Return-Path: <mpn@google.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020B21A02A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 21:38:20 +1000 (EST)
Received: by mail-wi0-f169.google.com with SMTP id hi2so562642wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 04:38:15 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 09/10] mm,
 cma: move output param to the end of param list
In-Reply-To: <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 13:38:11 +0200
Message-ID: <xa1twqcmicik.fsf@mina86.com>
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

On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> Conventionally, we put output param to the end of param list.
> cma_declare_contiguous() doesn't look like that, so change it.

Perhaps the function should be changed to return an error-pointer?

> Additionally, move down cma_areas reference code to the position
> where it is really needed.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

>
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book=
3s_hv_builtin.c
> index 28ec226..97613ea 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -184,7 +184,7 @@ void __init kvm_cma_reserve(void)
>=20=20
>  		align_size =3D max(kvm_rma_pages << PAGE_SHIFT, align_size);
>  		cma_declare_contiguous(selected_size, 0, 0, align_size,
> -			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, &kvm_cma, false);
> +			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, false, &kvm_cma);
>  	}
>  }
>=20=20
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index f177f73..bfd4553 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -149,7 +149,7 @@ int __init dma_contiguous_reserve_area(phys_addr_t si=
ze, phys_addr_t base,
>  {
>  	int ret;
>=20=20
> -	ret =3D cma_declare_contiguous(size, base, limit, 0, 0, res_cma, fixed);
> +	ret =3D cma_declare_contiguous(size, base, limit, 0, 0, fixed, res_cma);
>  	if (ret)
>  		return ret;
>=20=20
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index e38efe9..e53eead 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -6,7 +6,7 @@ struct cma;
>  extern int __init cma_declare_contiguous(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
>  				phys_addr_t alignment, int order_per_bit,
> -				struct cma **res_cma, bool fixed);
> +				bool fixed, struct cma **res_cma);
>  extern struct page *cma_alloc(struct cma *cma, int count, unsigned int a=
lign);
>  extern bool cma_release(struct cma *cma, struct page *pages, int count);
>  #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index 01a0713..22a5b23 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -142,8 +142,8 @@ core_initcall(cma_init_reserved_areas);
>   * @limit: End address of the reserved memory (optional, 0 for any).
>   * @alignment: Alignment for the contiguous memory area, should be power=
 of 2
>   * @order_per_bit: Order of pages represented by one bit on bitmap.
> - * @res_cma: Pointer to store the created cma region.
>   * @fixed: hint about where to place the reserved area
> + * @res_cma: Pointer to store the created cma region.
>   *
>   * This function reserves memory from early allocator. It should be
>   * called by arch specific code once the early allocator (memblock or bo=
otmem)
> @@ -156,9 +156,9 @@ core_initcall(cma_init_reserved_areas);
>  int __init cma_declare_contiguous(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
>  				phys_addr_t alignment, int order_per_bit,
> -				struct cma **res_cma, bool fixed)
> +				bool fixed, struct cma **res_cma)
>  {
> -	struct cma *cma =3D &cma_areas[cma_area_count];
> +	struct cma *cma;
>  	int ret =3D 0;
>=20=20
>  	pr_debug("%s(size %lx, base %08lx, limit %08lx alignment %08lx)\n",
> @@ -214,6 +214,7 @@ int __init cma_declare_contiguous(phys_addr_t size,
>  	 * Each reserved area must be initialised later, when more kernel
>  	 * subsystems (like slab allocator) are available.
>  	 */
> +	cma =3D &cma_areas[cma_area_count];
>  	cma->base_pfn =3D PFN_DOWN(base);
>  	cma->count =3D size >> PAGE_SHIFT;
>  	cma->order_per_bit =3D order_per_bit;
> --=20
> 1.7.9.5
>

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
