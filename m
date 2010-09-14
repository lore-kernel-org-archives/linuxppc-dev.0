Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by ozlabs.org (Postfix) with ESMTP id 103F7B6EF7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 14:09:34 +1000 (EST)
Received: from mail189-tx2 (localhost.localdomain [127.0.0.1])	by
	mail189-tx2-R.bigfish.com (Postfix) with ESMTP id 603231EA817D	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 04:09:31 +0000 (UTC)
Received: from TX2EHSMHS025.bigfish.com (unknown [10.9.14.238])	by
	mail189-tx2.bigfish.com (Postfix) with ESMTP id 0B4872A2004B	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 04:09:31 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8E49TTo004728	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 21:09:29 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8E4OZb1003749	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 23:24:36 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
Date: Tue, 14 Sep 2010 12:09:20 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A1FC299@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100913112749.2fb32b3d@schlenkerla.am.freescale.net>
References: <AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com><3850A844E6A3854C827AC5C0BEC7B60A1FC150@zch01exm23.fsl.freescale.net>
	<20100913112749.2fb32b3d@schlenkerla.am.freescale.net>
From: Zang Roy-R61911 <r61911@freescale.com>
To: "Wood Scott-B07421" <B07421@freescale.com>
Cc: dedekind1@gmail.com, Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
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
> Sent: Tuesday, September 14, 2010 0:28 AM
> To: Zang Roy-R61911
> Cc: Geert Uytterhoeven; linux-mtd@lists.infradead.org; Wood =
Scott-B07421;
> dedekind1@gmail.com; Lan Chunhe-B25806; linuxppc-dev@ozlabs.org; =
akpm@linux-
> foundation.org; dwmw2@infradead.org; Gala Kumar-B11780
> Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc =
issue with
> 36bit mode
>=20
> On Mon, 13 Sep 2010 00:22:10 -0700
> "Zang Roy-R61911" <r61911@freescale.com> wrote:
>=20
> >
> >
> > > -----Original Message-----
> > > From: geert.uytterhoeven@gmail.com =
[mailto:geert.uytterhoeven@gmail.com]
> On
> > > Behalf Of Geert Uytterhoeven
> > > Sent: Thursday, September 09, 2010 19:06 PM
> > > To: Zang Roy-R61911
> > > Cc: linux-mtd@lists.infradead.org; Wood Scott-B07421; =
dedekind1@gmail.com;
> Lan
> > > Chunhe-B25806; linuxppc-dev@ozlabs.org; akpm@linux-foundation.org;
> > > dwmw2@infradead.org; Gala Kumar-B11780
> > > Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc =
issue
> with
> > > 36bit mode
> > >
> > > On Thu, Sep 9, 2010 at 12:20, Roy Zang =
<tie-fei.zang@freescale.com> wrote:
> > > > From: Lan Chunhe-B25806 <b25806@freescale.com>
> > > >
> > > > When system uses 36bit physical address, res.start is 36bit
> > > > physical address. But the function of in_be32 returns 32bit
> > > > physical address. Then both of them compared each other is
> > > > wrong. So by converting the address of res.start into
> > > > the right format fixes this issue.
> > >
> > > > =A0/**
> > > > + * fsl_lbc_addr - convert the base address
> > > > + * @addr_base: base address of the memory bank
> > > > + *
> > > > + * This function converts a base address of lbc into the right =
format
> for
> > > the BR
> > > > + * registers. If the SOC has eLBC then it returns 32bit =
physical
> address
> > > else
> > > > + * it returns 34bit physical address for local bus(Example: =
MPC8641).
> > > > + */
> > > > +unsigned int fsl_lbc_addr(phys_addr_t addr_base)
> > >     ^^^^^^^^^^^^
> > > Shouldn't this be u32 or __be32, for consistency with the actual
> > > comparisons below?
> > __be32 is better.
>=20
> I disagree, the return from this function is native-endian.  It should
> be u32.
But the return of this value is ONLY used for br comparing. It is big =
endia.
Thanks.
Roy=20
