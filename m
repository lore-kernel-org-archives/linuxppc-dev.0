Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A5D51A04F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 07:14:01 +1000 (AEST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 18 Aug 2015 18:13:56 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 7D2E31DC0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 17:12:50 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7ILEFl85152912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 18:14:16 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7ILDoGu005701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 18:13:51 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 0/2] Disable MSI/MSI-X interrupts manually at PCI probe time
 in PowerPC architecture
Date: Tue, 18 Aug 2015 18:13:48 -0300
Message-Id: <1439932430-13375-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These 2 patches correct a bogus behaviour introduced by commit 1851617cd2
("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI").
The commit moved the logic responsible to disable MSI/MSI-X interrupts
at PCI probe time to a new function, named pci_msi_setup_pci_dev(), that
is not reachable in the code path of PowerPC pSeries platform.

Since then, devices aren't able to activate MSI/MSI-X capability, even
after boot. The first patch makes the function pci_msi_setup_pci_dev()
non-static. The second patch inserts a call to the function in powerpc
code, so it explicitly disables MSI/MSI-X interrupts at PCI probe time.

Guilherme G. Piccoli (2):
  PCI: Make pci_msi_setup_pci_dev() non-static for use by arch code
  powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case

 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 drivers/pci/probe.c               | 2 +-
 include/linux/pci.h               | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.1.0
