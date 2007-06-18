Return-Path: <pantelis.antoniou@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 5B3F2DDE1C
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 22:15:08 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so1370298ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 05:15:06 -0700 (PDT)
In-Reply-To: <46766C91.6090903@freescale.com>
References: <46766C91.6090903@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <03F6FDB0-3D7B-4272-AC1C-8E06F82DD815@gmail.com>
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] rheap: eliminates internal fragments caused by alignment
Date: Mon, 18 Jun 2007 15:14:42 +0300
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>, Paul <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Li,

The patch appears fine at first glance.

I'm really curious what kind of alignment do you use in order to have so
much wasted space that re-inserting the leftovers makes so much of a
difference.

-- Pantelis


On 18 =CE=99=CE=BF=CF=85=CE=BD 2007, at 2:29 =CE=9C=CE=9C, Li Yang =
wrote:

> The patch adds fragments caused by rh_alloc_align() back to free =20
> list, instead
> of allocating the whole chunk of memory.  This will greatly improve =20=

> memory
> utilization managed by rheap.
>
> It solves MURAM not enough problem with 3 UCCs enabled on MPC8323.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/lib/rheap.c |   48 ++++++++++++++++++++++++++=20
> +------------------
> 1 files changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> index 180ee29..2f24ea0 100644
> --- a/arch/powerpc/lib/rheap.c
> +++ b/arch/powerpc/lib/rheap.c
> @@ -437,27 +437,26 @@ unsigned long rh_alloc_align(rh_info_t * =20
> info, int size, int alignment, const ch
> 	struct list_head *l;
> 	rh_block_t *blk;
> 	rh_block_t *newblk;
> -	unsigned long start;
> +	unsigned long start, sp_size;
> 	/* Validate size, and alignment must be power of two */
> 	if (size <=3D 0 || (alignment & (alignment - 1)) !=3D 0)
> 		return (unsigned long) -EINVAL;
> -	/* given alignment larger that default rheap alignment */
> -	if (alignment > info->alignment)
> -		size +=3D alignment - 1;
> -
> 	/* Align to configured alignment */
> 	size =3D (size + (info->alignment - 1)) & ~(info->alignment - =
1);
> -	if (assure_empty(info, 1) < 0)
> +	if (assure_empty(info, 2) < 0)
> 		return (unsigned long) -ENOMEM;
> 	blk =3D NULL;
> 	list_for_each(l, &info->free_list) {
> 		blk =3D list_entry(l, rh_block_t, list);
> -		if (size <=3D blk->size)
> -			break;
> +		if (size <=3D blk->size) {
> +			start =3D (blk->start + alignment - 1) & =
~(alignment - 1);
> +			if (start + size <=3D blk->start + blk->size)
> +				break;
> +		}
> 		blk =3D NULL;
> 	}
> @@ -470,25 +469,36 @@ unsigned long rh_alloc_align(rh_info_t * =20
> info, int size, int alignment, const ch
> 		list_del(&blk->list);
> 		newblk =3D blk;
> 	} else {
> +		/* Fragment caused, split if needed */
> +		/* Create block for fragment in the beginning */
> +		sp_size =3D start - blk->start;
> +		if (sp_size) {
> +			rh_block_t *spblk;
> +
> +			spblk =3D get_slot(info);
> +			spblk->start =3D blk->start;
> +			spblk->size =3D sp_size;
> +			/* add before the blk */
> +			list_add(&spblk->list, blk->list.prev);
> +		}
> 		newblk =3D get_slot(info);
> -		newblk->start =3D blk->start;
> +		newblk->start =3D start;
> 		newblk->size =3D size;
> -		/* blk still in free list, with updated start, size */
> -		blk->start +=3D size;
> -		blk->size -=3D size;
> +		/* blk still in free list, with updated start and size
> +		 * for fragment in the end */
> +		blk->start =3D start + size;
> +		blk->size -=3D sp_size + size;
> +		/* No fragment in the end, remove blk */
> +		if (blk->size =3D=3D 0) {
> +			list_del(&blk->list);
> +			release_slot(info, blk);
> +		}
> 	}
> 	newblk->owner =3D owner;
> -	start =3D newblk->start;
> 	attach_taken_block(info, newblk);
> -	/* for larger alignment return fixed up pointer  */
> -	/* this is no problem with the deallocator since */
> -	/* we scan for pointers that lie in the blocks   */
> -	if (alignment > info->alignment)
> -		start =3D (start + alignment - 1) & ~(alignment - 1);
> -
> 	return start;
> }
>
