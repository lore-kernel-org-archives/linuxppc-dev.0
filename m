Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "andrew may" <acmay@acmay.homeip.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: "Armin" <akuster@pacbell.net>
Subject: Re: PPC405gp enet Soft Reset
Date: Fri, 8 Feb 2002 11:03:59 +0100
Message-ID: <EFEAIMDCOOOHIEPHDNFJOEJBDKAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020207191741.A26185@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew

> I seem to be having a problem with the soft reset of EMAC
> mode register when I have no ethernet connection to by phy.

We have the same problem (CPCI-405 with Intel LXT971 PHY).

> After this code in init_ppc405_enet(void) the SRST bit does
> not clear until after I stick in a cable.

See Chapter 19.7.1 in PPC405GP User Manual (EMAC0_MR0):

"Both PHY clocks, PHYTxClk and PHYRxClk, must be active prior to requesting
a soft reset through EMAC0_MR0[SRST]. If the PHY clocks are inactive, the
soft reset never completes, even if the clocks subsequently become
active..."

It seems that we can't reset and setup the EMAC correctly without cable
connected (no cable == no PHY clock!). So what do we do when this occurs?
Disable the driver?

Stefan Roese.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
