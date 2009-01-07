Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BA0FDE44F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 16:27:37 +1100 (EST)
Message-Id: <165C7C29-C240-45DE-B2A1-DDD1E251384A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081229164035.GB8215@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/4] powerpc/32: Make clear_fixmap actually work
Date: Tue, 6 Jan 2009 23:25:27 -0600
References: <20081229164035.GB8215@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 29, 2008, at 10:40 AM, Anton Vorontsov wrote:

> The clear_fixmap() routine issues map_page() with flags set to 0.
> Currently this causes a BUG_ON() inside the map_page(), as it assumes
> that a PTE should be clear before mapping.
>
> This patch makes the map_page() to trigger the BUG_ON() only if the
> flags were set.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/mm/pgtable_32.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/ 
> pgtable_32.c
> index 3414724..23553a7 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -259,7 +259,8 @@ int map_page(unsigned long va, phys_addr_t pa,  
> int flags)
> 		/* The PTE should never be already set nor present in the
> 		 * hash table
> 		 */
> -		BUG_ON(pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE));
> +		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
> +		       flags);
> 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
> 						     __pgprot(flags)));
> 	}

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
