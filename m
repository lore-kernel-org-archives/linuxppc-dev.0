Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 5EA6FB70A6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2010 02:28:32 +1000 (EST)
Received: from mail13-tx2 (localhost.localdomain [127.0.0.1])	by
	mail13-tx2-R.bigfish.com (Postfix) with ESMTP id 10F0D18E06FF	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 16:28:29 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.249])	by
	mail13-tx2.bigfish.com (Postfix) with ESMTP id 553E2170805E	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 16:28:16 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8DGRpFx015406	for
	<linuxppc-dev@ozlabs.org>; Mon, 13 Sep 2010 09:28:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8DGgwcT025915	for <linuxppc-dev@ozlabs.org>;
	Mon, 13 Sep 2010 11:42:59 -0500 (CDT)
Date: Mon, 13 Sep 2010 11:27:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Zang Roy-R61911" <r61911@freescale.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
Message-ID: <20100913112749.2fb32b3d@schlenkerla.am.freescale.net>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A1FC150@zch01exm23.fsl.freescale.net>
References: <AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com>
	<3850A844E6A3854C827AC5C0BEC7B60A1FC150@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
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

On Mon, 13 Sep 2010 00:22:10 -0700
"Zang Roy-R61911" <r61911@freescale.com> wrote:

>=20
>=20
> > -----Original Message-----
> > From: geert.uytterhoeven@gmail.com [mailto:geert.uytterhoeven@gmail.com=
] On
> > Behalf Of Geert Uytterhoeven
> > Sent: Thursday, September 09, 2010 19:06 PM
> > To: Zang Roy-R61911
> > Cc: linux-mtd@lists.infradead.org; Wood Scott-B07421; dedekind1@gmail.c=
om; Lan
> > Chunhe-B25806; linuxppc-dev@ozlabs.org; akpm@linux-foundation.org;
> > dwmw2@infradead.org; Gala Kumar-B11780
> > Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue=
 with
> > 36bit mode
> >=20
> > On Thu, Sep 9, 2010 at 12:20, Roy Zang <tie-fei.zang@freescale.com> wro=
te:
> > > From: Lan Chunhe-B25806 <b25806@freescale.com>
> > >
> > > When system uses 36bit physical address, res.start is 36bit
> > > physical address. But the function of in_be32 returns 32bit
> > > physical address. Then both of them compared each other is
> > > wrong. So by converting the address of res.start into
> > > the right format fixes this issue.
> >=20
> > > =A0/**
> > > + * fsl_lbc_addr - convert the base address
> > > + * @addr_base: base address of the memory bank
> > > + *
> > > + * This function converts a base address of lbc into the right forma=
t for
> > the BR
> > > + * registers. If the SOC has eLBC then it returns 32bit physical add=
ress
> > else
> > > + * it returns 34bit physical address for local bus(Example: MPC8641).
> > > + */
> > > +unsigned int fsl_lbc_addr(phys_addr_t addr_base)
> >     ^^^^^^^^^^^^
> > Shouldn't this be u32 or __be32, for consistency with the actual
> > comparisons below?
> __be32 is better.

I disagree, the return from this function is native-endian.  It should
be u32.

-Scott
