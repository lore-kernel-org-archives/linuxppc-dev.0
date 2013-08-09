Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF0602C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 04:25:19 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 12:25:16 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CED4338C8027
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 14:25:12 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r79IPE2M186282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 14:25:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r79IPDMc031166
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 14:25:13 -0400
Received: from suka2 (suka2.usor.ibm.com [9.70.94.91])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r79IPAZc031038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Aug 2013 14:25:10 -0400
Date: Fri, 9 Aug 2013 11:24:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Build errors on mainline kernel
Message-ID: <20130809182446.GA26711@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I am tryng to compile clean mainline kernel with a few different config files
and running into errors with some configs.

I am building on RHEL6.3 with following binaries:

	gcc (GCC) 4.4.6 20120305 (Red Hat 4.4.6-4)
	GNU ld version 2.20.51.0.2-5.34.el6 20100205
	binutils-2.20.51.0.2-5.34.el6.ppc64
	binutils-devel-2.20.51.0.2-5.34.el6.ppc64

I am getting the error with several files and configs, but other configs 
(eg: ppc64_defconfig, pmac32_defconfig) build fine.

For instance, with latest mainline kernel (commit 6c2580c) and ppc64_defconfig, I get:

	make O=linux-obj mrproper
	make O=linux-obj ppc64e_defconfig
	make O=linux-obj arch/powerpc/platforms/85xx/smp.o
	  ...

	CC      arch/powerpc/platforms/85xx/smp.o
	{standard input}: Assembler messages:
	{standard input}:240: Error: junk at end of line: `1'
	make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
	make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2

Not sure if 240 is a line number in smp.c, but looking through the function
containing line 240, I was able to compile the smp.c after commenting out
the two WARN_ON() messages.

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp
index 5ced4f5..9705850 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -151,8 +151,10 @@ static int smp_85xx_kick_cpu(int nr)
        int ioremappable;
        int ret = 0;
 
+#if 0
        WARN_ON(nr < 0 || nr >= NR_CPUS);
        WARN_ON(hw_cpu < 0 || hw_cpu >= NR_CPUS);
+#endif
 
        pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);

---

The pre-processor output for the first WARN_ON() is:

 ---
 ({ int __ret_warn_on = !!(nr < 0 || nr >= 32); if (__builtin_constant_p(__ret_warn_on)) { if (__ret_warn_on) do { __asm__ __volatile__( "1:    twi 31,0,0\n" ".section __bug_table,\"a\"\n" "2:\t" ".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previous\n" : : "i" ("/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"), "i" (154), "i" (((1 << 0) | ((9) << 8))), "i" (sizeof(struct bug_entry))); } while (0); } else { __asm__ __volatile__( "1:      ""tdnei" " ""   %4,0\n" ".section __bug_table,\"a\"\n" "2:\t" ".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previous\n" : : "i" ("/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"), "i" (154), "i" (((1 << 0) | ((9) << 8))), "i" (sizeof(struct bug_entry)), "r" (__ret_warn_on)); } __builtin_expect(!!(__ret_warn_on), 0); });

---


Should I be doing something different to build with these configs ?
