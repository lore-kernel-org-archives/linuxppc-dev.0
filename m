Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64776B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:45:51 +1100 (EST)
Subject: Re: [RFC PATCH 03/11] ppc: Create ops to choose between direct
	window and iommu based on device mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20101011000903R.fujita.tomonori@lab.ntt.co.jp>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
	<1286559192-10898-4-git-send-email-nacc@us.ibm.com>
	<1286581493.2463.428.camel@pasglop>
	<20101011000903R.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Oct 2010 10:41:41 +1100
Message-ID: <1286754101.2463.515.camel@pasglop>
Mime-Version: 1.0
Cc: avorontsov@mvista.com, miltonm@bga.com, linux-kernel@vger.kernel.org,
	paulus@samba.org, scottwood@freescale.com, nacc@us.ibm.com,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-11 at 00:09 +0900, FUJITA Tomonori wrote:
> On Sat, 09 Oct 2010 10:44:53 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2010-10-08 at 10:33 -0700, Nishanth Aravamudan wrote:
> > > Also allow the coherent ops to be iommu if only the coherent mask is too
> > > small, mostly for driver that do not set set the coherent mask but also
> > > don't use the coherent api.
> > 
> > You are doing the transition at map_sg time which is a hot path, I don't
> > like that. Also you add all those "choose" variants of the dma ops...
> > not very nice at all.
> 
> Agreed, looks hacky.
> 
> 
> > You may want to look at the patches I posted to the list a while back
> > for doing direct DMA on Bimini:
> > 
> > [PATCH 1/2] powerpc/dma: Add optional platform override of dma_set_mask()
> 
> Would it be cleaner if each ppc dma_map_ops has the own set_dma_mask
> and dma_set_mask simply calls dma_map_ops->set_dma_mask?

I'm not sure I parse what you wrote above :-)

I did try with various methods back then, and what ended up sucking the
less was basically to hookup dma_set_mask() at the arch level.

In fact, it makes sense to the extent that the arch is the one that
knows that there are multiple regions configured potentially with
different capabilities.

You can still do the switch within the dma_ops->set_dma_mask if you want
I suppose, especially if you end up hitting different attribute regions
within a single bus or such but from my experience, it gets really hacky
with multiple ops structures etc...
> 
> > [PATCH 2/2] powerpc/dart_iommu: Support for 64-bit iommu bypass window on PCIe
> 

Cheers,
Ben.
