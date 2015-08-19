Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB65E1A1930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 04:54:18 +1000 (AEST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 15:54:14 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E0D593520082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:53:05 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7JIqfvN47448318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:52:41 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7JIsAIp005463
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:54:11 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, mpe@ellerman.id.au, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 bhelgaas@google.com, mst@redhat.com
Subject: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe
 time in OF case
Date: Wed, 19 Aug 2015 15:54:10 -0300
Message-Id: <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>,
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>,
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes since v2:
 * Added "Fixes" line
 * Improved commit reference by using 12 first chars of SHA

>8----------8<

Since the commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
if kernel doesn't support MSI"), MSI/MSI-X interrupts aren't being
disabled at PCI probe time, as the logic responsible for this was moved
in the aforementioned commit from pci_device_add() to pci_setup_device().
The latter function is not reachable on PowerPC pSeries platform during
Open Firmware PCI probing time.

This patch calls pci_msi_setup_pci_dev() explicitly to disable MSI/MSI-X
during PCI probe time on pSeries platform.

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel
doesn't support MSI")

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 42e02a2..0e920f3 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -191,6 +191,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	pci_device_add(dev, bus);
 
+	/* Disable MSI/MSI-X here to avoid bogus interrupts */
+	pci_msi_setup_pci_dev(dev);
+
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
-- 
2.1.0
