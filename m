Date: Wed, 21 Jan 2004 18:51:25 +0900
Subject: Re: local_irq_enable() problem...
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
In-Reply-To: <10F0AFAD-4B61-11D8-8D03-000A95A0560C@us.ibm.com>
Message-Id: <60A99FA3-4BF7-11D8-A780-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
Thank you for your comment.

On 2004.1.21, at 12:55  AM, Hollis Blanchard wrote:
> On Jan 20, 2004, at 7:34 AM, Etsushi Kato wrote:
>>
>> In the early boot sequence, 2.6 kernel freezes just after showing
>> 'arch_exit' on the screen, and 'Console: colour dummy device 80x25' on
>> the serial console.  Even if I put printk() right after
>> local_irq_enable() in init/main.c, this debug print won't show up.  So
>> it seems something causes kernel hang while enabling MSR_EE bit, but I
>> can't figure out how to detect...  Does anyone have a clue?
>
> Perhaps you have an irq that won't shut up?

I think it should be OK since I've ported all the nubus-pmac specific
setup code which works fine on Linux 2.4.24.

>  Or maybe a problem
> returning from an exception handler (I'm assuming you have your own
> head.S).

Yes, I use slightly modified version of head.S based on Takashi Oe's
2.4 nubus patch (see attached diff below).

Is there any way to check whether exception handling code is working
correctly?  Register usage in head.S and entry.S seems to be changed
from 2.4, so perhaps I missed porting some part.  But I'm not yet fully
understanding PPC asm code and memory address mapping... (on
nubus-pmac, KERNELBASE is 0xc0000000, KERNLOAD_OFFSET is created and
set as 0x200000, and KERNELLOAD is 0xc0200000).

Thanks,
--
Etsushi Kato
ekato@ees.hokudai.ac.jp




diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S	Wed Jan 21 18:34:35 2004
+++ b/arch/ppc/kernel/head.S	Wed Jan 21 18:34:35 2004
@@ -173,11 +173,13 @@
   	bl	mmu_off
  __after_mmu_off:
  #ifndef CONFIG_POWER4
+#ifndef CONFIG_NBPMAC
  	bl	clear_bats
+#endif /* !CONFIG_NBPMAC */
  	bl	flush_tlbs

  	bl	initial_bats
-#if !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT)
+#if !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT) &&
!defined(CONFIG_NBPMAC)
  	bl	setup_disp_bat
  #endif
  #else /* CONFIG_POWER4 */
@@ -192,8 +194,10 @@
  	li	r24,0			/* cpu# */
  	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
  #ifdef CONFIG_6xx
+#ifndef CONFIG_NBPMAC
  	bl	reloc_offset
  	bl	init_idle_6xx
+#endif /* !CONFIG_NBPMAC */
  #endif /* CONFIG_6xx */
  #ifdef CONFIG_POWER4
  	bl	reloc_offset
@@ -201,7 +205,7 @@
  #endif /* CONFIG_POWER4 */


-#ifndef CONFIG_APUS
+#if !defined(CONFIG_APUS) && !defined(CONFIG_NBPMAC)
  /*
   * We need to run with _start at physical address 0.
   * On CHRP, we are loaded at 0x10000 since OF on CHRP uses
@@ -215,7 +219,7 @@
  	addis	r4,r3,KERNELBASE@h	/* current address of _start */
  	cmpwi	0,r4,0			/* are we already running at 0? */
  	bne	relocate_kernel
-#endif /* CONFIG_APUS */
+#endif /* !CONFIG_APUS && !CONFIG_NBPMAC */
  /*
   * we now have the 1st 16M of ram mapped with the bats.
   * prep needs the mmu to be turned on here, but pmac already has it on.
@@ -411,7 +415,16 @@
  	bne	1f			/* if not, try to put a PTE */
  	mfspr	r4,DAR			/* into the hash table */
  	rlwinm	r3,r10,32-15,21,21	/* DSISR_STORE -> _PAGE_RW */
+#ifndef CONFIG_NBPMAC
  	bl	hash_page
+#else /* !CONFIG_NBPMAC */
+	/* relative addressing can't be used here */
+	lis	r2,hash_page@h
+	ori	r2,r2,hash_page@l
+	tophys(r2,r2)
+	mtspr	LR,r2
+	blrl
+#endif /* !CONFIG_NBPMAC */
  1:	stw	r10,_DSISR(r11)
  	mr	r5,r10
  	mfspr	r4,DAR
@@ -438,7 +451,16 @@
  	beq	1f			/* if so, try to put a PTE */
  	li	r3,0			/* into the hash table */
  	mr	r4,r12			/* SRR0 is fault address */
+#ifndef CONFIG_NBPMAC
  	bl	hash_page
+#else /* !CONFIG_NBPMAC */
+	/* relative addressing can't be used here */
+	lis	r2,hash_page@h
+	ori	r2,r2,hash_page@l
+	tophys(r2,r2)
+	mtspr	LR,r2
+	blrl
+#endif /* !CONFIG_NBPMAC */
  1:	addi	r3,r1,STACK_FRAME_OVERHEAD
  	mr	r4,r12
  	mr	r5,r9
@@ -1229,8 +1251,10 @@
  	bl	identify_cpu
  	bl	call_setup_cpu		/* Call setup_cpu for this CPU */
  #ifdef CONFIG_6xx
+#ifndef CONFIG_NBPMAC
  	lis	r3,-KERNELBASE@h
  	bl	init_idle_6xx
+#endif /* !CONFIG_NBPMAC */
  #endif /* CONFIG_6xx */
  #ifdef CONFIG_POWER4
  	lis	r3,-KERNELBASE@h
@@ -1390,6 +1414,15 @@
  	bl	copy_and_flush		/* copy the first 0x4000 bytes */
  #endif  /* CONFIG_APUS */

