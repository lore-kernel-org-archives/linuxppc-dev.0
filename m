Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B54E2DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2009 08:32:18 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1KLWDLZ029175
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 14:32:14 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n1KLWBJs011453
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 15:32:11 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Gianfar tx-babbling-errors
Date: Fri, 20 Feb 2009 14:32:00 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD3302B1EB2E@az33exm24.fsl.freescale.net>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C0774E@CYBORG3.cyclone.com>
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<18AEF66AFDF06F4CAAA1D419D000FD3302B1EAB1@az33exm24.fsl.freescale.net>
	<43EB80E07C42E1408726E4905FB96B04C0774E@CYBORG3.cyclone.com>
From: "Haruki Dai-R35557" <Dai.Haruki@freescale.com>
To: "Scott Coulter" <scott.coulter@cyclone.com>, <linuxppc-dev@ozlabs.org>
Cc: Gala Kumar-B11780 <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott,
 I am not so sure about your PHY, but if you access to PHY while packet
transmission through MDIO bus, the packet might be corrupted. Do you
have "phy_interrupt" in the /proc/interrupts? What is your dmesg around
the eTSEC look like (there is phy driver info surrounded).

Regards
Dai



> -----Original Message-----
> From: Scott Coulter [mailto:scott.coulter@cyclone.com]
> Sent: Friday, February 20, 2009 3:00 PM
> To: Haruki Dai-R35557; linuxppc-dev@ozlabs.org
> Cc: Gala Kumar-B11780
> Subject: RE: Gianfar tx-babbling-errors
>=20
>=20
>=20
>=20
> Dai,
>=20
> >  Is this your own board? If so, what PHY chip are you using? Are you
> > using the PHY driver?
> >  If the generic PHY driver is used and polling the MDIO periodically
> for
> > the link check, you may truncate the packet. I hope this is not the
> > case.
>=20
> Yes this is our own board.  Both the 8568E and 8572E processors each
> expose two TSECs.  The 4 TSECs are each connected to a separate
> interface of a  Broadcom 5464 Quad PHY in RGMII mode.  I am pretty
sure
> that there is no interrupt connected (I'll have to check with the
> hardware engineer) and I know that I didn't configure one in the DTS
> file.  My kernel is configured to use the Broadcomm 54xx driver, but
I'm
> not sure if it polls when no interrupt is configured.
>=20
> Thanks,
> Scott
> ___________________________________________________________________
>=20
>   Scott N. Coulter
>   Senior Software Engineer
>=20
>   Cyclone Microsystems
>   370 James Street              Phone:  203.786.5536 ext. 118
>   New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
>   U.S.A.                        Web:    http://www.cyclone.com
> ___________________________________________________________________
>=20
> > -----Original Message-----
> > From: Haruki Dai-R35557 [mailto:Dai.Haruki@freescale.com]
> > Sent: February 20, 2009 2:16PM
> > To: Scott Coulter; linuxppc-dev@ozlabs.org
> > Cc: Gala Kumar-B11780
> > Subject: RE: Gianfar tx-babbling-errors
> >
> > Hi Scott,
> >
> >
> > Regards
> > Dai
> >
> > > -----Original Message-----
> > > From: linuxppc-dev-bounces+dai.haruki=3Dfreescale.com@ozlabs.org
> > > =
[mailto:linuxppc-dev-bounces+dai.haruki=3Dfreescale.com@ozlabs.org]
On
> > Behalf Of
> > > Scott Coulter
> > > Sent: Wednesday, February 18, 2009 10:16 AM
> > > To: linuxppc-dev@ozlabs.org
> > > Subject: Gianfar tx-babbling-errors
> > >
> > >
> > > Hi all,
> > >
> > > As a simple stress test for my board with an MPC8572E and an
> MPC8568E
> > on
> > > it, I setup both processors to boot linux 2.6.27.6 with an NFS
root
> > and
> > > then perform repeated native compiles of a linux kernel over NFS.
> > After
> > > running for 4 days straight or so with between 250-300 build
cycles
> > per
> > > processor, I stopped the builds and ran ethtool to look for any
odd
> > > statistics.  Both processors reported non-zero values for
> > > tx-babbling-errors.  Both processors reported around 1300
> > > tx-babbling-errors out of about 80,000,000 Tx packets.  Should I
be
> > > concerned about the tx-babbling-errors?  What conditions would
cause
> > > these errors to be reported?
> > >
> > > Thanks,
> > > Scott
> > >
> > >
> > >
> > >
> > >
> > >
___________________________________________________________________
> > >
> > >   Scott N. Coulter
> > >   Senior Software Engineer
> > >
> > >   Cyclone Microsystems
> > >   370 James Street              Phone:  203.786.5536 ext. 118
> > >   New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
> > >   U.S.A.                        Web:    http://www.cyclone.com
> > >
___________________________________________________________________
> > >
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
