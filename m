Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 8E10C2BD6A
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 16:24:27 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id i8F6OaIq026965
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2004 09:24:37 +0300 (EEST)
Message-ID: <4147DEBD.4090206@intracom.gr>
Date: Wed, 15 Sep 2004 09:18:37 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <4146F3C3.2090100@intracom.gr>
	<20040914231551.GC9398@smtp.west.cox.net>
In-Reply-To: <20040914231551.GC9398@smtp.west.cox.net>
Content-Type: multipart/mixed; boundary="------------010908060103060301040506"
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Trivial warning fix patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010908060103060301040506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tom Rini wrote:
> On Tue, Sep 14, 2004 at 04:36:03PM +0300, Pantelis Antoniou wrote:
> 
> 
>>Hi
>>
>>The following patch removes some annoying warnings produced
>>by the latest gccs.
> 
> 
> Can you please read the Developer's Certificate of Origin 1.0 (found in
> Documentation/SubmittingPatches and add the approraite lines?  Thanks (I
> hate to be annoying about it, but..)
> 

Signed-off-by: Pantelis Antoniou <panto@intracom.gr>

Boy is this anal or what?

Regards

Pantelis




--------------010908060103060301040506
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

--------------010908060103060301040506--
