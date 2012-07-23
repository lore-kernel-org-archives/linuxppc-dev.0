Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 10:00:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 07/11] arch/powerpc: Increase the slice range to 64TB
Message-ID: <20120723000048.GG17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:37PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch makes the high psizes mask as an unsigned char array
> so that we can have more than 16TB. Currently we support upto
> 64TB

Some comments inline...

> @@ -804,16 +804,19 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
>  #ifdef CONFIG_PPC_MM_SLICES
>  unsigned int get_paca_psize(unsigned long addr)
>  {
> -	unsigned long index, slices;
> +	u64 lpsizes;
> +	unsigned char *hpsizes;
> +	unsigned long index, mask_index;
>  
>  	if (addr < SLICE_LOW_TOP) {
> -		slices = get_paca()->context.low_slices_psize;
> +		lpsizes = get_paca()->context.low_slices_psize;
>  		index = GET_LOW_SLICE_INDEX(addr);
> -	} else {
> -		slices = get_paca()->context.high_slices_psize;
> -		index = GET_HIGH_SLICE_INDEX(addr);
> +		return (lpsizes >> (index * 4)) & 0xF;
>  	}
> -	return (slices >> (index * 4)) & 0xF;
> +	hpsizes = get_paca()->context.high_slices_psize;
> +	index = GET_HIGH_SLICE_INDEX(addr) >> 1;
> +	mask_index = GET_HIGH_SLICE_INDEX(addr) - (index << 1);
> +	return (hpsizes[index] >> (mask_index * 4)) & 0xF;

The last 3 lines here feel awkward.  How about:

> +	index = GET_HIGH_SLICE_INDEX(addr);
> +	mask_index = index & 1;
> +	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xF;

>  static struct slice_mask slice_mask_for_size(struct mm_struct *mm, int psize)
>  {
> +	unsigned char *hpsizes;
> +	int index, mask_index;
>  	struct slice_mask ret = { 0, 0 };
>  	unsigned long i;
> -	u64 psizes;
> +	u64 lpsizes;
>  
> -	psizes = mm->context.low_slices_psize;
> +	lpsizes = mm->context.low_slices_psize;
>  	for (i = 0; i < SLICE_NUM_LOW; i++)
> -		if (((psizes >> (i * 4)) & 0xf) == psize)
> +		if (((lpsizes >> (i * 4)) & 0xf) == psize)
>  			ret.low_slices |= 1u << i;
>  
> -	psizes = mm->context.high_slices_psize;
> -	for (i = 0; i < SLICE_NUM_HIGH; i++)
> -		if (((psizes >> (i * 4)) & 0xf) == psize)
> +	hpsizes = mm->context.high_slices_psize;
> +	for (i = 0; i < SLICE_NUM_HIGH; i++) {
> +		index = i >> 1;
> +		mask_index = i - (index << 1);

Again, seems like a complicated way to do mask_index = i & 1 (or
even i % 2, if you prefer, but then make i an unsigned type).

Paul.
