Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt46Z1Sm2zDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:40:05 +1000 (AEST)
Message-ID: <1505360385.12628.187.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/powernv: Update comment about shifting
 IOV BAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <helgaas@kernel.org>, David
 Gibson <david@gibson.dropbear.id.au>, Alistair Popple
 <alistair@popple.id.au>, shan.gavin@gmail.com, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Russell Currey
 <ruscur@russell.cc>
Date: Thu, 14 Sep 2017 13:39:45 +1000
In-Reply-To: <18f3462e-09ee-ce02-f9c6-eafad68cb9c6@ozlabs.ru>
References: <20170831033412.1971-1-aik@ozlabs.ru>
 <0d7068aa-7331-0ce0-145d-8afe1e83a8ec@ozlabs.ru>
 <1505358454.12628.185.camel@kernel.crashing.org>
 <18f3462e-09ee-ce02-f9c6-eafad68cb9c6@ozlabs.ru>
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

On Thu, 2017-09-14 at 13:18 +1000, Alexey Kardashevskiy wrote:
> On 14/09/17 13:07, Benjamin Herrenschmidt wrote:
> > On Thu, 2017-09-14 at 12:45 +1000, Alexey Kardashevskiy wrote:
> > > On 31/08/17 13:34, Alexey Kardashevskiy wrote:
> > > > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > 
> > > Oops, this was not right :)
> > > 
> > > Anyway, Ben, please comment. Thanks.
> > 
> > This is incorrect, we can do hotplug behind switches afaik.
> 
> Do we have an actual system which allows this? 

Tuleta no ?

> Anyway, what we do now is
> wrong and it needs what? Reserve that hole? I'd like to update the comment
> for now, at least, and state what bad thing can happen and what we expect.

The hole should be reserved unless another SR-IOV device can use it ...

> 
> > > 
> > > > 
> > > > From: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > 
> > > > This updates the comment about creating a hole in /proc/iomem which
> > > > should not be normally happening but it does in the powernv platform
> > > > due the way MMIO M64 BARs are organised in the IODA2-capable hardware.
> > > > 
> > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > ---
> > > > 
> > > > It has been mentioned multiple times (last one -
> > > > https://www.spinics.net/lists/linux-pci/msg64084.html ) that the comment
> > > > is not informative enough for people not particularly familiar with
> > > > the POWER8 IO hardware.
> > > > 
> > > > This attempt aims to:
> > > > 1. explain why we shift the resource
> > > > 2. explain why nothing can use that hole as a resource while it is "free"
> > > > (I am not sure that this is the case actually)
> > > > 
> > > > Please comment, everyone, let's have this very well documented while
> > > > I remember these bits :) Thanks.
> > > > ---
> > > >  arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > index 48de308224d6..c4a36ae78c95 100644
> > > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > @@ -1002,9 +1002,13 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> > > >  	}
> > > >  
> > > >  	/*
> > > > -	 * After doing so, there would be a "hole" in the /proc/iomem when
> > > > -	 * offset is a positive value. It looks like the device return some
> > > > -	 * mmio back to the system, which actually no one could use it.
> > > > +	 * Since M64 BAR shares segments among all possible 256 PEs,
> > > > +	 * we have to shift the beginning of PF IOV BAR to make it start from
> > > > +	 * the segment which belongs to the PE number assigned to the first VF.
> > > > +	 * This creates a "hole" in the /proc/iomem which could be used for
> > > > +	 * allocating other resources, however this is not expected to happen
> > > > +	 * on IODA as the only possibility would be a PCI hotplug and IODA
> > > > +	 * hardware only allows it on a slot with dedicated PHB.
> > > >  	 */
> > > >  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> > > >  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> > > > 
> > > 
> > > 
> 
> 
