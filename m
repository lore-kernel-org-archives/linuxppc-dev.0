Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94CF82C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2013 09:33:49 +1000 (EST)
Message-ID: <1370648019.3766.439.camel@pasglop>
Subject: Re: FSL 64-bit DMA window question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 08 Jun 2013 09:33:39 +1000
In-Reply-To: <1370647771.6813.19@snotra>
References: <1370647771.6813.19@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-07 at 18:29 -0500, Scott Wood wrote:

> I just meant that a PCIe device targeting something other than RAM,  
> CCSR (it's not just MSIs that are mapped through the special window),  
> or another PCIe is a rather unusual case -- not something that you'd  
> see by just plugging in an ordinary PCIe card.  The tradeoff is that if  
> we accommodate this strange use case, boards like the radeon would need  
> to use swiotlb (once we fix the > versus >= bug) unless the user tweaks  
> the DMA window.

Yeah, well, swiotlb won't work for radeon anyway. It has its own
"mmu" (a GART really) and will constantly want to pin pages in it,
swiotlb will be at best a mess and at worst will just not work.

> It may be best to stick with the default that makes everything work,  
> even if a broken PCIe card ends up being a bit slower out of the box,  
> even if the PCIe-to-MMIO use case is weird and would require custom  
> setup anyway.  OTOH, did we ever care about 32-bit DMA being able to  
> access MMIO?

Not that I know of.

> Hmm... Why are we using this special window at all?  Can't we just have  
> one large identity mapping starting at zero, with the MSI window  
> presumably taking precedence? 

Then you'd have to reserve the RAM covered by the MSI window, not
necessarily a big deal. It would also still allow swiotlb to work, so it
actually doesn't seem like a bad idea if you don't have an actual /
usable iommu.

So if it works, I like that idea even better.

>  The manual is a bit vague on whether  
> inbound windows can overlap with priority... in EP mode it says it  
> does, and the RC section is silent.  Do we currently ever overlap  
> PCICSRBAR with a real window?

Cheers,
Ben.
