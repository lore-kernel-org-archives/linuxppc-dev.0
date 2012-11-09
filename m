Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/14] powerpc: Turn syscall handler into macros
Date: Fri,  9 Nov 2012 17:19:03 +1100
Message-Id: <1352441953-29096-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This turns the syscall handler into macros as we are going to want to reuse
them again later.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   63 +++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0969b7f..85b3c7e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -25,6 +25,43 @@
  * 0x7000 - 0x7fff : FWNMI data area
  * 0x8000 -        : Early init and support code
  */
+	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
+#define SYSCALL_PSERIES_1 					\
+BEGIN_FTR_SECTION						\
+	cmpdi	r0,0x1ebe ; 					\
+	beq-	1f ;						\
+END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
+	mr	r9,r13 ;					\
+	GET_PACA(r13) ;						\
+	mfspr	r11,SPRN_SRR0 ;					\
+0:
+
+#define SYSCALL_PSERIES_2_RFID 					\
+	mfspr	r12,SPRN_SRR1 ;					\
+	ld	r10,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER(r10, system_call_entry) ; 			\
+	mtspr	SPRN_SRR0,r10 ; 				\
+	ld	r10,PACAKMSR(r13) ;				\
+	mtspr	SPRN_SRR1,r10 ; 				\
+	rfid ; 							\
+	b	. ;	/* prevent speculative execution */
+
+#define SYSCALL_PSERIES_3					\
+	/* Fast LE/BE switch system call */			\
+1:	mfspr	r12,SPRN_SRR1 ;					\
+	xori	r12,r12,MSR_LE ;				\
+	mtspr	SPRN_SRR1,r12 ;					\
+	rfid ;		/* return to userspace */		\
+	b	. ;						\
+2:	mfspr	r12,SPRN_SRR1 ;					\
+	andi.	r12,r12,MSR_PR ;				\
+	bne	0b ;						\
+	mtspr	SPRN_SRR0,r3 ;					\
+	mtspr	SPRN_SRR1,r4 ;					\
+	mtspr	SPRN_SDR1,r5 ;					\
+	rfid ;							\
+	b	. ;	/* prevent speculative execution */
+
 
 /*
  * This is the start of the interrupt handlers for pSeries
@@ -207,31 +244,11 @@ system_call_pSeries:
 	KVMTEST(0xc00)
 	GET_SCRATCH0(r13)
 #endif
-BEGIN_FTR_SECTION
-	cmpdi	r0,0x1ebe
-	beq-	1f
-END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
-	mr	r9,r13
-	GET_PACA(r13)
-	mfspr	r11,SPRN_SRR0
-	mfspr	r12,SPRN_SRR1
-	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, system_call_entry)
-	mtspr	SPRN_SRR0,r10
-	ld	r10,PACAKMSR(r13)
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.	/* prevent speculative execution */
-
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_RFID
+	SYSCALL_PSERIES_3
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
 
-/* Fast LE/BE switch system call */
-1:	mfspr	r12,SPRN_SRR1
-	xori	r12,r12,MSR_LE
-	mtspr	SPRN_SRR1,r12
-	rfid		/* return to userspace */
-	b	.
-
 	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xd00)
 
-- 
1.7.9.5
