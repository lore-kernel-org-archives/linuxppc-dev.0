Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSVcF5Z42zDwLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:16:45 +1100 (AEDT)
Subject: [PATCH v4 6/7] PCI: Decouple IORESOURCE_ROM_ENABLE and
 PCI_ROM_ADDRESS_ENABLE
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: clsoto@us.ibm.com, benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Mon, 28 Nov 2016 22:16:07 -0600
Message-ID: <20161129041607.21453.52485.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the assumption that IORESOURCE_ROM_ENABLE == PCI_ROM_ADDRESS_ENABLE.
PCI_ROM_ADDRESS_ENABLE is the ROM enable bit defined by the PCI spec, so if
we're reading or writing a BAR register value, that's what we should use.
IORESOURCE_ROM_ENABLE is a corresponding bit in struct resource flags.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab00267..cf7670e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -227,7 +227,8 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
 		}
 	} else {
-		res->flags |= (l & IORESOURCE_ROM_ENABLE);
+		if (l & PCI_ROM_ADDRESS_ENABLE)
+			res->flags |= IORESOURCE_ROM_ENABLE;
 		l64 = l & PCI_ROM_ADDRESS_MASK;
 		sz64 = sz & PCI_ROM_ADDRESS_MASK;
 		mask64 = (u32)PCI_ROM_ADDRESS_MASK;
