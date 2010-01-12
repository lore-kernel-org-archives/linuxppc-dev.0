Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [194.151.106.228])
	by ozlabs.org (Postfix) with ESMTP id 0AA4D1007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 01:20:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] powerpc/4xx: Add support for type 1 pci transactions on 4xx
	boards
Date: Tue, 12 Jan 2010 15:09:26 +0100
Message-ID: <4CD35CD1F8085945B597F80EEC89421303B8AD11@exc01.bk.prodrive.nl>
From: "Stef van Os" <stef.van.os@Prodrive.nl>
To: "Felix Radensky" <felix@embedded-sol.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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

This=20patch=20adds=20type=201=20PCI=20transactions=20to=204xx=20PCI=20co=
de,=20enabling=20the
discovery=20of
devices=20behind=20a=20PCI=20bridge.

Signed-off-by:=20Stef=20van=20Os=20<stef.van.os@gmail.com>
---
=20arch/powerpc/sysdev/ppc4xx_pci.c=20|=20=20=20=206=20++++--
=201=20files=20changed,=204=20insertions(+),=202=20deletions(-)

diff=20--git=20a/arch/powerpc/sysdev/ppc4xx_pci.c
b/arch/powerpc/sysdev/ppc4xx_pci.c
index=206ff9d71..370cc1c=20100644
---=20a/arch/powerpc/sysdev/ppc4xx_pci.c
+++=20b/arch/powerpc/sysdev/ppc4xx_pci.c
@@=20-363,7=20+363,8=20@@=20static=20void=20__init=20ppc4xx_probe_pci_bri=
dge(struct
device_node=20*np)
=20=20=20=20=20=20=20=20hose->last_busno=20=3D=20bus_range=20?=20bus_rang=
e[1]=20:=200xff;

=20=20=20=20=20=20=20=20/*=20Setup=20config=20space=20*/
-=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
0);
+=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20PPC_INDIRECT_TYPE_SET_CFG_TY=
PE);

=20=20=20=20=20=20=20=20/*=20Disable=20all=20windows=20*/
=20=20=20=20=20=20=20=20writel(0,=20reg=20+=20PCIL0_PMM0MA);
@@=20-569,7=20+570,8=20@@=20static=20void=20__init=20ppc4xx_probe_pcix_br=
idge(struct
device_node=20*np)
=20=20=20=20=20=20=20=20hose->last_busno=20=3D=20bus_range=20?=20bus_rang=
e[1]=20:=200xff;

=20=20=20=20=20=20=20=20/*=20Setup=20config=20space=20*/
-=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
0);
+=20=20=20=20=20=20=20setup_indirect_pci(hose,=20rsrc_cfg.start,=20rsrc_c=
fg.start=20+=200x4,
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20PPC_INDIRECT_TYPE_SET_CFG_TY=
PE);

=20=20=20=20=20=20=20=20/*=20Disable=20all=20windows=20*/
=20=20=20=20=20=20=20=20writel(0,=20reg=20+=20PCIX0_POM0SA);


Disclaimer:=20The=20information=20contained=20in=20this=20email,=20includ=
ing=20any=20attachments=20is=20
confidential=20and=20is=20for=20the=20sole=20use=20of=20the=20intended=20=
recipient(s).=20Any=20unauthorized=20
review,=20use,=20disclosure=20or=20distribution=20is=20prohibited.=20If=
=20you=20are=20not=20the=20intended=20
recipient,=20please=20notify=20the=20sender=20immediately=20by=20replying=
=20to=20this=20message=20and=20
destroy=20all=20copies=20of=20this=20message=20and=20any=20attachments.
