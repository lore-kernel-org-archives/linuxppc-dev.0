Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6F80FDDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 20:34:11 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0H9Y96k010474 for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 02:34:09 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0H9Y6Ub005937
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 03:34:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: PCI IRQ -MPC8540
Date: Wed, 17 Jan 2007 17:34:06 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A07108C@zch01exm27.fsl.freescale.net>
In-Reply-To: <5C902FB2-CF5C-466A-B7AF-8D0B4BFA1A25@kernel.crashing.org>
From: "Jin Zhengxiong-R64188" <Jason.Jin@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"agnel juni" <junijoseph@yahoo.co.in>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



>What kinda of interrupt do you want on IRQ_OUT/INTA?

>- k

On Jan 16, 2007, at 7:54 PM, agnel juni wrote:

> Yes IRQ_OUT is wired to INTA.
>
> Could you please advise on how to generate interrupt for this.

You can refer to a Freescale Linux BSP for MPC8540EVAL board. There's a =
pci agent driver for MPC8540, and the corresponding host driver for =
MPC8560. The agent driver use a message interrupt in MPC8540 and =
redirect the interrupt to IRQ_OUT. As the IRQ_OUT is wired to INTA, you =
can treat MPC8540 as a PCI device.

Jason Jin


> Thanks
> J-
>
> ----- Original Message ----
> From: Kumar Gala <galak@kernel.crashing.org>
> To: agnel juni <junijoseph@yahoo.co.in>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Tuesday, 16 January, 2007 5:29:01 PM
> Subject: Re: PCI IRQ -MPC8540
>
>
> On Jan 16, 2007, at 5:20 PM, agnel juni wrote:
>
> > Hello all:
> >
> > I would like to understand if there is a way to program the PCI=20
> > interrupt pin register of MPC8540. I did look for this in the=20
> > datasheet, but couldn't find any positive answer.
> >
> > Currently, I am working in a set-up where MPC8540 is an agent,=20
> > plugged into the PC host. I couldn't get an IRQ for the card when=20
> > plugged in some PCI slots, whereas in one of the slots I do see a=20
> > non-zero value.
> >
> > It would be great if you could help me understand the issue.
> >
> > I am sorry if the question is inapporpriate in the group. I am=20
> > desperate to solve the issue.
> >
> > Thanks for any help.
>
> You need to find out how the PCI edge interrupts are wired on you=20
> board than we can talk about how to generate an interrupt based on=20
> that.  I'd guess IRQ_OUT is wired to INTA, but it would be good to=20
> verify that.
>
> - k
>
> > J.Joseph
> >
> > ----- Original Message ----
> > From: Kumar Gala <galak@kernel.crashing.org>
> > To: Wang Matthew-R59995 <Qi.W@freescale.com>
> > Cc: linuxppc-embedded@ozlabs.org
> > Sent: Wednesday, 18 October, 2006 6:54:24 PM
> > Subject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36
> >
> >
> > On Oct 18, 2006, at 8:10 PM, Wang Matthew-R59995 wrote:
> >
> > > Hi Kumar,
> > >
> > > Actually I do many trials about it. Vxwerks Bootrom is smaller
> than
> > > U-Boot. The key difference between Bootrom and U-boot is that some =

> > > source code of Bootrom is invisible to the users.
> > >
> > > Actually the rfi instruction which I point out is the first rfi=20
> > > instruction of Linux PowerPC bringup.
> > >
> > > Before that, it's TLB entry invalidation and temp TLB entry
> mapping.
> > >
> > > I check MMU setting carefully before coming Linux Kernel.
> > >
> > > I just want to know if other guys met similar scenario like me. I=20
> > > don't need the precise answer, just overall suggestion about it
> because I
> > > understand that not everyone has the same bootloader of mine, that =

> > > bootloader is actually a customized bootloader.
> >
> > I understand that, thus I was asking what exact problem you were=20
> > seeing to try and help.
> >
> > > Anyway thank you.
> > >
> > > R9 point to LR register, mask the high 20 bit of r9 and send to
> r7,
> > > and
> > > then add 24, which means stride 6 instructions for rfi instruction =

> > > execution.
> > >
> > > Of course, rfi can switch the TLB entry, both the previous TLB=20
> > > entry and the temp TLB entry point to the same physical address.
> > >
> > > I've checked it.
> >
> > I know what the code does, I wrote it :)
> >
> > - kumar
> >
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org=20
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > Here's a new way to find what you're looking for - Yahoo! Answers
>
>
>
> Here's a new way to find what you're looking for - Yahoo! Answers

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org =
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
