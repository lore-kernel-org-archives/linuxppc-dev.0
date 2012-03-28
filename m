Return-Path: <gxt@mprc.pku.edu.cn>
Received: from mprc.pku.edu.cn (mprc.pku.edu.cn [162.105.203.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C5CB9B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 14:34:56 +1100 (EST)
Message-ID: <4F7275FE.8000100@mprc.pku.edu.cn>
Date: Wed, 28 Mar 2012 10:22:54 +0800
From: Guan Xuetao <gxt@mprc.pku.edu.cn>
MIME-Version: 1.0
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Matt Turner <mattst88@gmail.com>,
 Dezhong Diao <dediao@cisco.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> index bfa9fbb..4cf5f0c 100644
> --- a/arch/unicore32/mm/dma-swiotlb.c
> +++ b/arch/unicore32/mm/dma-swiotlb.c
> @@ -17,9 +17,23 @@
>
>   #include<asm/dma.h>
>
> +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> +					    dma_addr_t *dma_handle, gfp_t flags,
> +					    struct dma_attrs *attrs)
> +{
> +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> +}
> +
> +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
The bit is ok for me. Only a typo here, please change unicode to unicore.

Thanks and Regards.

Guan Xuetao
