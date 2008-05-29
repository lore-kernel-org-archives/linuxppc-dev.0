Return-Path: <mohan@in.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96C1ADDFCD
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 05:18:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4TJI9Ch014118
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 15:18:09 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4TJI6C6114022
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:18:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4TJI6jZ013666
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 13:18:06 -0600
Date: Fri, 30 May 2008 00:48:02 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [RFC PATCH 4/4] Relocation support
Message-ID: <20080529191802.GD15762@in.ibm.com>
References: <20080529190809.GA15388@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080529190809.GA15388@in.ibm.com>
Cc: paulus@samba.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Relocation support

This patch changes all LOAD_REG_ADDR macro calls to LOAD_REG_IMMEDIATE
to make sure that we load the correct address. It also takes care of
absolute symbols access in the code by adding the relocation kernel base
address.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
Index: linux-2.6.26-rc3/arch/powerpc/kernel/crash_dump.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/crash_dump.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/crash_dump.c
@@ -26,10 +26,57 @@
 #define DBG(fmt...)
 #endif
 
+extern unsigned long long reloc_delta;
+
+#ifdef CONFIG_RELOCATABLE_PPC64
+void __init reserve_kdump_trampoline(void)
+{
+	if (RELOC(reloc_delta))
+		lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+}
+#else
 void __init reserve_kdump_trampoline(void)
 {
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
 }
+#endif
+
+#ifdef CONFIG_RELOCATABLE_PPC64
+static void __init create_trampoline(unsigned long addr)
+{
+	/* The maximum range of a single instruction branch, is the current
+	 * instruction's address + (32 MB - 4) bytes. For the trampoline we
+	 * need to branch to current address + 32 MB. So we insert a nop at
+	 * the trampoline address, then the next instruction (+ 4 bytes)
+	 * does a branch to (32 MB - 4). The net effect is that when we
+	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
+	 * two instructions it doesn't require any registers.
+	 */
+	create_instruction(addr, 0x60000000); /* nop */
+	create_branch(addr + 4, addr + RELOC(reloc_delta), 0);
+}
+
+void __init setup_kdump_trampoline(void)
+{
+	unsigned long i;
+
+	DBG(" -> setup_kdump_trampoline()\n");
+
+	if (!RELOC(reloc_delta))
+		return;
+
+	for (i = KDUMP_TRAMPOLINE_START; i < KDUMP_TRAMPOLINE_END; i += 8)
+		create_trampoline(i);
+
+#ifdef CONFIG_PPC_PSERIES
+	create_trampoline(__pa(system_reset_fwnmi) - RELOC(reloc_delta));
+	create_trampoline(__pa(machine_check_fwnmi) - RELOC(reloc_delta));
+#endif /* CONFIG_PPC_PSERIES */
+
+	DBG(" <- setup_kdump_trampoline()\n");
+}
+
+#else
 
 static void __init create_trampoline(unsigned long addr)
 {
@@ -62,6 +109,7 @@ void __init setup_kdump_trampoline(void)
 
 	DBG(" <- setup_kdump_trampoline()\n");
 }
+#endif
 
 #ifdef CONFIG_PROC_VMCORE
 static int __init parse_elfcorehdr(char *p)
Index: linux-2.6.26-rc3/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/entry_64.S
+++ linux-2.6.26-rc3/arch/powerpc/kernel/entry_64.S
@@ -709,7 +709,7 @@ _GLOBAL(enter_rtas)
         std	r6,PACASAVEDMSR(r13)
 
 	/* Setup our real return addr */	
-	LOAD_REG_ADDR(r4,.rtas_return_loc)
+	LOAD_REG_IMMEDIATE(r4,.rtas_return_loc)
 	clrldi	r4,r4,2			/* convert to realmode address */
        	mtlr	r4
 
@@ -725,7 +725,7 @@ _GLOBAL(enter_rtas)
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
 
