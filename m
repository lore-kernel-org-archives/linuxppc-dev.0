Message-ID: <39E62C4C.42287094@student.ethz.ch>
Date: Thu, 12 Oct 2000 23:25:33 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
CC: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
References: <Pine.LNX.4.21.0010122029001.1217-100000@idd-01.imbc.gr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kostas Gewrgiou wrote:
>
> On Thu, 12 Oct 2000, Michel [iso-8859-1] Dänzer wrote:
>
> > Kostas Gewrgiou wrote:
> > >
> > > Kevin Hendricks patches from Ani's tree will fix the memory/clock values
> > > for OF cards only, the patch breaks the calculations for the x86 cards
> > > (thats the reason why its not in the xfree cvs),
> >
> > But there is an #ifdef _powerpc_ so it can't break x86 machines?
>
> Yes but it *does* break x86 cards used in ppc machines.
> (linux/ppc isn't the only ppc os supported in xfree and they won't
> be happy if we break things for them)

And the int10 or whatever code works for them?


> > > The current test only checks if a rom is present not if a bios or OF
> > > segment is there, it needs to be fixed to check that its really reading
> > > from a bios rom and not from something else (OF).
> >
> > So this code from the current X CVS:
> >
> >     R128ReadBIOS(0x0000, info->VBIOS, R128_VBIOS_SIZE);
> >     if (info->VBIOS[0] != 0x55 || info->VBIOS[1] != 0xaa) {
> >         xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
> >                    "Video BIOS not detected in PCI space!\n");
> >
> > only checks if there is a ROM, not if it's a BIOS?
>
> Right, from the pci spec the table is something like this
> Offset    Length    Value    Description
> 0h          1        55h    ROM Signature, byte 1
> 1h          1        AAh    ROM Signature, byte 2
> ...
> 18h-19h     2        xx     Pointer to PCI Data Structure
>
> PCI Data Structure
> Offset    Length  Description
> ...
> 14           1    Code Type
> ..
>
> Code Type is 0 for bios and 1 for OF
>
> So you'll have to add one more test to check for BIOS/OF

And then set info->VBIOS = NULL for OF and change the #ifdef _powerpc_ to if
(!info->VBIOS) or similar?


I have my last exam for this year tomorrow and leave for two weeks of vacation
on Saturday, so I wish good luck to any takers :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
