Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CBC62DDEFF
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 21:27:50 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5IBRUJH003677
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 04:27:31 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5IBRTsY020266
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 06:27:30 -0500 (CDT)
Message-ID: <46766C91.6090903@freescale.com>
Date: Mon, 18 Jun 2007 19:29:21 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] rheap: eliminates internal fragments caused by alignment
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch adds fragments caused by rh_alloc_align() back to free list, instead
of allocating the whole chunk of memory.  This will greatly improve memory
utilization managed by rheap.

It solves MURAM not enough problem with 3 UCCs enabled on MPC8323.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/lib/rheap.c |   48 +++++++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 180ee29..2f24ea0 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -437,27 +437,26 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 	struct list_head *l;
 	rh_block_t *blk;
 	rh_block_t *newblk;
-	unsigned long start;
+	unsigned long start, sp_size;
 
 	/* Validate size, and alignment must be power of two */
 	if (size <= 0 || (alignment & (alignment - 1)) != 0)
 		return (unsigned long) -EINVAL;
 
-	/* given alignment larger that default rheap alignment */
-	if (alignment > info->alignment)
-		size += alignment - 1;
-
 	/* Align to configured alignment */
 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
 
-	if (assure_empty(info, 1) < 0)
+	if (assure_empty(info, 2) < 0)
 		return (unsigned long) -ENOMEM;
 
 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
-		if (size <= blk->size)
-			break;
+		if (size <= blk->size) {
+			start = (blk->start + alignment - 1) & ~(alignment - 1);
+			if (start + size <= blk->start + blk->size)
+				break;
+		}
 		blk = NULL;
 	}
 
@@ -470,25 +469,36 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 		list_del(&blk->list);
 		newblk = blk;
 	} else {
+		/* Fragment caused, split if needed */
+		/* Create block for fragment in the beginning */
+		sp_size = start - blk->start;
+		if (sp_size) {
+			rh_block_t *spblk;
+
+			spblk = get_slot(info);
+			spblk->start = blk->start;
+			spblk->size = sp_size;
+			/* add before the blk */
+			list_add(&spblk->list, blk->list.prev);
+		}
 		newblk = get_slot(info);
-		newblk->start = blk->start;
+		newblk->start = start;
 		newblk->size = size;
 
-		/* blk still in free list, with updated start, size */
-		blk->start += size;
-		blk->size -= size;
+		/* blk still in free list, with updated start and size
+		 * for fragment in the end */
+		blk->start = start + size;
+		blk->size -= sp_size + size;
+		/* No fragment in the end, remove blk */
+		if (blk->size == 0) {
+			list_del(&blk->list);
+			release_slot(info, blk);
+		}
 	}
 
 	newblk->owner = owner;
-	start = newblk->start;
 	attach_taken_block(info, newblk);
 
-	/* for larger alignment return fixed up pointer  */
-	/* this is no problem with the deallocator since */
-	/* we scan for pointers that lie in the blocks   */
-	if (alignment > info->alignment)
-		start = (start + alignment - 1) & ~(alignment - 1);
-
 	return start;
 }
