Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 609F4DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 19:57:45 +1100 (EST)
Subject: Re: [PATCH] POWERPC: MTD: Add cached map support to physmap_of MTD
	driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1229365518-20538-1-git-send-email-tpiepho@freescale.com>
References: <1229365518-20538-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 19:55:31 +1100
Message-Id: <1229417731.7319.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 10:25 -0800, Trent Piepho wrote:
> The MTD system supports operation where a direct mapped flash chip is
> mapped twice.  The normal mapping is a standard ioremap(), which is
> non-cached and guarded on powerpc.  The second mapping is used only for
> reads and can be cached and non-guarded.  Currently, only the pxa2xx
> mapping driver makes use of this feature.  This patch adds support to the
> physmap_of driver on PPC32 platforms for this cached mapping mode.

This can be dangerous tho.

I think it's illegal as per the architecture to have the same physical
address mapped twice with different caching attributes.

More specifically, various processors can get very upset if you do an
uncached access that happens to hit a line in the cache.

The problem gets worsened by the fact that cores that support
speculative loads and prefetch will potentially bring anything mapped
into the cache even if it's not directly accessed.

So you have to be very careful and first verify that on whatever core
you intend to use that feature, what you are doing is indeed safe.

Cheers,
Ben.
