Return-Path: <akinobu.mita@gmail.com>
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F1D81A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 23:58:04 +1100 (AEDT)
Received: by mail-la0-f54.google.com with SMTP id hv19so572857lab.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 04:58:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
References: <20150120140200.aa7ba0eb28d95e456972e178@freescale.com>
 <20150120230150.GA14475@cloud>
 <20150120160738.edfe64806cc8b943beb1dfa0@linux-foundation.org>
Date: Wed, 21 Jan 2015 21:57:59 +0900
Message-ID: <CAC5umyieZn7ppXkKb45O=C=BF+iv6R_A1Dwfhro=cBJzFeovrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: fix undefined reference to `.kernel_map_pages' on
 PPC builds
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
 Rik van Riel <riel@redhat.com>, linux-mm@kvack.org, josh@joshtriplett.org,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
 Minchan Kim <minchan@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-01-21 9:07 GMT+09:00 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 20 Jan 2015 15:01:50 -0800 josh@joshtriplett.org wrote:
>
>> On Tue, Jan 20, 2015 at 02:02:00PM -0600, Kim Phillips wrote:
>> > It's possible to configure DEBUG_PAGEALLOC without PAGE_POISONING on
>> > ppc.  Fix building the generic kernel_map_pages() implementation in
>> > this case:
>> >
>> >   LD      init/built-in.o
>> > mm/built-in.o: In function `free_pages_prepare':
>> > mm/page_alloc.c:770: undefined reference to `.kernel_map_pages'
>> > mm/built-in.o: In function `prep_new_page':
>> > mm/page_alloc.c:933: undefined reference to `.kernel_map_pages'
>> > mm/built-in.o: In function `map_pages':
>> > mm/compaction.c:61: undefined reference to `.kernel_map_pages'
>> > make: *** [vmlinux] Error 1

kernel_map_pages() is static inline function since commit 031bc5743f15
("mm/debug-pagealloc: make debug-pagealloc boottime configurable").

But there is old declaration in 'arch/powerpc/include/asm/cacheflush.h'.
Removing it or changing s/kernel_map_pages/__kernel_map_pages/ in this
header file or something can fix this problem?

The architecture which has ARCH_SUPPORTS_DEBUG_PAGEALLOC
including PPC should not build mm/debug-pagealloc.o
