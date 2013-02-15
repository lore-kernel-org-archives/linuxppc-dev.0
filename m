Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Feb 2013 15:42:28 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] powerpc: Update kernel VSID range
Message-ID: <20130215044228.GE25015@drongo>
References: <a>
 <1360830983-1812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360830983-1812-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360830983-1812-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: phileas-fogg@mail.ru, linuxppc-dev@lists.ozlabs.org, geoff@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2013 at 02:06:21PM +0530, Aneesh Kumar K.V wrote:
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
> For user processes max context id is limited to ((1ul << 19) - 6)
> for kernel space, we use the top 4 context ids to map address as below
> 0x7fffb -  [ 0xc000000000000000 - 0xcfffffffffffffff ]

Actually, each context only gives us 64TB, so the range here would be
0xc000000000000000 - 0xc0003fffffffffff.  Similarly for the others.

> 0x7fffc -  [ 0xd000000000000000 - 0xdfffffffffffffff ]
> 0x7fffd -  [ 0xe000000000000000 - 0xefffffffffffffff ]
> 0x7fffe -  [ 0xf000000000000000 - 0xffffffffffffffff ]

We could increase all these context numbers by 1.  We have to avoid
the last ESID of the last context because of the modulo operation in
the vsid scramble, but the vmemmap (which is what uses region 0xf)
will never be close to 64TB in size (it's 56 bytes per page of system
memory).

[snip]
> +static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
> +{
> +	unsigned long context;
> +	/*
> +	 * kernel take the top 4 context from the available range
> +	 */

You should check the ea here, and if it is out of range (below 0xc...,
or with any of the 0x0fffc00000000000 bits set), return 0, which is
the reserved vsid.

> +	context = (MAX_CONTEXT - 4) +  ((ea >> 60) - 0xc);
> +	return get_vsid(context, ea, ssize);
> +}
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 4665e82..d8f6804 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1268,17 +1268,24 @@ do_ste_alloc:
>  _GLOBAL(do_stab_bolted)
>  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
>  	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
> +	mfspr	r11,SPRN_DAR			/* ea */
> +
> +	/*
> +	 * Calculate VSID:
> +	 * This is the kernel vsid, we take the top for context from
> +	 * the range. context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
> +	 */
> +	srdi	r9,r11,60
> +	subi	r9,r9,(0xc + 4 + 1)
> +	lis	r10,8
> +	add	r9,r9,r10		/* context */

At this point we know the top 4 bits of EA are 0xc, so the context is
a constant which we can load with 2 instructions.  We do also need to
check the middle bits (0x0fff_c000_0000_0000) and use a VSID of 0 if
any of them are set.

> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 1a16ca2..487f998 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -56,12 +56,19 @@ _GLOBAL(slb_allocate_realmode)
>  	 */
>  _GLOBAL(slb_miss_kernel_load_linear)
>  	li	r11,0
> -	li	r9,0x1
> +	/*
> +	 * context = (MAX_CONTEXT - 4) + ((ea >> 60) - 0xc)
> +	 */
> +	srdi	r9,r3,60
> +	subi	r9,r9,(0xc + 4 + 1)
> +	lis	r10, 8
> +	add	r9,r9,r10
> +	srdi	r10,r3,28 /* FIXME!! doing it twice */

Also need to check the middle bits here and for the 1T case.

Paul.
