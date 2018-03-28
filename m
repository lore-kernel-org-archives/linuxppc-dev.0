Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BCqc6ZwZzF2Gf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 03:23:40 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id a11so1163690pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 09:23:40 -0700 (PDT)
Date: Thu, 29 Mar 2018 02:23:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linus971@gmail.com, will.deacon@arm.com, alexander.duyck@gmail.com,
 okaya@codeaurora.org, jgg@ziepe.ca, David.Laight@aculab.com,
 oohall@gmail.com, netdev@vger.kernel.org, alexander.h.duyck@redhat.com,
 torvalds@linux-foundation.org
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180329022324.037c3f39@roar.ozlabs.ibm.com>
In-Reply-To: <20180328.115509.481837809903086401.davem@davemloft.net>
References: <CA+55aFxULkhZGhg-tTBBxBBvXbL7QV7f6zvwW7U2wHFijqGEqw@mail.gmail.com>
 <b02cc752d90c5e5ae2cc8cc4f67429a7@codeaurora.org>
 <1522249996.21446.25.camel@kernel.crashing.org>
 <20180328.115509.481837809903086401.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Mar 2018 11:55:09 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 29 Mar 2018 02:13:16 +1100
> 
> > Let's fix all archs, it's way easier than fixing all drivers. Half of
> > the archs are unused or dead anyway.  
> 
> Agreed.

While we're making decrees here, can we do something about mmiowb?
The semantics are basically indecipherable.

  This is a variation on the mandatory write barrier that causes writes to weakly
  ordered I/O regions to be partially ordered.  Its effects may go beyond the
  CPU->Hardware interface and actually affect the hardware at some level.

How can a driver writer possibly get that right?

IIRC it was added for some big ia64 system that was really expensive
to implement the proper wmb() semantics on. So wmb() semantics were
quietly downgraded, then the subsequently broken drivers they cared
about were fixed by adding the stronger mmiowb().

What should have happened was wmb and writel remained correct, sane, and
expensive, and they add an mmio_wmb() to order MMIO stores made by the
writel_relaxed accessors, then use that to speed up the few drivers they
care about.

Now that ia64 doesn't matter too much, can we deprecate mmiowb and just
make wmb ordering talk about stores to the device, not to some
intermediate stage of the interconnect where it can be subsequently
reordered wrt the device? Drivers can be converted back to using wmb
or writel gradually.

Thanks,
Nick
