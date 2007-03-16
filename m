Return-Path: <dgibson@ozlabs.org>
Date: Fri, 16 Mar 2007 14:47:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Add gcc format warnings to zImage printf()
Message-ID: <20070316034751.GC12325@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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
Paulus, please apply, and save us from brown-paper-bag bugs like
mine with the earlier version of the no sp parameter to start() patch.

Index: working-2.6/arch/powerpc/boot/stdio.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/stdio.h	2007-03-15 16:13:19.000000000 +1100
+++ working-2.6/arch/powerpc/boot/stdio.h	2007-03-15 16:14:40.000000000 +1100
@@ -7,11 +7,11 @@
 #define	EINVAL		22	/* Invalid argument */
 #define ENOSPC		28	/* No space left on device */
 
-extern int printf(const char *fmt, ...);
+extern int printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
 
 #define fprintf(fmt, args...)	printf(args)
 
-extern int sprintf(char *buf, const char *fmt, ...);
+extern int sprintf(char *buf, const char *fmt, ...) __attribute__((format(printf, 2, 3)));
 
 extern int vsprintf(char *buf, const char *fmt, va_list args);
 
Index: working-2.6/arch/powerpc/boot/main.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/main.c	2007-03-15 16:16:06.000000000 +1100
+++ working-2.6/arch/powerpc/boot/main.c	2007-03-15 16:16:48.000000000 +1100
@@ -139,7 +139,7 @@ static struct addr_range prep_kernel(voi
 	} else {
 		if ((unsigned long)_start < ei.memsize) {
 			printf("Insufficient memory for kernel at address 0!"
-			       " (_start=%lx)\n\r", _start);
+			       " (_start=%p)\n\r", _start);
 			exit();
 		}
 	}
@@ -150,7 +150,7 @@ static struct addr_range prep_kernel(voi
 	/* discard up to the actual load data */
 	gunzip_discard(&gzstate, ei.elfoffset - sizeof(elfheader));
 	len = gunzip_finish(&gzstate, addr, ei.memsize);
-	printf("done 0x%lx bytes\n\r", len);
+	printf("done 0x%x bytes\n\r", len);
 
 	flush_cache(addr, ei.loadsize);
 
@@ -196,7 +196,7 @@ static struct addr_range prep_initrd(str
 			       "ramdisk !\n\r");
 			exit();
 		}
-		printf("Relocating initrd 0x%p <- 0x%p (0x%lx bytes)\n\r",
+		printf("Relocating initrd 0x%lx <- 0x%p (0x%lx bytes)\n\r",
 		       initrd_addr, old_addr, initrd_size);
 		memmove((void *)initrd_addr, old_addr, initrd_size);
 	}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
