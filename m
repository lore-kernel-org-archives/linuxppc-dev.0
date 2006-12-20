Return-Path: <anton@ozlabs.org>
Date: Wed, 20 Dec 2006 15:58:52 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] move ELF_ET_DYN_BASE
Message-ID: <20061220045852.GA1810@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I often test new versions of glibc by doing:

LD_LIBRARY_PATH=/XXX/lib /XXX/lib/ld.so.1 <binary>

One test case ended up SEGV'ing. Upon closer inspection ld.so was loaded
at 0x8000000 (128MB) with the heap right after it. Since we normally
link binaries at 0x10000000 (256MB) we only had about 128MB of space for
the heap:

00100000-00103000 r-xp 00100000 00:00 0           [vdso]
08000000-0801e000 r-xp 00000000 00:01 33079       /lib/ld-2.5.so
0802d000-0802f000 rwxp 0001d000 00:01 33079       /lib/ld-2.5.so
0802f000-08050000 rwxp 0802f000 00:00 0           [heap]
0fe91000-0ffd9000 r-xp 00000000 00:01 33082       /lib/libc-2.5.so
0ffd9000-0ffe8000 ---p 00148000 00:01 33082       /lib/libc-2.5.so
0ffe8000-0ffea000 r--p 00147000 00:01 33082       /lib/libc-2.5.so
0ffea000-0ffed000 rwxp 00149000 00:01 33082       /lib/libc-2.5.so
10000000-10004000 r-xp 00000000 00:01 76          /bin/sleep
10013000-10014000 rwxp 00003000 00:01 76          /bin/sleep
ffb41000-ffb56000 rw-p ffb41000 00:00 0           [stack]

One way to fix this is move ELF_ET_DYN_BASE from 0x08000000 to 0x20000000.
This allows 128MB for the binary (hopefully enough for even the most
crazy c++ apps), and with our current layout we will grow the heap up
and the stack down, allowing potentially gigabytes of heap:

00100000-00103000 r-xp 00100000 00:00 0           [vdso]
0fe8a000-0ffd3000 r-xp 00000000 00:01 3350        /lib/tls/libc-2.3.6.so
0ffd3000-0ffe3000 ---p 00149000 00:01 3350        /lib/tls/libc-2.3.6.so
0ffe3000-0ffea000 r--p 00149000 00:01 3350        /lib/tls/libc-2.3.6.so
0ffea000-0ffee000 rwxp 00150000 00:01 3350        /lib/tls/libc-2.3.6.so
10000000-10004000 r-xp 00000000 00:01 76          /bin/sleep
10013000-10014000 rwxp 00003000 00:01 76          /bin/sleep
20000000-20018000 r-xp 00000000 00:01 3478        /lib/ld-2.3.6.so
20028000-20029000 r--p 00018000 00:01 3478        /lib/ld-2.3.6.so
20029000-2002a000 rwxp 00019000 00:01 3478        /lib/ld-2.3.6.so
2002a000-2004b000 rwxp 2002a000 00:00 0           [heap]
ffd67000-ffd7c000 rw-p ffd67000 00:00 0           [stack]

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/include/asm-powerpc/elf.h
===================================================================
--- kernel.orig/include/asm-powerpc/elf.h	2006-12-19 22:22:03.000000000 -0600
+++ kernel/include/asm-powerpc/elf.h	2006-12-19 22:23:58.000000000 -0600
@@ -175,7 +175,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE         (0x08000000)
+#define ELF_ET_DYN_BASE         (0x20000000)
 
 /* Common routine for both 32-bit and 64-bit processes */
 static inline void ppc_elf_core_copy_regs(elf_gregset_t elf_regs,
