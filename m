From: linas@austin.ibm.com
Date: Thu, 11 Sep 2003 11:28:23 -0500
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] ppc64 kernel 2.6 ide-related patches (trivial)
Message-ID: <20030911112823.A27066@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Im getting complaints that the following patch hasn't made it into
the 2.6 BK trees yet.  They prevent the ide code from compiling.
Could someone apply this?

--linas

--- include/asm-ppc64/io.h.orig	2003-09-11 11:07:07.000000000 -0500
+++ include/asm-ppc64/io.h	2003-09-11 11:08:47.000000000 -0500
@@ -93,7 +93,7 @@ extern void _outsl_ns(volatile u32 *port
 #define inw_p(port)             inw(port)
 #define outw_p(val, port)       (udelay(1), outw((val), (port)))
 #define inl_p(port)             inl(port)
-#define outl_p(val, port)       (udelay(1), outl((val, (port)))
+#define outl_p(val, port)       (udelay(1), outl((val), (port)))

 /*
  * The *_ns versions below don't do byte-swapping.

--- arch/ppc64/kernel/misc.S.orig	2003-09-11 11:13:33.000000000 -0500
+++ arch/ppc64/kernel/misc.S	2003-09-11 11:15:18.000000000 -0500
@@ -359,7 +359,7 @@ _GLOBAL(_outsl)
 	bdnz	00b
 	blr

-_GLOBAL(ide_insw)
+/* _GLOBAL(ide_insw) now in drivers/ide/ide-iops.c */
 _GLOBAL(_insw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -371,7 +371,7 @@ _GLOBAL(_insw_ns)
 	bdnz	00b
 	blr

-_GLOBAL(ide_outsw)
+/* _GLOBAL(ide_outsw) now in drivers/ide/ide-iops.c */
 _GLOBAL(_outsw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
