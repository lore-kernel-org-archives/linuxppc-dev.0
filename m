Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C12EDE104
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Mar 2008 13:54:24 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m2S2sJMr016994 for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 19:54:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2S2sGDp003402
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 21:54:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ucc_geth: Add 8 bytes to max TX frame for VLANs
Date: Fri, 28 Mar 2008 10:54:16 +0800
Message-ID: <989B956029373F45A0B8AF029708189001D19A3F@zch01exm26.fsl.freescale.net>
In-Reply-To: <1206621833.7589.286.camel@gentoo-jocke.transmode.se>
References: <>
	<1205853088-30171-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<989B956029373F45A0B8AF029708189001D19565@zch01exm26.fsl.freescale.net>
	<46CAC1281D7CB94A9AEFFB131F9569CA227627@tmnt04.transmode.se>
	<1206436671.7589.208.camel@gentoo-jocke.transmode.se>
	<989B956029373F45A0B8AF029708189001D198BC@zch01exm26.fsl.freescale.net>
	<1206621833.7589.286.camel@gentoo-jocke.transmode.se>
From: "Li Yang" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: Netdev <netdev@vger.kernel.org>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Hi Jocke,
> >=20
> > QUICC engine supports dynamic maximum frame length.  If you are not=20
> > expecting to receive only tagged frames, I recommend to use this=20
> > feature by setting dynamicMaxFrameLength and=20
> dynamicMinFrameLength in=20
> > ug_info instead of increasing the MaxLength for both tagged=20
> and untagged frames.
> > See the following part from the reference manual.
> >=20
> > The MFLR entry in the Global Parameter RAM defines the=20
> length of the=20
> > largest frame, excluding Q TAG but including FCS, that is=20
> still valid.=20
> > When REMODER[DXE]=3D1, a tagged frame that has length equals
> > MaxLength+4 considered valid, and a non tagged frame that has length
> > equals MaxLength is the longest
> > that is still considered valid. When REMODER[DXE]=3D0, any=20
> frame longer=20
> > than MaxLength consider erroneous frame.
> > For systems with only tagged frames, set REMODER[DXE]=3D0 and set=20
> > MaxLength =3D Max LLC size+4.
> >=20
> > - Leo
>=20
> Interesting, that should also work although QinQ will not. I=20
> will have a closer look but I still don't see how my orginal=20
> patch would harm anything. One could add my patch on top but=20
> with only 4 bytes extra.

Hi,

The increase of max packet length may cause a waste of QE internal
buffer for every packet.  Furthermore it affects the hardware statistics
of jumbo packets.

- Leo
