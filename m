Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 603111A097D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:19 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:18 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3AFC62CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2f1Ut34930814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dE9A029501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/21] powerpc/eeh: Block PCI config access during reset
Date: Tue, 30 Sep 2014 12:39:03 +1000
Message-Id: <1412044750-24460-14-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Function pcibios_set_pcie_reset_state() can be used to do PCI
reset. PCI config access during the reset usually causes EEH
errors unexpectedly. In order to avoid the EEH error, the patch
blocks PCI config access during reset with the help of flag
EEH_PE_RESET, which is similar to what we did in EEH PE reset
path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 7004673..545860f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -668,14 +668,18 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	switch (state) {
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
+		eeh_pe_state_clear(pe, EEH_PE_RESET);
 		break;
 	case pcie_hot_reset:
+		eeh_pe_state_mark(pe, EEH_PE_RESET);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
+		eeh_pe_state_mark(pe, EEH_PE_RESET);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
+		eeh_pe_state_clear(pe, EEH_PE_RESET);
 		return -EINVAL;
 	};
 
-- 
1.8.3.2
