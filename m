Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADAB5B7BB7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2009 18:01:28 +1000 (EST)
In-Reply-To: <20090929210331.GA25779@laura.chatsunix.int.mrv.com>
References: <20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache	coherency
	rewrite
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 30 Sep 2009 09:59:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 29/09/2009 23:03:31:
>
> Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
>
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 29/09/2009 10:16:38:
> > >
> > >
> > > > hmm, yes. You do get this and mysterious SEGV if you hit the but so does
> > > > other bugs too so this is probably due to missing invalidation.
> > > >
> > > > I suspect that something like below will fix the problem and
> > > > is the "correct" fix(untested, not even compiled):
> > >
> > > Ok but do we also still have to worry about the "unpopulated" TLB
> > > entries and invalidate them somehow when populating ?
> >
> > Since I am probably the only one that knows about DAR problem I figured
> > I should take a stab at it. This is not tested, but I hope Rex and the list
> > can do that. Once this works as it should, we can remove all special handling
> > for 8xx in copy_tofrom_user() and friends.
> > No sign-off yet, want some confirmation first.
>
> It doesn't make a difference. I applied it to the top of the tree,
> it got to userspace but it is stuck. Using break I am able to dump the
> registers, I'm not sure if this is useful. Oh, well, I finally got to a shell
> but it is unusably slow. Is there some test code that would be better to run?
> I tried looking through the mailing list archives but I couldn't find anything.
>
> thanks!
> /rex.

Ok, I have made some minor tweaks and added debug code in
do_page_fault(). Would be great if you could try on both
.31 and top of tree.

 Jocke

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 4dd38f1..b3f6687 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -709,6 +709,14 @@ ret_from_except:
 	SYNC			/* Some chip revs have problems here... */
 	MTMSRD(r10)		/* disable interrupts */

+#ifdef CONFIG_8xx
+	/* Tag DAR with a well know value.
+	 * This needs to match head_8xx.S and
+	 * do_page_fault()
+	 */
+	li	r3, 0x00f0
+	mtspr	SPRN_DAR, r3
+#endif
 	lwz	r3,_MSR(r1)	/* Returning to user mode? */
 	andi.	r0,r3,MSR_PR
 	beq	resume_kernel
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..f9e2363 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -39,6 +39,15 @@
 #else
 #define DO_8xx_CPU6(val, reg)
 #endif
+
+/* DAR needs to be tagged with a known value so that the
+ * DataTLB Miss/Error and do_page_fault() can recognize a
+ * buggy dcbx instruction and workaround the problem.
+ * dcbf, dcbi, dcbst, dcbz instructions do not update DAR
+ * when trapping into a Data TLB Miss/Error. See
+ * DataStoreTLBMiss and DataTLBError for details
+ */
+
 	__HEAD
 _ENTRY(_stext);
 _ENTRY(_start);
@@ -352,7 +361,7 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -365,6 +374,19 @@ InstructionTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	rfi
+2:
+	mfspr	r10, SPRN_SRR1
+	rlwinm	r10,r10,0,5,3 /* clear bit 4(0x08000000) */
+	mtspr	SPRN_SRR1, r10
+
+	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	lwz	r11, 0(r0)
+	mtcr	r11
+	lwz	r11, 4(r0)
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)
+#endif
+	b	InstructionAccess

 	. = 0x1200
 DataStoreTLBMiss:
@@ -428,10 +450,11 @@ DataStoreTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+	mtspr	SPRN_DAR, r11		/* Tag DAR */

 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
@@ -441,7 +464,15 @@ DataStoreTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	rfi
-
+2:
+	mfspr	r10, SPRN_M_TW	/* Restore registers */
+	lwz	r11, 0(r0)
+	mtcr	r11
+	lwz	r11, 4(r0)
+#ifdef CONFIG_8xx_CPU6
+	lwz	r3, 8(r0)
+#endif
+	b	DataAccess
 /* This is an instruction TLB error on the MPC8xx.  This could be due
  * to many reasons, such as executing guarded memory or illegal instruction
  * addresses.  There is nothing to do but handle a big time error fault.
@@ -492,6 +523,8 @@ DataTLBError:
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
 	mfspr	r10, SPRN_DAR
+	cmpwi	cr0, r10, 0x00f0	/* check if DAR holds a tag */
+	beq-	2f
 	rlwinm	r11, r10, 0, 0, 19
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, SPRN_M_CASID
@@ -550,6 +583,7 @@ DataTLBError:
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+	mtspr	SPRN_DAR, r11		/* Tag DAR */

 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7699394..4fefd01 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -125,6 +125,61 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;

+#if 1 /* defined(CONFIG_8xx)*/
+/*
+ Work around DTLB Miss/Error, as these do not update
+ DAR for dcbf, dcbi, dcbst, dcbz instructions
+ This relies on every exception tagging DAR with 0xf0
+ before returning (rfi)
+ DAR is passed as 'address' to this function.
+ */
+	{
+		unsigned long ra, rb, dar, insn;
+		char *istr = NULL;
+
+		insn = *((unsigned long *)regs->nip);
+		if ((insn >> (31-5)) == 31) {
+			if ((insn >> 1) == 1014) /* dcbz ? */
+				istr = "dcbz";
+			if ((insn >> 1) == 86) /* dcbf ? */
+				istr = "dcbf";
+			if ((insn >> 1) == 470) /* dcbi ? */
+				istr = "dcbi";
+			if ((insn >> 1) == 54) /* dcbst ? */
+				istr = "dcbst";
+		}
+		if (istr) {
+			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+			printk(KERN_CRIT "%s r%ld,r%ld found at NIP:%lx\n",
+			       istr, regs->nip, ra, rb);
+			printk(KERN_CRIT "DAR is:%lx (should be 0xf0)\n", regs->dar);
+
+		}
+		if (regs->dar == 0xf0 && !istr)
+			printk(KERN_CRIT "DAR is 0xf0 but insn at NIP is: %lx is"
+			       "not a cache insn:%lx!\n", regs->nip, insn);
+		if (trap == 0x300 && address != regs->dar)
+			printk(KERN_CRIT "DAR:%lx != address:%lx!\n", address, regs->dar);
+
+		if (istr || (trap == 0x300 && address == 0xf0)) {
+			insn = *((unsigned long *)regs->nip);
+			/* Check if it is a
+			 * dcbf, dcbi, dcbst, dcbz insn ?
+			if ((insn >> (31-5)) != 31)
+				break; // Not a dcbx instruction
+			 */
+
+			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+			dar = regs->gpr[rb];
+			if (ra)
+				dar += regs->gpr[ra];
+			regs->dar = dar;
+			address = dar;
+		}
+	}
+#endif
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
 	 * Fortunately the bit assignments in SRR1 for an instruction
