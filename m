Return-Path: <mpn@google.com>
Received: from mail-we0-x230.google.com (mail-we0-x230.google.com
 [IPv6:2a00:1450:400c:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B5731A0339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 19:47:24 +1000 (EST)
Received: by mail-we0-f176.google.com with SMTP id u56so966468wes.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 02:47:19 -0700 (PDT)
Sender: Michal Nazarewicz <mpn@google.com>
From: Michal Nazarewicz <mina86@mina86.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 02/10] DMA, CMA: fix possible memory leak
In-Reply-To: <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-3-git-send-email-iamjoonsoo.kim@lge.com>
Date: Thu, 12 Jun 2014 11:47:16 +0200
Message-ID: <xa1tha3qjw7v.fsf@mina86.com>
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
> We should free memory for bitmap when we find zone mis-match,
> otherwise this memory will leak.
>
> Additionally, I copy code comment from ppc kvm's cma code to notify
> why we need to check zone mis-match.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Michal Nazarewicz <mina86@mina86.com>

> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index bd0bb81..fb0cdce 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -177,14 +177,24 @@ static int __init cma_activate_area(struct cma *cma)
>  		base_pfn =3D pfn;
>  		for (j =3D pageblock_nr_pages; j; --j, pfn++) {
>  			WARN_ON_ONCE(!pfn_valid(pfn));
> +			/*
> +			 * alloc_contig_range requires the pfn range
> +			 * specified to be in the same zone. Make this
> +			 * simple by forcing the entire CMA resv range
> +			 * to be in the same zone.
> +			 */
>  			if (page_zone(pfn_to_page(pfn)) !=3D zone)
> -				return -EINVAL;
> +				goto err;
>  		}
>  		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
>  	} while (--i);
>=20=20
>  	mutex_init(&cma->lock);
>  	return 0;
> +
> +err:
> +	kfree(cma->bitmap);
> +	return -EINVAL;
>  }

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
