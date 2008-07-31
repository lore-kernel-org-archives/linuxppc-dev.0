Return-Path: <sachinp@in.ibm.com>
Received: from e28esmtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7C49DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:54:16 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id m6V6sAq4016653
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 12:24:10 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6V6sA1k794710
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 12:24:10 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m6V6s9fP007886
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 12:24:09 +0530
Message-ID: <489161A4.6060801@in.ibm.com>
Date: Thu, 31 Jul 2008 12:24:28 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/kdump: Fix /dev/oldmem interface
Content-Type: multipart/mixed; boundary="------------020906020009090102040509"
Cc: linuxppc-dev@ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020906020009090102040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the /dev/oldmem interface for kdump on ppc64.
The patch originally came from Michael Ellerman hence have
retained the signed-off line. I just rediffed/tested against
latest git. Michael has ack'ed this patch.

Ben this is not a must for 2.6.27 but would be good if it's 
included.

Thanks
-Sachin

Signed-off-by : Michael Ellerman <michael@ellerman.id.au>
Acked-by : Michael Ellerman <michael@ellerman.id.au>

---


--------------020906020009090102040509
Content-Type: text/x-patch;
 name="fix-oldmem-interface-of-kdump.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-oldmem-interface-of-kdump.patch"

Fix /dev/oldmem for kdump

A change to __ioremap() broke reading /dev/oldmem because we're no
longer able to ioremap pfn 0 (d177c207ba16b1db31283e2d1fee7ad4a863584b).

We actually don't need to ioremap for anything that's part of the linear
mapping, so just read it directly.

Also make sure we're only reading one page or less at a time.

Signed-off-by : Michael Ellerman <michael@ellerman.id.au>
---

diff -Naurp 1/arch/powerpc/kernel/crash_dump.c 2/arch/powerpc/kernel/crash_dump.c
--- 1/arch/powerpc/kernel/crash_dump.c	2008-07-31 11:55:39.000000000 +0530
+++ 2/arch/powerpc/kernel/crash_dump.c	2008-07-31 12:09:49.000000000 +0530
@@ -86,6 +86,19 @@ static int __init parse_savemaxmem(char 
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
+
+static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
+                               unsigned long offset, int userbuf)
+{
+	if (userbuf) {
+		if (copy_to_user((char __user *)buf, (vaddr + offset), csize))
+			return -EFAULT;
+	} else
+		memcpy(buf, (vaddr + offset), csize);
+
+	return csize;
+}
+
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -107,16 +120,16 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!csize)
 		return 0;
 
-	vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+	csize = min(csize, PAGE_SIZE);
 
-	if (userbuf) {
-		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
-			iounmap(vaddr);
-			return -EFAULT;
-		}
-	} else
-		memcpy(buf, (vaddr + offset), csize);
+	if (pfn < max_pfn) {
+		vaddr = __va(pfn << PAGE_SHIFT);
+		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+	} else {
+		vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
+		iounmap(vaddr);
+	}
 
-	iounmap(vaddr);
 	return csize;
 }

--------------020906020009090102040509--
