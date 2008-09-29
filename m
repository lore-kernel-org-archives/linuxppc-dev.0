Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA3C5DE2A6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 06:05:18 +1000 (EST)
Date: Mon, 29 Sep 2008 22:04:48 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
Message-ID: <20080929200448.GA23025@www.tglx.de>
References: <20080923195404.GA10935@www.tglx.de>
	<200809240124.m8O1O2QK076012@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200809240124.m8O1O2QK076012@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Milton Miller | 2008-09-23 20:24:02 [-0500]:

>If you have any questions about kdump or what needs to happen,
>please feel free to contact me either by email or on irc (sometimes
>I use mdm other times the email login as my nick, and when connected
>I tend to leave it well past the hours I am at the computer).

I copied most of the 64bit code to parse the device tree without the pci
nodes & moved it to 32. The userland *could* work, I'm not sure. My
outout is:

|load: entry = 0x80053c flags = 0
|nr_segments = 2
|segment[0].buf   = 0x1002b8f0
|segment[0].bufsz = 80
|segment[0].mem   = (nil)
|segment[0].memsz = 1000
|segment[1].buf   = 0x4803f008
|segment[1].bufsz = 3a3138
|segment[1].mem   = 0x800000
|segment[1].memsz = 3b0000

Now. The entry address in image->start is valid and is the entrypoint of
the "custom" cuImage. Custom means that it does not depend any register
values passed from u-boot (the original one needs a pointer to bd_t).
The only requirement is a valid 1:1 memory mapping.

I learned, that I can not disable the MMU on Book-E so I have to create
a new temporary mapping in my relocate_new_kernel routine. _start is
doing the same thing what I am trying to accomplish: create a new
mapping and don't kill the current one and switch over. This is done by
disabling all mappings but the current, creating a new mapping with
EFN/RPN = 0 and swapping the TS bit in MAS1. This is my current patch
which is not really working:

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7a6dfbc..49c9c2a 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -878,22 +878,142 @@ relocate_new_kernel:
 	/* r4 = reboot_code_buffer */
 	/* r5 = start_address      */
 
-	li	r0, 0
+	mr r27, r4
+	mr r28, r5
+	mr r29, r6
+
+	li      r25,0           /* phys kernel start (low) */
+	li      r24,0           /* CPU number */
+	li      r23,0           /* phys kernel start (high) */
+
+
+/* 1. Find the index of the entry we're executing in */
+	bl      invstr                          /* Find our address */
+invstr: mflr    r6                              /* Make it accessible */
+	mfmsr   r7
+	rlwinm  r4,r7,27,31,31                  /* extract MSR[IS] */
+	mfspr   r7, SPRN_PID0
+	slwi    r7,r7,16
+	or      r7,r7,r4
+	mtspr   SPRN_MAS6,r7
+	tlbsx   0,r6                            /* search MSR[IS], SPID=PID0 */
+#ifndef CONFIG_E200
+	mfspr   r7,SPRN_MAS1
+	andis.  r7,r7,MAS1_VALID@h
+	bne     match_TLB

The branch above is taken, so I've found my current mapping

+	mfspr   r7,SPRN_PID1
+	slwi    r7,r7,16
+	or      r7,r7,r4
+	mtspr   SPRN_MAS6,r7
+	tlbsx   0,r6                            /* search MSR[IS], SPID=PID1 */
+	mfspr   r7,SPRN_MAS1
+	andis.  r7,r7,MAS1_VALID@h
+	bne     match_TLB
+	mfspr   r7, SPRN_PID2
+	slwi    r7,r7,16
+	or      r7,r7,r4
+	mtspr   SPRN_MAS6,r7
+	tlbsx   0,r6                            /* Fall through, we had to match */
+#endif
+match_TLB:
+
+	rlwinm  r3,r7,16,20,31                  /* Extract MAS0(Entry) */
+
+	mfspr   r7,SPRN_MAS1                    /* Insure IPROT set */
+	oris    r7,r7,MAS1_IPROT@h
+	mtspr   SPRN_MAS1,r7
+	tlbwe
+
+/* 2. Invalidate all entries except the entry we're executing in */
+	mfspr   r9,SPRN_TLB1CFG
+	andi.   r9,r9,0xfff
+	li      r6,0                            /* Set Entry counter to 0 */
+1:      lis     r7,0x1000                       /* Set MAS0(TLBSEL) = 1 */
+	rlwimi  r7,r6,16,4,15                   /* Setup MAS0 = TLBSEL | ESEL(r6) */
+	mtspr   SPRN_MAS0,r7
+	tlbre
+	mfspr   r7,SPRN_MAS1
+	rlwinm  r7,r7,0,2,31                    /* Clear MAS1 Valid and IPROT */
+	cmpw    r3,r6
+	beq     skpinv                        /* Dont update the current execution TLB */
+	mtspr   SPRN_MAS1,r7
+	tlbwe
+	isync
+skpinv: addi    r6,r6,1                         /* Increment */
+	cmpw    r6,r9                           /* Are we done? */
+	bne     1b                              /* If not, repeat */
 
