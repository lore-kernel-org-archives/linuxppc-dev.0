Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40B2B3331wzF2Jw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:08:58 +1100 (AEDT)
Date: Wed, 28 Mar 2018 10:09:07 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180328090907.GC28871@arm.com>
References: <20180327095745.GB29373@arm.com>
 <CAK8P3a0s+kP5=qEqTqAHGwB7j9ydaXD+oQJdLrFz=8swuWaDBg@mail.gmail.com>
 <20180327100944.GD29373@arm.com>
 <CAK8P3a0Xep0-EpGS9jnjUf1iJhRxH1WRztGQrvkdrLVaxBPT1w@mail.gmail.com>
 <20180327110258.GF2464@arm.com>
 <bba5ebd8-0643-6f09-9367-419b49e53535@codeaurora.org>
 <20180327143628.GA10642@arm.com>
 <1522186185.7364.59.camel@kernel.crashing.org>
 <20180328085338.GA28871@arm.com>
 <5d3973edea93473197505f2e42cd3107@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d3973edea93473197505f2e42cd3107@AcuMS.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2018 at 09:00:01AM +0000, David Laight wrote:
> From: Will Deacon
> > Sent: 28 March 2018 09:54
> ...
> > > > I don't think so. My reading of memory-barriers.txt says that writeX might
> > > > expand to outX, and outX is not ordered with respect to other types of
> > > > memory.
> > >
> > > Ugh ?
> > >
> > > My understanding of HW at least is the exact opposite. outX is *more*
> > > ordered if anything, than any other accessors. IO space is completely
> > > synchronous, non posted and ordered afaik.
> > 
> > I'm just going by memory-barriers.txt:
> > 
> > 
> >  (*) inX(), outX():
> > 
> >      [...]
> > 
> >      They are guaranteed to be fully ordered with respect to each other.
> > 
> >      They are not guaranteed to be fully ordered with respect to other types of
> >      memory and I/O operation.
> 
> A long time ago there was a document from Intel that said that inb/outb weren't
> necessarily synchronised wrt memory accesses.
> (Might be P-pro era).
> However no processors actually behaved that way and more recent docs
> say that inb/outb are fully ordered.

Thank you, David! I'll write another patch fixing this up and hopefully
we'll soon have one making writeX/readX much clearer.

Will
