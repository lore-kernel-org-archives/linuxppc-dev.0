Return-Path: <m.szyprowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCEE31A0334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 19:21:50 +1000 (EST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N7900DTZ87C0E50@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 16 Jun 2014 10:11:36 +0100 (BST)
Message-id: <539EB4C7.3080106@samsung.com>
Date: Mon, 16 Jun 2014 11:11:35 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
MIME-version: 1.0
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area management
 code
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
In-reply-to: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
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

Hello,

On 2014-06-16 07:40, Joonsoo Kim wrote:
> Currently, there are two users on CMA functionality, one is the DMA
> subsystem and the other is the KVM on powerpc. They have their own code
> to manage CMA reserved area even if they looks really similar.
> >From my guess, it is caused by some needs on bitmap management. Kvm side
> wants to maintain bitmap not for 1 page, but for more size. Eventually it
> use bitmap where one bit represents 64 pages.
>
> When I implement CMA related patches, I should change those two places
> to apply my change and it seem to be painful to me. I want to change
> this situation and reduce future code management overhead through
> this patch.
>
> This change could also help developer who want to use CMA in their
> new feature development, since they can use CMA easily without
> copying & pasting this reserved area management code.
>
> v3:
>    - Simplify old patch 1(log format fix) and move it to the end of patchset.
>    - Patch 2: Pass aligned base and size to dma_contiguous_early_fixup()
>    - Patch 5: Add some accessor functions to pass aligned base and size to
>    dma_contiguous_early_fixup() function
>    - Patch 5: Move MAX_CMA_AREAS definition to cma.h
>    - Patch 6: Add CMA region zeroing to PPC KVM's CMA alloc function
>    - Patch 8: put 'base' ahead of 'size' in cma_declare_contiguous()
>    - Remaining minor fixes are noted in commit description of each one
>
> v2:
>    - Although this patchset looks very different with v1, the end result,
>    that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
>
> This patchset is based on linux-next 20140610.

Thanks for taking care of this. I will test it with my setup and if
everything goes well, I will take it to my -next tree. If any branch
is required for anyone to continue his works on top of those patches,
let me know, I will also prepare it.

> Patch 1-4 prepare some features to cover PPC KVM's requirements.
> Patch 5-6 generalize CMA reserved area management code and change users
> to use it.
> Patch 7-9 clean-up minor things.
>
> Joonsoo Kim (9):
>    DMA, CMA: fix possible memory leak
>    DMA, CMA: separate core CMA management codes from DMA APIs
>    DMA, CMA: support alignment constraint on CMA region
>    DMA, CMA: support arbitrary bitmap granularity
>    CMA: generalize CMA reserved area management functionality
>    PPC, KVM, CMA: use general CMA reserved area management framework
>    mm, CMA: clean-up CMA allocation error path
>    mm, CMA: change cma_declare_contiguous() to obey coding convention
>    mm, CMA: clean-up log message
>
>   arch/arm/mm/dma-mapping.c            |    1 +
>   arch/powerpc/kvm/book3s_64_mmu_hv.c  |    4 +-
>   arch/powerpc/kvm/book3s_hv_builtin.c |   19 +-
>   arch/powerpc/kvm/book3s_hv_cma.c     |  240 ------------------------
>   arch/powerpc/kvm/book3s_hv_cma.h     |   27 ---
>   drivers/base/Kconfig                 |   10 -
>   drivers/base/dma-contiguous.c        |  210 ++-------------------
>   include/linux/cma.h                  |   21 +++
>   include/linux/dma-contiguous.h       |   11 +-
>   mm/Kconfig                           |   11 ++
>   mm/Makefile                          |    1 +
>   mm/cma.c                             |  335 ++++++++++++++++++++++++++++++++++
>   12 files changed, 397 insertions(+), 493 deletions(-)
>   delete mode 100644 arch/powerpc/kvm/book3s_hv_cma.c
>   delete mode 100644 arch/powerpc/kvm/book3s_hv_cma.h
>   create mode 100644 include/linux/cma.h
>   create mode 100644 mm/cma.c
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
