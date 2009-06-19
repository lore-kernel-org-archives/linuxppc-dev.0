Return-Path: <sonny@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1C9B0B7241
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 11:13:11 +1000 (EST)
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FE0CDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 11:13:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5J1G0jH005764
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 21:16:00 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J1D5Rm018098
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 21:13:05 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J1D5Wx014159
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 21:13:05 -0400
Date: Thu, 18 Jun 2009 20:13:04 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20090619011304.GF31192@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
	<20081117072613.GO16240@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081117072613.GO16240@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, sonnyrao@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 17, 2008 at 01:26:13AM -0600, Sonny Rao wrote:
> On Fri, Nov 07, 2008 at 04:28:29PM +1100, Paul Mackerras wrote:
> > Sonny Rao writes:
> > 
> > > Fix the BSR driver to allow small BSR devices, which are limited to a
> > > single 4k space, on a 64k page kernel.  Previously the driver would
> > > reject the mmap since the size was smaller than PAGESIZE (or because
> > > the size was greater than the size of the device).  Now, we check for
> > > this case use remap_4k_pfn(). Also, take out code to set vm_flags,
> > > as the remap_pfn functions will do this for us.
> > 
> > Thanks.
> > 
> > Do we know that the BSR size will always be 4k if it's not a multiple
> > of 64k?  Is it possible that we could get 8k, 16k or 32k or BSRs?
> > If it is possible, what does the user need to be able to do?  Do they
> > just want to map 4k, or might then want to map the whole thing?
> 
> 
> Hi Paul, I took a look at changing the driver to reject a request for
> mapping more than a single 4k page, however the only indication we get
> of the requested size in the mmap function is the vma size, and this
> is always one page at minimum.  So, it's not possible to determine if
> the user wants one 4k page or more.  As I noted in my first response,
> there is only one case where this is even possible and I don't think
> it is a significant concern.
> 
> I did notice that I left out the check to see if the user is trying to
> map more than the device length, so I fixed that.  Here's the revised
> patch.

Alright, I've reworked this now so that if we get one of these cases
where there's a bsr that's > 4k and < 64k on a 64k kernel we'll only
advertise that it is a 4k BSR to userspace.  I think this is the best
solution since user programs are only supposed to look at sysfs to
determine how much can be mapped, and libbsr does this as well.

Please consider for 2.6.31 as a fix, thanks.

---

Fix the BSR driver to allow small BSR devices on a 64k page kernel.  
Previously the driver would reject the mmap since the size was smaller
than PAGESIZE. This patch adds a check for this case and uses remap_4k_pfn().

There are also casees where we have a size that is greater than 4k but
smaller than 64k, and in that case we would only map the first 4k using
remap_4k_pfn, so we also change the length that we advertise in sysfs, 
so the user knows they can only map 4k. 

Also, take out code to set vm_flags, as the remap_pfn functions will
do this for us.

Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>

Index: linux-2.6.30/drivers/char/bsr.c
===================================================================
--- linux-2.6.30.orig/drivers/char/bsr.c	2009-06-18 13:02:16.000000000 -0500
+++ linux-2.6.30/drivers/char/bsr.c	2009-06-18 18:18:29.000000000 -0500
@@ -27,6 +27,7 @@
 #include <linux/cdev.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <asm/pgtable.h>
 #include <asm/io.h>
 
 /*
@@ -117,15 +118,22 @@
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
@@ -205,6 +213,11 @@
 		cur->bsr_stride = bsr_stride[i];
 		cur->bsr_dev    = MKDEV(bsr_major, i + total_bsr_devs);
 
+		/* if we have a bsr_len of > 4k and less then PAGE_SIZE (64k pages) */
+		/* we can only map 4k of it, so only advertise the 4k in sysfs */
+		if (cur->bsr_len > 4096 && cur->bsr_len < PAGE_SIZE)
+			cur->bsr_len = 4096;
+
 		switch(cur->bsr_bytes) {
 		case 8:
 			cur->bsr_type = BSR_8;
