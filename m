Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCDE6DE45D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:43:45 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Make rheap safe for spinlocks
Date: Mon, 14 Apr 2008 10:43:38 -0500
Message-Id: <12081878182664-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The rheap allocation function, rh_alloc, could call kmalloc with GFP_KERNEL.
This can sleep, which means you couldn't hold a spinlock while called rh_alloc.
Change all kmalloc calls to use GFP_ATOMIC so that it won't sleep.  This is
safe because only small blocks are allocated.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.26.

 arch/powerpc/lib/rheap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 22c3b4f..29b2941 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -54,7 +54,7 @@ static int grow(rh_info_t * info, int max_blocks)
 
 	new_blocks = max_blocks - info->max_blocks;
 
-	block = kmalloc(sizeof(rh_block_t) * max_blocks, GFP_KERNEL);
+	block = kmalloc(sizeof(rh_block_t) * max_blocks, GFP_ATOMIC);
 	if (block == NULL)
 		return -ENOMEM;
 
@@ -258,7 +258,7 @@ rh_info_t *rh_create(unsigned int alignment)
 	if ((alignment & (alignment - 1)) != 0)
 		return ERR_PTR(-EINVAL);
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kmalloc(sizeof(*info), GFP_ATOMIC);
 	if (info == NULL)
 		return ERR_PTR(-ENOMEM);
 
-- 
1.5.3
