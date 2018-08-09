Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m7hd3VflzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 10:01:37 +1000 (AEST)
Message-ID: <f7daffa5481ab82f345aa5bf9f63f40caa068456.camel@kernel.crashing.org>
Subject: Re: [PATCH 08/20] powerpc/dma: remove the unused dma_nommu_ops export
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 09 Aug 2018 10:01:16 +1000
In-Reply-To: <20180731121625.GA29793@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-9-hch@lst.de> <20180731121625.GA29793@lst.de>
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

On Tue, 2018-07-31 at 14:16 +0200, Christoph Hellwig wrote:
> It turns out cxl actually uses it.  So for now skip this patch,
> although random code in drivers messing with dma ops will need to
> be sorted out sooner or later.

CXL devices are "special", they bypass the classic iommu in favor of
allowing the device to operate using the main processor page tables
using an MMU context (so basically the device can use userspace
addresses directly), akin to ATS.

I think the code currently uses the nommu ops as a way to do a simple
kernel mapping for kernel drivers using CXL (not userspace stuff)
though.

Ben.
