Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C5512C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 03:35:04 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 22:05:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 780FA394005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 22:04:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0TGYspZ38469838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 22:04:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0TGYwmd012287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 22:04:59 +0530
Message-ID: <52E92DB0.1050902@linux.vnet.ibm.com>
Date: Wed, 29 Jan 2014 10:34:56 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Handle vmalloc addresses
Content-Type: text/plain; charset=ISO-8859-1
Cc: Rong Song Shen <shenrs@cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nx-842 compression driver does not currently handle getting
a physical address for vmalloc addresses. The current driver
uses __pa() for all addresses which does not properly handle
vmalloc addresses and thus causes a failure since we do not pass
a proper physical address to phyp.

This patch adds a routine to convert an address to a physical
address by checking for vmalloc addresses and handling them properly.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
 ---
 drivers/crypto/nx/nx-842.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

Index: linux/drivers/crypto/nx/nx-842.c
===================================================================
--- linux.orig/drivers/crypto/nx/nx-842.c	2014-01-22 08:52:55.000000000 -0600
+++ linux/drivers/crypto/nx/nx-842.c	2014-01-29 08:25:33.000000000 -0600
@@ -158,6 +158,15 @@
 	return sl->entry_nr * sizeof(struct nx842_slentry);
 }
 
+static inline unsigned long nx842_get_pa(void *addr)
+{
+	if (is_vmalloc_addr(addr))
+		return page_to_phys(vmalloc_to_page(addr))
+		       + offset_in_page(addr);
+	else
+		return __pa(addr);
+}
+
 static int nx842_build_scatterlist(unsigned long buf, int len,
 			struct nx842_scatterlist *sl)
 {
@@ -168,7 +177,7 @@
 
 	entry = sl->entries;
 	while (len) {
-		entry->ptr = __pa(buf);
+		entry->ptr = nx842_get_pa((void *)buf);
 		nextpage = ALIGN(buf + 1, NX842_HW_PAGE_SIZE);
 		if (nextpage < buf + len) {
 			/* we aren't at the end yet */
@@ -370,8 +379,8 @@
 	op.flags = NX842_OP_COMPRESS;
 	csbcpb = &workmem->csbcpb;
 	memset(csbcpb, 0, sizeof(*csbcpb));
-	op.csbcpb = __pa(csbcpb);
-	op.out = __pa(slout.entries);
+	op.csbcpb = nx842_get_pa(csbcpb);
+	op.out = nx842_get_pa(slout.entries);
 
 	for (i = 0; i < hdr->blocks_nr; i++) {
 		/*
@@ -401,13 +410,13 @@
 		 */
 		if (likely(max_sync_size == NX842_HW_PAGE_SIZE)) {
 			/* Create direct DDE */
-			op.in = __pa(inbuf);
+			op.in = nx842_get_pa((void *)inbuf);
 			op.inlen = max_sync_size;
 
 		} else {
 			/* Create indirect DDE (scatterlist) */
 			nx842_build_scatterlist(inbuf, max_sync_size, &slin);
-			op.in = __pa(slin.entries);
+			op.in = nx842_get_pa(slin.entries);
 			op.inlen = -nx842_get_scatterlist_size(&slin);
 		}
 
@@ -565,7 +574,7 @@
 	op.flags = NX842_OP_DECOMPRESS;
 	csbcpb = &workmem->csbcpb;
 	memset(csbcpb, 0, sizeof(*csbcpb));
-	op.csbcpb = __pa(csbcpb);
+	op.csbcpb = nx842_get_pa(csbcpb);
 
 	/*
 	 * max_sync_size may have changed since compression,
@@ -597,12 +606,12 @@
 		if (likely((inbuf & NX842_HW_PAGE_MASK) ==
 			((inbuf + hdr->sizes[i] - 1) & NX842_HW_PAGE_MASK))) {
 			/* Create direct DDE */
-			op.in = __pa(inbuf);
+			op.in = nx842_get_pa((void *)inbuf);
 			op.inlen = hdr->sizes[i];
 		} else {
 			/* Create indirect DDE (scatterlist) */
 			nx842_build_scatterlist(inbuf, hdr->sizes[i] , &slin);
-			op.in = __pa(slin.entries);
+			op.in = nx842_get_pa(slin.entries);
 			op.inlen = -nx842_get_scatterlist_size(&slin);
 		}
 
@@ -613,12 +622,12 @@
 		 */
 		if (likely(max_sync_size == NX842_HW_PAGE_SIZE)) {
 			/* Create direct DDE */
-			op.out = __pa(outbuf);
+			op.out = nx842_get_pa((void *)outbuf);
 			op.outlen = max_sync_size;
 		} else {
 			/* Create indirect DDE (scatterlist) */
 			nx842_build_scatterlist(outbuf, max_sync_size, &slout);
-			op.out = __pa(slout.entries);
+			op.out = nx842_get_pa(slout.entries);
 			op.outlen = -nx842_get_scatterlist_size(&slout);
 		}
 
