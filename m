Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQ5l188wzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:30:03 +1000 (AEST)
Date: Mon, 30 Jul 2018 10:29:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
Message-ID: <20180730102957.47fa1191@t450s.home>
In-Reply-To: <4089d9ed-0c6b-3ba2-d447-049ce5b98764@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
 <20180607161541.21df6434@w520.home>
 <f0561258-698c-9086-255d-ff6c1aa16cfd@ozlabs.ru>
 <20180607214455.51ecfa1a@w520.home>
 <ff6de203-9287-8158-f0fb-ee9146245bea@ozlabs.ru>
 <20180607230323.0148344e@w520.home>
 <20180710141020.759983a6@aik.ozlabs.ibm.com>
 <20180710163715.5c326985@t450s.home>
 <20180711192621.174d849a@aik.ozlabs.ibm.com>
 <4089d9ed-0c6b-3ba2-d447-049ce5b98764@ozlabs.ru>
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

On Mon, 30 Jul 2018 18:58:49 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 11/07/2018 19:26, Alexey Kardashevskiy wrote:
> > On Tue, 10 Jul 2018 16:37:15 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> >> On Tue, 10 Jul 2018 14:10:20 +1000
> >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>  
> >>> On Thu, 7 Jun 2018 23:03:23 -0600
> >>> Alex Williamson <alex.williamson@redhat.com> wrote:
> >>>     
> >>>> On Fri, 8 Jun 2018 14:14:23 +1000
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>       
> >>>>> On 8/6/18 1:44 pm, Alex Williamson wrote:        
> >>>>>> On Fri, 8 Jun 2018 13:08:54 +1000
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>           
> >>>>>>> On 8/6/18 8:15 am, Alex Williamson wrote:          
> >>>>>>>> On Fri, 08 Jun 2018 07:54:02 +1000
> >>>>>>>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >>>>>>>>             
> >>>>>>>>> On Thu, 2018-06-07 at 11:04 -0600, Alex Williamson wrote:            
> >>>>>>>>>>
> >>>>>>>>>> Can we back up and discuss whether the IOMMU grouping of NVLink
> >>>>>>>>>> connected devices makes sense?  AIUI we have a PCI view of these
> >>>>>>>>>> devices and from that perspective they're isolated.  That's the view of
> >>>>>>>>>> the device used to generate the grouping.  However, not visible to us,
> >>>>>>>>>> these devices are interconnected via NVLink.  What isolation properties
> >>>>>>>>>> does NVLink provide given that its entire purpose for existing seems to
> >>>>>>>>>> be to provide a high performance link for p2p between devices?              
> >>>>>>>>>
> >>>>>>>>> Not entire. On POWER chips, we also have an nvlink between the device
> >>>>>>>>> and the CPU which is running significantly faster than PCIe.
> >>>>>>>>>
> >>>>>>>>> But yes, there are cross-links and those should probably be accounted
> >>>>>>>>> for in the grouping.            
> >>>>>>>>
> >>>>>>>> Then after we fix the grouping, can we just let the host driver manage
> >>>>>>>> this coherent memory range and expose vGPUs to guests?  The use case of
> >>>>>>>> assigning all 6 GPUs to one VM seems pretty limited.  (Might need to
> >>>>>>>> convince NVIDIA to support more than a single vGPU per VM though)            
> >>>>>>>
> >>>>>>> These are physical GPUs, not virtual sriov-alike things they are
> >>>>>>> implementing as well elsewhere.          
> >>>>>>
> >>>>>> vGPUs as implemented on M- and P-series Teslas aren't SR-IOV like
> >>>>>> either.  That's why we have mdev devices now to implement software
> >>>>>> defined devices.  I don't have first hand experience with V-series, but
> >>>>>> I would absolutely expect a PCIe-based Tesla V100 to support vGPU.          
> >>>>>
> >>>>> So assuming V100 can do vGPU, you are suggesting ditching this patchset and
> >>>>> using mediated vGPUs instead, correct?        
> >>>>
> >>>> If it turns out that our PCIe-only-based IOMMU grouping doesn't
> >>>> account for lack of isolation on the NVLink side and we correct that,
> >>>> limiting assignment to sets of 3 interconnected GPUs, is that still a
> >>>> useful feature?  OTOH, it's entirely an NVIDIA proprietary decision
> >>>> whether they choose to support vGPU on these GPUs or whether they can
> >>>> be convinced to support multiple vGPUs per VM.
> >>>>       
> >>>>>>> My current understanding is that every P9 chip in that box has some NVLink2
> >>>>>>> logic on it so each P9 is directly connected to 3 GPUs via PCIe and
> >>>>>>> 2xNVLink2, and GPUs in that big group are interconnected by NVLink2 links
> >>>>>>> as well.
> >>>>>>>
> >>>>>>> From small bits of information I have it seems that a GPU can perfectly
> >>>>>>> work alone and if the NVIDIA driver does not see these interconnects
> >>>>>>> (because we do not pass the rest of the big 3xGPU group to this guest), it
> >>>>>>> continues with a single GPU. There is an "nvidia-smi -r" big reset hammer
> >>>>>>> which simply refuses to work until all 3 GPUs are passed so there is some
> >>>>>>> distinction between passing 1 or 3 GPUs, and I am trying (as we speak) to
> >>>>>>> get a confirmation from NVIDIA that it is ok to pass just a single GPU.
> >>>>>>>
> >>>>>>> So we will either have 6 groups (one per GPU) or 2 groups (one per
> >>>>>>> interconnected group).          
> >>>>>>
> >>>>>> I'm not gaining much confidence that we can rely on isolation between
> >>>>>> NVLink connected GPUs, it sounds like you're simply expecting that
> >>>>>> proprietary code from NVIDIA on a proprietary interconnect from NVIDIA
> >>>>>> is going to play nice and nobody will figure out how to do bad things
> >>>>>> because... obfuscation?  Thanks,          
> >>>>>
> >>>>> Well, we already believe that a proprietary firmware of a sriov-capable
> >>>>> adapter like Mellanox ConnextX is not doing bad things, how is this
> >>>>> different in principle?        
> >>>>
> >>>> It seems like the scope and hierarchy are different.  Here we're
> >>>> talking about exposing big discrete devices, which are peers of one
> >>>> another (and have history of being reverse engineered), to userspace
> >>>> drivers.  Once handed to userspace, each of those devices needs to be
> >>>> considered untrusted.  In the case of SR-IOV, we typically have a
> >>>> trusted host driver for the PF managing untrusted VFs.  We do rely on
> >>>> some sanity in the hardware/firmware in isolating the VFs from each
> >>>> other and from the PF, but we also often have source code for Linux
> >>>> drivers for these devices and sometimes even datasheets.  Here we have
> >>>> neither of those and perhaps we won't know the extent of the lack of
> >>>> isolation between these devices until nouveau (best case) or some
> >>>> exploit (worst case) exposes it.  IOMMU grouping always assumes a lack
> >>>> of isolation between devices unless the hardware provides some
> >>>> indication that isolation exists, for example ACS on PCIe.  If NVIDIA
> >>>> wants to expose isolation on NVLink, perhaps they need to document
> >>>> enough of it that the host kernel can manipulate and test for isolation,
> >>>> perhaps even enabling virtualization of the NVLink interconnect
> >>>> interface such that the host can prevent GPUs from interfering with
> >>>> each other.  Thanks,      
> >>>
> >>>
> >>> So far I got this from NVIDIA:
> >>>
> >>> 1. An NVLink2 state can be controlled via MMIO registers, there is a
> >>> "NVLINK ISOLATION ON MULTI-TENANT SYSTEMS" spec (my copy is
> >>> "confidential" though) from NVIDIA with the MMIO addresses to block if
> >>> we want to disable certain links. In order to NVLink to work it needs to
> >>> be enabled on both sides so by filtering certains MMIO ranges we can
> >>> isolate a GPU.    
> >>
> >> Where are these MMIO registers, on the bridge or on the endpoint device?  
> > 
> > The endpoint GPU device.
> >   
> >> I'm wondering when you say block MMIO if these are ranges on the device
> >> that we disallow mmap to and all the overlapping PAGE_SIZE issues that
> >> come with that or if this should essentially be device specific
> >> enable_acs and acs_enabled quirks, and maybe also potentially used by
> >> Logan's disable acs series to allow GPUs to be linked and have grouping
> >> to match.  
> > 
> > An update, I confused P100 and V100, P100 would need filtering but
> > ours is V100 and it has a couple of registers which we can use to
> > disable particular links and once disabled, the link cannot be
> > re-enabled till the next secondary bus reset.
> > 
> >   
> >>> 2. We can and should also prohibit the GPU firmware update, this is
> >>> done via MMIO as well. The protocol is not open but at least register
> >>> ranges might be in order to filter these accesses, and there is no
> >>> plan to change this.    
> >>
> >> I assume this MMIO is on the endpoint and has all the PAGE_SIZE joys
> >> along with it.  
> > 
> > Yes, however NVIDIA says there is no performance critical stuff with
> > this 64K page.
> >   
> >> Also, there are certainly use cases of updating
> >> firmware for an assigned device, we don't want to impose a policy, but
> >> we should figure out the right place for that policy to be specified by
> >> the admin.  
> > 
> > May be but NVIDIA is talking about some "out-of-band" command to the GPU
> > to enable firmware update so firmware update is not really supported.
> > 
> >   
> >>> 3. DMA trafic over the NVLink2 link can be of 2 types: UT=1 for
> >>> PCI-style DMA via our usual TCE tables (one per a NVLink2 link),
> >>> and UT=0 for direct host memory access. UT stands for "use
> >>> translation" and this is a part of the NVLink2 protocol. Only UT=1 is
> >>> possible over the PCIe link.
> >>> This UT=0 trafic uses host physical addresses returned by a nest MMU (a
> >>> piece of NVIDIA logic on a POWER9 chip), this takes LPID (guest id),
> >>> mmu context id (guest userspace mm id), a virtual address and translates
> >>> to the host physical and that result is used for UT=0 DMA, this is
> >>> called "ATS" although it is not PCIe ATS afaict.
> >>> NVIDIA says that the hardware is designed in a way that it can only do
> >>> DMA UT=0 to addresses which ATS translated to, and there is no way to
> >>> override this behavior and this is what guarantees the isolation.    
> >>
> >> I'm kinda lost here, maybe we can compare it to PCIe ATS where an
> >> endpoint requests a translation of an IOVA to physical address, the
> >> IOMMU returns a lookup based on PCIe requester ID, and there's an
> >> invalidation protocol to keep things coherent.  
> > 
> > Yes there is. The current approach is to have an MMU notifier in
> > the kernel which tells an NPU (IBM piece of logic between GPU/NVlink2
> > and NVIDIA nest MMU) to invalidate translations and that in turn pokes
> > the GPU till that confirms that it invalidated tlbs and there is no
> > ongoing DMA.
> >   
> >> In the case above, who provides a guest id and mmu context id?   
> > 
> > We (powerpc/powernv platform) configure NPU to bind specific bus:dev:fn to
> > an LPID (== guest id) and MMU context id comes from the guest. The nest
> > MMU knows where the partition table and this table contains all the
> > pointers needs for the translation.
> > 
> >   
> >> Additional software
> >> somewhere?  Is the virtual address an IOVA or a process virtual
> >> address?   
> > 
> > A guest kernel or a guest userspace virtual address.
> >   
> >> Do we assume some sort of invalidation protocol as well?  
> > 
> > I am little confused, is this question about the same invalidation
> > protocol as above or different?
> > 
> >   
> >>> So isolation can be achieved if I do not miss something.
> >>>
> >>> How do we want this to be documented to proceed? I assume if I post
> >>> patches filtering MMIOs, this won't do it, right? If just 1..3 are
> >>> documented, will we take this t&c or we need a GPU API spec (which is
> >>> not going to happen anyway)?    
> >>
> >> "t&c"? I think we need what we're actually interacting with to be well
> >> documented, but that could be _thorough_ comments in the code, enough
> >> to understand the theory of operation, as far as I'm concerned.  A pdf
> >> lost on a corporate webserver isn't necessarily an improvement over
> >> that, but there needs to be sufficient detail to understand what we're
> >> touching such that we can maintain, adapt, and improve the code over
> >> time.  Only item #3 above appears POWER specific, so I'd hope that #1
> >> is done in the PCI subsystem, #2 might be a QEMU option (maybe kernel
> >> vfio-pci, but I'm not sure that's necessary), and I don't know where #3
> >> goes.  Thanks,  
> > 
> > Ok, understood. Thanks!  
> 
> After some local discussions, it was pointed out that force disabling
> nvlinks won't bring us much as for an nvlink to work, both sides need to
> enable it so malicious guests cannot penetrate good ones (or a host)
> unless a good guest enabled the link but won't happen with a well
> behaving guest. And if two guests became malicious, then can still only
> harm each other, and so can they via other ways such network. This is
> different from PCIe as once PCIe link is unavoidably enabled, a well
> behaving device cannot firewall itself from peers as it is up to the
> upstream bridge(s) now to decide the routing; with nvlink2, a GPU still
> has means to protect itself, just like a guest can run "firewalld" for
> network.
> 
> Although it would be a nice feature to have an extra barrier between
> GPUs, is inability to block the links in hypervisor still a blocker for
> V100 pass through?

How is the NVLink configured by the guest, is it 'on'/'off' or are
specific routes configured?  If the former, then isn't a non-malicious
guest still susceptible to a malicious guest?  If the latter, how is
routing configured by the guest given that the guest view of the
topology doesn't match physical hardware?  Are these routes
deconfigured by device reset?  Are they part of the save/restore
state?  Thanks,

Alex
