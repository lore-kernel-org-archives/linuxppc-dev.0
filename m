Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by lists.ozlabs.org (Postfix) with ESMTP id 0F8591A0357
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 11:20:54 +1000 (EST)
Date: Tue, 17 Jun 2014 10:25:07 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
Message-ID: <20140617012507.GA6825@js1304-P5Q-DELUXE>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <539EB4C7.3080106@samsung.com>
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2014 at 11:11:35AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-06-16 07:40, Joonsoo Kim wrote:
> >Currently, there are two users on CMA functionality, one is the DMA
> >subsystem and the other is the KVM on powerpc. They have their own code
> >to manage CMA reserved area even if they looks really similar.
> >>From my guess, it is caused by some needs on bitmap management. Kvm side
> >wants to maintain bitmap not for 1 page, but for more size. Eventually it
> >use bitmap where one bit represents 64 pages.
> >
> >When I implement CMA related patches, I should change those two places
> >to apply my change and it seem to be painful to me. I want to change
> >this situation and reduce future code management overhead through
> >this patch.
> >
> >This change could also help developer who want to use CMA in their
> >new feature development, since they can use CMA easily without
> >copying & pasting this reserved area management code.
> >
> >v3:
> >   - Simplify old patch 1(log format fix) and move it to the end of patchset.
> >   - Patch 2: Pass aligned base and size to dma_contiguous_early_fixup()
> >   - Patch 5: Add some accessor functions to pass aligned base and size to
> >   dma_contiguous_early_fixup() function
> >   - Patch 5: Move MAX_CMA_AREAS definition to cma.h
> >   - Patch 6: Add CMA region zeroing to PPC KVM's CMA alloc function
> >   - Patch 8: put 'base' ahead of 'size' in cma_declare_contiguous()
> >   - Remaining minor fixes are noted in commit description of each one
> >
> >v2:
> >   - Although this patchset looks very different with v1, the end result,
> >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
> >
> >This patchset is based on linux-next 20140610.
> 
> Thanks for taking care of this. I will test it with my setup and if
> everything goes well, I will take it to my -next tree. If any branch
> is required for anyone to continue his works on top of those patches,
> let me know, I will also prepare it.

Hello,

I'm glad to hear that. :)
But, there is one concern. As you already know, I am preparing further
patches (Aggressively allocate the pages on CMA reserved memory). It
may be highly related to MM branch and also slightly depends on this CMA
changes. In this case, what is the best strategy to merge this
patchset? IMHO, Anrew's tree is more appropriate branch. If there is
no issue in this case, I am willing to develope further patches based
on your tree.

Thanks.
