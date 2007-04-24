Return-Path: <olof@lixom.net>
Date: Tue, 24 Apr 2007 14:43:48 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH] 64K page support for kexec
Message-ID: <20070424194348.GA8371@lixom.net>
References: <1177439513.24866.5.camel@luke-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177439513.24866.5.camel@luke-laptop>
From: olof@lixom.net (Olof Johansson)
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Didn't see this posted before, but see some comments below.


Thanks,

Olof
On Tue, Apr 24, 2007 at 03:31:53PM -0300, Luke Browning wrote:

> +#define LP_SHIFT	12
> +#define LP_BITS		8
> +#define LP_MASK(i)	((((1 << LP_BITS) - 1) >> (i)) << LP_SHIFT)

Seems to me that something like:
#define LP_MASK(i)	((0xff >> (i)) << LP_SHIFT)

is considerably easier to read.

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

No ifdefs please. Just take it out if it's not needed.

> +	else if (!(hpte_r & LP_MASK(0)))
> +		size = MMU_PAGE_16M;
> +	else {
> +		for (i = 0; i < LP_BITS; i++) {
> +			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
> +				break;
> +		}
> +		penc = LP_MASK(i+1) >> LP_SHIFT;

No need for braces. Also, why iterate from 0 to LP_BITS if you're doing i+1 everywhere?

> +		for (size = MMU_PAGE_64K; size < MMU_PAGE_16M; size++) {

This assumes that the page sizes are ordered. Why not just iterate from
0 to MMU_PAGE_COUNT?

> +			if (!mmu_psize_defs[size].shift)
> +				continue;

A comment to the effect of "unused entries have a shift value of 0" could be
useful.

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

A BUG_ON() when other sizes are hit could be a good idea?

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

Same thing here w.r.t. ifdefs

>  
> -		va |= vpi << PAGE_SHIFT;
>  	}
> +#endif
>  
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

Using hpte_v as variable name is a bit misleading.  avpn or va would be
a better variable name.


-Olof
