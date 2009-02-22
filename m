Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GC12006@kryten>
Message-Id: <20090222115331.921201207@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:49:59 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 02/10] powerpc: Use new layout for 64bit binaries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We currently place mmaps just below the stack on 32bit, but leave them
in the middle of the address space on 64bit:

00100000-00120000 r-xp 00100000 00:00 0                    [vdso]
10000000-10010000 r-xp 00000000 08:06 179534               /tmp/sleep
10010000-10020000 rw-p 00000000 08:06 179534               /tmp/sleep
10020000-10130000 rw-p 10020000 00:00 0                    [heap]
40000000000-40000030000 r-xp 00000000 08:06 440743         /lib64/ld-2.9.so
40000030000-40000040000 rw-p 00020000 08:06 440743         /lib64/ld-2.9.so
40000050000-400001f0000 r-xp 00000000 08:06 440671         /lib64/libc-2.9.so
400001f0000-40000200000 r--p 00190000 08:06 440671         /lib64/libc-2.9.so
40000200000-40000220000 rw-p 001a0000 08:06 440671         /lib64/libc-2.9.so
40000220000-40008230000 rw-p 40000220000 00:00 0 
fffffbc0000-fffffd10000 rw-p fffffeb0000 00:00 0           [stack]

Right now it isn't an issue, but at some stage we will run into mmap or
hugetlb allocation issues. Using the same layout as 32bit gives us a
some breathing room. This matches what x86-64 is doing too.

00100000-00103000 r-xp 00100000 00:00 0                    [vdso]
10000000-10001000 r-xp 00000000 08:06 554894               /tmp/test
10010000-10011000 r--p 00000000 08:06 554894               /tmp/test
10011000-10012000 rw-p 00001000 08:06 554894               /tmp/test
10012000-10113000 rw-p 10012000 00:00 0                    [heap]
fffefdf7000-ffff7df8000 rw-p fffefdf7000 00:00 0 
ffff7df8000-ffff7f97000 r-xp 00000000 08:06 130591         /lib64/libc-2.9.so
ffff7f97000-ffff7fa6000 ---p 0019f000 08:06 130591         /lib64/libc-2.9.so
ffff7fa6000-ffff7faa000 r--p 0019e000 08:06 130591         /lib64/libc-2.9.so
ffff7faa000-ffff7fc0000 rw-p 001a2000 08:06 130591         /lib64/libc-2.9.so
ffff7fc0000-ffff7fc4000 rw-p ffff7fc0000 00:00 0 
ffff7fc4000-ffff7fec000 r-xp 00000000 08:06 130663         /lib64/ld-2.9.so
ffff7fee000-ffff7ff0000 rw-p ffff7fee000 00:00 0 
ffff7ffa000-ffff7ffb000 rw-p ffff7ffa000 00:00 0 
ffff7ffb000-ffff7ffc000 r--p 00027000 08:06 130663         /lib64/ld-2.9.so
ffff7ffc000-ffff7fff000 rw-p 00028000 08:06 130663         /lib64/ld-2.9.so
ffff7fff000-ffff8000000 rw-p ffff7fff000 00:00 0 
fffffc59000-fffffc6e000 rw-p ffffffeb000 00:00 0           [stack]

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/mmap.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/mmap.c	2009-02-20 13:39:05.000000000 +1100
+++ linux-2.6/arch/powerpc/mm/mmap.c	2009-02-20 13:40:26.000000000 +1100
@@ -48,12 +48,6 @@
 
 static inline int mmap_is_legacy(void)
 {
-	/*
-	 * Force standard allocation for 64 bit programs.
-	 */
-	if (!test_thread_flag(TIF_32BIT))
-		return 1;
-
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
 

-- 
