Return-Path: <sachinp@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C59B667B73
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 14:37:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8L4b73K031894
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:37:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8L4b7ZC238300
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:37:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8L4b7Sh031920
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:37:07 -0400
Message-ID: <451216EE.8010404@in.ibm.com>
Date: Thu, 21 Sep 2006 10:07:02 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] kdump: don't call __ioremap() for pfn = 0
Content-Type: multipart/mixed; boundary="------------000200080202030300040502"
Cc: paulus@samba.org, Fastboot mailing list <fastboot@lists.osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000200080202030300040502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

While using dd command to retrive the dump from /dev/oldmem, there comes
a rare case where pfn value is zero. In this case the __ioremap() call 
returns
NULL and hence copying fails.

# dd if=/dev/oldmem of=/dev/null
dd: reading `/dev/oldmem': Bad address
0+0 records in
0+0 records out
0 bytes (0 B) copied, 0.000121 seconds, 0.0 kB/s

Attached is a patch to fix this problem. During such rare cases don't call
__ioremap() to do the address translation, instead use __va() .

Tested with 2.6.18.

Thanks
-Sachin

--------------000200080202030300040502
Content-Type: text/plain;
 name="kdump-no-ioremap-for-pfn-zero-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-no-ioremap-for-pfn-zero-fix"

* During some rare cases [like using dd command with /dev/oldmem] the pfn value
  can be zero. Do not call __ioremap for zero pfn value, instead use __va to 
  calculate the virtual address.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>

diff -Naurp a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
--- a/arch/powerpc/kernel/crash_dump.c	2006-09-20 09:12:06.000000000 +0530
+++ b/arch/powerpc/kernel/crash_dump.c	2006-09-21 09:06:35.000000000 +0530
@@ -101,7 +101,15 @@ ssize_t copy_oldmem_page(unsigned long p
 	if (!csize)
 		return 0;
 
-	vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
+	/* During some rare cases [like using dd command with /dev/oldmem] 
+	 * the pfn value can be zero. Do not call __ioremap for zero
+	 * pfn value, instead use __va to calculate the virtual address.
+	 */
+
+	if (pfn == 0)
+		vaddr = __va(pfn << PAGE_SHIFT);
+	else
+		vaddr = __ioremap(pfn << PAGE_SHIFT, PAGE_SIZE, 0);
 
 	if (userbuf) {
 		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {

--------------000200080202030300040502--
