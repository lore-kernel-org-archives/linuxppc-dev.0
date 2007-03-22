Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	<linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/4] powerpc: Add gcc format warnings to zImage printf()
In-Reply-To: <20070322054812.GA16993@localhost.localdomain>
Message-Id: <20070322055913.CB7A2DDF2A@ozlabs.org>
Date: Thu, 22 Mar 2007 16:59:13 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the correct attributes to the zImage's versions of
printf to make gcc generate format string mismatch warnings.  It also
corrects several minor problems with format strings in the zImage thus
discovered.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/main.c  |    6 +++---
 arch/powerpc/boot/stdio.h |    5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: working-2.6/arch/powerpc/boot/stdio.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/stdio.h	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/boot/stdio.h	2007-03-22 12:35:08.000000000 +1100
@@ -7,11 +7,12 @@
 #define	EINVAL		22	/* Invalid argument */
 #define ENOSPC		28	/* No space left on device */
 
-extern int printf(const char *fmt, ...);
+extern int printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 
 #define fprintf(fmt, args...)	printf(args)
 
-extern int sprintf(char *buf, const char *fmt, ...);
+extern int sprintf(char *buf, const char *fmt, ...)
+	__attribute__((format(printf, 2, 3)));
 
 extern int vsprintf(char *buf, const char *fmt, va_list args);
 
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-22 12:26:06.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-22 12:33:49.000000000 +1100
@@ -136,7 +136,7 @@ static struct addr_range prep_kernel(voi
 	} else {
 		if ((unsigned long)_start < ei.memsize)
 			fatal("Insufficient memory for kernel at address 0!"
-			       " (_start=%lx)\n\r", _start);
+			       " (_start=%p)\n\r", _start);
 	}
 
 	/* Finally, gunzip the kernel */
@@ -145,7 +145,7 @@ static struct addr_range prep_kernel(voi
 	/* discard up to the actual load data */
 	gunzip_discard(&gzstate, ei.elfoffset - sizeof(elfheader));
 	len = gunzip_finish(&gzstate, addr, ei.memsize);
-	printf("done 0x%lx bytes\n\r", len);
+	printf("done 0x%x bytes\n\r", len);
 
 	flush_cache(addr, ei.loadsize);
 
@@ -189,7 +189,7 @@ static struct addr_range prep_initrd(str
 		if (! initrd_addr)
 			fatal("Can't allocate memory for initial "
 			       "ramdisk !\n\r");
-		printf("Relocating initrd 0x%p <- 0x%p (0x%lx bytes)\n\r",
+		printf("Relocating initrd 0x%lx <- 0x%p (0x%lx bytes)\n\r",
 		       initrd_addr, old_addr, initrd_size);
 		memmove((void *)initrd_addr, old_addr, initrd_size);
 	}
