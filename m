Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 547221014D0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:46:31 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/20] powerpc/powernv: Machine check and other system
	interrupts
Date: Tue, 20 Sep 2011 13:45:04 +1000
Message-Id: <1316490307-28030-17-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL can handle various interrupt for us such as Machine Checks (it
performs all sorts of recovery tasks and passes back control to us with
informations about the error), Hardware Management Interrupts and Softpatch
interrupts.

This wires up the mechanisms and prints out specific informations returned
by HAL when a machine check occurs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h        |    2 +
 arch/powerpc/include/asm/paca.h        |    8 ++
 arch/powerpc/kernel/asm-offsets.c      |   10 +++
 arch/powerpc/kernel/exceptions-64s.S   |   27 ++++++-
 arch/powerpc/platforms/powernv/opal.c  |  130 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c |    1 +
 6 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9bb0efd..fca611b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -436,6 +436,8 @@ extern void opal_get_rtc_time(struct rtc_time *tm);
 extern unsigned long opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 
+extern int opal_machine_check(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 516bfb3..17722c7 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -43,6 +43,7 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
+struct opal_machine_check_event;
 
 /*
  * Defines the layout of the paca.
@@ -135,6 +136,13 @@ struct paca_struct {
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
 
+#ifdef CONFIG_PPC_POWERNV
+	/* Pointer to OPAL machine check event structure set by the
+	 * early exception handler for use by high level C handler
+	 */
+	struct opal_machine_check_event *opal_mc_evt;
+#endif
+
 	/* Stuff for accurate time accounting */
 	u64 user_time;			/* accumulated usermode TB ticks */
 	u64 system_time;		/* accumulated system TB ticks */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 5f078bc..536ffa8 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -48,6 +48,9 @@
 #ifdef CONFIG_PPC_ISERIES
 #include <asm/iseries/alpaca.h>
 #endif
+#ifdef CONFIG_PPC_POWERNV
+#include <asm/opal.h>
+#endif
 #if defined(CONFIG_KVM) || defined(CONFIG_KVM_GUEST)
 #include <linux/kvm_host.h>
 #endif
@@ -609,5 +612,12 @@ int main(void)
 					arch.timing_last_enter.tv32.tbl));
 #endif
 
+#ifdef CONFIG_PPC_POWERNV
+	DEFINE(OPAL_MC_GPR3, offsetof(struct opal_machine_check_event, gpr3));
+	DEFINE(OPAL_MC_SRR0, offsetof(struct opal_machine_check_event, srr0));
+	DEFINE(OPAL_MC_SRR1, offsetof(struct opal_machine_check_event, srr1));
+	DEFINE(PACA_OPAL_MC_EVT, offsetof(struct paca_struct, opal_mc_evt));
+#endif
+
 	return 0;
 }
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 41b02c7..d51458f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1143,7 +1143,7 @@ _GLOBAL(do_stab_bolted)
 	rfid
 	b	.	/* prevent speculative execution */
 
-#ifdef CONFIG_PPC_PSERIES
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
  * This address (0x7000) is fixed by the RPA.
@@ -1151,7 +1151,7 @@ _GLOBAL(do_stab_bolted)
 	.= 0x7000
 	.globl fwnmi_data_area
 fwnmi_data_area:
-#endif /* CONFIG_PPC_PSERIES */
+#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 	/* iSeries does not use the FWNMI stuff, so it is safe to put
 	 * this here, even if we later allow kernels that will boot on
@@ -1176,9 +1176,12 @@ xLparMap:
 
 #endif /* CONFIG_PPC_ISERIES */
 
-#ifdef CONFIG_PPC_PSERIES
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+	/* pseries and powernv need to keep the whole page from
+	 * 0x7000 to 0x8000 free for use by the firmware
+	 */
         . = 0x8000
-#endif /* CONFIG_PPC_PSERIES */
+#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 /*
  * Space for CPU0's segment table.
@@ -1193,3 +1196,19 @@ xLparMap:
 	.globl initial_stab
 initial_stab:
 	.space	4096
+#ifdef CONFIG_PPC_POWERNV
+_GLOBAL(opal_mc_secondary_handler)
+	HMT_MEDIUM
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
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 5a598ca..aaa0dba 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -27,12 +27,14 @@ struct opal {
 
 static struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
+extern u64 opal_mc_secondary_handler[];
 
 int __init early_init_dt_scan_opal(unsigned long node,
 				   const char *uname, int depth, void *data)
 {
 	const void *basep, *entryp;
 	unsigned long basesz, entrysz;
+	u64 glue;
 
 	if (depth != 1 || strcmp(uname, "ibm,opal") != 0)
 		return 0;
@@ -59,6 +61,19 @@ int __init early_init_dt_scan_opal(unsigned long node,
 		printk("OPAL V1 detected !\n");
 	}
 
+	/* Hookup some exception handlers. We use the fwnmi area at 0x7000
+	 * to provide the glue space to OPAL
+	 */
+	glue = 0x7000;
+	opal_register_exception_handler(OPAL_MACHINE_CHECK_HANDLER,
+					__pa(opal_mc_secondary_handler[0]),
+					glue);
+	glue += 128;
+	opal_register_exception_handler(OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
+					0, glue);
+	glue += 128;
+	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
+
 	return 1;
 }
 
@@ -136,6 +151,121 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	return written;
 }
 
