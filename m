Return-Path: <pgaltieri@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 73F9168505
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Oct 2005 04:09:38 +1000 (EST)
Received: from playin.mvista.com (playin.az.mvista.com [10.50.1.73])
	by hermes.mvista.com (Postfix) with ESMTP id 46F661A53F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Oct 2005 11:09:37 -0700 (PDT)
From: Paolo Galtieri <pgaltieri@mvista.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-BO5BWmMR95Z2x24CRQi5"
Date: Fri, 07 Oct 2005 11:09:37 -0700
Message-Id: <1128708577.4809.36.camel@playin.mvista.com>
Mime-Version: 1.0
Subject: Updated high mem patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BO5BWmMR95Z2x24CRQi5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There was a minor error in the high mem patch I posted yesterday.  I
have attached the correct patch.

Paolo

--=-BO5BWmMR95Z2x24CRQi5
Content-Disposition: attachment; filename=PPC-highmempatch
Content-Type: text/plain; name=PPC-highmempatch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14/arch/ppc/kernel/dma-mapping.c.orig	2005-10-06 15:50:46.000000000 -0700
+++ linux-2.6.14/arch/ppc/kernel/dma-mapping.c	2005-10-07 08:36:33.000000000 -0700
@@ -401,10 +401,10 @@
 static inline void __dma_sync_page_highmem(struct page *page,
 		unsigned long offset, size_t size, int direction)
 {
-	size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
+	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size = seg_size;
 	unsigned long flags, start, seg_offset = offset;
-	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
+	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
 	int seg_nr = 0;
 
 	local_irq_save(flags);

--=-BO5BWmMR95Z2x24CRQi5--
