Date: Mon, 30 Jun 2003 14:57:02 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Terry Greeniaus <tgree@phys.ualberta.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: how to setup PLL1 on 750FX
In-Reply-To: <1056788580.32105.82.camel@gaston>
Message-ID: <Pine.LNX.4.44.0306301448490.12550-100000@stoa.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 28 Jun 2003, Benjamin Herrenschmidt wrote:
> Looks good. Just fix the cpu_setup_6xx.S code so that sleep mode
> works properly and it should be ok to merge upstream.

Oddly enough, sleep mode was working without HID1 and HID2 being saved;
however, I was occationally getting non-reproducable hangs on resume.
I've changed __save_cpu_setup and __restore_cpu_setup in cpu_setup_6xx.S
to use real_pvr now.  Sleep/resume works fine from both high speed and low
speed.  Also, I moved the setup of PLL1 to setup_750fx in cpu_setup_6xx.S.

Chris.


diff -b -c -r linux-2.4-benh.orig/Documentation/Configure.help linux-2.4-benh/Documentation/Configure.help
*** linux-2.4-benh.orig/Documentation/Configure.help	Mon Jun 16 04:32:31 2003
--- linux-2.4-benh/Documentation/Configure.help	Thu Jun 26 22:15:43 2003
***************
*** 22440,22445 ****
--- 22440,22456 ----

    If in doubt, say N.

+ BlueChip 750FX Support
+ CONFIG_BLUECHIP_750FX
+   If you have purchased a PowerLogix BlueChip G3 processor upgarde
+   for your machine, enabling this option will allow your IBM 750FX
+   processor to be correctly detected and allows you to use the
+   advanced features of your processor (namely, the variable clock
+   speed feature).  If you don't have this type of upgrade, this
+   option has no effect.
+
+   If in doubt, say N.
+
  # Choice: ppc4xxtype
  Oak
  CONFIG_OAK
diff -b -c -r linux-2.4-benh.orig/arch/ppc/config.in linux-2.4-benh/arch/ppc/config.in
*** linux-2.4-benh.orig/arch/ppc/config.in	Fri May 16 09:27:13 2003
--- linux-2.4-benh/arch/ppc/config.in	Thu Jun 26 22:04:18 2003
***************
*** 38,43 ****
--- 38,47 ----
    bool 'MPC8260 CPM Support' CONFIG_8260
  fi

+ if [ "$CONFIG_6xx" = "y" ]; then
+   bool 'BlueChip 750FX Support' CONFIG_BLUECHIP_750FX
+ fi
+
  if [ "$CONFIG_POWER3" = "y" -o "$CONFIG_POWER4" = "y" ]; then
    define_bool CONFIG_PPC64BRIDGE y
    define_bool CONFIG_ALL_PPC y
diff -b -c -r linux-2.4-benh.orig/arch/ppc/configs/pmac_defconfig linux-2.4-benh/arch/ppc/configs/pmac_defconfig
*** linux-2.4-benh.orig/arch/ppc/configs/pmac_defconfig	Mon Jun 16 04:40:40 2003
--- linux-2.4-benh/arch/ppc/configs/pmac_defconfig	Thu Jun 26 22:05:46 2003
***************
*** 29,34 ****
--- 29,35 ----
  # CONFIG_POWER4 is not set
  # CONFIG_8xx is not set
  # CONFIG_8260 is not set
+ # CONFIG_BLUECHIP_750FX is not set
  CONFIG_PPC_STD_MMU=y
  CONFIG_CPU_FREQ=y
  # CONFIG_CPU_FREQ_24_API is not set
diff -b -c -r linux-2.4-benh.orig/arch/ppc/defconfig linux-2.4-benh/arch/ppc/defconfig
*** linux-2.4-benh.orig/arch/ppc/defconfig	Mon Jun 16 04:40:40 2003
--- linux-2.4-benh/arch/ppc/defconfig	Thu Jun 26 22:06:51 2003
***************
*** 29,34 ****
--- 29,35 ----
  # CONFIG_POWER4 is not set
  # CONFIG_8xx is not set
  # CONFIG_8260 is not set
