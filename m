Date: Mon, 23 Jun 2003 13:16:41 -0400 (EDT)
From: Chris Studholme <cvs@cs.utoronto.ca>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org,
	Terry Greeniaus <tgree@phys.ualberta.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pismo upgraded to 750fx not detected correctly
In-Reply-To: <20030623082751.GA2738@iram.es>
Message-ID: <Pine.LNX.4.44.0306231306590.5151-100000@stoa.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Jun 2003, Gabriel Paubert wrote:
> > diff -c -r linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S linux-2.4.21-ac1/arch/ppc/kernel/misc.S
> > *** linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S	Fri Jun 13 10:51:31 2003
> > --- linux-2.4.21-ac1/arch/ppc/kernel/misc.S	Sun Jun 22 21:25:32 2003
> > ***************
> > *** 113,118 ****
> > --- 113,139 ----
> >   	addis	r8,r3,cpu_specs@ha
> >   	addi	r8,r8,cpu_specs@l
> >   	mfpvr	r7
> > +
> > + /* check for 750fx strapped on as 750 */
> > + 	srwi	r6,r7,16
> > + 	cmpli	0,r6,8
> > + 	bne	1f
> > + 	mfspr	r5,0x3F1
> > + 	srwi.	r6,r5,17
> > + 	bso	2f
>
> Are you sure you want to test the summary overflow bit
> in this branch ? This bit is not related to the result
> of the preceding srwi. instruction, so this looks
> strange to say the least.

What I was trying to do is test the last bit shifted out by the srwi., but
I still don't know how to do that, so how about this instead:

	mfspr	r5,0x3F1
	andis.	r6,r5,0x0001
	bne	2f

> > + 	xori	r6,r5,0x0200
> > + 	b	3f
> > + 2:
> > + 	xori	r6,r5,0x0002
> > + 3:
> > + 	mtspr	0x3F1,r6
> > + 	mfspr	r6,0x3F1
> > + 	cmplw	0,r5,r6
> > + 	beq	1f
> > +
> > + /* pvr is actually 0x7000nnnn, not 0x0008nnnn */
> > + 	xoris	r7,r7,0x7008
> > +
> >   1:
> >   	lwz	r5,CPU_SPEC_PVR_MASK(r8)
> >   	and	r5,r5,r7
> > ***************
> > *** 127,132 ****
> > --- 148,158 ----
> >   	slwi	r4,r4,2
> >   	sub	r8,r8,r3
> >   	stwx	r8,r4,r6
> > +
> > + 	addis	r6,r3,real_pvr@ha
> > + 	addi	r6,r6,real_pvr@l
> > + 	stwx	r7,0,r6
>
> A bit convoluted no? r3 is supposed to be zero, so
> the standard way of performing this is:
> 	lis r6,real_pvr@ha
> 	stw r7,real_pvr@l(r6)

I believe when this method is called, there is some concern over where
data is.  The method comments are:

  /*
   * identify_cpu,
   * called with r3 = data offset and r4 = CPU number
   * doesn't change r3
   */

and all of the other references to global data involve r3, like:

	addis	r8,r3,cpu_specs@ha
	addi	r8,r8,cpu_specs@l

and

	addis	r6,r3,cur_cpu_spec@ha
	addi	r6,r6,cur_cpu_spec@l
	slwi	r4,r4,2
	sub	r8,r8,r3
	stwx	r8,r4,r6

so I figured I should do the same.  But perhaps I could still simplify my
code with:

	addis	r6,r3,real_pvr@ha
	stwx	r7,real_pvr@l(r6)

> > +
> >   	blr
> >

Chris.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
