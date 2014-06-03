Return-Path: <mpn@google.com>
Received: from mail-wg0-x22b.google.com (mail-wg0-x22b.google.com
 [IPv6:2a00:1450:400c:c00::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F9E11A0837
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 16:56:12 +1000 (EST)
Received: by mail-wg0-f43.google.com with SMTP id l18so6249863wgh.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jun 2014 23:56:07 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 1/3] CMA: generalize CMA reserved area management
 functionality
In-Reply-To: <1401757919-30018-2-git-send-email-iamjoonsoo.kim@lge.com>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-2-git-send-email-iamjoonsoo.kim@lge.com>
Date: Tue, 03 Jun 2014 08:56:00 +0200
Message-ID: <xa1tzjhujxbz.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 03 2014, Joonsoo Kim wrote:
> Currently, there are two users on CMA functionality, one is the DMA
> subsystem and the other is the kvm on powerpc. They have their own code
> to manage CMA reserved area even if they looks really similar.
> From my guess, it is caused by some needs on bitmap management. Kvm side
> wants to maintain bitmap not for 1 page, but for more size. Eventually it
> use bitmap where one bit represents 64 pages.
>
> When I implement CMA related patches, I should change those two places
> to apply my change and it seem to be painful to me. I want to change
> this situation and reduce future code management overhead through
> this patch.
>
> This change could also help developer who want to use CMA in their
> new feature development, since they can use CMA easily without
> copying & pasting this reserved area management code.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Some small comments below, but in general

Acked-by: Michal Nazarewicz <mina86@mina86.com>

>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> new file mode 100644
> index 0000000..60ba06f
> --- /dev/null
> +++ b/include/linux/cma.h
> @@ -0,0 +1,28 @@
> +/*
> + * Contiguous Memory Allocator
> + *
> + * Copyright LG Electronics Inc., 2014
> + * Written by:
> + *	Joonsoo Kim <iamjoonsoo.kim@lge.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License or (at your optional) any later version of the license.
> + *

Superfluous empty comment line.

Also, I'm not certain whether this copyright notice is appropriate here,
but that's another story.

> + */
> +
> +#ifndef __CMA_H__
> +#define __CMA_H__
> +
> +struct cma;
> +
> +extern struct page *cma_alloc(struct cma *cma, unsigned long count,
> +				unsigned long align);
> +extern bool cma_release(struct cma *cma, struct page *pages,
> +				unsigned long count);
> +extern int __init cma_declare_contiguous(phys_addr_t size, phys_addr_t b=
ase,
> +				phys_addr_t limit, phys_addr_t alignment,
> +				unsigned long bitmap_shift, bool fixed,
> +				struct cma **res_cma);
> +#endif

> diff --git a/mm/cma.c b/mm/cma.c
> new file mode 100644
> index 0000000..0dae88d
> --- /dev/null
> +++ b/mm/cma.c
> @@ -0,0 +1,329 @@

> +static int __init cma_activate_area(struct cma *cma)
> +{
> +	int max_bitmapno =3D cma_bitmap_max_no(cma);
> +	int bitmap_size =3D BITS_TO_LONGS(max_bitmapno) * sizeof(long);
> +	unsigned long base_pfn =3D cma->base_pfn, pfn =3D base_pfn;
> +	unsigned i =3D cma->count >> pageblock_order;
> +	struct zone *zone;
> +
> +	pr_debug("%s()\n", __func__);
> +	if (!cma->count)
> +		return 0;

Alternatively:

+	if (!i)
+		return 0;

> +
> +	cma->bitmap =3D kzalloc(bitmap_size, GFP_KERNEL);
> +	if (!cma->bitmap)
> +		return -ENOMEM;
> +
> +	WARN_ON_ONCE(!pfn_valid(pfn));
> +	zone =3D page_zone(pfn_to_page(pfn));
> +
> +	do {
> +		unsigned j;
> +
> +		base_pfn =3D pfn;
> +		for (j =3D pageblock_nr_pages; j; --j, pfn++) {
> +			WARN_ON_ONCE(!pfn_valid(pfn));
> +			/*
> +			 * alloc_contig_range requires the pfn range
> +			 * specified to be in the same zone. Make this
> +			 * simple by forcing the entire CMA resv range
> +			 * to be in the same zone.
> +			 */
> +			if (page_zone(pfn_to_page(pfn)) !=3D zone)
> +				goto err;
> +		}
> +		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
> +	} while (--i);
> +
> +	mutex_init(&cma->lock);
> +	return 0;
> +
> +err:
> +	kfree(cma->bitmap);
> +	return -EINVAL;
> +}

> +static int __init cma_init_reserved_areas(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < cma_area_count; i++) {
> +		int ret =3D cma_activate_area(&cma_areas[i]);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

Or even:

static int __init cma_init_reserved_areas(void)
{
	int i, ret =3D 0;
	for (i =3D 0; !ret && i < cma_area_count; ++i)
		ret =3D cma_activate_area(&cma_areas[i]);
	return ret;
}

> +int __init cma_declare_contiguous(phys_addr_t size, phys_addr_t base,
> +				phys_addr_t limit, phys_addr_t alignment,
> +				unsigned long bitmap_shift, bool fixed,
> +				struct cma **res_cma)
> +{
> +	struct cma *cma =3D &cma_areas[cma_area_count];

Perhaps it would make sense to move this initialisation to the far end
of this function?

> +	int ret =3D 0;
> +
> +	pr_debug("%s(size %lx, base %08lx, limit %08lx, alignment %08lx)\n",
> +			__func__, (unsigned long)size, (unsigned long)base,
> +			(unsigned long)limit, (unsigned long)alignment);
> +
> +	/* Sanity checks */
> +	if (cma_area_count =3D=3D ARRAY_SIZE(cma_areas)) {
> +		pr_err("Not enough slots for CMA reserved regions!\n");
> +		return -ENOSPC;
> +	}
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	/*
> +	 * Sanitise input arguments.
> +	 * CMA area should be at least MAX_ORDER - 1 aligned. Otherwise,
> +	 * CMA area could be merged into other MIGRATE_TYPE by buddy mechanism
> +	 * and CMA property will be broken.
> +	 */
> +	alignment >>=3D PAGE_SHIFT;
> +	alignment =3D PAGE_SIZE << max3(MAX_ORDER - 1, pageblock_order,
> +						(int)alignment);
> +	base =3D ALIGN(base, alignment);
> +	size =3D ALIGN(size, alignment);
> +	limit &=3D ~(alignment - 1);
> +	/* size should be aligned with bitmap_shift */
> +	BUG_ON(!IS_ALIGNED(size >> PAGE_SHIFT, 1 << cma->bitmap_shift));

cma->bitmap_shift is not yet initialised thus the above line should be:

	BUG_ON(!IS_ALIGNED(size >> PAGE_SHIFT, 1 << bitmap_shift));

> +
> +	/* Reserve memory */
> +	if (base && fixed) {
> +		if (memblock_is_region_reserved(base, size) ||
> +		    memblock_reserve(base, size) < 0) {
> +			ret =3D -EBUSY;
> +			goto err;
> +		}
> +	} else {
> +		phys_addr_t addr =3D memblock_alloc_range(size, alignment, base,
> +							limit);
> +		if (!addr) {
> +			ret =3D -ENOMEM;
> +			goto err;
> +		} else {
> +			base =3D addr;
> +		}
> +	}
> +
> +	/*
> +	 * Each reserved area must be initialised later, when more kernel
> +	 * subsystems (like slab allocator) are available.
> +	 */
> +	cma->base_pfn =3D PFN_DOWN(base);
> +	cma->count =3D size >> PAGE_SHIFT;
> +	cma->bitmap_shift =3D bitmap_shift;
> +	*res_cma =3D cma;
> +	cma_area_count++;
> +
> +	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
> +		(unsigned long)base);

Doesn't this message end up being: =E2=80=9Ccma: CMA: reserved =E2=80=A6=E2=
=80=9D? pr_fmt adds
=E2=80=9Ccma:=E2=80=9D at the beginning, doesn't it?  So we should probably=
 drop =E2=80=9CCMA:=E2=80=9D
here.

> +
> +	return 0;
> +
> +err:
> +	pr_err("CMA: failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
> +	return ret;
> +}

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
