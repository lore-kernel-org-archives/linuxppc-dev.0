Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4098C520L8zF27C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 09:36:49 +1100 (AEDT)
Message-ID: <1522103771.7364.20.camel@kernel.crashing.org>
Subject: Re: RFC on writel and writel_relaxed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, David
 Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>, "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Alexander Duyck
 <alexander.h.duyck@redhat.com>, Will Deacon <will.deacon@arm.com>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 09:36:11 +1100
In-Reply-To: <20180326222756.GJ15554@ziepe.ca>
References: <1521854626.16434.359.camel@kernel.crashing.org>
 <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
 <20180326165425.GA15554@ziepe.ca>
 <CAK8P3a1zeMyj+Z-y4ER4moY6Zip9EWNOinf+VnboGOrgiwbBZA@mail.gmail.com>
 <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <ebb36fd4-62e2-394a-219f-686c45a6dc75@codeaurora.org>
 <1522101717.7364.14.camel@kernel.crashing.org>
 <20180326222756.GJ15554@ziepe.ca>
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

On Mon, 2018-03-26 at 16:27 -0600, Jason Gunthorpe wrote:
> > Otherwise almost all drivers out there are broken which I very much
> > doubt :-)
> 
> But.. Sinan is right, you look anywhere in the driver tree and you
> find stuff like this:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c
> 
>         /* Force memory writes to complete before letting h/w
>          * know there are new descriptors to fetch.
>          */
>         wmb();
> 
> 
> It is *systemic*

Yes, because they all copied e1000e :-) If you look at the comment in
there, it does say it's only for weakly ordered archs such as ia64, and
even then, probably predates Linus strong statement on the matter.

> I even see patches adding wmb() based on actual observed memory
> corruption during testing on Intel:
> 
> https://patchwork.kernel.org/patch/10177207/
> 
> So you think all of this is unnecessary and writel is totally strongly
> ordered, even on multi-socket Intel?

I don't kow, it used to be the case, at least that's what drove us to
define things the way we did.

Maybe things changed, but if that's the case, nobody knows for sure,
and we probably want to get Linus POV on the matter.

I know I still write drivers that do not add a wmb in that case because
I expect things to work without it.

If that has changed, we probably can relax some of the barriers in our
implementations of writel on a number of architectures, but not before
auditing a bunch more drivers to make sure they have the write wmb()'s

Cheers,
Ben.
