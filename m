Return-Path: <sonny@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 240A3DDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 11:38:44 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mA70cISk008752
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 17:38:18 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA70cgdE145724
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 17:38:42 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA70cCXq006422
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Nov 2008 17:38:13 -0700
Date: Thu, 6 Nov 2008 18:38:41 -0600
From: Sonny Rao <sonnyrao@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
Message-ID: <20081107003841.GE7533@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the BSR driver to allow small BSR devices, which are limited to a
single 4k space, on a 64k page kernel.  Previously the driver would
reject the mmap since the size was smaller than PAGESIZE (or because
the size was greater than the size of the device).  Now, we check for
this case use remap_4k_pfn(). Also, take out code to set vm_flags,
as the remap_pfn functions will do this for us.


Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>

Index: common/drivers/char/bsr.c
===================================================================
--- common.orig/drivers/char/bsr.c	2008-11-06 16:43:58.000000000 -0600
+++ common/drivers/char/bsr.c	2008-11-06 18:30:41.000000000 -0600
@@ -27,6 +27,7 @@
 #include <linux/cdev.h>
 #include <linux/list.h>
 #include <linux/mm.h>
+#include <asm/pgtable.h>
 #include <asm/io.h>
 
 /*
@@ -115,15 +116,23 @@
 {
 	unsigned long size   = vma->vm_end - vma->vm_start;
 	struct bsr_dev *dev = filp->private_data;
+	int ret;
 
-	if (size > dev->bsr_len || (size & (PAGE_SIZE-1)))
-		return -EINVAL;
+	/* This is legal where we have a BSR on a 4k page but a 64k kernel */
+	if (size > dev->bsr_len)
+		size = dev->bsr_len;
 
-	vma->vm_flags |= (VM_IO | VM_DONTEXPAND);
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
-			       size, vma->vm_page_prot))
+	if (dev->bsr_len < PAGE_SIZE)
+		ret = remap_4k_pfn(vma, vma->vm_start, dev->bsr_addr >> 12,
+				   vma->vm_page_prot);
+	else
+		ret = io_remap_pfn_range(vma, vma->vm_start,
+					 dev->bsr_addr >> PAGE_SHIFT,
+					 size, vma->vm_page_prot);
+
+	if (ret)
 		return -EAGAIN;
 
 	return 0;
