Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC6DC1A1170
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 21:53:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>, schwab@linux-m68k.org,
 <linux-kernel@vger.kernel.org>, murphyp@linux.vnet.ibm.com,
 tuliom@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com
Subject: [PATCH] Partial revert of "powerpc: Individual System V IPC system
 calls"
Date: Wed, 16 Dec 2015 21:53:29 +1100
Message-Id: <1450263209-11217-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This partially reverts commit a34236155afb1cc41945e58388ac988431bcb0b8.

While reviewing the glibc patch to exploit the individual IPC calls,
Arnd & Andreas noticed that we were still requiring userspace to pass
IPC_64 in order to get the new style IPC API.

With a bit of cleanup in the kernel we can drop that requirement, and
instead only provide the new style API, which will simplify things for
userspace.

Rather than try and sneak that patch into 4.4, instead we will drop the
individual IPC calls for powerpc, and merge them again in 4.5 once the
cleanup patch has gone in.

Because we've already added sys_mlock2() as syscall #378, we don't do a
full revert of the IPC calls. Instead we drop the __NR #defines, and
send those now undefined syscall numbers to sys_ni_syscall(). This
leaves a gap in the syscall numbers, but we'll reuse them when we merge
the individual IPC calls.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/systbl.h      | 24 ++++++++++++------------
 arch/powerpc/include/uapi/asm/unistd.h | 12 ------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index f2b0b1b0c72a..5654ece02c0d 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -370,16 +370,16 @@ COMPAT_SYS(execveat)
 PPC64ONLY(switch_endian)
 SYSCALL_SPU(userfaultfd)
 SYSCALL_SPU(membarrier)
-SYSCALL(semop)
-SYSCALL(semget)
-COMPAT_SYS(semctl)
-COMPAT_SYS(semtimedop)
-COMPAT_SYS(msgsnd)
-COMPAT_SYS(msgrcv)
-SYSCALL(msgget)
-COMPAT_SYS(msgctl)
-COMPAT_SYS(shmat)
-SYSCALL(shmdt)
-SYSCALL(shmget)
-COMPAT_SYS(shmctl)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
 SYSCALL(mlock2)
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 1effea5193d6..12a05652377a 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -388,18 +388,6 @@
 #define __NR_switch_endian	363
 #define __NR_userfaultfd	364
 #define __NR_membarrier		365
-#define __NR_semop		366
-#define __NR_semget		367
-#define __NR_semctl		368
-#define __NR_semtimedop		369
-#define __NR_msgsnd		370
-#define __NR_msgrcv		371
-#define __NR_msgget		372
-#define __NR_msgctl		373
-#define __NR_shmat		374
-#define __NR_shmdt		375
-#define __NR_shmget		376
-#define __NR_shmctl		377
 #define __NR_mlock2		378
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.5.0
