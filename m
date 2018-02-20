Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFFM1xMmzF19Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:11:15 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id q13so1098993pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:11:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/9] powerpc/64s: kbuild set assembler machine type to POWER4
Date: Wed, 21 Feb 2018 05:08:26 +1000
Message-Id: <20180220190832.1872-4-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rather than override the machine type in .S code (which can hide
wrong or ambiguous code generation for the target), set the type
to power4 for all assembly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                |  1 +
 arch/powerpc/include/asm/ppc_asm.h   | 11 ++++-------
 arch/powerpc/kernel/entry_64.S       |  2 +-
 arch/powerpc/kernel/exceptions-64s.S | 10 ++--------
 arch/powerpc/lib/copypage_power7.S   |  3 ---
 arch/powerpc/lib/copyuser_power7.S   |  3 ---
 arch/powerpc/lib/memcpy_power7.S     |  3 ---
 7 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ccd2556bdb53..cb6de0815a28 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -243,6 +243,7 @@ endif
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ae94b3626b6c..13f7f4c0e1ea 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -439,14 +439,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 
 /* The following stops all load and store data streams associated with stream
  * ID (ie. streams created explicitly).  The embedded and server mnemonics for
- * dcbt are different so we use machine "power4" here explicitly.
+ * dcbt are different so this must only be used for server.
  */
-#define DCBT_STOP_ALL_STREAM_IDS(scratch)	\
-.machine push ;					\
-.machine "power4" ;				\
-       lis     scratch,0x60000000@h;		\
-       dcbt    0,scratch,0b01010;		\
-.machine pop
+#define DCBT_BOOK3S_STOP_ALL_STREAM_IDS(scratch)	\
+       lis     scratch,0x60000000@h;			\
+       dcbt    0,scratch,0b01010
 
 /*
  * toreal/fromreal/tophys/tovirt macros. 32-bit BookE makes them
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..51695608c68b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -545,7 +545,7 @@ _GLOBAL(_switch)
 /* Cancel all explict user streams as they will have no use after context
  * switch and will stop the HW from creating streams itself
  */
-	DCBT_STOP_ALL_STREAM_IDS(r6)
+	DCBT_BOOK3S_STOP_ALL_STREAM_IDS(r6)
 #endif
 
 	addi	r6,r4,-THREAD	/* Convert THREAD to 'current' */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..19a021eae769 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -629,14 +629,11 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	bne	cr4,1f		/* returning to kernel */
 
-.machine	push
-.machine	"power4"
 	mtcrf	0x80,r9
 	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
 	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
 	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-.machine	pop
 
 	RESTORE_CTR(r9, PACA_EXSLB)
 	RESTORE_PPR_PACA(PACA_EXSLB, r9)
@@ -649,14 +646,11 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 1:
-.machine	push
-.machine	"power4"
 	mtcrf	0x80,r9
 	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
 	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
 	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
-.machine	pop
 
 	RESTORE_CTR(r9, PACA_EXSLB)
 	RESTORE_PPR_PACA(PACA_EXSLB, r9)
@@ -1466,7 +1460,7 @@ TRAMP_REAL_BEGIN(rfi_flush_fallback)
 	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
 	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
-	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
+	DCBT_BOOK3S_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
@@ -1506,7 +1500,7 @@ TRAMP_REAL_BEGIN(hrfi_flush_fallback)
 	ld	r11,PACA_L1D_FLUSH_SIZE(r13)
 	srdi	r11,r11,(7 + 3) /* 128 byte lines, unrolled 8x */
 	mtctr	r11
-	DCBT_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
+	DCBT_BOOK3S_STOP_ALL_STREAM_IDS(r11) /* Stop prefetch streams */
 
 	/* order ld/st prior to dcbt stop all streams with flushing */
 	sync
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index ca5fc8fa7efc..8fa73b7ab20e 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -42,8 +42,6 @@ _GLOBAL(copypage_power7)
 	lis	r8,0x8000	/* GO=1 */
 	clrldi	r8,r8,32
 
-.machine push
-.machine "power4"
 	/* setup read stream 0  */
 	dcbt	0,r4,0b01000  	/* addr from */
 	dcbt	0,r7,0b01010   /* length and depth from */
@@ -52,7 +50,6 @@ _GLOBAL(copypage_power7)
 	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
 	dcbt	0,r8,0b01010	/* all streams GO */
-.machine pop
 
 #ifdef CONFIG_ALTIVEC
 	mflr	r0
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index d416a4a66578..215e4760c09f 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -312,8 +312,6 @@ err1;	stb	r0,0(r3)
 	lis	r8,0x8000	/* GO=1 */
 	clrldi	r8,r8,32
 
-.machine push
-.machine "power4"
 	/* setup read stream 0 */
 	dcbt	0,r6,0b01000   /* addr from */
 	dcbt	0,r7,0b01010   /* length and depth from */
@@ -322,7 +320,6 @@ err1;	stb	r0,0(r3)
 	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
 	dcbt	0,r8,0b01010	/* all streams GO */
-.machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
 
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 193909abd18b..df7de9d3da08 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -259,15 +259,12 @@ _GLOBAL(memcpy_power7)
 	lis	r8,0x8000	/* GO=1 */
 	clrldi	r8,r8,32
 
-.machine push
-.machine "power4"
 	dcbt	0,r6,0b01000
 	dcbt	0,r7,0b01010
 	dcbtst	0,r9,0b01000
 	dcbtst	0,r10,0b01010
 	eieio
 	dcbt	0,r8,0b01010	/* GO */
-.machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
 
-- 
2.16.1
