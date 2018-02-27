Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zr9822JlkzF1T8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 18:20:17 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1R7JmkL057450
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 02:20:15 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gd1xct2fu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 02:20:15 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 07:20:13 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 3/5] powerpc/mm/slice: implement
 slice_check_range_fits
In-Reply-To: <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <caa9d52e0a8ef15719bafe8002a4ad2dc359c634.1518382747.git.christophe.leroy@c-s.fr>
Date: Tue, 27 Feb 2018 12:50:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k1uy7vbr.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
 +	if ((start + len) > SLICE_LOW_TOP) {
> +		unsigned long start_index = GET_HIGH_SLICE_INDEX(start);
> +		unsigned long align_end = ALIGN(end, (1UL << SLICE_HIGH_SHIFT));
> +		unsigned long count = GET_HIGH_SLICE_INDEX(align_end) - start_index;
> +		unsigned long i;
>  
> -	slice_bitmap_and(result, mask->high_slices, available->high_slices,
> -			 slice_count);
> +		for (i = start_index; i < start_index + count; i++) {
> +			if (!test_bit(i, available->high_slices))
> +				return false;
> +		}
> +	}

why not bitmap_equal here instead of test_bit in loop?
>  
> -	return (mask->low_slices & available->low_slices) == mask->low_slices &&
> -		slice_bitmap_equal(result, mask->high_slices, slice_count);
> +	return true;
>  }

-aneesh
