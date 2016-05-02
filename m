Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qz1xx6KhQzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 21:18:13 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 May 2016 21:18:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 12C3D2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 21:18:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42BI2M755902324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 21:18:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u42BHbud030854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 21:17:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ebru Akagunduz <ebru.akagunduz@gmail.com>, Rik van Riel <riel@redhat.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
In-Reply-To: <20160502183234.1dad8115@canb.auug.org.au>
References: <20160502183234.1dad8115@canb.auug.org.au>
Date: Mon, 02 May 2016 16:47:10 +0530
Message-ID: <87h9egzp3d.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Andrew,
>
> After merging the akpm-current tree, today's linux-next build (powerpc
> allyesconfig and pseries_le_defconfig) failed like this:
>
> In file included from include/linux/mm.h:394:0,
>                  from mm/huge_memory.c:10:
> include/linux/huge_mm.h:53:22: error: initializer element is not constant
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                       ^
> mm/huge_memory.c:104:62: note: in expansion of macro 'HPAGE_PMD_NR'
>  static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
>                                                               ^
>
> Caused by commit
>
>   6d34b9749be2 ("mm: make optimistic check for swapin readahead")
>
> interacting with commit
>
>   dd1842a2a448 ("powerpc/mm: Make page table size a variable")
>
> from the powerpc tree.
>
> I applied this fix patch for today (hopefully this is still initialised
> early enough):
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 2 May 2016 18:25:42 +1000
> Subject: [PATCH] mm: make optimistic check for swapin readahead fix
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  mm/huge_memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f0cd9dbc1157..6aabfa166b6d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -101,7 +101,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
>   * fault.
>   */
>  static unsigned int khugepaged_max_ptes_none __read_mostly;
> -static unsigned int khugepaged_max_ptes_swap __read_mostly = HPAGE_PMD_NR/8;
> +static unsigned int khugepaged_max_ptes_swap __read_mostly;
>  static unsigned long allocstall;
>
>  static int khugepaged(void *none);
> @@ -703,6 +703,7 @@ static int __init hugepage_init(void)
>
>  	khugepaged_pages_to_scan = HPAGE_PMD_NR * 8;
>  	khugepaged_max_ptes_none = HPAGE_PMD_NR - 1;
> +	khugepaged_max_ptes_swap = HPAGE_PMD_NR / 8;
>  	/*
>  	 * hugepages can't be allocated by the buddy allocator
>  	 */
> -- 
> 2.7.0
>
>
>
>
> -- 
> Cheers,
> Stephen Rothwell
