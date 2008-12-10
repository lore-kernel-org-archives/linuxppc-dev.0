Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BCBCDDF26
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 04:25:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mBAHPDfa018866
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 10:25:14 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mBAHPCSH015543
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 11:25:13 -0600 (CST)
Date: Wed, 10 Dec 2008 11:25:12 -0600
From: Scott Wood <scottwood@freescale.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] fork_init: fix division by zero
Message-ID: <20081210172512.GA19584@ld0162-tx32.am.freescale.net>
References: <200812092044.40649.yur@emcraft.com>
	<Pine.LNX.4.64.0812100944080.25126@vixen.sonytel.be>
	<503391615.20081210130113@emcraft.com>
	<20081210101745.GG28946@ZenIV.linux.org.uk>
	<1795455197.20081210132912@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1795455197.20081210132912@emcraft.com>
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Al Viro <viro@ZenIV.linux.org.uk>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2008 at 01:29:12PM +0300, Yuri Tikhonov wrote:
> On Wednesday, December 10, 2008 you wrote:
> > x * y / z is parsed as (x * y) / z, not x * (y / z).
> 
>  Here we believe in preprocessor: since all PAGE_SIZE, 8, and 
> THREAD_SIZE are the constants we expect it will calculate this.
> 
>  E.g. here is the result from this line as produced by cross-gcc 
> 4.2.2:
> 
>         lis     r9,0
>         rlwinm  r29,r29,2,16,29
>         stw     r29,0(r9)
> 
>  As you see - only rotate-left, i.e. multiplication to the constant.

Yes, and also note that it is masking the result by 0xfffc, to preserve
the effect of any overflow in (x * y).

-Scott
