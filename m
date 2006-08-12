Return-Path: <Rajan.Rai@ingenient.com>
Received: from mail.ingenient.com (unknown [63.87.52.245])
	by ozlabs.org (Postfix) with ESMTP id 02D0B67BDB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 22:35:29 +1000 (EST)
Message-ID: <44DDCAB8.80106@ingenient.com>
Date: Sat, 12 Aug 2006 08:34:00 -0400
From: Rajan Rai <Rajan.Rai@ingenient.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI driver on EB8347
References: <995B09A8299C2C44B59866F6391D2635018CA7@zch01exm21.fsl.freescale.net>
	<4DA89577C33E194ABEBC978921E858541B8E3B@exchange.ingenient.net>
	<94857DB0-ABC7-4AA5-BE5B-1CBEAA09D906@kernel.crashing.org>
In-Reply-To: <94857DB0-ABC7-4AA5-BE5B-1CBEAA09D906@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



          Thanks IRQ problem is resolved. As  pointed out it was problem 
with IRQ IDSEL mapping. Mapping needs to be different on Eval board I'm 
using and our custom design. But my driver is still not working on our 
custom design. PCI device doesn't receive any messages from MPC8347 on 
our custom design mother board which uses pci-bridge where as it works 
fine on Eval board which doesn't use PCI bridge.

                         I guess problem lies at the kernel level and 
not the driver. Any tips apart from IDSEL IRQ settings at kernel level 
what else I need to change when I move from 1 mother board to another.  
My PCI  devices do get base address 0 and 1 allocated properly by the 
OS. But when I try to write any messages on those addresses PCI device 
doesn't see them

Regards,
-Rajan

Kumar Gala wrote:
>
> On Aug 11, 2006, at 4:15 AM, rajan rai wrote:
>
>>
>>                       I'm using polling mechanism and not interrupts 
>> in my driver. Although I'm not using polling I see strange behavior 
>> When I do lspci -v I don't see any interrupts being allocated to PCI 
>> device behind PCI bridge !!!! But when I use same card directly on 
>> primary bus I do see interrupt being allocated to PCI device. Any 
>> advise why IRQ's being not allocated in case its attached to PCI 
>> bridge ?
>>
>>                               Do I need to take care of any extra 
>> configuration in case of PCI card is attached to PCI bridge ?
>
> You need to make sure that the pci_map_irq/mpc83xx_map_irq function 
> handles the right swizziling for the P2P bridge for your setup.  If 
> you are just connected directly its pretty straight forward.  However 
> IRQ assignment behind the bridge can be very board specific and so you 
> need to make sure that the code is doing the right think for you.
>
> What ever strangeness do you see from lspci?
>
> - k
>
>
