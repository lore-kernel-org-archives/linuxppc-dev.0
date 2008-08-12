Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55658DDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 18:11:12 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7C8B6Oe027256
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:11:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7C8B6Fg140668
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:11:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7C8B6mV018850
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 04:11:06 -0400
Date: Tue, 12 Aug 2008 13:41:03 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/5] Relocation support
Message-ID: <20080812081103.GD19619@in.ibm.com>
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201644.GD26566@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080811201644.GD26566@in.ibm.com>
Cc: paulus@samba.org, miltonm@bga.com
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

Add relocatable kernel support like avoiding copying the vmlinux
image to compile address, adding relocation delta to the absolute
symbol references etc. ld does not provide relocation entries for
.got section, and the user space relocation extraction program
can not process @got entries.  So use LOAD_REG_IMMEDIATE macro
instead of LOAD_REG_ADDR macro for relocatable kernel.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/include/asm/ppc_asm.h     |    4 ++
 arch/powerpc/include/asm/prom.h        |    2 +
 arch/powerpc/include/asm/sections.h    |    4 ++-
 arch/powerpc/include/asm/system.h      |    5 +++
 arch/powerpc/kernel/head_64.S          |   53 ++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/machine_kexec_64.c |    4 +-
 arch/powerpc/kernel/misc.S             |   40 +++++++++++++++++++-----
 arch/powerpc/kernel/prom.c             |   13 +++++++-
 arch/powerpc/kernel/prom_init.c        |   27 +++++++++++++---
 arch/powerpc/kernel/prom_init_check.sh |    2 +-
 arch/powerpc/kernel/setup_64.c         |    5 +--
 arch/powerpc/mm/hash_low_64.S          |   12 +++++++
 arch/powerpc/mm/init_64.c              |    7 ++--
 arch/powerpc/mm/mem.c                  |    3 +-
 arch/powerpc/mm/slb_low.S              |    4 ++
 15 files changed, 158 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 0966899..2309ad0 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -295,8 +295,12 @@ n:
 	oris    (reg),(reg),(expr)@h;		\
 	ori     (reg),(reg),(expr)@l;
 
+#ifdef CONFIG_RELOCATABLE_PPC64
+#define LOAD_REG_ADDR(reg,name)		LOAD_REG_IMMEDIATE(reg,name)
+#else
 #define LOAD_REG_ADDR(reg,name)			\
 	ld	(reg),name@got(r2)
+#endif
 
 #define LOAD_REG_ADDRBASE(reg,name)	LOAD_REG_ADDR(reg,name)
 #define ADDROFF(name)			0
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index eb3bd2e..4d7aa4f 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -39,6 +39,8 @@
 
 #define OF_DT_VERSION		0x10
 
+extern unsigned long reloc_delta, kernel_base;
+
 /*
  * This is what gets passed to the kernel by prom_init or kexec
  *
diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 916018e..f19dab3 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -7,10 +7,12 @@
 #ifdef __powerpc64__
 
 extern char _end[];
+extern unsigned long kernel_base;
 
 static inline int in_kernel_text(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end
+								+ kernel_base)
 		return 1;
 
 	return 0;
diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index d6648c1..065c830 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -537,6 +537,11 @@ extern unsigned long add_reloc_offset(unsigned long);
 extern void reloc_got2(unsigned long);
 
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
+#ifdef CONFIG_PPC64
+#define RELOC(x)	(*PTRRELOC(&(x)))
+#else
+#define RELOC(x)	(x)
+#endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void account_system_vtime(struct task_struct *);
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cc8fb47..6274686 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
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
@@ -1248,6 +1254,38 @@ _STATIC(__mmu_off)
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
@@ -1323,6 +1361,19 @@ _INIT_STATIC(__boot_from_prom)
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
@@ -1336,8 +1387,6 @@ _STATIC(__after_prom_start)
  *	r26 == relocation offset
  *	r27 == KERNELBASE
  */
-	bl	.reloc_offset
-	mr	r26,r3
 	LOAD_REG_IMMEDIATE(r27, KERNELBASE)
 
 	LOAD_REG_IMMEDIATE(r3, PHYSICAL_START)	/* target addr */
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a168514..ce19c44 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -43,7 +43,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 	 * overlaps kernel static data or bss.
 	 */
 	for (i = 0; i < image->nr_segments; i++)
