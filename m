Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHW1N0Dw1zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:04:08 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHW1L6kn6z9s4s
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 15:04:06 +1100 (AEDT)
Message-ID: <1486440239.4850.113.camel@kernel.crashing.org>
Subject: [RFC PATCH v2 1/2] powerpc/powernv: Remove separate entry for OPAL
 real mode calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Date: Tue, 07 Feb 2017 15:03:59 +1100
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

>From 5f32fd8fef0cb762ddb0939265455a0b3db2911b Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 7 Feb 2017 15:01:55 +1100
Subject: 

All entry points already read the MSR so they can easily do
the right thing.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Test both IR and DR and fix accidentally removing an
    instruction in the tracepoint path.

 arch/powerpc/include/asm/opal.h                |  7 ---
 arch/powerpc/kernel/idle_book3s.S              |  6 +--
 arch/powerpc/kvm/book3s_hv_builtin.c           | 13 +++--
 arch/powerpc/kvm/book3s_hv_rm_xics.c           | 14 +++---
 arch/powerpc/platforms/powernv/opal-wrappers.S | 70 +++++++++++---------------
 arch/powerpc/platforms/powernv/pci-ioda.c      |  5 --
 6 files changed, 45 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f..16efe74 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -67,7 +67,6 @@ int64_t opal_pci_config_write_half_word(uint64_t phb_id, uint64_t bus_dev_func,
 int64_t opal_pci_config_write_word(uint64_t phb_id, uint64_t bus_dev_func,
 				   uint64_t offset, uint32_t data);
 int64_t opal_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
-int64_t opal_rm_set_xive(uint32_t isn, uint16_t server, uint8_t priority);
 int64_t opal_get_xive(uint32_t isn, __be16 *server, uint8_t *priority);
 int64_t opal_register_exception_handler(uint64_t opal_exception,
 					uint64_t handler_address,
@@ -220,18 +219,12 @@ int64_t opal_pci_set_power_state(uint64_t async_token, uint64_t id,
 int64_t opal_pci_poll2(uint64_t id, uint64_t data);
 
 int64_t opal_int_get_xirr(uint32_t *out_xirr, bool just_poll);
-int64_t opal_rm_int_get_xirr(__be32 *out_xirr, bool just_poll);
 int64_t opal_int_set_cppr(uint8_t cppr);
 int64_t opal_int_eoi(uint32_t xirr);
-int64_t opal_rm_int_eoi(uint32_t xirr);
 int64_t opal_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
-int64_t opal_rm_int_set_mfrr(uint32_t cpu, uint8_t mfrr);
 int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			  uint32_t pe_num, uint32_t tce_size,
 			  uint64_t dma_addr, uint32_t npages);
-int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
-			     uint32_t pe_num, uint32_t tce_size,
-			     uint64_t dma_addr, uint32_t npages);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72dac0b..5302e1a 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -250,7 +250,7 @@ fastsleep_workaround_at_entry:
 	/* Fast sleep workaround */
 	li	r3,1
 	li	r4,1
-	bl	opal_rm_config_cpu_idle_state
+	bl	opal_config_cpu_idle_state
 
 	/* Clear Lock bit */
 	li	r0,0
@@ -544,7 +544,7 @@ timebase_resync:
 	 */
 	ble	cr3,clear_lock
 	/* Time base re-sync */
-	bl	opal_rm_resync_timebase;
+	bl	opal_resync_timebase;
 	/*
 	 * If waking up from sleep, per core state is not lost, skip to
 	 * clear_lock.
@@ -633,7 +633,7 @@ hypervisor_state_restored:
 fastsleep_workaround_at_exit:
 	li	r3,1
 	li	r4,0
-	bl	opal_rm_config_cpu_idle_state
+	bl	opal_config_cpu_idle_state
 	b	timebase_resync
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 5bb24be..d2a8268 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -229,8 +229,7 @@ void kvmhv_rm_send_ipi(int cpu)
 	if (xics_phys)
 		rm_writeb(xics_phys + XICS_MFRR, IPI_PRIORITY);
 	else
-		opal_rm_int_set_mfrr(get_hard_smp_processor_id(cpu),
-				     IPI_PRIORITY);
+		opal_int_set_mfrr(get_hard_smp_processor_id(cpu), IPI_PRIORITY);
 }
 
 /*
@@ -414,7 +413,7 @@ static long kvmppc_read_one_intr(bool *again)
 	xics_phys = local_paca->kvm_hstate.xics_phys;
 	if (!xics_phys) {
 		/* Use OPAL to read the XIRR */
-		rc = opal_rm_int_get_xirr(&xirr, false);
+		rc = opal_int_get_xirr(&xirr, false);
 		if (rc < 0)
 			return 1;
 	} else {
@@ -449,8 +448,8 @@ static long kvmppc_read_one_intr(bool *again)
 			_stbcix(xics_phys + XICS_MFRR, 0xff);
 			_stwcix(xics_phys + XICS_XIRR, xirr);
 		} else {
-			opal_rm_int_set_mfrr(hard_smp_processor_id(), 0xff);
-			rc = opal_rm_int_eoi(h_xirr);
+			opal_int_set_mfrr(hard_smp_processor_id(), 0xff);
+			rc = opal_int_eoi(h_xirr);
 			/* If rc > 0, there is another interrupt pending */
 			*again = rc > 0;
 		}
