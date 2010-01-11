Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [194.151.106.228])
	by ozlabs.org (Postfix) with ESMTP id 04EBEB6ED0
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jan 2010 21:08:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PCI-PCI bridge scanning broken on 460EX
Date: Mon, 11 Jan 2010 10:58:52 +0100
Message-ID: <4CD35CD1F8085945B597F80EEC89421303B8AD0C@exc01.bk.prodrive.nl>
In-Reply-To: <1263159117.724.15.camel@pasglop>
References: <4B388D9D.7010404@embedded-sol.com><1262584539.2173.335.camel@pasglop>
	<4B41ADF1.1000400@embedded-sol.com><4B49CE8A.7000609@embedded-sol.com>
	<1263155906.724.2.camel@pasglop><4B4A4307.5050704@embedded-sol.com>
	<1263159117.724.15.camel@pasglop>
From: "Stef van Os" <stef.van.os@Prodrive.nl>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello=20Felix,

I=20had=20a=20problem=20similar=20to=20this=20on=20the=20440GX,=20the=20P=
CI=20code=20was=20not
sending=20type=201=20transactions=20when=20scanning=20behind=20bridges.=
=20Perhaps=20you
could=20try=20this:

Index:=20linux/arch/powerpc/sysdev/ppc4xx_pci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
---=20linux/arch/powerpc/sysdev/ppc4xx_pci.c=20=20=20=20=20=20(revision=
=2026)
+++=20linux/arch/powerpc/sysdev/ppc4xx_pci.c=20=20=20=20=20=20(revision=
=2027)
@@=20-569,7=20+569,7=20@@
=20=20=20=20=20=20=20=20hose->last_busno=20=3D=20bus_range=20?=20bus_rang=
e[1]=20:=200xff;

=20=20=20=20=20=20=20=20/*=20Setup=20config=20space=20*/
-=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
0);
+=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
PPC_INDIRECT_TYPE_SET_CFG_TYPE);

=20=20=20=20=20=20=20=20/*=20Disable=20all=20windows=20*/
=20=20=20=20=20=20=20=20writel(0,=20reg=20+=20PCIX0_POM0SA);



With=20kind=20regards=20/=20Met=20vriendelijke=20groet,

Stef=20van=20Os

Prodrive=20B.V.=20


-----Original=20Message-----
From:=20linuxppc-dev-bounces+stef.van.os=3Dprodrive.nl@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+stef.van.os=3Dprodrive.nl@lists.ozlabs.org]
On=20Behalf=20Of=20Benjamin=20Herrenschmidt
Sent:=20zondag=2010=20januari=202010=2022:32
To:=20Felix=20Radensky
Cc:=20linuxppc-dev@ozlabs.org;=20Stefan=20Roese;=20Feng=20Kan
Subject:=20Re:=20PCI-PCI=20bridge=20scanning=20broken=20on=20460EX


>=20OK,=20I'll=20try=20writing=20byte=20by=20byte.=20The=20funny=20thing=
=20is=20the=20u-boot=20also=20
>=20writes=20the=20same=20value=20to=20PCI_PRIMARY_BUS=20register=20and=
=20it=20doesn't=20cause

>=20reset.

Maybe=20the=20bridge=20doesn't=20want=20to=20be=20programmed=20more=20tha=
n=20once=20on=20these
registers=20?=20In=20any=20case,=20that's=20very=20very=20fishy....=20I=
=20wonder=20if=20the
bridge=20is=20causing=20a=20PCI=20reset=20-upstream-=20(which=20would=20r=
eally=20be=20a=20weird
thing=20to=20do)=20and=20the=20460=20is=20turning=20that=20into=20a=20sys=
tem=20reset=20?=20Check=20if
there=20are=20ways=20to=20control=20how=20the=20460=20reacts=20to=20PCI=
=20resets...

In=20any=20case,=20it=20looks=20like=20a=20fucked=20up=20bridge=20to=20me=
.=20I=20don't=20suppose
you've=20seen=20anything=20in=20the=20bridge=20data=20sheet=20or=20errata=
=20sheet=20that=20could
explain=20what=20it's=20doing=20?

Cheers,
Ben.


_______________________________________________
Linuxppc-dev=20mailing=20list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

Disclaimer:=20The=20information=20contained=20in=20this=20email,=20includ=
ing=20any=20attachments=20is=20
confidential=20and=20is=20for=20the=20sole=20use=20of=20the=20intended=20=
recipient(s).=20Any=20unauthorized=20
review,=20use,=20disclosure=20or=20distribution=20is=20prohibited.=20If=
=20you=20are=20not=20the=20intended=20
recipient,=20please=20notify=20the=20sender=20immediately=20by=20replying=
=20to=20this=20message=20and=20
destroy=20all=20copies=20of=20this=20message=20and=20any=20attachments.
