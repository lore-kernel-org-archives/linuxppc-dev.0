Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C86CADDE2F
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 13:50:35 +1000 (EST)
Date: Mon, 14 May 2007 13:50:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Wire up some more syscalls
Message-Id: <20070514135033.07c1b840.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

signalfd, timerfd and eventfd

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/systbl.h |    3 +++
 include/asm-powerpc/unistd.h |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

This depends on the patch I just sent to declare compat_sys_signalfd and
compat_sys_timerfd.  And I am assuming that the SPU's want these.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 3d44446..700ca59 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -308,3 +308,6 @@ COMPAT_SYS_SPU(move_pages)
 SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
+COMPAT_SYS_SPU(signalfd)
+COMPAT_SYS_SPU(timerfd)
+SYSCALL_SPU(eventfd)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 21f004a..912e009 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -327,10 +327,13 @@
 #define __NR_getcpu		302
 #define __NR_epoll_pwait	303
 #define __NR_utimensat		304
+#define __NR_signalfd		305
+#define __NR_timerfd		306
+#define __NR_eventfd		307
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		305
+#define __NR_syscalls		308
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.1.4
