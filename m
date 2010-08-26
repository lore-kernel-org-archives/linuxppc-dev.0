Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18921B70D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Aug 2010 14:50:41 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o7Q4k9DS027257
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2010 14:46:09 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7Q4obA21687720
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2010 14:50:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7Q4oasD000473
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2010 14:50:37 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Wire up direct socket system calls
Date: Thu, 26 Aug 2010 14:50:28 +1000
Message-Id: <1282798228-340-1-git-send-email-imunsie@au1.ibm.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, linuxppc-dev@lists.ozlabs.org,
	Andreas Schwab <schwab@linux-m68k.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@linux.intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch wires up the various socket system calls on PowerPC so that
userspace can call them directly, rather than by going through the
multiplexed socketcall system call.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/systbl.h |   19 +++++++++++++++++++
 arch/powerpc/include/asm/unistd.h |   21 ++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 3d21266..aa0f1eb 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -329,3 +329,22 @@ COMPAT_SYS(rt_tgsigqueueinfo)
 SYSCALL(fanotify_init)
 COMPAT_SYS(fanotify_mark)
 SYSCALL_SPU(prlimit64)
+SYSCALL_SPU(socket)
+SYSCALL_SPU(bind)
+SYSCALL_SPU(connect)
+SYSCALL_SPU(listen)
+SYSCALL_SPU(accept)
+SYSCALL_SPU(getsockname)
+SYSCALL_SPU(getpeername)
+SYSCALL_SPU(socketpair)
+SYSCALL_SPU(send)
+SYSCALL_SPU(sendto)
+COMPAT_SYS_SPU(recv)
+COMPAT_SYS_SPU(recvfrom)
+SYSCALL_SPU(shutdown)
+COMPAT_SYS_SPU(setsockopt)
+COMPAT_SYS_SPU(getsockopt)
+COMPAT_SYS_SPU(sendmsg)
+COMPAT_SYS_SPU(recvmsg)
+COMPAT_SYS_SPU(recvmmsg)
+SYSCALL_SPU(accept4)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 597e6f9..6151937 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -348,10 +348,29 @@
 #define __NR_fanotify_init	323
 #define __NR_fanotify_mark	324
 #define __NR_prlimit64		325
+#define __NR_socket		326
+#define __NR_bind		327
+#define __NR_connect		328
+#define __NR_listen		329
+#define __NR_accept		330
+#define __NR_getsockname	331
+#define __NR_getpeername	332
+#define __NR_socketpair		333
+#define __NR_send		334
+#define __NR_sendto		335
+#define __NR_recv		336
+#define __NR_recvfrom		337
+#define __NR_shutdown		338
+#define __NR_setsockopt		339
+#define __NR_getsockopt		340
+#define __NR_sendmsg		341
+#define __NR_recvmsg		342
+#define __NR_recvmmsg		343
+#define __NR_accept4		344
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		326
+#define __NR_syscalls		345
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.7.1
