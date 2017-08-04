Return-Path: <sam@ravnborg.org>
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNwnb4YnpzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 15:43:15 +1000 (AEST)
Date: Fri, 4 Aug 2017 07:37:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org
Subject: Re: [v5 09/15] sparc64: optimized struct page zeroing
Message-ID: <20170804053701.GA30068@ravnborg.org>
References: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
 <1501795433-982645-10-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501795433-982645-10-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Pavel.

On Thu, Aug 03, 2017 at 05:23:47PM -0400, Pavel Tatashin wrote:
> Add an optimized mm_zero_struct_page(), so struct page's are zeroed without
> calling memset(). We do eight regular stores, thus avoid cost of membar.

The commit message does no longer reflect the implementation,
and should be updated.

> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 6fbd931f0570..be47537e84c5 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -230,6 +230,38 @@ extern unsigned long _PAGE_ALL_SZ_BITS;
>  extern struct page *mem_map_zero;
>  #define ZERO_PAGE(vaddr)	(mem_map_zero)
>  
> +/* This macro must be updated when the size of struct page grows above 80
> + * or reduces below 64.
> + * The idea that compiler optimizes out switch() statement, and only
> + * leaves clrx instructions or memset() call.
> + */
> +#define	mm_zero_struct_page(pp) do {					\
> +	unsigned long *_pp = (void *)(pp);				\
> +									\
> +	/* Check that struct page is 8-byte aligned */			\
> +	BUILD_BUG_ON(sizeof(struct page) & 7);				\
Would also be good to catch if sizeof > 80 so we do not silently
migrate to the suboptimal version (silent at build time).
Can you at build time catch if size is no any of: 64, 72, 80
and simplify the below a little?

	Sam
