Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luke Browning <lukebr@linux.vnet.ibm.com>
In-Reply-To: <1177439513.24866.5.camel@luke-laptop>
References: <1177439513.24866.5.camel@luke-laptop>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 08:48:14 +1000
Message-Id: <1177454894.14873.142.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Getting better :-)

Sorry for the constant nagging, let's say I'm a bit perfectionist...

> -static unsigned long slot2va(unsigned long hpte_v, unsigned long slot)
> -{
> -	unsigned long avpn = HPTE_V_AVPN_VAL(hpte_v);
> -	unsigned long va;
> -
> -	va = avpn << 23;
> -
> -	if (! (hpte_v & HPTE_V_LARGE)) {
> -		unsigned long vpi, pteg;
> -
> -		pteg = slot / HPTES_PER_GROUP;
> -		if (hpte_v & HPTE_V_SECONDARY)
> -			pteg = ~pteg;

Hrm... hpte_decode ends up being a pretty big function... I suppose
that's ok.

> +#define LP_SHIFT	12
> +#define LP_BITS		8
> +#define LP_MASK(i)	((((1 << LP_BITS) - 1) >> (i)) << LP_SHIFT)
> +
> +static void hpte_decode(hpte_t *hpte, unsigned long slot, 
> +			int *psize, unsigned long *va)
> +{
> +	unsigned long hpte_r = hpte->r;
> +	unsigned long hpte_v = hpte->v;
> +	unsigned long avpn;
> +	int i, size, shift, penc, avpnm_bits;
> +		
> +	if (!(hpte_v & HPTE_V_LARGE))
> +		size = MMU_PAGE_4K;
> +#if 0
> +	else if (hpte_v & 0x4000000000000000UL)
> +		size = MMU_PAGE_16G;
> +#endif

Remove the above. I don't think it's right anyway. We'll deal with 16G
pages when we start using them.

> +	else if (!(hpte_r & LP_MASK(0)))
> +		size = MMU_PAGE_16M;

Is that correct ? (The above). I haven't quite noticed in the previous
instances of the patch, sorry about that but I don't think that's the
way to detect the "old style" 16M pages... I -suspect- that the normal
algorithm will work for them, that is, they'll have a penc of 0 which
will match what's in the mmu_psize_defs[MMU_PAGE_16M] but it's worth
actually testing it.

Now that I think about it, it's possible that I lead you on the wrong
track there initially... Sorry about that.

I think your above code will treat anything with a penc of 0 as a 16M
page, which might be true with current implementations, is also, I
think, not mandated by the arch, is it ? (I don't have my 2.03 at hand
as I'm writing this email).

> +	else {
> +		for (i = 0; i < LP_BITS; i++) {
> +			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
> +				break;
> +		}
> +		penc = LP_MASK(i+1) >> LP_SHIFT;
> +		for (size = MMU_PAGE_64K; size < MMU_PAGE_16M; size++) {
> +			if (!mmu_psize_defs[size].shift)
> +				continue;
> +			if (penc == mmu_psize_defs[size].penc)
> +				break;
> +		}
> +	}
>  
> -		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
> +	/*
> +	 * FIXME, this could be made more efficient by storing the type 
> +	 * of hash algorithm in mmu_psize_defs[].  The code below assumes 
> +	 * the number of bits in the va representing the offset in the
> +	 * page is less than 23. This affects the hash algorithm that is
> +	 * used. When 16G pages are supported, a new hash algorithm
> +	 * needs to be provided.  See POWER ISA Book III.
> +	 *
> +	 * The code below works for 16M, 64K, and 4K pages.
> +	 */

I'm not 100% certain about your comment. The by type of hash algorithm
you mean the segment size right ? This is not directly related to the
page size. While 1T segments are mandatory for 16G pages, they can also
hold normal page sizes... If we're going to implement support for 1T
segment, we should get the segment size (and thus the hash algorithm)
from the B bit of the PTE.

In fact, when doing 1T segments, we'll have to deal with them regardless
of the page size (the hashing will be different for all page sizes).

> +	shift = mmu_psize_defs[size].shift;
> +	if (mmu_psize_defs[size].avpnm)
> +		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
> +	else
> +		avpnm_bits = 0;
> +	if (shift - avpnm_bits <= 23) {
> +		avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
> +
> +		if (shift < 23) {
> +			unsigned long vpi, pteg;
> +
> +			pteg = slot / HPTES_PER_GROUP;
> +			if (hpte_v & HPTE_V_SECONDARY)
> +				pteg = ~pteg;
> +			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
> +			avpn |= (vpi << mmu_psize_defs[size].shift);
> +		}
> +	}
> +#if 0
> +	/* 16GB page hash, p > 23 */
> +	else {
>  
> -		va |= vpi << PAGE_SHIFT;
>  	}
> +#endif

Just don't keep the code in #if 0, just a comment about something
needing to be done for 16G ...

> -	return va;
> +	*va = avpn;
> +	*psize = size;
>  }
>  
>  /*
> @@ -374,8 +420,6 @@ static unsigned long slot2va(unsigned lo
>   *
>   * TODO: add batching support when enabled.  remember, no dynamic memory here,
>   * athough there is the control page available...
> - *
> - * XXX FIXME: 4k only for now !
>   */
>  static void native_hpte_clear(void)
>  {
> @@ -383,6 +427,7 @@ static void native_hpte_clear(void)
>  	hpte_t *hptep = htab_address;
>  	unsigned long hpte_v;
>  	unsigned long pteg_count;
> +	int psize;
>  
>  	pteg_count = htab_hash_mask + 1;
>  
> @@ -408,8 +453,9 @@ static void native_hpte_clear(void)
>  		 * already hold the native_tlbie_lock.
>  		 */
>  		if (hpte_v & HPTE_V_VALID) {
> +			hpte_decode(hptep, slot, &psize, &hpte_v);
>  			hptep->v = 0;
> -			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
> +			__tlbie(hpte_v, psize);
>  		}
>  	}
>  
> 
