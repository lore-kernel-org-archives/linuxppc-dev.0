Message-ID: <392903EC.FE7BE532@da-san.com>
Date: Mon, 22 May 2000 18:54:52 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Marcus Sundberg <marcus@cendio.se>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com> <vehfbtasi8.fsf@lipta.cendio.se> <39289DA5.F0A5B8FF@da-san.com> <vevh07dj26.fsf@lipta.cendio.se>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Seungdong Lee <sdlee@da-san.com> writes:
>
> > Marcus Sundberg wrote:
> > > I'm not very familiar with 82x0 processors, but doesn't 8240 use a
> > > 603-core? When I worked with a 603ev running at 200 MHz I got
> > > something like 133 BogoMIPS, so then the above value would be correct.
> > >
> >
> > Good information.
> > But, why it is 133 BogoMIPS?
>
> Because that's what a 200 MHz PowerPC 603 gives you.
> Checking the BogoMIPS howto will show you one report of a 603,
> running at 100 MHz and giving 66 BogoMIPS, which is at par with
> our results.
>
> > I still think that the correct value is 400.
>
> Unless you have tried other 603-based sytems you have no reason to
> think so. I repeat my statement from the previous post:
>

You are right, but you might think in other way if you read instruction timing
section in 603 manual.
Branch instruction needs only 1 CPU clock and test loop is as follows.

extern __inline__ void __delay(unsigned int loops)
{
        if (loops != 0)
                __asm__ __volatile__("mtctr %0; 1: bdnz 1b" : :
                                     "r" (loops) : "ctr");
}

"bdnz" instruction is executed 'loops' times.
bdnz is the instruction which jumps to itself. Loop count is controlled by CTR
register.

Please check the BogoMIPS algorithm.
It is still misterious to me.

Bye.

-- Seungdong Lee

>
> > > The BogoMIPS can be used for rough sanity-checks when comparing
> > > processors with identical cores and different clocks. For anything
> > > else it's completely useless.
>
> //Marcus
> --
> -------------------------------+-----------------------------------
>         Marcus Sundberg        |       Phone: +46 707 452062
>   Embedded Systems Consultant  |      Email: marcus@cendio.se
>        Cendio Systems AB       |       http://www.cendio.com
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