-	LOAD_REG_ADDR(r4, rtas)
+	LOAD_REG_IMMEDIATE(r4, rtas)
 	ld	r5,RTASENTRY(r4)	/* get the rtas->entry value */
 	ld	r4,RTASBASE(r4)		/* get the rtas->base value */
 	
Index: linux-2.6.26-rc3/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6.26-rc3/arch/powerpc/kernel/head_64.S
@@ -102,6 +102,12 @@ __secondary_hold_acknowledge:
 	.llong hvReleaseData-KERNELBASE
 #endif /* CONFIG_PPC_ISERIES */
 
+#ifdef CONFIG_RELOCATABLE_PPC64
+	/* Used as static variable to initialize the reloc_delta */
+__initialized:
+	.long 0x0
+#endif
+
 	. = 0x60
 /*
  * The following code is used to hold secondary processors
@@ -121,11 +127,13 @@ _GLOBAL(__secondary_hold)
 	/* Tell the master cpu we're here */
 	/* Relocation is off & we are located at an address less */
 	/* than 0x100, so only need to grab low order offset.    */
-	std	r24,__secondary_hold_acknowledge@l(0)
+	LOAD_REG_IMMEDIATE(r25, __secondary_hold_acknowledge)
+	std	r24,0(r25)
 	sync
 
 	/* All secondary cpus wait here until told to start. */
-100:	ld	r4,__secondary_hold_spinloop@l(0)
+	LOAD_REG_IMMEDIATE(r25, __secondary_hold_spinloop)
+100:	ld	r4,0(r25)
 	cmpdi	0,r4,1
 	bne	100b
 
@@ -1176,6 +1184,38 @@ _STATIC(__mmu_off)
  *
  */
 _GLOBAL(__start_initialization_multiplatform)
+#ifdef CONFIG_RELOCATABLE_PPC64
+	mr	r21,r3
+	mr	r22,r4
+	mr	r23,r5
+	bl	.reloc_offset
+	mr	r26,r3
+	mr	r3,r21
+	mr	r4,r22
+	mr	r5,r23
+
+	LOAD_REG_IMMEDIATE(r27, __initialized)
+	add	r27,r26,r27
+	ld	r7,0(r27)
+	cmpdi	r7,0
+	bne	4f
+
+	li	r7,1
+	stw	r7,0(r27)
+
+	cmpdi	r6,0
+	beq	4f
+	LOAD_REG_IMMEDIATE(r27, reloc_delta)
+	add	r27,r27,r26
+	std	r6,0(r27)
+
+	LOAD_REG_IMMEDIATE(r27, KERNELBASE)
+	add	r7,r6,r27
+	LOAD_REG_IMMEDIATE(r27, kernel_base)
+	add	r27,r27,r26
+	std	r7,0(r27)
+4:
+#endif
 	/*
 	 * Are we booted from a PROM Of-type client-interface ?
 	 */
@@ -1251,6 +1291,19 @@ _INIT_STATIC(__boot_from_prom)
 	trap
 
 _STATIC(__after_prom_start)
+	bl	.reloc_offset
+	mr	r26,r3
+#ifdef CONFIG_RELOCATABLE_PPC64
+	/*
+	 * If its a relocatable kernel, no need to copy the kernel
+	 * to PHYSICAL_START. Continue running from the same location
+	 */
+	LOAD_REG_IMMEDIATE(r27, reloc_delta)
+	add	r27,r27,r26
+	ld	r28,0(r27)
+	cmpdi	r28,0
+	bne	.start_here_multiplatform
+#endif
 
 /*
  * We need to run with __start at physical address PHYSICAL_START.
@@ -1264,8 +1317,6 @@ _STATIC(__after_prom_start)
  *	r26 == relocation offset
  *	r27 == KERNELBASE
  */
-	bl	.reloc_offset
-	mr	r26,r3
 	LOAD_REG_IMMEDIATE(r27, KERNELBASE)
 
 	LOAD_REG_IMMEDIATE(r3, PHYSICAL_START)	/* target addr */
