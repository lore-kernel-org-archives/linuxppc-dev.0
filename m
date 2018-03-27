Return-Path: <jgg@ziepe.ca>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409XyY3xb2zF2DR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 01:12:19 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id m134-v6so10652170itb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 07:12:19 -0700 (PDT)
Date: Tue, 27 Mar 2018 08:12:15 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: okaya@codeaurora.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>,
 David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, linux-rdma@vger.kernel.org,
 Alexander Duyck <alexander.h.duyck@redhat.com>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: RFC on writel and writel_relaxed
Message-ID: <20180327141215.GA12318@ziepe.ca>
References: <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
 <CAK8P3a3a+zUNLjqw9CL5rYkXhJ-GMVTVnBU2XUu2f3njZfrqKw@mail.gmail.com>
 <1522141019.7364.43.camel@kernel.crashing.org>
 <CAK8P3a0gCYjw78snni_1Jkk5uA5a-j0x-XZDrN=RaZfXctOSoA@mail.gmail.com>
 <1522149801.7364.49.camel@kernel.crashing.org>
 <4f27ac42a6953589157f4d7f18051366@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f27ac42a6953589157f4d7f18051366@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 08:22:55AM -0400, okaya@codeaurora.org wrote:
> On 2018-03-27 07:23, Benjamin Herrenschmidt wrote:
> >On Tue, 2018-03-27 at 11:44 +0200, Arnd Bergmann wrote:
> >>> The interesting thing is that we do seem to have a whole LOT of these
> >>> spurrious wmb before writel all over the tree, I suspect because of
> >>> that incorrect recommendation in memory-barriers.txt.
> >>>
> >>> We should fix that.
> >>
> >>Maybe the problem is just that it's so counter-intuitive that we don't
> >>need that barrier in Linux, when the hardware does need one on some
> >>architectures.
> >>
> >>How about we define a barrier type instruction specifically for this
> >>purpose, something like wmb_before_mmio() and have all architectures
> >>define that to an empty macro?
> >
> >This is exactly what wmb() is about and exactly what Linux rejected
> >back in the day (and in hindsight I agree with him).
> >
> >>That way, having correct code using wmb_before_mmio() will not
> >>trigger an incorrect review comment that leads to extra wmb(). ;-)
> >
> >Ah, you mean have an empty macro that will always be empty on all
> >architectures just to fool people ? :-)
> >
> >Not sure that will fly ... I think we just need to be documenting that
> >stuff better and not have incorrect examples. Also a sweep to remove
> >some useless ones like the one in e1000e would help.
> 
> I have been converting wmb+writel to wmb+writel_relaxed. (About 30 patches)
>
> I will have to just remove the wmb and keep writel, then repost.

Okay, but before you do that, can we get a statement how this works
for WC?

Some of these writels are to WC memory, do they need the wmb()?!?

Jason
