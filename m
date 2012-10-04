Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 82BC12C034F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 03:08:48 +1000 (EST)
Date: Thu, 4 Oct 2012 11:08:41 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC: Correct the tophys/tovirt macros
Message-ID: <20121004170841.GA2994@obsidianresearch.com>
References: <20120930232847.GG30637@obsidianresearch.com>
 <1349349544.4260.24.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349349544.4260.24.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 04, 2012 at 09:19:04PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2012-09-30 at 17:28 -0600, Jason Gunthorpe wrote:
> > asm/page.h discusses the calculation for v2p and p2v, it should be:
> >  va = pa + KERNELBASE - PHYSICAL_START
> > which is the same as:
> >  va = pa + LOAD_OFFSET
> > 
> > tophys/tovirt were using PAGE_OFFSET, which as page.h says, is almost
> > always the same thing.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> It's a bit gross tho in that KERNEL_BASE, PHYSICAL_START and LOAD_OFFSET
> are about where the kernel is linked/running, and while the value ends
> up happening to also be the p->v offset (and indeed not by accident), it
> makes the code less clear and more confusing.

Yes, I found the three names confusing.. However LOAD_OFFSET is the
name that include/asm-generic/vmlinux.lds.h and many arch's use for
P2V translation in the linker script, so at least there is some
precedent.

> I don't have the bandwidth to revisit all that, but I really think that
> whole are area where PAGE_OFFSET doesn't map 0 needs revisiting.

Something like that is also outside my scope.. This patch does fix a
bug I hit when CONFIG_PHYSICAL_START is used, are there problems with
it in other cases?

FWIW, this is part of a larger work that makes CONFIG_PHYSICAL_START
work on PPC404, which is not yet clean enough to post:
https://github.com/jgunthorpe/linux/commit/90df2d247c9db5d39c32dbbada0815f15d7b3be7

Regards,
Jason
