In-Reply-To: <19991122150653.A13066@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 13:35:36 +0100
To: Cort Dougan <cort@fsmlabs.com>
CC: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123133536.013861@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>I applied the patch (with some changes necessary to get it into
>2.2.14pre7).  It breaks pmac netboot during the jump from
>__secondary_stat() to clear_bats().  There must be some I mappings we need
>to preserve in order to get to non-pc relative code.  It's worth noting
>that OF loads us and gives us mappings for 0xc000000 since that's where
>we're linked at.  BootX and Quik don't do that so that's probably why they
>work.  Netboot is really useful so I'd prefer to not break it (definitely
>not in 2.2).  Any ideas for workarounds?
>
>Chrp and prep netboot works fine.  Boot via quik on chrp works, too.

Ok. I gave a try at asking OF for the physical address. It seems to work
here on the iBook
but I couldn't do more tests today. I hope I didn't mess up the patch (my
real prom.c patch is much bigger, I extracted only what is interesting to
us now):


--- paulus_stable/arch/ppc/kernel/prom.c	Thu Sep  9 21:07:52 1999
+++ linux.ben/arch/ppc/kernel/prom.c	Tue Nov 23 13:21:56 1999
@@ -263,7 +263,7 @@
  * handling exceptions and the MMU hash table for us.
  */
 __init
-void
+unsigned long
 prom_init(int r3, int r4, prom_entry pp)
 {
 #ifdef CONFIG_SMP	
@@ -272,14 +272,18 @@
 	char type[16], *path;
 #endif	
 	unsigned long mem;
-	ihandle prom_rtas;
+	ihandle prom_rtas, prom_mmu;
 	unsigned long offset = reloc_offset();
 	int l;
 	char *p, *d;
+	unsigned long phys;
+	
+	/* Default */
+	phys = offset + KERNELBASE;
 	
 	/* check if we're apus, return if we are */
 	if ( r3 == 0x61707573 )
-		return;
+		return phys;
 
 	/* If we came here from BootX, clear the screen,
 	 * set up some pointers and return. */
@@ -375,12 +379,12 @@
 		prom_print(RELOC("booting...\n"));
 		flushscreen();
 #endif
-		return;
+		return phys;
 	}
 	
 	/* check if we're prep, return if we are */
 	if ( *(unsigned long *)(0) == 0xdeadc0de )
-		return;
+		return phys;
 
 	/* First get a handle for the stdout device */
 	RELOC(prom) = pp;
@@ -472,6 +476,29 @@
 			prom_print(RELOC(" done\n"));
 	}
 
+	if ((int) call_prom(RELOC("getprop"), 4, 1, RELOC(prom_chosen),
+			    RELOC("mmu"), &prom_mmu, sizeof(prom_mmu)) <= 0) {	
+		prom_print(RELOC(" no MMU found\n"));
+	} else {
+		int nargs;
+		struct prom_args prom_args;
+		nargs = 4;
+		prom_args.service = RELOC("call-method");
+		prom_args.nargs = nargs;
+		prom_args.nret = 4;
+		prom_args.args[0] = RELOC("translate");
+		prom_args.args[1] = prom_mmu;
+		prom_args.args[2] = (void *)(offset + KERNELBASE);
+		prom_args.args[3] = (void *)1;
+		RELOC(prom)(&prom_args);
+
+		/* We assume the phys. address size is 3 cells */
+		if (prom_args.args[nargs] != 0)
+			prom_print(RELOC(" (translate failed) "));
+		else
+			phys = (unsigned long)prom_args.args[nargs+3];
+	}
+
 #ifdef CONFIG_SMP
 	/*
 	 * With CHRP SMP we need to use the OF to start the other
@@ -548,6 +575,7 @@
 			prom_print(RELOC("...failed\n"));
 	}
 #endif	
+	return phys;
 }
 
--- paulus_stable/include/asm/prom.h	Thu Sep  9 05:26:50 1999
+++ linux.ben/include/asm/prom.h	Tue Nov 23 13:21:33 1999
@@ -63,7 +63,7 @@
 
 /* Prototypes */
 extern void abort(void);
