Return-Path: <albert_herranz@yahoo.es>
Received: from smtp126.mail.ukl.yahoo.com (smtp126.mail.ukl.yahoo.com
	[77.238.184.57]) by ozlabs.org (Postfix) with SMTP id E7AF8B7D65
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 03:37:13 +1100 (EST)
Message-ID: <4B8A9BB2.3080202@yahoo.es>
Date: Sun, 28 Feb 2010 17:37:06 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2 4/9] add generic dmabounce support
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
	<1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
	<20100228142046.GA16745@n2100.arm.linux.org.uk>
In-Reply-To: <20100228142046.GA16745@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell King - ARM Linux wrote:
> On Sun, Feb 28, 2010 at 03:07:57PM +0100, Albert Herranz wrote:
>> This patch makes part of the ARM dmabounce code available to other
>> architectures as a generic API.
> 
> There is already a generic dma bounce implementation - it's called
> swiotlb - lib/swiotlb.c.  We should eventually switch the ARM
> dmabounce stuff over to that instead of keeping dmabounce around.
> 
> The only problem I forsee is that on ARM, we have devices which can
> only address the least significant N bits of RAM, but there may be
> an offset on the base address of RAM on the bus which isn't included
> in these N bits.
> 
> Even more fun is where we have a DMA controller which can address
> N bits of RAM, except for bit M which must be zero... (where N > M).
> 

In the Wii we have several limitations:
- it is a NOT_COHERENT_CACHE platform
- write accesses to coherent memory from the main processor must be done always in 32-bit chunks
- some devices can only reliably perform DMA to/from a specific region of memory (the second block of RAM, 64MB at 0x10000000, called MEM2)

So if swiotlb is the way to go I can try to adapt it to take into account these cases:
- it should allocate the io_tlb_start and io_tlb_overflow_buffer areas from MEM2 (add allocation/freeing hooks for these areas?)
- it should copy data from coherent memory in 32-bit chunks (add copy to/from coherent hooks?)
- it should decide to bounce buffers sitting in MEM1 (add a dma_needs_bounce() hook?)

Thanks,
Albert
