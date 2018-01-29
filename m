Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVK7f08wwzDqkl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 17:18:05 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0T6Fs6s023279
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 01:18:03 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fsueed8kh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 01:18:02 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 06:18:01 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] powerpc/mm: Remove intermediate bitmap copy in
 'slices'
In-Reply-To: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
References: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
Date: Mon, 29 Jan 2018 11:47:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3kh194d.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> bitmap_or() and bitmap_andnot() can work properly with dst identical
> to src1 or src2. There is no need of an intermediate result bitmap
> that is copied back to dst in a second step.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: New in v2
>  v3: patch moved up front of the serie to avoid ephemeral slice_bitmap_copy() function in following patch
>
>  arch/powerpc/mm/slice.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 23ec2c5e3b78..98b53d48968f 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -388,21 +388,17 @@ static unsigned long slice_find_area(struct mm_struct *mm, unsigned long len,
>  
>  static inline void slice_or_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> -
>  	dst->low_slices |= src->low_slices;
> -	bitmap_or(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	bitmap_or(dst->high_slices, dst->high_slices, src->high_slices,
> +		  SLICE_NUM_HIGH);
>  }
>  
>  static inline void slice_andnot_mask(struct slice_mask *dst, struct slice_mask *src)
>  {
> -	DECLARE_BITMAP(result, SLICE_NUM_HIGH);
> -
>  	dst->low_slices &= ~src->low_slices;
>  
> -	bitmap_andnot(result, dst->high_slices, src->high_slices, SLICE_NUM_HIGH);
> -	bitmap_copy(dst->high_slices, result, SLICE_NUM_HIGH);
> +	bitmap_andnot(dst->high_slices, dst->high_slices, src->high_slices,
> +		      SLICE_NUM_HIGH);
>  }
>  
>  #ifdef CONFIG_PPC_64K_PAGES
> -- 
> 2.13.3
