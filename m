Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0086.outbound.protection.outlook.com [104.47.38.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2zlX4c96zDsPr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:54:31 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: [EXTERNAL]Re: FSL serial 166550 errata broken?
Date: Thu, 28 Sep 2017 15:54:22 +0000
Message-ID: <1506614061.21929.1.camel@infinera.com>
References: <1506358524.29657.31.camel@infinera.com>
 <VI1PR04MB207821E9B5E0FE0BB629E1FA9A7A0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <1506510185.2325.4.camel@infinera.com>
 <VI1PR04MB2078E07ED3BCF8C6001FA72E9A780@VI1PR04MB2078.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB2078E07ED3BCF8C6001FA72E9A780@VI1PR04MB2078.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-27 at 15:32 +0000, York Sun wrote:
> On 09/27/2017 04:03 AM, Joakim Tjernlund wrote:
> > On Mon, 2017-09-25 at 17:26 +0000, York Sun wrote:
> > > On 09/25/2017 09:55 AM, Joakim Tjernlund wrote:
> > > > We got some "broken" boards(mpx8321) where UART RX is held low(BREA=
K)
> > > > There we get a few:
> > > >     serial8250: too much work for irq18
> > > > and the board freezes.
> > > >=20
> > > > Looking inte to driver/CPU there is an errtum(A-004737) w.r.t BREAK=
 handling
> > > > and I can see we are hitting the irq function fsl8250_handle_irq() =
added
> > > > in commit: 9deaa53ac7fa373623123aa4f18828dd62292b1a
> > > >    "serial: add irq handler for Freescale 16550 errata."
> > > > For all I can tell this workaround is broken and I cannot figure ou=
t why.
> > > > Any pointers?
> > > >=20
> > >=20
> > > Jocke,
> > >=20
> > > Did you mean MPC8321?
> > >=20
> > > I personally don't have experience debugging this erratum. Have you
> > > tried to contact the patch author Paul Gortmaker to see how he manage=
d
> > > to get it work?
> >=20
> > No, but I just found out it is u-boot related. If I use an very old u-b=
oot it works.
> > Between then and now we did a massive upgrade of u-boot and now if brea=
ks. And no,
> > bisect not possible due to local u-boot mods :)
>=20
> How old? It is a good sign that an old U-Boot works. Git bisect would be=
=20
> a good tool if practical. Sometimes I have to reapply some local changes=
=20
> for every step of bisect to make it useful. You mileage may vary though.
>=20
> >=20
> > Any idea what could be different? I cannot see and I have tested
> > what I could see/think of but now I am out of ideas.
>=20
> I don't believe we have much change for MPC8321 for a long time. If any=20
> change has impact on kernel but not U-Boot itself, it may be other=20
> errata workarounds.
>=20
> I presume this happens on your own board. If I am in your shoes, I would=
=20
> try to reduce the number of local commits and reapply them to various=20
> U-Boot tags to further narrow down the search scope. In the mean time,=20
> getting register dump to compare the good and bad may be another way to g=
o.

God, this was no fun exercise but I think I found the offending commit: 82d=
da962f0a6449672df3378bb6b5fe54372a927
    serial: Unconditionally enable CONFIG_SERIAL_MULTI
   =20
    Enable CONFIG_SERIAL_MULTI for all builds of U-Boot. That includes
    both SPL builds and non-SPL builds, everything. To avoid poluting
    this patch with removal of ifdef-endif constructions containing
    CONFIG_SERIAL_MULTI, the CONFIG_SERIAL_MULTI is temporarily added
    into CPPFLAGS in config.mk . This will be again removed in following
    patch.
