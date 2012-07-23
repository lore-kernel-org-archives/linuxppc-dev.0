Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05F6D2C0374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 02:18:27 +1000 (EST)
Message-ID: <500D7921.6060804@freescale.com>
Date: Mon, 23 Jul 2012 11:17:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>
In-Reply-To: <1343023569.2957.19.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Mingkai Hu <Mingkai.hu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2012 01:06 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2012-07-20 at 20:21 +0800, Shaohui Xie wrote:
>> PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so all the
>> memory will be put into this zone. If the memory size is greater than
>> the device's DMA capability and device uses dma_alloc_coherent to allocate
>> memory, it will get an address which is over the device's DMA addressing,
>> the device will fail.
>>
>> So we split the memory to two zones by adding a zone ZONE_NORMAL, since
>> we already allocate PCICSRBAR/PEXCSRBAR right below the 4G boundary (if the
>> lowest PCI address is above 4G), so we constrain the DMA zone ZONE_DMA
>> to 2GB, also, we clear the flag __GFP_DMA and set it only if the device's
>> dma_mask < total memory size. By doing this, devices which cannot DMA all
>> the memory will be limited to ZONE_DMA, but devices which can DMA all the
>> memory will not be affected by this limitation.
> 
> This is wrong.

How so?

> Don't you have an iommu do deal with those devices anyway ?

Yes, but we don't yet have DMA API support for it, it would lower
performance because we'd have to use a lot of subwindows which are
poorly cached (and even then we wouldn't be able to map more than 256
pages at once on a given device), and the IOMMU may not be available at
all if we're being virtualized.

> What about swiotlb ?

That doesn't help with alloc_coherent().

> If you *really* need to honor 32 (or 31 even) bit DMAs,

31-bit is to accommodate PCI, which has PEXCSRBAR that must live under 4
GiB and can't be disabled.

> what you -may- want to do is create a ZONE_DMA32 like other architectures, do not
> hijack the historical ZONE_DMA.

Could you point me to somewhere that clearly defines what ZONE_DMA is to
be used for, such that this counts as hijacking (but using ZONE_DMA32 to
mean 31-bit wouldn't)?  The only arches I see using ZONE_DMA32 (x86 and
mips) also have a separate, more restrictive ZONE_DMA.  PowerPC doesn't.
 It uses ZONE_DMA to point to all of memory (except highmem on 32-bit)
-- how is that not hijacking, if this is?  We can't have ZONE_DMA be
less restrictive than ZONE_DMA32, because the fallback rules are
hardcoded the other way around in generic code.

The exact threshold for ZONE_DMA could be made platform-configurable.

> But even then, I'm dubious this is really needed.

We'd like our drivers to stop crashing with more than 4GiB of RAM on 64-bit.

-Scott
