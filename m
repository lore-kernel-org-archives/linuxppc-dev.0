Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2DC1EB70A3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 08:01:17 +1000 (EST)
Subject: Re: ppc44x - how do i optimize driver for tlb hits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20100923151246.GA17015@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 08:01:04 +1000
Message-ID: <1285279264.5158.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-23 at 10:12 -0500, Ayman El-Khashab wrote:
> I've implemented a working driver on my 460EX.  it allocates a couple
> of buffers of 4MB each.  I have a custom memcmp algorithm in asm that
> is extremely fast in user space, but 1/2 as fast when run on these
> buffers.
> 
> my tests are showing that the algorithm seems to be memory bandwidth
> bound.  my guess is that i am having tlb or cache misses (my algo
> uses the dbct) that is slowing performance.  curiously when in user
> space, i can affect the performance by small changes in the size of
> the buffer, i.e. 4MB + 32B is fast, 4MB + 4K is much worse.
> 
> Can i adjust my driver code that is using kmalloc to make sure that
> the ppc44x has 4MB tlb entries for these and that they stay put?

Anything you allocate with kmalloc() is going to be mapped by bolted
256M TLB entries, so there should be no TLB misses happening in the
kernel case.

Cheers,
Ben.
