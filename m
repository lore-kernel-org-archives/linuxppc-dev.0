Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWDJg507KzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:43:31 +1000 (AEST)
Date: Mon, 14 Aug 2017 13:43:26 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 02/15] x86/mm: setting fields in deferred pages
Message-ID: <20170814114326.GH19063@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-3-git-send-email-pasha.tatashin@oracle.com>
 <20170811090214.GD30811@dhcp22.suse.cz>
 <b0422e38-a6da-081a-71c5-82a36dd2a5bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0422e38-a6da-081a-71c5-82a36dd2a5bb@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 11-08-17 11:39:41, Pasha Tatashin wrote:
> >AFAIU register_page_bootmem_info_node is only about struct pages backing
> >pgdat, usemap and memmap. Those should be in reserved memblocks and we
> >do not initialize those at later times, they are not relevant to the
> >deferred initialization as your changelog suggests so the ordering with
> >get_page_bootmem shouldn't matter. Or am I missing something here?
> 
> The pages for pgdata, usemap, and memmap are part of reserved, and thus
> getting initialized when free_all_bootmem() is called.
> 
> So, we have something like this in mem_init()
> 
> register_page_bootmem_info
>  register_page_bootmem_info_node
>   get_page_bootmem
>    .. setting fields here ..
>    such as: page->freelist = (void *)type;
> 
> free_all_bootmem()
>  free_low_memory_core_early()
>   for_each_reserved_mem_region()
>    reserve_bootmem_region()
>     init_reserved_page() <- Only if this is deferred reserved page
>      __init_single_pfn()
>       __init_single_page()
>           memset(0) <-- Loose the set fields here!

OK, I have missed that part. Please make it explicit in the changelog.
It is quite easy to get lost in the deep call chains.
-- 
Michal Hocko
SUSE Labs
