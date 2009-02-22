Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GG12006@kryten>
Message-Id: <20090222115332.404685001@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:03 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 06/10] powerpc: Randomise lower bits of stack address
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randomise the lower bits of the stack address. More randomisation is good for
security but the scatter can also help with SMT threads that share an L1. A
quick test case shows this working:

int main()
{
	int sp;
	printf("%x\n", (unsigned long)&sp & 4095);
}

before:
80
80
80
80
80

after:
610
490
300
6b0
d80

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/include/asm/system.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/system.h	2009-02-20 13:39:05.000000000 +1100
+++ linux-2.6/arch/powerpc/include/asm/system.h	2009-02-20 13:51:39.000000000 +1100
@@ -531,7 +531,7 @@
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
-#define arch_align_stack(x) (x)
+extern unsigned long arch_align_stack(unsigned long sp);
 
 /* Used in very early kernel initialization. */
 extern unsigned long reloc_offset(void);
Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2009-02-20 13:39:05.000000000 +1100
+++ linux-2.6/arch/powerpc/kernel/process.c	2009-02-20 13:51:39.000000000 +1100
@@ -34,6 +34,8 @@
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
 #include <linux/kernel_stat.h>
+#include <linux/personality.h>
+#include <linux/random.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -1122,3 +1124,10 @@
 }
 
 #endif /* THREAD_SHIFT < PAGE_SHIFT */
+
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_int() & ~PAGE_MASK;
+	return sp & ~0xf;
+}

-- 
