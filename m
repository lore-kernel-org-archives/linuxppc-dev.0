Message-ID: <40BEEA15.3070505@intracom.gr>
Date: Thu, 03 Jun 2004 12:06:29 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>,
	Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: new dma API questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there.

I have a few questions regarding the new DMA API.

1. dma_map_single finally calls virt_to_bus, which is simplified
   to:
      return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;

   PCI_DRAM_OFFSET is defined to be pci_dram_offset.
   Typically it is set be 0 for most arches without pci.
   How could we overide it with a constant 0 so that we avoid the
   memory access?

2. How soon in the init sequence could we call dma_alloc_consistent?
   For example when setting up a serial console on 8xx I need memory
   for the fifos, and I have to revert in using m8xx_hostalloc which
   IMO should be already dead.

   If we could arrange for consistent_alloc to be able to operate with
   a fixed memory area until the memory initialization is complete
   it would make my life much easier and we could finally kill
   m8xx_hostalloc & friends.

3. The first argument is dma_* function is a struct device.
   When working with network devices I must set this to NULL.
   Granted this is no problem right now, but could this be
   a problem in the future?

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
