Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0DA6B70A6
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 13:28:32 +1100 (EST)
Received: from mail44-db3 (localhost.localdomain [127.0.0.1])	by
	mail44-db3-R.bigfish.com (Postfix) with ESMTP id 8D2091BA8155	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:13:19 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.240])	by
	mail44-db3.bigfish.com (Postfix) with ESMTP id 26C121840051	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 02:13:19 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o982D1Nm013087	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 19:13:01 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o982D0QZ004737	for <linuxppc-dev@ozlabs.org>;
	Thu, 7 Oct 2010 21:13:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Fri, 8 Oct 2010 10:13:08 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F6134@zmy16exm20.fsl.freescale.net>
In-Reply-To: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: David Brownell <david-b@pacbell.net>, <linuxppc-dev@ozlabs.org>,
	<spi-devel-general@lists.sourceforge.net>, <linux-mtd@lists.infradead.org>
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
	Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Thursday, September 30, 2010 6:46 PM
> To: linuxppc-dev@ozlabs.org; spi-devel-general@lists.sourceforge.net; =
linux-
> mtd@lists.infradead.org; Hu Mingkai-B21284
> Cc: Gala Kumar-B11780; Zang Roy-R61911; Hu Mingkai-B21284
> Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read =
page by
> page
>=20
>=20
> --- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:
>=20
> > From: Mingkai Hu <Mingkai.hu@freescale.com>
> > Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read =
page
> > by page
>=20
> NAK.
>=20
> We went over this before.
>=20
> =A0 The bug is in your SPI master controller driver, and the fix there =
involves
> mapping large reads  into multiple smaller reads.=A0 (Example, 128K =
read as two
> 64K reads instead of one of 128K.
>=20
> It's *NEVER* appropriate to commit to patching all upper level drivers =
in order
> to work around bugs in lower level ones.=A0 The set of such upper =
level drivers
> that may need bugfixing is quite large, most will never be used with =
your buggy
> controller driver, and all such patches will need testing (but the =
test
> resources are probably not available).
>=20
> Whatever SPI controller driver you're working with is clearly buggy =
... but not
> unfixably so.
>=20
> DO NOT head down the path of requiring every SPI device driver to =
include
> workarounds for this odd little SPI master driver bug.
>=20
> - Dave
>=20

Thanks for your comments, the controller driver is the proper place to =
handle this, I'll fix it.

Thanks,
Mingkai
