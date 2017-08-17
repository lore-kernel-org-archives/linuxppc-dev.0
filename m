Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYGQD2rplzDqfw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 05:25:24 +1000 (AEST)
Date: Thu, 17 Aug 2017 13:25:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jike Song
 <jike.song@intel.com>, Neo Jia <cjia@nvidia.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Eric Auger <eric.auger@redhat.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>, Vlad
 Tsyrklevich <vlad@tsyrklevich.net>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, Yongji Xie <elohimes@gmail.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Mauricio Faria de Oliveira
 <mauricfo@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, David
 Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Message-ID: <20170817132514.49051ba0@w520.home>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0059144@AcuExch.aculab.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
 <20170815103717.3b64e10c@w520.home>
 <1502843749.4493.67.camel@kernel.crashing.org>
 <20170816105602.57fd1dcc@w520.home>
 <063D6719AE5E284EB5DD2968C1650D6DD0059144@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Aug 2017 10:56:35 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Alex Williamson
> > Sent: 16 August 2017 17:56  
> ...
> > Firmware pissing match...  Processors running with 8k or less page size
> > fall within the recommendations of the PCI spec for register alignment
> > of MMIO regions of the device and this whole problem becomes less of an
> > issue.  
> 
> Actually if qemu is causing the MSI-X table accesses to fault, why doesn't
> it just lie to the guest about the physical address of the MSI-X table?
> Then mmio access to anything in the same physical page will just work.

That's an interesting idea, but now you need to add a BAR for the
virtualized vector table, but you'll also need to support extending a
BAR because there won't necessarily be a BAR available to add.  Of
course PCI requires natural alignment of BARs, thus an extra few bytes
on the end doubles the BAR size.  So also hope that if we need to
extend a BAR that there's a relatively small one available.  In either
case you're changing the layout of the device from what the driver might
expect.  We try pretty hard with device assignment to leave things in
the same place as they appear on bare metal, perhaps removing things,
but not actually moving things.  It might work in the majority of
cases, but it seems a bit precarious overall.  Thanks,

Alex
