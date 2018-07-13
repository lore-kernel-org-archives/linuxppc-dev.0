Return-Path: <js1304@gmail.com>
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RjZj218YzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 16:29:32 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id m1-v6so11176913wrg.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 23:29:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180712071536.GA15506@lst.de>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz>
 <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
 <20180711085407.GB20050@dhcp22.suse.cz>
 <CAAmzW4M3KADCZD9+B2h7=WsYksGtg-GzYRCJjbqK5Scceynrrg@mail.gmail.com>
 <20180712071536.GA15506@lst.de>
From: Joonsoo Kim <js1304@gmail.com>
Date: Fri, 13 Jul 2018 15:29:29 +0900
Message-ID: <CAAmzW4MNuZOZRP1fHt7E42Mm6+-CLkYYA1Ju2Cfe0ik4Ynb4Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
To: Christoph Hellwig <hch@lst.de>
Cc: Michal Hocko <mhocko@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Nazarewicz <mina86@mina86.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Zankel <chris@zankel.net>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 Laura Abbott <labbott@redhat.com>, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2018-07-12 16:15 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Thu, Jul 12, 2018 at 11:48:47AM +0900, Joonsoo Kim wrote:
>> One of existing user is general DMA layer and it takes gfp flags that is
>> provided by user. I don't check all the DMA allocation sites but how do
>> you convince that none of them try to use anything other
>> than GFP_KERNEL [|__GFP_NOWARN]?
>
> They use a few others things still like __GFP_COMP, __GPF_DMA or
> GFP_HUGEPAGE.  But all these are bogus as we have various implementations
> that can't respect them.  I plan to get rid of the gfp_t argument
> in the dma_map_ops alloc method in a few merge windows because of that,
> but it needs further implementation consolidation first.

Okay. If those flags are all, this change would be okay.

For the remind of this gfp flag introduction in cma_alloc(), see the
following link.

https://marc.info/?l=linux-mm&m=148431452118407

Thanks.
