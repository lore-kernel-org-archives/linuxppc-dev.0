Date: Tue, 25 May 2004 02:28:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 4/7] fix include wrapper
Message-ID: <Pine.LNX.4.58.0405250228140.19031@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Outside the include protection must only be comments, so that
cpp can optimize the header scan.

Index: 2.6/include/asm-ppc/current.h
diff -u 2.6/include/asm-ppc/current.h:1.1.1.1 2.6/include/asm-ppc/current.h:1.2
--- 2.6/include/asm-ppc/current.h:1.1.1.1	Sat Jan 31 15:43:32 2004
+++ 2.6/include/asm-ppc/current.h	Wed Feb  4 13:21:36 2004
@@ -1,11 +1,11 @@
-#ifdef __KERNEL__
 #ifndef _PPC_CURRENT_H
 #define _PPC_CURRENT_H
+#ifdef __KERNEL__

 /*
  * We keep `current' in r2 for speed.
  */
 register struct task_struct *current asm ("r2");

-#endif /* !(_PPC_CURRENT_H) */
 #endif /* __KERNEL__ */
+#endif /* !(_PPC_CURRENT_H) */
Index: 2.6/include/asm-ppc/io.h
diff -u 2.6/include/asm-ppc/io.h:1.1.1.3 2.6/include/asm-ppc/io.h:1.5
--- 2.6/include/asm-ppc/io.h:1.1.1.3	Sun May 23 15:31:13 2004
+++ 2.6/include/asm-ppc/io.h	Mon May 24 13:32:36 2004
@@ -1,6 +1,6 @@
-#ifdef __KERNEL__
 #ifndef _PPC_IO_H
 #define _PPC_IO_H
+#ifdef __KERNEL__

 #include <linux/config.h>
 #include <linux/types.h>
@@ -426,5 +433,5 @@
 #define consistent_sync_page(pg, off, sz, rw)	do { } while (0)

 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
-#endif /* _PPC_IO_H */
 #endif /* __KERNEL__ */
+#endif /* _PPC_IO_H */

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
