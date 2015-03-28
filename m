Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C53CD1A0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 21:35:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v5 1/2] powerpc: Add a proper syscall for switching endianness
Date: Sat, 28 Mar 2015 21:35:16 +1100
Message-Id: <1427538917-5140-1-git-send-email-mpe@ellerman.id.au>
Cc: Jeremy Kerr <jk@ozlabs.org>, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently have a "special" syscall for switching endianness. This is
syscall number 0x1ebe, which is handled explicitly in the 64-bit syscall
exception entry.

That has a few problems, firstly the syscall number is outside of the
usual range, which confuses various tools. For example strace doesn't
recognise the syscall at all.

Secondly it's handled explicitly as a special case in the syscall
exception entry, which is complicated enough without it.

As a first step toward removing the special syscall, we need to add a
regular syscall that implements the same functionality.

The logic is simple, it simply toggles the MSR_LE bit in the userspace
MSR. This is the same as the special syscall, with the caveat that the
special syscall clobbers fewer registers.

This version clobbers r9-r12, XER, CTR, and CR0-1,5-7.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v3: Don't provide the syscall on 32-bit.
v4: No change.
v5: No change.

 arch/powerpc/include/asm/systbl.h           |  1 +
 arch/powerpc/include/asm/unistd.h           |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h      |  1 +
 arch/powerpc/kernel/entry_64.S              |  5 +++++
 arch/powerpc/kernel/syscalls.c              | 17 +++++++++++++++++
 arch/powerpc/kernel/systbl.S                |  2 ++
 arch/powerpc/kernel/systbl_chk.c            |  2 ++
 arch/powerpc/platforms/cell/spu_callbacks.c |  1 +
 8 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 91062eef582f..f1863a138b4a 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -367,3 +367,4 @@ SYSCALL_SPU(getrandom)
 SYSCALL_SPU(memfd_create)
 SYSCALL_SPU(bpf)
 COMPAT_SYS(execveat)
+PPC64ONLY(switch_endian)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 36b79c31eedd..f4f8b667d75b 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		363
+#define __NR_syscalls		364
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index ef5b5b1f3123..e4aa173dae62 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -385,5 +385,6 @@
 #define __NR_memfd_create	360
 #define __NR_bpf		361
 #define __NR_execveat		362
+#define __NR_switch_endian	363
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d180caf2d6de..afbc20019c2e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -356,6 +356,11 @@ _GLOBAL(ppc64_swapcontext)
 	bl	sys_swapcontext
 	b	.Lsyscall_exit
 
+_GLOBAL(ppc_switch_endian)
+	bl	save_nvgprs
+	bl	sys_switch_endian
+	b	.Lsyscall_exit
+
 _GLOBAL(ret_from_fork)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index b2702e87db0d..5fa92706444b 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -121,3 +121,20 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
 			     (u64)len_high << 32 | len_low, advice);
 }
+
+long sys_switch_endian(void)
+{
+	struct thread_info *ti;
+
+	current->thread.regs->msr ^= MSR_LE;
+
+	/*
+	 * Set TIF_RESTOREALL so that r3 isn't clobbered on return to
+	 * userspace. That also has the effect of restoring the non-volatile
+	 * GPRs, so we saved them on the way in here.
+	 */
+	ti = current_thread_info();
+	ti->flags |= _TIF_RESTOREALL;
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 7ab5d434e2ee..4d6b1d3a747f 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -22,6 +22,7 @@
 #define PPC_SYS(func)		.llong	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
 #define OLDSYS(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
 #define SYS32ONLY(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.llong	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
 #define SYSX(f, f3264, f32)	.llong	DOTSYM(f),DOTSYM(f3264)
 #else
 #define SYSCALL(func)		.long	sys_##func
@@ -29,6 +30,7 @@
 #define PPC_SYS(func)		.long	ppc_##func
 #define OLDSYS(func)		.long	sys_##func
 #define SYS32ONLY(func)		.long	sys_##func
+#define PPC64ONLY(func)		.long	sys_ni_syscall
 #define SYSX(f, f3264, f32)	.long	f32
 #endif
 #define SYSCALL_SPU(func)	SYSCALL(func)
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 238aa63ced8f..2384129f5893 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -21,9 +21,11 @@
 #ifdef CONFIG_PPC64
 #define OLDSYS(func)		-1
 #define SYS32ONLY(func)		-1
+#define PPC64ONLY(func)		__NR_##func
 #else
 #define OLDSYS(func)		__NR_old##func
 #define SYS32ONLY(func)		__NR_##func
+#define PPC64ONLY(func)		-1
 #endif
 #define SYSX(f, f3264, f32)	-1
 
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index b0ec78e8ad68..a494028b2cdf 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -39,6 +39,7 @@ static void *spu_syscall_table[] = {
 #define PPC_SYS(func)		sys_ni_syscall,
 #define OLDSYS(func)		sys_ni_syscall,
 #define SYS32ONLY(func)		sys_ni_syscall,
+#define PPC64ONLY(func)		sys_ni_syscall,
 #define SYSX(f, f3264, f32)	sys_ni_syscall,
 
 #define SYSCALL_SPU(func)	sys_##func,
-- 
2.1.0
