Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BFE2B6EDD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2010 02:38:37 +1100 (EST)
Received: from mail4-db3 (localhost.localdomain [127.0.0.1])	by
	mail4-db3-R.bigfish.com (Postfix) with ESMTP id 90F501A3820C	for
	<linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 15:38:31 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.250])	by
	mail4-db3.bigfish.com (Postfix) with ESMTP id 4F3E6600046	for
	<linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2010 15:38:30 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o94FcGUO029983	for
	<linuxppc-dev@ozlabs.org>; Mon, 4 Oct 2010 08:38:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o94Fr7UN000090	for <linuxppc-dev@ozlabs.org>;
	Mon, 4 Oct 2010 10:53:07 -0500 (CDT)
Date: Mon, 4 Oct 2010 10:38:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20101004103813.14d04956@udp111988uds.am.freescale.net>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A256099@zch01exm23.fsl.freescale.net>
References: <20100920131907.GA2184@oksana.dev.rtsoft.ru>
	<3850A844E6A3854C827AC5C0BEC7B60A256099@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
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

On Sat, 2 Oct 2010 05:36:27 -0700
"Zang Roy-R61911" <r61911@freescale.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Anton Vorontsov [mailto:cbouatmailru@gmail.com]
> > Sent: Monday, September 20, 2010 21:19 PM
> > To: Zang Roy-R61911
> > Cc: linux-mtd@lists.infradead.org; dwmw2@infradead.org; dedekind1@gmail.com;
> > akpm@linux-foundation.org; Lan Chunhe-B25806; Wood Scott-B07421; Gala Kumar-
> > B11780; linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect nand
> > flash partitions
> > 
> > On Fri, Sep 17, 2010 at 03:01:08PM +0800, Roy Zang wrote:
> > [...]
> > > +static struct mutex fsl_elbc_nand_mutex;
> > > +
> > > +static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
> > >  {
> > > -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> > > +	struct fsl_lbc_regs __iomem *lbc;
> > >  	struct fsl_elbc_mtd *priv;
> > >  	struct resource res;
> > > +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;
> > 
> > No need for = NULL.
> Any harm? Or just personal habit or style? Can you explain about why?

Besides not wanting superfluous code on general principle, it could
hide a bug if in the future the real initialization is missing on some
code path.  It would become a runtime NULL dereference rather than a
compiler warning.

-Scott
