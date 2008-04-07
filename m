Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 724DEDDED9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 23:03:08 +1000 (EST)
Message-ID: <47FA1B20.40609@ru.mvista.com>
Date: Mon, 07 Apr 2008 17:01:20 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC: Add PCI entry to 440EPx Sequoia DTS.
References: <20071221162601.GA1700@ru.mvista.com>
	<47F7A935.3080803@ru.mvista.com>
In-Reply-To: <47F7A935.3080803@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
> Valentine Barshak wrote:
> 
>> This adds PCI entry to PowerPC 440EPx Sequoia DTS.
> 
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
>> --- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts    2007-12-21 
>> 17:14:17.000000000 +0300
>> +++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts    2007-12-21 
>> 17:18:32.000000000 +0300
>> @@ -324,6 +324,33 @@
>>                  has-new-stacr-staopc;
>>              };
>>          };
>> +
>> +        PCI0: pci@1ec000000 {
>> +            device_type = "pci";
>> +            #interrupt-cells = <1>;
>> +            #size-cells = <2>;
>> +            #address-cells = <3>;
>> +            compatible = "ibm,plb440epx-pci", "ibm,plb-pci";
>> +            primary;
>> +            reg = <1 eec00000 8    /* Config space access */
>> +                   1 eed00000 4    /* IACK */
>> +                   1 eed00000 4    /* Special cycle */
>> +                   1 ef400000 40>;    /* Internal registers */
>> +
>> +            /* Outbound ranges, one memory and one IO,
>> +             * later cannot be changed. Chip supports a second
>> +             * IO range but we don't use it for now
>> +             */
>> +            ranges = <02000000 0 80000000 1 80000000 0 10000000
> 
>    I wonder why the AMCC's Sequoia/Rainier manual has PCI memory mapped 
> at 0x80000000-0xbfffffff? The 0x80000000-0x8fffffff mapping was assumed 
> by arch/ppc/ code.  What/why changed here?

The addresses in the manual are relative to bus base. PCI controller is 
located on the PLB and PLB base address is 0x100000000ULL on Sequoia.
Older PPC code has ioremap64 function that did the 64 to 32-bit trick
It's been abolished. The kernel has support for 64-bit physical 
addresses on 32-bit. IMHO there's no big reason to keep doing that 
address trick. However, there are some drivers that use unsigned long 
for storing physical addresses. This is wrong, since 
pci_resource_start() returns a resource_size_t value. I think it's these 
drivers that have to be fixed instead of adding workarounds to ppc4xx code.
Thanks,
Valentine.

>    As we now both know, having PCI memory space mapped beyound 4 GB 
> makes some drivers misbehave as they use 'unsigned long' to store the 
> result of pci_resource_start() and later ioremap() this truncated value 
> -- which is 64-bit on Sequoia due to CONFIG_RESOURCE_64BIT=y that is 
> needed to store the beyond-4GB addresses.
> 
>> +                01000000 0 00000000 1 e8000000 0 00100000>;
>> +
>> +            /* Inbound 2GB range starting at 0 */
>> +            dma-ranges = <42000000 0 0 0 0 0 80000000>;
>> +
>> +            /* All PCI interrupts are routed to IRQ 67 */
>> +            interrupt-map-mask = <0000 0 0 0>;
>> +            interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
>> +        };
>>      };
> 
> WBR, Sergei
