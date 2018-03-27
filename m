Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409V3h65PxzF2Bb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 23:01:36 +1100 (AEDT)
Message-ID: <1522149687.7364.46.camel@kernel.crashing.org>
Subject: Re: RFC on writel and writel_relaxed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, Sinan
 Kaya <okaya@codeaurora.org>, David Laight <David.Laight@aculab.com>, Oliver
 <oohall@gmail.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Alexander Duyck
 <alexander.h.duyck@redhat.com>, "Paul E. McKenney"
 <paulmck@linux.vnet.ibm.com>, peterz@infradead.org,
 mingo@redhat.com, corbet@lwn.net
Date: Tue, 27 Mar 2018 22:21:27 +1100
In-Reply-To: <20180327095745.GB29373@arm.com>
References: <CAK8P3a1zeMyj+Z-y4ER4moY6Zip9EWNOinf+VnboGOrgiwbBZA@mail.gmail.com>
 <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <20180327095745.GB29373@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 10:57 +0100, Will Deacon wrote:
> > 
> > The interesting thing is that we do seem to have a whole LOT of these
> > spurrious wmb before writel all over the tree, I suspect because of
> > that incorrect recommendation in memory-barriers.txt.
> > 
> > We should fix that.
> 
> Patch below. Thoughts?

Looks good, we should probably also have a clearer (explicit)
definition of that ordering in the driver-api doco.

Now, to remove all those useless wmb's and find what other bugs they
were papering over ... ;-)

Cheers,
Ben.
