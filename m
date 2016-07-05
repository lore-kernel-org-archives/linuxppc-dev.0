Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk9VN5pZ1zDqqS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 14:13:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pci: Fix build with PCI_IOV=y and EEH=n
Date: Tue,  5 Jul 2016 14:13:30 +1000
Message-Id: <1467692010-12512-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Despite attempting to fix this in commit fb36e9073693 ("powerpc/pci: Fix
SRIOV not building without EEH enabled"), the build is still broken when
PCI_IOV=y and EEH=n (eg. g5_defconfig with PCI_IOV=y):

  arch/powerpc/kernel/pci_dn.c: In function ‘remove_dev_pci_data’:
  arch/powerpc/kernel/pci_dn.c:230:18: error: unused variable ‘edev’

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci_dn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index bfe60a1e70d9..e056c9e7b474 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -227,7 +227,9 @@ void remove_dev_pci_data(struct pci_dev *pdev)
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent;
 	struct pci_dn *pdn, *tmp;
+#ifdef CONFIG_EEH
 	struct eeh_dev *edev;
+#endif
 	int i;
 
 	/*
-- 
2.7.4
