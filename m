Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7E1C1A025F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 09:15:14 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 1 May 2015 09:15:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D8BB82CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 09:15:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3UNF18O6357026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 09:15:10 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3UNEamK024662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 09:14:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Fix race condition in
 pcibios_set_pcie_reset_state()
Date: Fri,  1 May 2015 09:14:11 +1000
Message-Id: <1430435651-13628-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When asserting reset in pcibios_set_pcie_reset_state(), the PE
is enforced to (hardware) frozen state in order to drop unexpected
PCI transactions (except PCI config read/write) automatically by
hardware during reset, which would cause recursive EEH error.
However, the (software) frozen state EEH_PE_ISOLATED is missed.
When users get 0xFF from PCI config or MMIO read, EEH_PE_ISOLATED
is set in PE state retrival backend. Unfortunately, nobody (the
reset handler or the EEH recovery functinality in host) will clear
EEH_PE_ISOLATED when the PE has been passed through to guest.

The patch sets and clears EEH_PE_ISOLATED properly during reset
in function pcibios_set_pcie_reset_state() to fix the issue.

Fixes: 28158cd ("Enhance pcibios_set_pcie_reset_state()")
Reported-by: Carol L. Soto <clsoto@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol L. Soto <clsoto@us.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 65f38d2..b798c86 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -749,21 +749,24 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_unfreeze_pe(pe, false);
 		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
 	case pcie_hot_reset:
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
+		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
 		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED | EEH_PE_CFG_BLOCKED);
 		return -EINVAL;
 	};
 
-- 
2.1.0
