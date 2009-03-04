Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA91FDDF7F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 12:22:33 +1100 (EST)
Date: Tue, 3 Mar 2009 20:22:29 -0500
From: Kyle McMartin <kyle@infradead.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: detect sbc610 boards and only fixup nec usb on them
Message-ID: <20090304012229.GN28503@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kyle McMartin <kyle@redhat.com>

Bug #486511 in Fedora, this is getting applied to any machine with a NEC
USB pci device if this CONFIG_GEF_SBC610 is on (as it was in Fedora.)
Obviously this isn't appropriate to do in any more than the SBC610
case..., so flag that we're a sbc610 board, and skip the fixup if we're
not.

(Fedora: Should fix USB on Mac G4/G5...)

Signed-off-by: Kyle McMartin <kyle@redhat.com>

---
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index fb371f5..54afda2 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -51,6 +51,8 @@
 
 void __iomem *sbc610_regs;
 
+static int is_sbc610;
+
 static void __init gef_sbc610_init_irq(void)
 {
 	struct device_node *cascade_node = NULL;
@@ -142,6 +144,9 @@ static void __init gef_sbc610_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
+	if (!is_sbc610)
+		return;
+
 	printk(KERN_INFO "Running NEC uPD720101 Fixup\n");
 
 	/* Ensure ports 1, 2, 3, 4 & 5 are enabled */
@@ -166,8 +171,10 @@ static int __init gef_sbc610_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "gef,sbc610"))
+	if (of_flat_dt_is_compatible(root, "gef,sbc610")) {
+		is_sbc610 = 1;
 		return 1;
+	}
 
 	return 0;
 }
