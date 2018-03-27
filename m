Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 409TFG3N5yzF2C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 22:24:49 +1100 (AEDT)
Date: Tue, 27 Mar 2018 12:24:57 +0100
From: Will Deacon <will.deacon@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sinan Kaya <okaya@codeaurora.org>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180327112456.GA15531@arm.com>
References: <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <20180327094159.GA29373@arm.com>
 <1522149602.7364.44.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522149602.7364.44.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 10:20:02PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2018-03-27 at 10:42 +0100, Will Deacon wrote:
> > > 
> > > This example adds a wmb() between two writes to a coherent DMA
> > > area, it is definitely required there. I'm pretty sure I've never seen
> > > any bug reports pointing to a missing wmb() between memory
> > > and MMIO write accesses, but if you remember seeing them in the
> > > list, maybe you can look again for some evidence of something going
> > > wrong on x86 without it?
> > 
> > If this is just about ordering accesses to coherent DMA, then using
> > dma_wmb() instead will be much better performance on arm/arm64.
> 
> Ah, something we should look into for powerpc as well, as we could use
> an lwsync for that which is also cheaper than a full sync wmb does.
> 
> dma_wmb() is basically the same as smp_wmb() without the CONFIG_SMP
> conditional right ?

Almost -- the slight change we have on arm64 is to say that it's
"outer-shareable", which means it also orders non-cacheable accesses
in the case that dma_alloc_coherent is used to allocate a consistent
buffer for a non-coherent device.

Will
