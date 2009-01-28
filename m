Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 5085DDDFC8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 09:41:26 +1100 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: containers@lists.osdl.org
Subject: [PATCH 2/3] powerpc: wire up checkpoint and restart syscalls
Date: Wed, 28 Jan 2009 16:41:17 -0600
Message-Id: <1233182478-27113-3-git-send-email-ntl@pobox.com>
In-Reply-To: <1233182478-27113-1-git-send-email-ntl@pobox.com>
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/include/asm/systbl.h |    2 ++
 arch/powerpc/include/asm/unistd.h |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 803def2..cdb60b4 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -322,3 +322,5 @@ SYSCALL_SPU(epoll_create1)
 SYSCALL_SPU(dup3)
 SYSCALL_SPU(pipe2)
 SYSCALL(inotify_init1)
+SYSCALL(checkpoint)
+SYSCALL(restart)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index e07d0c7..2e333a1 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -341,10 +341,12 @@
 #define __NR_dup3		316
 #define __NR_pipe2		317
 #define __NR_inotify_init1	318
+#define __NR_checkpoint		319
+#define __NR_restart		320
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		319
+#define __NR_syscalls		321
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.5
