Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 2659B2BD3C
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 23:41:48 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8EDfrb2016085
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 16:41:54 +0300 (EEST)
Message-ID: <4146F3C3.2090100@intracom.gr>
Date: Tue, 14 Sep 2004 16:36:03 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
	Tom Rini <trini@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------070007040909080700070802"
Cc: 
Subject: [PATCH] Trivial warning fix patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070007040909080700070802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

The following patch removes some annoying warnings produced
by the latest gccs.

Regards

Pantelis

--------------070007040909080700070802
Content-Type: text/x-patch;
 name="rheap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rheap.patch"

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linuxppc_2.5/arch/ppc/lib/rheap.c linuxppc_2.5-intracom/arch/ppc/lib/rheap.c
--- linuxppc_2.5/arch/ppc/lib/rheap.c	2004-07-16 10:03:07 +03:00
+++ linuxppc_2.5-intracom/arch/ppc/lib/rheap.c	2004-09-14 12:58:48 +03:00
@@ -216,7 +216,7 @@
 
 	/* Grow the after block backwards */
 	if (before == NULL && after != NULL) {
-		(int8_t *) after->start -= size;
+		after->start = (int8_t *)after->start - size;
 		after->size += size;
 		return;
 	}
@@ -407,7 +407,7 @@
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			(int8_t *) blk->start += size;
+			blk->start = (int8_t *)blk->start + size;
 		blk->size -= size;
 
 	} else {
@@ -471,7 +471,7 @@
 	newblk->owner = owner;
 
 	/* blk still in free list, with updated start, size */
-	(int8_t *) blk->start += size;
+	blk->start = (int8_t *)blk->start + size;
 	blk->size -= size;
 
 	start = newblk->start;
@@ -535,7 +535,7 @@
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			(int8_t *) blk->start += size;
+			blk->start = (int8_t *)blk->start + size;
 		blk->size -= size;
 
 	} else {

--------------070007040909080700070802--
