Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4128hV64ZJzF33K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 14:34:50 +1000 (AEST)
Date: Thu, 7 Jun 2018 22:34:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 5/5] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20180607223446.1278deb1@w520.home>
In-Reply-To: <b1ec37e5-e7a0-5930-edcb-08272ca841b0@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607084420.29513-6-aik@ozlabs.ru>
 <20180607110449.2c25a62d@w520.home>
 <d4ffacf9-5028-9f76-cbad-4f1a487b6db3@ozlabs.ru>
 <20180607213535.04e68bac@w520.home>
 <b1ec37e5-e7a0-5930-edcb-08272ca841b0@ozlabs.ru>
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

On Fri, 8 Jun 2018 13:52:05 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 8/6/18 1:35 pm, Alex Williamson wrote:
> > On Fri, 8 Jun 2018 13:09:13 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
> >> On 8/6/18 3:04 am, Alex Williamson wrote:  
> >>> On Thu,  7 Jun 2018 18:44:20 +1000
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:  
> >>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >>>> index 7bddf1e..38c9475 100644
> >>>> --- a/drivers/vfio/pci/vfio_pci.c
> >>>> +++ b/drivers/vfio/pci/vfio_pci.c
> >>>> @@ -306,6 +306,15 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
> >>>>  		}
> >>>>  	}
> >>>>  
> >>>> +	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA &&
> >>>> +	    pdev->device == 0x1db1 &&
> >>>> +	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {    
> >>>
> >>> Can't we do better than check this based on device ID?  Perhaps PCIe
> >>> capability hints at this?    
> >>
> >> A normal PCI pluggable device looks like this:
> >>
> >> root@fstn3:~# sudo lspci -vs 0000:03:00.0
> >> 0000:03:00.0 3D controller: NVIDIA Corporation GK210GL [Tesla K80] (rev a1)
> >> 	Subsystem: NVIDIA Corporation GK210GL [Tesla K80]
> >> 	Flags: fast devsel, IRQ 497
> >> 	Memory at 3fe000000000 (32-bit, non-prefetchable) [disabled] [size=16M]
> >> 	Memory at 200000000000 (64-bit, prefetchable) [disabled] [size=16G]
> >> 	Memory at 200400000000 (64-bit, prefetchable) [disabled] [size=32M]
> >> 	Capabilities: [60] Power Management version 3
> >> 	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
> >> 	Capabilities: [78] Express Endpoint, MSI 00
> >> 	Capabilities: [100] Virtual Channel
> >> 	Capabilities: [128] Power Budgeting <?>
> >> 	Capabilities: [420] Advanced Error Reporting
> >> 	Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
> >> 	Capabilities: [900] #19
> >>
> >>
> >> This is a NVLink v1 machine:
> >>
> >> aik@garrison1:~$ sudo lspci -vs 000a:01:00.0
> >> 000a:01:00.0 3D controller: NVIDIA Corporation Device 15fe (rev a1)
> >> 	Subsystem: NVIDIA Corporation Device 116b
> >> 	Flags: bus master, fast devsel, latency 0, IRQ 457
> >> 	Memory at 3fe300000000 (32-bit, non-prefetchable) [size=16M]
> >> 	Memory at 260000000000 (64-bit, prefetchable) [size=16G]
> >> 	Memory at 260400000000 (64-bit, prefetchable) [size=32M]
> >> 	Capabilities: [60] Power Management version 3
> >> 	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
> >> 	Capabilities: [78] Express Endpoint, MSI 00
> >> 	Capabilities: [100] Virtual Channel
> >> 	Capabilities: [250] Latency Tolerance Reporting
> >> 	Capabilities: [258] L1 PM Substates
> >> 	Capabilities: [128] Power Budgeting <?>
> >> 	Capabilities: [420] Advanced Error Reporting
> >> 	Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
> >> 	Capabilities: [900] #19
> >> 	Kernel driver in use: nvidia
> >> 	Kernel modules: nvidiafb, nouveau, nvidia_384_drm, nvidia_384
> >>
> >>
> >> This is the one the patch is for:
> >>
> >> [aik@yc02goos ~]$ sudo lspci -vs 0035:03:00.0
> >> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> >> (rev a1)
> >> 	Subsystem: NVIDIA Corporation Device 1212
> >> 	Flags: fast devsel, IRQ 82, NUMA node 8
> >> 	Memory at 620c280000000 (32-bit, non-prefetchable) [disabled] [size=16M]
> >> 	Memory at 6228000000000 (64-bit, prefetchable) [disabled] [size=16G]
> >> 	Memory at 6228400000000 (64-bit, prefetchable) [disabled] [size=32M]
> >> 	Capabilities: [60] Power Management version 3
> >> 	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
> >> 	Capabilities: [78] Express Endpoint, MSI 00
> >> 	Capabilities: [100] Virtual Channel
> >> 	Capabilities: [250] Latency Tolerance Reporting
> >> 	Capabilities: [258] L1 PM Substates
> >> 	Capabilities: [128] Power Budgeting <?>
> >> 	Capabilities: [420] Advanced Error Reporting
> >> 	Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
> >> 	Capabilities: [900] #19
> >> 	Capabilities: [ac0] #23
> >> 	Kernel driver in use: vfio-pci
> >>
> >>
> >> I can only see a new capability #23 which I have no idea about what it
> >> actually does - my latest PCIe spec is
> >> PCI_Express_Base_r3.1a_December7-2015.pdf and that only knows capabilities
> >> till #21, do you have any better spec? Does not seem promising anyway...  
> > 
> > You could just look in include/uapi/linux/pci_regs.h and see that 23
> > (0x17) is a TPH Requester capability and google for that...  It's a TLP
> > processing hint related to cache processing for requests from system
> > specific interconnects.  Sounds rather promising.  Of course there's
> > also the vendor specific capability that might be probed if NVIDIA will
> > tell you what to look for and the init function you've implemented
> > looks for specific devicetree nodes, that I imagine you could test for
> > in a probe as well.  
> 
> 
> This 23 is in hex:
> 
> [aik@yc02goos ~]$ sudo lspci -vs 0035:03:00.0
> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100 SXM2]
> (rev a1)
> 	Subsystem: NVIDIA Corporation Device 1212
> 	Flags: fast devsel, IRQ 82, NUMA node 8
> 	Memory at 620c280000000 (32-bit, non-prefetchable) [disabled] [size=16M]
> 	Memory at 6228000000000 (64-bit, prefetchable) [disabled] [size=16G]
> 	Memory at 6228400000000 (64-bit, prefetchable) [disabled] [size=32M]
> 	Capabilities: [60] Power Management version 3
> 	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [78] Express Endpoint, MSI 00
> 	Capabilities: [100] Virtual Channel
> 	Capabilities: [250] Latency Tolerance Reporting
> 	Capabilities: [258] L1 PM Substates
> 	Capabilities: [128] Power Budgeting <?>
> 	Capabilities: [420] Advanced Error Reporting
> 	Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>
> 	Capabilities: [900] #19
> 	Capabilities: [ac0] #23
> 	Kernel driver in use: vfio-pci
> 
> [aik@yc02goos ~]$ sudo lspci -vvvxxxxs 0035:03:00.0 | grep ac0
> 	Capabilities: [ac0 v1] #23
> ac0: 23 00 01 00 de 10 c1 00 01 00 10 00 00 00 00 00

