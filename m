Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id B556168A20
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2006 20:03:27 +1100 (EST)
Message-Id: <20060201090325.497639000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:02:36 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 12/44] generic sched_find_first_bit()
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, linuxsh-dev@lists.sourceforge.net,
	linux-m68k@lists.linux-m68k.org, Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch introduces the C-language equivalent of the function:
int sched_find_first_bit(const unsigned long *b);

In include/asm-generic/bitops/sched.h

This code largely copied from:
include/asm-powerpc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/sched.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/sched.h
===================================================================
--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/sched.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_SCHED_H_
+#define _ASM_GENERIC_BITOPS_SCHED_H_
+
+#include <linux/compiler.h>	/* unlikely() */
+#include <asm/types.h>
+
+/*
+ * Every architecture must define this function. It's the fastest
+ * way of searching a 140-bit bitmap where the first 100 bits are
+ * unlikely to be set. It's guaranteed that at least one of the 140
+ * bits is cleared.
+ */
+static inline int sched_find_first_bit(const unsigned long *b)
+{
+#if BITS_PER_LONG == 64
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 64;
+	return __ffs(b[2]) + 128;
+#elif BITS_PER_LONG == 32
+	if (unlikely(b[0]))
+		return __ffs(b[0]);
+	if (unlikely(b[1]))
+		return __ffs(b[1]) + 32;
+	if (unlikely(b[2]))
+		return __ffs(b[2]) + 64;
+	if (b[3])
+		return __ffs(b[3]) + 96;
+	return __ffs(b[4]) + 128;
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+
+#endif /* _ASM_GENERIC_BITOPS_SCHED_H_ */

--
