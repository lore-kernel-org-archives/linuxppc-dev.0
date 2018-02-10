Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdvnB3mVlzF0cb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 01:43:25 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so2419243pfw.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 06:43:25 -0800 (PST)
Date: Sun, 11 Feb 2018 00:43:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/5] powerpc/mm/slice: Remove intermediate bitmap copy
Message-ID: <20180211004309.2eda56a3@roar.ozlabs.ibm.com>
In-Reply-To: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
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

On Sat, 10 Feb 2018 13:54:25 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> bitmap_or() and bitmap_andnot() can work properly with dst identical
> to src1 or src2. There is no need of an intermediate result bitmap
> that is copied back to dst in a second step.

Everyone seems to be working on the slice code all of a sudden. I
had the same change in my series I just posted, but I didn't notice
this one of yours earlier, and it's better split out, so this is
fine by me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  v2: New in v2
>  v3: patch moved up front of the serie to avoid ephemeral slice_bitmap_copy() function in following patch
>  v4: No change
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
