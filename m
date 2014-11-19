Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87C2D1A065E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 04:23:56 +1100 (AEDT)
Received: by mail-ig0-f178.google.com with SMTP id hl2so1360530igb.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 09:23:54 -0800 (PST)
Date: Wed, 19 Nov 2014 10:23:50 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
Message-ID: <20141119172350.GC23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com>
 <1416363332.5704.18.camel@au1.ibm.com>
 <20141119032100.GA7105@richard> <20141119042601.GB23467@google.com>
 <20141119092740.GA12872@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141119092740.GA12872@richard>
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

On Wed, Nov 19, 2014 at 05:27:40PM +0800, Wei Yang wrote:
> On Tue, Nov 18, 2014 at 09:26:01PM -0700, Bjorn Helgaas wrote:
> >On Wed, Nov 19, 2014 at 11:21:00AM +0800, Wei Yang wrote:
> >> On Wed, Nov 19, 2014 at 01:15:32PM +1100, Benjamin Herrenschmidt wrote:
> >> >On Tue, 2014-11-18 at 18:12 -0700, Bjorn Helgaas wrote:

> >> But the HW
> >> must map 256 segments with the same size. This will lead a situation like
> >> this.
> >> 
> >>    +------+------+        +------+------+------+------+
> >>    |VF#0  |VF#1  |   ...  |      |VF#N-1|PF#A  |PF#B  |
> >>    +------+------+        +------+------+------+------+
> >> 
> >> Suppose N = 254 and the HW map these 256 segments to their corresponding PE#.
> >
> >I guess these 256 segments are regions of CPU physical address space, and
> >they are being mapped to bus address space?  Is there some relationship
> >between a PE and part of the bus address space?
> >
> 
> PE is an entity for EEH, which may include a whole bus or one pci device.

Yes, I've read that many times.  What's missing is the connection between a
PE and the things in the PCI specs (buses, devices, functions, MMIO address
space, DMA, MSI, etc.)  Presumably the PE structure imposes constraints on
how the core uses the standard PCI elements, but we don't really have a
clear description of those constraints yet.

> When some device got some error, we need to identify which PE it belongs to.
> So we have some HW to map between PE# and MMIO/DMA/MSI address.
> 
> The HW mentioned in previous letter is the one to map MMIO address to a PE#.
> While this HW must map a range with 256 equal segments. And yes, this is
> mapped to bus address space.
> ...

> >> The difference after our expanding is the IOV BAR size is 256*4KB instead of
> >> 16KB. So it will look like this:
> >> 
> >>   PF  pci_dev->resource[7] = [mem 0x00000000-0x000fffff] (1024KB)
> >
> >Is the idea that you want this resource to be big enough to cover all 256
> >segments?  I think I'm OK with increasing the size of the PF resources to
> >prevent overlap.  That part shouldn't be too ugly.
> >
> 
> Yes, big enough to cover all 256 segments.
> 
> Sorry for making it ugly :-(

I didn't mean that what you did was ugly.  I meant that increasing the size
of the PF resource can be done cleanly.

By the way, when you do this, it would be nice if the dmesg showed the
standard PF IOV BAR sizing, and then a separate line showing the resource
expansion to deal with the PE constraints.  I don't think even the standard
output is very clear -- I think we currently get something like this:

  pci 0000:00:00.0 reg 0x174: [mem 0x00000000-0x00000fff]

But that is only the size of a single VF BAR aperture.  Then sriov_init()
multiplies that by the number of possible VFs, but I don't think we print
the overall size of that PF resource.  I think we should, because it's
misleading to print only the smaller piece.  Maybe something like this:

  pci 0000:00:00.0 VF BAR0: [mem 0x00000000-0x00003fff] (for 4 VFs)

And then you could do something like:

  pci 0000:00:00.0 VF BAR0: [mem 0x00000000-0x000fffff] (expanded for PE alignment)

> >>   VF1 pci_dev->resource[0] = [mem 0x00000000-0x00000fff]
> >>   VF2 pci_dev->resource[0] = [mem 0x00001000-0x00001fff]
> >>   VF3 pci_dev->resource[0] = [mem 0x00002000-0x00002fff]
> >>   VF4 pci_dev->resource[0] = [mem 0x00003000-0x00003fff]
> >>   ...
> >>   and 252 4KB space leave not used.
> >> 
> >> So the start address and the size of VF will not change, but the PF's IOV BAR
> >> will be expanded.
> >
> >I'm really dubious about this change to use pci_iov_resource_size().  I
> >think you might be doing that because if you increase the PF resource size,
> >dividing that increased size by total_VFs will give you garbage.  E.g., in
> >the example above, you would compute "size = 1024KB / 4", which would make
> >the VF BARs appear to be 256KB instead of 4KB as they should be.
> 
> Yes, your understanding is correct.
> 
> >I think it would be better to solve that problem by decoupling the PF
> >resource size and the VF BAR size.  For example, we could keep track of the
> >VF BAR size explicitly in struct pci_sriov, instead of computing it from
> >the PF resource size and total_VFs.  This would keep the VF BAR size
> >completely platform-independent.
> 
> Hmm... this is another solution.
> 
> If you prefer this one, I will make a change accordingly.

Yes, I definitely prefer to track the VF BAR size explicitly.  I think that
will make the code much clearer.

Bjorn
