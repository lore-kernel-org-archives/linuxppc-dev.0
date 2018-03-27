Return-Path: <jgg@ziepe.ca>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409DFn0vSQzF24G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 12:39:23 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id a15so7986003pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 18:39:23 -0700 (PDT)
Date: Mon, 26 Mar 2018 19:39:18 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180327013918.GN15554@ziepe.ca>
References: <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <1522103771.7364.20.camel@kernel.crashing.org>
 <20180326225046.GL15554@ziepe.ca>
 <1522108780.7364.24.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1522108780.7364.24.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 10:59:40AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2018-03-26 at 16:50 -0600, Jason Gunthorpe wrote:
> > On Tue, Mar 27, 2018 at 09:36:11AM +1100, Benjamin Herrenschmidt wrote:
> > > On Mon, 2018-03-26 at 16:27 -0600, Jason Gunthorpe wrote:
> > > > > Otherwise almost all drivers out there are broken which I very much
> > > > > doubt :-)
> > > > 
> > > > But.. Sinan is right, you look anywhere in the driver tree and you
> > > > find stuff like this:
> > > > 
> > > > drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > > > 
> > > >         /* Force memory writes to complete before letting h/w
> > > >          * know there are new descriptors to fetch.
> > > >          */
> > > >         wmb();
> > > > 
> > > > 
> > > > It is *systemic*
> > > 
> > > Yes, because they all copied e1000e :-) If you look at the comment in
> > > there, it does say it's only for weakly ordered archs such as ia64, and
> > > even then, probably predates Linus strong statement on the matter.
> > 
> > Hahah, sure I'll buy that..
> > 
> > But still, if this really is the case, a *strong* statement in
> > barriers.txt to that effect (and not an example demanding the wmb()!)
> > would be very helpful for those of us that have to review driver code!
> 
> I agree, and that Mellanox bug you pointed me to seems to indicate that
> this may not even be true on x86 anymore ...

However, with bugs like that it is hard to know what is going on.. It
could be a CPU bug instead.

> I think we might need to revisit this properly...

I would love to hear a definitive statement from Intel on what wmb();
writel(); does on x86..

Sinan's patches are backwards if writel is ordered, instead of
using writel_relaxed, they should be eliminating the wmb().

But there is no way patches like that could go ahead until
barriers.txt is updated..

Jason
