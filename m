Return-Path: <arjanv@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1DE4679FE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2005 19:56:35 +1000 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4J9uVQV014733
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2005 05:56:31 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com
	[172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4J9uVO05679
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2005 05:56:31 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id
	j4J9uVqG019986
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2005 05:56:31 -0400
Received: (from arjanv@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j4J9uV2n019984
	for linuxppc-dev@ozlabs.org; Thu, 19 May 2005 11:56:31 +0200
Date: Thu, 19 May 2005 11:56:31 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050519095631.GA18966@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: experimental kernel patch for FORTIFY_SOURCE in kernel space
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

There is a gcc patch in development (posted to the patches list several
times now and getting close to done) that allows gcc to track the size of
objects at compile time. The idea is that for code like

void func(char *str)
{
	char buf[20];
	strcpy(buf, str);
}

gcc keeps track of "buf" being 20 bytes in size and then (together with
glibc) cause that strcpy() to be replaced by a special strcpy that gets "20"
as extra parameter and will cause an abort rather than a buffer overflow if
more than 20 bytes get copied.

This works great in Fedora Core 4 for userland (the technology is there in
RHEL4 and FC3 as well but not used for everything), and recently I started
"porting" this to the kernel. 

There is somewhat of an architecture impact so before submitting it on lkml
I'd want to ask feedback from more arches than just x86... 


Greetings,
    Arjan van de Ven



diff -purN linux-2.6.12-rc4/Makefile linux-fortify/Makefile
--- linux-2.6.12-rc4/Makefile	2005-05-14 14:41:18.000000000 +0200
+++ linux-fortify/Makefile	2005-05-15 15:26:33.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION =-rc4
+EXTRAVERSION =-rc4-fortify
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -purN linux-2.6.12-rc4/arch/i386/Kconfig.debug linux-fortify/arch/i386/Kconfig.debug
--- linux-2.6.12-rc4/arch/i386/Kconfig.debug	2005-05-14 14:41:19.000000000 +0200
+++ linux-fortify/arch/i386/Kconfig.debug	2005-05-15 15:26:33.000000000 +0200
@@ -59,6 +59,14 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+config FORTIFY_SOURCE
+	bool "Enable limited buffer overflow checking"
+	help
+	  If you say Y here the kernel will use a recent gcc feature that
+	  allows several key kernel primitives to check for buffer overflows
+	  when dealing with static buffers. Do not enable this feature unless
+	  you have a very recent gcc (version 4.1 or gccs from FC3, FC4, RHEL4) 
+
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -purN linux-2.6.12-rc4/include/asm-i386/string.h linux-fortify/include/asm-i386/string.h
--- linux-2.6.12-rc4/include/asm-i386/string.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/asm-i386/string.h	2005-05-15 17:03:06.000000000 +0200
@@ -23,11 +23,14 @@
  *		consider these trivial functions to be PD.
  */
 
+
 /* AK: in fact I bet it would be better to move this stuff all out of line.
+ * Arjan: .. or just straight use the gcc built-in versions
  */
 
+
 #define __HAVE_ARCH_STRCPY
-static inline char * strcpy(char * dest,const char *src)
+extern inline char * strcpy(char * dest,const char *src)
 {
 int d0, d1, d2;
 __asm__ __volatile__(
@@ -41,7 +44,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRNCPY
-static inline char * strncpy(char * dest,const char *src,size_t count)
+extern inline char * strncpy(char * dest,const char *src,size_t count)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
@@ -60,7 +63,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRCAT
-static inline char * strcat(char * dest,const char * src)
+extern inline char * strcat(char * dest,const char * src)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
@@ -77,7 +80,7 @@ return dest;
 }
 
 #define __HAVE_ARCH_STRNCAT
-static inline char * strncat(char * dest,const char * src,size_t count)
+extern inline char * strncat(char * dest,const char * src,size_t count)
 {
 int d0, d1, d2, d3;
 __asm__ __volatile__(
diff -purN linux-2.6.12-rc4/include/asm-i386/uaccess.h linux-fortify/include/asm-i386/uaccess.h
--- linux-2.6.12-rc4/include/asm-i386/uaccess.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/asm-i386/uaccess.h	2005-05-15 15:26:33.000000000 +0200
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <linux/string.h>
+#include <linux/compiler.h>
 #include <asm/page.h>
 
 #define VERIFY_READ 0
@@ -507,10 +508,6 @@ __copy_from_user(void *to, const void __
        might_sleep();
        return __copy_from_user_inatomic(to, from, n);
 }
-unsigned long __must_check copy_to_user(void __user *to,
-				const void *from, unsigned long n);
-unsigned long __must_check copy_from_user(void *to,
-				const void __user *from, unsigned long n);
 long __must_check strncpy_from_user(char *dst, const char __user *src,
 				long count);
 long __must_check __strncpy_from_user(char *dst,
@@ -536,4 +533,40 @@ long strnlen_user(const char __user *str
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
+
+unsigned long __must_check copy_to_user(void __user *to,
+				const void *from, unsigned long n);
+
+#ifdef CONFIG_FORTIFY_SOURCE
+
+extern void __chk_fail(void);
+
+/* 
+ * the inline function with the check wants to call the non-inlined function
+ * with the same name for the actual work. The easiest way to do this is to make 
+ * an alias of the real function and just call this alias from the inline. 
+ */
+extern int __c_f_u_alias(void *to, const void __user *from, unsigned long __nbytes) __asm__ ("" "copy_from_user");
+
+
+extern unsigned long __always_inline __must_check 
+copy_from_user (void *to, const void __user *from, unsigned long __nbytes)
+{
+	/* 
+ 	 * if we know the size of "to" then we can validate that we don't overrun the buffer.
+	 * note that if __nbytes is known at compiletime this check is nicely optimized out
+         */
+	if (__bos0 (to) != (size_t) -1 && __nbytes > __bos0 (to))
+		__chk_fail();
+	return __c_f_u_alias (to, from, __nbytes);
+}
+
+#else
+
+unsigned long __must_check copy_to_user(void __user *to,
+				const void *from, unsigned long n);
+
+#endif
+
+
 #endif /* __i386_UACCESS_H */
diff -purN linux-2.6.12-rc4/include/linux/compiler-gcc3.h linux-fortify/include/linux/compiler-gcc3.h
--- linux-2.6.12-rc4/include/linux/compiler-gcc3.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/linux/compiler-gcc3.h	2005-05-15 15:26:33.000000000 +0200
@@ -30,3 +30,8 @@
 #define __must_check		__attribute__((warn_unused_result))
 #endif
 
+
+#if  defined(__GNUC_RH_RELEASE__) && __GNUC_MINOR__ >= 4 && __GNUC_PATCHLEVEL__ >=2 
+#define __bos(ptr) __builtin_object_size (ptr, 1)
+#define __bos0(ptr) __builtin_object_size (ptr, 0)
+#endif
diff -purN linux-2.6.12-rc4/include/linux/compiler-gcc4.h linux-fortify/include/linux/compiler-gcc4.h
--- linux-2.6.12-rc4/include/linux/compiler-gcc4.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/linux/compiler-gcc4.h	2005-05-15 15:26:33.000000000 +0200
@@ -14,3 +14,7 @@
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
+#if defined(__GNUC_RH_RELEASE__) || __GNUC_MINOR__ >= 1
+#define __bos(ptr) __builtin_object_size (ptr, 1)
+#define __bos0(ptr) __builtin_object_size (ptr, 0)
+#endif
diff -purN linux-2.6.12-rc4/include/linux/compiler.h linux-fortify/include/linux/compiler.h
--- linux-2.6.12-rc4/include/linux/compiler.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/linux/compiler.h	2005-05-15 15:26:33.000000000 +0200
@@ -155,4 +155,13 @@ extern void __chk_io_ptr(void __iomem *)
 #define __always_inline inline
 #endif
 
+#ifndef __bos
+#define __bos(x) -1
+#endif
+
+#ifndef __bos0
+#define __bos0(x) -1
+#endif
+
+
 #endif /* __LINUX_COMPILER_H */
diff -purN linux-2.6.12-rc4/include/linux/slab.h linux-fortify/include/linux/slab.h
--- linux-2.6.12-rc4/include/linux/slab.h	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/include/linux/slab.h	2005-05-15 15:26:33.000000000 +0200
@@ -73,9 +73,9 @@ struct cache_sizes {
 	kmem_cache_t	*cs_dmacachep;
 };
 extern struct cache_sizes malloc_sizes[];
-extern void *__kmalloc(size_t, unsigned int __nocast);
+extern __attribute__((malloc)) void *__kmalloc(size_t, unsigned int __nocast); 
 
-static inline void *kmalloc(size_t size, unsigned int __nocast flags)
+static inline __attribute__((malloc)) void *kmalloc(size_t size, unsigned int __nocast flags) 
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
diff -purN linux-2.6.12-rc4/include/linux/string.h linux-fortify/include/linux/string.h
--- linux-2.6.12-rc4/include/linux/string.h	2005-03-02 08:38:07.000000000 +0100
+++ linux-fortify/include/linux/string.h	2005-05-15 17:12:16.000000000 +0200
@@ -88,6 +88,96 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+
+#ifdef CONFIG_FORTIFY_SOURCE
+
+/*
+ * "fortified" variants of some of these functions that for certain cases make
+ * gcc emit code that checks for buffer overflows.
+ */
+
+#undef strcpy
+#undef __HAVE_ARCH_STRCPY
+#define strcpy(dest, src) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strcpy_chk (dest, src, __bos (dest))                   \
+   : __strcpy_ichk (dest, src))
+static __always_inline char *
+__strcpy_ichk (char * __dest, const char * __src)
+{
+  return __builtin___strcpy_chk (__dest, __src, __bos (__dest));
+}
+
+#undef strncpy
+#undef __HAVE_ARCH_STRNCPY
+#define strncpy(dest, src, len) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strncpy_chk (dest, src, len, __bos (dest))             \
+   : __strncpy_ichk (dest, src, len))
+static __always_inline char *
+__strncpy_ichk (char * __dest, const char * __src, size_t __len)
+{
+  return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
+}
+
+#undef strcat
+#undef __HAVE_ARCH_STRCAT
+#define strcat(dest, src) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strcat_chk (dest, src, __bos (dest))                   \
+   : __strcat_ichk (dest, src))
+static __always_inline char *
+__strcat_ichk (char * __dest, const char * __src)
+{
+  return __builtin___strcat_chk (__dest, __src, __bos (__dest));
+}
+
+#undef strncat
+#undef __HAVE_ARCH_STRNCAT
+#define strncat(dest, src, len) \
+  ((__bos (dest) != (size_t) -1)                                        \
+   ? __builtin___strncat_chk (dest, src, len, __bos (dest))             \
+   : __strncat_ichk (dest, src, len))
+static __always_inline char *
+__strncat_ichk (char * __dest, const char * __src, size_t __len)
+{
+  return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
+}
+
+#undef memcpy
+#define memcpy(dest, src, len) \
+  ((__bos0 (dest) != (size_t) -1)                                       \
+   ? __builtin___memcpy_chk (dest, src, len, __bos0 (dest))             \
+   : __memcpy_ichk (dest, src, len))
+static __always_inline void *
+__memcpy_ichk (void * __dest, const void *__src, size_t __len)
+{
+  return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
+}
+
+/* memset(x,y,0) is a common typo; this dummy non-existent function is
+ * there to create a linker error in that case
+ */
+extern void __warn_memset_zero_len(void);
+
+#undef memset
+#define memset(dest, ch, len) \
+  (__builtin_constant_p (len) && (len) == 0 && (!__builtin_constant_p(ch) || ((ch)!=0)) \
+   ? (__warn_memset_zero_len (), (void) (ch), (void) (len), (void *) (dest))  \
+   : ((__bos0 (dest) != (size_t) -1)                                          \
+      ? __builtin___memset_chk (dest, ch, len, __bos0 (dest))                 \
+      : __memset_ichk (dest, ch, len)))
+
+static __always_inline void *
+__memset_ichk (void *__dest, int __ch, size_t __len)
+{
+  return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest));
+}
+
+
+#endif
+
+
 #ifdef __cplusplus
 }
 #endif
diff -purN linux-2.6.12-rc4/lib/Makefile linux-fortify/lib/Makefile
--- linux-2.6.12-rc4/lib/Makefile	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/lib/Makefile	2005-05-15 15:26:33.000000000 +0200
@@ -18,6 +18,7 @@ endif
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
+lib-$(CONFIG_FORTIFY_SOURCE) += fortify.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
diff -purN linux-2.6.12-rc4/lib/fortify.c linux-fortify/lib/fortify.c
--- linux-2.6.12-rc4/lib/fortify.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-fortify/lib/fortify.c	2005-05-15 16:29:15.000000000 +0200
@@ -0,0 +1,292 @@
+/*
+ * Copyright (C) 1991, 1997, 2003, 2004 Free Software Foundation, Inc.
+ * Portions Copyright (C) 2005 Red Hat, Inc.
+ * Portions Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ * (Several of these functions were copied from various FSF projects)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/module.h>
+
+
+void __chk_fail(void) 
+{
+	printk("** kernel buffer overflow detected via application %s ***\n", current->comm);
+	panic("Aborting!\n");
+}
+EXPORT_SYMBOL_GPL(__chk_fail);
+
+void * __memcpy_chk (void *dstpp, const void* srcpp, size_t len, size_t dstlen)
+{
+	char *d = (char *) dstpp, *s = (char *) srcpp;
+
+	if (unlikely(dstlen < len))
+		__chk_fail ();
+
+        while (len--)
+                *d++ = *s++;
+
+        return d;
+}
+
+EXPORT_SYMBOL_GPL(__memcpy_chk);
+
+void * __memset_chk (void *dst, const int c, size_t len, size_t dstlen)
+{
+	char *d = (char *) dst;
+
+	if (unlikely(dstlen < len))
+		__chk_fail ();
+
+        while (len--)
+                *d++ = c;
+
+        return d;
+}
+
+EXPORT_SYMBOL_GPL(__memset_chk);
+
+/* Copy SRC to DEST with checking of destination buffer overflow.  */
+char * __strcpy_chk (char *dest, const char *src, size_t destlen)
+{
+  char c;
+  char *s = (char *) src;
+  const ptrdiff_t off = dest - s;
+
+  while (__builtin_expect (destlen >= 4, 0))
+    {
+      c = s[0];
+      s[off] = c;
+      if (c == '\0')
+        return dest;
+      c = s[1];
+      s[off + 1] = c;
+      if (c == '\0')
+        return dest;
+      c = s[2];
+      s[off + 2] = c;
+      if (c == '\0')
+        return dest;
+      c = s[3];
+      s[off + 3] = c;
+      if (c == '\0')
+        return dest;
+      destlen -= 4;
+      s += 4;
+    }
+
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s;
+      *(s++ + off) = c;
+    }
+  while (c != '\0');
+
+  return dest;
+}
+
+EXPORT_SYMBOL_GPL(__strcpy_chk);
+
+
+char * __strcat_chk (char *dest, const char *src, size_t destlen)
+{
+  char *s1 = dest;
+  const char *s2 = src;
+  char c;
+
+  /* Find the end of the string.  */
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s1++;
+    }
+  while (c != '\0');
+
+  /* Make S1 point before the next character, so we can increment
+     it while memory is read (wins on pipelined cpus).  */
+  ++destlen;
+  s1 -= 2;
+
+  do
+    {
+      if (__builtin_expect (destlen-- == 0, 0))
+        __chk_fail ();
+      c = *s2++;
+      *++s1 = c;
+    }
+  while (c != '\0');
+
+  return dest;
+}
+
+EXPORT_SYMBOL_GPL(__strcat_chk);
+
+char * __strncat_chk (char *s1, const char *s2, size_t n, size_t s1len)
+{
+  char c;
+  char *s = s1;
+
+  /* Find the end of S1.  */
+  do
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      c = *s1++;
+    }
+  while (c != '\0');
+
+  /* Make S1 point before next character, so we can increment
+     it while memory is read (wins on pipelined cpus).  */
+  ++s1len;
+  s1 -= 2;
+
+  if (n >= 4)
+    {
+      size_t n4 = n >> 2;
+      do
+	{
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	  if (__builtin_expect (s1len-- == 0, 0))
+	    __chk_fail ();
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    return s;
+	} while (--n4 > 0);
+      n &= 3;
+    }
+
+  while (n > 0)
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      c = *s2++;
+      *++s1 = c;
+      if (c == '\0')
+	return s;
+      n--;
+    }
+
+  if (c != '\0')
+    {
+      if (__builtin_expect (s1len-- == 0, 0))
+	__chk_fail ();
+      *++s1 = '\0';
+    }
+
+  return s;
+}
+
+EXPORT_SYMBOL_GPL(__strncat_chk);
+
+
+char * __strncpy_chk (char *s1, const char *s2, size_t n, size_t s1len)
+{
+  char c;
+  char *s = s1;
+
+  if (__builtin_expect (s1len < n, 0))
+    __chk_fail ();
+
+  --s1;
+
+  if (n >= 4)
+    {
+      size_t n4 = n >> 2;
+
+      for (;;)
+	{
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  c = *s2++;
+	  *++s1 = c;
+	  if (c == '\0')
+	    break;
+	  if (--n4 == 0)
+	    goto last_chars;
+	}
+      n = n - (s1 - s) - 1;
+      if (n == 0)
+	return s;
+      goto zero_fill;
+    }
+
+ last_chars:
+  n &= 3;
+  if (n == 0)
+    return s;
+
+  do
+    {
+      c = *s2++;
+      *++s1 = c;
+      if (--n == 0)
+	return s;
+    }
+  while (c != '\0');
+
+ zero_fill:
+  do
+    *++s1 = '\0';
+  while (--n > 0);
+
+  return s;
+}
+
+EXPORT_SYMBOL_GPL(__strncpy_chk);
+
+
+void dummy(int n)
+{	
+	char buf1[20];
+	char buf2[30];
+	memcpy(buf1, buf2, 30);
+	memcpy(buf1, buf2, n);
+}
diff -purN linux-2.6.12-rc4/lib/string.c linux-fortify/lib/string.c
--- linux-2.6.12-rc4/lib/string.c	2005-05-14 14:41:21.000000000 +0200
+++ linux-fortify/lib/string.c	2005-05-15 16:46:05.000000000 +0200
@@ -91,6 +91,7 @@ EXPORT_SYMBOL(strcpy);
  * count, the remainder of @dest will be padded with %NUL.
  *
  */
+#undef strncpy
 char * strncpy(char * dest,const char *src,size_t count)
 {
 	char *tmp = dest;
@@ -162,6 +163,7 @@ EXPORT_SYMBOL(strcat);
  * Note that in contrast to strncpy, strncat ensures the result is
  * terminated.
  */
+#undef strncat
 char * strncat(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
@@ -449,6 +451,7 @@ EXPORT_SYMBOL(strsep);
  *
  * Do not use memset() to access IO space, use memset_io() instead.
  */
+#undef memset
 void * memset(void * s,int c,size_t count)
 {
 	char *xs = (char *) s;
@@ -471,6 +474,7 @@ EXPORT_SYMBOL(memset);
  * You should not use this function to access IO space, use memcpy_toio()
  * or memcpy_fromio() instead.
  */
+#undef memcpy
 void * memcpy(void * dest,const void *src,size_t count)
 {
 	char *tmp = (char *) dest, *s = (char *) src;
