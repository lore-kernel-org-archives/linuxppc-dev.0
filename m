Date: Mon, 24 Mar 2003 15:20:48 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <IGEFJKJNHJDCBKALBJLLCEGDFLAA.joakim.tjernlund@lumentis.se>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Cc: strauman@SLAC.Stanford.EDU
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCEGFFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Hi list
> >
> > I have been researching why I can't use dcbz and friends on 8xx CPU.
> > Till Strauman found out long ago that the dcxx instuctions did not update
> > the DAR register and that was the key I needed.
> >
> > After a lot of testing/reading I found a 2 instruction workaround
> > that lets me use dcbz in copy_tofrom_user().
> > I can also used dcbz in a user space app without problems. I even
> > removed the TLB change bit hack by Tom Rini and everything works.
> >
> > By copying the MD_EPN register to the DAR register in the DTLB Miss handler
> > just before MD_RPN is written everything just works. The only explanation that
> > makes sense to me is that the MD_RPN has a undocumented dependency to the DAR
> > register, the 20 msb of MD_EPN and DAR needs to be the same before MD_RPN is written.
>
> hmm, this is not quite correct. I can copy MD_EPN to DAR after the write to MD_RPN
> and it still works. Seems like DAR must be correct when rfi is executed. I wonder
> why?

hmm, can it be that when you return from the DTLB Miss, you sometimes get an DTLB error
immediately and that DTLB Error "inherits" the DAR from the DTLB Miss?

I removed the "copy DAR to MD_EPN" part in the DTLB Error handler and my systems
runs fine.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