-		if (image->segment[i].mem < __pa(_end))
+		if (image->segment[i].mem < (__pa(_end) + kernel_base))
 			return -ETXTBSY;
 
 	/*
@@ -317,7 +317,7 @@ static void __init export_htab_values(void)
 	if (!node)
 		return;
 
-	kernel_end = __pa(_end);
+	kernel_end = __pa(_end) + kernel_base;
 	prom_add_property(node, &kernel_end_prop);
 
 	/* On machines with no htab htab_address is NULL */
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 85cb6f3..28718ed 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
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
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 87d83c5..453dc98 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -65,6 +65,9 @@
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 
+unsigned long reloc_delta __attribute__ ((__section__ (".data")));
+unsigned long kernel_base __attribute__ ((__section__ (".data")));
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -1163,8 +1166,16 @@ void __init early_init_devtree(void *params)
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
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index b72849a..8e8ddbe 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -91,11 +91,9 @@ extern const struct linux_logo logo_linux_clut224;
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
@@ -1078,7 +1076,12 @@ static void __init prom_init_mem(void)
 		}
 	}
 
-	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
+#ifndef CONFIG_RELOCATABLE_PPC64
+ 	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
+#else
+	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000 +
+							RELOC(reloc_delta));
+#endif
 
 	/* Check if we have an initrd after the kernel, if we do move our bottom
 	 * point to after it
@@ -1338,10 +1341,17 @@ static void __init prom_hold_cpus(void)
 	phandle node;
 	char type[64];
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
 #ifdef CONFIG_PPC64
 	/* __secondary_hold is actually a descriptor, not the text address */
 	unsigned long secondary_hold
@@ -2376,8 +2386,15 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
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
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 2c7e8e8..3cc7e24 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,7 @@ WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2 kernstart_addr"
+reloc_got2 kernstart_addr reloc_delta"
 
 NM="$1"
 OBJ="$2"
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8b25f51..5498662 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -208,7 +208,6 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Probe the machine type */
 	probe_machine();
-
 	setup_kdump_trampoline();
 
 	DBG("Found, Initializing memory management...\n");
@@ -526,9 +525,9 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.panic)
 		setup_panic();
 
-	init_mm.start_code = (unsigned long)_stext;
+	init_mm.start_code = (unsigned long)_stext + kernel_base;
 	init_mm.end_code = (unsigned long) _etext;
-	init_mm.end_data = (unsigned long) _edata;
+	init_mm.end_data = (unsigned long) _edata + kernel_base;
 	init_mm.brk = klimit;
 	
 	irqstack_early_init();
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index a719f53..acf64d9 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -168,7 +168,11 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
+#ifndef CONFIG_RELOCATABLE_PPC64
 	ld	r4,htab_hash_mask@got(2)
+#else
+	LOAD_REG_IMMEDIATE(r4,htab_hash_mask)
+#endif
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -461,7 +465,11 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
+#ifndef CONFIG_RELOCATABLE_PPC64
 	ld	r4,htab_hash_mask@got(2)
+#else
+	LOAD_REG_IMMEDIATE(r4,htab_hash_mask)
+#endif
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -792,7 +800,11 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
+#ifndef CONFIG_RELOCATABLE_PPC64
 	ld	r4,htab_hash_mask@got(2)
+#else
+	LOAD_REG_IMMEDIATE(r4,htab_hash_mask)
+#endif
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 4f7df85..086fa2d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -79,10 +79,11 @@ phys_addr_t kernstart_addr;
 
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
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1c93c25..04e5d06 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -362,7 +362,8 @@ void __init mem_init(void)
 		}
 	}
 
-	codesize = (unsigned long)&_sdata - (unsigned long)&_stext;
+	codesize = (unsigned long)&_sdata - (unsigned long)&_stext
+						+ kernel_base;
 	datasize = (unsigned long)&_edata - (unsigned long)&_sdata;
 	initsize = (unsigned long)&__init_end - (unsigned long)&__init_begin;
 	bsssize = (unsigned long)&__bss_stop - (unsigned long)&__bss_start;
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index bc44dc4..aadc389 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -128,7 +128,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
 	/* Now get to the array and obtain the sllp
 	 */
 	ld	r11,PACATOC(r13)
+#ifndef CONFIG_RELOCATABLE_PPC64
 	ld	r11,mmu_psize_defs@got(r11)
+#else
+	LOAD_REG_IMMEDIATE(r11,mmu_psize_defs)
+#endif
 	add	r11,r11,r9
 	ld	r11,MMUPSIZESLLP(r11)
 	ori	r11,r11,SLB_VSID_USER
-- 
1.5.4