@@ -1411,7 +1462,7 @@ __secondary_start:
 	bl	.early_setup_secondary
 
 	/* Initialize the kernel stack.  Just a repeat for iSeries.	 */
-	LOAD_REG_ADDR(r3, current_set)
+	LOAD_REG_IMMEDIATE(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
 	ldx	r1,r3,r28
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
@@ -1422,7 +1473,7 @@ __secondary_start:
 	mtlr	r7
 
 	/* enable MMU and jump to start_secondary */
-	LOAD_REG_ADDR(r3, .start_secondary_prolog)
+	LOAD_REG_IMMEDIATE(r3, .start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
Index: linux-2.6.26-rc3/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/machine_kexec.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/machine_kexec.c
@@ -16,6 +16,8 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 
+extern unsigned long long reloc_delta;
+
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown)
@@ -67,6 +69,11 @@ void __init reserve_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
+#ifdef CONFIG_RELOCATABLE_PPC64
+	if (reloc_delta)
+		return;
+#endif
+
 	/* this is necessary because of lmb_phys_mem_size() */
 	lmb_analyze();
 
Index: linux-2.6.26-rc3/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/machine_kexec_64.c
@@ -25,6 +25,8 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 
+extern unsigned long long kernel_base;
+
 int default_machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -43,7 +45,7 @@ int default_machine_kexec_prepare(struct
 	 * overlaps kernel static data or bss.
 	 */
 	for (i = 0; i < image->nr_segments; i++)
-		if (image->segment[i].mem < __pa(_end))
+		if (image->segment[i].mem < __pa(_end) + kernel_base)
 			return -ETXTBSY;
 
 	/*
@@ -317,7 +319,7 @@ static void __init export_htab_values(vo
 	if (!node)
 		return;
 
-	kernel_end = __pa(_end);
+	kernel_end = __pa(_end) + kernel_base;
 	prom_add_property(node, &kernel_end_prop);
 
 	/* On machines with no htab htab_address is NULL */
Index: linux-2.6.26-rc3/arch/powerpc/kernel/misc.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/misc.S
+++ linux-2.6.26-rc3/arch/powerpc/kernel/misc.S
@@ -20,6 +20,8 @@
 #include <asm/asm-compat.h>
 #include <asm/asm-offsets.h>
 
+#define RELOC_DELTA 0x4000000002000000
+
 	.text
 
 /*
@@ -33,6 +35,17 @@ _GLOBAL(reloc_offset)
 1:	mflr	r3
 	LOAD_REG_IMMEDIATE(r4,1b)
 	subf	r3,r4,r3
+#ifdef CONFIG_RELOCATABLE_PPC64
+	LOAD_REG_IMMEDIATE(r5, RELOC_DELTA)
+	cmpd	r3,r5
+	bne	2f
+	/*
+	 * Don't return the offset if the difference is
+	 * RELOC_DELTA
+	 */
+	li	r3,0
+2:
+#endif
 	mtlr	r0
 	blr
 
@@ -40,14 +53,25 @@ _GLOBAL(reloc_offset)
  * add_reloc_offset(x) returns x + reloc_offset().
  */
 _GLOBAL(add_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	LOAD_REG_IMMEDIATE(r4,1b)
-	subf	r5,r4,r5
-	add	r3,r3,r5
-	mtlr	r0
-	blr
+        mflr    r0
+        bl      1f
+1:      mflr    r5
+        LOAD_REG_IMMEDIATE(r4,1b)
+        subf    r5,r4,r5
+#ifdef CONFIG_RELOCATABLE_PPC64
+	LOAD_REG_IMMEDIATE(r4, RELOC_DELTA)
+	cmpd	r5,r4
+	bne	2f
+	/*
+	 * Don't add the offset if the difference is
+	 * RELOC_DELTA
+	 */
+	li	r5,0
+2:
+#endif
+        add     r3,r3,r5
+        mtlr    r0
+        blr
 
 _GLOBAL(kernel_execve)
 	li	r0,__NR_execve
Index: linux-2.6.26-rc3/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/prom.c
@@ -65,6 +65,9 @@
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 
+unsigned long long reloc_delta __attribute__ ((__section__ (".data")));
+unsigned long long kernel_base __attribute__ ((__section__ (".data")));
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -1125,7 +1128,6 @@ static void __init phyp_dump_reserve_mem
 static inline void __init phyp_dump_reserve_mem(void) {}
 #endif /* CONFIG_PHYP_DUMP  && CONFIG_PPC_RTAS */
 
-
 void __init early_init_devtree(void *params)
 {
 	DBG(" -> early_init_devtree(%p)\n", params);
@@ -1159,8 +1161,16 @@ void __init early_init_devtree(void *par
 	parse_early_param();
 
 	/* Reserve LMB regions used by kernel, initrd, dt, etc... */
-	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	reserve_kdump_trampoline();
+#ifdef CONFIG_RELOCATABLE_PPC64
+	if (RELOC(kernel_base)) {
+		lmb_reserve(0, KDUMP_RESERVE_LIMIT);
+		lmb_reserve(kernel_base, __pa(klimit) - PHYSICAL_START);
+	} else
+		lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+#else
+	lmb_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
+#endif
 	reserve_crashkernel();
 	early_reserve_mem();
 	phyp_dump_reserve_mem();
Index: linux-2.6.26-rc3/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/prom_init.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/prom_init.c
@@ -91,16 +91,16 @@ extern const struct linux_logo logo_linu
  * fortunately don't get interpreted as two arguments).
  */
 #ifdef CONFIG_PPC64
-#define RELOC(x)        (*PTRRELOC(&(x)))
 #define ADDR(x)		(u32) add_reloc_offset((unsigned long)(x))
 #define OF_WORKAROUNDS	0
 #else
-#define RELOC(x)	(x)
 #define ADDR(x)		(u32) (x)
 #define OF_WORKAROUNDS	of_workarounds
 int of_workarounds;
 #endif
 
+extern unsigned long long reloc_delta;
+
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
 #define OF_WA_LONGTRAIL	2	/* work around longtrail bugs */
 
@@ -1070,7 +1070,8 @@ static void __init prom_init_mem(void)
 		}
 	}
 
-	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
+	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000 +
+							RELOC(reloc_delta));
 
 	/* Check if we have an initrd after the kernel, if we do move our bottom
 	 * point to after it
@@ -1321,7 +1322,7 @@ extern unsigned long __secondary_hold_ac
  * We want to reference the copy of __secondary_hold_* in the
  * 0 - 0x100 address range
  */
-#define LOW_ADDR(x)	(((unsigned long) &(x)) & 0xff)
+#define LOW_ADDR(x)    (((unsigned long) &(x)) & 0xff)
 
 static void __init prom_hold_cpus(void)
 {
@@ -1334,10 +1335,18 @@ static void __init prom_hold_cpus(void)
 	unsigned int cpu_threads, hw_cpu_num;
 	int propsize;
 	struct prom_t *_prom = &RELOC(prom);
+#ifndef CONFIG_RELOCATABLE_PPC64
 	unsigned long *spinloop
 		= (void *) LOW_ADDR(__secondary_hold_spinloop);
 	unsigned long *acknowledge
 		= (void *) LOW_ADDR(__secondary_hold_acknowledge);
+#else
+	unsigned long *spinloop
+		= (void *) &__secondary_hold_spinloop;
+	unsigned long *acknowledge
+		= (void *) &__secondary_hold_acknowledge;
+#endif
+
 #ifdef CONFIG_PPC64
 	/* __secondary_hold is actually a descriptor, not the text address */
 	unsigned long secondary_hold
@@ -2399,8 +2408,15 @@ unsigned long __init prom_init(unsigned 
 	/*
 	 * Copy the CPU hold code
 	 */
-	if (RELOC(of_platform) != PLATFORM_POWERMAC)
-		copy_and_flush(0, KERNELBASE + offset, 0x100, 0);
+	if (RELOC(of_platform) != PLATFORM_POWERMAC) {
+#ifdef CONFIG_RELOCATABLE_PPC64
+		if (RELOC(reloc_delta))
+			copy_and_flush(0, KERNELBASE + RELOC(reloc_delta),
+								0x100, 0);
+		else
+#endif
+			copy_and_flush(0, KERNELBASE + offset, 0x100, 0);
+	}
 
 	/*
 	 * Do early parsing of command line
Index: linux-2.6.26-rc3/arch/powerpc/kernel/prom_init_check.sh
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/prom_init_check.sh
+++ linux-2.6.26-rc3/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,7 @@ WHITELIST="add_reloc_offset __bss_start 
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2"
+reloc_got2 reloc_delta"
 
 NM="$1"
 OBJ="$2"
Index: linux-2.6.26-rc3/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6.26-rc3/arch/powerpc/kernel/setup_64.c
@@ -74,6 +74,8 @@ int have_of = 1;
 int boot_cpuid = 0;
 u64 ppc64_pft_size;
 
+extern unsigned long long reloc_delta, kernel_base;
+
 /* Pick defaults since we might want to patch instructions
  * before we've read this from the device tree.
  */
@@ -208,7 +210,6 @@ void __init early_setup(unsigned long dt
 
 	/* Probe the machine type */
 	probe_machine();
-
 	setup_kdump_trampoline();
 
 	DBG("Found, Initializing memory management...\n");
@@ -524,9 +525,9 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.panic)
 		setup_panic();
 
-	init_mm.start_code = (unsigned long)_stext;
+	init_mm.start_code = (unsigned long)_stext + kernel_base;
 	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
+	init_mm.end_data = (unsigned long) _edata + kernel_base;
 	init_mm.brk = klimit;
 	
 	irqstack_early_init();
Index: linux-2.6.26-rc3/arch/powerpc/mm/hash_low_64.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/mm/hash_low_64.S
+++ linux-2.6.26-rc3/arch/powerpc/mm/hash_low_64.S
@@ -83,7 +83,7 @@ _GLOBAL(__hash_page_4K)
 	std	r29,STK_REG(r29)(r1)
 	std	r30,STK_REG(r30)(r1)
 	std	r31,STK_REG(r31)(r1)
-	
+
 	/* Step 1:
 	 *
 	 * Check permissions, atomically mark the linux PTE busy
@@ -168,7 +168,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -461,7 +461,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -788,7 +788,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
Index: linux-2.6.26-rc3/arch/powerpc/mm/init_64.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/mm/init_64.c
+++ linux-2.6.26-rc3/arch/powerpc/mm/init_64.c
@@ -77,12 +77,15 @@
 phys_addr_t memstart_addr = ~0;
 phys_addr_t kernstart_addr;
 
+extern unsigned long long kernel_base;
+
 void free_initmem(void)
 {
-	unsigned long addr;
+	unsigned long long addr, eaddr;
 
-	addr = (unsigned long)__init_begin;
-	for (; addr < (unsigned long)__init_end; addr += PAGE_SIZE) {
+	addr = (unsigned long long )__init_begin + kernel_base;
+	eaddr = (unsigned long long ) __init_end + kernel_base;
+	for (; addr < eaddr; addr += PAGE_SIZE) {
 		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
Index: linux-2.6.26-rc3/arch/powerpc/mm/mem.c
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/mm/mem.c
+++ linux-2.6.26-rc3/arch/powerpc/mm/mem.c
@@ -376,6 +376,8 @@ void __init mem_init(void)
 	struct page *page;
 	unsigned long reservedpages = 0, codesize, initsize, datasize, bsssize;
 
+	extern unsigned long long reloc_delta, kernel_base;
+
 	num_physpages = lmb.memory.size >> PAGE_SHIFT;
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
@@ -401,7 +403,8 @@ void __init mem_init(void)
 		}
 	}
 
-	codesize = (unsigned long)&_sdata - (unsigned long)&_stext;
+	codesize = (unsigned long)&_sdata - (unsigned long)&_stext
+						+ kernel_base;
 	datasize = (unsigned long)&_edata - (unsigned long)&_sdata;
 	initsize = (unsigned long)&__init_end - (unsigned long)&__init_begin;
 	bsssize = (unsigned long)&__bss_stop - (unsigned long)&__bss_start;
Index: linux-2.6.26-rc3/arch/powerpc/mm/slb_low.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/mm/slb_low.S
+++ linux-2.6.26-rc3/arch/powerpc/mm/slb_low.S
@@ -128,7 +128,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT
 	/* Now get to the array and obtain the sllp
 	 */
 	ld	r11,PACATOC(r13)
-	ld	r11,mmu_psize_defs@got(r11)
+	LOAD_REG_IMMEDIATE(r11, mmu_psize_defs)
 	add	r11,r11,r9
 	ld	r11,MMUPSIZESLLP(r11)
 	ori	r11,r11,SLB_VSID_USER
Index: linux-2.6.26-rc3/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- linux-2.6.26-rc3.orig/arch/powerpc/platforms/pseries/hvCall.S
+++ linux-2.6.26-rc3/arch/powerpc/platforms/pseries/hvCall.S
@@ -55,7 +55,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_PURR);				
 	/* calculate address of stat structure r4 = opcode */	\
 	srdi	r4,r4,2;		/* index into array */	\
 	mulli	r4,r4,HCALL_STAT_SIZE;				\
-	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
+	LOAD_REG_IMMEDIATE(r7, per_cpu__hcall_stats);		\
 	add	r4,r4,r7;					\
 	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
 	add	r4,r4,r7;					\
Index: linux-2.6.26-rc3/include/asm-powerpc/exception.h
===================================================================
--- linux-2.6.26-rc3.orig/include/asm-powerpc/exception.h
+++ linux-2.6.26-rc3/include/asm-powerpc/exception.h
@@ -47,12 +47,6 @@
 #define EX_R3		64
 #define EX_LR		72
 
-/*
- * We're short on space and time in the exception prolog, so we can't
- * use the normal SET_REG_IMMEDIATE macro. Normally we just need the
- * low halfword of the address, but for Kdump we need the whole low
- * word.
- */
 #ifdef CONFIG_CRASH_DUMP
 #define LOAD_HANDLER(reg, label)					\
 	oris	reg,reg,(label)@h;	/* virt addr of handler ... */	\
Index: linux-2.6.26-rc3/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.26-rc3.orig/include/asm-powerpc/system.h
+++ linux-2.6.26-rc3/include/asm-powerpc/system.h
@@ -517,6 +517,11 @@ extern unsigned long add_reloc_offset(un
 extern void reloc_got2(unsigned long);
 
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
+#ifdef CONFIG_PPC64
+#define RELOC(x)        (*PTRRELOC(&(x)))
+#else
+#define RELOC(x)	(x)
+#endif
 
 static inline void create_instruction(unsigned long addr, unsigned int instr)
 {
Index: linux-2.6.26-rc3/include/asm-powerpc/sections.h
===================================================================
--- linux-2.6.26-rc3.orig/include/asm-powerpc/sections.h
+++ linux-2.6.26-rc3/include/asm-powerpc/sections.h
@@ -7,10 +7,12 @@
 #ifdef __powerpc64__
 
 extern char _end[];
+extern unsigned long long reloc_delta, kernel_base;
 
 static inline int in_kernel_text(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end
+								+ kernel_base)
 		return 1;
 
 	return 0;
