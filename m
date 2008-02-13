Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2010DDF5C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 10:17:57 +1100 (EST)
Date: Wed, 13 Feb 2008 15:18:28 -0800 (PST)
Message-Id: <20080213.151828.177835338.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] [POWERPC] Make lmb support large physical addressing
From: David Miller <davem@davemloft.net>
In-Reply-To: <1202943042.7296.48.camel@pasglop>
References: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
	<1202943042.7296.48.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2008 09:50:42 +1100

> 
> On Wed, 2008-02-13 at 16:43 -0600, Becky Bruce wrote:
> > Convert the lmb code to use phys_addr_t instead of unsigned long for
> > physical addresses and sizes.  This is needed to support large amounts
> > of RAM on 32-bit systems that support 36-bit physical addressing.
> > 
> > Built/booted on mpc8641; build tested on pasemi and 44x.
> > 
> > Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> > ---
> > Folks,
> > 
> > This has been sitting in my tree for a few days, and now it looks like
> > David M. has submitted a patch that changes the lmb code to be shared
> > between sparc and powerpc.  Sparc has no notion of a phys_addr_t.
> > Should we just use u64 everywhere in this code instead?  Thoughts?
> 
> An option would be to use resource_size_t, though it's a bit yucky...
> 
> Dave, what do you prefer ?

u64 is fine with me, either way we'll be casting the printk()
arguments all over the place so the choice really isn't
so important one way or the other as far as I can tell.
