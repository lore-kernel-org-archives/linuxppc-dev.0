Return-Path: <becky.bruce@freescale.com>
In-Reply-To: <43D0A21D-89BC-4EFE-BA2A-94760BA32276@kernel.crashing.org>
References: <43D0A21D-89BC-4EFE-BA2A-94760BA32276@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <28076a8ba1e55469c74b0677a289fd0b@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Date: Wed, 16 Nov 2005 10:31:59 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Merge align.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >
> > The 603 is still in production? And is the upcoming 8641 exactly
> > the same as the 74xx series in this respect?
>
> 603 is used in all 82xx/83xx processors from Freescale. The 8641 is=A0
> the same core as 7448.

The differences between 603 and 603e wrt alignment exceptions, as far=20
as I can tell, are:
- 603 does not take exception on misaligned LE accesses except for=20
strings and multiples
- 603 takes an alignment exception on ecowx/eciwx, 603e does not
- 603 generates an alignment when a ld/st crosses a segment boundary=20
and the T bit is different in the 2 segments

I should have listed these out above, sorry!

>
> >> - single and double precision floating point ld/st ops (non-E500,=20=

> non
> >> data size aligned)
> >
> > Hmm, you can load a double from any 4 byte aligned address AFAIR.
>
> This is only because every processor handles the misalignment for=A0
> you.=A0 Its completely valid for someone to build a PPC that has an=A0
> alignment exception in this case.

You're right, I should have said "word-aligned", not "data size=20
aligned".  While a load of a doubleword from a word aligned address is=20=

considered misaligned by the hardware, it doesn't generate an exception=20=

in any parts we have now that I know of.

> > However we do care about byte reversal instructions, which
> > probably believe like the corresponding normal instruction
> > (i.e., lwbrx has the same rules as lwzx, etc.)

Yep, they would work the same way, which for all of FSL's current parts=20=

would mean no exception.

> >
> >> - lwarx/stwcx (all procs)
> >
> > And ldarx/stdcx. on 64 bit, but these ones should not
> > be emulated. So it's easy ;-)
> >
> >> - multiple/string with LE set (750, 603e, 7450, 7400)
> >
> > Again LE mode is probably irrelevant.
>
> Agree with that. We dont support LE on classic.

Yep.  Just listed for completeness.

>
>
> >> - eciwx/ecowx (750, 7450, 7400)
> >
> > Have these instructions ever been used for something
> > under Linux?
>
> I dont believe so.

These guys are legagy - I don't think anyone uses them, and the=20
alignment exception doesn't (and, IMHO shouldn't) care about them at=20
all.   They're just listed here for completeness.

>
> >> - a couple of others related to vector processing
> >
> > Which ones? The Altivec load and store instructions
> > simply mask the low order bits AFAIR.
>
> SPE misalignment is something to look at.

I'll look into it when I have a moment to breathe......  There are 2=20
conditions here that aren't currently handled (from the manual):
- SPFP and SPE instructions are not aligned on a natural boundary=20
(defined by the size of the data element being accessed)
- physical address of certain evld/st instructions is not aligned on a=20=

64-bit boundary.
=09
>
> >> If anybody knows offhand of something missing there, let me know.
> >
> > Nothing, but did you check when crossing a segment (256MB) boundary.
> > I seem to remember that some processors performed misaligned
> > load/store across pages but not across segments.

As far as I can tell, the only one that cares about segment boundaries=20=

is 603 (604, 604e, and 601 may care, but I don't consider those=20
"current", and I don't have any working hardware).  And it only takes=20
an exception if there's a difference in the T-bit across the segments.

Cheers!
-B=
