Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1B2DDE10B
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 17:25:43 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n0V6PgrR000337
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 17:25:42 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0V6Q0K9643134
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 17:26:00 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0V6Pgqc004338
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 17:25:42 +1100
Message-ID: <4983EEE3.3080208@in.ibm.com>
Date: Sat, 31 Jan 2009 11:55:39 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Patch] 2.6.29-rc3-git2 - Fix net/ipv6/ip6mr.o build break
Content-Type: multipart/mixed; boundary="------------040102010908060506040102"
Cc: yoshfuji@linux-ipv6.org, Mel Gorman <mel@csn.ul.ie>, davem@davemloft.net,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040102010908060506040102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

allmodconfig build breaks with following error.

 CHK     include/linux/version.h
 CHK     include/linux/utsrelease.h
 SYMLINK include/asm -> include/asm-powerpc
 CALL    scripts/checksyscalls.sh
 CHK     include/linux/compile.h
 CALL    arch/powerpc/kernel/systbl_chk.sh
 CALL    arch/powerpc/kernel/prom_init_check.sh
 CC [M]  net/ipv6/ip6mr.o
net/ipv6/ip6mr.c: In function pim6_rcv:
net/ipv6/ip6mr.c:366: error: implicit declaration of function csum_ipv6_magic
make[2]: *** [net/ipv6/ip6mr.o] Error 1
make[1]: *** [net/ipv6] Error 2
make: *** [net] Error 2

Following patch fixes this issue.

thanks
-Sachin


Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---



--------------040102010908060506040102
Content-Type: text/x-patch;
 name="fix-ipv6-ip6mr-build-break.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ipv6-ip6mr-build-break.patch"

* Fix ip6mr build break (undefined csum_ipv6_magic symbol)

Signed-off-by : Sachin Sant (sachinp@in.ibm.com)
---

diff -Naurp a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
--- a/net/ipv6/ip6mr.c	2009-01-31 13:58:00.000000000 +0530
+++ b/net/ipv6/ip6mr.c	2009-01-31 13:59:16.000000000 +0530
@@ -43,6 +43,7 @@
 #include <net/netlink.h>
 
 #include <net/ipv6.h>
+#include <net/ip6_checksum.h>
 #include <net/ip6_route.h>
 #include <linux/mroute6.h>
 #include <linux/pim.h>

--------------040102010908060506040102--
