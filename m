Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5DCC1A2BF7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 05:14:53 +1000 (AEST)
Received: by lbcjc2 with SMTP id jc2so58063670lbc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Sep 2015 12:14:50 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] powerpc: msi: mark bitmap with kmemleak_not_leak()
Date: Sun, 13 Sep 2015 21:36:37 +0300
Message-Id: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the MSI bitmap test on boot kmemleak spews the following trace:

unreferenced object 0xc00000016e86c900 (size 64):
    comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
    hex dump (first 32 bytes):
	00 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
	.......7........
	ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
	................
	backtrace:
	[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
	[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
	[<c000000000a9aff8>]
	.msi_bitmap_selftest+0x30/0x2b4
	[<c0000000000090f4>]
	.do_one_initcall+0xd4/0x270
	[<c000000000a8e250>]
	.kernel_init_freeable+0x1a0/0x280
	[<c000000000009b5c>]
	.kernel_init+0x1c/0x120
	[<c000000000007fbc>]
	.ret_from_kernel_thread+0x58/0x9c

The comment in msi_bitmap_free() states that we can't free
the bitmap so mark it with the kmemleak_not_leak().

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/sysdev/msi_bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 73b64c7..bd9fa54 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -139,6 +139,7 @@ int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 void msi_bitmap_free(struct msi_bitmap *bmp)
 {
 	/* we can't free the bitmap we don't know if it's bootmem etc. */
+	kmemleak_not_leak(bmp->bitmap);
 	of_node_put(bmp->of_node);
 	bmp->bitmap = NULL;
 }
-- 
2.4.0
