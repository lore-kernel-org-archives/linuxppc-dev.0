Return-Path: <olof@lixom.net>
Date: Thu, 26 Apr 2007 02:15:32 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: 64K page support for kexec
Message-ID: <20070426071532.GA24937@lixom.net>
References: <1177439513.24866.5.camel@luke-laptop>
	<20070424194348.GA8371@lixom.net>
	<1177455014.14873.144.camel@localhost.localdomain>
	<1177529739.24866.34.camel@luke-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177529739.24866.34.camel@luke-laptop>
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
                                                                                                                                             
Two comments below, besides that it looks good!
                                                                                                                                             
On Wed, Apr 25, 2007 at 04:35:39PM -0300, Luke Browning wrote:

> +#define LP_SHIFT	12
> +#define LP_BITS		8
> +#define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
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
> +	else {
> +		for (i = 0; i < LP_BITS; i++) {
> +			if ((hpte_r & LP_MASK(i+1)) == LP_MASK(i+1))
> +				break;
> +		}
> +		penc = LP_MASK(i+1) >> LP_SHIFT;
> +		for (size = 0; size < MMU_PAGE_COUNT - 1; size++) {

This will never consider the last page size. Either <= MMU_PAGE_COUNT-1
or < MMU_PAGE_COUNT. The latter would be more natural.

> -		pteg = slot / HPTES_PER_GROUP;
> -		if (hpte_v & HPTE_V_SECONDARY)
> -			pteg = ~pteg;
> +			/* 4K pages are not represented by LP */
> +			if (size == MMU_PAGE_4K)
> +				continue;
> +
> +			/* valid entries have a shift value */
> +			if (!mmu_psize_defs[size].shift)
> +				continue;
>  
> -		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
> +			if (penc == mmu_psize_defs[size].penc)
> +				break;
> +		}
> +	}
>  
> -		va |= vpi << PAGE_SHIFT;
> +	/*
> +	 * FIXME, the code below works for 16M, 64K, and 4K pages as these
> +	 * fall under the p<=23 rules for calculating the virtual address.
> +	 * In the case of 16M pages, an extra bit is stolen from the AVPN
> +	 * field to achieve the requisite 24 bits. 
> +	 *
> +	 * 16G pages are not supported by the code below.
> +	 */
> +	BUG_ON(hpte_v & 0x4000000000000000UL);		/* 1T segment */
> +	BUG_ON(size == MMU_PAGE_16G);
> +	BUG_ON(size == MMU_PAGE_64K_AP);

Milton didn't like BUG_ON() here, and I think I agree after hearing his
motivations. I know I was the one suggesting them, but they're better
to keep out at the moment.

[...]



Thanks,

-Olof
