From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Thomas Lange" <thomas@corelatus.com>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Potential problem in fec.c for 8xx
Date: Fri, 20 Sep 2002 16:13:35 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJKECBCJAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3D8B1950.CE2DB9A1@corelatus.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Thomas,

normaly this shouldn't happen. By default the interrupts of the PHY chips
are disabled (see PHY register settings). So when you enable the 8xx
interrupt nothing should happen.
So FEC driver has the time to detect the PHY and setup the registers. After
the registers are initializes (esp. interrupt mask) the first interrupts may
appeare.

Maybe there is the following problem: The PHY CHIP doesn't get a reset
signal when rebooting your board (warm start). In that case I could imagine
that the interrupts are still enabled in the PHY chip.... (Do you have the
same problem after a cold start?)

Regards, Stephan

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Thomas
> Lange
> Sent: Freitag, 20. September 2002 14:49
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Potential problem in fec.c for 8xx
>
>
>
> When using MII, the interrupt for link status changes
> is enabled before the PHY type has been detected.
>
> If a link status change happens before PHY is detected,
> you will get kernel panic in mii_link_interrupt
> because the MII functions are undefined.
>
> The correct way to do this would be to move the
> enabling of MII interrupts from fec_enet_init
> to mii_discover_phy3.
>
> I can prepare a patch if someone points me to
> the correct version to patch.
>
> /Thomas
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