@@ -474,8 +473,8 @@ static long kvmppc_read_one_intr(bool *again)
 			if (xics_phys)
 				_stbcix(xics_phys + XICS_MFRR, IPI_PRIORITY);
 			else
-				opal_rm_int_set_mfrr(hard_smp_processor_id(),
-						     IPI_PRIORITY);
+				opal_int_set_mfrr(hard_smp_processor_id(),
+						  IPI_PRIORITY);
 			/* Let side effects complete */
 			smp_mb();
 			return 1;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 06edc43..de55f87 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL(kvm_irq_bypass);
 
 static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 			    u32 new_irq);
-static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu);
+static int xics_opal_set_server(unsigned int hw_irq, int server_cpu);
 
 /* -- ICS routines -- */
 static void ics_rm_check_resend(struct kvmppc_xics *xics,
@@ -73,8 +73,8 @@ static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu)
 	if (paca[hcpu].kvm_hstate.xics_phys)
 		icp_native_cause_ipi_rm(hcpu);
 	else
-		opal_rm_int_set_mfrr(get_hard_smp_processor_id(hcpu),
-				     IPI_PRIORITY);
+		opal_int_set_mfrr(get_hard_smp_processor_id(hcpu),
+				  IPI_PRIORITY);
 }
 #else
 static inline void icp_send_hcore_msg(int hcore, struct kvm_vcpu *vcpu) { }
@@ -730,7 +730,7 @@ int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 			++vcpu->stat.pthru_host;
 			if (state->intr_cpu != pcpu) {
 				++vcpu->stat.pthru_bad_aff;
-				xics_opal_rm_set_server(state->host_irq, pcpu);
+				xics_opal_set_server(state->host_irq, pcpu);
 			}
 			state->intr_cpu = -1;
 		}
@@ -758,16 +758,16 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, __be32 xirr, bool *again)
 	if (xics_phys) {
 		_stwcix(xics_phys + XICS_XIRR, xirr);
 	} else {
-		rc = opal_rm_int_eoi(be32_to_cpu(xirr));
+		rc = opal_int_eoi(be32_to_cpu(xirr));
 		*again = rc > 0;
 	}
 }
 
