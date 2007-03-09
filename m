Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77110DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 11:59:46 +1100 (EST)
Date: Fri, 9 Mar 2007 11:57:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/3] [POWERPC] wire up sys_epoll_pwait
Message-Id: <20070309115710.6050edc8.sfr@canb.auug.org.au>
In-Reply-To: <20070309115457.611e4c99.sfr@canb.auug.org.au>
References: <20070309115457.611e4c99.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: pc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
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
 include/asm-powerpc/systbl.h |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

This depended on the compat code for epoll which has now gone into
Linus's kernel.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 418e5c7..fe63831 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -306,3 +306,4 @@ COMPAT_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
 COMPAT_SYS(move_pages)
 SYSCALL_SPU(getcpu)
+COMPAT_SYS(epoll_pwait)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index bcc21bf..2baedbe 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -325,10 +325,11 @@
 #define __NR_set_robust_list	300
 #define __NR_move_pages		301
 #define __NR_getcpu		302
+#define __NR_epoll_pwait	303
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		303
+#define __NR_syscalls		304
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.0.3
