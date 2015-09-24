Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B18D1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 16:16:58 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62521140281
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 16:16:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 24 Sep 2015 16:16:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9D5AB3578054
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 16:16:54 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8O6GjWw14680186
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 16:16:54 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8O6GLxY003087
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2015 16:16:21 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH 1/1] powerpc: Individual System V IPC system calls
Date: Thu, 24 Sep 2015 15:39:28 +1000
Message-Id: <fc46555d58def0d9ad51ba3e6bc66d5dcf537d48.1443073157.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch provides individual system call numbers for the following
System V IPC system calls, on PowerPC, so that they do not need to be
multiplexed:
* semop, semget, semctl, semtimedop
* msgsnd, msgrcv, msgget, msgctl
* shmat, shmdt, shmget, shmctl

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

 arch/powerpc/include/asm/systbl.h      | 12 ++++++++++++
 arch/powerpc/include/asm/unistd.h      |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 12 ++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 71f2b3f..546b9ec 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -368,3 +368,15 @@ SYSCALL_SPU(memfd_create)
 SYSCALL_SPU(bpf)
 COMPAT_SYS(execveat)
 PPC64ONLY(switch_endian)
+SYSCALL(semop)
+SYSCALL(semget)
+COMPAT_SYS(semctl)
+COMPAT_SYS(semtimedop)
+COMPAT_SYS(msgsnd)
+COMPAT_SYS(msgrcv)
+SYSCALL(msgget)
+COMPAT_SYS(msgctl)
+COMPAT_SYS(shmat)
+SYSCALL(shmdt)
+SYSCALL(shmget)
+COMPAT_SYS(shmctl)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index f4f8b66..e51c51b 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		364
+#define __NR_syscalls		376
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index e4aa173..a8390ee 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -386,5 +386,17 @@
 #define __NR_bpf		361
 #define __NR_execveat		362
 #define __NR_switch_endian	363
+#define __NR_semop		364
+#define __NR_semget		365
+#define __NR_semctl		366
+#define __NR_semtimedop		367
+#define __NR_msgsnd		368
+#define __NR_msgrcv		369
+#define __NR_msgget		370
+#define __NR_msgctl		371
+#define __NR_shmat		372
+#define __NR_shmdt		373
+#define __NR_shmget		374
+#define __NR_shmctl		375
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.1.4
