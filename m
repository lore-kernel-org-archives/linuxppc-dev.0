Return-Path: <SRS0+7112437059cd471be2ea+638+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFC04679E2
	for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2005 19:00:36 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20050519095631.GA18966@devserv.devel.redhat.com>
References: <20050519095631.GA18966@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 23 May 2005 09:57:14 +0100
Message-Id: <1116838635.19183.142.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: experimental kernel patch for FORTIFY_SOURCE in kernel space
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-19 at 11:56 +0200, Arjan van de Ven wrote:
> There is somewhat of an architecture impact so before submitting it on
> lkml I'd want to ask feedback from more arches than just x86... 

As discussed in IRC: Put the config option in lib/Kconfig.debug instead
of in arch/i386, and we need to do something about the string functions.
I just made the versions in lib/string.c weak; I doubt that's the best
answer.

Seems to work for me on PPC. Would certainly be nice to make it know
about kmalloc() though. I also made __chk_fail use BUG() instead of
panic().

--- linux-2.6.11/arch/i386/Kconfig.debug.fortifyppc	2005-05-19 13:18:08.000000000 +0100
+++ linux-2.6.11/arch/i386/Kconfig.debug	2005-05-19 13:18:24.000000000 +0100
@@ -59,14 +59,6 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
-config FORTIFY_SOURCE
-	bool "Enable limited buffer overflow checking"
-	help
-	  If you say Y here the kernel will use a recent gcc feature that
-	  allows several key kernel primitives to check for buffer overflows
-	  when dealing with static buffers. Do not enable this feature unless
-	  you have a very recent gcc (version 4.1 or gccs from FC3, FC4, RHEL4) 
-
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
--- linux-2.6.11/include/asm-ppc/uaccess.h.fortifyppc	2005-05-19 12:09:40.000000000 +0100
+++ linux-2.6.11/include/asm-ppc/uaccess.h	2005-05-19 13:14:18.000000000 +0100
@@ -330,8 +330,18 @@ copy_to_user(void __user *to, const void
 	return n;
 }
 
+extern void __chk_fail(void);
+
 static inline unsigned long __copy_from_user(void *to, const void __user *from, unsigned long size)
 {
+#ifdef CONFIG_FORTIFY_SOURCE
+	/* 
+	 * if we know the size of "to" then we can validate that we don't overrun the buffer.
+	 * note that if __nbytes is known at compiletime this check is nicely optimized out
+         */
+	if (__bos0 (to) != (size_t) -1 && size > __bos0 (to))
+		__chk_fail();
+#endif
 	return __copy_tofrom_user((__force void __user *)to, from, size);
 }
 
--- linux-2.6.11/lib/fortify.c.fortifyppc	2005-05-19 13:18:56.000000000 +0100
+++ linux-2.6.11/lib/fortify.c	2005-05-19 12:22:22.000000000 +0100
@@ -29,7 +29,7 @@
 void __chk_fail(void) 
 {
 	printk("** kernel buffer overflow detected via application %s ***\n", current->comm);
-	panic("Aborting!\n");
+	BUG();
 }
 EXPORT_SYMBOL_GPL(__chk_fail);
 
--- linux-2.6.11/lib/Kconfig.debug.fortifyppc	2005-05-19 13:17:36.000000000 +0100
+++ linux-2.6.11/lib/Kconfig.debug	2005-05-19 13:11:33.000000000 +0100
@@ -168,6 +168,16 @@ config DEBUG_FS
 
 	  If unsure, say N.
 
+config FORTIFY_SOURCE
+	bool "Enable limited buffer overflow checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here the kernel will use a recent gcc feature that
+	  allows several key kernel primitives to check for buffer overflows
+	  when dealing with static buffers. Do not enable this feature unless
+	  you have a very recent gcc (version 4.1 or gccs from FC3, FC4, RHEL4)
+
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU || FRV)
--- linux-2.6.11/lib/string.c.fortifyppc	2005-05-19 12:06:49.000000000 +0100
+++ linux-2.6.11/lib/string.c	2005-05-23 09:51:27.000000000 +0100
@@ -66,7 +66,7 @@ EXPORT_SYMBOL(strnicmp);
  * @src: Where to copy the string from
  */
 #undef strcpy
-char * strcpy(char * dest,const char *src)
+char *  __attribute__((weak)) strcpy(char * dest,const char *src)
 {
 	char *tmp = dest;
 
@@ -92,7 +92,7 @@ EXPORT_SYMBOL(strcpy);
  *
  */
 #undef strncpy
-char * strncpy(char * dest,const char *src,size_t count)
+char * __attribute__((weak)) strncpy(char * dest,const char *src,size_t count)
 {
 	char *tmp = dest;
 
@@ -139,7 +139,7 @@ EXPORT_SYMBOL(strlcpy);
  * @src: The string to append to it
  */
 #undef strcat
-char * strcat(char * dest, const char * src)
+char * __attribute__((weak)) strcat(char * dest, const char * src)
 {
 	char *tmp = dest;
 
@@ -164,7 +164,7 @@ EXPORT_SYMBOL(strcat);
  * terminated.
  */
 #undef strncat
-char * strncat(char *dest, const char *src, size_t count)
+char * __attribute__((weak)) strncat(char *dest, const char *src, size_t count)
 {
 	char *tmp = dest;
 

-- 
dwmw2
