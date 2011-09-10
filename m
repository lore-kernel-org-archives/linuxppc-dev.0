Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00954B72D9
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 00:20:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/21] powerpc/powernv: Add OPAL takeover from PowerVM
Date: Sat, 10 Sep 2011 11:19:56 -0300
Message-Id: <1315664408-16797-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On machines supporting the OPAL firmware version 1, the system
is initially booted under pHyp. We then use a special hypercall
to verify if OPAL is available and if it is, we then trigger
a "takeover" which disables pHyp and loads the OPAL runtime
firmware, giving control to the kernel in hypervisor mode.

This patch add the necessary code to detect that the OPAL takeover
capability is present when running under PowerVM (aka pHyp) and
perform said takeover to get hypervisor control of the processor.

To perform the takeover, we must first use RTAS (within Open
Firmware runtime environment) to start all processors & threads,
in order to give control to OPAL on all of them. We then call
the takeover hypercall on everybody, OPAL will re-enter the kernel
main entry point passing it a flat device-tree.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h                |   50 +++++
 arch/powerpc/kernel/head_64.S                  |    4 +
 arch/powerpc/kernel/prom_init.c                |  239 ++++++++++++++++++++++--
 arch/powerpc/kernel/prom_init_check.sh         |    3 +-
 arch/powerpc/platforms/powernv/Makefile        |    2 +-
 arch/powerpc/platforms/powernv/opal-takeover.S |  140 ++++++++++++++
 6 files changed, 419 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/include/asm/opal.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-takeover.S

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
new file mode 100644
index 0000000..ecdb283
--- /dev/null
+++ b/arch/powerpc/include/asm/opal.h
@@ -0,0 +1,50 @@
+/*
+ * PowerNV OPAL definitions.
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __OPAL_H
+#define __OPAL_H
+
+/****** Takeover interface ********/
+
+/* PAPR H-Call used to querty the HAL existence and/or instanciate
+ * it from within pHyp (tech preview only).
+ *
+ * This is exclusively used in prom_init.c
+ */
+
+#ifndef __ASSEMBLY__
+
+struct opal_takeover_args {
+	u64	k_image;		/* r4 */
+	u64	k_size;			/* r5 */
+	u64	k_entry;		/* r6 */
+	u64	k_entry2;		/* r7 */
+	u64	hal_addr;		/* r8 */
+	u64	rd_image;		/* r9 */
+	u64	rd_size;		/* r10 */
+	u64	rd_loc;			/* r11 */
+};
+
+extern long opal_query_takeover(u64 *hal_size, u64 *hal_align);
+
+extern long opal_do_takeover(struct opal_takeover_args *args);
+
+extern int opal_enter_rtas(struct rtas_args *args,
+			   unsigned long data,
+			   unsigned long entry);
+
+
+#endif /* __ASSEMBLY__ */
+
+/****** OPAL APIs ******/
+
+
+#endif /* __OPAL_H */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index e708abe..dea8191 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -51,6 +51,10 @@
  *  For pSeries or server processors:
  *   1. The MMU is off & open firmware is running in real mode.
  *   2. The kernel is entered at __start
+ * -or- For OPAL entry:
+ *   1. The MMU is off, processor in HV mode, primary CPU enters at 0
+ *      with device-tree in gpr3
+ *   2. Secondary processors enter at 0x60 with PIR in gpr3
  *
  *  For iSeries:
  *   1. The MMU is on (as it always is for iSeries)
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a909f4e..9369287 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -43,6 +43,7 @@
 #include <asm/btext.h>
 #include <asm/sections.h>
 #include <asm/machdep.h>
+#include <asm/opal.h>
 
 #include <linux/linux_logo.h>
 
@@ -185,6 +186,7 @@ static unsigned long __initdata prom_tce_alloc_end;
 #define PLATFORM_LPAR		0x0001
 #define PLATFORM_POWERMAC	0x0400
 #define PLATFORM_GENERIC	0x0500
+#define PLATFORM_OPAL		0x0600
 
 static int __initdata of_platform;
 