+#ifdef CONFIG_NBPMAC
+	/* Copy exception vector to phys 0x0 */
+	lis	r4,(KERNELBASE+KERNLOAD_OFFSET)@h
+	lis	r3,KERNELBASE@h		/* Copy to phys 0x00000000 */
+	li	r5,0x4000		/* # bytes of memory to copy */
+	li	r6,0
+	bl	copy_and_flush		/* copy the first 0x4000 bytes */
+#endif	/* CONFIG_NBPMAC */
+
  /*
   * Go back to running unmapped so we can load up new values
   * for SDR1 (hash table pointer) and the segment registers
@@ -1559,12 +1592,24 @@
  	bne	4f
  	ori	r11,r11,4		/* set up BAT registers for 601 */
  	li	r8,0x7f			/* valid, block length = 8MB */
-	oris	r9,r11,0x800000@h	/* set up BAT reg for 2nd 8M */
-	oris	r10,r8,0x800000@h	/* set up BAT reg for 2nd 8M */
  	mtspr	IBAT0U,r11		/* N.B. 601 has valid bit in */
  	mtspr	IBAT0L,r8		/* lower BAT register */
+#ifdef CONFIG_NBPMAC
+	lis	r10,-KERNELBASE@h
+	addis	r9,r10,nbpmac_2nd_mem_chank@ha
+	addi	r9,r9,nbpmac_2nd_mem_chank@l
+	lwz	r10,0(r9)
+	or	r9,r11,r10		/* set up BAT reg for 2nd mem region */
+	or	r10,r8,r10		/* set up BAT reg for 2nd mem region */
  	mtspr	IBAT1U,r9
  	mtspr	IBAT1L,r10
+	sync
+#else /* CONFIG_NBPMAC */
+	oris	r9,r11,0x800000@h	/* set up BAT reg for 2nd 8M */
+	oris	r10,r8,0x800000@h	/* set up BAT reg for 2nd 8M */
+	mtspr	IBAT1U,r9
+	mtspr	IBAT1L,r10
+#endif
  	isync
  	blr
  #endif /* CONFIG_PPC64BRIDGE */
@@ -1594,6 +1639,22 @@
  	blr

  #if !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT)
+#define setup_misc_bat(n, dbat, ibat)	\
+	addis	r8,r3,ibat@ha;		\
+	addi	r8,r8,ibat@l;		\
+	lwz	r11,0(r8);		\
+	lwz	r8,4(r8);		\
+	mtibatl	n,r8;			\
+	mtibatu	n,r11;			\
+	cmpi	0,r9,1;			\
+	beq	1f;			\
+	addis	r8,r3,dbat@ha;		\
+	addi	r8,r8,dbat@l;		\
+	lwz	r11,0(r8);		\
+	lwz	r8,4(r8);		\
+	mtdbatl	n,r8;			\
+	mtdbatu	n,r11;			\
+1:
  setup_disp_bat:
  	/*
  	 * setup the display bat prepared for us in prom.c
@@ -1601,21 +1662,50 @@
  	mflr	r8
  	bl	reloc_offset
  	mtlr	r8
-	addis	r8,r3,disp_BAT@ha
-	addi	r8,r8,disp_BAT@l
-	lwz	r11,0(r8)
-	lwz	r8,4(r8)
  	mfspr	r9,PVR
-	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
-	cmpi	0,r9,1
-	beq	1f
-	mtspr	DBAT3L,r8
-	mtspr	DBAT3U,r11
-	blr
-1:	mtspr	IBAT3L,r8
-	mtspr	IBAT3U,r11
+	rlwinm	r9,r9,16,16,31
+	setup_misc_bat(3, disp_DBAT, disp_IBAT)
  	blr

+#ifdef CONFIG_NBPMAC
+/*
+ * For some reasons, kernel dies if it accesses I/O region or AV card's
+ * frame buffer region when MMU is off.  Do minimal MMU setup before
+ * continuing if booted from BootX.  With Apple booter, MMU is on.
+ * Use BAT 3 to map current frame buffer, BAT 0 for logic board memory.
+ * FB base address and size used are from bat_fb_base and bat_fb_size.
+ */
+_GLOBAL(nubus_early_mmu_setup)
+	mfmsr	r6
+	andi.	r6,r6,MSR_DR		/* MMU enabled? */
+	bnelr				/* if apple booter, we are set */
+	mflr	r6
+	bl	clear_bats
+	bl	reloc_offset
+	mfspr	r9,PVR			/* get cpu type */
+	rlwinm	r9,r9,16,16,31
+	cmpi	0,r9,1
+	bne	9f
+	addis	r4,r3,disp_IBAT@ha	/* get BATU value setup by prom.c */
+	lwz	r4,disp_IBAT@l(r4)
+	cmpi	0,r4,0			/* if BATU = 0, don't use BAT3 */
+	beq	2f
+	b	3f
+9:	addis	r4,r3,disp_DBAT@ha	/* get BATU value setup by prom.c */
+	lwz	r4,disp_DBAT@l(r4)
+	cmpi	0,r4,0			/* if BATU = 0, don't use BAT3 */
+	beq	2f
+3:	setup_misc_bat(3, disp_DBAT, disp_IBAT)
+2:	setup_misc_bat(0, kern_BAT0, kern_BAT0)
+	setup_misc_bat(1, kern_BAT1, kern_BAT1)
+	/* turn on MMU */
+	mfmsr	r3
+	ori	r3,r3,(MSR_DR|MSR_IR)@l
+	mtspr	SRR0,r6
+	mtspr	SRR1,r3
+	SYNC
+	rfi
+#endif /* CONFIG_NBPMAC */
  #endif /* !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT) */

  #else /* CONFIG_POWER4 */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
