Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 433EAB7BD9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 03:27:31 +1000 (EST)
In-Reply-To: <OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
References: <1253843480.7103.492.camel@pasglop>	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
Message-ID: <OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 30 Sep 2009 19:23:44 +0200
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

>
> Rex Feany <RFeany@mrv.com> wrote on 30/09/2009 11:00:02:
> >
> > Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
> >
> > > > Ok, I have made some minor tweaks and added debug code in
> > > > do_page_fault(). Would be great if you could try on both
> > > > .31 and top of tree.
> > > >
> > > >  Jocke
> > >
> > > OOPS, found a bug. Use this one instead:
> >
> > .31 - no change, it worked before your patch and it works after.
> > None of your debugging printks show up. I tried removing the tlbil_va()
> > from do_dcache_icache_coherency() and userspace goes back to be being
> > slow/non functional.
>
> Had a look at linus tree and there is something I don't understand.
> Your fix, e0908085fc2391c85b85fb814ae1df377c8e0dcb, fixes a problem
> that was introduced by 8d30c14cab30d405a05f2aaceda1e9ad57800f36 but
> 8d30c14cab30d405a05f2aaceda1e9ad57800f36 was included in .31 and .31
> works and top of tree does not, how can that be?
>
> To me it seems more likely that some mm change introduced between .31 and
> top of tree is the culprit.
> My patch addresses the problem described in the comment:
> /* On 8xx, cache control instructions (particularly
>  * "dcbst" from flush_dcache_icache) fault as write
>  * operation if there is an unpopulated TLB entry
>  * for the address in question. To workaround that,
>  * we invalidate the TLB here, thus avoiding dcbst
>  * misbehaviour.
>  */
> Now you are using this old fix to paper over some other bug or so I think.

There is something fishy with the TLB status, looking into the mpc862 manual I
don't see how it can work reliably. Need to dwell some more.
Anyhow, I have incorporated some of my findings into a new patch,
perhaps this will be the golden one?

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
index 52ff8c5..de1fd58 100644
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
@@ -222,6 +231,7 @@ DataAccess:
 	stw	r10,_DSISR(r11)
 	mr	r5,r10
 	mfspr	r4,SPRN_DAR
+	stw	r4,_DAR(r11)
 	EXC_XFER_EE_LITE(0x300, handle_page_fault)

 /* Instruction access exception.
@@ -352,7 +362,7 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-2:	li	r11, 0x00f0
+	li	r11, 0x00f0
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
@@ -365,6 +375,19 @@ InstructionTLBMiss:
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
@@ -428,10 +451,11 @@ DataStoreTLBMiss:
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
@@ -441,7 +465,18 @@ DataStoreTLBMiss:
 	lwz	r3, 8(r0)
 #endif
 	rfi
+2:
+	li	r10, 0
+	mtspr	SPRN_DSISR, r10 /* Clear all bits */

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
@@ -492,6 +527,8 @@ DataTLBError:
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
 	mfspr	r10, SPRN_DAR
+	cmpwi	cr0, r10, 0x00f0	/* check if DAR holds a tag */
+	beq-	2f
 	rlwinm	r11, r10, 0, 0, 19
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, SPRN_M_CASID
@@ -550,6 +587,7 @@ DataTLBError:
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
+	mtspr	SPRN_DAR, r11		/* Tag DAR */

 	mfspr	r10, SPRN_M_TW	/* Restore registers */
 	lwz	r11, 0(r0)
