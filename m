Return-Path: <mpn@google.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26CC11A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 20:02:46 +1000 (EST)
Received: by mail-wi0-f181.google.com with SMTP id n3so2645154wiv.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 03:02:42 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 04/10] DMA,
 CMA: support alignment constraint on cma region
In-Reply-To: <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 12:02:38 +0200
Message-ID: <xa1t8up2jvi9.fsf@mina86.com>
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
> ppc kvm's cma area management needs alignment constraint on

I've noticed it earlier and cannot seem to get to terms with this.  It
should IMO be PPC, KVM and CMA since those are acronyms.  But if you
have strong feelings, it's not a big issue.

> cma region. So support it to prepare generalization of cma area
> management functionality.
>
> Additionally, add some comments which tell us why alignment
> constraint is needed on cma region.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 8a44c82..bc4c171 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -219,6 +220,7 @@ core_initcall(cma_init_reserved_areas);
>   * @size: Size of the reserved area (in bytes),
>   * @base: Base address of the reserved area optional, use 0 for any
>   * @limit: End address of the reserved memory (optional, 0 for any).
> + * @alignment: Alignment for the contiguous memory area, should be
>  	power of 2

=E2=80=9Cmust be power of 2 or zero=E2=80=9D.

>   * @res_cma: Pointer to store the created cma region.
>   * @fixed: hint about where to place the reserved area
>   *
> @@ -233,15 +235,15 @@ core_initcall(cma_init_reserved_areas);
>   */
>  static int __init __dma_contiguous_reserve_area(phys_addr_t size,
>  				phys_addr_t base, phys_addr_t limit,
> +				phys_addr_t alignment,
>  				struct cma **res_cma, bool fixed)
>  {
>  	struct cma *cma =3D &cma_areas[cma_area_count];
> -	phys_addr_t alignment;
>  	int ret =3D 0;
>=20=20
> -	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
> -		 (unsigned long)size, (unsigned long)base,
> -		 (unsigned long)limit);
> +	pr_debug("%s(size %lx, base %08lx, limit %08lx align_order %08lx)\n",
> +		__func__, (unsigned long)size, (unsigned long)base,
> +		(unsigned long)limit, (unsigned long)alignment);

Nit: Align with the rest of the arguments, i.e.:

+	pr_debug("%s(size %lx, base %08lx, limit %08lx align_order %08lx)\n",
+		 __func__, (unsigned long)size, (unsigned long)base,
+		 (unsigned long)limit, (unsigned long)alignment);

>=20=20
>  	/* Sanity checks */
>  	if (cma_area_count =3D=3D ARRAY_SIZE(cma_areas)) {

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
