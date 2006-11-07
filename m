Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:58 +1100
Subject: [PATCH 24/31] powerpc: spider uses low level BE MMIO accessors
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072415.3446D68337@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We use the powerpc specific low level MMIO accessor variants instead
of readl() or readl_be() because we know spidernet is not a real PCI
device and we can thus avoid the performance hit caused by the PCI
workarounds.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/net/spider_net.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: linux-cell/drivers/net/spider_net.c
===================================================================
--- linux-cell.orig/drivers/net/spider_net.c	2006-11-07 15:10:08.000000000 +1100
+++ linux-cell/drivers/net/spider_net.c	2006-11-07 15:11:26.000000000 +1100
@@ -88,12 +88,11 @@ MODULE_DEVICE_TABLE(pci, spider_net_pci_
 static inline u32
 spider_net_read_reg(struct spider_net_card *card, u32 reg)
 {
-	u32 value;
-
-	value = readl(card->regs + reg);
-	value = le32_to_cpu(value);
-
-	return value;
+	/* We use the powerpc specific variants instead of readl_be() because
+	 * we know spidernet is not a real PCI device and we can thus avoid the
+	 * performance hit caused by the PCI workarounds.
+	 */
+	return in_be32(card->regs + reg);
 }
 
 /**
@@ -105,8 +104,11 @@ spider_net_read_reg(struct spider_net_ca
 static inline void
 spider_net_write_reg(struct spider_net_card *card, u32 reg, u32 value)
 {
-	value = cpu_to_le32(value);
-	writel(value, card->regs + reg);
+	/* We use the powerpc specific variants instead of writel_be() because
+	 * we know spidernet is not a real PCI device and we can thus avoid the
+	 * performance hit caused by the PCI workarounds.
+	 */
+	out_be32(card->regs + reg, value);
 }
 
 /** spider_net_write_phy - write to phy register
