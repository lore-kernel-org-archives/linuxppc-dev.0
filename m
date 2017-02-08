Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJHXV6NT3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 21:30:18 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 75so14848709pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 02:30:18 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 8 Feb 2017 16:00:10 +0530
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/5] powerpc/mm/slice: Convert slice_mask high slice
 to a bitmap
Message-ID: <20170208103010.GD17068@localhost.localdomain>
References: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486439333-22162-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486439333-22162-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 09:18:49AM +0530, Aneesh Kumar K.V wrote:
> In followup patch we want to increase the va range which will result
> in us requiring high_slices to have more than 64 bits. To enable this
> convert high_slices to bitmap. We keep the number bits same in this patch
> and later change that to larger value
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/page_64.h |  15 +++---
>  arch/powerpc/mm/slice.c            | 106 ++++++++++++++++++++++++-------------
>  2 files changed, 76 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
> index dd5f0712afa2..7f72659b7999 100644
> --- a/arch/powerpc/include/asm/page_64.h
> +++ b/arch/powerpc/include/asm/page_64.h
> @@ -98,19 +98,16 @@ extern u64 ppc64_pft_size;
>  #define GET_LOW_SLICE_INDEX(addr)	((addr) >> SLICE_LOW_SHIFT)
>  #define GET_HIGH_SLICE_INDEX(addr)	((addr) >> SLICE_HIGH_SHIFT)
>  
> +#ifndef __ASSEMBLY__
>  struct slice_mask {
>  	u16 low_slices;

Can we move low_slices as well, although we don't need it
it'll just make the code consistent.

> -	u64 high_slices;
> +	DECLARE_BITMAP(high_slices, 64);
>  };
>  
>  
>  static void slice_print_mask(const char *label, struct slice_mask mask)
>  {
> -	char	*p, buf[16 + 3 + 64 + 1];
> +	char	*p, buf[SLICE_NUM_LOW + 3 + SLICE_NUM_HIGH + 1];
>  	int	i;
>  
>  	if (!_slice_debug)
> @@ -60,8 +55,12 @@ static void slice_print_mask(const char *label, struct slice_mask mask)
>  	*(p++) = ' ';
>  	*(p++) = '-';
>  	*(p++) = ' ';
> -	for (i = 0; i < SLICE_NUM_HIGH; i++)
> -		*(p++) = (mask.high_slices & (1ul << i)) ? '1' : '0';
> +	for (i = 0; i < SLICE_NUM_HIGH; i++) {
> +		if (test_bit(i, mask.high_slices))
> +			*(p++) = '1';
> +		else
> +			*(p++) = '0';
> +	}

Can we move to using %*pbl or bitmap_print_to_pagebuf

>  	*(p++) = 0;
>  
>

Balbir Singh. 
