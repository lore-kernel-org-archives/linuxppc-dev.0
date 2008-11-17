Return-Path: <sonny@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FD9BDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 18:26:18 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAH7Pjo8012671
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 00:25:45 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAH7QDBD145804
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 00:26:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAH7QDD6014267
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 00:26:13 -0700
Date: Mon, 17 Nov 2008 01:26:13 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20081117072613.GO16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18707.53757.132643.518167@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 07, 2008 at 04:28:29PM +1100, Paul Mackerras wrote:
> Sonny Rao writes:
> 
> > Fix the BSR driver to allow small BSR devices, which are limited to a
> > single 4k space, on a 64k page kernel.  Previously the driver would
> > reject the mmap since the size was smaller than PAGESIZE (or because
> > the size was greater than the size of the device).  Now, we check for
> > this case use remap_4k_pfn(). Also, take out code to set vm_flags,
> > as the remap_pfn functions will do this for us.
> 
> Thanks.
> 
> Do we know that the BSR size will always be 4k if it's not a multiple
> of 64k?  Is it possible that we could get 8k, 16k or 32k or BSRs?
> If it is possible, what does the user need to be able to do?  Do they
> just want to map 4k, or might then want to map the whole thing?


Hi Paul, I took a look at changing the driver to reject a request for
mapping more than a single 4k page, however the only indication we get
of the requested size in the mmap function is the vma size, and this
is always one page at minimum.  So, it's not possible to determine if
the user wants one 4k page or more.  As I noted in my first response,
there is only one case where this is even possible and I don't think
it is a significant concern.

I did notice that I left out the check to see if the user is trying to
map more than the device length, so I fixed that.  Here's the revised
patch.

--------

Fix the BSR driver to allow small BSR devices on a 64k page kernel.  
Previously the driver would reject the mmap since the size was smaller
than PAGESIZE. This patch adds a  check for this case and uses remap_4k_pfn().

Also, take out code to set vm_flags, as the remap_pfn functions will
do this for us.

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>

Index: linux/drivers/char/bsr.c
===================================================================
--- linux.orig/drivers/char/bsr.c	2008-11-17 00:29:23.000000000 -0600
+++ linux/drivers/char/bsr.c	2008-11-17 00:59:57.000000000 -0600
@@ -27,6 +27,7 @@
 #include <linux/cdev.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <asm/pgtable.h>
 #include <asm/io.h>
 
 /*
@@ -115,15 +116,22 @@
 {
 	unsigned long size   = vma->vm_end - vma->vm_start;
 	struct bsr_dev *dev = filp->private_data;
+	int ret;
 
-	if (size > dev->bsr_len || (size & (PAGE_SIZE-1)))
-		return -EINVAL;
-
-	vma->vm_flags |= (VM_IO | VM_DONTEXPAND);
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
-			       size, vma->vm_page_prot))
+	/* check for the case of a small BSR device and map one 4k page for it*/
+	if (dev->bsr_len < PAGE_SIZE && size == PAGE_SIZE)
+		ret = remap_4k_pfn(vma, vma->vm_start, dev->bsr_addr >> 12,
+				   vma->vm_page_prot);
+	else if (size <= dev->bsr_len)
+		ret = io_remap_pfn_range(vma, vma->vm_start,
+					 dev->bsr_addr >> PAGE_SHIFT,
+					 size, vma->vm_page_prot);
+	else
+		return -EINVAL;
+
+	if (ret)
 		return -EAGAIN;
 
 	return 0;
