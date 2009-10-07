Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67F3BB7B7A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 10:35:58 +1100 (EST)
In-Reply-To: <OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@LocalDomain>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>
	<OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@LocalDomain>
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
Message-ID: <OFF10831EF.A11E2609-ONC1257648.00813FA6-C1257648.0081783B@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 01:34:09 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 08/10/2009 01:11:23:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 00:20:17:
> >
> > On Thu, 2009-10-08 at 00:08 +0200, Joakim Tjernlund wrote:
> > >
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:14:52:
> > > >
> > > > On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> > > >
> > > > > +   andi.   r11, r10, _PAGE_USER | _PAGE_ACCESSED
> > > > > +   cmpwi   cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> > > > > +   bne-   cr0, 2f
> > > >
> > > > Did you mean _PAGE_PRESENT | _PAGE_ACCESSED ?
>
> YES! cut and paste error, will send a new much improved patch
> with my new idea.

So here it is(on top for now), what do you think?

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 8c4c416..fea9f5b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -339,8 +339,8 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */

-	andi.	r11, r10, _PAGE_USER | _PAGE_ACCESSED
-	cmpwi	cr0, r11, _PAGE_USER | _PAGE_ACCESSED
+	andi.	r21, r20, _PAGE_ACCESSED | _PAGE_PRESENT
+	cmpwi	cr0, r21, _PAGE_ACCESSED | _PAGE_PRESENT
 	bne-	cr0, 2f
 	/* Dont' bother with PP lsb, bit 21 for now */

@@ -365,7 +365,10 @@ InstructionTLBMiss:
 	rfi
 2:
 	mfspr	r11, SRR1
-	rlwinm	r11, r11, 0, 5, 3 /* clear guarded */
+	/* clear all error bits as TLB Miss
+	 * sets a few unconditionally
+	*/
+	rlwinm	r21, r21, 0, 0xffff
 	mtspr	SRR1, r11

 	mfspr	r10, SPRN_M_TW	/* Restore registers */
@@ -422,8 +425,8 @@ DataStoreTLBMiss:

 	andi.	r11, r10, _PAGE_ACCESSED
 	bne+	cr0, 5f	/* branch if access allowed */
-	rlwinm	r10, r10, 0, 21, 19 /* Clear _PAGE_USER */
-	ori	r10, r10, _PAGE_RW  /* Set RW bit for xor below to clear it */
+	/* Need to know if load/store -> force a TLB Error */
+	rlwinm	r20, r20, 0, 0, 30 /* Clear _PAGE_PRESENT */
 5:	xori	r10, r10, _PAGE_RW  /* invert RW bit */

 	/* The Linux PTE won't go exactly into the MMU TLB.
@@ -482,8 +485,11 @@ DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR *
 	/* First, make sure this was a store operation.
 	*/
 	mfspr	r11, SPRN_DSISR
-	andis.	r11, r11, 0x4000 /* no translation */
-	bne	2f	/* branch if set */
+	andis.	r21, r21, 0x4800	/* !translation or protection */
+	bne	2f	/* branch if either is set */
+	/* Only Change bit left now, do it here as it is faster
+	 * than trapping to the C fault handler.
+	*/

 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
@@ -533,16 +539,8 @@ DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR *
 	mfspr	r11, SPRN_MD_TWC		/* ....and get the pte address */
 	lwz	r10, 0(r11)		/* Get the pte */

-	mfspr	r11, DSISR
-	andis.	r11, r11, 0x0200	/* store */
-	beq	5f
-	andi.	r11, r10, _PAGE_RW	/* writeable? */
-	beq	2f /* nope */
-	ori	r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
-5:	ori	r10, r10, _PAGE_ACCESSED
-	mfspr	r11, MD_TWC		/* Get pte address again */
+	ori	r10, r10, _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HWWRITE
 	stw	r10, 0(r11)		/* and update pte in table */
-
 	xori	r10, r10, _PAGE_RW	/* RW bit is inverted */

 	/* The Linux PTE won't go exactly into the MMU TLB.
