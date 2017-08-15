Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWhB41K8SzDqfg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 15:39:23 +1000 (AEST)
Message-ID: <1502775480.4493.45.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jike Song <jike.song@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex
 Williamson <alex.williamson@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Arvind Yadav
 <arvind.yadav.cs@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kirti
 Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira
 <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras
 <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Aug 2017 15:38:00 +1000
In-Reply-To: <599252B9.8030407@intel.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com> <59924B85.5040405@intel.com>
 <1502760820.4493.40.camel@kernel.crashing.org> <599252B9.8030407@intel.com>
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

On Tue, 2017-08-15 at 09:47 +0800, Jike Song wrote:
> On 08/15/2017 09:33 AM, Benjamin Herrenschmidt wrote:
> > On Tue, 2017-08-15 at 09:16 +0800, Jike Song wrote:
> > > > Taking a step back, though, why does vfio-pci perform this check in the
> > > > first place? If a malicious guest already has control of a device, any
> > > > kind of interrupt spoofing it could do by fiddling with the MSI-X
> > > > message address/data it could simply do with a DMA write anyway, so the
> > > > security argument doesn't stand up in general (sure, not all PCIe
> > > > devices may be capable of arbitrary DMA, but that seems like more of a
> > > > tenuous security-by-obscurity angle to me).
> > 
> > I tried to make that point for years, thanks for re-iterating it :-)
> > 
> > > Hi Robin,
> > > 
> > > DMA writes will be translated (thereby censored) by DMA Remapping hardware,
> > > while MSI/MSI-X will not. Is this different for non-x86?
> > 
> > There is no way your DMA remapping HW can differenciate. The only
> > difference between a DMA write and an MSI is ... the address. So if I
> > can make my device DMA to the MSI address range, I've defeated your
> > security.
> 
> I don't think with IRQ remapping enabled, you can make your device DMA to
> MSI address, without being treated as an IRQ and remapped. If so, the IRQ
> remapping hardware is simply broken :)

You are mixing things here.

Robin's point is that there is no security provided by the obfuscating
of the MSI-X table by qemu because whatever qemu does to "filter" the
MSI-X targer addresses can be worked around by making the device DMA
wherever you want.

None of what you say invalidates that basic fact.

Now, as far as your remapping HW goes, either it filters interrupts or
it doesn't. If it does then yes, it can't be spoofed, and thus you
don't need the filtering of the table in qemu.

If it doesn't, then the guest can spoof any interrupt using DMAs and
whatever qemu does to filter the table is not going to fix it.

Thus the point remains that the only value in qemu filtering the table
is to enable already insecure use cases to work, without actually
making them any more secure.

Ben.
