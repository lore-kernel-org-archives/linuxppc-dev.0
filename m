Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 7102FDE196
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 02:12:41 +1100 (EST)
Message-ID: <47A3379F.2090004@coritel.it>
Date: Fri, 01 Feb 2008 16:15:43 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: External Interrupt
References: <47A2D424.3090903@coritel.it> <47A32C9C.3090709@ru.mvista.com>
In-Reply-To: <47A32C9C.3090709@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii
Cc: Linuxppc Embedded Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov ha scritto:
> Marco Stornelli wrote:
>> Hi,
>>
>> I used the linux kernel 2.6.10 with a processor MPC8548E. I wrote a
>> driver for a device connected with the local bus. This device has an
>> external interrupt. In the local bus driver I have used the macro
>> MPC85xx_IRQ_EXT<X> to get the interrupt number and pass it to the
>> driver and after that register the ISR. Now with a kernel 2.6.21 this
>> macro isn't available because in the header file irq.h there is the
>> option CONFIG_PPC_MERGE that disable those options. I think this
>> problem is related to the migration of ppc code towards powerpc. I
>> know that now there is the new device tree source file where I can add
>> a device and its interrupt number  but I think in this file I should
>> describe only the platform device, and this device is not a platform
>> device.
> 
>    How comes that it's not platform device if it hangs off the local bus?


In SoC system generally the platform device are (more or less) the
microprocessor controller like i2c, pci, local bus itself and so on. I
think is like if you consider a PCI board a platform device only because
it hangs off the PCI link.

> 
>> Then, how can I get now this  value? Is there some function to
>> call? How can I perform this operation?
> 
>    Probably irq_alloc_virt()...
> 
