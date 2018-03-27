Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 409RN972mczF2B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 21:00:41 +1100 (AEDT)
Date: Tue, 27 Mar 2018 11:00:49 +0100
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Sinan Kaya <okaya@codeaurora.org>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180327100049.GC29373@arm.com>
References: <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <CAK8P3a0gCYjw78snni_1Jkk5uA5a-j0x-XZDrN=RaZfXctOSoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a0gCYjw78snni_1Jkk5uA5a-j0x-XZDrN=RaZfXctOSoA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 11:44:22AM +0200, Arnd Bergmann wrote:
> On Tue, Mar 27, 2018 at 10:56 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2018-03-27 at 09:56 +0200, Arnd Bergmann wrote:
> >> On Tue, Mar 27, 2018 at 12:27 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>
> >> I'm pretty sure I've never seen
> >> any bug reports pointing to a missing wmb() between memory
> >> and MMIO write accesses, but if you remember seeing them in the
> >> list, maybe you can look again for some evidence of something going
> >> wrong on x86 without it?
> >
> > The interesting thing is that we do seem to have a whole LOT of these
> > spurrious wmb before writel all over the tree, I suspect because of
> > that incorrect recommendation in memory-barriers.txt.
> >
> > We should fix that.
> 
> Maybe the problem is just that it's so counter-intuitive that we don't
> need that barrier in Linux, when the hardware does need one on some
> architectures.
> 
> How about we define a barrier type instruction specifically for this
> purpose, something like wmb_before_mmio() and have all architectures
> define that to an empty macro?
> 
> That way, having correct code using wmb_before_mmio() will not
> trigger an incorrect review comment that leads to extra wmb(). ;-)

Please don't add more barriers :)! I think that will make it even more
difficult to understand how to use the ones we already have -- the problem
here seems to be that the documentation that was added for the dma_*
barriers got this wrong, but it was at least in contradiction with the
section elsewhere in memory-barriers.txt that describes the relaxed I/O
accessors.

I guess somebody could hack checkpatch to look for back-to-back wmb/writel
sequences? I suspect we could do something with coccinelle too.

Will
