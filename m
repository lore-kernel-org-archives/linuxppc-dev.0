Return-Path: <scottwood@freescale.com>
Date: Mon, 13 Oct 2008 10:06:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
Message-ID: <20081013150613.GD18502@ld0162-tx32.am.freescale.net>
References: <48ECC611.3030309@mikroswiat.pl> <48ECF08F.7000400@freescale.com>
	<1223764327.8157.185.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223764327.8157.185.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 12, 2008 at 09:32:07AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-08 at 12:40 -0500, Scott Wood wrote:
> > 
> > The performance difference most likely comes from the fact that copy 
> > to/from user can assume that the memory is cacheable, while memcpy is 
> > occasionally used on cache-inhibited memory -- so dcbz isn't used.  We 
> > may be better off handling the alignment fault on those occasions, and 
> > we should use dcba on chips that support it.
> 
> Note that the kernel memcpy isn't supposed to be used for non-cacheable
> memory. That's what memcpy_to/fromio are for.

I agree that it *shouldn't*, but the presence of cacheble_memcpy (used
only by the EMAC driver, AFAICT) suggests that it was a concern.

> But Paul has a point that for small copies especially, the cost of
> the cache instructions outweigh their benefit.

Possibly, but what is the overall effect on the system of using them,
even if it hurts small copies slightly?  How many small copies are of
constant size, which could be diverted to another implementation at
compile-time?  Even run-time diversion may help, as the cost of a small
memcpy is only important if you do it many times, in which case the
branch will probably be correctly predicted.

Given the networking results Dominik posted, I think it's worth a look.

-Scott
