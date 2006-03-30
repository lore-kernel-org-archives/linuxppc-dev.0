Return-Path: <mort@bork.org>
Received: from galileo.bork.org (galileo.bork.org [134.117.69.57])
	by ozlabs.org (Postfix) with ESMTP id 3401F679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 08:39:28 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id F256F4037
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 16:11:43 -0500 (EST)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29121-03 for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 16:11:43 -0500 (EST)
Date: Thu, 30 Mar 2006 16:11:43 -0500
From: Martin Hicks <mort@bork.org>
To: linuxppc-embedded@ozlabs.org
Subject: U-boot CPU post failure on 405gp
Message-ID: <20060330211143.GK27792@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm using a PPC405gp based board, and using u-boot to boot Linux.  I
recently upgraded toolchains from gcc-3.2 (some timesys build) to a
gcc-3.4.5/glibc-2.3.6 toolchain built with crosstools-0.42

Reading specs from /home/mort/src/targa/powerpc-linux/gcc-3.4.5-glibc-2.3.6/powerpc-405-linux-gnu/bin/../lib/gcc/powerpc-405-linux-gnu/3.4.5/specs
Configured with: /home/mort/src/crosstool-0.42/build/powerpc-405-linux-gnu/gcc-3.4.5-glibc-2.3.6/gcc-3.4.5/configure --target=powerpc-405-linux-gnu --host=i686-host_pc-linux-gnu --prefix=/opt/targa/local/powerpc-linux/gcc-3.4.5-glibc-2.3.6/powerpc-405-linux-gnu --with-cpu=405 --enable-cxx-flags=-mcpu=405 --with-headers=/opt/targa/local/powerpc-linux/gcc-3.4.5-glibc-2.3.6/powerpc-405-linux-gnu/powerpc-405-linux-gnu/include --with-local-prefix=/opt/targa/local/powerpc-linux/gcc-3.4.5-glibc-2.3.6/powerpc-405-linux-gnu/powerpc-405-linux-gnu --disable-nls --enable-threads=posix --enable-symvers=gnu --enable-__cxa_atexit --enable-languages=c,c++ --enable-shared --enable-c99 --enable-long-long
Thread model: posix
gcc version 3.4.5


The problem I'm having is when running the CPU post test on u-boot
1.1.4.  Specifically, in the branch tests.  While doing the first branch
conditional test the computer incorrectly takes the "if (link)" branch
in u-boot/post/cpu/b.c::cpu_post_test_bc()

--- a/post/cpu/b.c
+++ b/post/cpu/b.c
@@ -84,10 +84,14 @@ static int cpu_post_test_bc (ulong cmd, 
     }
     if (ret == 0)
     {
-	if (link)
+        printf("link = %d\n", link);
+        if (link)
 	    ret = lr == (ulong) code + 24 ? 0 : -1;
 	else
 	    ret = lr == 0 ? 0 : -1;
+	if (ret)
+		printf("ret = %d, link = %lx, code = %p, lr = %lx\n",
+		       ret, link, code, lr);
     }
 
     return ret;

---

Running with this small change, I get:

POST cpu link = 0
ret = -1, link = 0, code = 03fa5ab8, lr = 0

It looks clear to me that link == 0, so the test worked fine.

However, if I take away the "static" from the cpu_post_test_bc()
declaration then everything works fine.

I've posted "objdump -dS" output for post/cpu/b.o with and without
cpu_post_test_bc() declared as static at:

http://www.bork.org/~mort/ppcstatic/

Any hints appreciated.  Let me know if any other info is required.
mh

-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
