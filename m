Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 14:42:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 2/3] powerpc: Update kernel VSID range
Message-ID: <20130313034254.GC21125@iris.ozlabs.ibm.com>
References: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363090131-14545-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363090131-14545-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 12, 2013 at 05:38:50PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
> we have boot hangs on platforms that only support 65 bit VA.
> 
> With this patch we now have proto vsid generated as below:
> 
> We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
> from mmu context id and effective segment id of the address.
> 
> For user processes max context id is limited to ((1ul << 19) - 5)
> for kernel space, we use the top 4 context ids to map address as below
> 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Mostly looks OK, and it could go in as is, so

Acked-by: Paul Mackerras <paulus@samba.org>

Some minor comments below...

> + * For user processes max context id is limited to ((1ul << 19) - 6)

should be ((1ul << 19) - 5)

> + * a divide or extra multiply (see below). The scramble function gives
> + * robust scattering in the hash * table (at least based on some initial

                                    ^ superfluous *

> +	/*
> +	 * Calculate VSID:
> +	 * This is the kernel vsid, we take the top for context from
> +	 * the range. context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
> +	 * Here we know that (ea >> 60) == 0xc
> +	 */
> +	lis	r9,8
> +	subi	r9,r9,4		/* context */

Would be nice to do this as:

	lis	r9, (MAX_USER_CONTEXT+1)@ha
	addi	r9, r9, (MAX_USER_CONTEXT+1)@l

rather than having the hard-coded 8 and 4.

>  int __init_new_context(void)
>  {
>  	int index;
> @@ -56,7 +47,7 @@ again:
>  	else if (err)
>  		return err;
>  
> -	if (index > MAX_CONTEXT) {
> +	if (index > (MAX_USER_CONTEXT)) {

Unnecessary extra parentheses.

>  _GLOBAL(slb_allocate_realmode)
> -	/* r3 = faulting address */
> +	/*
> +	 * check for bad kernel/user address
> +	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
> +	 */
> +	rldicr. r9,r3,4,(63 - 46 - 4)
> +	bne-	8f
>  
>  	srdi	r9,r3,60		/* get region */
> -	srdi	r10,r3,28		/* get esid */
> +	srdi	r10,r3,SID_SHIFT	/* get esid */
>  	cmpldi	cr7,r9,0xc		/* cmp PAGE_OFFSET for later use */
>  
>  	/* r3 = address, r10 = esid, cr7 = <> PAGE_OFFSET */
> @@ -56,12 +61,13 @@ _GLOBAL(slb_allocate_realmode)
>  	 */
>  _GLOBAL(slb_miss_kernel_load_linear)
>  	li	r11,0
> -	li	r9,0x1
>  	/*
> -	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
> -	 * the necessary adjustment
> +	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
>  	 */
> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
> +	rldicl	r9,r3,4,62
> +	addis	r9,r9,8
> +	subi	r9,r9,4

You already have the region ID in r9, so you could do this in two
instructions like this:

	addis	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@ha
	addi	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@l

> +
>  BEGIN_FTR_SECTION
>  	b	slb_finish_load
>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
> @@ -91,24 +97,19 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>  	_GLOBAL(slb_miss_kernel_load_io)
>  	li	r11,0
>  6:
> -	li	r9,0x1
>  	/*
> -	 * for 1T we shift 12 bits more.  slb_finish_load_1T will do
> -	 * the necessary adjustment
> +	 * context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1
>  	 */
> -	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
> +	rldicl	r9,r3,4,62
> +	addis	r9,r9,8
> +	subi	r9,r9,4

If you did the context calculation earlier, before the "bne cr7,1f",
you could save 3 more instructions.

Paul.