@@ -644,7 +646,7 @@ static void __init early_cmdline_parse(void)
 	}
 }
 
-#ifdef CONFIG_PPC_PSERIES
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * There are two methods for telling firmware what our capabilities are.
  * Newer machines have an "ibm,client-architecture-support" method on the
@@ -1274,6 +1276,195 @@ static void __init prom_init_mem(void)
 	prom_printf("  ram_top      : %x\n", RELOC(ram_top));
 }
 
+static void __init prom_close_stdin(void)
+{
+	struct prom_t *_prom = &RELOC(prom);
+	ihandle val;
+
+	if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
+		call_prom("close", 1, 0, val);
+}
+
+#ifdef CONFIG_PPC_POWERNV
+
+static u64 __initdata prom_opal_size;
+static u64 __initdata prom_opal_align;
+static int __initdata prom_rtas_start_cpu;
+static u64 __initdata prom_rtas_data;
+static u64 __initdata prom_rtas_entry;
+
+/* XXX Don't change this structure without updating opal-takeover.S */
+static struct opal_secondary_data {
+	s64				ack;	/*  0 */
+	u64				go;	/*  8 */
+	struct opal_takeover_args	args;	/* 16 */
+} opal_secondary_data;
+
+extern char opal_secondary_entry;
+
+static void prom_query_opal(void)
+{
+	long rc;
+
+	prom_printf("Querying for OPAL presence... ");
+	rc = opal_query_takeover(&RELOC(prom_opal_size),
+				 &RELOC(prom_opal_align));
+	prom_debug("(rc = %ld) ", rc);
+	if (rc != 0) {
+		prom_printf("not there.\n");
+		return;
+	}
+	RELOC(of_platform) = PLATFORM_OPAL;
+	prom_printf(" there !\n");
+	prom_debug("  opal_size  = 0x%lx\n", RELOC(prom_opal_size));
+	prom_debug("  opal_align = 0x%lx\n", RELOC(prom_opal_align));
+	if (RELOC(prom_opal_align) < 0x10000)
+		RELOC(prom_opal_align) = 0x10000;
+}
+
+static int prom_rtas_call(int token, int nargs, int nret, int *outputs, ...)
+{
+	struct rtas_args rtas_args;
+	va_list list;
+	int i;
+
+	rtas_args.token = token;
+	rtas_args.nargs = nargs;
+	rtas_args.nret  = nret;
+	rtas_args.rets  = (rtas_arg_t *)&(rtas_args.args[nargs]);
+	va_start(list, outputs);
+	for (i = 0; i < nargs; ++i)
+		rtas_args.args[i] = va_arg(list, rtas_arg_t);
+	va_end(list);
+
+	for (i = 0; i < nret; ++i)
+		rtas_args.rets[i] = 0;
+
+	opal_enter_rtas(&rtas_args, RELOC(prom_rtas_data),
+			RELOC(prom_rtas_entry));
+
+	if (nret > 1 && outputs != NULL)
+		for (i = 0; i < nret-1; ++i)
+			outputs[i] = rtas_args.rets[i+1];
+	return (nret > 0)? rtas_args.rets[0]: 0;
+}
+
+static void __init prom_opal_hold_cpus(void)
+{
+	int i, cnt, cpu, rc;
+	long j;
+	phandle node;
+	char type[64];
+	u32 servers[8];
+	struct prom_t *_prom = &RELOC(prom);
+	void *entry = (unsigned long *)&RELOC(opal_secondary_entry);
+	struct opal_secondary_data *data = &RELOC(opal_secondary_data);
+
+	prom_debug("prom_opal_hold_cpus: start...\n");
+	prom_debug("    - entry       = 0x%x\n", entry);
+	prom_debug("    - data        = 0x%x\n", data);
+
+	data->ack = -1;
+	data->go = 0;
+
+	/* look for cpus */
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = 0;
+		prom_getprop(node, "device_type", type, sizeof(type));
+		if (strcmp(type, RELOC("cpu")) != 0)
+			continue;
+
+		/* Skip non-configured cpus. */
+		if (prom_getprop(node, "status", type, sizeof(type)) > 0)
+			if (strcmp(type, RELOC("okay")) != 0)
+				continue;
+
+		cnt = prom_getprop(node, "ibm,ppc-interrupt-server#s", servers,
+			     sizeof(servers));
+		if (cnt == PROM_ERROR)
+			break;
+		cnt >>= 2;
+		for (i = 0; i < cnt; i++) {
+			cpu = servers[i];
+			prom_debug("CPU %d ... ", cpu);
+			if (cpu == _prom->cpu) {
+				prom_debug("booted !\n");
+				continue;
+			}
+			prom_debug("starting ... ");
+
+			/* Init the acknowledge var which will be reset by
+			 * the secondary cpu when it awakens from its OF
+			 * spinloop.
+			 */
+			data->ack = -1;
+			rc = prom_rtas_call(RELOC(prom_rtas_start_cpu), 3, 1,
+					    NULL, cpu, entry, data);
+			prom_debug("rtas rc=%d ...", rc);
+
+			for (j = 0; j < 100000000 && data->ack == -1; j++) {
+				HMT_low();
+				mb();
+			}
+			HMT_medium();
+			if (data->ack != -1)
+				prom_debug("done, PIR=0x%x\n", data->ack);
+			else
+				prom_debug("timeout !\n");
+		}
+	}
+	prom_debug("prom_opal_hold_cpus: end...\n");
+}
+
+static void prom_opal_takeover(void)
+{
+	struct opal_secondary_data *data = &RELOC(opal_secondary_data);
+	struct opal_takeover_args *args = &data->args;
+	u64 align = RELOC(prom_opal_align);
+	u64 top_addr, opal_addr;
+
+	args->k_image	= (u64)RELOC(_stext);
+	args->k_size	= _end - _stext;
+	args->k_entry	= 0;
+	args->k_entry2	= 0x60;
+
+	top_addr = _ALIGN_UP(args->k_size, align);
+
+	if (RELOC(prom_initrd_start) != 0) {
+		args->rd_image = RELOC(prom_initrd_start);
+		args->rd_size = RELOC(prom_initrd_end) - args->rd_image;
+		args->rd_loc = top_addr;
+		top_addr = _ALIGN_UP(args->rd_loc + args->rd_size, align);
+	}
+
+	/* Pickup an address for the HAL. We want to go really high
+	 * up to avoid problem with future kexecs. On the other hand
+	 * we don't want to be all over the TCEs on P5IOC2 machines
+	 * which are going to be up there too. We assume the machine
+	 * has plenty of memory, and we ask for the HAL for now to
+	 * be just below the 1G point, or above the initrd
+	 */
+	opal_addr = _ALIGN_DOWN(0x40000000 - RELOC(prom_opal_size), align);
+	if (opal_addr < top_addr)
+		opal_addr = top_addr;
+	args->hal_addr = opal_addr;
+
+	prom_debug("  k_image    = 0x%lx\n", args->k_image);
+	prom_debug("  k_size     = 0x%lx\n", args->k_size);
+	prom_debug("  k_entry    = 0x%lx\n", args->k_entry);
+	prom_debug("  k_entry2   = 0x%lx\n", args->k_entry2);
+	prom_debug("  hal_addr   = 0x%lx\n", args->hal_addr);
+	prom_debug("  rd_image   = 0x%lx\n", args->rd_image);
+	prom_debug("  rd_size    = 0x%lx\n", args->rd_size);
+	prom_debug("  rd_loc     = 0x%lx\n", args->rd_loc);
+	prom_printf("Performing OPAL takeover,this can take a few minutes..\n");
+	prom_close_stdin();
+	mb();
+	data->go = 1;
+	for (;;)
+		opal_do_takeover(args);
+}
+#endif /* CONFIG_PPC_POWERNV */
 
 /*
  * Allocate room for and instantiate RTAS
@@ -1326,6 +1517,12 @@ static void __init prom_instantiate_rtas(void)
 	prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
 		     &entry, sizeof(entry));
 
+#ifdef CONFIG_PPC_POWERNV
+	/* PowerVN takeover hack */
+	RELOC(prom_rtas_data) = base;
+	RELOC(prom_rtas_entry) = entry;
+	prom_getprop(rtas_node, "start-cpu", &RELOC(prom_rtas_start_cpu), 4);
+#endif
 	prom_debug("rtas base     = 0x%x\n", base);
 	prom_debug("rtas entry    = 0x%x\n", entry);
 	prom_debug("rtas size     = 0x%x\n", (long)size);
