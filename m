Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F8D3DDFD9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 02:51:26 +1000 (EST)
Message-ID: <480F6905.3070808@tiscali.nl>
Date: Wed, 23 Apr 2008 18:51:17 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: mpic_pasemi_msi: failed allocation unnoticed
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

bitmap_find_free_region(), called by mpic_msi_alloc_hwirqs() may
return -ENOMEM, but hwirq of type irq_hw_number_t which is unsigned.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
The functions can be found respectively in:
//---[ vi lib/bitmap.c +807 ]---
//---[ vi arch/powerpc/sysdev/mpic_msi.c +39 ]---

diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
index 33cbfb2..a15ac5c 100644
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -109,7 +109,7 @@ static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		 * sources can be changed independently.
 		 */
 		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, ALLOC_CHUNK);
-		if (hwirq < 0) {
+		if (hwirq == -ENOMEM) {
 			pr_debug("pasemi_msi: failed allocating hwirq\n");
 			return hwirq;
 		}
