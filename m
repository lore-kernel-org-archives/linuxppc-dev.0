Date: Sun, 12 Mar 2000 20:12:08 -0500
From: Daniel Jacobowitz <drow@false.org>
To: cort@hq.fsmlabs.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Quik 2.0e patches and issues
Message-ID: <20000312201207.A4674@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Well, I finally got quik 2.0* to work on my hardware (7300, Oldworld power
macintosh) again.  It required a couple of patches which I'm not quite sure
about, so I wanted to get your opinion on them.

In order:

 - The first chunk is to deal with the type of dev_t.  I'm not entirely sure
why it is necessary, but it most definitely is.  Otherwise PART always comes
out as zero.

 - The second is the really important part, and I'm really confused as to
why it was necessary.  Without -N, the data section gets thoroughly trashed.
This leads to e2fslibs returning an error code because the magic field of
the struct_linux_manager is clobbered, as is the value in linux_io_manager.
protect[] does not seem to help.  My guess is the lack of page-aligning the
data segment made the difference.  Why did you decide to remove -N?

 - The two adds of a __KERNEL__ are a workaround for a bug with the altivec
types in 2.2's headers - it should be fixed there rather than in quik, and
I'll send you a patch for that later this week when I go through my kernel
tree.  I have a matching accumulation of little fixes for there.

 - The boot logic. I don't understand how start += entry can ever be right;
shouldn't it be start = entry?  I don't remember why I had start = load_loc
in my tree, but it seems to work; I suspect that isn't right either.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quik.diff"

diff -ur quik-2.0e/quik/quik.c quik-work/quik/quik.c
--- quik-2.0e/quik/quik.c	Fri Mar 10 15:59:28 2000
+++ quik-work/quik/quik.c	Sun Mar 12 14:31:22 2000
@@ -55,8 +55,8 @@

 int unit_shift;
 int part_mask;
-#define UNIT(dev)	(MINOR(dev) >> unit_shift)
-#define PART(dev)	(MINOR(dev) & part_mask)
+#define UNIT(dev)	(((int)MINOR(dev)) >> unit_shift)
+#define PART(dev)	(((int)MINOR(dev)) &  part_mask)

 #define swab_32(x)	((((x) >> 24) & 0xff) + (((x) >> 8) & 0xff00) \
 			 + (((x) & 0xff00) << 8) + (((x) & 0xff) << 24))
diff -ur quik-2.0e/second/Makefile quik-work/second/Makefile
--- quik-2.0e/second/Makefile	Fri Mar 10 15:59:28 2000
+++ quik-work/second/Makefile	Sun Mar 12 14:35:29 2000
@@ -4,7 +4,7 @@

 CFLAGS = -I../include -O2 -D__NO_STRING_INLINES

-LDFLAGS= -Ttext 0x3e0000
+LDFLAGS=-N -Ttext 0x3e0000

 OBJS =	crt0.o printf.o malloc.o main.o cmdline.o disk.o file.o \
 	cfg.o strtol.o prom.o cache.o string.o setjmp.o ctype.o \
diff -ur quik-2.0e/second/main.c quik-work/second/main.c
--- quik-2.0e/second/main.c	Fri Mar 10 15:59:28 2000
+++ quik-work/second/main.c	Sun Mar 12 14:42:46 2000
@@ -29,6 +29,7 @@

 #include "quik.h"
 #include <string.h>
+#define __KERNEL__
 #include <linux/elf.h>
 #include <layout.h>
 #ifdef BOOTINFO
@@ -497,10 +501,17 @@
      * point may actually be a procedure descriptor.
      */
     start = *(unsigned *)entry;
-    if (start < load_loc || start >= load_loc + len
-	|| ((unsigned *)entry)[2] != 0)
-	/* doesn't look like a procedure descriptor */
-	start += entry;
+    /* new boot strategy - see head.S in the kernel for more info -- Cort */
+    if (start == 0x60000000/* nop */ )
+	    start = load_loc;
+    /* not the new boot strategy, use old logic -- Cort */
+    else
+    {
+	    if (start < load_loc || start >= load_loc + len
+		|| ((unsigned *)entry)[2] != 0)
+		    /* doesn't look like a procedure descriptor */
+		    start += entry;
+    }
     printf("Starting at %x\n", start);
 #ifdef BOOTINFO
     /* setup the bootinfo */
diff -ur quik-2.0e/util/elfextract.c quik-work/util/elfextract.c
--- quik-2.0e/util/elfextract.c	Fri Mar 10 15:59:28 2000
+++ quik-work/util/elfextract.c	Sun Mar 12 12:46:21 2000
@@ -4,6 +4,7 @@
  * Copyright 1996 Paul Mackerras.
  */
 #include <stdio.h>
+#define __KERNEL__
 #include <linux/elf.h>

 FILE *fi, *fo;

--sm4nu43k4a2Rpi4c--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
