Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZGrM4FHtzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:47:31 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
Date: Fri,  3 Mar 2017 15:47:18 +1100
Message-Id: <20170303044718.19253-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh_handle_special_event() is called when an EEH event is detected but
can't be narrowed down to a specific PE.  This function looks through
every PE to find one in an erroneous state, then calls the regular event
handler eeh_handle_normal_event() once it knows which PE has an error.

However, if eeh_handle_normal_event() found that the PE cannot possibly
be recovered, it will remove the PE and associated devices.  This leads
to a use after free in eeh_handle_special_event() as it attempts to clear
the "recovering" state on the PE after eeh_handle_normal_event() returns.

Thus, make sure the PE is valid when attempting to clear state in
eeh_handle_special_event().

Cc: <stable@vger.kernel.org> #3.10+
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_driver.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index b94887165a10..492397298a2a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -983,6 +983,19 @@ static void eeh_handle_special_event(void)
 		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
 		    rc == EEH_NEXT_ERR_FENCED_PHB) {
 			eeh_handle_normal_event(pe);
+
+			/*
+			 * eeh_handle_normal_event() can free the PE if it
+			 * determines that the PE cannot possibly be recovered.
+			 * Make sure the PE still exists before changing its
+			 * state.
+			 */
+			if (!pe || (pe->type & EEH_PE_INVALID)
+			    || (pe->state & EEH_PE_REMOVED)) {
+				pr_warn("EEH: not clearing state on bad PE\n");
+				continue;
+			}
+
 			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
 		} else {
 			pci_lock_rescan_remove();
-- 
2.12.0
