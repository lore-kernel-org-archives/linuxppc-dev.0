Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFFD6DDF55
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:32:35 +1000 (EST)
Message-ID: <480FB8FA.3060805@tiscali.nl>
Date: Thu, 24 Apr 2008 00:32:26 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2 v2] powerpc: mpic_pasemi_msi: failed allocation unnoticed
References: <480F6905.3070808@tiscali.nl>
In-Reply-To: <480F6905.3070808@tiscali.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

also please add my signoff to 
[PATCH 2/2 v2] mpic_u3msi: mpic_u3msi: failed allocation unnoticed
---
bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may return
signed, but hwirq is unsigned. A failed allocation remains unnoticed.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 33cbfb2..68aff60 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -95,6 +95,7 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
+	int ret;
 
 	pr_debug("pasemi_msi_setup_msi_irqs, pdev %p nvec %d type %d\n",
 		 pdev, nvec, type);
@@ -108,8 +109,9 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		 * few MSIs for someone, but restrictions will apply to how the
 		 * sources can be changed independently.
 		 */
-		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, ALLOC_CHUNK);
-		if (hwirq < 0) {
+		ret = mpic_msi_alloc_hwirqs(msi_mpic, ALLOC_CHUNK);
+		hwirq = ret;
+		if (ret < 0) {
 			pr_debug("pasemi_msi: failed allocating hwirq\n");
 			return hwirq;
 		}
