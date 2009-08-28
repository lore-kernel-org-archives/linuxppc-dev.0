Return-Path: <Mingkai.Hu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7ED47B7BFB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 21:03:13 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2574BDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 21:03:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7SB2pxR009307
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 04:02:51 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n7SB48Hb019188
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 06:04:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Date: Fri, 28 Aug 2009 19:02:51 +0800
Message-ID: <73839B4A0818E747864426270AC332C304438438@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20090819015101.GA10782@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru><20090807195822.GG2735@oksana.dev.rtsoft.ru><A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org><20090818233818.GA29042@oksana.dev.rtsoft.ru><F58A75CD-73CC-4F75-AF51-2BCC0B828E84@kernel.crashing.org>
	<20090819015101.GA10782@oksana.dev.rtsoft.ru>
From: "Hu Mingkai-B21284" <Mingkai.Hu@freescale.com>
To: <avorontsov@ru.mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+b21284=3Dfreescale.com@lists.ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b21284=3Dfreescale.com@lists.ozlabs
> .org] On Behalf Of Anton Vorontsov
> Sent: Wednesday, August 19, 2009 9:51 AM
> To: Kumar Gala
> Cc: Ben Dooks; linux-kernel@vger.kernel.org;=20
> sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org; Andrew=20
> Morton; Pierre Ossman; David Vrabel
> Subject: Re: [PATCH v2] powerpc/85xx: Add eSDHC support for=20
> MPC8536DS boards
>=20
> On Tue, Aug 18, 2009 at 08:24:17PM -0500, Kumar Gala wrote:
> >=20
> > On Aug 18, 2009, at 6:38 PM, Anton Vorontsov wrote:
> >=20
> > >This patch simply adds sdhci node to the device tree.
> > >
> > >We specify clock-frequency manually, so that eSDHC will=20
> work without=20
> > >upgrading U-Boot. Though, that'll only work for default setup (1500
> > >MHz) on new board revisions. For non-default setups, it's=20
> recommended=20
> > >to upgrade U-Boot, since it will fixup clock-frequency=20
> automatically.
> > >
> > >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >=20
> > out of interest the 85xx eSDHC don't need the sdhci,wp-inverted=20
> > property?
>=20
> Yes, eSDHC controllers in MPC85xx report normal state in its=20
> registers.
>=20

Hi Anton,

The eSDHC controller in different silicon version on MPC8536  reports
different WP state in the register PRSSTAT:

Silicon 1.0:

Card WP pos    PRSSTAT[WPSPL]    RMMCR[SDHC_WP]    GENCFG[SDHC_WP_INV]
------------------------------------------------------------------------
---------------------------------------------
unLock               1                                   1
/
Lock                    0                                   1
/

Silicon 1.1:

Card WP pos    PRSSTAT[WPSPL]    RMMCR[SDHC_WP]    GENCFG[SDHC_WP_INV]
------------------------------------------------------------------------
---------------------------------------------
unLock               0                                   1
0
Lock                    1                                   1
0

Note: the register GENCFG is added on silicon 1.1 to invert the WP
state.

For silicon 1.0,  the macro SDHCI_QUIRK_INVERTED_WRITE_PROTECT is also
defined,
so the dirver will report the error WP state in function sdhci_get_ro.

Best regards,
Mingkai
