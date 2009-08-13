Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 94207B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 18:29:23 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1MbUwW-000787-Kq
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2009 09:41:48 +0200
Date: Thu, 13 Aug 2009 09:41:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -v2 0/7] powerpc: use asm-generic/dma-mapping-common.h
Message-ID: <20090813074131.GH12143@elte.hu>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1250142522.3587.110.camel@pasglop>
	<20090813160625B.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090813160625B.fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> On Thu, 13 Aug 2009 15:48:42 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2009-08-05 at 14:08 +0900, FUJITA Tomonori wrote:
> > 
> > > The above swiotlb patchset was merged in -tip so I think that merging
> > > this patchset via -tip too is the easiest way to handle this patchset.
> > > 
> > > The patchset also is available via a git tree:
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git powerpc
> > 
> > Hi !
> > 
> > While I generally agree here with the patches, I'm not sure it should be
> > merged via -tip since it mostly touches arch/powerpc files (and I need
> > to review it a bit more carefully, hopefully you'll have Ack's hitting
> > your mailbox later today).
> 
> Thanks!
> 
> This patchset depends on my swiotlb cleanup patchset:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git swiotlb
> 
> http://marc.info/?l=linux-ia64&m=124718816520156&w=2
> 
> My swiotlb cleanup patchset has been in -tip. It might be easier 
> to merge both the swiotlb patchset and this patchset in powerpc 
> tree?

Ben, what's your preference? I waited for your reaction with these 
bits, i.e. they are not in tip:core/iommu yet.

One variant would be what Fujita suggested: you could pull 
core/iommu as a basis (it's a well-tested, problem-free tree at the 
moment, with no big risky items), and then pull/apply the powerpc 
specific bits from Fujita.

A second variant would be that we could pull these bits into 
core/iommu ... albeit you are right that the PowerPC tree is much 
better at testing PowerPC patches.

A third variant would be to wait with these bits until the swiotlb 
bits in core/iommu hit upstream. This would increase patch latency.

Any of these variants is good to me. What Fujita suggests seems to 
be the best to me: #1 gets us the most testing and the lowest 
latency - at the cost of tree dependency. We wont rebase core/iommu.

[ We've got three good tree properties: "tree independence",
  "good testing", "low patch latency", but we cannot have all
  three at once, we must pick two of them ;-) ]

	Ingo
