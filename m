Return-Path: <b04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A26CDDE27
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 02:31:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4EGVUIa015294
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 09:31:30 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix alignment problem in rh_alloc_align() with
	exact-sized blocks
Date: Mon, 14 May 2007 11:31:26 -0500
Message-Id: <1179160286213-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When an rheap is created, the caller can specify the alignment to use.  In
rh_alloc_align(), if a free block is found that is the exact size needed
(including extra space for alignment), that configured alignment value is not
used to align the pointer.  Instead, the default alignment is used.  If the
default alignment is smaller than the configured alignment, then the returned
value will not be aligned correctly.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/lib/rheap.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index b2f6dcc..180ee29 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -468,25 +468,19 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 	if (blk->size == size) {
 		/* Move from free list to taken list */
 		list_del(&blk->list);
-		blk->owner = owner;
-		start = blk->start;
-
-		attach_taken_block(info, blk);
+		newblk = blk;
+	} else {
+		newblk = get_slot(info);
+		newblk->start = blk->start;
+		newblk->size = size;
 
-		return start;
+		/* blk still in free list, with updated start, size */
+		blk->start += size;
+		blk->size -= size;
 	}
 
-	newblk = get_slot(info);
-	newblk->start = blk->start;
-	newblk->size = size;
 	newblk->owner = owner;
-
-	/* blk still in free list, with updated start, size */
-	blk->start += size;
-	blk->size -= size;
-
 	start = newblk->start;
-
 	attach_taken_block(info, newblk);
 
 	/* for larger alignment return fixed up pointer  */
-- 
1.5.0.2.260.g2eb065
