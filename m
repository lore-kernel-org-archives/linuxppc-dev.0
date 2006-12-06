Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9FA1D67BDD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 06:28:11 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6JS4F0007592
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 14:28:04 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6JS1at529700
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 12:28:01 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6JS0GW019215
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 12:28:01 -0700
Date: Wed, 6 Dec 2006 13:27:45 -0600
To: Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Bug report: CELL on linux-2.6.19-git7 won't build,
Message-ID: <20061206192745.GC17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Arnd, Geoff,

At this time, linux-2.6.19-git7 won't build when CELL is enabled, with the error

  CHECK   include/asm/spu_info.h
/kernels/kernel.org/linux-2.6.19-git7/usr/include/asm/spu_info.h requires asm/spu.h, which does not exist in exported headers

So I modified include/asm-powerpc/Kbuild only to get

  CHECK   include/asm/spu.h
/kernels/kernel.org/linux-2.6.19-git7/usr/include/asm/spu.h requires linux/workqueue.h, which does not exist in exported
headers

So I stripped everything out. I'm not sure what the correct fix is
suposed to be.

--linas

----
 include/asm-powerpc/Kbuild |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19-git7/include/asm-powerpc/Kbuild
===================================================================
--- linux-2.6.19-git7.orig/include/asm-powerpc/Kbuild	2006-12-05 17:11:02.000000000 -0600
+++ linux-2.6.19-git7/include/asm-powerpc/Kbuild	2006-12-06 13:13:08.000000000 -0600
@@ -17,7 +17,8 @@ header-y += ipc.h
 header-y += poll.h
 header-y += shmparam.h
 header-y += sockios.h
-header-y += spu_info.h
+# header-y += spu_info.h
+# header-y += spu.h
 header-y += ucontext.h
 header-y += ioctl.h
 header-y += linkage.h
