Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5kmB3vGSzDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 19:18:02 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alex Williamson' <alex.williamson@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>
CC: Yongji Xie <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "joro@8bytes.org" <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "alistair@popple.id.au" <alistair@popple.id.au>,
 "ruscur@russell.cc" <ruscur@russell.cc>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Date: Fri, 13 May 2016 09:16:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4BBEDD@AcuExch.aculab.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
 <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
 <20160505090513.56886c12@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F84EEBA@SHSMSX101.ccr.corp.intel.com>
 <20160511095331.18436241@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F850046@SHSMSX101.ccr.corp.intel.com>
 <20160511202042.77593861@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8507E8@SHSMSX101.ccr.corp.intel.com>
 <20160512114735.7ec61bd3@t450s.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F853FA4@SHSMSX101.ccr.corp.intel.com>
 <20160512233246.347b8b3c@t450s.home>
In-Reply-To: <20160512233246.347b8b3c@t450s.home>
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

From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: 13 May 2016 06:33
...
> Simply denying direct writes to the vector table or preventing mapping
> of the vector table into the user address space does not provide any
> tangible form of protection.  Many devices make use of window registers
> that allow backdoors to arbitrary device registers.  Some drivers even
> use this as the primary means for configuring MSI-X, which makes them
> incompatible with device assignment without device specific quirks to
> enable virtualization of these paths.

We have one fgpa based PCIe slave where the device driver has to read
the MSI-X table and then write the value to other fpga registers so
that the logic can generate the correct PCIe write cycle when an
interrupt is requested.
The MSI-X table itself is only as a PCIe slave.

We also have host accessible DMA controllers that the device driver
uses to copy data to kernel memory.
These could easily be used to generate arbitrary MSI-X requests.
As I've said earlier it is almost certainly possible to get any
ethernet hardware to perform something similar.

So without hardware that is able to limit the memory and MSI-X
that each PCIe endpoint can access I believe that if a virtualisation
system gives a guest kernel direct access to a PCIe devices it gives
the guest kernel the ability to raise and MSI-X interrupt and read/write
any physical memory.
(I've not looked at the cpu virtualisation support, but do know what
the PCIe devices can do.)

More interestingly, probably the 'worst' thing (from a security point of vi=
ew)
that changing the MSI-X table lets you do is a write to an arbitrary
physical memory address.

	David