@@ -1543,7 +1740,7 @@ static void __init prom_hold_cpus(void)
 		*acknowledge = (unsigned long)-1;
 
 		if (reg != _prom->cpu) {
-			/* Primary Thread of non-boot cpu */
+			/* Primary Thread of non-boot cpu or any thread */
 			prom_printf("starting cpu hw idx %lu... ", reg);
 			call_prom("start-cpu", 3, 0, node,
 				  secondary_hold, reg);
@@ -1652,15 +1849,6 @@ static void __init prom_init_stdout(void)
 		prom_setprop(val, path, "linux,boot-display", NULL, 0);
 }
 
-static void __init prom_close_stdin(void)
-{
-	struct prom_t *_prom = &RELOC(prom);
-	ihandle val;
-
-	if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
-		call_prom("close", 1, 0, val);
-}
-
 static int __init prom_find_machine_type(void)
 {
 	struct prom_t *_prom = &RELOC(prom);
@@ -2504,6 +2692,7 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
+
 /*
  * We enter here early on, when the Open Firmware prom is still
  * handling exceptions and the MMU hash table for us.
@@ -2565,7 +2754,7 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 	 */
 	prom_check_initrd(r3, r4);
 
-#ifdef CONFIG_PPC_PSERIES
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 	/*
 	 * On pSeries, inform the firmware about our capabilities
 	 */
@@ -2611,14 +2800,30 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
 #endif
 
 	/*
-	 * On non-powermacs, try to instantiate RTAS and puts all CPUs
-	 * in spin-loops. PowerMacs don't have a working RTAS and use
-	 * a different way to spin CPUs
+	 * On non-powermacs, try to instantiate RTAS. PowerMacs don't
+	 * have a usable RTAS implementation.
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC) {
+	if (RELOC(of_platform) != PLATFORM_POWERMAC)
 		prom_instantiate_rtas();
-		prom_hold_cpus();
+
+#ifdef CONFIG_PPC_POWERNV
+	/* Detect HAL and try instanciating it & doing takeover */
+	if (RELOC(of_platform) == PLATFORM_PSERIES_LPAR) {
+		prom_query_opal();
+		if (RELOC(of_platform) == PLATFORM_OPAL) {
+			prom_opal_hold_cpus();
+			prom_opal_takeover();
+		}
 	}
+#endif
+
+	/*
+	 * On non-powermacs, put all CPUs in spin-loops.
+	 *
+	 * PowerMacs use a different mechanism to spin CPUs
+	 */
+	if (RELOC(of_platform) != PLATFORM_POWERMAC)
+		prom_hold_cpus();
 
 	/*
 	 * Fill in some infos for use by the kernel later on
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 9f82f49..20af6aa 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,8 @@ WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2 kernstart_addr memstart_addr linux_banner"
+reloc_got2 kernstart_addr memstart_addr linux_banner _stext
+opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry"
 
 NM="$1"
 OBJ="$2"
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 1c43250..4971330 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,2 +1,2 @@
-obj-y			+= setup.o
+obj-y			+= setup.o opal-takeover.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/powerpc/platforms/powernv/opal-takeover.S b/arch/powerpc/platforms/powernv/opal-takeover.S
new file mode 100644
index 0000000..77b48b2
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-takeover.S
@@ -0,0 +1,140 @@
+/*
+ * PowerNV OPAL takeover assembly code, for use by prom_init.c
+ *
+ * Copyright 2011 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/hvcall.h>
+#include <asm/asm-offsets.h>
+#include <asm/opal.h>
+
+#define STK_PARAM(i)	(48 + ((i)-3)*8)
+
+#define H_HAL_TAKEOVER			0x5124
+#define H_HAL_TAKEOVER_QUERY_MAGIC	-1
+
+	.text
+_GLOBAL(opal_query_takeover)
+	mfcr	r0
+	stw	r0,8(r1)
+	std	r3,STK_PARAM(r3)(r1)
+	std	r4,STK_PARAM(r4)(r1)
+	li	r3,H_HAL_TAKEOVER
+	li	r4,H_HAL_TAKEOVER_QUERY_MAGIC
+	HVSC
+	ld	r10,STK_PARAM(r3)(r1)
+	std	r4,0(r10)
+	ld	r10,STK_PARAM(r4)(r1)
+	std	r5,0(r10)
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+	blr
+
+_GLOBAL(opal_do_takeover)
+	mfcr	r0
+	stw	r0,8(r1)
+	mflr	r0
+	std	r0,16(r1)
+	bl	__opal_do_takeover
+	ld	r0,16(r1)
+	mtlr	r0
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+	blr
+
+__opal_do_takeover:
+	ld	r4,0(r3)
+	ld	r5,0x8(r3)
+	ld	r6,0x10(r3)
+	ld	r7,0x18(r3)
+	ld	r8,0x20(r3)
+	ld	r9,0x28(r3)
+	ld	r10,0x30(r3)
+	ld	r11,0x38(r3)
+	li	r3,H_HAL_TAKEOVER
+	HVSC
+	blr
+
+	.globl opal_secondary_entry
+opal_secondary_entry:
+	mr	r31,r3
+	mfmsr	r11
+	li	r12,(MSR_SF | MSR_ISF)@highest
+	sldi	r12,r12,48
+	or	r11,r11,r12
+	mtmsrd	r11
+	isync
+	mfspr	r4,SPRN_PIR
+	std	r4,0(r3)
+1:	HMT_LOW
+	ld	r4,8(r3)
+	cmpli	cr0,r4,0
+	beq	1b
+	HMT_MEDIUM
+1:	addi	r3,r31,16
+	bl	__opal_do_takeover
+	b	1b
+
+_GLOBAL(opal_enter_rtas)
+	mflr	r0
+	std	r0,16(r1)
+        stdu	r1,-PROM_FRAME_SIZE(r1)	/* Save SP and create stack space */
+
+	/* Because PROM is running in 32b mode, it clobbers the high order half
+	 * of all registers that it saves.  We therefore save those registers
+	 * PROM might touch to the stack.  (r0, r3-r13 are caller saved)
+	*/
+	SAVE_GPR(2, r1)
+	SAVE_GPR(13, r1)
+	SAVE_8GPRS(14, r1)
+	SAVE_10GPRS(22, r1)
+	mfcr	r10
+	mfmsr	r11
+	std	r10,_CCR(r1)
+	std	r11,_MSR(r1)
+
+	/* Get the PROM entrypoint */
+	mtlr	r5
+
+	/* Switch MSR to 32 bits mode
+	 */
+        li      r12,1
+        rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
+        andc    r11,r11,r12
+        li      r12,1
+        rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
+        andc    r11,r11,r12
+        mtmsrd  r11
+        isync
+
+	/* Enter RTAS here... */
+	blrl
+
+	/* Just make sure that r1 top 32 bits didn't get
+	 * corrupt by OF
+	 */
+	rldicl	r1,r1,0,32
+
+	/* Restore the MSR (back to 64 bits) */
+	ld	r0,_MSR(r1)
+	MTMSRD(r0)
+        isync
+
+	/* Restore other registers */
+	REST_GPR(2, r1)
+	REST_GPR(13, r1)
+	REST_8GPRS(14, r1)
+	REST_10GPRS(22, r1)
+	ld	r4,_CCR(r1)
+	mtcr	r4
+
+        addi	r1,r1,PROM_FRAME_SIZE
+	ld	r0,16(r1)
+	mtlr    r0
+	blr
-- 
1.7.4.1
