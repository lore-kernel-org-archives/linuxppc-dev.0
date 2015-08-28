Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FAB71A0541
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:58:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 28 Aug 2015 11:58:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D18142BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:58:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7S1w6Oh63438988
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:58:14 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7S1vgxT005308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:57:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH] powerpc/eeh: Fix fenced PHB caused by eeh_slot_error_detail()
Date: Fri, 28 Aug 2015 11:57:00 +1000
Message-Id: <1440727035-4314-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The config space of some PCI devices can't be accessed when their
PEs are in frozen state. Otherwise, fenced PHB might be seen.
Those PEs are identified with flag EEH_PE_CFG_RESTRICTED, meaing
EEH_PE_CFG_BLOCKED is set automatically when the PE is put to
frozen state (EEH_PE_ISOLATED). eeh_slot_error_detail() restores
PCI device BARs with eeh_pe_restore_bars(), which then calls
eeh_ops->restore_config() to reinitialize the PCI device in
(OPAL) firmware. eeh_ops->restore_config() produces PCI config
access that causes fenced PHB. The problem was reported on below
adapter:

   0001:01:00.0 0200: 14e4:168e (rev 10)
   0001:01:00.0 Ethernet controller: Broadcom Corporation \
                NetXtreme II BCM57810 10 Gigabit Ethernet (rev 10)

This fixes the issue by skipping eeh_pe_restore_bars() in
eeh_slot_error_detail() when EEH_PE_CFG_BLOCKED is set for the PE.

Fixes: b6541db1 ("powerpc/eeh: Block PCI config access upon frozen PE")
Cc: stable@vger.kernel.org # v4.0+
Reported-by: Manvanthara B. Puttashankar <mputtash@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index af9b597..c7c6e5d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -308,11 +308,26 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	if (!(pe->type & EEH_PE_PHB)) {
 		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG))
 			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+
+		/*
+		 * The config space of some PCI devices can't be accessed
+		 * when their PEs are in frozen state. Otherwise, fenced
+		 * PHB might be seen. Those PEs are identified with flag
+		 * EEH_PE_CFG_RESTRICTED, indicating EEH_PE_CFG_BLOCKED
+		 * is set automatically when the PE is put to EEH_PE_ISOLATED.
+		 *
+		 * Restoring BARs possibly triggers PCI config access in
+		 * (OPAL) firmware and then causes fenced PHB. If the
+		 * PCI config is blocked with flag EEH_PE_CFG_BLOCKED, it's
+		 * pointless to restore BARs and dump config space.
+		 */
 		eeh_ops->configure_bridge(pe);
-		eeh_pe_restore_bars(pe);
+		if (!(pe->state & EEH_PE_CFG_BLOCKED)) {
+			eeh_pe_restore_bars(pe);
 
-		pci_regs_buf[0] = 0;
-		eeh_pe_traverse(pe, eeh_dump_pe_log, &loglen);
+			pci_regs_buf[0] = 0;
+			eeh_pe_traverse(pe, eeh_dump_pe_log, &loglen);
+		}
 	}
 
 	eeh_ops->get_log(pe, severity, pci_regs_buf, loglen);
-- 
2.1.0
