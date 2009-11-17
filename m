Return-Path: <B08308@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 808EAB7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 17:59:19 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAH6xFFw002045
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 23:59:16 -0700 (MST)
Received: from zin33exm23.fsl.freescale.net (zin33exm23.ap.freescale.net
	[10.232.192.22])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAH6xF8P016360
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:59:16 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/1] ata/sata_sil24: MSI support, disabled by default
Date: Tue, 17 Nov 2009 12:29:25 +0530
Message-ID: <F2F605B667B24B489C904986E0D60A08012220A2@zin33exm23.fsl.freescale.net>
In-Reply-To: <da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
References: <1258352362-11231-1-git-send-email-vivek.mahajan@freescale.com>
	<da824cf30911160937l38651a44sc25a3315efd24aea@mail.gmail.com>
From: "Mahajan Vivek-B08308" <B08308@freescale.com>
To: "Grant Grundler" <grundler@google.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Grant Grundler [mailto:grundler@google.com]=20
> Sent: Monday, November 16, 2009 11:08 PM
> > +static int sata_sil24_msi; =A0 =A0/* Disable MSI */=20
> > +module_param_named(msi, sata_sil24_msi, bool, S_IRUGO);=20
> > +MODULE_PARM_DESC(msi, "Enable MSI (Default: false)");
>=20
> Vivek,
> Do we even still need the parameter? I'm thinking either MSI=20
> works with a chipset or it doesn't. The kernel has globals to=20
> "know" which state is true.

Sometimes even in a platform, some PCIe endpoints do very=20
well with MSI while others may have to resort to legacy ints.=20
Should we let the endpoints make the final call.

>=20
> If the parameter is needed, when this driver is compiled into=20
> the kernel, how is "msi" parameter specified?
> I think the parameter needs to be documented and fit in with=20
> other "msi" parameters.
> See "nomsi" in Documentation/kernel-parameters.txt.

In this case "msi" is supposed to be passed via insmod and=20
not via kernel cmdline. If the driver is built-in the kernel,=20
then force sata_sil24_msi =3D 1 in the driver to enable it.

>=20
> If you want to keep this module parameter, can I suggest=20
> calling the exported parameter "sata_sil24_msi"?
>=20

Will do it in the subsequent patch.

> pci_intx() isn't documented in MSI-HOWTO.txt  - because it's=20
> already called:
>     pci_msi_enable() -> pci_msi_enable_block() ->=20
> msi_capability_init()
>        -> pci_intx_for_msi(dev, 0) -> pci_intx(pdev, 0);
>=20
> (thanks to willy (Mathew Wilcox) for pointing me at
> msi_capability_init() - I overlooked it)
>=20
> Please add "Reviewed-by: Grant Grundler=20
> <grundler@google.com>" once the variable name is changed and=20
> the pci_intx() call is removed.

Will take care in the upcoming patch

>=20
> cheers,
> grant

Thanks,
Vivek
=20
