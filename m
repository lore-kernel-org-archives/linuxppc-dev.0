Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mVRt4MWnzDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 00:06:50 +1000 (AEST)
Date: Thu, 9 Aug 2018 08:06:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm-ppc@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
Message-ID: <20180809080645.02f688c8@t450s.home>
In-Reply-To: <cbe30444-9ac4-fc70-dfc0-4430a4d26905@ozlabs.ru>
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
 <20180730102957.47fa1191@t450s.home>
 <09755067-29e2-8d9c-9a4b-a368d0b5add4@ozlabs.ru>
 <20180731082905.5c7cdeee@t450s.home>
 <38e4455c-e3b8-b867-1771-0f4ccf9d31d8@ozlabs.ru>
 <20180801101646.2de997c3@t450s.home>
 <dc0e5c0b-c6de-df1c-176f-7f64cbd6a7ba@ozlabs.ru>
 <cbe30444-9ac4-fc70-dfc0-4430a4d26905@ozlabs.ru>
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

On Thu, 9 Aug 2018 14:21:29 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 08/08/2018 18:39, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 02/08/2018 02:16, Alex Williamson wrote:  
> >> On Wed, 1 Aug 2018 18:37:35 +1000
> >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>  
> >>> On 01/08/2018 00:29, Alex Williamson wrote:  
> >>>> On Tue, 31 Jul 2018 14:03:35 +1000
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>     
> >>>>> On 31/07/2018 02:29, Alex Williamson wrote:    
> >>>>>> On Mon, 30 Jul 2018 18:58:49 +1000
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:    
> >>>>>>> After some local discussions, it was pointed out that force disabling
> >>>>>>> nvlinks won't bring us much as for an nvlink to work, both sides need to
> >>>>>>> enable it so malicious guests cannot penetrate good ones (or a host)
> >>>>>>> unless a good guest enabled the link but won't happen with a well
> >>>>>>> behaving guest. And if two guests became malicious, then can still only
> >>>>>>> harm each other, and so can they via other ways such network. This is
> >>>>>>> different from PCIe as once PCIe link is unavoidably enabled, a well
> >>>>>>> behaving device cannot firewall itself from peers as it is up to the
> >>>>>>> upstream bridge(s) now to decide the routing; with nvlink2, a GPU still
> >>>>>>> has means to protect itself, just like a guest can run "firewalld" for
> >>>>>>> network.
> >>>>>>>
> >>>>>>> Although it would be a nice feature to have an extra barrier between
> >>>>>>> GPUs, is inability to block the links in hypervisor still a blocker for
> >>>>>>> V100 pass through?      
> >>>>>>
> >>>>>> How is the NVLink configured by the guest, is it 'on'/'off' or are
> >>>>>> specific routes configured?       
> >>>>>
> >>>>> The GPU-GPU links need not to be blocked and need to be enabled
> >>>>> (==trained) by a driver in the guest. There are no routes between GPUs
> >>>>> in NVLink fabric, these are direct links, it is just a switch on each
> >>>>> side, both switches need to be on for a link to work.    
> >>>>
> >>>> Ok, but there is at least the possibility of multiple direct links per
> >>>> GPU, the very first diagram I find of NVlink shows 8 interconnected
> >>>> GPUs:
> >>>>
> >>>> https://www.nvidia.com/en-us/data-center/nvlink/    
> >>>
> >>> Out design is like the left part of the picture but it is just a detail.  
> >>
> >> Unless we can specifically identify a direct link vs a mesh link, we
> >> shouldn't be making assumptions about the degree of interconnect.
> >>    
> >>>> So if each switch enables one direct, point to point link, how does the
> >>>> guest know which links to open for which peer device?    
> >>>
> >>> It uses PCI config space on GPUs to discover the topology.  
> >>
> >> So do we need to virtualize this config space if we're going to
> >> virtualize the topology?
> >>  
> >>>> And of course
> >>>> since we can't see the spec, a security audit is at best hearsay :-\    
> >>>
> >>> Yup, the exact discovery protocol is hidden.  
> >>
> >> It could be reverse engineered...
> >>  
> >>>>> The GPU-CPU links - the GPU bit is the same switch, the CPU NVlink state
> >>>>> is controlled via the emulated PCI bridges which I pass through together
> >>>>> with the GPU.    
> >>>>
> >>>> So there's a special emulated switch, is that how the guest knows which
> >>>> GPUs it can enable NVLinks to?    
> >>>
> >>> Since it only has PCI config space (there is nothing relevant in the
> >>> device tree at all), I assume (double checking with the NVIDIA folks
> >>> now) the guest driver enables them all, tests which pair works and
> >>> disables the ones which do not. This gives a malicious guest a tiny
> >>> window of opportunity to break into a good guest. Hm :-/  
> >>
> >> Let's not minimize that window, that seems like a prime candidate for
> >> an exploit.
> >>  
> >>>>>> If the former, then isn't a non-malicious
> >>>>>> guest still susceptible to a malicious guest?      
> >>>>>
> >>>>> A non-malicious guest needs to turn its switch on for a link to a GPU
> >>>>> which belongs to a malicious guest.    
> >>>>
> >>>> Actual security, or obfuscation, will we ever know...    
> >>>>>>> If the latter, how is    
> >>>>>> routing configured by the guest given that the guest view of the
> >>>>>> topology doesn't match physical hardware?  Are these routes
> >>>>>> deconfigured by device reset?  Are they part of the save/restore
> >>>>>> state?  Thanks,      
> >>>>
> >>>> Still curious what happens to these routes on reset.  Can a later user
> >>>> of a GPU inherit a device where the links are already enabled?  Thanks,    
> >>>
> >>> I am told that the GPU reset disables links. As a side effect, we get an
> >>> HMI (a hardware fault which reset the host machine) when trying
> >>> accessing the GPU RAM which indicates that the link is down as the
> >>> memory is only accessible via the nvlink. We have special fencing code
> >>> in our host firmware (skiboot) to fence this memory on PCI reset so
> >>> reading from it returns zeroes instead of HMIs.  
> >>
> >> What sort of reset is required for this?  Typically we rely on
> >> secondary bus reset for GPUs, but it would be a problem if GPUs were to
> >> start implementing FLR and nobody had a spec to learn that FLR maybe
> >> didn't disable the link.  The better approach to me still seems to be
> >> virtualizing these NVLink config registers to an extent that the user
> >> can only enabling links where they have ownership of both ends of the
> >> connection.  Thanks,  
> > 
> > 
> > I re-read what I wrote and I owe some explanation.
> > 
> > The link state can be:
> > - disabled (or masked),
> > - enabled (or not-disabled? unmasked?),
> > - trained (configured).
> > 
> > At the moment no reset disables links, on sec bus reset they are
> > unconfigured and go to the initial enabled-and-not-trained state which
> > is the default config. The NVIDIA driver in the guest trains links to do
> > the topology discovery. We can disable links and this disabled status
> > remains until sec bus reset and there is no way to re-enable links other
> > than sec bus reset. This is what I get from NVIDIA. FLR should not be
> > able to change a thing here.  
> 
> 
> btw using this masking mechanism does not involve any virtualizing -
> these are MMIO registers which a powernv platform reset hook will write
> to in order to stay in sync with already configured IOMMU groups and
> that's all, the guest will still be able to access them with no
> filtering on the way, it just won't do anything. Or this is still called
> virtualizing?

The only thing POWER specific here seems to be the NVLink interface to
the CPU, so why would a reset hook be implemented as a powernv platform
reset hook?  We know these GPUs also exist in x86 platforms, so
anything we do on the endpoint should be shared regardless of the
platform.  I'm envisioning that even if we simply disable the NVLink
via a device specific reset, we'd probably still want to hide the
NVLink capability from the user, otherwise it seems likely that they
might try to interact with NVLink and we might induce problems that
it's not in an expected state.  So if we hide the capability or trap
access to the configuration registers, I'd call that virtualization.
Thanks,

Alex
