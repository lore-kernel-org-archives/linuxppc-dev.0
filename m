Message-ID: <39AD5E8E.E3C244D8@mvista.com>
Date: Wed, 30 Aug 2000 12:20:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com> <20000830215856.B5340@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:

> Hi, Mark!
>
> On Tue, Aug 29, 2000 at 12:16:09PM -0700, you wrote the following:
>
> > > I downloaded the kernel and tried it. It starts booting, but it hangs
> > > right after initializing the the OpenPIC. :-( I'll download the source
> > > code tonight and try to look at it, although I don't have much hopes
> > > gotta learn though.
> > >
> > > Is there any book that you recommend to get me started? Any other
> > > docs/tips?
> >
> > Oops, I should have included the sandpoint switch settings.  For
> > this version of the kernel, the sandpoint switches must be set as
> > follows:
> >
> > S4,S3: up, down
> > S5: down
> > S6: down (yours is probably up which is why it hung in openpic)
> >
> > Try this and see if it helps.
>
> It did! The kernel boots fine now all the way through.
>
> Thanks a lot!
>
> Another question: what would be the best way to go about booting Linux
> from the flash? Would flashing the kernel in instead of the dink32
> monitor do the trick, or does dink32 do some important initializations
> that are needed for the kernel to boot?

Yeah, at the moment, it does rely on DINK to do some initial setup (memory
controller, et. al.).  If you want, you can put that in the code yourself and
then you can get rid of DINK.  If you don't want to do that, you can still put
the kernel in flash (somewhere that doesn't overwrite DINK or the execption
vectors) as long as you have enough flash on your PPMC module.  You can then
do something like "env BOOT=<address>" to cause DINK to automatically jump to
that address--that's should be the address of the linux ppc bootloader--and
the kernel will boot up for you without your intervention.

Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
