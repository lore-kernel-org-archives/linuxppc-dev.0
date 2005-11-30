Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 42C546884E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 04:34:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 30 Nov 2005 18:34:13 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FE39C@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@embeddedalley.com>,
	gtolstolytkin@ru.mvista.com, linuxppc-embedded@ozlabs.org
Subject: RE: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>=20
> On Mon, Nov 07, 2005 at 07:37:45PM +0100, Joakim Tjernlund wrote:
> >  >=20
> > > On Mon, Nov 07, 2005 at 07:14:15PM +0100, Joakim Tjernlund wrote:
> > > > > -----Original Message-----
> > > > > From: Tom Rini [mailto:trini@kernel.crashing.org]=20
> > > > > Sent: 07 November 2005 16:52
> > > > > To: Marcelo Tosatti
> > > > > Cc: Joakim Tjernlund; Pantelis Antoniou; Dan Malek;=20
> > > > > linuxppc-embedded@ozlabs.org; gtolstolytkin@ru.mvista.com
> > > > > Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
> > > > >=20
> > > > > On Mon, Nov 07, 2005 at 08:16:18AM -0200, Marcelo=20
> Tosatti wrote:
> > > > > > Joakim!
> > > > > >=20
> > > > > > On Mon, Nov 07, 2005 at 03:32:52PM +0100, Joakim=20
> > > Tjernlund wrote:
> > > > > > > Hi Marcelo
> > > > > > >=20
> > > > > > > [SNIP]=20
> > > > > > > > The root of the problem are the changes against=20
> the 8xx TLB=20
> > > > > > > > handlers introduced
> > > > > > > > during v2.6. What happens is the TLBMiss=20
> handlers load the=20
> > > > > > > > zeroed pte into
> > > > > > > > the TLB, causing the TLBError handler to be=20
> invoked (thats=20
> > > > > > > > two TLB faults per=20
> > > > > > > > pagefault), which then jumps to the generic MM code to=20
> > > > > setup the pte.
> > > > > > > >=20
> > > > > > > > The bug is that the zeroed TLB is not invalidated (the=20
> > > > > same reason
> > > > > > > > for the "dcbst" misbehaviour), resulting in infinite=20
> > > > > TLBError faults.
> > > > > > > >=20
> > > > > > > > Dan, I wonder why we just don't go back to v2.4=20
> behaviour.
> > > > > > >=20
> > > > > > > This is one reason why it is the way it is:
> > > > > > >=20
> > > > >=20
> > >=20
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
> > > > > > > This details are little fuzzy ATM, but I think the=20
> > > reason for the
> > > > > > > current
> > > > > > > impl. was only that it was less intrusive to impl.
> > > > > >=20
> > > > > > Ah, I see. I wonder if the bug is processor specific: we=20
> > > > > don't have such
> > > > > > changes in our v2.4 tree and never experienced such problem.
> > > > > >=20
> > > > > > It should be pretty easy to hit it right? (instruction=20
> > > > > pagefaults should
> > > > > > fail).
> > > > > >=20
> > > > > > Grigori, Tom, can you enlight us about the issue on the URL=20
> > > > > above. How
> > > > > > can it be triggered?
> > > > >=20
> > > > > So after looking at the code in 2.6.14 and current git, I=20
> > > think the
> > > > > above URL isn't relevant, unless there was a change I=20
> > > missed (which
> > > > > could totally be possible) that reverted the patch there and=20
> > > > > fixed that
> > > > > issue in a different manner.  But since I didn't figure that=20
> > > > > out until I
> > > > > had finished researching it again:
> > > >=20
> > > > I wasn't clear enough. What I meant was that the above=20
> patch made me
> > > > think and
> > > > the result was that I came up with a simpler fix, the "two=20
> > > exception"
> > > > fix that
> > > > is in current kernels. See
> > > >=20
> > >
http://linux.bkbits.net:8080/linux-2.6/diffs/arch/ppc/kernel/head_8xx.S@
> > > >=20
> > > 1.19?nav=3Dindex.html|src/.|src/arch|src/arch/ppc|src/arch/ppc/k
> > > ernel|hist
> > > > /arch/ppc/kernel/head_8xx.S
> > > > It appears this fix has some other issues :(
> > > >=20
> > > > How do the other ppc arches do? I am guessing that they=20
> don't double
> > > > fault, but bails
> > > > out to do_page_fault from the TLB Miss handler, like=20
> 8xx used to do.
> > >=20
> > > Assuming Dan doesn't come up with a more simple & better=20
> fix, maybe we
> > > should go back to the original patch I made?
> >=20
> > That was what I was thinking too(or some variation of your patch)
> > I wonder if that would solve the misbehaving dcbst problem=20
> Marcelo found
> > some time ago too?
>=20
> Hi Joakim,
>=20
> Yes, it would fix the "dcbst" issue. That problem was triggered by a
> zeroed TLB entry.
>=20
> In practice it seems that the "three exception" approach does=20
> not impose
> a significant overhead in comparison with the "two exception" version
> (as can be seen by the results of the latency tests).
>=20
> Anyway, if decided upon, the "two exception" version (no zeroed TLB
> entry state) needs the TLBMiss handler should to the present=20
> bit as Dan
> mentioned.
>=20
> I don't know what Dan is up to, he meant to be doing=20
> significant changes.

Dan, any progress?

>=20
> I'll be playing with TLB preloading next week... how's your=20
> TLB handler
> shrinkage idea?

Well, here is a first step.
This patch will save 2 instructions in the hot path and removes the need
to save=20
registers around address 0 in the ITLB Miss handler IFF you use pinned
TLBs and no modules.

What do you think?

 Jocke

--- head_8xx.S.org	Wed Nov 30 16:38:30 2005
+++ head_8xx.S	Wed Nov 30 18:19:16 2005
@@ -300,14 +300,17 @@
 #endif
 	DO_8xx_CPU6(0x3f80, r3)
 	mtspr	SPRN_M_TW, r10	/* Save a couple of working registers */
+#if !CONFIG_PIN_TLB || CONFIG_MODULES
 	mfcr	r10
 	stw	r10, 0(r0)
-	stw	r11, 4(r0)
+#endif
+	mtspr	SPRN_SPRG2, r11	/* Save a couple of working registers */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	DO_8xx_CPU6(0x3780, r3)
 	mtspr	SPRN_MD_EPN, r10	/* Have to use MD_EPN for walk,
MI_EPN can't */
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
=20
+#if !CONFIG_PIN_TLB || CONFIG_MODULES
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
@@ -319,12 +322,19 @@
 3:
 	lwz	r11, 0(r10)	/* Get the level 1 entry */
 	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address
*/
-	beq	2f		/* If zero, don't try to find a pte */
-
+	ori	r11,r11,1	/* Set valid bit */
+	beq-	2f		/* If zero, don't try to find a pte */
+#else
+	lwz	r11, 0(r10)	/* Get the level 1 entry */
+	mfcr	r10		/* Save CR */
+	cmplwi	cr0,r11,0x0fff	/* Test page descriptor page address */
+	ori	r11,r11,1	/* Set valid bit */
+	bng-	3f		/* If zero, don't try to find a pte */
+	mtcr	r10		/* Restore CR */
+#endif
 	/* We have a pte table, so load the MI_TWC with the attributes
 	 * for this "segment."
 	 */
-	ori	r11,r11,1		/* Set valid bit */
 	DO_8xx_CPU6(0x2b80, r3)
 	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 	DO_8xx_CPU6(0x3b80, r3)
@@ -347,13 +357,19 @@
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
=20
 	mfspr	r10, SPRN_M_TW	/* Restore registers */
+#if !CONFIG_PIN_TLB || CONFIG_MODULES
 	lwz	r11, 0(r0)
 	mtcr	r11
-	lwz	r11, 4(r0)
+#endif
+	mfspr	r11, SPRN_SPRG2	/* Restore registers */
 #ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	rfi
+#if !CONFIG_PIN_TLB || CONFIG_MODULES
+3:	mtcr	r10
+	ba	2b
+#endif
=20
 	. =3D 0x1200
 DataStoreTLBMiss:
