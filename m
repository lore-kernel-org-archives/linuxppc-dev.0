Return-Path: <mel@csn.ul.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EBF567B16
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 01:12:20 +1000 (EST)
Date: Fri, 26 May 2006 16:12:14 +0100
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd attempt)
Message-ID: <20060526151214.GA5190@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
From: mel@csn.ul.ie (Mel Gorman)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Resending with Andrew's email address correct this time)

For the last few -mm releases, kernels built for an old RS6000 failed to
compile with the message;

arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function `vrsqrtefp':
: undefined reference to `__udivdi3'
arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function `vrsqrtefp':
: undefined reference to `__udivdi3'
make: *** [.tmp_vmlinux1] Error 1

2.6.17-rc5 is not affected but I didn't search for the culprit patch in
-mm. The following patch adds an implementation of __udivdi3 for plain old
ppc32. This may not be the correct fix as Google tells me that __udivdi3
has been replaced by calls to do_div() in a number of cases. There was no
obvious way to do that for vrsqrtefp, hence this workaround. The patch should
be acked, rejected or replaced by a ppc expert.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc5-clean/arch/powerpc/lib/Makefile linux-2.6.17-rc5-udivdi3_ppc/arch/powerpc/lib/Makefile
--- linux-2.6.17-rc5-clean/arch/powerpc/lib/Makefile	2006-05-25 02:50:17.000000000 +0100
+++ linux-2.6.17-rc5-udivdi3_ppc/arch/powerpc/lib/Makefile	2006-05-26 13:17:15.000000000 +0100
@@ -4,7 +4,7 @@
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-y			:= string.o strcase.o
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o udivdi3.o
 endif
 
 obj-y			+= bitops.o
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.17-rc5-clean/arch/powerpc/lib/udivdi3.c linux-2.6.17-rc5-udivdi3_ppc/arch/powerpc/lib/udivdi3.c
--- linux-2.6.17-rc5-clean/arch/powerpc/lib/udivdi3.c	2006-05-26 13:17:22.000000000 +0100
+++ linux-2.6.17-rc5-udivdi3_ppc/arch/powerpc/lib/udivdi3.c	2006-05-26 13:25:26.000000000 +0100
@@ -0,0 +1,15 @@
+/*
+ * Simple __udivdi3 function which doesn't use FPU.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm-generic/div64.h>
+
+u64 __udivdi3(u64 n, u64 d)
+{
+	if (d & ~0xffffffff)
+		panic("Need true 64-bit/64-bit division");
+	return __div64_32(&n, (u32)d);
+}
+
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
