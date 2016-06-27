Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpN48hlzDqxF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:04 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpM38HZz9t1N
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:03 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/17] powerpc/opal: Add real mode call wrappers
Date: Mon, 27 Jun 2016 22:25:23 +1000
Message-Id: <1467030333-31435-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the old generic opal_call_realmode() with proper per-call
wrappers similar to the normal ones and convert callers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal-api.h            | 10 +++-
 arch/powerpc/include/asm/opal.h                |  6 +++
 arch/powerpc/kernel/idle_power7.S              | 16 ++-----
 arch/powerpc/platforms/powernv/opal-wrappers.S | 63 +++++++++++++-------------
 4 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 4b4b559..957795c 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -162,7 +162,8 @@
 #define	OPAL_INT_SET_CPPR			123
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
-#define OPAL_LAST				125
+#define OPAL_PCI_TCE_KILL			126
+#define OPAL_LAST				126
 
 /* Device tree flags */
 
@@ -895,6 +896,13 @@ enum {
 	OPAL_REBOOT_PLATFORM_ERROR	= 1,
 };
 
+/* Argument to OPAL_PCI_TCE_KILL */
+enum {
+	OPAL_PCI_TCE_KILL_PAGES,
+	OPAL_PCI_TCE_KILL_PE,
+	OPAL_PCI_TCE_KILL_ALL,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6ccb847..ec6e0cc 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -214,6 +214,12 @@ int64_t opal_int_get_xirr(uint32_t *out_xirr, bool just_poll);
 int64_t opal_int_set_cppr(uint8_t cppr);
 int64_t opal_int_eoi(uint32_t xirr);
 int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
+int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
+			  uint32_t pe_num, uint32_t tce_size,
+			  uint64_t dma_addr, uint32_t npages);
+int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
+			     uint32_t pe_num, uint32_t tce_size,
+			     uint64_t dma_addr, uint32_t npages);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 470ceeb..c93f825 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -196,8 +196,7 @@ fastsleep_workaround_at_entry:
 	/* Fast sleep workaround */
 	li	r3,1
 	li	r4,1
-	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
-	bl	opal_call_realmode
+	bl	opal_rm_config_cpu_idle_state
 
 	/* Clear Lock bit */
 	li	r0,0
@@ -270,8 +269,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	ld	r2,PACATOC(r13);					\
 	ld	r1,PACAR1(r13);						\
 	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
-	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
-	bl	opal_call_realmode;					\
+	bl	opal_rm_handle_hmi;					\
 	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
 20:	nop;
 
@@ -284,7 +282,7 @@ _GLOBAL(power7_wakeup_tb_loss)
 	 * and they are restored before switching to the process context. Hence
 	 * until they are restored, they are free to be used.
 	 *
-	 * Save SRR1 in a NVGPR as it might be clobbered in opal_call_realmode
+	 * Save SRR1 in a NVGPR as it might be clobbered in opal call
 	 * (called in CHECK_HMI_INTERRUPT). SRR1 is required to determine the
 	 * wakeup reason if we branch to kvm_start_guest.
 	 */
@@ -378,10 +376,7 @@ timebase_resync:
 	 * set in exceptions-64s.S */
 	ble	cr3,clear_lock
 	/* Time base re-sync */
-	li	r0,OPAL_RESYNC_TIMEBASE
-	bl	opal_call_realmode;
-	/* TODO: Check r3 for failure */
-
+	bl	opal_rm_resync_timebase;
 	/*
 	 * If waking up from sleep, per core state is not lost, skip to
 	 * clear_lock.
@@ -469,8 +464,7 @@ hypervisor_state_restored:
 fastsleep_workaround_at_exit:
 	li	r3,1
 	li	r4,0
-	li	r0,OPAL_CONFIG_CPU_IDLE_STATE
-	bl	opal_call_realmode
+	bl	opal_rm_config_cpu_idle_state
 	b	timebase_resync
 
 /*
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3854343..d5f00bb 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -59,7 +59,7 @@ END_FTR_SECTION(0, 1);						\
 #define OPAL_CALL(name, token)		\
  _GLOBAL_TOC(name);			\
 	mflr	r0;			\
-	std	r0,16(r1);		\
+	std	r0,PPC_LR_STKOFF(r1);	\
 	li	r0,token;		\
 	OPAL_BRANCH(opal_tracepoint_entry) \
 	mfcr	r12;			\
@@ -92,7 +92,7 @@ opal_return:
 	FIXUP_ENDIAN
 	ld	r2,PACATOC(r13);
 	lwz	r4,8(r1);
-	ld	r5,16(r1);
+	ld	r5,PPC_LR_STKOFF(r1);
 	ld	r6,PACASAVEDMSR(r13);
 	mtspr	SPRN_SRR0,r5;
 	mtspr	SPRN_SRR1,r6;
@@ -157,43 +157,37 @@ opal_tracepoint_return:
 	blr
 #endif
 
-/*
- * Make opal call in realmode. This is a generic function to be called
- * from realmode. It handles endianness.
- *
- * r13 - paca pointer
- * r1  - stack pointer
- * r0  - opal token
- */
-_GLOBAL(opal_call_realmode)
-	mflr	r12
-	std	r12,PPC_LR_STKOFF(r1)
-	ld	r2,PACATOC(r13)
-	/* Set opal return address */
-	LOAD_REG_ADDR(r12,return_from_opal_call)
-	mtlr	r12
-
-	mfmsr	r12
-#ifdef __LITTLE_ENDIAN__
-	/* Handle endian-ness */
-	li	r11,MSR_LE
-	andc	r12,r12,r11
-#endif
-	mtspr	SPRN_HSRR1,r12
-	LOAD_REG_ADDR(r11,opal)
-	ld	r12,8(r11)
-	ld	r2,0(r11)
-	mtspr	SPRN_HSRR0,r12
+#define OPAL_CALL_REAL(name, token)			\
+ _GLOBAL_TOC(name);					\
+	mflr	r0;					\
+	std	r0,PPC_LR_STKOFF(r1);			\
+	li	r0,token;				\
+	mfcr	r12;					\
+	stw	r12,8(r1);				\
+							\
+	/* Set opal return address */			\
+	LOAD_REG_ADDR(r11, opal_return_realmode);	\
+	mtlr	r11;					\
+	mfmsr	r12;					\
+	li	r11,MSR_LE;				\
+	andc	r12,r12,r11;				\
+	mtspr	SPRN_HSRR1,r12;				\
+	LOAD_REG_ADDR(r11,opal);			\
+	ld	r12,8(r11);				\
+	ld	r2,0(r11);				\
+	mtspr	SPRN_HSRR0,r12;				\
 	hrfid
 
-return_from_opal_call:
-#ifdef __LITTLE_ENDIAN__
+opal_return_realmode:
 	FIXUP_ENDIAN
-#endif
+	ld	r2,PACATOC(r13);
+	lwz	r11,8(r1);
 	ld	r12,PPC_LR_STKOFF(r1)
+	mtcr	r11;
 	mtlr	r12
 	blr
 
+
 OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
 OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
 OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
@@ -271,6 +265,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
+OPAL_CALL_REAL(opal_rm_resync_timebase,		OPAL_RESYNC_TIMEBASE);
 OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
@@ -285,7 +280,9 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
+OPAL_CALL_REAL(opal_rm_handle_hmi,		OPAL_HANDLE_HMI);
 OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
+OPAL_CALL_REAL(opal_rm_config_cpu_idle_state,	OPAL_CONFIG_CPU_IDLE_STATE);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
@@ -306,3 +303,5 @@ OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
 OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
 OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
+OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
+OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
-- 
2.7.4