-extern void prom_init(int, int, prom_entry);
+extern unsigned long prom_init(int, int, prom_entry);
 extern void prom_print(const char *msg);
 extern void relocate_nodes(void);
 extern void finish_device_tree(void);

--- paulus_stable/arch/ppc/kernel/head.S	Sat Oct 16 01:48:04 1999
+++ linux.ben/arch/ppc/kernel/head.S	Tue Nov 23 13:26:18 1999
@@ -249,8 +249,12 @@
 	bl	prom_init
 	.globl	__secondary_start
 __secondary_start:
-/*
- * Use the first pair of BAT registers to map the 1st 16MB
+/* Switch MMU off, clear BATs and flush TLB */
+ 	bl	mmu_off
+	bl	clear_bats
+	bl	flush_tlbs
+
+/* Use the first pair of BAT registers to map the 1st 16MB
  * of RAM to KERNELBASE.  From this point on we can't safely
  * call OF any more.
  */
@@ -289,14 +293,6 @@
 	clrldi	r16,r16,63
 	mtsdr1	r16
 #else /* CONFIG_PPC64 */
-	/*
-	 * If the MMU is off clear the bats.  See clear_bat() -- Cort
-	 */
-	mfmsr	r20
-	andi.	r20,r20,MSR_DR
-	bne	100f
-	bl	clear_bats
-100:
 	/* 
 	 * allow secondary cpus to get at all of ram in early bootup
 	 * since their init_task may be up there -- Cort
@@ -1673,6 +1669,19 @@
 	blr
 #endif /* CONFIG_8xx */
 
+mmu_off:
+ 	addi	r4, r3, __secondary_start - _start
+	mfmsr	r3
+	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
+	beq	1f
+	ori	r3,r3,MSR_DR|MSR_IR
+	xori	r3,r3,MSR_DR|MSR_IR
+	mtspr	SRR0,r4
+	mtspr	SRR1,r3
+	sync
+	rfi
+1:	blr
+
 /*
  * This code is jumped to from the startup code to copy
  * the kernel image to physical address 0.
@@ -1682,8 +1691,10 @@
 	addi	r9,r9,0x6f58		/* translate source addr */
 	cmpw	r31,r9			/* (we have to on chrp) */
 	beq	7f
+#if 0 // still needed ? breaks on me if I don't disable this
 	rlwinm	r4,r4,0,8,31		/* translate source address */
 	add	r4,r4,r3		/* to region mapped with BATs */
+#endif	
 7:	addis	r9,r26,klimit@ha	/* fetch klimit */
 	lwz	r25,klimit@l(r9)
 	addis	r25,r25,-KERNELBASE@h
@@ -2755,25 +2766,36 @@
  */
 clear_bats:
 	li	r20,0
-	
+	mfspr	r9,PVR
+	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
+	cmpwi	r9, 1
+	beq	1f
+
 	mtspr	DBAT0U,r20
-	mtspr	DBAT0L,r20
-	mtspr	IBAT0U,r20
-	mtspr	IBAT0L,r20
-	
+	mtspr	DBAT0L,r20	
 	mtspr	DBAT1U,r20
 	mtspr	DBAT1L,r20
+	mtspr	DBAT2U,r20
+	mtspr	DBAT2L,r20	
+	mtspr	DBAT3U,r20
+	mtspr	DBAT3L,r20
+1:	
+	mtspr	IBAT0U,r20
+	mtspr	IBAT0L,r20
 	mtspr	IBAT1U,r20
 	mtspr	IBAT1L,r20
-	
-	mtspr	DBAT2U,r20
-	mtspr	DBAT2L,r20
 	mtspr	IBAT2U,r20
 	mtspr	IBAT2L,r20
-	
-	mtspr	DBAT3U,r20
-	mtspr	DBAT3L,r20
 	mtspr	IBAT3U,r20
 	mtspr	IBAT3L,r20
 
 	blr
+
+flush_tlbs:
+	lis	r20, 0x1000
+1:	addic.	r20, r20, -0x1000
+	tlbie	r20
+	blt	1b
+	sync
+	blr
+	
\ No newline at end of file


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
