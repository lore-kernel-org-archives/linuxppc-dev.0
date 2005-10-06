Return-Path: <pgaltieri@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id E5DB6684CB
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Oct 2005 09:24:36 +1000 (EST)
Received: from playin.mvista.com (playin.az.mvista.com [10.50.1.73])
	by hermes.mvista.com (Postfix) with ESMTP id AD51C1A54F
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Oct 2005 16:01:28 -0700 (PDT)
From: Paolo Galtieri <pgaltieri@mvista.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-x0srW5L4CPmpyUg085uT"
Date: Thu, 06 Oct 2005 16:01:28 -0700
Message-Id: <1128639689.4809.19.camel@playin.mvista.com>
Mime-Version: 1.0
Subject: Two bugs in handling of highmem on PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-x0srW5L4CPmpyUg085uT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Folks,
  in looking at the PPC code for handling highmem and it appears to me
that there are two bugs in how the data is written out by
__dma_sync_page_highmem().
The first is how the size of the first segment is calculated, and the
second is in the calculation of the number of segments to write out.

In the case of the first bug here is the code:

    size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;

The intent here is to determine the number of bytes you can write in the
current page given that kmap_atomic() maps pages in one at a time.  The
problem with this code is depending on the values of size and offset the
result can be negative, e.g. if size is 200 and offset is 800 then:

    seg_size = min(4096, 200) - 800
    seg_size = 200 - 800
    seg_size = -600; 

At best this will cause an OOPs, but more likely a panic, when you call
__dma_sync() because your end address will be lower than the start
address. I believe the correct calculation should be:

    size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);

Here (PAGE_SIZE - offset) gives you the amount of space left in the page
which is really what you want to use when determining the number of
bytes you can write.

In the case of the second bug here is the code:

    int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;

The first thing that sticks out is why is the macro PAGE_ALIGN(), which
is supposed to take an address as a parameter, being called with a size?

The problem with this code is that it returns the wrong number of
segments. For example, if size is 200 and the offset is 4095 this will
return 1 as the number of segments.  This is wrong, there are in fact 2
segments to write, 1 byte in the current page and 199 bytes in the next
page. I believe the correct calculation should be:

    1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;

The 1 represents the first segment which will always get written, the
rest represents the number of full and partial pages that need to be
written out.  For example, if we have a size of 200 and an offset of
4095 then seg_size is 1 (min(4096 - 4095, 200)) so the number of
segments comes out to:

    nr_segs = 1 + (200 - 1 + 4096 - 1)/4096
    nr_segs = 1 + 4294/4096
    nr_segs = 1 + 1
    nr_segs = 2

Which is correct.

I would very much appreciate it if those of you who are more familiar
with this part of the kernel could review and comment on my
interpretation of what is going on and provide feedback.

Thank you,
Paolo Galtieri

I have attached a patch that is made against 2.6.14-rc3-git6


--=-x0srW5L4CPmpyUg085uT
Content-Disposition: attachment; filename=PPC-highmempatch
Content-Type: text/plain; name=PPC-highmempatch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14/arch/ppc/kernel/dma-mapping.c.orig	2005-10-06 15:50:46.000000000 -0700
+++ linux-2.6.14/arch/ppc/kernel/dma-mapping.c	2005-10-06 15:51:40.000000000 -0700
@@ -401,10 +401,10 @@
 static inline void __dma_sync_page_highmem(struct page *page,
 		unsigned long offset, size_t size, int direction)
 {
-	size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
+	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size = seg_size;
 	unsigned long flags, start, seg_offset = offset;
-	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
+	1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
 	int seg_nr = 0;
 
 	local_irq_save(flags);

--=-x0srW5L4CPmpyUg085uT--
