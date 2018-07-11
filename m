Return-Path: <js1304@gmail.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QW7m3BkDzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:35:31 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id c13-v6so17011271wrt.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 00:35:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710095056.GE14284@dhcp22.suse.cz>
References: <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709121956.20200-1-m.szyprowski@samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
 <CAAmzW4PPNYhUj_MeZox+ddq8MjXqnJs_AJ3xkayf710udD1pSg@mail.gmail.com>
 <20180710095056.GE14284@dhcp22.suse.cz>
From: Joonsoo Kim <js1304@gmail.com>
Date: Wed, 11 Jul 2018 16:35:28 +0900
Message-ID: <CAAmzW4P1m_T77DfQzDD6ysGaOF46++-0gwRaOajmo6ef=VYp=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
To: Michal Hocko <mhocko@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Michal Nazarewicz <mina86@mina86.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christoph Hellwig <hch@lst.de>,
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

2018-07-10 18:50 GMT+09:00 Michal Hocko <mhocko@kernel.org>:
> On Tue 10-07-18 16:19:32, Joonsoo Kim wrote:
>> Hello, Marek.
>>
>> 2018-07-09 21:19 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
>> > cma_alloc() function doesn't really support gfp flags other than
>> > __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
>>
>> Although gfp_mask isn't used in cma_alloc() except no_warn, it can be used
>> in alloc_contig_range(). For example, if passed gfp mask has no __GFP_FS,
>> compaction(isolation) would work differently. Do you have considered
>> such a case?
>
> Does any of cma_alloc users actually care about GFP_NO{FS,IO}?

I don't know. My guess is that cma_alloc() is used for DMA allocation so
block device would use it, too. If fs/block subsystem initiates the
request for the device,
it would be possible that cma_alloc() is called with such a flag.
Again, I don't know
much about those subsystem so I would be wrong.

Thanks.
