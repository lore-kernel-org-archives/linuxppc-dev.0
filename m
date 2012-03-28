Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 8E928B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 17:10:48 +1100 (EST)
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1K00K62ZTXQD10@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 28 Mar 2012 07:10:45 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1K002VYZTSZH@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 28 Mar 2012 07:10:41 +0100 (BST)
Date: Wed, 28 Mar 2012 08:10:20 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
In-reply-to: <4F7275FE.8000100@mprc.pku.edu.cn>
To: 'Guan Xuetao' <gxt@mprc.pku.edu.cn>
Message-id: <00ac01cd0ca9$7508f4e0$5f1adea0$%szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
 <4F7275FE.8000100@mprc.pku.edu.cn>
Cc: linux-mips@linux-mips.org, 'Kevin Cernekee' <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 'Stephen Rothwell' <sfr@canb.auug.org.au>, 'Jonathan Corbet' <corbet@lwn.net>,
 x86@kernel.org, 'Matt Turner' <mattst88@gmail.com>,
 'Dezhong Diao' <dediao@cisco.com>, 'Fenghua Yu' <fenghua.yu@intel.com>,
 'Arnd Bergmann' <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, 'Ivan Kokshaysky' <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 'Thomas Gleixner' <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 'Richard Henderson' <rth@twiddle.net>, discuss@x86-64.org,
 'Michal Simek' <monstr@monstr.eu>, 'Tony Luck' <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, 'Richard Kuo' <rkuo@codeaurora.org>,
 'FUJITA Tomonori' <fujita.tomonori@lab.ntt.co.jp>,
 'Kyungmin Park' <kyungmin.park@samsung.com>,
 'Paul Mundt' <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 'Andrew Morton' <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "'David S. Miller'" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wednesday, March 28, 2012 4:23 AM Guan Xuetao wrote:

> On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> > diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> > index bfa9fbb..4cf5f0c 100644
> > --- a/arch/unicore32/mm/dma-swiotlb.c
> > +++ b/arch/unicore32/mm/dma-swiotlb.c
> > @@ -17,9 +17,23 @@
> >
> >   #include<asm/dma.h>
> >
> > +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle, gfp_t flags,
> > +					    struct dma_attrs *attrs)
> > +{
> > +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> > +}
> > +
> > +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
> The bit is ok for me. Only a typo here, please change unicode to unicore.

Ups, I'm sorry for that typo. I've fixed it on my git tree:

http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commitdiff;h=bbe43c05b0653
9c09f89e07bcaf61ea0fca8d67f

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
