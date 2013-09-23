Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/39] powerpc: endian safe trampoline
Date: Mon, 23 Sep 2013 12:04:45 +1000
Message-Id: <1379901913-5945-12-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Create a trampoline that works in either endian and flips to
the expected endian. Use it for primary and secondary thread
entry as well as RTAS and OF call return.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h | 31 ++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/entry_64.S     | 36 ++++++++++++++++++++----------------
 arch/powerpc/kernel/head_64.S      |  3 +++
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 0c51fb4..ce05bba 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -845,6 +845,35 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,946)
 #define N_SLINE	68
 #define N_SO	100
 
-#endif /*  __ASSEMBLY__ */
+/*
+ * Create an endian fixup trampoline
+ *
+ * This starts with a "tdi 0,0,0x48" instruction which is
+ * essentially a "trap never", and thus akin to a nop.
+ *
+ * The opcode for this instruction read with the wrong endian
+ * however results in a b . + 8
+ *
+ * So essentially we use that trick to execute the following
+ * trampoline in "reverse endian" if we are running with the
+ * MSR_LE bit set the "wrong" way for whatever endianness the
+ * kernel is built for.
+ */
 
+#ifdef CONFIG_PPC_BOOK3E
+#define FIXUP_ENDIAN
+#else
+#define FIXUP_ENDIAN						   \
+	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
+	b     $+36;	  /* Skip trampoline if endian is good	*/ \
+	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
+	.long 0xa602487d; /* mflr r10				*/ \
+	.long 0x1c004a39; /* addi r10,r10,28			*/ \
+	.long 0xa600607d; /* mfmsr r11				*/ \
+	.long 0x01006b69; /* xori r11,r11,1			*/ \
+	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
+	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
+	.long 0x2400004c  /* rfid				*/
+#endif /* !CONFIG_PPC_BOOK3E */
+#endif /*  __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_PPC_ASM_H */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c04cdf7..889ea2b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1017,7 +1017,7 @@ _GLOBAL(enter_rtas)
 	
         li      r9,1
         rldicr  r9,r9,MSR_SF_LG,(63-MSR_SF_LG)
-	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI
+	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI|MSR_LE
 	andc	r6,r0,r9
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
@@ -1032,6 +1032,8 @@ _GLOBAL(enter_rtas)
 	b	.	/* prevent speculative execution */
 
 _STATIC(rtas_return_loc)
+	FIXUP_ENDIAN
+
 	/* relocation is off at this point */
 	GET_PACA(r4)
 	clrldi	r4,r4,2			/* convert to realmode address */
@@ -1103,28 +1105,30 @@ _GLOBAL(enter_prom)
 	std	r10,_CCR(r1)
 	std	r11,_MSR(r1)
 
-	/* Get the PROM entrypoint */
-	mtlr	r4
+	/* Put PROM address in SRR0 */
+	mtsrr0	r4
+
+	/* Setup our trampoline return addr in LR */
+	bcl	20,31,$+4
+0:	mflr	r4
+	addi	r4,r4,(1f - 0b)
+       	mtlr	r4
 
-	/* Switch MSR to 32 bits mode
+	/* Prepare a 32-bit mode big endian MSR
 	 */
 #ifdef CONFIG_PPC_BOOK3E
 	rlwinm	r11,r11,0,1,31
-	mtmsr	r11
+	mtsrr1	r11
+	rfi
 #else /* CONFIG_PPC_BOOK3E */
-        mfmsr   r11
-        li      r12,1
-        rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
-        andc    r11,r11,r12
-        li      r12,1
-        rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
-        andc    r11,r11,r12
-        mtmsrd  r11
+	LOAD_REG_IMMEDIATE(r12, MSR_SF | MSR_ISF | MSR_LE)
+	andc	r11,r11,r12
+	mtsrr1	r11
+	rfid
 #endif /* CONFIG_PPC_BOOK3E */
-        isync
 
-	/* Enter PROM here... */
-	blrl
+1:	/* Return from OF */
+	FIXUP_ENDIAN
 
 	/* Just make sure that r1 top 32 bits didn't get
 	 * corrupt by OF
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3d11d80..2ae41ab 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -68,6 +68,7 @@ _stext:
 _GLOBAL(__start)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
+	FIXUP_ENDIAN
 	b	.__start_initialization_multiplatform
 END_FTR_SECTION(0, 1)
 
@@ -115,6 +116,7 @@ __run_at_load:
  */
 	.globl	__secondary_hold
 __secondary_hold:
+	FIXUP_ENDIAN
 #ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
@@ -205,6 +207,7 @@ _GLOBAL(generic_secondary_thread_init)
  * as SCOM before entry).
  */
 _GLOBAL(generic_secondary_smp_init)
+	FIXUP_ENDIAN
 	mr	r24,r3
 	mr	r25,r4
 
-- 
1.8.1.2
