Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdSfT3MsRzDw4b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 05:19:45 +1100 (AEDT)
Message-Id: <e6292c23163fac0865def3a385ff01d1497b005b.1481652710.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1481652710.git.christophe.leroy@c-s.fr>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC 1/2] powerpc/32: Unset MSR RI in exception epilogs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Tue, 13 Dec 2016 19:19:41 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At exception prologs, once SRR0 and SRR1 have been saved, MSR RI is
set to mark the interrupt as recoverable.

MSR RI has to be unset before writing into SRR0 and SRR1 at exception
epilogs.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/ppc_asm.h | 6 ++++++
 arch/powerpc/include/asm/reg_8xx.h | 1 +
 arch/powerpc/kernel/entry_32.S     | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c443..493cb97 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -514,6 +514,12 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define MTMSR_EERI(reg)	mtmsr	reg
 #endif
 
+#ifdef CONFIG_PPC_8xx
+#define SET_MSR_NRI(r)	mtspr	SPRN_NRI,r
+#else
+#define SET_MSR_NRI(r)	mfmsr r; rlwinm r,r,0,~MSR_RI; MTMSRD(r)
+#endif
+
 #endif /* __KERNEL__ */
 
 /* The boring bits... */
diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
index c52725b..52f3684 100644
--- a/arch/powerpc/include/asm/reg_8xx.h
+++ b/arch/powerpc/include/asm/reg_8xx.h
@@ -28,6 +28,7 @@
 /* Special MSR manipulation registers */
 #define SPRN_EIE	80	/* External interrupt enable (EE=1, RI=1) */
 #define SPRN_EID	81	/* External interrupt disable (EE=0, RI=1) */
+#define SPRN_NRI	82	/* Non recoverable interrupt (EE=0, RI=0) */
 
 /* Debug registers */
 #define SPRN_CMPE	152
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 980626a..b912bab 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -205,6 +205,7 @@ transfer_to_handler_cont:
 	mflr	r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
+	SET_MSR_NRI(r12)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	lis	r12,reenable_mmu@h
 	ori	r12,r12,reenable_mmu@l
@@ -292,6 +293,7 @@ stack_ovf:
 	lis	r9,StackOverflow@ha
 	addi	r9,r9,StackOverflow@l
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
+	SET_MSR_NRI(r12)
 	mtspr	SPRN_SRR0,r9
 	mtspr	SPRN_SRR1,r10
 	SYNC
@@ -418,6 +420,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	lwz	r7,_NIP(r1)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
+	SET_MSR_NRI(r4)
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
 	SYNC
@@ -700,6 +703,7 @@ fast_exception_return:
 	mtcr	r10
 	lwz	r10,_LINK(r11)
 	mtlr	r10
+	SET_MSR_NRI(r10)
 	REST_GPR(10, r11)
 	mtspr	SPRN_SRR1,r9
 	mtspr	SPRN_SRR0,r12
@@ -974,6 +978,7 @@ exc_exit_restart_end:
 	.globl exc_exit_restart
 exc_exit_restart:
 	lwz	r11,_NIP(r1)
+	SET_MSR_NRI(r12)
 	lwz	r12,_MSR(r1)
 exc_exit_start:
 	mtspr	SPRN_SRR0,r11
-- 
2.10.1
