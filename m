Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92465DE544
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 07:12:33 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	avorontsov@ru.mvista.com, benh@kernel.crashing.org, tony@bakeyournoodle.com
Subject: [PATCH] powerpc: fix memory leaks in QE library
Date: Mon, 18 Aug 2008 16:12:08 -0500
Message-Id: <1219093928-5349-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix two memory leaks in the Freescale QE library: add a missing kfree() in
ucc_fast_init() if the ioremap() fails, and update ucc_fast_free() to call
iounmap() on uf_regs.

Based on a patch from Tony Breeds <tony@bakeyournoodle.com>.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 1aecb07..25fbbfa 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -208,6 +208,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	uccf->uf_regs = ioremap(uf_info->regs, sizeof(struct ucc_fast));
 	if (uccf->uf_regs == NULL) {
 		printk(KERN_ERR "%s: Cannot map UCC registers\n", __func__);
+		kfree(uccf);
 		return -ENOMEM;
 	}
 
@@ -355,6 +356,9 @@ void ucc_fast_free(struct ucc_fast_private * uccf)
 	if (uccf->ucc_fast_rx_virtual_fifo_base_offset)
 		qe_muram_free(uccf->ucc_fast_rx_virtual_fifo_base_offset);
 
+	if (uccf->uf_regs)
+		iounmap(uccf->uf_regs);
+
 	kfree(uccf);
 }
 EXPORT_SYMBOL(ucc_fast_free);
-- 
1.5.5
