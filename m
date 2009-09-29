Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0078EB7C25
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 21:59:25 +1000 (EST)
In-Reply-To: <1254212198.5256.0.camel@pasglop>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>	
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>	
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 29 Sep 2009 13:56:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 29/09/2009 10:16:38:
>
>
> > hmm, yes. You do get this and mysterious SEGV if you hit the but so does
> > other bugs too so this is probably due to missing invalidation.
> >
> > I suspect that something like below will fix the problem and
> > is the "correct" fix(untested, not even compiled):
>
> Ok but do we also still have to worry about the "unpopulated" TLB
> entries and invalidate them somehow when populating ?

Since I am probably the only one that knows about DAR problem I figured
I should take a stab at it. This is not tested, but I hope Rex and the list
can do that. Once this works as it should, we can remove all special handling
for 8xx in copy_tofrom_user() and friends.
No sign-off yet, want some confirmation first.

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 4dd38f1..691ebd3 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -774,7 +774,14 @@ restore:
 	lwz	r11,_CTR(r1)
 	mtspr	SPRN_XER,r10
 	mtctr	r11
-
+#ifdef CONFIG_8xx
+	/* Tag DAR with a well know value.
+	 * This needs to match head_8xx.S and
+	 * do_page_fault()
+	 */
+	li	r10, 0xf0
+	mtspr	SPRN_DAR, r10
+#endif
 	PPC405_ERR77(0,r1)
 BEGIN_FTR_SECTION
 	lwarx	r11,0,r1
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..418ea96 100644
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
@@ -428,7 +437,8 @@ DataStoreTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
+	mtspr	SPRN_DAR, r11		/* Tag DAR */
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
@@ -441,7 +451,15 @@ DataStoreTLBMiss:
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
@@ -492,6 +510,8 @@ DataTLBError:
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
 	mfspr	r10, SPRN_DAR
+	cmpwi	cr0, r10, 0xf0		/* check it DAR holds a tag */
+	beq-	2f
 	rlwinm	r11, r10, 0, 0, 19
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, SPRN_M_CASID
@@ -547,6 +567,7 @@ DataTLBError:
 	 * of the MMU.
 	 */
 	li	r11, 0x00f0
+	mtspr	SPRN_DAR, r11		/* Tag DAR */
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7699394..be779b2 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -125,6 +125,32 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;

+#if defined(CONFIG_8xx)
+/*
+ Workarund DTLB Miss/Error, as these do not update DAR
+ for dcbf, dcbi, dcbst, dcbz instructions
+ This relies on every exception tagging DAR with 0xf0
+ before returning (rfi)
+ DAR as passed as address to this function.
+ */
+#define RA(inst)        (((inst) & 0x001F0000) >> 16)
+#define RB(inst)        (((inst) & 0x0000F800) >> 11)
+	{
+		unsigned long ra, rb, dar, insns;
+
+		if (trap == 0x300 && address == 0xf0) {
+			insns = *((unsigned long *)regs->nip);
+			/* Really check if it is an dcbf, dcbi, dcbst, dcbz insns ? */
+			ra  = RA(insns); /* Reg Ra */
+			rb  = RB(insns); /* Reg Rb */
+			dar = regs->gpr[rb];
+			if (ra)
+				dar += regs->gpr[ra];
+			/* regs->dar = dar; perhaps */
+			address = dar;
+		}
+	}
+#endif
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
 	 * Fortunately the bit assignments in SRR1 for an instruction
