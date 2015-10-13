Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B6B51A02CF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 12:50:38 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF8B7140D7A
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:50:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 13 Oct 2015 11:50:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 317232CE8050
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:50:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D1oLuG15466604
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:50:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D1o1l4023254
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 12:50:01 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 1/1] powerpc: Individual System V IPC system calls
Date: Tue, 13 Oct 2015 12:49:28 +1100
Message-Id: <a3cfb270cd61cc3aacdf929e7739ae46dcff86bd.1444700960.git.sam.bobroff@au1.ibm.com>
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

v2:

Rebased onto today's next-20151012.

 arch/powerpc/include/asm/systbl.h      | 12 ++++++++++++
 arch/powerpc/include/asm/unistd.h      |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 12 ++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 126d0c4..c9e26cb 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -370,3 +370,15 @@ COMPAT_SYS(execveat)
 PPC64ONLY(switch_endian)
 SYSCALL_SPU(userfaultfd)
 SYSCALL_SPU(membarrier)
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
index 13411be..6d8f802 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		366
+#define __NR_syscalls		378
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 63377380..81579e9 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -388,5 +388,17 @@
 #define __NR_switch_endian	363
 #define __NR_userfaultfd	364
 #define __NR_membarrier		365
+#define __NR_semop		366
+#define __NR_semget		367
+#define __NR_semctl		368
+#define __NR_semtimedop		369
+#define __NR_msgsnd		370
+#define __NR_msgrcv		371
+#define __NR_msgget		372
+#define __NR_msgctl		373
+#define __NR_shmat		374
+#define __NR_shmdt		375
+#define __NR_shmget		376
+#define __NR_shmctl		377
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.1.4
