To: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: crash loadin bash after booting linux on a MPC860ADS
References: <D53137D1F3DDD211A3750800060DA313017023B1@viee122a.erd.siemens.at>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 04 Apr 2000 18:49:42 +0200
In-Reply-To: Eisenzopf Thomas's message of "Tue, 4 Apr 2000 18:07:00 +0200"
Message-ID: <kfywvmdvmjd.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eisenzopf Thomas <thomas.eisenzopf@siemens.at> writes:

> Hello,
>
> thanks again for the suggestions from some members of this mailing list. I
> managed to reconfigure my kernel and now I can boot linux until the NFS root
> filesystem is mounted.
>
> But after this the kernel tries to load the shell /bin/sh from NFS, at this
> point the system crashes. My kernel includes the patches from
> www.s4l.de/powerpc.html.
>
> Please, can anyone help? I took the ramdisk.image.gz filesystem from
> www.s4l.de/powerpc.html. This should be working for PowerPC(?). On the other
> hand I tried to get my own filesystem (crosscompile bash, ...), but it
> didn´t work. Perhaps someone could support me with a tarball of a filesystem
> working on a MPC860ADS board with NFS root filesystem? How can I make a
> filesystem on my own (on an Intel PC)?
>
>
> 8xxROM 0.3.0
>
> compiletime options:
> board: ADS DRAM_50MHZ
> disk: DISK_ROM
>
> cpu: XPC860xxZPnnA3 at 48 MHz: 4Kbyte icache 4Kbyte dcache
>
> <warning: cpu core has silicon bugs, check the errata>

Well, guess you didn't do this...
Either put your CPU on a hard surface, apply a sledgehammer to it,
and get a new(er) one. ;)
Or apply the following diff and see if things get better:

diff -u -r1.2 -r1.3
--- head.S	2000/01/11 18:13:31	1.2
+++ head.S	2000/01/11 18:27:59	1.3
@@ -883,11 +886,26 @@
  * only perform the attribute functions.
  */
 InstructionTLBMiss:
+#ifndef NO_MPC8xxBUG_CPU6
+	stw	r3, 8(r0)
+	li	r3, M_TW_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
 	stw	r21, 4(r0)
 	mfspr	r20, SRR0	/* Get effective address of fault */
+	li	r3, MD_EPN_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#else /* NO_MPC8xxBUG_CPU6 */
+	mtspr	M_TW, r20	/* Save a couple of working registers */
+	mfcr	r20
+	stw	r20, 0(r0)
+	stw	r21, 4(r0)
+	mfspr	r20, SRR0	/* Get effective address of fault */
+#endif /* NO_MPC8xxBUG_CPU6 */
 	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r20, M_TWB	/* Get level 1 table entry address */
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
@@ -899,8 +917,19 @@
 	 */
 	tophys(r21,r21,0)
 	ori	r21,r21,1		/* Set valid bit */
+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MI_TWC_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+	mtspr	MI_TWC, r21	/* Set page attributes */
+	li	r3, MD_TWC_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+	mtspr	MD_TWC, r21	/* Load pte table base address */
+#else
 	mtspr	MI_TWC, r21	/* Set page attributes */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
+#endif /* NO_MPC8xxBUG_CPU6 */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
 	lwz	r21, 0(r21)	/* Get the pte */

@@ -920,18 +949,29 @@
 	 */
 	ori	r20, r21, 0x00f0

+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MI_RPN_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	MI_RPN, r20	/* Update TLB entry */

 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	rfi

 2:	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	b	InstructionAccess
 #endif /* CONFIG_8xx */

@@ -1009,6 +1049,12 @@
 	b	00b			/* Try lookup again */
 #endif /* NO_RELOAD_HTAB */
 #else /* CONFIG_8xx */
+#ifndef NO_MPC8xxBUG_CPU6
+	stw	r3, 8(r0)
+	li	r3, M_TW_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
@@ -1022,6 +1068,11 @@
 	 */
 	tophys(r21, r21, 0)
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MD_TWC_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
 	lwz	r21, 0(r21)	/* Get the pte */
@@ -1042,18 +1093,29 @@
 	 */
 	ori	r20, r21, 0x00f0

+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MD_RPN_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	MD_RPN, r20	/* Update TLB entry */

 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	rfi

 2:	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	b	DataAccess
 #endif /* CONFIG_8xx */

@@ -1086,6 +1148,12 @@
  */
 	. = 0x1400
 DataTLBError:
+#ifndef NO_MPC8xxBUG_CPU6
+	stw	r3, 8(r0)
+	li	r3, M_TW_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	M_TW, r20	/* Save a couple of working registers */
 	mfcr	r20
 	stw	r20, 0(r0)
@@ -1106,6 +1174,11 @@
 	 */
 	tophys(r21, r21, 0)
 	ori	r21, r21, 1		/* Set valid bit in physical L2 page */
+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MD_TWC_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	MD_TWC, r21		/* Load pte table base address */
 	mfspr	r21, MD_TWC		/* ....and get the pte address */
 	lwz	r21, 0(r21)		/* Get the pte */
@@ -1133,18 +1206,29 @@
 	 */
 	ori	r20, r21, 0x00f0

+#ifndef NO_MPC8xxBUG_CPU6
+	li	r3, MD_RPN_ADDR
+	stw	r3, 12(r0)
+	lwz	r3, 12(r0)
+#endif
 	mtspr	MD_RPN, r20	/* Update TLB entry */

 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	rfi
 2:
 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
 	mtcr	r21
 	lwz	r21, 4(r0)
+#ifndef NO_MPC8xxBUG_CPU6
+	lwz	r3, 8(r0)
+#endif
 	b	DataAccess
 #endif /* CONFIG_8xx */

@@ -2214,7 +2307,19 @@
         lwz     r9,MM-TSS(r4)           /* Get virtual address of mm */
         lwz     r9,PGD(r9)              /* get new->mm->pgd */
         addis   r9,r9,-KERNELBASE@h     /* convert to phys addr */
+#ifndef NO_MPC8xxBUG_CPU6
+	lis	r6, cmd_line@h
+	ori	r6, r6, cmd_line@l
+	li	r7, M_TWB_ADDR
+	stw	r7, 12(r6)
+	lwz	r7, 12(r6)
+	mtspr   M_TWB, r9               /* Update MMU base address */
+	li	r7, M_CASID_ADDR
+	stw	r7, 12(r6)
+	lwz	r7, 12(r6)
+#else
         mtspr   M_TWB, r9               /* Update MMU base address */
+#endif /* NO_MPC8xxBUG_CPU6 */
         mtspr   M_CASID, r5             /* Update context */
         tlbia
 #endif


//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
