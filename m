Return-Path: <benh@kernel.crashing.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48ECF08F.7000400@freescale.com>
References: <48ECC611.3030309@mikroswiat.pl> <48ECF08F.7000400@freescale.com>
Content-Type: text/plain
Date: Sun, 12 Oct 2008 09:32:07 +1100
Message-Id: <1223764327.8157.185.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 12:40 -0500, Scott Wood wrote:
> 
> The performance difference most likely comes from the fact that copy 
> to/from user can assume that the memory is cacheable, while memcpy is 
> occasionally used on cache-inhibited memory -- so dcbz isn't used.  We 
> may be better off handling the alignment fault on those occasions, and 
> we should use dcba on chips that support it.

Note that the kernel memcpy isn't supposed to be used for non-cacheable
memory. That's what memcpy_to/fromio are for.

But Paul has a point that for small copies especially, the cost of
the cache instructions outweigh their benefit.

Cheers,
Ben.
