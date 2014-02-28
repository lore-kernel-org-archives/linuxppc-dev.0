Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A4502C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 22:32:01 +1100 (EST)
Date: Fri, 28 Feb 2014 12:31:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
Message-ID: <20140228113146.GJ27965@twins.programming.kicks-ass.net>
References: <1393578122-6500-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393578122-6500-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: Liu Ping Fan <pingfank@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 28, 2014 at 02:32:02PM +0530, Aneesh Kumar K.V wrote:
> From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> 
> When doing some numa tests on powerpc, I triggered an oops bug. I find
> it is caused by using page->_last_cpupid.  It should be initialized as
> "-1 & LAST_CPUPID_MASK", but not "-1". Otherwise, in task_numa_fault(),
> we will miss the checking (last_cpupid == (-1 & LAST_CPUPID_MASK)).
> And finally cause an oops bug in task_numa_group(), since the online cpu is
> less than possible cpu. This happen with CONFIG_SPARSE_VMEMMAP disabled
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


Acked-by: Peter Zijlstra <peterz@infradead.org>

> ---
>   
>  include/linux/mm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f28f46eade6a..86245839c9fa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -757,7 +757,7 @@ static inline bool __cpupid_match_pid(pid_t task_pid, int cpupid)
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>  static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
>  {
> -	return xchg(&page->_last_cpupid, cpupid);
> +	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
>  }
>  
>  static inline int page_cpupid_last(struct page *page)
> @@ -766,7 +766,7 @@ static inline int page_cpupid_last(struct page *page)
>  }
>  static inline void page_cpupid_reset_last(struct page *page)
>  {
> -	page->_last_cpupid = -1;
> +	page->_last_cpupid = -1 & LAST_CPUPID_MASK;
>  }
>  #else
>  static inline int page_cpupid_last(struct page *page)
> -- 
> 1.8.3.2
> 
