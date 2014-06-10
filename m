Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo04.lge.com (lgeamrelo04.lge.com [156.147.1.127])
 by lists.ozlabs.org (Postfix) with ESMTP id E94B81A0865
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 12:45:21 +1000 (EST)
Date: Tue, 10 Jun 2014 11:49:11 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [RFC PATCH 2/3] DMA, CMA: use general CMA reserved area
 management framework
Message-ID: <20140610024910.GB19036@js1304-P5Q-DELUXE>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1twqcyjx3z.fsf@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <xa1twqcyjx3z.fsf@mina86.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
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

On Tue, Jun 03, 2014 at 09:00:48AM +0200, Michal Nazarewicz wrote:
> On Tue, Jun 03 2014, Joonsoo Kim wrote:
> > Now, we have general CMA reserved area management framework,
> > so use it for future maintainabilty. There is no functional change.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> > diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> > index dfb1dc9..ecb85ac 100644
> > --- a/include/linux/dma-contiguous.h
> > +++ b/include/linux/dma-contiguous.h
> > @@ -53,9 +53,10 @@
> >  
> >  #ifdef __KERNEL__
> >  
> > +#include <linux/device.h>
> > +
> 
> Why is this suddenly required?
> 
> >  struct cma;
> >  struct page;
> > -struct device;
> >  
> >  #ifdef CONFIG_DMA_CMA
> 

Without including device.h, build failure occurs.
In dma-contiguous.h, we try to access to dev->cma_area, so we need
device.h. In the past, we included it luckily by swap.h in
drivers/base/dma-contiguous.c. Swap.h includes node.h and then node.h
includes device.h, so we were happy. But, in this patch, I remove
'include <linux/swap.h>' so we need to include device.h explicitly.

Thanks.
