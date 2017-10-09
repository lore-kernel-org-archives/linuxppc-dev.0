Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9cYv1n7nzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 21:54:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/64s: Move the two FAST_ENDIAN macros next to each
 other
Date: Mon,  9 Oct 2017 21:54:04 +1100
Message-Id: <1507546445-28089-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So we can #ifdef them in the next patch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b9925933b3e5..5bdad80dd9c2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -865,12 +865,6 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 #define LOAD_SYSCALL_HANDLER(reg)					\
 	__LOAD_HANDLER(reg, system_call_common)
 
-#define SYSCALL_FASTENDIAN_TEST					\
-BEGIN_FTR_SECTION						\
-	cmpdi	r0,0x1ebe ; 					\
-	beq-	1f ;						\
-END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
-
 /*
  * After SYSCALL_KVMTEST, we reach here with PACA in r13, r13 in r9,
  * and HMT_MEDIUM.
@@ -885,6 +879,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	rfid ; 							\
 	b	. ;	/* prevent speculative execution */
 
+#define SYSCALL_FASTENDIAN_TEST					\
+BEGIN_FTR_SECTION						\
+	cmpdi	r0,0x1ebe ; 					\
+	beq-	1f ;						\
+END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
+
 #define SYSCALL_FASTENDIAN					\
 	/* Fast LE/BE switch system call */			\
 1:	mfspr	r12,SPRN_SRR1 ;					\
-- 
2.7.4