+ # CONFIG_BLUECHIP_750FX is not set
  CONFIG_PPC_STD_MMU=y
  CONFIG_ALL_PPC=y
  # CONFIG_APUS is not set
diff -b -c -r linux-2.4-benh.orig/arch/ppc/kernel/cpu_setup_6xx.S linux-2.4-benh/arch/ppc/kernel/cpu_setup_6xx.S
*** linux-2.4-benh.orig/arch/ppc/kernel/cpu_setup_6xx.S	Sat May  3 14:47:07 2003
--- linux-2.4-benh/arch/ppc/kernel/cpu_setup_6xx.S	Mon Jun 30 14:41:48 2003
***************
*** 185,192 ****
--- 185,210 ----
  	blr

  /* 750fx specific
+  * If PLL1 is not active, it is set to DEFAULT_PLL1_CONFIG.
   */
  setup_750fx:
+ #ifdef CONFIG_BLUECHIP_750FX
+ 	mfspr	r10,SPRN_HID1
+ 	andi.	r6,r10,0x00FE
+ 	bnelr
+ 	andis.	r6,r10,0x0001
+ 	bnelr
+
+ 	ori	r10,r10,DEFAULT_PLL1_CONFIG
+ 	mtspr	SPRN_HID1,r10
+
+ 	/* wait for PLL to stabilize (approx 0.4ms) */
+ 	mftbl	r7
+ 1:	mftbl	r6
+ 	sub	r6,r6,r7
+ 	cmpli	cr0,r6,10000
+ 	ble	1b
+ #endif /* CONFIG_BLUECHIP_750FX */
  	blr

  /* MPC 745x
***************
*** 282,288 ****
  	stw	r3,CS_HID0(r5)

  	/* Now deal with CPU type dependent registers */
! 	mfspr	r3,PVR
  	srwi	r3,r3,16
  	cmpli	cr0,r3,0x8000	/* 7450 */
  	cmpli	cr1,r3,0x000c	/* 7400 */
--- 300,307 ----
  	stw	r3,CS_HID0(r5)

  	/* Now deal with CPU type dependent registers */
! 	lis	r3,real_pvr@ha
! 	lwz	r3,real_pvr@l(r3)
  	srwi	r3,r3,16
  	cmpli	cr0,r3,0x8000	/* 7450 */
  	cmpli	cr1,r3,0x000c	/* 7400 */
***************
*** 318,324 ****
  	mfspr	r4,SPRN_HID1
  	stw	r4,CS_HID1(r5)
  	/* If rev 2.x, backup HID2 */
! 	mfspr	r3,PVR
  	andi.	r3,r3,0xff00
  	cmpi	cr0,r3,0x0200
  	bne	1f
--- 337,343 ----
  	mfspr	r4,SPRN_HID1
  	stw	r4,CS_HID1(r5)
  	/* If rev 2.x, backup HID2 */
! 	mfspr	r3,PVR	/* don't need real_pvr here */
  	andi.	r3,r3,0xff00
  	cmpi	cr0,r3,0x0200
  	bne	1f
***************
*** 349,355 ****
  	isync

  	/* Now deal with CPU type dependent registers */
! 	mfspr	r3,PVR
  	srwi	r3,r3,16
  	cmpli	cr0,r3,0x8000	/* 7450 */
  	cmpli	cr1,r3,0x000c	/* 7400 */
--- 368,375 ----
  	isync

  	/* Now deal with CPU type dependent registers */
! 	lis	r3,(real_pvr-KERNELBASE)@ha
! 	lwz	r3,real_pvr@l(r3)
  	srwi	r3,r3,16
  	cmpli	cr0,r3,0x8000	/* 7450 */
  	cmpli	cr1,r3,0x000c	/* 7400 */
***************
*** 407,413 ****
  	 * to PLL 0 on all
  	 */
  	/* If rev 2.x, restore HID2 with low voltage bit cleared */
! 	mfspr	r3,PVR
  	andi.	r3,r3,0xff00
  	cmpi	cr0,r3,0x0200
  	bne	4f
--- 427,433 ----
  	 * to PLL 0 on all
  	 */
  	/* If rev 2.x, restore HID2 with low voltage bit cleared */
