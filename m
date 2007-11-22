Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id AFFEFDE345
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:44 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:43 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/10] powerpc: Implement crash dump support on ppc32
Message-ID: <20071122154643.GA26544@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement /dev/oldmem and /proc/vmcore support for ppc32.
It is used to provide crash dumps of the previously running kernel.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/kernel/crash_dump.c |   67 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/kexec.h      |   62 +++++++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 77c0376..39a3d92 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -13,6 +13,7 @@
 
 #include <linux/crash_dump.h>
 #include <linux/bootmem.h>
+#include <linux/highmem.h>
 #include <asm/kdump.h>
 #include <asm/lmb.h>
 #include <asm/firmware.h>
@@ -83,6 +84,7 @@ static int __init parse_savemaxmem(char *p)
 }
 __setup("savemaxmem=", parse_savemaxmem);
 
+#ifdef CONFIG_PPC64
 /**
  * copy_oldmem_page - copy one page from "oldmem"
  * @pfn: page frame number to be copied
@@ -117,3 +119,68 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	iounmap(vaddr);
 	return csize;
 }
+
+#else	/* CONFIG_PPC64 */
+
+static void *kdump_buf_page;
+
+/**
+ * copy_oldmem_page - copy one page from "oldmem"
+ * @pfn: page frame number to be copied
+ * @buf: target memory address for the copy; this can be in kernel address
+ *	space or user address space (see @userbuf)
+ * @csize: number of bytes to copy
+ * @offset: offset in bytes into the page (based on pfn) to begin the copy
+ * @userbuf: if set, @buf is in user address space, use copy_to_user(),
+ *	otherwise @buf is in kernel address space, use memcpy().
+ *
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel.
+ *
+ * Calling copy_to_user() in atomic context is not desirable. Hence first
+ * copying the data to a pre-allocated kernel page and then copying to user
+ * space in non-atomic context.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+                               size_t csize, unsigned long offset, int userbuf)
+{
+	void  *vaddr;
+
+	if (!csize)
+		return 0;
+
+	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+
+	if (!userbuf) {
+		memcpy(buf, (vaddr + offset), csize);
+		kunmap_atomic(vaddr, KM_PTE0);
+	} else {
+		if (!kdump_buf_page) {
+			printk(KERN_WARNING "Kdump: Kdump buffer page not"
+				" allocated\n");
+			return -EFAULT;
+		}
+		copy_page(kdump_buf_page, vaddr);
+		kunmap_atomic(vaddr, KM_PTE0);
+		if (copy_to_user(buf, (kdump_buf_page + offset), csize))
+			return -EFAULT;
+	}
+
+	return csize;
+}
+
+static int __init kdump_buf_page_init(void)
+{
+	int ret = 0;
+
+	kdump_buf_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kdump_buf_page) {
+		printk(KERN_WARNING "Kdump: Failed to allocate kdump buffer"
+			 " page\n");
+		ret = -ENOMEM;
+	}
+
+	return ret;
+}
+arch_initcall(kdump_buf_page_init);
+#endif	/* CONFIG_PPC64 */
diff --git a/include/asm-powerpc/kexec.h b/include/asm-powerpc/kexec.h
index b6f817b..8c213c0 100644
--- a/include/asm-powerpc/kexec.h
+++ b/include/asm-powerpc/kexec.h
@@ -101,11 +101,67 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 #else
 /*
- * Provide a dummy definition to avoid build failures. Will remain
- * empty till crash dump support is enabled.
+ * This function is responsible for capturing register states if coming
+ * via panic or invoking dump using sysrq-trigger.
  */
 static inline void crash_setup_regs(struct pt_regs *newregs,
-					struct pt_regs *oldregs) { }
+					struct pt_regs *oldregs)
+{
+	if (oldregs)
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	else {
+		/* FIXME Merge this with xmon_save_regs ?? */
+		unsigned long tmp1, tmp2;
+		__asm__ __volatile__ (
+			"stw    0,0(%2)\n"
+			"stw    1,4(%2)\n"
+			"stw    2,8(%2)\n"
+			"stw    3,12(%2)\n"
+			"stw    4,16(%2)\n"
+			"stw    5,20(%2)\n"
+			"stw    6,24(%2)\n"
+			"stw    7,28(%2)\n"
+			"stw    8,32(%2)\n"
+			"stw    9,36(%2)\n"
+			"stw    10,40(%2)\n"
+			"stw    11,44(%2)\n"
+			"stw    12,48(%2)\n"
+			"stw    13,52(%2)\n"
+			"stw    14,56(%2)\n"
+			"stw    15,60(%2)\n"
+			"stw    16,64(%2)\n"
+			"stw    17,68(%2)\n"
+			"stw    18,72(%2)\n"
+			"stw    19,76(%2)\n"
+			"stw    20,80(%2)\n"
+			"stw    21,84(%2)\n"
+			"stw    22,88(%2)\n"
+			"stw    23,92(%2)\n"
+			"stw    24,96(%2)\n"
+			"stw    25,100(%2)\n"
+			"stw    26,104(%2)\n"
+			"stw    27,108(%2)\n"
+			"stw    28,112(%2)\n"
+			"stw    29,116(%2)\n"
+			"stw    30,120(%2)\n"
+			"stw    31,124(%2)\n"
+			"mfmsr  %0\n"
+			"stw    %0,132(%2)\n"
+			"mfctr  %0\n"
+			"stw    %0,140(%2)\n"
+			"mflr   %0\n"
+			"stw    %0,144(%2)\n"
+			"bl     1f\n"
+		"1:     mflr   %1\n"
+			"stw    %1,128(%2)\n"
+			"mtlr   %0\n"
+			"mfxer  %0\n"
+			"stw    %0,148(%2)\n"
+			: "=&r" (tmp1), "=&r" (tmp2)
+			: "b" (newregs)
+			: "memory");
+	}
+}
 #endif /* !__powerpc64 __ */
 
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
-- 
1.5.3.4
