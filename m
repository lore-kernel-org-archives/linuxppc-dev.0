Return-Path: <bob.picco@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDGMV3PKNzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 05:24:22 +1100 (AEDT)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9DIOHT3020401
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 18:24:19 GMT
Date: Fri, 13 Oct 2017 14:23:58 -0400
From: Bob Picco <bob.picco@oracle.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, akpm@linux-foundation.org,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v12 00/11] complete deferred page initialization
Message-ID: <20171013182358.GE17753@zareason>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171013173214.27300-1-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pavel Tatashin wrote:	[Fri Oct 13 2017, 01:32:03PM EDT]
> Changelog:
> v12 - v11
> - Improved comments for mm: zero reserved and unavailable struct pages
> - Added back patch: mm: deferred_init_memmap improvements
> - Added patch from Will Deacon: arm64: kasan: Avoid using
>   vmemmap_populate to initialise shadow
[...]
> Pavel Tatashin (10):
>   mm: deferred_init_memmap improvements
>   x86/mm: setting fields in deferred pages
>   sparc64/mm: setting fields in deferred pages
>   sparc64: simplify vmemmap_populate
>   mm: defining memblock_virt_alloc_try_nid_raw
>   mm: zero reserved and unavailable struct pages
>   x86/kasan: add and use kasan_map_populate()
>   arm64/kasan: add and use kasan_map_populate()
>   mm: stop zeroing memory during allocation in vmemmap
>   sparc64: optimized struct page zeroing
> 
> Will Deacon (1):
>   arm64: kasan: Avoid using vmemmap_populate to initialise shadow
> 
>  arch/arm64/Kconfig                  |   2 +-
>  arch/arm64/mm/kasan_init.c          | 130 +++++++++++++--------
>  arch/sparc/include/asm/pgtable_64.h |  30 +++++
>  arch/sparc/mm/init_64.c             |  32 +++---
>  arch/x86/mm/init_64.c               |  10 +-
>  arch/x86/mm/kasan_init_64.c         |  75 +++++++++++-
>  include/linux/bootmem.h             |  27 +++++
>  include/linux/memblock.h            |  16 +++
>  include/linux/mm.h                  |  26 +++++
>  mm/memblock.c                       |  60 ++++++++--
>  mm/page_alloc.c                     | 224 +++++++++++++++++++++---------------
>  mm/sparse-vmemmap.c                 |  15 ++-
>  mm/sparse.c                         |   6 +-
>  13 files changed, 469 insertions(+), 184 deletions(-)
> 
> -- 
> 2.14.2
> 
Boot tested on ThunderX2 VM.
Tested-by: Bob Picco <bob.picco@oracle.com>
