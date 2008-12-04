Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BDB0DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 20:22:29 +1100 (EST)
Message-ID: <4937A143.2020100@embedded-sol.com>
Date: Thu, 04 Dec 2008 11:22:11 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Accessing PCI-E resources on 460EX
References: <490F6882.6050101@embedded-sol.com>	<1228118085.7356.115.camel@pasglop>	<4933C5AF.5040406@embedded-sol.com>	<1228165452.7356.123.camel@pasglop>
	<4935B900.5020405@embedded-sol.com>
In-Reply-To: <4935B900.5020405@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Ben

Sorry for confusion. With 2.6.28-rc6 mmap() of resource0  works fine.
The application still doesn't work, but that's because it's not reading what
it expects from resource file. I guess it's no longer a kernel problem.

Thanks a lot for your help.

Felix.

Felix Radensky wrote:
> Benjamin Herrenschmidt wrote:
>> On Mon, 2008-12-01 at 13:08 +0200, Felix Radensky wrote:
>>  
>>> and I'm afraid it can take me some time to move from 2.6.26 to 2.6.28.
>>> Any chance I can backport you modifications to 2.6.26 ? Have you
>>> modified
>>> other files except arch/powerpc/sysdev/ppc4xx_pci.c to fix these
>>> problems ?
>>>
>>>     
>>
>> Yes, quite a few changes in the PCI layer etc...
>>
>> Board support changes shouldn't be too hard to port over tho, it depends
>> how you did them.
>>   
>
> I've managed to run 2.6.28-rc6 on this platform, it was not that 
> difficult after all.
> I only had to remove PCIX and PCIE0 from Canyonlands DTS, as they are not
> used on this board. However this did not solve my problem. Below are 
> relevant
> bits from dmesg
>
> PCIE1: Checking link...
> PCIE1: Device detected, waiting for link...
> PCIE1: link is up !
> PCI host bridge /plb/pciex@d20000000 (primary) ranges:
> MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
>  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
> 4xx PCI DMA offset set to 0x00000000
> PCIE1: successfully set as root-complex
> PCI: Probing PCI hardware
> PCI: Hiding 4xx host bridge resources 0000:80:00.0
> pci 0000:81:00.0: disabling ASPM on pre-1.1 PCIe device.  You can 
> enable it with 'pcie_aspm=force'
> pci 0000:80:00.0: PCI bridge, secondary bus 0000:81
> pci 0000:80:00.0:   IO window: disabled
> pci 0000:80:00.0:   MEM window: 0x80000000-0x800fffff
> pci 0000:80:00.0:   PREFETCH window: disabled
> bus: 80 index 0 io port: [0x00-0xffff]
> bus: 80 index 1 mmio: [0xe80000000-0xeffffffff]
> bus: 81 index 0 mmio: [0x0-0xfff]
> bus: 81 index 1 mmio: [0xe80000000-0xe800fffff]
> bus: 81 index 2 mmio: [0x0-0x0]
> bus: 81 index 3 mmio: [0x0-0x0]
>
> The application code that mmaps PCI memory is attached.
> The attempt to access /sys/bus/pci/devices/0000:81:00.0/resource0
> results in I/O error. The device in question is Mellanox Infiniband
> switch. I will gladly test any other ideas you may have.
>
> Felix.
>> Cheers,
>> Ben.
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>   
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
