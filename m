Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B21D1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 08:06:19 +1000 (EST)
Date: Thu, 17 Jul 2014 15:06:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] CMA: generalize CMA reserved area management
 functionality (fixup)
Message-Id: <20140717150615.32c48786b6bdbc880bdc5ed4@linux-foundation.org>
In-Reply-To: <1405589767-17513-1-git-send-email-m.szyprowski@samsung.com>
References: <53C78ED7.7030002@samsung.com>
 <1405589767-17513-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>,
 kvm@vger.kernel.org, linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Jul 2014 11:36:07 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> MAX_CMA_AREAS is used by other subsystems (i.e. arch/arm/mm/dma-mapping.c),
> so we need to provide correct definition even if CMA is disabled.
> This patch fixes this issue.
> 
> Reported-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/cma.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 9a18a2b1934c..c077635cad76 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -5,7 +5,11 @@
>   * There is always at least global CMA area and a few optional
>   * areas configured in kernel .config.
>   */
> +#ifdef CONFIG_CMA
>  #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
> +#else
> +#define MAX_CMA_AREAS	(0)
> +#endif
>  
>  struct cma;

Joonsoo already fixed this up, a bit differently:
http://ozlabs.org/~akpm/mmots/broken-out/cma-generalize-cma-reserved-area-management-functionality-fix.patch

Which approach makes more sense?



From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: CMA: fix ARM build failure related to MAX_CMA_AREAS definition

If CMA is disabled, CONFIG_CMA_AREAS isn't defined so compile error
happens. To fix it, define MAX_CMA_AREAS if CONFIG_CMA_AREAS
isn't defined.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/cma.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN include/linux/cma.h~cma-generalize-cma-reserved-area-management-functionality-fix include/linux/cma.h
--- a/include/linux/cma.h~cma-generalize-cma-reserved-area-management-functionality-fix
+++ a/include/linux/cma.h
@@ -5,8 +5,14 @@
  * There is always at least global CMA area and a few optional
  * areas configured in kernel .config.
  */
+#ifdef CONFIG_CMA_AREAS
 #define MAX_CMA_AREAS	(1 + CONFIG_CMA_AREAS)
 
+#else
+#define MAX_CMA_AREAS	(0)
+
+#endif
+
 struct cma;
 
 extern phys_addr_t cma_get_base(struct cma *cma);
_
