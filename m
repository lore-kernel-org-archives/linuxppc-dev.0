Message-ID: <001501c239f2$69a3b340$43ba459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <39044C84-A5E2-11D6-A3EA-0003939A0A86@mvista.com>
Subject: Re: symbol card with orinoco_cs on mpc823
Date: Fri, 2 Aug 2002 15:01:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks David and Matthew.

I also tried to enlarge the setup/hold/strobe parameter in m8xx_pcmcia.c by
double the ADJ to 360.
But it remains the same. Maybe i'll try to set the parameter manually.

regards

----- Original Message -----
From: "Matthew Locke" <mlocke@mvista.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, August 02, 2002 2:36 PM
Subject: Re: symbol card with orinoco_cs on mpc823


>
> On Thursday, August 1, 2002, at 11:23 PM, David Gibson wrote:
>
> >
> > On Fri, Aug 02, 2002 at 02:01:52PM +0800, shaowei dai wrote:
> >>
> >> Hello,
> >>
> >> Has anybody tried orinodo_cs 0.11b or 0.12b with success on symbol
> >> Spectrum24 High rate11M card on mpc platform?
> >> I've tried 2.4.18-pre3 and 2.4.19-rc3 kernel with orinoco driver. It
> >> works
> >> fine with intersil card. But
> >> when i try it on symbol card, it always crashes. After tracing down i
> >> find
> >> it is caused by hermes_init(). It seems the
> >> call to hermes_write_regn(hw,INTEN,0)  cause the crash. The ksymoops
> >> also
> >> suggest this function. It is just an io write. What can be wrong? And
> >> most
> >> strange thing is why it doesn't cause any trouble in normal intersil
> >> card.
> >
> > That's wierd - it is just a register write, so this sounds like a
> > low-level problem.  Is something about the card confusing the PCMCIA
> > system so it's reporting the wrong IO addresses?  Or maybe the timing
> > is a little bit different and something in the slot driver can't cope.
> >
>
> I would guess timing.  I have seen problems between different cards with
> the same chipset fail on 8xx.  Usually timing is the culprit.
>
> > --
> > David Gibson | For every complex problem there is a
> > david@gibson.dropbear.id.au | solution which is simple, neat and
> > | wrong.
> > http://www.ozlabs.org/people/dgibson
> >
> >
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
