Message-ID: <3AFEE26B.DA891A5A@folkwang-hochschule.de>
Date: Sun, 13 May 2001 21:37:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel sound problems (and misc)
References: <989768459.4941.0.camel@kara>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:

> The misc problem is, while trying to compile paulus' kernel, the vmlinux
> target fails to link with rwsem_down_write_failed and rwsem_wake
> undefined references.
>
> I hope somebody can help me tackle these.
>

i ran into a similar problem last week trying to build an ia32
kernel.
seems it was due to some fundamental changes to semaphore stuff and
a some compiler instructions i don't wuite understand.
someone sent me a patch, i've added it below. (part of it is
alpha-specific and irrelevant, but the last part seems interesting.)
might give you an idea, but might also be that you have a different
problem.
search the lkml archive for rwsem_, there were quite a few posts.

good luck,

jörn


This patch fixes the __builtin_expect compile problem in 2.4.4-pre6
by
moving the definition of __builtin_expect from
include/asm-alpha/compiler.h to include/linux/compiler.h and
including
this file where needed. I haven't touched the ia64 files that uses
__builtin_expect. Does any pre-2.96 compilers have support for ia64?

--
Niels Kristian Bech Jensen -- nkbj@image.dk --
http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!
<<-----------

diff -u --recursive --new-file
v2.4.4-pre6/linux/include/asm-alpha/compiler.h
linux/include/asm-alpha/compiler.h
--- v2.4.4-pre6/linux/include/asm-alpha/compiler.h      Mon Nov 13
04:27:11 2000
+++ linux/include/asm-alpha/compiler.h  Sun Apr 22 08:28:07 2001
@@ -72,13 +72,4 @@
   __asm__("stw %1,%0" : "=m"(mem) : "r"(val))
 #endif

-/* Somewhere in the middle of the GCC 2.96 development cycle, we
implemented
-   a mechanism by which the user can annotate likely branch
directions and
-   expect the blocks to be reordered appropriately.  Define
__builtin_expect
-   to nothing for earlier compilers.  */
-
-#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
-#define __builtin_expect(x, expected_value) (x)
-#endif
-
 #endif /* __ALPHA_COMPILER_H */
diff -u --recursive --new-file
v2.4.4-pre6/linux/include/asm-alpha/semaphore.h
linux/include/asm-alpha/semaphore.h
--- v2.4.4-pre6/linux/include/asm-alpha/semaphore.h     Sun Apr 22
08:18:53 2001
+++ linux/include/asm-alpha/semaphore.h Sun Apr 22 08:28:29 2001
@@ -11,7 +11,7 @@
 #include <asm/current.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
-#include <asm/compiler.h>      /* __builtin_expect */
+#include <linux/compiler.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>

diff -u --recursive --new-file
v2.4.4-pre6/linux/include/linux/compiler.h
linux/include/linux/compiler.h
--- v2.4.4-pre6/linux/include/linux/compiler.h  Thu Jan  1 01:00:00
1970
+++ linux/include/linux/compiler.h      Sun Apr 22 08:29:12 2001
@@ -0,0 +1,13 @@
+#ifndef __LINUX_COMPILER_H
+#define __LINUX_COMPILER_H
+
+/* Somewhere in the middle of the GCC 2.96 development cycle, we
implemented
+   a mechanism by which the user can annotate likely branch
directions and
+   expect the blocks to be reordered appropriately.  Define
__builtin_expect
+   to nothing for earlier compilers.  */
+
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
+#endif /* __LINUX_COMPILER_H */
diff -u --recursive --new-file v2.4.4-pre6/linux/lib/rwsem.c
linux/lib/rwsem.c
--- v2.4.4-pre6/linux/lib/rwsem.c       Sun Apr 22 08:19:11 2001
+++ linux/lib/rwsem.c   Sun Apr 22 08:29:37 2001
@@ -6,6 +6,7 @@
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/module.h>
+#include <linux/compiler.h>

 struct rwsem_waiter {
        struct rwsem_waiter     *next;

--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
