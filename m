Message-ID: <392917C2.A43BDCAB@da-san.com>
Date: Mon, 22 May 2000 20:19:30 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <Pine.BSF.4.21.0005221234370.87833-100000@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

> On Mon, 22 May 2000, Seungdong Lee wrote:
>
> >
> > Marcus Sundberg wrote:
> > > Seungdong Lee <sdlee@da-san.com> writes:
> > > > Marcus Sundberg wrote:
> > > > > I'm not very familiar with 82x0 processors, but doesn't 8240 use a
> > > > > 603-core? When I worked with a 603ev running at 200 MHz I got
> > > > > something like 133 BogoMIPS, so then the above value would be correct.
> > >
> > > > I still think that the correct value is 400.
> > >
> > You are right, but you might think in other way if you read
> > instruction timing section in 603 manual.
> > Branch instruction needs only 1 CPU clock and test loop is as follows.
> >
> > extern __inline__ void __delay(unsigned int loops)
> > {
> >         if (loops != 0)
> >                 __asm__ __volatile__("mtctr %0; 1: bdnz 1b" : :
> >                                      "r" (loops) : "ctr");
> > }
> >
> > "bdnz" instruction is executed 'loops' times.
> > bdnz is the instruction which jumps to itself.
> > Loop count is controlled by CTR register.
>
> In this case you utilize the single dedicated loop HW resorce of
> the PowerPC architecture. I have at times had to resort to this
> kind of handassembling with addition of move-many instructions
> and cache nullify to eliminate copyback reading, simply because
> GCC _does not_ utilize this dedicated hardware on its own.
>
> > Please check the BogoMIPS algorithm.
>
> Rather check the implementation. If it is written in C then it
> will not result in the above assembly construct - it will use
> an ordinary register as loop counter instead.
>

Above inline assembly is not my own.
You can find it in official Linux/PowerPC distribution.
I don't think that compiler changes anything in loop itself.
Bye.

-- Seungdong Lee

>
> --
>   ******************************************************
>   Never ever underestimate the power of human stupidity.
>   -Robert Anson Heinlein
>
>                 GeirFRS@invalid.and.so.forth
>   ******************************************************
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