! 	mfspr	r3,PVR	/* don't need real_pvr here */
  	andi.	r3,r3,0xff00
  	cmpi	cr0,r3,0x0200
  	bne	4f
diff -b -c -r linux-2.4-benh.orig/arch/ppc/kernel/cputable.c linux-2.4-benh/arch/ppc/kernel/cputable.c
*** linux-2.4-benh.orig/arch/ppc/kernel/cputable.c	Mon Jun 16 04:40:40 2003
--- linux-2.4-benh/arch/ppc/kernel/cputable.c	Thu Jun 26 17:38:35 2003
***************
*** 18,23 ****
--- 18,25 ----

  struct cpu_spec* cur_cpu_spec[NR_CPUS];

+ unsigned int real_pvr;
+
  extern void __setup_cpu_601(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
  extern void __setup_cpu_603(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
  extern void __setup_cpu_604(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
diff -b -c -r linux-2.4-benh.orig/arch/ppc/kernel/misc.S linux-2.4-benh/arch/ppc/kernel/misc.S
*** linux-2.4-benh.orig/arch/ppc/kernel/misc.S	Thu Mar 27 05:43:31 2003
--- linux-2.4-benh/arch/ppc/kernel/misc.S	Mon Jun 30 12:08:47 2003
***************
*** 113,118 ****
--- 113,140 ----
  	addis	r8,r3,cpu_specs@ha
  	addi	r8,r8,cpu_specs@l
  	mfpvr	r7
+
+ #ifdef CONFIG_BLUECHIP_750FX
+ 	/* if pvr reports 750, check for 750fx */
+ 	srwi	r6,r7,16
+ 	cmpli	0,r6,8
+ 	bne	1f
+
+ 	mfspr   r5,SPRN_HID1
+ 	andis.  r6,r5,0x0001
+ 	xori	r6,r5,0x0002
+ 	beq     2f
+ 	xori	r6,r5,0x0200
+ 2:	mtspr	SPRN_HID1,r6
+ 	mfspr	r6,SPRN_HID1
+ 	cmplw	0,r5,r6
+ 	beq	1f
+
+ 	/* pvr is actually 0x7000nnnn, not 0x0008nnnn */
+ 	xoris	r7,r7,0x7008
+ 	mtspr	SPRN_HID1,r5
+ #endif /* CONFIG_BLUECHIP_750FX */
+
  1:
  	lwz	r5,CPU_SPEC_PVR_MASK(r8)
  	and	r5,r5,r7
***************
*** 127,132 ****
--- 149,156 ----
  	slwi	r4,r4,2
  	sub	r8,r8,r3
  	stwx	r8,r4,r6
+ 	addis	r6,r3,real_pvr@ha
+ 	stw	r7,real_pvr@l(r6)
  	blr

  /*
diff -b -c -r linux-2.4-benh.orig/arch/ppc/kernel/prom.c linux-2.4-benh/arch/ppc/kernel/prom.c
*** linux-2.4-benh.orig/arch/ppc/kernel/prom.c	Thu Feb 27 10:14:49 2003
--- linux-2.4-benh/arch/ppc/kernel/prom.c	Mon Jun 30 08:34:09 2003
***************
*** 78,83 ****
--- 78,90 ----
  extern boot_infos_t *boot_infos;
  unsigned long dev_tree_size;

+ #ifdef CONFIG_BLUECHIP_750FX
+ /* extra properties for 750fx */
+ unsigned int reduced_clock_frequency;
+ struct property reduced_clock_frequency_prop;
+ struct property dynamic_power_step_prop;
+ #endif /* CONFIG_BLUECHIP_750FX */
+
  void __openfirmware
  phys_call_rtas(int service, int nargs, int nret, ...)
  {
***************
*** 101,106 ****
--- 108,221 ----
  	rtas(&u, rtas_data);
  }

+ #ifdef CONFIG_BLUECHIP_750FX
+ /* Fix device tree (cpu-frequency and L2 cache size) for 750FX.
+  */
+ static void __init
+ prom_fixup_for_750fx(void)
+ {
+ 	struct device_node *cpunode, *cachenode;
+ 	u32 *value;
+ 	unsigned int cachesize, cacheline;
+ 	unsigned int busfreq,hid1,multiplier;
+
+ 	/* cache size */
+ 	cachesize = 0x00080000;
+ 	cacheline = 64;
+
+ 	/* assume only one CPU */
+ 	cpunode = find_type_devices("cpu");
+ 	if (!cpunode)
+ 		return;
+
+ 	value = (u32*)get_property(cpunode, "cpu-version", NULL);
+ 	if (value)
+ 		*value = real_pvr;
+
+ 	/* L2 cache */
+ 	cachenode = find_type_devices("cache");
+ 	if (!cachenode)
+ 		return;
+
+ 	value = (u32*)get_property(cachenode, "d-cache-size", NULL);
+ 	if (value)
+ 		*value = cachesize;
+
+ 	value = (u32*)get_property(cachenode, "d-cache-line-size", NULL);
+ 	if (value)
+ 		*value = cacheline;
+
+ 	value = (u32*)get_property(cachenode, "i-cache-size", NULL);
+ 	if (value)
+ 		*value = cachesize;
+
+ 	value = (u32*)get_property(cachenode, "i-cache-line-size", NULL);
+ 	if (value)
+ 		*value = cacheline;
+
+ 	/* calculate cpu clock frequency */
+ 	value = (u32*)get_property(cpunode, "bus-frequency", NULL);
+ 	if (value && *value>0) {
+ 		busfreq = *value;
+ 		if (66000000<busfreq && busfreq<67000000)
+ 			busfreq=66666667;
+ 		else if (99000000<busfreq && busfreq<101000000)
+ 			busfreq=100000000;
+ 		else if (132000000<busfreq && busfreq<134000000)
+ 			busfreq=133333334;
+
+ 		/* get frequency multiplier (current speed) */
+ 		hid1 = mfspr(HID1);
+ 		if (hid1&0x00010000)
+ 			multiplier = (hid1>>3)&0x1F;
+ 		else if (hid1&0x00020000)
+ 			multiplier = (hid1>>11)&0x1F;
+ 		else
+ 			multiplier = (hid1>>27)&0x1F;
+ 		if (multiplier==0x1F)
+ 			multiplier=0;
+ 		else if (multiplier>20)
+ 			multiplier=(multiplier-10)*2;
+ 		else if (multiplier==3)
+ 			multiplier=2;
+ 		if (multiplier>=2) {
+ 			value = (u32*)get_property(cpunode,"clock-frequency",NULL);
+ 			if (value)
+ 				*value = busfreq * multiplier / 2;
+
+ 			value = (u32*)get_property(cachenode,"clock-frequency",NULL);
+ 			if (value)
+ 				*value = busfreq * multiplier / 2;
+ 		}
+
+ 		/* get frequency multiplier (low speed) */
+ 		multiplier = (hid1>>3)&0x1F;
+ 		if (multiplier==0x1F)
+ 			multiplier=0;
+ 		else if (multiplier>20)
+ 			multiplier=(multiplier-10)*2;
+ 		else if (multiplier==3)
+ 			multiplier=2;
+ 		if (multiplier>=2) {
+ 			reduced_clock_frequency = busfreq * multiplier / 2;
+ 			memset(&reduced_clock_frequency_prop,-1,sizeof(struct property));
+ 			reduced_clock_frequency_prop.name = "reduced-clock-frequency";
+ 			reduced_clock_frequency_prop.length = 4;
+ 			reduced_clock_frequency_prop.value =
+ 				(unsigned char*)&reduced_clock_frequency;
+ 			prom_add_property(cpunode,&reduced_clock_frequency_prop);
+
+ 			memset(&dynamic_power_step_prop,-1,sizeof(struct property));
+ 			dynamic_power_step_prop.name = "dynamic-power-step";
+ 			dynamic_power_step_prop.length = 0;
+ 			dynamic_power_step_prop.value =
+ 				(unsigned char*)&dynamic_power_step_prop;
+ 			prom_add_property(cpunode,&dynamic_power_step_prop);
+ 		}
+ 	}
+ }
+ #endif /* CONFIG_BLUECHIP_750FX */
+
  /*
   * finish_device_tree is called once things are running normally
   * (i.e. with text and data mapped to the address they were linked at).
***************
*** 161,166 ****
--- 276,286 ----
  	mem = finish_node(allnodes, mem, NULL, 1, 1);
  	dev_tree_size = mem - (unsigned long) allnodes;
  	klimit = (char *) mem;
+
+ #ifdef CONFIG_BLUECHIP_750FX
+ 	if ((PVR_VER(real_pvr)==0x7000) && (PVR_VER(mfspr(PVR))==8))
+ 		prom_fixup_for_750fx();
+ #endif /* CONFIG_BLUECHIP_750FX */
  }

  static unsigned long __init
diff -b -c -r linux-2.4-benh.orig/arch/ppc/kernel/setup.c linux-2.4-benh/arch/ppc/kernel/setup.c
*** linux-2.4-benh.orig/arch/ppc/kernel/setup.c	Mon Jun 16 04:40:41 2003
--- linux-2.4-benh/arch/ppc/kernel/setup.c	Thu Jun 26 18:54:25 2003
***************
*** 155,161 ****
  	lpj = cpu_data[i].loops_per_jiffy;
  	seq_printf(m, "processor\t: %u\n", i);
  #else
! 	pvr = mfspr(PVR);
  	lpj = loops_per_jiffy;
  #endif

--- 155,161 ----
  	lpj = cpu_data[i].loops_per_jiffy;
  	seq_printf(m, "processor\t: %u\n", i);
  #else
! 	pvr = real_pvr;
  	lpj = loops_per_jiffy;
  #endif

diff -b -c -r linux-2.4-benh.orig/arch/ppc/platforms/pmac_cpufreq.c linux-2.4-benh/arch/ppc/platforms/pmac_cpufreq.c
*** linux-2.4-benh.orig/arch/ppc/platforms/pmac_cpufreq.c	Wed Apr 30 10:29:25 2003
--- linux-2.4-benh/arch/ppc/platforms/pmac_cpufreq.c	Thu Jun 26 18:58:46 2003
***************
*** 238,243 ****
--- 238,244 ----
   *  - Titanium PowerBook 500 (PMU based, 300Mhz & 500Mhz)
   *  - iBook2 500 (PMU based, 400Mhz & 500Mhz)
   *  - iBook2 700 (CPU based, 400Mhz & 700Mhz, support low voltage)
+  *  - BlueChip G3 upgraded Pismo PowerBook (CPU based)
   */
  static int __init
  pmac_cpufreq_setup(void)
***************
*** 302,308 ****
  		cpufreq_uses_pmu = 1;
  	}
  	/* Else check for 750FX */
! 	else if (PVR_VER(mfspr(PVR)) == 0x7000) {
  		if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
  			goto out;
  		hi_freq = cur_freq;
--- 303,309 ----
  		cpufreq_uses_pmu = 1;
  	}
  	/* Else check for 750FX */
! 	else if (PVR_VER(real_pvr) == 0x7000) {
  		if (get_property(cpunode, "dynamic-power-step", NULL) == NULL)
  			goto out;
  		hi_freq = cur_freq;
diff -b -c -r linux-2.4-benh.orig/include/asm-ppc/processor.h linux-2.4-benh/include/asm-ppc/processor.h
*** linux-2.4-benh.orig/include/asm-ppc/processor.h	Thu Jun 26 17:19:10 2003
--- linux-2.4-benh/include/asm-ppc/processor.h	Mon Jun 30 13:53:17 2003
***************
*** 559,564 ****
--- 559,567 ----
  #define _CHRP_Motorola 0x04  /* motorola chrp, the cobra */
  #define _CHRP_IBM      0x05  /* IBM chrp, the longtrail and longtrail 2 */

+ /* default low speed config for cases where we set PLL1 ourselves */
+ #define DEFAULT_PLL1_CONFIG 0x44  /* for 4x bus-speed and <600MHz */
+
  #define _GLOBAL(n)\
  	.globl n;\
  n:
***************
*** 616,621 ****
--- 619,629 ----
  #define _machine 0
  #endif /* CONFIG_ALL_PPC */

+ /* Some machines report incorrect version with mfspr(PVR).  Use this global
+  * instead.
+  */
+ extern unsigned int real_pvr;
+
  struct task_struct;
  void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
  void release_thread(struct task_struct *);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
