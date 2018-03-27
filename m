Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 409YVH4vDTzF2Ch
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 01:36:22 +1100 (AEDT)
Date: Tue, 27 Mar 2018 15:36:29 +0100
From: Will Deacon <will.deacon@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180327143628.GA10642@arm.com>
References: <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <20180327095745.GB29373@arm.com>
 <CAK8P3a0s+kP5=qEqTqAHGwB7j9ydaXD+oQJdLrFz=8swuWaDBg@mail.gmail.com>
 <20180327100944.GD29373@arm.com>
 <CAK8P3a0Xep0-EpGS9jnjUf1iJhRxH1WRztGQrvkdrLVaxBPT1w@mail.gmail.com>
 <20180327110258.GF2464@arm.com>
 <bba5ebd8-0643-6f09-9367-419b49e53535@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bba5ebd8-0643-6f09-9367-419b49e53535@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 09:46:51AM -0400, Sinan Kaya wrote:
> On 3/27/2018 7:02 AM, Will Deacon wrote:
> > -     See Documentation/DMA-API.txt for more information on consistent memory.
> > +     can see it now has ownership.  Note that, when using writel(), a prior
> > +     wmb() is not needed to guarantee that the cache coherent memory writes
> > +     have completed before writing to the MMIO region.  The cheaper
> > +     writel_relaxed() does not provide this guarantee and must not be used
> > +     here.
> 
> Can we say the same thing for iowrite32() and iowrite32be(). I also see wmb()
> in front of these.

I don't think so. My reading of memory-barriers.txt says that writeX might
expand to outX, and outX is not ordered with respect to other types of
memory.

Will
