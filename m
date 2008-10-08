Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (unknown [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id 8F8BDDDF6A
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 11:13:35 +1100 (EST)
Date: Wed, 8 Oct 2008 16:50:27 -0700
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 8600 serial support
Message-ID: <20081008235027.GA14053@cynthia.pants.nu>
References: <48ED0F30.7080103@hypersurf.com> <1223498711.8157.90.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223498711.8157.90.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 07:45:11AM +1100, Benjamin Herrenschmidt wrote:
> Yes, it's not totally trivial and I wouldn't recommend using the weirdo
> code in macserial (it does things that I don't understand how they work
> with the dbdma engine).
> 
> The best way I see is to start from scratch with two different
> mechanisms:
> 
>  - For Tx, that's the easiest, the fire off DMA's for outgoing chars,
> maybe queue up a few descriptors to let data accumulate.
> 
>  - For Rx, one descriptor per byte. That sucks but I think that's also
> what Apple does. No need to have a huge Rx buffer anyway. That gives you
> precise Rx status to the byte.

I know it's not really in the scope of the discussion, but do you have
any suggestions for how we might support this with AMIC or PSC DMA where
we can't have an arbitrary number of in-flight commands? There hasn't
been a lot of traction on getting the non-PCI macs working again, but
that is something that may happen eventually. It would be nice to have
similar designs for both the descriptor based and register driven DMA
engines, but I definitely understand if you think that's not realistic.

It seems to me that an interrupt per-byte (which this design would
imply on the older DMA engines) would make the DMA less useful.

	Brad Boyer
	flar@allandria.com
