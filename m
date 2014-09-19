Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7BAA41A0B89
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:49:25 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Sep 2014 15:49:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AD2003578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:49:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8J5oaM923330916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:50:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8J5mnmV017976
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:48:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc/eeh: Block PCI config access during reset
Date: Fri, 19 Sep 2014 15:48:22 +1000
Message-Id: <1411105703-30149-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1411105703-30149-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1411105703-30149-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
