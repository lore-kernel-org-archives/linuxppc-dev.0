Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com
 [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1061A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 20:35:18 +1000 (AEST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Christoph Hellwig <hch@lst.de>, "torvalds@linux-foundation.org"
 <torvalds@linux-foundation.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "egtvedt@samfundet.no"
 <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>,
 "dhowells@redhat.com" <dhowells@redhat.com>, "monstr@monstr.eu"
 <monstr@monstr.eu>, "x86@kernel.org" <x86@kernel.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "grundler@parisc-linux.org"
 <grundler@parisc-linux.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org"
 <linux-alpha@vger.kernel.org>, "linux-ia64@vger.kernel.org"
 <linux-ia64@vger.kernel.org>, "linux-metag@vger.kernel.org"
 <linux-metag@vger.kernel.org>, "linux-mips@linux-mips.org"
 <linux-mips@linux-mips.org>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org"
 <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org"
 <linux-xtensa@linux-xtensa.org>, "linux-nvdimm@ml01.01.org"
 <linux-nvdimm@ml01.01.org>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>
Subject: Re: [PATCH 19/31] arc: handle page-less SG entries
Date: Wed, 12 Aug 2015 10:28:55 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B21F5@IN01WEMBXB.internal.synopsys.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
 <1439363150-8661-20-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 12 August 2015 12:39 PM, Christoph Hellwig wrote:=0A=
> Make all cache invalidation conditional on sg_has_page() and use=0A=
> sg_phys to get the physical address directly.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
With a minor nit below.=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
> ---=0A=
>  arch/arc/include/asm/dma-mapping.h | 26 +++++++++++++++++++-------=0A=
>  1 file changed, 19 insertions(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dm=
a-mapping.h=0A=
> index 2d28ba9..42eb526 100644=0A=
> --- a/arch/arc/include/asm/dma-mapping.h=0A=
> +++ b/arch/arc/include/asm/dma-mapping.h=0A=
> @@ -108,9 +108,13 @@ dma_map_sg(struct device *dev, struct scatterlist *s=
g,=0A=
>  	struct scatterlist *s;=0A=
>  	int i;=0A=
>  =0A=
> -	for_each_sg(sg, s, nents, i)=0A=
> -		s->dma_address =3D dma_map_page(dev, sg_page(s), s->offset,=0A=
> -					       s->length, dir);=0A=
> +	for_each_sg(sg, s, nents, i) {=0A=
> +		if (sg_has_page(s)) {=0A=
> +			_dma_cache_sync((unsigned long)sg_virt(s), s->length,=0A=
> +					dir);=0A=
> +		}=0A=
> +		s->dma_address =3D sg_phys(s);=0A=
> +	}=0A=
>  =0A=
>  	return nents;=0A=
>  }=0A=
> @@ -163,8 +167,12 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatt=
erlist *sglist, int nelems,=0A=
>  	int i;=0A=
>  	struct scatterlist *sg;=0A=
>  =0A=
> -	for_each_sg(sglist, sg, nelems, i)=0A=
> -		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);=0A=
> +	for_each_sg(sglist, sg, nelems, i) {=0A=
> +		if (sg_has_page(sg)) {=0A=
> +			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,=0A=
> +					dir);=0A=
> +		}=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  static inline void=0A=
> @@ -174,8 +182,12 @@ dma_sync_sg_for_device(struct device *dev, struct sc=
atterlist *sglist,=0A=
>  	int i;=0A=
>  	struct scatterlist *sg;=0A=
>  =0A=
> -	for_each_sg(sglist, sg, nelems, i)=0A=
> -		_dma_cache_sync((unsigned int)sg_virt(sg), sg->length, dir);=0A=
> +	for_each_sg(sglist, sg, nelems, i) {=0A=
> +		if (sg_has_page(sg)) {=0A=
> +			_dma_cache_sync((unsigned int)sg_virt(sg), sg->length,=0A=
> +				dir);=0A=
=0A=
For consistency, could u please fix the left alignment of @dir above - anot=
her tab=0A=
perhaps ?=0A=
=0A=
> +		}=0A=
> +	}=0A=
>  }=0A=
>  =0A=
>  static inline int dma_supported(struct device *dev, u64 dma_mask)=0A=
=0A=
