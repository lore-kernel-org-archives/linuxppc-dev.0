Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00A33B70CB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 03:24:11 +1100 (EST)
Received: from mail117-tx2 (localhost.localdomain [127.0.0.1])	by
	mail117-tx2-R.bigfish.com (Postfix) with ESMTP id 60C4512406E9	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:01:27 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.251])	by
	mail117-tx2.bigfish.com (Postfix) with ESMTP id 303A412E8053	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:01:25 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9EG1f8d012679	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:01:41 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9EGGVcP020622	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 11:16:31 -0500 (CDT)
Date: Thu, 14 Oct 2010 11:01:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20101014110118.11fabed5@udp111988uds.am.freescale.net>
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60A2B02B7@zch01exm23.fsl.freescale.net>
References: <20101004103813.14d04956@udp111988uds.am.freescale.net>
	<3850A844E6A3854C827AC5C0BEC7B60A2B02B7@zch01exm23.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Hu Mingkai-B21284 <B21284@freescale.com>,
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

On Wed, 13 Oct 2010 20:09:02 -0700
"Zang Roy-R61911" <r61911@freescale.com> wrote:

> > > > > +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;
> > > >
> > > > No need for = NULL.
> > > Any harm? Or just personal habit or style? Can you explain about
> why?
> > 
> > Besides not wanting superfluous code on general principle, it could
> > hide a bug if in the future the real initialization is missing on some
> > code path.  It would become a runtime NULL dereference rather than a
> > compiler warning.
> 
> Not exactly.
> Per my understand, if the pointer will definitely be assigned in code
> path,
> it is not necessary to init it when define. for example,
> 
> char c;
> char b;
> char *a;
> if (condition)
> 	a = &c;
> else
> 	a = &b;
> ...
> 
> for other case, if the path will not ensure the pointer assignment, it
> will be inited
> when define to avoid warning. for example,
> 
> char c;
> char *a = NULL;
> if (condition)
> 	a = &c;
> ...

Yes, but this patch looks like the former case, not the
latter.  Is GCC giving a warning without the initializer?

-Scott
