From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 24 Jun 2003 10:18:29 +0200
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	Terry Greeniaus <tgree@phys.ualberta.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pismo upgraded to 750fx not detected correctly
Message-ID: <20030624081829.GA30884@iram.es>
References: <20030623082751.GA2738@iram.es> <Pine.LNX.4.44.0306231306590.5151-100000@stoa.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0306231306590.5151-100000@stoa.dhs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 23, 2003 at 01:16:41PM -0400, Chris Studholme wrote:
> On Mon, 23 Jun 2003, Gabriel Paubert wrote:
> > > diff -c -r linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S linux-2.4.21-ac1/arch/ppc/kernel/misc.S
> > > *** linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S	Fri Jun 13 10:51:31 2003
> > > --- linux-2.4.21-ac1/arch/ppc/kernel/misc.S	Sun Jun 22 21:25:32 2003
> > > ***************
> > > *** 113,118 ****
> > > --- 113,139 ----
> > >   	addis	r8,r3,cpu_specs@ha
> > >   	addi	r8,r8,cpu_specs@l
> > >   	mfpvr	r7
> > > +
> > > + /* check for 750fx strapped on as 750 */
> > > + 	srwi	r6,r7,16
> > > + 	cmpli	0,r6,8
> > > + 	bne	1f
> > > + 	mfspr	r5,0x3F1
> > > + 	srwi.	r6,r5,17
> > > + 	bso	2f
> >
> > Are you sure you want to test the summary overflow bit
> > in this branch ? This bit is not related to the result
> > of the preceding srwi. instruction, so this looks
> > strange to say the least.
>
> What I was trying to do is test the last bit shifted out by the srwi., but
> I still don't know how to do that, so how about this instead:
>
> 	mfspr	r5,0x3F1
> 	andis.	r6,r5,0x0001
> 	bne	2f

This looks much better, and is the standard way
of testing a bit on PPC.

> > >   	slwi	r4,r4,2
> > >   	sub	r8,r8,r3
> > >   	stwx	r8,r4,r6
> > > +
> > > + 	addis	r6,r3,real_pvr@ha
> > > + 	addi	r6,r6,real_pvr@l
> > > + 	stwx	r7,0,r6
> >
> > A bit convoluted no? r3 is supposed to be zero, so

Argh, disregard this. I've been lately working too much with
an assembler in which the result is the last operand and
believed that sub r8,r8,r3 was a convoluted way of clearung r3.

> > the standard way of performing this is:
> > 	lis r6,real_pvr@ha
> > 	stw r7,real_pvr@l(r6)
>
> I believe when this method is called, there is some concern over where
> data is.  The method comments are:
>
>   /*
>    * identify_cpu,
>    * called with r3 = data offset and r4 = CPU number
>    * doesn't change r3
>    */
>
> and all of the other references to global data involve r3, like:
>
> 	addis	r8,r3,cpu_specs@ha
> 	addi	r8,r8,cpu_specs@l
>
> and
>
> 	addis	r6,r3,cur_cpu_spec@ha
> 	addi	r6,r6,cur_cpu_spec@l
> 	slwi	r4,r4,2
> 	sub	r8,r8,r3
> 	stwx	r8,r4,r6
>
> so I figured I should do the same.  But perhaps I could still simplify my
> code with:
>
> 	addis	r6,r3,real_pvr@ha
> 	stwx	r7,real_pvr@l(r6)

Correct, provided the last instruction is stw instead of stwx, and
unless I miss again something.

	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
