Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0058.outbound.protection.outlook.com [104.47.41.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2FKv3YzjzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 21:03:13 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "leoyang.li@nxp.com" <leoyang.li@nxp.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: FSL serial 166550 errata broken?
Date: Wed, 27 Sep 2017 11:03:06 +0000
Message-ID: <1506510185.2325.4.camel@infinera.com>
References: <1506358524.29657.31.camel@infinera.com>
 <VI1PR04MB207821E9B5E0FE0BB629E1FA9A7A0@VI1PR04MB2078.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB207821E9B5E0FE0BB629E1FA9A7A0@VI1PR04MB2078.eurprd04.prod.outlook.com>
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

On Mon, 2017-09-25 at 17:26 +0000, York Sun wrote:
> On 09/25/2017 09:55 AM, Joakim Tjernlund wrote:
> > We got some "broken" boards(mpx8321) where UART RX is held low(BREAK)
> > There we get a few:
> >    serial8250: too much work for irq18
> > and the board freezes.
> >=20
> > Looking inte to driver/CPU there is an errtum(A-004737) w.r.t BREAK han=
dling
> > and I can see we are hitting the irq function fsl8250_handle_irq() adde=
d
> > in commit: 9deaa53ac7fa373623123aa4f18828dd62292b1a
> >   "serial: add irq handler for Freescale 16550 errata."
> > For all I can tell this workaround is broken and I cannot figure out wh=
y.
> > Any pointers?
> >=20
>=20
> Jocke,
>=20
> Did you mean MPC8321?
>=20
> I personally don't have experience debugging this erratum. Have you=20
> tried to contact the patch author Paul Gortmaker to see how he managed=20
> to get it work?

No, but I just found out it is u-boot related. If I use an very old u-boot =
it works.
Between then and now we did a massive upgrade of u-boot and now if breaks. =
And no,
bisect not possible due to local u-boot mods :)

Any idea what could be different? I cannot see and I have tested
what I could see/think of but now I am out of ideas.

 Jocke