-	/*
-	 * Set Machine Status Register to a known status,
-	 * switch the MMU off and jump to 1: in a single step.
-	 */
+	/* Invalidate TLB0 */
+	li      r6,0x04
+	tlbivax 0,r6
+	TLBSYNC
+	/* Invalidate TLB1 */
+	li      r6,0x0c
+	tlbivax 0,r6
+	TLBSYNC
 
-	mr	r8, r0
-	ori     r8, r8, MSR_RI|MSR_ME
-	mtspr	SPRN_SRR1, r8
-	addi	r8, r4, 1f - relocate_new_kernel
-	mtspr	SPRN_SRR0, r8
-	sync
+/* 3. Setup a temp mapping and jump to it */
+	andi.   r5, r3, 0x1     /* Find an entry not used and is non-zero */
+	addi    r5, r5, 0x1
+	lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
+	rlwimi  r7,r3,16,4,15   /* Setup MAS0 = TLBSEL | ESEL(r3) */
+	mtspr   SPRN_MAS0,r7
+	tlbre
+
+	/* set mask to 0xfffff000 , EFN / RPN should be 0 / 0 */
+	li      r8, -1
+	li	r6, 12
+	slw     r6,r8,r6        /* convert to mask */
+
+	li	r7, 0 		/* find our address */
+	addi	r7, r27, current_IP - relocate_new_kernel
+current_IP:
+
+	mfspr   r8,SPRN_MAS3
+#ifdef CONFIG_PHYS_64BIT
+	mfspr   r23,SPRN_MAS7
+#endif
+	and     r8,r6,r8
+	subfic  r9,r6,-4096
+	and     r9,r9,r7
+
+	or      r25,r8,r9
+	ori     r8,r25,(MAS3_SX|MAS3_SW|MAS3_SR)
+
+	/* Just modify the entry ID and EPN for the temp mapping */
+	lis     r7,0x1000       /* Set MAS0(TLBSEL) = 1 */
+	rlwimi  r7,r5,16,4,15   /* Setup MAS0 = TLBSEL | ESEL(r5) */
+	mtspr   SPRN_MAS0,r7
+	xori    r6,r4,1         /* Setup TMP mapping in the other Address space */
+	slwi    r6,r6,12
+	oris    r6,r6,(MAS1_VALID|MAS1_IPROT)@h
+	ori     r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_1GB))@l
+	mtspr   SPRN_MAS1,r6
+	mfspr   r6,SPRN_MAS2
+	li      r7,0            /* temp EPN = 0 */
+	rlwimi  r7,r6,0,20,31
+
+	mtspr   SPRN_MAS2,r7
+	mtspr   SPRN_MAS3,r8

Here I get:

MAS0: 0x10010000
MAS1: 0xc0001a00
MAS2: 0x00000000
MAS3: 0x00000015

+	tlbwe

I haven't made it to here.

+
+	xori    r6,r4,1
+	slwi    r6,r6,5         /* setup new context with other address space */
+
+	li	r7, 0 		/* find our address */
+	addi	r7, r27, old_copy_code - relocate_new_kernel
+
+	mtspr   SPRN_SRR0,r7
+	mtspr   SPRN_SRR1,r6
 	rfi
+old_copy_code:
+
+	mr r4, r27
+	mr r5, r28
+	mr r6, r29
+
+	li	r0, 0
 
-1:
 	/* from this point address translation is turned off */
 	/* and interrupts are disabled */
 

In order to dump the MASx values, I did not invalidate the TLBs entries
(s/beq skpinv/b skpinv) and branched to address 0 before the tlbwe to
receive a register dump. This little trick did not work after the tlbwe
instruction. I probably overwrote the wrong / active TLB entry. Since
the TI bit is fliped, this new TLB entry should not be used anyway.
Without invalidating the TLBs, I may have picked the wrong ESEL index
and overwrote either my current mapping or that one that used by the
expection handler/serial port and the bug is somewhere else.

Milton, do have an idea how I could debug this further? My cuImage does
not expect any register values or anything so I thing it hangs here
somewhere and never enter the cuImage code.

>milton

Sebastian
