Date: Thu, 12 Oct 2000 19:22:05 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
Subject: Re: dual head r128
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Message-id: <39E5F33D.8166A4DD@student.ethz.ch>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <Pine.LNX.4.21.0010121849230.1017-100000@idd-01.imbc.gr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> On Wed, 11 Oct 2000, Josh Huber wrote:
>
> > On Wed, Oct 11, 2000 at 08:43:28PM +0200, Michel D?nzer wrote:
>
> > > Does aty128fb work on the second card? If yes, try Option "UseFBDev".
> >
> > The secondary card is a PC card, so it's not initialized by OF, but I
> > think the r128 fb driver does a proper initialization of the card, so
> > that shouldn't be the problem.
>
> Kevin Hendricks patches from Ani's tree will fix the memory/clock values
> for OF cards only, the patch breaks the calculations for the x86 cards
> (thats the reason why its not in the xfree cvs),

But there is an #ifdef _powerpc_ so it can't break x86 machines?


> On Thu, 12 Oct 2000, Hendricks, Kevin wrote:
>
> The new r128 code needs to read extra values from the rom for the flatpanel
> setup as well (Michel knows more about this) which we will have to find a
> solution too.

And it will be hard. Rumour has it that the correct values are in MacOS and
only Apple knows how to do it right, not even ATI. The default values work
more or less on my Pismo, but there is always the danger of damaging the
panel.

Note that the FP code is only needed for stretching modes with a lower
resolution than the panel's, just disabling it altogether works fine for the
full resolution.


> > Since he has a bios on a ppc card it would be interesting to see the
> > results of some "bios present?" tests to help determine if a bios is
> > really there or not.  The current test sometimes passes on macs without a
> > bios (possibly OF rom?) and garbage values are returned.
>
> The current test only checks if a rom is present not if a bios or OF segment
> is there, it needs to be fixed to check that its really reading from a
> bios rom and not from something else (OF).

So this code from the current X CVS:

    R128ReadBIOS(0x0000, info->VBIOS, R128_VBIOS_SIZE);
    if (info->VBIOS[0] != 0x55 || info->VBIOS[1] != 0xaa) {
        xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
                   "Video BIOS not detected in PCI space!\n");

only checks if there is a ROM, not if it's a BIOS?


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
