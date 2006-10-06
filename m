Return-Path: <SRS0+76111bb9e974a2920ddb+1139+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E1C267EB8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2006 01:23:52 +1000 (EST)
Subject: vsdo_datapage.h WTF?
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org, paulus@samba.org
Content-Type: text/plain
Date: Fri, 06 Oct 2006 16:23:28 +0100
Message-Id: <1160148208.4795.30.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If vdso_datapage.h is supposed to be useful to userspace, then we need
to export it.

And if it's supposed to be useful to userspace, then it needs not to
have arrays which vary in size with __NR_syscalls, which is something
that seems to get changed in _every_ kernel release.

And the 32-bit version wants a version number too, surely? And what
happens to 32-bit processes running on a 64-bit kernel? What do _they_
see?

diff --git a/include/asm-powerpc/Kbuild b/include/asm-powerpc/Kbuild
index 9827849..c89c92e 100644
--- a/include/asm-powerpc/Kbuild
+++ b/include/asm-powerpc/Kbuild
@@ -39,3 +39,4 @@ unifdef-y += signal.h
 unifdef-y += termios.h
 unifdef-y += types.h
 unifdef-y += unistd.h
+unifdef-y += vdso_datapage.h
diff --git a/include/asm-powerpc/vdso_datapage.h b/include/asm-powerpc/vdso_datapage.h
index 8a94f0e..4f2208d 100644
--- a/include/asm-powerpc/vdso_datapage.h
+++ b/include/asm-powerpc/vdso_datapage.h
@@ -1,10 +1,8 @@
 #ifndef _VDSO_DATAPAGE_H
 #define _VDSO_DATAPAGE_H
-#ifdef __KERNEL__
-
 /*
  * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
- * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * Copyright (C) 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
  * 		      IBM Corp.
  *
  * This program is free software; you can redistribute it and/or
@@ -38,15 +36,18 @@ #define SYSTEMCFG_MINOR 1
 
 #ifndef __ASSEMBLY__
 
+#ifdef __KERNEL__
 #include <linux/unistd.h>
 
 #define SYSCALL_MAP_SIZE      ((__NR_syscalls + 31) / 32)
+#endif
 
 /*
  * So here is the ppc64 backward compatible version
  */
 
-#ifdef CONFIG_PPC64
+/* Must work in userspace so use __powerpc64__ not CONFIG_PPC64 */
+#ifdef __powerpc64__
 
 struct vdso_data {
 	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
@@ -56,7 +57,7 @@ struct vdso_data {
 	} version;
 
 	/* Note about the platform flags: it now only contains the lpar
-	 * bit. The actual platform number is dead and burried
+	 * bit. The actual platform number is dead and buried
 	 */
 	__u32 platform;			/* Platform flags		0x18 */
 	__u32 processor;		/* Processor type		0x1C */
@@ -79,11 +80,17 @@ struct vdso_data {
 	 */
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
+#ifndef __KERNEL__
+	/* These fields are totally broken, since SYSCALL_MAP_SIZE is going to
+	   change _frequently_ so the ABI will keep changing. And we don't even
+	   make __NR_syscalls available elsewhere so that userspace can cope.
+	   So let's hide these from userspace entirely, since they cannot be used... */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+#endif
 };
 
-#else /* CONFIG_PPC64 */
+#else /* __powerpc64__ */
 
 /*
  * And here is the simpler 32 bits version
@@ -98,10 +105,12 @@ struct vdso_data {
 	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
+#ifndef __KERNEL__ /* See rant above */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+#endif
 };
 
-#endif /* CONFIG_PPC64 */
+#endif /* __powerpc64__  */
 
 #ifdef __KERNEL__
 extern struct vdso_data *vdso_data;
@@ -109,5 +118,4 @@ #endif
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
 #endif /* _SYSTEMCFG_H */


-- 
dwmw2
