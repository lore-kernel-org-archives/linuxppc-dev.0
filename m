Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D174F2C0315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:45:50 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r0A6jjbQ006579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 00:45:46 -0600
Message-ID: <1357800345.4838.91.camel@pasglop>
Subject: [PATCH] powerpc: Make room in exception vector area
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 10 Jan 2013 17:45:45 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The FWNMI region is fixed at 0x7000 and the vector are now
overflowing that with some configurations. Fix that by moving
some hash management code out of that region as it doesn't need
to be that close to the call sites (isn't accessed using
conditional branches).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64s.S |  110 +++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a28a65f..7a1c87c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1180,6 +1180,61 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	.globl	__end_handlers
 __end_handlers:
 
+	/* Equivalents to the above handlers for relocation-on interrupt vectors */
+	STD_RELON_EXCEPTION_HV(., 0xe00, h_data_storage)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe00)
+	STD_RELON_EXCEPTION_HV(., 0xe20, h_instr_storage)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe20)
+	STD_RELON_EXCEPTION_HV(., 0xe40, emulation_assist)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
+	STD_RELON_EXCEPTION_HV(., 0xe60, hmi_exception)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
+	MASKABLE_RELON_EXCEPTION_HV(., 0xe80, h_doorbell)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe80)
+
+	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+/*
+ * Data area reserved for FWNMI option.
+ * This address (0x7000) is fixed by the RPA.
+ */
+	.= 0x7000
+	.globl fwnmi_data_area
+fwnmi_data_area:
+
+	/* pseries and powernv need to keep the whole page from
+	 * 0x7000 to 0x8000 free for use by the firmware
+	 */
+	. = 0x8000
+#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+
+/* Space for CPU0's segment table */
+	.balign 4096
+	.globl initial_stab
+initial_stab:
+	.space	4096
+
+#ifdef CONFIG_PPC_POWERNV
+_GLOBAL(opal_mc_secondary_handler)
+	HMT_MEDIUM_PPR_DISCARD
+	SET_SCRATCH0(r13)
+	GET_PACA(r13)
+	clrldi	r3,r3,2
+	tovirt(r3,r3)
+	std	r3,PACA_OPAL_MC_EVT(r13)
+	ld	r13,OPAL_MC_SRR0(r3)
+	mtspr	SPRN_SRR0,r13
+	ld	r13,OPAL_MC_SRR1(r3)
+	mtspr	SPRN_SRR1,r13
+	ld	r3,OPAL_MC_GPR3(r3)
+	GET_SCRATCH0(r13)
+	b	machine_check_pSeries
+#endif /* CONFIG_PPC_POWERNV */
+
+
 /*
  * Hash table stuff
  */
@@ -1373,58 +1428,3 @@ _GLOBAL(do_stab_bolted)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
 	rfid
 	b	.	/* prevent speculative execution */
-
-
-	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV(., 0xe00, h_data_storage)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe00)
-	STD_RELON_EXCEPTION_HV(., 0xe20, h_instr_storage)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe20)
-	STD_RELON_EXCEPTION_HV(., 0xe40, emulation_assist)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
-	STD_RELON_EXCEPTION_HV(., 0xe60, hmi_exception)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
-	MASKABLE_RELON_EXCEPTION_HV(., 0xe80, h_doorbell)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe80)
-
-	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
-
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
-/*
- * Data area reserved for FWNMI option.
- * This address (0x7000) is fixed by the RPA.
- */
-	.= 0x7000
-	.globl fwnmi_data_area
-fwnmi_data_area:
-
-	/* pseries and powernv need to keep the whole page from
-	 * 0x7000 to 0x8000 free for use by the firmware
-	 */
-	. = 0x8000
-#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
-
-/* Space for CPU0's segment table */
-	.balign 4096
-	.globl initial_stab
-initial_stab:
-	.space	4096
-
-#ifdef CONFIG_PPC_POWERNV
-_GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM_PPR_DISCARD
-	SET_SCRATCH0(r13)
-	GET_PACA(r13)
-	clrldi	r3,r3,2
-	tovirt(r3,r3)
-	std	r3,PACA_OPAL_MC_EVT(r13)
-	ld	r13,OPAL_MC_SRR0(r3)
-	mtspr	SPRN_SRR0,r13
-	ld	r13,OPAL_MC_SRR1(r3)
-	mtspr	SPRN_SRR1,r13
-	ld	r3,OPAL_MC_GPR3(r3)
-	GET_SCRATCH0(r13)
-	b	machine_check_pSeries
-#endif /* CONFIG_PPC_POWERNV */
