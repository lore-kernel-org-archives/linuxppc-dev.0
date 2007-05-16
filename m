Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49B8CDDF26
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:52:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4GImVgP016767
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:48:31 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GIq7Lp212962
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:52:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GIq7jl025509
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:52:07 -0600
Received: from [9.10.86.50] (9-10-86-50.rchland.ibm.com [9.10.86.50])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4GIq7AM025490
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 12:52:07 -0600
Subject: [PATCH] Pass per-file CFLAGs for platform specific op codes
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 16 May 2007 13:51:37 -0500
Message-Id: <1179341497.13214.117.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As a result of compiling all of the wrapper files for every platform
now, the kernel build can fail for toolchains that don't support various
op codes by default.  An example of this building a 7xx platform with
the ELD4.0 toolchain, is below:

/tmp/ccYjhJoL.s: Assembler messages:
/tmp/ccYjhJoL.s:42: Error: Unrecognized opcode: `mtdcr'
/tmp/ccYjhJoL.s:43: Error: Unrecognized opcode: `mfdcr'
make[1]: *** [arch/powerpc/boot/44x.o] Error 1

The following patch introduces additional CFLAGS for the 4xx specific
files and fixes the kernel compile.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -33,6 +33,9 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
+$(obj)/44x.o: BOOTCFLAGS += -Wa,-mbooke
+$(obj)/ebony.o: BOOTCFLAGS += -Wa,-mbooke
+
 zlib       := inffast.c inflate.c inftrees.c
 zlibheader := inffast.h inffixed.h inflate.h inftrees.h infutil.h
 zliblinuxheader := zlib.h zconf.h zutil.h
