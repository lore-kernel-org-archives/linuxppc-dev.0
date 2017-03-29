Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtD8k4B7CzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 14:41:58 +1100 (AEDT)
Date: Wed, 29 Mar 2017 14:11:53 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 01/17] powerpc/mm/slice: Convert slice_mask high slice
 to a bitmap
Message-ID: <20170329031153.GA13844@fergus.ozlabs.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490153823-29241-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 22, 2017 at 09:06:47AM +0530, Aneesh Kumar K.V wrote:
> In followup patch we want to increase the va range which will result
> in us requiring high_slices to have more than 64 bits. To enable this
> convert high_slices to bitmap. We keep the number bits same in this patch
> and later change that to higher value

See comment below...

> @@ -531,8 +569,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	slice_print_mask(" mask", mask);
>  
>   convert:
> -	andnot_mask(mask, good_mask);
> -	andnot_mask(mask, compat_mask);
> +	slice_andnot_mask(&mask, &good_mask);
> +	slice_andnot_mask(&mask, &compat_mask);
>  	if (mask.low_slices || mask.high_slices) {

The test on mask.high_slices here wants to test whether high_slices
has any bits set, but with the conversion to a bitmap, the test will
be always true since what will be tested is the address of the array
in the bitmap.

Paul.
