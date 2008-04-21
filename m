Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id ACDD0DEBC9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 01:17:12 +1000 (EST)
Message-ID: <480CAFD2.2050108@ru.mvista.com>
Date: Mon, 21 Apr 2008 19:16:34 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>
	<480BA937.7050603@linux.vnet.ibm.com>
	<1208727408.7009.0.camel@pasglop>
	<480C80B6.30904@linux.vnet.ibm.com>
	<480C87BD.8090207@ru.mvista.com>
	<480C9FE2.4030601@linux.vnet.ibm.com>
In-Reply-To: <480C9FE2.4030601@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Ehrhardt wrote:

>>> +else {
>>> +printk(KERN_ERR"%s - continue with start 0x%0lx on %p\n", __func__, 
>>> (this->end + 1), this->sibling);
>>> +}
>>>                 new->start = this->end + 1;
>>>                 this = this->sibling;
>>
>>
>>    And here. Yet it's not clear why you call resource's 'end' 'start'...

> It's the new->start that get's calculated one line after that new else 
> part.
> I printed that one to to see a bit how the loop iterates the resource 
> elements.

    Yeah, I figured that out right after sending mail. :-)

> ------------------------------------------------------------------------

> With DEBUG in arch/powerpc/kernel/pci-common.c, debug in commandline and a patch with some printk's (I attached the patch because it is the usual "put printk's everywhere" so the diff helps to understand where the prints come from). Corrected prinf format specifiers according to the comments from Sergei Shtylyov.

> PCI host bridge /plb/pci@1ec000000 (primary) ranges:
>  MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
>   IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCI: Probing PCI hardware
> PCI: Hiding 4xx host bridge resources 0000:00:00.0
> Try to map irq for 0000:00:00.0...
>  -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
>  -> mapped to linux irq 16
> Try to map irq for 0000:00:0a.0...
>  -> got one, spec 2 cells (0x00000003 0x00000008...) on /interrupt-controller2
>  -> mapped to linux irq 16
> Try to map irq for 0000:00:0a.1...
> PCI: PHB (bus 0) bridge rsrc 0: 0000000000000000-00000000000fffff [0x100], parent c0365060 (PCI IO)
> __request_resource - request 0xcf8045b0 name '/plb/pci@1ec000000' start 0x0 end 0xfffff
> __request_resource - no conflict parent 0xc0365060 sibling 0x00000000
> PCI: PHB (bus 0) bridge rsrc 1: 0000000180000000-000000018fffffff [0x200], parent c0365038 (PCI mem)
> __request_resource - request 0xcf8045d8 name '/plb/pci@1ec000000' start 0x180000000 end 0x18fffffff
> __request_resource - no conflict parent 0xc0365038 sibling 0x00000000
> PCI: Assigning unassigned resouces...
> pci_assign_unassigned_resources -#1- bus 0xcf82d400
> pci_assign_unassigned_resources -#2- bus 0xcf82d400
> pci_assign_resource - allocate with IORESOURCE_PREFETCH
> pci_bus_alloc_resource - enter
> pci_assign_resource - second pci_bus_alloc_resource call
> pci_bus_alloc_resource - enter
> pci_bus_alloc_resource - call allocate ressource size 0x8000000 startcalc 0xffffffff, align 0x8000000
> find_resource - size 0x8000000, min 0x180000000, max 0xffffffffffffffff
> find_resource - found start 0x180000000 end 0x187ffffff
> __request_resource - request 0xcf810578 name '0000:00:0a.0' start 0x180000000 end 0x187ffffff
> __request_resource - no conflict parent 0xcf8045d8 sibling 0x00000000
> pci_assign_resource - allocate with IORESOURCE_PREFETCH
> pci_bus_alloc_resource - enter
> pci_assign_resource - second pci_bus_alloc_resource call
> pci_bus_alloc_resource - enter
> pci_bus_alloc_resource - call allocate ressource size 0x8000000 startcalc 0xffffffff, align 0x8000000
> find_resource - size 0x8000000, min 0x180000000, max 0xffffffffffffffff
> find_resource - continue with start 0x188000000 on 0x00000000
> find_resource - found start 0x188000000 end 0x18fffffff
> __request_resource - request 0xcf810178 name '0000:00:0a.1' start 0x188000000 end 0x18fffffff
> __request_resource - no conflict parent 0xcf8045d8 sibling 0x00000000
> pci_assign_resource - allocate with IORESOURCE_PREFETCH
> pci_bus_alloc_resource - enter
> pci_assign_resource - second pci_bus_alloc_resource call
> pci_bus_alloc_resource - enter

    Ah, that's what happens -- BAR0 in functions 0/1 takes up the whole 265 
MiB of the PCI memory space (128+128), so no place is left for other memory BARs.

> pci_bus_alloc_resource - call allocate ressource size 0x20000 startcalc 0xffffffff, align 0x20000
> find_resource - size 0x20000, min 0x180000000, max 0xffffffffffffffff
> find_resource - continue with start 0x188000000 on 0xcf810178
> find_resource - continue with start 0x190000000 on 0x00000000
> find_resource - no this - exit
> PCI: pci_assign_resource - Failed to allocate mem resource #6:20000@190000000 for 0000:00:0a.0
> pci_assign_resource - allocate with IORESOURCE_PREFETCH
> pci_bus_alloc_resource - enter
> pci_bus_alloc_resource - call allocate ressource size 0x10000 startcalc 0xffffffff, align 0x10000
> find_resource - size 0x10000, min 0x180000000, max 0xffffffffffffffff
> find_resource - continue with start 0x188000000 on 0xcf810178
> find_resource - continue with start 0x190000000 on 0x00000000
> find_resource - no this - exit
> PCI: pci_assign_resource - Failed to allocate mem resource #2:10000@190000000 for 0000:00:0a.0
> pci_assign_resource - allocate with IORESOURCE_PREFETCH

    Hm, BAR2 shouldn't be allocated in theprefetchable space -- it corresponds 
to non-prefetchable (from lspci's output) MMIO register region...

WBR, Sergei
