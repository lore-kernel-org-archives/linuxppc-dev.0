Return-Path: <kim.phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8EF1DDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 11:40:29 +1100 (EST)
Date: Mon, 8 Dec 2008 18:35:52 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: jhsiao@amcc.com
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v4]
Message-Id: <20081208183552.744cb4ae.kim.phillips@freescale.com>
In-Reply-To: <1228773307.4906.14.camel@jhsiao-usb>
References: <1228256232.4770.47.camel@jhsiao-usb>
	<20081204193256.12dbc306.kim.phillips@freescale.com>
	<1228773307.4906.14.camel@jhsiao-usb>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 08 Dec 2008 13:55:07 -0800
James Hsiao <jhsiao@amcc.com> wrote:

> >> +     /* figure how many gd is needed */
> >> +     if (aad_len) {
> >> +             num_gd = get_sg_count(assoc, aad_len) +
> >> +                     get_sg_count(src, datalen);
> 
> > this is dead code - aad_len is never non-zero - is there some code
> > missing from crypto4xx_alg.c?  Also, IIRC, assoc is a superset of src,
> > so I believe something like num_gd = get_sg_count(assoc, aad_len +
> > datalen) would work better - this should also permit removal of the
> > nbytes reached check in [1] in get_sg_count.
> 
> For the get num_gd, assoc and src are two different scatter_lists. One
> for the packet and one for the aad, so, it makes more sense to me to
> count them seperately. Yes?

ok I looked it up - they are disjoint sg lists, so, yes, you're right.

> The way to driver pass aad and aad_len is from crypto4xx_build_pd. 
> This aad support will be used in the future. Do you want me to remover
> from the current release?  The reason I have it in, is to avoid too much
> code change for the future release.

removing it would definitely make both this and any forthcoming aead
patches more on topic and thus easier to review (plus I suspect adding
unused code to the kernel is generally frowned upon...)

Kim
