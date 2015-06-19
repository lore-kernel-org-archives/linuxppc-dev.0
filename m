Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B42C31A0551
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2015 09:02:29 +1000 (AEST)
Message-ID: <1434754913.27935.1.camel@kernel.crashing.org>
Subject: Re: powerpc/iommu: Support "hybrid" iommu/direct DMA ops for
 coherent_mask < dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 20 Jun 2015 09:01:53 +1000
In-Reply-To: <5584874D.2060402@linux.vnet.ibm.com>
References: <20150518064027.27A97140D18@ozlabs.org>
 <5584874D.2060402@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-06-19 at 16:19 -0500, Brian King wrote:
> On 05/18/2015 01:40 AM, Michael Ellerman wrote:
> > On Mon, 2015-18-05 at 03:56:51 UTC, Benjamin Herrenschmidt wrote:
> >> This patch adds the ability to the DMA direct ops to fallback to the IOMMU
> >> ops for coherent alloc/free if the coherent mask of the device isn't
> >> suitable for accessing the direct DMA space and the device also happens
> >> to have an active IOMMU table.
> > 
> > Can you do the removal of the union, the #ifdef PPC64 and the static inlines as
> > a precursor patch, that would remove some of the noise in the diff.
> > 
> > And can you explain the changes to dart, pseries and powernv.
> > 
> > There's also some whitespace changes in iommu.h that I assume you didn't want?
> 
> Hi Ben,
> 
> Do you plan to resubmit with these changes? The patch seems to work fine in
> my testing. Would be nice to get this merged.

Argh, completely forgot about it. I'll respin it next week.

> Thanks,
> 
> Brian
> 
