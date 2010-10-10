Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from tama500.ecl.ntt.co.jp (tama500.ecl.ntt.co.jp [129.60.39.148])
	by ozlabs.org (Postfix) with ESMTP id 337FFB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 02:47:37 +1100 (EST)
To: benh@kernel.crashing.org
Subject: Re: [RFC PATCH 03/11] ppc: Create ops to choose between direct
	window and iommu based on device mask
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1286581493.2463.428.camel@pasglop>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
	<1286559192-10898-4-git-send-email-nacc@us.ibm.com>
	<1286581493.2463.428.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20101011000903R.fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 11 Oct 2010 00:09:03 +0900
Cc: avorontsov@mvista.com, miltonm@bga.com, linux-kernel@vger.kernel.org,
	fujita.tomonori@lab.ntt.co.jp, paulus@samba.org,
	scottwood@freescale.com, nacc@us.ibm.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 09 Oct 2010 10:44:53 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2010-10-08 at 10:33 -0700, Nishanth Aravamudan wrote:
> > Also allow the coherent ops to be iommu if only the coherent mask is too
> > small, mostly for driver that do not set set the coherent mask but also
> > don't use the coherent api.
> 
> You are doing the transition at map_sg time which is a hot path, I don't
> like that. Also you add all those "choose" variants of the dma ops...
> not very nice at all.

Agreed, looks hacky.


> You may want to look at the patches I posted to the list a while back
> for doing direct DMA on Bimini:
> 
> [PATCH 1/2] powerpc/dma: Add optional platform override of dma_set_mask()

Would it be cleaner if each ppc dma_map_ops has the own set_dma_mask
and dma_set_mask simply calls dma_map_ops->set_dma_mask?


> [PATCH 2/2] powerpc/dart_iommu: Support for 64-bit iommu bypass window on PCIe
