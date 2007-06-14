Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE8EDDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 23:40:37 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5EDeUs7014889
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 06:40:31 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l5EDeTQ4027622
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:40:29 -0500 (CDT)
Message-ID: <467145BC.1020800@freescale.com>
Date: Thu, 14 Jun 2007 21:42:20 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Chuck Meade <chuck@ThePTRGroup.com>
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
References: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
	<1181807671.30670.358.camel@gentoo-jocke.transmode.se>
	<4671321E.9000204@ThePTRGroup.com>
In-Reply-To: <4671321E.9000204@ThePTRGroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the patch to remove internal fragment when doing
aligned allocation.

The patch change to add the fragments back into the free list,
instead of allocate the whole trunk of space with internal
fragment.
---

 arch/powerpc/lib/rheap.c |   45 +++++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 180ee29..f8b3f1a 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -437,16 +437,12 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
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
 
@@ -456,8 +452,11 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
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
 
@@ -470,25 +469,35 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 		list_del(&blk->list);
 		newblk = blk;
 	} else {
+		/* Fragment caused, split if needed */
+		/* Create block for fragment in the beginning, insert to free list */
+		sp_size = start - blk->start;
+		if (sp_size) {
+			rh_block_t *spblk;
+
+			spblk = get_slot(info);
+			spblk->start = blk->start;
+			spblk->size = sp_size;
+			list_add(&spblk->list, &blk->list);
+		}
 		newblk = get_slot(info);
-		newblk->start = blk->start;
+		newblk->start = start;
 		newblk->size = size;
 
-		/* blk still in free list, with updated start, size */
-		blk->start += size;
-		blk->size -= size;
+		/* blk still in free list, with updated start, size
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
