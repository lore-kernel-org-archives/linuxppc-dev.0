Return-Path: <Mingkai.Hu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 71B4FB70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 17:52:01 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3C01DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 17:51:57 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7V7pbDO010515
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 00:51:48 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n7V7qxAN009650
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 02:53:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Date: Mon, 31 Aug 2009 15:51:29 +0800
Message-ID: <73839B4A0818E747864426270AC332C304438600@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20090828151953.GA14776@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
	<20090807195822.GG2735@oksana.dev.rtsoft.ru>
	<A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
	<20090818233818.GA29042@oksana.dev.rtsoft.ru>
	<F58A75CD-73CC-4F75-AF51-2BCC0B828E84@kernel.crashing.org>
	<20090819015101.GA10782@oksana.dev.rtsoft.ru>
	<73839B4A0818E747864426270AC332C304438438@zmy16exm20.fsl.freescale.net>
	<20090828151953.GA14776@oksana.dev.rtsoft.ru>
From: "Hu Mingkai-B21284" <Mingkai.Hu@freescale.com>
To: <avorontsov@ru.mvista.com>
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
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: Friday, August 28, 2009 11:20 PM
> To: Hu Mingkai-B21284
> Cc: Kumar Gala; Ben Dooks; linux-kernel@vger.kernel.org;=20
> sdhci-devel@lists.ossman.eu; linuxppc-dev@ozlabs.org; Andrew=20
> Morton; Pierre Ossman; David Vrabel
> Subject: Re: [PATCH v2] powerpc/85xx: Add eSDHC support for=20
> MPC8536DS boards
>=20
> On Fri, Aug 28, 2009 at 07:02:51PM +0800, Hu Mingkai-B21284 wrote:
> > > On Tue, Aug 18, 2009 at 08:24:17PM -0500, Kumar Gala wrote:
> > > >=20
> > > > On Aug 18, 2009, at 6:38 PM, Anton Vorontsov wrote:
> > > >=20
> > > > >This patch simply adds sdhci node to the device tree.
> > > > >
> > > > >We specify clock-frequency manually, so that eSDHC will
> > > work without
> > > > >upgrading U-Boot. Though, that'll only work for default setup=20
> > > > >(1500
> > > > >MHz) on new board revisions. For non-default setups, it's
> > > recommended
> > > > >to upgrade U-Boot, since it will fixup clock-frequency
> > > automatically.
> > > > >
> > > > >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > >=20
> > > > out of interest the 85xx eSDHC don't need the sdhci,wp-inverted=20
> > > > property?
> > >=20
> > > Yes, eSDHC controllers in MPC85xx report normal state in its=20
> > > registers.
> > >=20
> >=20
> > Hi Anton,
> >=20
> > The eSDHC controller in different silicon version on=20
> MPC8536  reports=20
> > different WP state in the register PRSSTAT:
>=20
> Thanks a million for the heads up!
>=20
> Yes, the manual I used ("MPC8536ERM Rev. 0 10/2008") doesn't=20
> mention that, but the newer manual that I just downloaded=20
> ("MPC8536ERM Rev. 1
> 05/2009") does.
>=20
> [...]
> > For silicon 1.0,  the macro=20
> SDHCI_QUIRK_INVERTED_WRITE_PROTECT is also=20
> > defined, so the dirver will report the error WP state in function=20
> > sdhci_get_ro.
>=20
> Not any longer. We don't actually define it for any 85xx CPUs.
>=20
> I need to think how should we handle all these WP inversions. :-)
>=20
> So, we have inversion in BCSR (depending on the BCSR=20
> revision), configurable inversion in CPU via GENCFGR for 1.1=20
> silicon, and non-configurable non-inverted reporting for 1.0=20
> silicon...
>=20
> Do you know if there are any plans to fix the WP inversion=20
> for MPC8569E-MDS boards, or make something like GENCFGR for=20
> MPC8569 CPUs?
>=20
> Thanks,
>=20

Sorry, I also don't know the plan to MPC8569 CPU, but if I get any info,
I'll inform you ASAP. :-)

Best regards,
Mingkai

> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>=20
>=20
