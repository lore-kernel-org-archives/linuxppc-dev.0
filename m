Return-Path: <jk@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 153D4B707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 16:38:40 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/mpic: fix WARN_ON from alloc_bootmem
Message-Id: <1246257419.938592.49700983608.1.gpush@pingu>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 29 Jun 2009 14:36:59 +0800
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current powerpc/merge on a QS21 reports an oops on boot:

------------[ cut here ]------------
Badness at mm/bootmem.c:535
 [snip]
Call Trace:
[c000000000763a80] [c0000000005dd068] .alloc_arch_preferred_bootmem+0x28/0x9c (unreliable)
[c000000000763b10] [c0000000005ddaac] .___alloc_bootmem_nopanic+0x5c/0x130
[c000000000763bc0] [c0000000005ddbd8] .___alloc_bootmem+0x28/0x68
[c000000000763c50] [c0000000005dddf0] .__alloc_bootmem+0x1c/0x30
[c000000000763cd0] [c0000000005d1080] .mpic_alloc+0x20c/0x9f8
[c000000000763dc0] [c0000000005d3348] .cell_init_irq+0x70/0x114
[c000000000763e60] [c0000000005c41f8] .init_IRQ+0x44/0x64
[c000000000763ee0] [c0000000005c0914] .start_kernel+0x238/0x440
[c000000000763f90] [c000000000007368] .start_here_common+0x1c/0x34

Looks like we're using alloc_bootmem after the slab is up and running,
in mpic_init.

This change uses a kzalloc instead - in fact, we've already done a
kzalloc() earlier in this function.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/sysdev/mpic.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d46de1f..a5980e6 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1109,9 +1109,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 			psize /= 4;
 			bits = intvec_top + 1;
 			mapsize = BITS_TO_LONGS(bits) * sizeof(unsigned long);
-			mpic->protected = alloc_bootmem(mapsize);
+			mpic->protected = kzalloc(mapsize, GFP_KERNEL);
 			BUG_ON(mpic->protected == NULL);
-			memset(mpic->protected, 0, mapsize);
 			for (i = 0; i < psize; i++) {
 				if (psrc[i] > intvec_top)
 					continue;
