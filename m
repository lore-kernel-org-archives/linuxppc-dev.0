Return-Path: <paulus@ozlabs.org>
Date: Wed, 1 Aug 2012 14:31:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 11/13] arch/powerpc: properly isolate kernel and user
 proto-VSID
Message-ID: <20120801043147.GA24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343647339-25576-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2012 at 04:52:17PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> The proto-VSID space is divided into two class
> User:   0 to 2^(CONTEXT_BITS + USER_ESID_BITS) -1
> kernel: 2^(CONTEXT_BITS + USER_ESID_BITS) to 2^(VSID_BITS) - 1
> 
> With KERNEL_START at 0xc000000000000000, the proto vsid for
> the kernel ends up with 0xc00000000 (36 bits). With 64TB
> patchset we need to have kernel proto-VSID in the
> [2^37 to 2^38 - 1] range due to the increased USER_ESID_BITS.

This needs to be rolled in with the previous patch, otherwise you'll
break bisection.

> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index db2cb3f..405d380 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -57,8 +57,16 @@ _GLOBAL(slb_allocate_realmode)
>  _GLOBAL(slb_miss_kernel_load_linear)
>  	li	r11,0
>  BEGIN_FTR_SECTION
> +	li	r9,0x1
> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>  	b	slb_finish_load
>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
> +	li	r9,0x1
> +	/*
> +	 * shift 12 bits less here, slb_finish_load_1T will do
> +	 * the necessary shits
> +	 */
> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>  	b	slb_finish_load_1T

Since you're actually doing exactly the same instructions in the 256M
and 1T segment cases, why not do the li; rldimi before the
BEGIN_FTR_SECTION?

> @@ -86,8 +94,16 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
>  	li	r11,0
>  6:
>  BEGIN_FTR_SECTION
> +	li	r9,0x1
> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>  	b	slb_finish_load
>  END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
> +	li	r9,0x1
> +	/*
> +	 * shift 12 bits less here, slb_finish_load_1T will do
> +	 * the necessary shits
> +	 */
> +	rldimi  r10,r9,(CONTEXT_BITS + USER_ESID_BITS),0
>  	b	slb_finish_load_1T

And similarly here.

Paul.
