Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (stargate.chelsio.com [12.22.49.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A8F9DDF34
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 05:17:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ioremap fails for a device in PCI-E slot on AMCC katmai board
Date: Mon, 23 Feb 2009 10:17:58 -0800
Message-ID: <8A71B368A89016469F72CD08050AD33402D57563@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Great...That works!!!

Thank you so much.
Shubhada

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Friday, February 20, 2009 8:38 PM
To: Shubhada Pugaonkar
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ioremap fails for a device in PCI-E slot on AMCC katmai
board

On Fri, 2009-02-20 at 17:35 -0800, Shubhada Pugaonkar wrote:

> ****************************************************
>=20
> cxgb3_main.c:
>=20
>         mmio_start =3D pci_resource_start(pdev, 0);
>=20
>         mmio_len =3D pci_resource_len(pdev, 0);
>=20
>         ai =3D t3_get_adapter_info(ent->driver_data);
>=20

My bet is that mmio_start is an unsigned long instead of a
resource_size_t and thus gets cropped (ie, driver bug).

 (/me goes read the source)

Yes, indeed, that's the problem. Change the definition
of mmio_start and mmio_len to resource_size_t, that should
fix it. I suspect the other driver has the same problem.

Note: They will still get cropped, I suspect, when copied
to netdev->mem_start, nothing much to do here, but fortunately
those fields aren't used.

BTW. If you do patches to fix those drivers, please send them
to the netdev@vger.kernel.org mailing list too.

Cheers,
Ben.
