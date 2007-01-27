Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id BB4E0DE1B1
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 10:41:53 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix array indexing error in rheap grow()
Date: Sat, 27 Jan 2007 17:41:49 -0600
Message-Id: <1169941309366-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>, Ionut Nicu <ionut.nicu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The grow() function in the rheap library allocates a larger array of blocks, 
copies the contents of the old blocks array to the newly allocated array and
fixes the list_head pointers after the copy.  At the end, the new blocks must 
be enqueued to the empty_list of the rh_info_t structure.  This patch fixes
a bug where the code was indexing past the end of the array when enqueueing 
blocks.  The UCC ethernet driver, which uses the rheap allocator, experiences
kernel panics because of this bug.

Signed-off-by: Ionut Nicu <ionut.nicu@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/lib/rheap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 57bf991..4bbda6b 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -85,7 +85,8 @@ static int grow(rh_info_t * info, int ma
 	info->flags &= ~RHIF_STATIC_BLOCK;
 
 	/* add all new blocks to the free list */
-	for (i = 0, blk = block + info->max_blocks; i < new_blocks; i++, blk++)
+	blk = block + info->max_blocks - new_blocks;
+	for (i = 0; i < new_blocks; i++, blk++)
 		list_add(&blk->list, &info->empty_list);
 
 	return 0;
-- 
1.4.4
