Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9FE6DE259
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 19:18:32 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n058ISp1007346
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 01:18:29 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n058IRCd021514
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 02:18:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 3/4] powerpc/fsl_pci: Add MPC83xx PCI-E controller
	RCmode support
Date: Mon, 5 Jan 2009 16:18:26 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208904074B@zch01exm21.fsl.freescale.net>
In-Reply-To: <20081229210559.GA10801@oksana.dev.rtsoft.ru>
References: <20081229164038.GC8215@oksana.dev.rtsoft.ru><DE5232AE-281E-4A6E-9844-A69DF7C90034@kernel.crashing.org>
	<20081229210559.GA10801@oksana.dev.rtsoft.ru>
From: "Liu Dave" <DaveLiu@freescale.com>
To: <avorontsov@ru.mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Huang Changming-R66093 <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
> +				    unsigned int devfn, int offset)
> +{
> +	struct pci_controller *hose =3D bus->sysdata;
> +	struct mpc83xx_pcie *pcie =3D hose->dn->data;
> +	u8 bus_no =3D bus->number - hose->first_busno;
> +	u32 dev_base =3D bus_no << 20 | devfn << 12;

Hello Anton,

There is one bug for the bus/device number shift according to the latest
83xx UM. The shift should be

dev_base =3D (bus_no << 24) | (devfn << 16);

You can download the latest MPC8315 UM as reference from
http://www.freescale.com.

AFAIK, you will work on the u-boot for 83xx PEX, Any question forward
to Jerry Huang (in cc). I think he should have some update for PEX.

Thanks,
Dave
