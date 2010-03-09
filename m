Return-Path: <albert_herranz@yahoo.es>
Received: from smtp124.mail.ukl.yahoo.com (smtp124.mail.ukl.yahoo.com
	[77.238.184.55]) by ozlabs.org (Postfix) with SMTP id DA6BCB7D13
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Mar 2010 05:07:32 +1100 (EST)
Message-ID: <4B968E5D.5060708@yahoo.es>
Date: Tue, 09 Mar 2010 19:07:25 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [LKML] [RFC PATCH v3 04/11] swiotlb: support	NOT_COHERENT_CACHE
	PowerPC platforms
References: <1267963912-984-1-git-send-email-albert_herranz@yahoo.es>
	<1267963912-984-5-git-send-email-albert_herranz@yahoo.es>
	<20100308165500.GB4568@phenom.dumpdata.com>
In-Reply-To: <20100308165500.GB4568@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: x86@kernel.org, linux-ia64@vger.kernel.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Konrad Rzeszutek Wilk wrote:
> Hey Albert,
> 
> I've been doing some posting in this area to split the physical / bus
> address translation so that multiple platforms can utilize it. I was
> wondering if it makes sense to utilize some of those concepts (ie, extend it
> for DMA coherency) for your code:
> 
> https://lists.linux-foundation.org/pipermail/iommu/2010-February/002066.html
> 
> And here is the git tree that goes on top of those patches:
> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb-2.6.git xen-swiotlb-0.5
> 

Hi Konrad,

Thanks for your comments.

In my case, I'd like to re-use as much code from swiotlb as possible.
Adding a few function calls at strategic spots (which are optimized out for cache coherent platforms) to maintain cache coherency is currently enough for me if that's acceptable.
A more general approach would involve making swiotlb_bounce() platform-dependent (or at least the actual code for copying the buffers), and re-implementing map_page, sync_single and map_sg at the platform DMA code again.

I've whipped through your patches. If I undestood them, you make available a kind of swiotlb "library" core on top of which you can build alternate swiotlb-based dma ops.
Wouldn't it be a good idea to split the "library" code from the default swiotlb dma ops?
A(n embedded) platform may just want the "library" code to implement its own dma ops, without having to pay for the extra default swiotlb dma ops implementation.

Thanks,
Albert
