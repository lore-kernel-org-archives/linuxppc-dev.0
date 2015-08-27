Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E60821A0541
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 14:13:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 827F82CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:37 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R4DLHl59965582
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R4D474010005
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 14:13:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/pseries: Fix corrupted pdn list
Date: Thu, 27 Aug 2015 14:12:36 +1000
Message-Id: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit cca87d30 ("powerpc/pci: Refactor pci_dn") introduced pdn
list for SRIOV VFs. It means the pdn is be put into the child list
of its parent pdn when the pdn is created. When doing PCI hot
unplugging on pSeries, the PCI device node as well as its pdn are
released through procfs entry "powerpc/ofdt". Some one else grabs
the memory chunk of the pdn and update it accordingly. At the same
time, the pdn is still tracked in the child list of parent pdn. It
leads to corrupted child list in the parent pdn.

This fixes above issue by removing the pdn from the child list of
its parent pdn when the device node is detached from the system.
Note the pdn is free'd when the device node is released if the
device node is dynamic one. Otherwise, the device node as well
as the pdn won't be released.

Fixes: cca87d30 ("powerpc/pci: Refactor pci_dn")
Reported-by: Santwana Samantray <santwana.samantray@in.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index df6a704..e6e8b24 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -268,6 +268,11 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 			eeh_dev_init(PCI_DN(np), pci->phb);
 		}
 		break;
+	case OF_RECONFIG_DETACH_NODE:
+		pci = PCI_DN(np);
+		if (pci)
+			list_del(&pci->list);
+		break;
 	default:
 		err = NOTIFY_DONE;
 		break;
-- 
2.1.0
