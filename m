Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1dF62MpxzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 02:55:22 +1000 (AEST)
Date: Fri, 6 May 2016 10:54:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Yongji Xie
 <xyjxie@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "joro@8bytes.org"
 <joro@8bytes.org>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "zhong@linux.vnet.ibm.com"
 <zhong@linux.vnet.ibm.com>, "nikunj@linux.vnet.ibm.com"
 <nikunj@linux.vnet.ibm.com>, "eric.auger@linaro.org"
 <eric.auger@linaro.org>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "alistair@popple.id.au" <alistair@popple.id.au>, "ruscur@russell.cc"
 <ruscur@russell.cc>
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
Message-ID: <20160506105458.1c1efc7a@t450s.home>
In-Reply-To: <fa5555df-b8d2-70ea-e9af-81336c431a67@ozlabs.ru>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
 <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
 <20160505090513.56886c12@t450s.home>
 <fa5555df-b8d2-70ea-e9af-81336c431a67@ozlabs.ru>
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

On Fri, 6 May 2016 16:35:38 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 05/06/2016 01:05 AM, Alex Williamson wrote:
> > On Thu, 5 May 2016 12:15:46 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >  
> >>> From: Yongji Xie [mailto:xyjxie@linux.vnet.ibm.com]
> >>> Sent: Thursday, May 05, 2016 7:43 PM
> >>>
> >>> Hi David and Kevin,
> >>>
> >>> On 2016/5/5 17:54, David Laight wrote:
> >>>  
> >>>> From: Tian, Kevin  
> >>>>> Sent: 05 May 2016 10:37  
> >>>> ...  
> >>>>>> Acutually, we are not aimed at accessing MSI-X table from
> >>>>>> guest. So I think it's safe to passthrough MSI-X table if we
> >>>>>> can make sure guest kernel would not touch MSI-X table in
> >>>>>> normal code path such as para-virtualized guest kernel on PPC64.
> >>>>>>  
> >>>>> Then how do you prevent malicious guest kernel accessing it?  
> >>>> Or a malicious guest driver for an ethernet card setting up
> >>>> the receive buffer ring to contain a single word entry that
> >>>> contains the address associated with an MSI-X interrupt and
> >>>> then using a loopback mode to cause a specific packet be
> >>>> received that writes the required word through that address.
> >>>>
> >>>> Remember the PCIe cycle for an interrupt is a normal memory write
> >>>> cycle.
> >>>>
> >>>> 	David
> >>>>  
> >>>
> >>> If we have enough permission to load a malicious driver or
> >>> kernel, we can easily break the guest without exposed
> >>> MSI-X table.
> >>>
> >>> I think it should be safe to expose MSI-X table if we can
> >>> make sure that malicious guest driver/kernel can't use
> >>> the MSI-X table to break other guest or host. The
> >>> capability of IRQ remapping could provide this
> >>> kind of protection.
> >>>  
> >>
> >> With IRQ remapping it doesn't mean you can pass through MSI-X
> >> structure to guest. I know actual IRQ remapping might be platform
> >> specific, but at least for Intel VT-d specification, MSI-X entry must
> >> be configured with a remappable format by host kernel which
> >> contains an index into IRQ remapping table. The index will find a
> >> IRQ remapping entry which controls interrupt routing for a specific
> >> device. If you allow a malicious program random index into MSI-X
> >> entry of assigned device, the hole is obvious...
> >>
> >> Above might make sense only for a IRQ remapping implementation
> >> which doesn't rely on extended MSI-X format (e.g. simply based on
> >> BDF). If that's the case for PPC, then you should build MSI-X
> >> passthrough based on this fact instead of general IRQ remapping
> >> enabled or not.  
> >
> > I don't think anyone is expecting that we can expose the MSI-X vector
> > table to the guest and the guest can make direct use of it.  The end
> > goal here is that the guest on a power system is already
> > paravirtualized to not program the device MSI-X by directly writing to
> > the MSI-X vector table.  They have hypercalls for this since they
> > always run virtualized.  Therefore a) they never intend to touch the
> > MSI-X vector table and b) they have sufficient isolation that a guest
> > can only hurt itself by doing so.
> >
> > On x86 we don't have a), our method of programming the MSI-X vector
> > table is to directly write to it. Therefore we will always require QEMU
> > to place a MemoryRegion over the vector table to intercept those
> > accesses.  However with interrupt remapping, we do have b) on x86, which
> > means that we don't need to be so strict in disallowing user accesses
> > to the MSI-X vector table.  It's not useful for configuring MSI-X on
> > the device, but the user should only be able to hurt themselves by
> > writing it directly.  x86 doesn't really get anything out of this
> > change, but it helps this special case on power pretty significantly
> > aiui.  Thanks,  
> 
> Excellent short overview, saved :)
> 
> How do we proceed with these patches? Nobody seems objecting them but also 
> nobody seems taking them either...

Well, this series is still based on some non-upstream patches, so...
Once that dependency is resolved this series should probably be split
into functional areas for acceptance by the appropriate subsystem
maintainers.
