Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45028B2A3@NTSERVER4>
From: Phil Thompson <philt@4bridgeworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC440GX GigE support - Update
Date: Fri, 14 May 2004 09:59:16 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


With a bit more digging I've come to the conclusion that interrupts are not
the cause of the problem. It seems more like the time taken by the SCSI
driver to initialise 2 SCSI buses is triggering the problem.

If I hack the SCSI driver detect code to just delay before returning "not
found" then things work with an overal delay of 2 seconds, but fail with an
overall delay of 4 seconds.

This would imply the problem is just within the GigE driver. Matt, comments?

Thanks,
Phil

> -----Original Message-----
> From: Phil Thompson
> Sent: 13 May 2004 12:44
> Subject: RE: PPC440GX GigE support
>
> I'm having some problems with this on an Ocotea board (using the
> latest source).
>
> With the default Ocotea configuration everything works fine when
> booting over both eth0 and eth3. If I then configure support for the
> SYM53C8XX_2 SCSI driver then everything continues to be fine for eth0,
> but with eth3 the system times out trying to autoconfigure using
> BOOTP. Packets are being sent Ok (irq 10 is raised and you see them on
> the wire), but they are not received (irq 11 is never raised).
>
> About 1 time in 10 the system will boot successfully.
>
> I don't think the SCSI driver is particularly relevant - just that
> it is a source of interrupts (irq 23) that occur after the MAL
> interrupts are enabled and before the kernel tries to use the network
> to autoconfigure.
>
> The implication is that there are problems in ppc4xx_pic.c in handling
> the 3rd UIC of the 440GX. There seems to be at least one bug in
> ppc4xx_uic_end() in the first case statement - there is no "case 2:"
> clause and it looks as if there should be - but it isn't the cause of
> the problem.
>
> I'll continue digging, but I'd welcome any ideas from anybody with
> more experience of interrupt handling on the 440GX.
>
> > -----Original Message-----
> > From: Matt Porter [mailto:mporter@kernel.crashing.org]
> > Sent: 19 April 2004 19:57
> > Subject: PPC440GX GigE support
> >
> > I've pushed a bunch of code for this to the linux-2.5-ocp tree.
> > It overhauls the EMAC driver a bit and adds a number of fields to
> > the new OCP EMAC .additions field that are set per SoC or by the
> > board specific code. There's support for GigE on EMAC2/3, the TAH,
> > zerocopy, and jumbo frames.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
