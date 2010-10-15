Return-Path: <R61911@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 042AC1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 13:15:24 +1100 (EST)
Received: from mail7-db3 (localhost.localdomain [127.0.0.1])	by
	mail7-db3-R.bigfish.com (Postfix) with ESMTP id 6CC391508CE	for
	<linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 02:15:19 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.247])	by
	mail7-db3.bigfish.com (Postfix) with ESMTP id 173B01200046	for
	<linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 02:15:19 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9F2F6ag014599	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 19:15:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9F2VMpL000682	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 21:31:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Fri, 15 Oct 2010 10:15:20 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B0445@zch01exm23.fsl.freescale.net>
In-Reply-To: <20101014110118.11fabed5@udp111988uds.am.freescale.net>
References: <20101004103813.14d04956@udp111988uds.am.freescale.net><3850A844E6A3854C827AC5C0BEC7B60A2B02B7@zch01exm23.fsl.freescale.net>
	<20101014110118.11fabed5@udp111988uds.am.freescale.net>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: dedekind1@gmail.com, Hu Mingkai-B21284 <B21284@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
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
> Sent: Friday, October 15, 2010 0:01 AM
> To: Zang Roy-R61911
> Cc: Wood Scott-B07421; Anton Vorontsov; linux-mtd@lists.infradead.org;
> dwmw2@infradead.org; dedekind1@gmail.com; akpm@linux-foundation.org;
Lan
> Chunhe-B25806; Gala Kumar-B11780; linuxppc-dev@ozlabs.org; Hu
Mingkai-B21284
> Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver
detect nand
> flash partitions
>=20
> On Wed, 13 Oct 2010 20:09:02 -0700
> "Zang Roy-R61911" <r61911@freescale.com> wrote:
>=20
> > > > > > +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl =3D NULL;
> > > > >
> > > > > No need for =3D NULL.
> > > > Any harm? Or just personal habit or style? Can you explain about
> > why?
> > >
> > > Besides not wanting superfluous code on general principle, it
could
> > > hide a bug if in the future the real initialization is missing on
some
> > > code path.  It would become a runtime NULL dereference rather than
a
> > > compiler warning.
> >
> > Not exactly.
> > Per my understand, if the pointer will definitely be assigned in
code
> > path,
> > it is not necessary to init it when define. for example,
> >
> > char c;
> > char b;
> > char *a;
> > if (condition)
> > 	a =3D &c;
> > else
> > 	a =3D &b;
> > ...
> >
> > for other case, if the path will not ensure the pointer assignment,
it
> > will be inited
> > when define to avoid warning. for example,
> >
> > char c;
> > char *a =3D NULL;
> > if (condition)
> > 	a =3D &c;
> > ...
>=20
> Yes, but this patch looks like the former case, not the
> latter.=20
That is right.
> Is GCC giving a warning without the initializer?
no.
we are on the same point.
Thanks.
Roy
