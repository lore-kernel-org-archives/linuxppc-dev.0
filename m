Return-Path: <zhangyanfei@cn.fujitsu.com>
Received: from heian.cn.fujitsu.com (unknown [59.151.112.132])
 by lists.ozlabs.org (Postfix) with ESMTP id EF6791A02B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:30:55 +1000 (EST)
Message-ID: <53996544.2050401@cn.fujitsu.com>
Date: Thu, 12 Jun 2014 16:31:00 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 08/10] mm, cma: clean-up cma allocation error path
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1402543307-29800-9-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/2014 11:21 AM, Joonsoo Kim wrote:
> We can remove one call sites for clear_cma_bitmap() if we first
> call it before checking error number.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 1e1b017..01a0713 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -282,11 +282,12 @@ struct page *cma_alloc(struct cma *cma, int count, unsigned int align)
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
>  			break;
> -		} else if (ret != -EBUSY) {
> -			clear_cma_bitmap(cma, pfn, count);
> -			break;
>  		}
> +
>  		clear_cma_bitmap(cma, pfn, count);
> +		if (ret != -EBUSY)
> +			break;
> +
>  		pr_debug("%s(): memory range at %p is busy, retrying\n",
>  			 __func__, pfn_to_page(pfn));
>  		/* try again with a bit different memory target */
> 


-- 
Thanks.
Zhang Yanfei
