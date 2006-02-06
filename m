Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 7 Feb 2006 10:59:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: wire up the *at system calls
Message-Id: <20060207105906.04a22df3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Linus <torvalds@osdl.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/systbl.S |   13 +++++++++++++
 include/asm-powerpc/unistd.h |   15 ++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletions(-)

This depend on the patch that creates all the compat wrappers.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

d02d8208813d8cae2c814a85734a1a31fed2f3ac
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 007b15e..fe16d9c 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -323,3 +323,16 @@ SYSCALL(spu_run)
 SYSCALL(spu_create)
 COMPAT_SYS(pselect6)
 COMPAT_SYS(ppoll)
+COMPAT_SYS(openat)
+COMPAT_SYS(mkdirat)
+COMPAT_SYS(mknodat)
+COMPAT_SYS(fchownat)
+COMPAT_SYS(futimesat)
+COMPAT_SYS(newfstatat)
+COMPAT_SYS(unlinkat)
+COMPAT_SYS(renameat)
+COMPAT_SYS(linkat)
+COMPAT_SYS(symlinkat)
+COMPAT_SYS(readlinkat)
+COMPAT_SYS(fchmodat)
+COMPAT_SYS(faccessat)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index a40cdff..d05b85e 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -300,8 +300,21 @@
 #define __NR_spu_create		279
 #define __NR_pselect6		280
 #define __NR_ppoll		281
+#define __NR_openat		282
+#define __NR_mkdirat		283
+#define __NR_mknodat		284
+#define __NR_fchownat		285
+#define __NR_futimesat		286
+#define __NR_newfstatat		287
+#define __NR_unlinkat		288
+#define __NR_renameat		289
+#define __NR_linkat		290
+#define __NR_symlinkat		291
+#define __NR_readlinkat		292
+#define __NR_fchmodat		293
+#define __NR_faccessat		294
 
-#define __NR_syscalls		282
+#define __NR_syscalls		295
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
-- 
1.1.5
