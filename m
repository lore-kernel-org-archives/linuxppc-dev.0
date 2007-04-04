Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F7B0DDF17
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:14:03 +1000 (EST)
Date: Wed, 4 Apr 2007 13:13:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
Message-ID: <20070404181351.GA19855@ld0162-tx32.am.freescale.net>
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4613E7CC.1020001@246tNt.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 08:00:44PM +0200, Sylvain Munaut wrote:
> Timur Tabi wrote:
> >   The first time you call rh_alloc(), you will get back a value of 0,
> > because that's the beginning of the heap.
> No, it doesn't always return 0.
> That depends on what free region you "attached" at initialisation. And
> you could have attached 0xffff0000 -> 0xffffffff ....

...in which case it's already broken, as IS_ERR() will return true after
you use up a little over 1/16 of the region.

-Scott
