Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 670EEDDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:43:02 +1100 (EST)
Date: Mon, 11 Feb 2008 11:38:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Wire up new timerfd syscalls
Message-Id: <20080211113840.154a3de5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
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
 include/asm-powerpc/systbl.h |    4 +++-
 include/asm-powerpc/unistd.h |    6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

Kernel built for ppc64_defconfig, pseries_defconfig, iseries_defconfig,
cell_defconfig and pmac32_defconfig.  The latter failed because
check_media_bay is still undefined (i.e. for unrelated reasons).

This has been tested on a pseries_defconfig kernel using the posted test
program built for 64 and 32 bit.

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index e996521..ae7085c 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -309,8 +309,10 @@ SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
 COMPAT_SYS_SPU(signalfd)
-SYSCALL(ni_syscall)
+SYSCALL_SPU(timerfd_create)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
 COMPAT_SYS(fallocate)
 SYSCALL(subpage_prot)
+COMPAT_SYS_SPU(timerfd_settime)
+COMPAT_SYS_SPU(timerfd_gettime)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index fedc4b8..ce91bb6 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -328,15 +328,17 @@
 #define __NR_epoll_pwait	303
 #define __NR_utimensat		304
 #define __NR_signalfd		305
-#define __NR_timerfd		306
+#define __NR_timerfd_create	306
 #define __NR_eventfd		307
 #define __NR_sync_file_range2	308
 #define __NR_fallocate		309
 #define __NR_subpage_prot	310
+#define __NR_timerfd_settime	311
+#define __NR_timerfd_gettime	312
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		311
+#define __NR_syscalls		313
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
