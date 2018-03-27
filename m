Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409kpW59yGzF204
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 08:36:03 +1100 (AEDT)
Message-ID: <1522186519.7364.64.camel@kernel.crashing.org>
Subject: Re: RFC on writel and writel_relaxed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Jason
 Gunthorpe <jgg@ziepe.ca>
Cc: David Laight <David.Laight@aculab.com>, Oliver <oohall@gmail.com>, "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Alexander Duyck
 <alexander.h.duyck@redhat.com>, Will Deacon <will.deacon@arm.com>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 28 Mar 2018 08:35:19 +1100
In-Reply-To: <1e077f6a-90b6-cce9-6f0f-a8c003fec850@codeaurora.org>
References: <1521692689.16434.293.camel@kernel.crashing.org>
 <CAOSf1CFv1HHCL3YOVhRn2U=grdNjaQ=A4m3xwxN2Rek1-_TySg@mail.gmail.com>
 <1521726722.16434.312.camel@kernel.crashing.org>
 <20180323163510.GC13033@ziepe.ca>
 <1521854626.16434.359.camel@kernel.crashing.org>
 <58ce5b83f40f4775bec1be8db66adb0d@AcuMS.aculab.com>
 <20180326165425.GA15554@ziepe.ca>
 <CAK8P3a1zeMyj+Z-y4ER4moY6Zip9EWNOinf+VnboGOrgiwbBZA@mail.gmail.com>
 <20180326202545.GB15554@ziepe.ca>
 <CAK8P3a3fc43ZcW626hmsd3DVcLw7hGkdUMxp7s4Rn3mdkziwMQ@mail.gmail.com>
 <20180326210951.GD15554@ziepe.ca>
 <CAK8P3a2UU1xAM0NLo7Q4-Xgo1SzY3De1uqpFudr+2ZW7nHEPmA@mail.gmail.com>
 <1522101616.7364.13.camel@kernel.crashing.org>
 <1e077f6a-90b6-cce9-6f0f-a8c003fec850@codeaurora.org>
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

On Tue, 2018-03-27 at 10:46 -0400, Sinan Kaya wrote:
>  combined buffers.
> 
> Alex:
> "Don't bother. I can tell you right now that for x86 you have to have a
> wmb() before the writel().

No, this isn't the semantics of writel. You shouldn't need it unless
something changed and we need to revisit our complete understanding of
*all* MMIO accessor semantics.

At least for UC space, it has always been accepted (and enforced) that
writel would not require any other barrier to order vs. previous stores
to memory.

> Based on the comment in
> (https://www.spinics.net/lists/linux-rdma/msg62666.html):
>     Replacing wmb() + writel() with wmb() + writel_relaxed() will work on
>     PPC, it will just not give you a benefit today.
> 
> I say the patch set stays. This gives benefit on ARM, and has no
> effect on x86 and PowerPC. If you want to look at trying to optimize
> things further on PowerPC and such then go for it in terms of trying
> to implement the writel_relaxed(). Otherwise I say we call the ARM
> goodness a win and don't get ourselves too wrapped up in trying to fix
> this for all architectures."