-static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu)
+static int xics_opal_set_server(unsigned int hw_irq, int server_cpu)
 {
 	unsigned int mangle_cpu = get_hard_smp_processor_id(server_cpu) << 2;
 
-	return opal_rm_set_xive(hw_irq, mangle_cpu, DEFAULT_PRIORITY);
+	return opal_set_xive(hw_irq, mangle_cpu, DEFAULT_PRIORITY);
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3aa40f1..28799e5 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -58,14 +58,16 @@ END_FTR_SECTION(0, 1);						\
 
 #define OPAL_CALL(name, token)		\
  _GLOBAL_TOC(name);			\
+	mfmsr	r12;			\
 	mflr	r0;			\
+	andi.	r11,r12,MSR_IR|MSR_DR; 	\
 	std	r0,PPC_LR_STKOFF(r1);	\
 	li	r0,token;		\
+	beq	opal_real_call;         \
 	OPAL_BRANCH(opal_tracepoint_entry) \
-	mfcr	r12;			\
-	stw	r12,8(r1);		\
+	mfcr	r11;			\
+	stw	r11,8(r1);		\
 	li	r11,0;			\
-	mfmsr	r12;			\
 	ori	r11,r11,MSR_EE;		\
 	std	r12,PACASAVEDMSR(r13);	\
 	andc	r12,r12,r11;		\
@@ -98,6 +100,30 @@ opal_return:
 	mtcr	r4;
 	rfid
 
+opal_real_call:
+	mfcr	r11
+	stw	r11,8(r1)
+	/* Set opal return address */
+	LOAD_REG_ADDR(r11, opal_return_realmode)
+	mtlr	r11
+	li	r11,MSR_LE
+	andc	r12,r12,r11
+	mtspr	SPRN_HSRR1,r12
+	LOAD_REG_ADDR(r11,opal)
+	ld	r12,8(r11)
+	ld	r2,0(r11)
+	mtspr	SPRN_HSRR0,r12
+	hrfid
+
+opal_return_realmode:
+	FIXUP_ENDIAN
+	ld	r2,PACATOC(r13);
+	lwz	r11,8(r1);
+	ld	r12,PPC_LR_STKOFF(r1)
+	mtcr	r11;
+	mtlr	r12
+	blr
+
 #ifdef CONFIG_TRACEPOINTS
 opal_tracepoint_entry:
 	stdu	r1,-STACKFRAMESIZE(r1)
@@ -155,36 +181,6 @@ opal_tracepoint_return:
 	blr
 #endif
 
-#define OPAL_CALL_REAL(name, token)			\
- _GLOBAL_TOC(name);					\
-	mflr	r0;					\
-	std	r0,PPC_LR_STKOFF(r1);			\
-	li	r0,token;				\
-	mfcr	r12;					\
-	stw	r12,8(r1);				\
-							\
-	/* Set opal return address */			\
-	LOAD_REG_ADDR(r11, opal_return_realmode);	\
-	mtlr	r11;					\
-	mfmsr	r12;					\
-	li	r11,MSR_LE;				\
-	andc	r12,r12,r11;				\
-	mtspr	SPRN_HSRR1,r12;				\
-	LOAD_REG_ADDR(r11,opal);			\
-	ld	r12,8(r11);				\
-	ld	r2,0(r11);				\
-	mtspr	SPRN_HSRR0,r12;				\
-	hrfid
-
-opal_return_realmode:
-	FIXUP_ENDIAN
-	ld	r2,PACATOC(r13);
-	lwz	r11,8(r1);
-	ld	r12,PPC_LR_STKOFF(r1)
-	mtcr	r11;
-	mtlr	r12
-	blr
-
 
 OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
 OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
@@ -208,7 +204,6 @@ OPAL_CALL(opal_pci_config_write_byte,		OPAL_PCI_CONFIG_WRITE_BYTE);
 OPAL_CALL(opal_pci_config_write_half_word,	OPAL_PCI_CONFIG_WRITE_HALF_WORD);
 OPAL_CALL(opal_pci_config_write_word,		OPAL_PCI_CONFIG_WRITE_WORD);
 OPAL_CALL(opal_set_xive,			OPAL_SET_XIVE);
-OPAL_CALL_REAL(opal_rm_set_xive,		OPAL_SET_XIVE);
 OPAL_CALL(opal_get_xive,			OPAL_GET_XIVE);
 OPAL_CALL(opal_register_exception_handler,	OPAL_REGISTER_OPAL_EXCEPTION_HANDLER);
 OPAL_CALL(opal_pci_eeh_freeze_status,		OPAL_PCI_EEH_FREEZE_STATUS);
@@ -264,7 +259,6 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
-OPAL_CALL_REAL(opal_rm_resync_timebase,		OPAL_RESYNC_TIMEBASE);
 OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
@@ -280,9 +274,7 @@ OPAL_CALL(opal_sensor_read,			OPAL_SENSOR_READ);
 OPAL_CALL(opal_get_param,			OPAL_GET_PARAM);
 OPAL_CALL(opal_set_param,			OPAL_SET_PARAM);
 OPAL_CALL(opal_handle_hmi,			OPAL_HANDLE_HMI);
-OPAL_CALL_REAL(opal_rm_handle_hmi,		OPAL_HANDLE_HMI);
 OPAL_CALL(opal_config_cpu_idle_state,		OPAL_CONFIG_CPU_IDLE_STATE);
-OPAL_CALL_REAL(opal_rm_config_cpu_idle_state,	OPAL_CONFIG_CPU_IDLE_STATE);
 OPAL_CALL(opal_slw_set_reg,			OPAL_SLW_SET_REG);
 OPAL_CALL(opal_register_dump_region,		OPAL_REGISTER_DUMP_REGION);
 OPAL_CALL(opal_unregister_dump_region,		OPAL_UNREGISTER_DUMP_REGION);
@@ -304,11 +296,7 @@ OPAL_CALL(opal_pci_get_presence_state,		OPAL_PCI_GET_PRESENCE_STATE);
 OPAL_CALL(opal_pci_get_power_state,		OPAL_PCI_GET_POWER_STATE);
 OPAL_CALL(opal_pci_set_power_state,		OPAL_PCI_SET_POWER_STATE);
 OPAL_CALL(opal_int_get_xirr,			OPAL_INT_GET_XIRR);
-OPAL_CALL_REAL(opal_rm_int_get_xirr,		OPAL_INT_GET_XIRR);
 OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
 OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
-OPAL_CALL_REAL(opal_rm_int_eoi,			OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
-OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
-OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b07680c..a897958 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1962,11 +1962,6 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		if (phb->model == PNV_PHB_MODEL_PHB3 && phb->regs)
 			pnv_pci_phb3_tce_invalidate(pe, rm, shift,
 						    index, npages);
-		else if (rm)
-			opal_rm_pci_tce_kill(phb->opal_id,
-					     OPAL_PCI_TCE_KILL_PAGES,
-					     pe->pe_number, 1u << shift,
-					     index << shift, npages);
 		else
 			opal_pci_tce_kill(phb->opal_id,
 					  OPAL_PCI_TCE_KILL_PAGES,
