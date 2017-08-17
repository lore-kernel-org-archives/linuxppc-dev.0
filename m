Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY37W4nQnzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 20:56:55 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alex Williamson' <alex.williamson@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
CC: Jike Song <jike.song@intel.com>, Neo Jia <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Eric Auger
 <eric.auger@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Kyle Mahlkuch
 <Kyle.Mahlkuch@ibm.com>, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Yongji
 Xie <elohimes@gmail.com>, Kirti Wankhede <kwankhede@nvidia.com>, Mauricio
 Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>, Arvind Yadav
 <arvind.yadav.cs@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, David Woodhouse <dwmw2@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Thu, 17 Aug 2017 10:56:35 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0059144@AcuExch.aculab.com>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
 <ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
 <20170815103717.3b64e10c@w520.home>
 <1502843749.4493.67.camel@kernel.crashing.org>
 <20170816105602.57fd1dcc@w520.home>
In-Reply-To: <20170816105602.57fd1dcc@w520.home>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alex Williamson
> Sent: 16 August 2017 17:56
...
> Firmware pissing match...  Processors running with 8k or less page size
> fall within the recommendations of the PCI spec for register alignment
> of MMIO regions of the device and this whole problem becomes less of an
> issue.

Actually if qemu is causing the MSI-X table accesses to fault, why doesn't
it just lie to the guest about the physical address of the MSI-X table?
Then mmio access to anything in the same physical page will just work.

It has already been pointed out that you can't actually police the
interrupts that are raised without host hardware support.

Actually, putting other vectors in the MSI-X table is boring, most
drivers will ignore unexpected interrupts.
Much more interesting are physical memory addresses and accessible IO
addresses.
Of course, a lot of boards have PCI master capability and can probably
be persuaded to do writes to specific location anyway.

	David
