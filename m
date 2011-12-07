Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E39DD10098F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 07:32:43 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND] rapidio/tsi721: modify PCIe capability settings
Date: Wed,  7 Dec 2011 15:31:15 -0500
Message-Id: <1323289875-25559-2-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1323289875-25559-1-git-send-email-alexandre.bounine@idt.com>
References: <1323289875-25559-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify initialization of PCIe capability registers in Tsi721 mport driver:
- change Completion Timeout value to avoid unexpected data transfer aborts
  during intensive traffic.
- replace hardcoded offset of PCIe capability block by getting it using
  the common function.

This patch is applicable to kernel versions starting from 3.2-rc1.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
---

[Resending this patch with updated commit comment]

 drivers/rapidio/devices/tsi721.c |   20 +++++++++++++++-----
 drivers/rapidio/devices/tsi721.h |    2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 83ac8728..691b1ab 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2154,7 +2154,7 @@ static int __devinit tsi721_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	struct tsi721_device *priv;
-	int i;
+	int i, cap;
 	int err;
 	u32 regval;
 
@@ -2262,10 +2262,20 @@ static int __devinit tsi721_probe(struct pci_dev *pdev,
 			dev_info(&pdev->dev, "Unable to set consistent DMA mask\n");
 	}
 
-	/* Clear "no snoop" and "relaxed ordering" bits. */
-	pci_read_config_dword(pdev, 0x40 + PCI_EXP_DEVCTL, &regval);
-	regval &= ~(PCI_EXP_DEVCTL_RELAX_EN | PCI_EXP_DEVCTL_NOSNOOP_EN);
-	pci_write_config_dword(pdev, 0x40 + PCI_EXP_DEVCTL, regval);
+	cap = pci_pcie_cap(pdev);
+	BUG_ON(cap == 0);
+
+	/* Clear "no snoop" and "relaxed ordering" bits, use default MRRS. */
+	pci_read_config_dword(pdev, cap + PCI_EXP_DEVCTL, &regval);
+	regval &= ~(PCI_EXP_DEVCTL_READRQ | PCI_EXP_DEVCTL_RELAX_EN |
+		    PCI_EXP_DEVCTL_NOSNOOP_EN);
+	regval |= 0x2 << MAX_READ_REQUEST_SZ_SHIFT;
+	pci_write_config_dword(pdev, cap + PCI_EXP_DEVCTL, regval);
+
+	/* Adjust PCIe completion timeout. */
+	pci_read_config_dword(pdev, cap + PCI_EXP_DEVCTL2, &regval);
+	regval &= ~(0x0f);
+	pci_write_config_dword(pdev, cap + PCI_EXP_DEVCTL2, regval | 0x2);
 
 	/*
 	 * FIXUP: correct offsets of MSI-X tables in the MSI-X Capability Block
diff --git a/drivers/rapidio/devices/tsi721.h b/drivers/rapidio/devices/tsi721.h
index 58be4de..822e54c 100644
--- a/drivers/rapidio/devices/tsi721.h
+++ b/drivers/rapidio/devices/tsi721.h
@@ -72,6 +72,8 @@
 #define TSI721_MSIXPBA_OFFSET	0x2a000
 #define TSI721_PCIECFG_EPCTL	0x400
 
+#define MAX_READ_REQUEST_SZ_SHIFT	12
+
 /*
  * Event Management Registers
  */
-- 
1.7.6