+int opal_machine_check(struct pt_regs *regs)
+{
+	struct opal_machine_check_event *opal_evt = get_paca()->opal_mc_evt;
+	struct opal_machine_check_event evt;
+	const char *level, *sevstr, *subtype;
+	static const char *opal_mc_ue_types[] = {
+		"Indeterminate",
+		"Instruction fetch",
+		"Page table walk ifetch",
+		"Load/Store",
+		"Page table walk Load/Store",
+	};
+	static const char *opal_mc_slb_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+	static const char *opal_mc_erat_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+	static const char *opal_mc_tlb_types[] = {
+		"Indeterminate",
+		"Parity",
+		"Multihit",
+	};
+
+	/* Copy the event structure and release the original */
+	evt = *opal_evt;
+	opal_evt->in_use = 0;
+
+	/* Print things out */
+	if (evt.version != OpalMCE_V1) {
+		pr_err("Machine Check Exception, Unknown event version %d !\n",
+		       evt.version);
+		return 0;
+	}
+	switch(evt.severity) {
+	case OpalMCE_SEV_NO_ERROR:
+		level = KERN_INFO;
+		sevstr = "Harmless";
+		break;
+	case OpalMCE_SEV_WARNING:
+		level = KERN_WARNING;
+		sevstr = "";
+		break;
+	case OpalMCE_SEV_ERROR_SYNC:
+		level = KERN_ERR;
+		sevstr = "Severe";
+		break;
+	case OpalMCE_SEV_FATAL:
+	default:
+		level = KERN_ERR;
+		sevstr = "Fatal";
+		break;
+	}
+
+	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
+	       evt.disposition == OpalMCE_DISPOSITION_RECOVERED ?
+	       "Recovered" : "[Not recovered");
+	printk("%s  Initiator: %s\n", level,
+	       evt.initiator == OpalMCE_INITIATOR_CPU ? "CPU" : "Unknown");
+	switch(evt.error_type) {
+	case OpalMCE_ERROR_TYPE_UE:
+		subtype = evt.u.ue_error.ue_error_type <
+			ARRAY_SIZE(opal_mc_ue_types) ?
+			opal_mc_ue_types[evt.u.ue_error.ue_error_type]
+			: "Unknown";
+		printk("%s  Error type: UE [%s]\n", level, subtype);
+		if (evt.u.ue_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt.u.ue_error.effective_address);
+		if (evt.u.ue_error.physical_address_provided)
+			printk("%s      Physial address: %016llx\n",
+			       level, evt.u.ue_error.physical_address);
+		break;
+	case OpalMCE_ERROR_TYPE_SLB:
+		subtype = evt.u.slb_error.slb_error_type <
+			ARRAY_SIZE(opal_mc_slb_types) ?
+			opal_mc_slb_types[evt.u.slb_error.slb_error_type]
+			: "Unknown";
+		printk("%s  Error type: SLB [%s]\n", level, subtype);
+		if (evt.u.slb_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt.u.slb_error.effective_address);
+		break;
+	case OpalMCE_ERROR_TYPE_ERAT:
+		subtype = evt.u.erat_error.erat_error_type <
+			ARRAY_SIZE(opal_mc_erat_types) ?
+			opal_mc_erat_types[evt.u.erat_error.erat_error_type]
+			: "Unknown";
+		printk("%s  Error type: ERAT [%s]\n", level, subtype);
+		if (evt.u.erat_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt.u.erat_error.effective_address);
+		break;
+	case OpalMCE_ERROR_TYPE_TLB:
+		subtype = evt.u.tlb_error.tlb_error_type <
+			ARRAY_SIZE(opal_mc_tlb_types) ?
+			opal_mc_tlb_types[evt.u.tlb_error.tlb_error_type]
+			: "Unknown";
+		printk("%s  Error type: TLB [%s]\n", level, subtype);
+		if (evt.u.tlb_error.effective_address_provided)
+			printk("%s    Effective address: %016llx\n",
+			       level, evt.u.tlb_error.effective_address);
+		break;
+	default:
+	case OpalMCE_ERROR_TYPE_UNKNOWN:
+		printk("%s  Error type: Unknown\n", level);
+		break;
+	}
+	return evt.severity == OpalMCE_SEV_FATAL ? 0 : 1;
+}
+
 static irqreturn_t opal_interrupt(int irq, void *data)
 {
 	uint64_t events;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 4a2b2e2..f0242f3 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -141,6 +141,7 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.restart = pnv_restart;
 	ppc_md.power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
+	ppc_md.machine_check_exception = opal_machine_check;
 }
 
 #ifdef CONFIG_PPC_POWERNV_RTAS
-- 
1.7.4.1
