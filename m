Return-Path: <segher@gcc1-power7.osuosl.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sqYvR2VX6zDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 00:50:43 +1100 (AEDT)
Received: from gcc1-power7.osuosl.org (gcc1-power7.osuosl.org [140.211.15.137])
 by ozlabs.org (Postfix) with ESMTP id 3sqYvR0Nk7z9rvt
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Oct 2016 00:50:43 +1100 (AEDT)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, amodra@gmail.com, markus@trippelsdorf.de,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH] powerpc: cmp -> cmpd for 64-bit
Date: Thu,  6 Oct 2016 13:42:19 +0000
Message-Id: <551528846e6a2783184ba8a4228348a2fc9786bd.1475761214.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerPC's "cmp" instruction has four operands.  Normally people write
"cmpw" or "cmpd" for the second cmp operand 0 or 1.  But, frequently
people forget, and write "cmp" with just three operands.

With older binutils this is silently accepted as if this was "cmpw",
while often "cmpd" is wanted.  With newer binutils GAS will complain
about this for 64-bit code.  For 32-bit code it still silently assumes
"cmpw" is what is meant.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/include/asm/cpuidle.h        | 2 +-
 arch/powerpc/kernel/vdso64/datapage.S     | 2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 01b8a13..3919332 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -26,7 +26,7 @@ extern u64 pnv_first_deep_stop_state;
 	std	r0,0(r1);					\
 	ptesync;						\
 	ld	r0,0(r1);					\
-1:	cmp	cr0,r0,r0;					\
+1:	cmpd	cr0,r0,r0;					\
 	bne	1b;						\
 	IDLE_INST;						\
 	b	.
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 184a6ba..abf17fe 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -59,7 +59,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	bl	V_LOCAL_FUNC(__get_datapage)
 	mtlr	r12
 	addi	r3,r3,CFG_SYSCALL_MAP64
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	li	r0,NR_syscalls
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index a76b4af..3820213 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -145,7 +145,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	bne	cr0,99f
 
 	li	r3,0
-	cmpli	cr0,r4,0
+	cmpldi	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
 	lis	r5,CLOCK_REALTIME_RES@h
-- 
1.9.3
