Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 54AC12C016A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 03:14:53 +1100 (EST)
From: Mark Salter <msalter@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] Add generic fixmap.h
Date: Mon, 25 Nov 2013 11:13:55 -0500
Message-Id: <1385396045-15852-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1385396045-15852-1-git-send-email-msalter@redhat.com>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 Michal Simek <monstr@monstr.eu>, James Hogan <james.hogan@imgtec.com>,
 Russell King <linux@arm.linux.org.uk>, linux-hexagon@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, Richard Kuo <rkuo@codeaurora.org>,
 Mark Salter <msalter@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many architectures provide an asm/fixmap.h which defines support for
compile-time 'special' virtual mappings which need to be made before
paging_init() has run. This support is also used for early ioremap
on x86. Much of this support is identical across the architectures.
This patch consolidates all of the common bits into asm-generic/fixmap.h
which is intended to be included from arch/*/include/asm/fixmap.h.

Signed-off-by: Mark Salter <msalter@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: linux-arch@vger.kernel.org
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
CC: Richard Kuo <rkuo@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
CC: James Hogan <james.hogan@imgtec.com>
CC: linux-metag@vger.kernel.org
CC: Michal Simek <monstr@monstr.eu>
CC: microblaze-uclinux@itee.uq.edu.au
CC: linux-mips@linux-mips.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
---
 include/asm-generic/fixmap.h | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 include/asm-generic/fixmap.h

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
new file mode 100644
index 0000000..5a64ca4
--- /dev/null
+++ b/include/asm-generic/fixmap.h
@@ -0,0 +1,97 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ * x86_32 and x86_64 integration by Gustavo F. Padovan, February 2009
+ * Break out common bits to asm-generic by Mark Salter, November 2013
+ */
+
+#ifndef __ASM_GENERIC_FIXMAP_H
+#define __ASM_GENERIC_FIXMAP_H
+
+#include <linux/bug.h>
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+#ifndef __ASSEMBLY__
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without translation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
+	return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+/*
+ * Provide some reasonable defaults for page flags.
+ * Not all architectures use all of these different types and some
+ * architectures use different names.
+ */
+#ifndef FIXMAP_PAGE_NORMAL
+#define FIXMAP_PAGE_NORMAL PAGE_KERNEL
+#endif
+#ifndef FIXMAP_PAGE_NOCACHE
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
+#endif
+#ifndef FIXMAP_PAGE_IO
+#define FIXMAP_PAGE_IO PAGE_KERNEL_IO
+#endif
+#ifndef FIXMAP_PAGE_CLEAR
+#define FIXMAP_PAGE_CLEAR __pgprot(0)
+#endif
+
+#ifndef set_fixmap
+#define set_fixmap(idx, phys)				\
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NORMAL)
+#endif
+
+#ifndef clear_fixmap
+#define clear_fixmap(idx)			\
+	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
+#endif
+
+/* Return a pointer with offset calculated */
+#define __set_fixmap_offset(idx, phys, flags)		      \
+({							      \
+	unsigned long addr;				      \
+	__set_fixmap(idx, phys, flags);			      \
+	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
+	addr;						      \
+})
+
+#define set_fixmap_offset(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
+
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+#define set_fixmap_offset_nocache(idx, phys) \
+	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NOCACHE)
+
+/*
+ * Some fixmaps are for IO
+ */
+#define set_fixmap_io(idx, phys) \
+	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_GENERIC_FIXMAP_H */
-- 
1.8.3.1
