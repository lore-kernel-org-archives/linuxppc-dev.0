Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 22C75B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:32 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <93f8c621d0b3aaabd901f31fa13a9bad4bd337e1.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:33 -0500
Subject: [PATCH 01/37] powerpc: fix memory corruption from unallocated slaves
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1fc711f7ffb01089efc58042cfdbac8573d1b59a (powerpc/kexec: Fix race
in kexec shutdown) moved the write to signal the cpu had exited the kernel
from before the transition to real mode in kexec_smp_wait to kexec_wait.

Unfornately it missed that kexec_wait is used both by cpus leaving the
kernel and by secondary slave cpus that were not allocated a paca for
what ever reason -- they could be beyond nr_cpus or not described in
the current device tree for whatever reason (for example, kexec-load
was not refreshed after a cpu hotplug operation).  Cpus coming through
that path they will write to paca[NR_CPUS] which is beyond the space
allocated for the paca data and overwrite memory not allocated to pacas
but very likely still real mode accessable).

Move the write back to kexec_smp_wait, which is used only by cpus that
found their paca, but after the transition to real mode.

Signed-off-by: Milton Miller <miltonm@bga.com>
Cc: <stable@kernel.org> # (1fc711f was backported to 2.6.32)
---
 arch/powerpc/kernel/misc_64.S |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 206a321..e89df59 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -462,7 +462,8 @@ _GLOBAL(disable_kernel_fp)
  * wait for the flag to change, indicating this kernel is going away but
  * the slave code for the next one is at addresses 0 to 100.
  *
- * This is used by all slaves.
+ * This is used by all slaves, even those that did not find a matching
+ * paca in the secondary startup code.
  *
  * Physical (hardware) cpu id should be in r3.
  */
@@ -471,10 +472,6 @@ _GLOBAL(kexec_wait)
 1:	mflr	r5
 	addi	r5,r5,kexec_flag-1b
 
-	li	r4,KEXEC_STATE_REAL_MODE
-	stb	r4,PACAKEXECSTATE(r13)
-	SYNC
-
 99:	HMT_LOW
 #ifdef CONFIG_KEXEC		/* use no memory without kexec */
 	lwz	r4,0(r5)
@@ -499,11 +496,17 @@ kexec_flag:
  *
  * get phys id from paca
  * switch to real mode
+ * mark the paca as no longer used
  * join other cpus in kexec_wait(phys_id)
  */
 _GLOBAL(kexec_smp_wait)
 	lhz	r3,PACAHWCPUID(r13)
 	bl	real_mode
+
+	li	r4,KEXEC_STATE_REAL_MODE
+	stb	r4,PACAKEXECSTATE(r13)
+	SYNC
+
 	b	.kexec_wait
 
 /*
-- 
1.7.0.4
