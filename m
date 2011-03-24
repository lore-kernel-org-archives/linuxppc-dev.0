Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 61FD4B6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Mar 2011 15:40:49 +1100 (EST)
Date: Thu, 24 Mar 2011 15:40:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: wire up new syscalls
Message-Id: <20110324154047.b96bfe46.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These syscalls have been added recently:
	name_to_handle_at
	open_by_handle_at
	clock_adjtime
	syncfs

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/systbl.h |    4 ++++
 arch/powerpc/include/asm/unistd.h |    6 +++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

I have test built this for pseries_defconfig and pmac32_deconfig both
with and without CONFIG_FHANDLE.

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index aa0f1eb..60f64b1 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -348,3 +348,7 @@ COMPAT_SYS_SPU(sendmsg)
 COMPAT_SYS_SPU(recvmsg)
 COMPAT_SYS_SPU(recvmmsg)
 SYSCALL_SPU(accept4)
+SYSCALL_SPU(name_to_handle_at)
+COMPAT_SYS_SPU(open_by_handle_at)
+COMPAT_SYS_SPU(clock_adjtime)
+SYSCALL_SPU(syncfs)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 6151937..3c21564 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -367,10 +367,14 @@
 #define __NR_recvmsg		342
 #define __NR_recvmmsg		343
 #define __NR_accept4		344
+#define __NR_name_to_handle_at	345
+#define __NR_open_by_handle_at	346
+#define __NR_clock_adjtime	347
+#define __NR_syncfs		348
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		345
+#define __NR_syscalls		349
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.7.4.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
