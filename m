In-Reply-To: <40BEEA15.3070505@intracom.gr>
References: <40BEEA15.3070505@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9A23BE48-B54C-11D8-853B-003065F9B7DC@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: new dma API questions
Date: Thu, 3 Jun 2004 06:56:01 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jun 3, 2004, at 5:06 AM, Pantelis Antoniou wrote:


> 1. dma_map_single finally calls virt_to_bus, which is simplified
>   to:
>      return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
>
>   PCI_DRAM_OFFSET is defined to be pci_dram_offset.
>   Typically it is set be 0 for most arches without pci.

It's typically set to zero for all architectures.

>   How could we overide it with a constant 0 so that we avoid the
>   memory access?

What memory access?

> 2. How soon in the init sequence could we call dma_alloc_consistent?

Not soon enough.

>   For example when setting up a serial console on 8xx I need memory
>   for the fifos, and I have to revert in using m8xx_hostalloc which
>   IMO should be already dead.

As you pointed out, that is going to have to stay for a while.  The
CPM and peripherals must do DMA long before the generic
supporting functions are ready.

>   If we could arrange for consistent_alloc to be able to operate with
>   a fixed memory area until the memory initialization is complete
>   it would make my life much easier and we could finally kill
>   m8xx_hostalloc & friends.

I don't think it is worth the complication.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
