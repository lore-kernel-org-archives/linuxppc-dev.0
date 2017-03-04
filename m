Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbNFT28lrzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 10:54:37 +1100 (AEDT)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
Date: Sun,  5 Mar 2017 10:54:34 +1100
Message-Id: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

I see a panic in early boot when building with a recent gcc toolchain.
The issue is a divide by zero, which is undefined. Older toolchains
let us get away with it:

int foo(int a) { return a / 0; }

foo:
	li 9,0
	divw 3,3,9
	extsw 3,3
	blr

But newer ones catch it:

foo:
	trap

Add a check to avoid the divide by zero.

Fixes: bd067f83b084 ("powerpc/64: Fix naming of cache block vs. cache line")
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/setup_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index adf2084..afd1c26 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -408,7 +408,8 @@ static void init_cache_info(struct ppc_cache_info *info, u32 size, u32 lsize,
 	info->line_size = lsize;
 	info->block_size = bsize;
 	info->log_block_size = __ilog2(bsize);
-	info->blocks_per_page = PAGE_SIZE / bsize;
+	if (bsize)
+		info->blocks_per_page = PAGE_SIZE / bsize;
 
 	if (sets == 0)
 		info->assoc = 0xffff;
-- 
2.7.4
