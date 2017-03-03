Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZYQX3PXFzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 02:44:36 +1100 (AEDT)
Date: Fri, 3 Mar 2017 16:44:30 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 09/10] powerpc/mm/slice: Move slice_mask struct
 definition to slice.c
Message-ID: <20170303164430.667291bc@kitsune.suse.cz>
In-Reply-To: <1487498837-12017-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Sun, 19 Feb 2017 15:37:16 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> This structure definition need not be in a header since this is used
> only by slice.c file. So move it to slice.c. This also allow us to
> use SLICE_NUM_HIGH instead of 512 and also helps in getting rid of
> one BUILD_BUG_ON().
> 
> I also switch the low_slices type to u64 from u16. This doesn't have
> an impact on size of struct due to padding added with u16 type. This
> helps in using bitmap printing function for printing slice mask.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/page_64.h | 11 -----------
>  arch/powerpc/mm/slice.c            | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/page_64.h
> b/arch/powerpc/include/asm/page_64.h index 9b60e9455c6e..3ecfc2734b50
> 100644 --- a/arch/powerpc/include/asm/page_64.h
> +++ b/arch/powerpc/include/asm/page_64.h
> @@ -99,17 +99,6 @@ extern u64 ppc64_pft_size;
>  #define GET_HIGH_SLICE_INDEX(addr)	((addr) >>
> SLICE_HIGH_SHIFT) 
>  #ifndef __ASSEMBLY__
> -/*
> - * One bit per slice. We have lower slices which cover 256MB segments
> - * upto 4G range. That gets us 16 low slices. For the rest we track
> slices
> - * in 1TB size.
> - * 64 below is actually SLICE_NUM_HIGH to fixup complie errros
> - */
> -struct slice_mask {
> -	u16 low_slices;
> -	DECLARE_BITMAP(high_slices, 512);
> -};
> -
>  struct mm_struct;
>  
>  extern unsigned long slice_get_unmapped_area(unsigned long addr,
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index fd2c85e951bd..8eedb7382942 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -37,7 +37,16 @@
>  #include <asm/hugetlb.h>
>  
>  static DEFINE_SPINLOCK(slice_convert_lock);
> -
> +/*
> + * One bit per slice. We have lower slices which cover 256MB segments
> + * upto 4G range. That gets us 16 low slices. For the rest we track
> slices
> + * in 1TB size.
> + * 64 below is actually SLICE_NUM_HIGH to fixup complie errros*
Please remove the above line which no longer applies for multiple
reasons.

Also consider swapping this and the previous patch.

Thanks

Michal
> + */
> +struct slice_mask {
> +	u64 low_slices;
> +	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
> +};
>  
>  #ifdef DEBUG
>  int _slice_debug = 1;
> @@ -412,8 +421,6 @@ unsigned long slice_get_unmapped_area(unsigned
> long addr, unsigned long len, struct mm_struct *mm = current->mm;
>  	unsigned long newaddr;
>  
> -	/* Make sure high_slices bitmap size is same as we expected
> */
> -	BUILD_BUG_ON(512 != SLICE_NUM_HIGH);
>  	/*
>  	 * init different masks
>  	 */
