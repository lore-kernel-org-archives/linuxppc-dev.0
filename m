Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 15:09:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 10/26] powerpc: Decode the pte-lp-encoding bits
 correctly.
Message-ID: <20130313040959.GF21125@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1362550227-575-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 06, 2013 at 11:40:11AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We look at both the segment base page size and actual page size and store
> the pte-lp-encodings in an array per base page size.
> 
> We also update all relevant functions to take actual page size argument
> so that we can use the correct PTE LP encoding in HPTE. This should also
> get the basic Multiple Page Size per Segment (MPSS) support. This is needed
> to enable THP on ppc64.

[snip]

> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -154,7 +154,7 @@ extern unsigned long htab_hash_mask;
>  struct mmu_psize_def
>  {
>  	unsigned int	shift;	/* number of bits */
> -	unsigned int	penc;	/* HPTE encoding */
> +	unsigned int	penc[MMU_PAGE_COUNT];	/* HPTE encoding */

Since we are using -1 as an invalid flag, it would be better to change
penc[] to be an array of int (or signed int) rather than unsigned
int.  That would eliminate a few (signed int) casts in your subsequent
patches.

> +static inline int hpte_actual_psize(struct hash_pte *hptep, int psize)
> +{
> +	int i, shift;
> +	unsigned int mask;
> +	/* Look at the 8 bit LP value */
> +	unsigned int lp = (hptep->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
> +
> +	/* First check if it is large page */
> +	if (!(hptep->v & HPTE_V_LARGE))
> +		return MMU_PAGE_4K;
> +
> +	/* start from 1 ignoring MMU_PAGE_4K */
> +	for (i = 1; i < MMU_PAGE_COUNT; i++) {
> +		/* valid entries have a shift value */
> +		if (!mmu_psize_defs[i].shift)
> +			continue;
> +		/*
> +		 * encoding bits per actual page size
> +		 *        PTE LP     actual page size
> +		 *    rrrr rrrz		≥8KB
> +		 *    rrrr rrzz		≥16KB
> +		 *    rrrr rzzz		≥32KB
> +		 *    rrrr zzzz		≥64KB
> +		 * .......
> +		 */
> +		shift = mmu_psize_defs[i].shift -
> +				mmu_psize_defs[MMU_PAGE_4K].shift;

The memory reference for mmu_psize_defs[MMU_PAGE_4K].shift seems
unnecessary here.  Just use LP_SHIFT, same as when you calculated lp.

Paul.
