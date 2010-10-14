Return-Path: <R61911@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8865A1007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 14:09:11 +1100 (EST)
Received: from mail166-tx2 (localhost.localdomain [127.0.0.1])	by
	mail166-tx2-R.bigfish.com (Postfix) with ESMTP id 66799E80320	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 03:09:08 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.246])	by
	mail166-tx2.bigfish.com (Postfix) with ESMTP id 1940A187804F	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 03:09:08 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9E39OMQ025703	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 20:09:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o9E38q7a009486	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 22:09:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect nand
	flash partitions
Date: Thu, 14 Oct 2010 11:09:02 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B02B7@zch01exm23.fsl.freescale.net>
In-Reply-To: <20101004103813.14d04956@udp111988uds.am.freescale.net>
References: <20100920131907.GA2184@oksana.dev.rtsoft.ru><3850A844E6A3854C827AC5C0BEC7B60A256099@zch01exm23.fsl.freescale.net>
	<20101004103813.14d04956@udp111988uds.am.freescale.net>
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
> Sent: Monday, October 04, 2010 23:38 PM
> To: Zang Roy-R61911
> Cc: Anton Vorontsov; linux-mtd@lists.infradead.org;
dwmw2@infradead.org;
> dedekind1@gmail.com; akpm@linux-foundation.org; Lan Chunhe-B25806;
Wood Scott-
> B07421; Gala Kumar-B11780; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver
detect nand
> flash partitions
>=20
> On Sat, 2 Oct 2010 05:36:27 -0700
> "Zang Roy-R61911" <r61911@freescale.com> wrote:
>=20
> >
> >
> > > -----Original Message-----
> > > From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]
> > > Sent: Monday, September 20, 2010 21:19 PM
> > > To: Zang Roy-R61911
> > > Cc: linux-mtd@lists.infradead.org; dwmw2@infradead.org;
> dedekind1@gmail.com;
> > > akpm@linux-foundation.org; Lan Chunhe-B25806; Wood Scott-B07421;
Gala
> Kumar-
> > > B11780; linuxppc-dev@ozlabs.org
> > > Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver
detect
> nand
> > > flash partitions
> > >
> > > On Fri, Sep 17, 2010 at 03:01:08PM +0800, Roy Zang wrote:
> > > [...]
> > > > +static struct mutex fsl_elbc_nand_mutex;
> > > > +
> > > > +static int __devinit fsl_elbc_nand_probe(struct platform_device
*dev)
> > > >  {
> > > > -	struct fsl_lbc_regs __iomem *lbc =3D ctrl->regs;
> > > > +	struct fsl_lbc_regs __iomem *lbc;
> > > >  	struct fsl_elbc_mtd *priv;
> > > >  	struct resource res;
> > > > +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl =3D NULL;
> > >
> > > No need for =3D NULL.
> > Any harm? Or just personal habit or style? Can you explain about
why?
>=20
> Besides not wanting superfluous code on general principle, it could
> hide a bug if in the future the real initialization is missing on some
> code path.  It would become a runtime NULL dereference rather than a
> compiler warning.

Not exactly.
Per my understand, if the pointer will definitely be assigned in code
path,
it is not necessary to init it when define. for example,

char c;
char b;
char *a;
if (condition)
	a =3D &c;
else
	a =3D &b;
...

for other case, if the path will not ensure the pointer assignment, it
will be inited
when define to avoid warning. for example,

char c;
char *a =3D NULL;
if (condition)
	a =3D &c;
...

Thanks.
Roy
