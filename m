Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 364391A09CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 15:26:06 +1100 (AEDT)
Received: by mail-ie0-f170.google.com with SMTP id tr6so6584400ieb.29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 20:26:04 -0800 (PST)
Date: Tue, 18 Nov 2014 21:26:01 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
Message-ID: <20141119042601.GB23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com>
 <1416363332.5704.18.camel@au1.ibm.com>
 <20141119032100.GA7105@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141119032100.GA7105@richard>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 Donald Dutile <ddutile@redhat.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 19, 2014 at 11:21:00AM +0800, Wei Yang wrote:
> On Wed, Nov 19, 2014 at 01:15:32PM +1100, Benjamin Herrenschmidt wrote:
> >On Tue, 2014-11-18 at 18:12 -0700, Bjorn Helgaas wrote:
> >> 
> >> Can you help me understand this?
> >> 
> >> We have previously called sriov_init() on the PF.  There, we sized the VF
> >> BARs, which are in the PF's SR-IOV Capability (SR-IOV spec sec 3.3.14).
> >> The size we discover is the amount of space required by a single VF, so
> >> sriov_init() adjusts PF->resource[PCI_IOV_RESOURCES + i] by multiplying
> >> that size by PCI_SRIOV_TOTAL_VF, so this PF resource is now big enough to 
> >> hold the VF BAR[i] areas for all the possible VFs.
> >
> >So I'll let Richard (Wei) answer on the details but I'll just chime in
> >about the "big picture". This isn't about changing the spacing between VFs
> >which is handled by the system page size.
> >
> >This is about the way we create MMIO windows from the CPU to the VF BARs.
> >
> >Basically, we have a (limited) set of 64-bit windows we can create that
> >are divided in equal sized segments (256 of them), each segment assigned
> >in HW to one of our Partitionable Endpoints (aka domain).
> >
> >So even if we only ever create 16 VFs for a device, we need to use an
> >entire of these windows, which will use 256*VF_size and thus allocate
> >that much space. Also the window has to be naturally aligned.
> >
> >We can then assign the VF BAR to a spot inside that window that corresponds
> >to the range of PEs that we have assigned to that device (which typically
> >isn't going to be the beginning of the window).
> >
> 
> Bjorn & Ben,
> 
> Let me try to explain it. Thanks for Ben's explanation, it would be helpful. We
> are not trying to change the space between VFs.
> 
> As mentioned by Ben, we use some HW to map the MMIO space to PE. 

We need some documentation with pictures about what a PE is.  I did find
this:

https://events.linuxfoundation.org/images/stories/slides/lfcs2013_yang.pdf

which looks like a good start, although there's not quite enough text for
me to understand, and it doesn't have much about MMIO space.

> But the HW
> must map 256 segments with the same size. This will lead a situation like
> this.
> 
>    +------+------+        +------+------+------+------+
>    |VF#0  |VF#1  |   ...  |      |VF#N-1|PF#A  |PF#B  |
>    +------+------+        +------+------+------+------+
> 
> Suppose N = 254 and the HW map these 256 segments to their corresponding PE#.

I guess these 256 segments are regions of CPU physical address space, and
they are being mapped to bus address space?  Is there some relationship
between a PE and part of the bus address space?

> Then it introduces one problem, the PF#A and PF#B have been already assigned
> to some PE#. We can't map one MMIO range to two different PE#.
> 
> What we have done is to "Expand the IOV BAR" to fit the whole HW 256 segments.
> By doing so, the MMIO range will look like this.
> 
>    +------+------+        +------+------+------+------+------+------+
>    |VF#0  |VF#1  |   ...  |      |VF#N-1|blank |blank |PF#A  |PF#B  |
>    +------+------+        +------+------+------+------+------+------+
> 
> We do some tricky to "Expand" the IOV BAR, so that make sure there would not
> be some overlap between VF's PE and PF's PE.

The language here is tricky.  You're not actually *expanding* the IOV BAR.
The IOV BAR is a hardware thing and its size is determined by normal BAR
sizing and the number of VFs.  What you're doing is reserving additional
space for that BAR, and the additional space will be unused.  That's all
fine; we just need a way to describe it accurately.

> Then this will leads to the IOV BAR size change from:
>    
>    IOV BAR size = (VF BAR aperture size) * VF_number
> 
>  to:
>    
>    IOV BAR size = (VF BAR aperture size) * 256
> 
> This is the reason we need a platform dependent method to get the VF BAR size.
> Otherwise the VF BAR size would be not correct.
> 
> Now let's take a look at your example again.
> 
>   PF SR-IOV Capability
>     TotalVFs = 4
>     NumVFs = 4
>     System Page Size = 4KB
>     VF BAR0 = [mem 0x00000000-0x00000fff] (4KB at address 0)
> 
>   PF  pci_dev->resource[7] = [mem 0x00000000-0x00003fff] (16KB)
>   VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
>   VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
>   VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
>   VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]
> 
> The difference after our expanding is the IOV BAR size is 256*4KB instead of
> 16KB. So it will look like this:
> 
>   PF  pci_dev->resource[7] = [mem 0x00000000-0x000fffff] (1024KB)

Is the idea that you want this resource to be big enough to cover all 256
segments?  I think I'm OK with increasing the size of the PF resources to
prevent overlap.  That part shouldn't be too ugly.

>   VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
>   VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
>   VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
>   VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]
>   ...
>   and 252 4KB space leave not used.
> 
> So the start address and the size of VF will not change, but the PF's IOV BAR
> will be expanded.

I'm really dubious about this change to use pci_iov_resource_size().  I
think you might be doing that because if you increase the PF resource size,
dividing that increased size by total_VFs will give you garbage.  E.g., in
the example above, you would compute "size = 1024KB / 4", which would make
the VF BARs appear to be 256KB instead of 4KB as they should be.

I think it would be better to solve that problem by decoupling the PF
resource size and the VF BAR size.  For example, we could keep track of the
VF BAR size explicitly in struct pci_sriov, instead of computing it from
the PF resource size and total_VFs.  This would keep the VF BAR size
completely platform-independent.

Bjorn
