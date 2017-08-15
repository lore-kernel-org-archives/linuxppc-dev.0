Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWZlv53D9zDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 11:34:51 +1000 (AEST)
Message-ID: <1502760820.4493.40.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jike Song <jike.song@intel.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>, Eric Auger
 <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Alex
 Williamson <alex.williamson@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Arvind Yadav
 <arvind.yadav.cs@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kirti
 Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira
 <mauricfo@linux.vnet.ibm.com>, Neo Jia <cjia@nvidia.com>, Paul Mackerras
 <paulus@samba.org>, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Aug 2017 11:33:40 +1000
In-Reply-To: <59924B85.5040405@intel.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com> <59924B85.5040405@intel.com>
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

On Tue, 2017-08-15 at 09:16 +0800, Jike Song wrote:
> > Taking a step back, though, why does vfio-pci perform this check in the
> > first place? If a malicious guest already has control of a device, any
> > kind of interrupt spoofing it could do by fiddling with the MSI-X
> > message address/data it could simply do with a DMA write anyway, so the
> > security argument doesn't stand up in general (sure, not all PCIe
> > devices may be capable of arbitrary DMA, but that seems like more of a
> > tenuous security-by-obscurity angle to me).

I tried to make that point for years, thanks for re-iterating it :-)

> Hi Robin,
> 
> DMA writes will be translated (thereby censored) by DMA Remapping hardware,
> while MSI/MSI-X will not. Is this different for non-x86?

There is no way your DMA remapping HW can differenciate. The only
difference between a DMA write and an MSI is ... the address. So if I
can make my device DMA to the MSI address range, I've defeated your
security.

The table obfuscating in qemu is only useful as an insecure way of
"making things sort-of-work" for HW that doesnt have proper remapping
or filtering.

On pseries we don't have that problem because:

 1) Our hypervisor (which is qemu) provide the DMA address for MSIs/X
so there is no need for "magic remapping" to give the guest a value
that works.

 2) Our HW (configured by VFIO/KVM) filters which device can DMA to
what address (including which MSIs/X) thus even if the guest doesn't
use the address passed and messes around, it can only shoot itself in
the foot.

So all we need is a way to tell qemu to stop doing that filtering on
our platform. This is *one bit* of information, it's taken 3 years of
arguments and we still don't have a solution. In the meantime,
workloads *are* being hurt by significant performance degradation due
to the MSI-X table sharing a 64K page (our page size) with other MMIOs.

Yay !

Ben.
