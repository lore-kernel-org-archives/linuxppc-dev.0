Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMsqZ4vQCzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 17:25:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] powerpc/mm/slice: Move slice_mask struct
 definition to slice.c
In-Reply-To: <1486988642-25000-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486988642-25000-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 17:25:45 +1100
Message-ID: <87mvdpmgpi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index b3f45e413a60..08ac27eae408 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -37,7 +37,16 @@
>  #include <asm/hugetlb.h>
>  
>  static DEFINE_SPINLOCK(slice_convert_lock);
> -
> +/*
> + * One bit per slice. We have lower slices which cover 256MB segments
> + * upto 4G range. That gets us 16 low slices. For the rest we track slices
> + * in 1TB size.

Can we tighten this comment up a bit.

What about:

> + * One bit per slice. The low slices cover the range 0 - 4GB, each
>   * slice being 256MB in size, for 16 low slices. The high slices
>   * cover the rest of the address space at 1TB granularity, with the
>   * exception of high slice 0 which covers the range 4GB - 1TB.

OK?

> + * 64 below is actually SLICE_NUM_HIGH to fixup complie errros

That line is bogus AFAICS, it refers to the old hardcoded value (prior
to 512), I'll drop it.

> + */
> +struct slice_mask {
> +	u64 low_slices;
> +	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
> +};


cheers
