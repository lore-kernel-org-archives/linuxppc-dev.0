Date: Thu, 12 Oct 2000 20:44:30 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <39E5F33D.8166A4DD@student.ethz.ch>
Message-ID: <Pine.LNX.4.21.0010122029001.1217-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Michel [iso-8859-1] Dänzer wrote:

> Kostas Gewrgiou wrote:
> >
> > Kevin Hendricks patches from Ani's tree will fix the memory/clock values
> > for OF cards only, the patch breaks the calculations for the x86 cards
> > (thats the reason why its not in the xfree cvs),
>
> But there is an #ifdef _powerpc_ so it can't break x86 machines?

Yes but it *does* break x86 cards used in ppc machines.
(linux/ppc isn't the only ppc os supported in xfree and they won't
be happy if we break things for them)

> > The new r128 code needs to read extra values from the rom for the flatpanel
> > setup as well (Michel knows more about this) which we will have to find a
> > solution too.
>
> And it will be hard. Rumour has it that the correct values are in MacOS and
> only Apple knows how to do it right, not even ATI. The default values work
> more or less on my Pismo, but there is always the danger of damaging the
> panel.

Damn thats not good :(

> Note that the FP code is only needed for stretching modes with a lower
> resolution than the panel's, just disabling it altogether works fine for the
> full resolution.
>
> > The current test only checks if a rom is present not if a bios or OF segment
> > is there, it needs to be fixed to check that its really reading from a
> > bios rom and not from something else (OF).
>
> So this code from the current X CVS:
>
>     R128ReadBIOS(0x0000, info->VBIOS, R128_VBIOS_SIZE);
>     if (info->VBIOS[0] != 0x55 || info->VBIOS[1] != 0xaa) {
>         xf86DrvMsg(pScrn->scrnIndex, X_WARNING,
>                    "Video BIOS not detected in PCI space!\n");
>
> only checks if there is a ROM, not if it's a BIOS?

Right, from the pci spec the table is something like this
Offset    Length    Value    Description
0h          1        55h    ROM Signature, byte 1
1h          1        AAh    ROM Signature, byte 2
...
18h-19h     2        xx     Pointer to PCI Data Structure

PCI Data Structure
Offset    Length  Description
...
14           1    Code Type
..

Code Type is 0 for bios and 1 for OF

So you'll have to add one more test to check for BIOS/OF

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