Oops, I was thinking lspci printed unknown in decimal.  Strange, it's a
shared, vendor specific capability:

https://pcisig.com/sites/default/files/specification_documents/ECN_DVSEC-2015-08-04-clean_0.pdf

We see in your dump that the vendor of this capability is 0x10de
(NVIDIA) and the ID of the capability is 0x0001.  Note that NVIDIA
sponsored this ECN.

> Talking to NVIDIA is always an option :)

Really no other choice to figure out how to decode these vendor
specific capabilities, this 0x23 capability at least seems to be meant
for sharing.

> >>> Is it worthwhile to continue with assigning the device in the !ENABLED
> >>> case?  For instance, maybe it would be better to provide a weak
> >>> definition of vfio_pci_nvlink2_init() that would cause us to fail here
> >>> if we don't have this device specific support enabled.  I realize
> >>> you're following the example set forth for IGD, but those regions are
> >>> optional, for better or worse.    
> >>
> >>
> >> The device is supposed to work even without GPU RAM passed through, this
> >> should look like NVLink v1 in this case (there used to be bugs in the
> >> driver, may be still are, have not checked for a while but there is a bug
> >> opened at NVIDIA about this and they were going to fix that), this is why I
> >> chose not to fail here.  
> > 
> > Ok.
> >   
> >>>> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> >>>> index 24ee260..2725bc8 100644
> >>>> --- a/drivers/vfio/pci/Kconfig
> >>>> +++ b/drivers/vfio/pci/Kconfig
> >>>> @@ -30,3 +30,7 @@ config VFIO_PCI_INTX
> >>>>  config VFIO_PCI_IGD
> >>>>  	depends on VFIO_PCI
> >>>>  	def_bool y if X86
> >>>> +
> >>>> +config VFIO_PCI_NVLINK2
> >>>> +	depends on VFIO_PCI
> >>>> +	def_bool y if PPC_POWERNV    
> >>>
> >>> As written, this also depends on PPC_POWERNV (or at least TCE), it's not
> >>> a portable implementation that we could re-use on X86 or ARM or any
> >>> other platform if hardware appeared for it.  Can we improve that as
> >>> well to make this less POWER specific?  Thanks,    
> >>
> >>
> >> As I said in another mail, every P9 chip in that box has some NVLink2 logic
> >> on it so it is not even common among P9's in general and I am having hard
> >> time seeing these V100s used elsewhere in such way.  
> > 
> > https://www.redhat.com/archives/vfio-users/2018-May/msg00000.html
> > 
> > Not much platform info, but based on the rpm mentioned, looks like an
> > x86_64 box.  Thanks,  
> 
> Wow. Interesting. Thanks for the pointer. No advertising material actually
> says that it is P9 only or even mention P9, wiki does not say it is P9 only
> either. Hmmm...

NVIDIA's own DGX systems are Xeon-based and seem to include NVLink.
The DGX-1 definitely makes use of the SXM2 modules, up to 8 of them.
The DGX Station might be the 4x V100 SXM2 box mentioned in the link.
Thanks,

Alex
