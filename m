Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id 7E158679FF
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2006 16:05:05 +1100 (EST)
Message-Id: <20060214050444.599668000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:06 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 15/47] generic hweight{64,32,16,8}()
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>, Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch introduces the C-language equivalents of the functions below:

unsigned int hweight32(unsigned int w);
unsigned int hweight16(unsigned int w);
unsigned int hweight8(unsigned int w);
unsigned long hweight64(__u64 w);

In include/asm-generic/bitops/hweight.h

This code largely copied from:
include/linux/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/hweight.h |    9 +++++
 lib/Makefile                         |    1 
 lib/hweight.c                        |   54 +++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/hweight.h
===================================================================
--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/hweight.h
@@ -0,0 +1,9 @@
+#ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
+#define _ASM_GENERIC_BITOPS_HWEIGHT_H_
+
+extern unsigned int hweight32(unsigned int w);
+extern unsigned int hweight16(unsigned int w);
+extern unsigned int hweight8(unsigned int w);
+extern unsigned long hweight64(__u64 w);
+
+#endif /* _ASM_GENERIC_BITOPS_HWEIGHT_H_ */
Index: 2.6-rc/lib/Makefile
===================================================================
--- 2.6-rc.orig/lib/Makefile
+++ 2.6-rc/lib/Makefile
@@ -21,6 +21,7 @@ lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += 
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
Index: 2.6-rc/lib/hweight.c
===================================================================
--- /dev/null
+++ 2.6-rc/lib/hweight.c
@@ -0,0 +1,54 @@
+#include <linux/module.h>
+#include <asm/types.h>
+
+/**
+ * hweightN - returns the hamming weight of a N-bit word
+ * @x: the word to weigh
+ *
+ * The Hamming Weight of a number is the total number of bits set in it.
+ */
+
+unsigned int hweight32(unsigned int w)
+{
+	unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+	res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+	res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+	res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+	return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+EXPORT_SYMBOL(hweight32);
+
+unsigned int hweight16(unsigned int w)
+{
+	unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+	res = (res & 0x3333) + ((res >> 2) & 0x3333);
+	res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+	return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+EXPORT_SYMBOL(hweight16);
+
+unsigned int hweight8(unsigned int w)
+{
+	unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+	res = (res & 0x33) + ((res >> 2) & 0x33);
+	return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+EXPORT_SYMBOL(hweight8);
+
+unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG == 32
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#elif BITS_PER_LONG == 64
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+EXPORT_SYMBOL(hweight64);

--
