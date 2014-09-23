Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F16001A098C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:06 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 11:09:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0DD632BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N1AVAX36307158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:10:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N193vn032655
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 11:09:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/eeh: Tag reset state for user owned PE
Date: Tue, 23 Sep 2014 11:09:03 +1000
Message-Id: <1411434544-10025-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1411434544-10025-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1411434544-10025-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PE would be owned by userland, which probably request PE reset
done in host side. During the reset, we should drop the PCI
config accesses to the PE with help of flag EEH_PE_RESET.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 545860f..059aa00 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1463,6 +1463,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 	switch (option) {
 	case EEH_RESET_DEACTIVATE:
 		ret = eeh_ops->reset(pe, option);
+		eeh_pe_state_clear(pe, EEH_PE_RESET);
 		if (ret)
 			break;
 
@@ -1477,6 +1478,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option)
 		 */
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 
+		eeh_pe_state_mark(pe, EEH_PE_RESET);
 		ret = eeh_ops->reset(pe, option);
 		break;
 	default:
-- 
1.8.3.2
