Return-Path: <sachinp@in.ibm.com>
Received: from e28esmtp01.in.ibm.com (e28smtp01.in.ibm.com [59.145.155.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp01.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64EE7DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:44:22 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id m5QAt2aC010260
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:25:02 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5QArw7U844016
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:23:58 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m5QAt2uK024071
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:25:02 +0530
Received: from [9.124.35.194] (sachinp.in.ibm.com [9.124.35.194])
	by d28av04.in.ibm.com (8.13.1/8.12.11) with ESMTP id m5QAt2Qh024068
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 16:25:02 +0530
Message-ID: <48637594.5040709@in.ibm.com>
Date: Thu, 26 Jun 2008 16:25:16 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix /dev/oldmem for kdump
Content-Type: multipart/mixed; boundary="------------040900090504010506080002"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040900090504010506080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one has been pending for a long time. Somehow never
made it upstream.

Resending the patch which fixes /dev/oldmem interface for kdump.

Tested with 2.6.26-rc8.

Signed-off-by : Michael Ellerman <michael@ellerman.id.au>


--------------040900090504010506080002
Content-Type: text/plain;
 name="fix-oldmem-interface-for-kdump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-oldmem-interface-for-kdump"

Fix /dev/oldmem for kdump

A change to __ioremap() broke reading /dev/oldmem because we're no
longer able to ioremap pfn 0 (d177c207ba16b1db31283e2d1fee7ad4a863584b).

We actually don't need to ioremap for anything that's part of the linear
mapping, so just read it directly.

Also make sure we're only reading one page or less at a time.

Signed-off-by : Michael Ellerman <michael@ellerman.id.au>
---

diff -Naurp old/arch/powerpc/kernel/crash_dump.c new/arch/powerpc/kernel/crash_dump.c
--- old/arch/powerpc/kernel/crash_dump.c	2008-06-25 07:28:20.000000000 +0530
+++ new/arch/powerpc/kernel/crash_dump.c	2008-06-26 14:46:17.000000000 +0530
@@ -83,6 +83,19 @@ static int __init parse_savemaxmem(char 
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
@@ -104,16 +117,16 @@ ssize_t copy_oldmem_page(unsigned long p
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

--------------040900090504010506080002--
