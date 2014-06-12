Return-Path: <mpn@google.com>
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com
 [IPv6:2a00:1450:400c:c05::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EECD1A03D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 20:20:02 +1000 (EST)
Received: by mail-wi0-f172.google.com with SMTP id hi2so7310898wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 03:19:58 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 05/10] DMA, CMA: support arbitrary bitmap granularity
In-Reply-To: <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-6-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 12:19:54 +0200
Message-ID: <xa1t61k6juph.fsf@mina86.com>
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
> ppc kvm's cma region management requires arbitrary bitmap granularity,
> since they want to reserve very large memory and manage this region
> with bitmap that one bit for several pages to reduce management overheads.
> So support arbitrary bitmap granularity for following generalization.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index bc4c171..9bc9340 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -38,6 +38,7 @@ struct cma {
>  	unsigned long	base_pfn;
>  	unsigned long	count;

Have you considered replacing count with maxno?

>  	unsigned long	*bitmap;
> +	int order_per_bit; /* Order of pages represented by one bit */

I'd make it unsigned.

>  	struct mutex	lock;
>  };
>=20=20
> +static void clear_cma_bitmap(struct cma *cma, unsigned long pfn, int
> count)

For consistency cma_clear_bitmap would make more sense I think.  On the
other hand, you're just moving stuff around so perhaps renaming the
function at this point is not worth it any more.

> +{
> +	unsigned long bitmapno, nr_bits;
> +
> +	bitmapno =3D (pfn - cma->base_pfn) >> cma->order_per_bit;
> +	nr_bits =3D cma_bitmap_pages_to_bits(cma, count);
> +
> +	mutex_lock(&cma->lock);
> +	bitmap_clear(cma->bitmap, bitmapno, nr_bits);
> +	mutex_unlock(&cma->lock);
> +}
> +
>  static int __init cma_activate_area(struct cma *cma)
>  {
> -	int bitmap_size =3D BITS_TO_LONGS(cma->count) * sizeof(long);
> +	int bitmap_maxno =3D cma_bitmap_maxno(cma);
> +	int bitmap_size =3D BITS_TO_LONGS(bitmap_maxno) * sizeof(long);
>  	unsigned long base_pfn =3D cma->base_pfn, pfn =3D base_pfn;
>  	unsigned i =3D cma->count >> pageblock_order;
>  	struct zone *zone;

bitmap_maxno is never used again, perhaps:

+	int bitmap_size =3D BITS_TO_LONGS(cma_bitmap_maxno(cma)) * sizeof(long);

instead? Up to you.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
