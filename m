Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36689B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 17:06:37 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 799AFDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 17:06:36 +1000 (EST)
Subject: Re: [PATCH 3/3] agp/uninorth: Unify U3 and pre-U3 insert_memory
	and remove_memory hooks.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
In-Reply-To: <1249422665-24437-3-git-send-email-michel@daenzer.net>
References: <1249422665-24437-1-git-send-email-michel@daenzer.net>
	<1249422665-24437-3-git-send-email-michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Aug 2009 17:05:48 +1000
Message-Id: <1250147148.3587.115.camel@pasglop>
Mime-Version: 1.0
Cc: Dave Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-04 at 23:51 +0200, Michel Dänzer wrote:
> From: Michel Dänzer <daenzer@vmware.com>
> 
> Signed-off-by: Michel Dänzer <daenzer@vmware.com>
> ---

Hi Michel !

While your two previous patches apply just fine, this one doesn't,
the uninorth_insert_memory() function seems to be slightly different
upstream. Does this depend on some separate yet unapplied patches ?

I'm putting 1/3 and 2/3 into my -test branch and they should hit my
-next branch in a couple of days.

Or do you prefer us to merge that via Dave ?

The thing is, stuff in -powerpc is much more likely to get some amount
of testing on actual ppc hardware than stuff in random other trees :-)

Cheers,
Ben.

>  drivers/char/agp/uninorth-agp.c |   64 +++++++--------------------------------
>  1 files changed, 11 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
> index bc8b43a..75aa33a 100644
> --- a/drivers/char/agp/uninorth-agp.c
> +++ b/drivers/char/agp/uninorth-agp.c
> @@ -144,53 +144,7 @@ static int uninorth_configure(void)
>  	return 0;
>  }
>  
> -static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start,
> -				int type)
> -{
> -	int i, j, num_entries;
> -	void *temp;
> -	int mask_type;
> -
> -	if (type != mem->type)
> -		return -EINVAL;
> -
> -	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
> -	if (mask_type != 0) {
> -		/* We know nothing of memory types */
> -		return -EINVAL;
> -	}
> -
> -	if (mem->page_count == 0)
> -		return 0;
> -
> -	temp = agp_bridge->current_size;
> -	num_entries = A_SIZE_32(temp)->num_entries;
> -
> -	if ((pg_start + mem->page_count) > num_entries)
> -		return -EINVAL;
> -
> -	j = pg_start;
> -
> -	while (j < (pg_start + mem->page_count)) {
> -		if (agp_bridge->gatt_table[j])
> -			return -EBUSY;
> -		j++;
> -	}
> -
> -	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
> -		agp_bridge->gatt_table[j] =
> -			cpu_to_le32((page_to_phys(mem->pages[i]) & 0xFFFFF000UL) | 0x1UL);
> -		flush_dcache_range((unsigned long)__va(page_to_phys(mem->pages[i])),
> -				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
> -	}
> -	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
> -	mb();
> -
> -	uninorth_tlbflush(mem);
> -	return 0;
> -}
> -
> -static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
> +static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
>  {
>  	int i, num_entries;
>  	void *temp;
> @@ -219,14 +173,18 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
>  	for (i = 0; i < mem->page_count; ++i) {
>  		if (gp[i]) {
>  			dev_info(&agp_bridge->dev->dev,
> -				 "u3_insert_memory: entry 0x%x occupied (%x)\n",
> +				 "uninorth_insert_memory: entry 0x%x occupied (%x)\n",
>  				 i, gp[i]);
>  			return -EBUSY;
>  		}
>  	}
>  
>  	for (i = 0; i < mem->page_count; i++) {
> -		gp[i] = (page_to_phys(mem->pages[i]) >> PAGE_SHIFT) | 0x80000000UL;
> +		if (is_u3)
> +			gp[i] = (page_to_phys(mem->pages[i]) >> PAGE_SHIFT) | 0x80000000UL;
> +		else
> +			gp[i] =	cpu_to_le32((page_to_phys(mem->pages[i]) & 0xFFFFF000UL) |
> +					    0x1UL);
>  		flush_dcache_range((unsigned long)__va(page_to_phys(mem->pages[i])),
>  				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
>  	}
> @@ -236,7 +194,7 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
>  	return 0;
>  }
>  
> -int u3_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
> +int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
>  {
>  	size_t i;
>  	u32 *gp;
> @@ -551,7 +509,7 @@ const struct agp_bridge_driver uninorth_agp_driver = {
>  	.create_gatt_table	= uninorth_create_gatt_table,
>  	.free_gatt_table	= uninorth_free_gatt_table,
>  	.insert_memory		= uninorth_insert_memory,
> -	.remove_memory		= agp_generic_remove_memory,
> +	.remove_memory		= uninorth_remove_memory,
>  	.alloc_by_type		= agp_generic_alloc_by_type,
>  	.free_by_type		= agp_generic_free_by_type,
>  	.agp_alloc_page		= agp_generic_alloc_page,
> @@ -577,8 +535,8 @@ const struct agp_bridge_driver u3_agp_driver = {
>  	.agp_enable		= uninorth_agp_enable,
>  	.create_gatt_table	= uninorth_create_gatt_table,
>  	.free_gatt_table	= uninorth_free_gatt_table,
> -	.insert_memory		= u3_insert_memory,
> -	.remove_memory		= u3_remove_memory,
> +	.insert_memory		= uninorth_insert_memory,
> +	.remove_memory		= uninorth_remove_memory,
>  	.alloc_by_type		= agp_generic_alloc_by_type,
>  	.free_by_type		= agp_generic_free_by_type,
>  	.agp_alloc_page		= agp_generic_alloc_page,
> -- 
> 1.6.3.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
