Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DE4DDDF49
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 09:03:09 +1000 (EST)
Message-ID: <480FC026.9060009@tiscali.nl>
Date: Thu, 24 Apr 2008 01:03:02 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2 v2] mpic_u3msi: mpic_u3msi: failed allocation unnoticed
References: <480F6905.3070808@tiscali.nl> <480F8754.7000200@tiscali.nl>
	<df21920e067e73985f73047e2d8bcbda@kernel.crashing.org>
	<480FB766.1040405@tiscali.nl>
In-Reply-To: <480FB766.1040405@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Again thanks to Segher and Joe Perches
---
bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may return
signed, but hwirq is unsigned. A failed allocation remains unnoticed.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
index 1d5a408..6e2f868 100644
--- a/arch/powerpc/sysdev/mpic_u3msi.c
+++ b/arch/powerpc/sysdev/mpic_u3msi.c
@@ -115,17 +115,19 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct msi_desc *entry;
 	struct msi_msg msg;
 	u64 addr;
+	int ret;
 
 	addr = find_ht_magic_addr(pdev);
 	msg.address_lo = addr & 0xFFFFFFFF;
 	msg.address_hi = addr >> 32;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
-		if (hwirq < 0) {
+		ret = mpic_msi_alloc_hwirqs(msi_mpic, 1);
+		if (ret < 0) {
 			pr_debug("u3msi: failed allocating hwirq\n");
-			return hwirq;
+			return ret;
 		}
+		hwirq = ret;
 
 		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
 		if (virq == NO_IRQ) {
