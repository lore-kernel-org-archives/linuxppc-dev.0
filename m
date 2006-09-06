Return-Path: <sachinp@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 79BB767B32
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 10:26:30 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k860QRkS025555
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 20:26:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k860QQWM267702
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 20:26:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k860QQPT000307
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 20:26:26 -0400
Message-ID: <44FE15B0.3030909@in.ibm.com>
Date: Wed, 06 Sep 2006 05:56:24 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] kdump : Support kernels having 64k page size.
Content-Type: multipart/mixed; boundary="------------010800050205020501030704"
Cc: fastboot-bounces@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010800050205020501030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following  kernel patch [ along with a patch to kexec tools posted 
seperately ]
is required to generate proper core files using kdump on ppc64.

Thanks
-Sachin



--------------010800050205020501030704
Content-Type: text/plain;
 name="ppc64-kexec-tools-64k-page-support"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-kexec-tools-64k-page-support"

* Generate proper core files using kdump on ppc64 with 64k page support.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/include/asm-powerpc/kdump.h b/include/asm-powerpc/kdump.h
--- a/include/asm-powerpc/kdump.h	2006-08-31 03:01:13.000000000 +0530
+++ b/include/asm-powerpc/kdump.h	2006-08-31 05:49:13.000000000 +0530
@@ -7,7 +7,7 @@
 /* How many bytes to reserve at zero for kdump. The reserve limit should
  * be greater or equal to the trampoline's end address.
  * Reserve to the end of the FWNMI area, see head_64.S */
-#define KDUMP_RESERVE_LIMIT	0x8000
+#define KDUMP_RESERVE_LIMIT	max(0x8000, PAGE_SIZE)
 
 #ifdef CONFIG_CRASH_DUMP
 

--------------010800050205020501030704--
