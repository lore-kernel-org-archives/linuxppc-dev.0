Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7202E1007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 16:03:54 +1100 (EST)
Received: from mail37-tx2 (localhost.localdomain [127.0.0.1])	by
	mail37-tx2-R.bigfish.com (Postfix) with ESMTP id 0C66CA00194	for
	<linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 05:03:51 +0000 (UTC)
Received: from TX2EHSMHS027.bigfish.com (unknown [10.9.14.243])	by
	mail37-tx2.bigfish.com (Postfix) with ESMTP id 248BDEB80EF	for
	<linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 05:03:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9F53KJ4022441	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 22:03:21 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9F53J4w015142	for <linuxppc-dev@ozlabs.org>;
	Fri, 15 Oct 2010 00:03:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/3 v4] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Fri, 15 Oct 2010 13:03:14 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B049B@zch01exm23.fsl.freescale.net>
In-Reply-To: <20101014110239.466072be@udp111988uds.am.freescale.net>
References: <20100920153718.GA4411@oksana.dev.rtsoft.ru><3850A844E6A3854C827AC5C0BEC7B60A2B0329@zch01exm23.fsl.freescale.net>
	<20101014110239.466072be@udp111988uds.am.freescale.net>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Anton Vorontsov
	<cbouatmailru@gmail.com>
Cc: dedekind1@gmail.com, Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, October 15, 2010 0:03 AM
> To: Zang Roy-R61911
> Cc: Anton Vorontsov; linux-mtd@lists.infradead.org;
dwmw2@infradead.org;
> dedekind1@gmail.com; akpm@linux-foundation.org; Lan Chunhe-B25806;
Wood Scott-
> B07421; Gala Kumar-B11780; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3 v4] P4080/eLBC: Make Freescale elbc interrupt
common
> to elbc devices
>=20
> On Wed, 13 Oct 2010 23:43:38 -0700
> "Zang Roy-R61911" <r61911@freescale.com> wrote:
>=20
> > > Plus, I think the patch is not runtime bisectable (i.e. you
> > > now do request_irq() here, but not removing it from the nand
> > > driver, so nand will fail to probe).
> > Nand driver does not need to request irq. It will use the irq
requested by
> lbc.
> > remember, other lbc device may also need to use this registered irq.
> > It should not be removed in nand driver.
>=20
> The point is that you need to make both changes in the same patch.

But according to previous discussion, if lbc driver is registered
successful, it will not be removed. (.remove function is dropped in the
patch). that is not bisectable?
nand driver will not touch the irq. all irq status process is in the lbc
driver.
Thanks.
Roy
