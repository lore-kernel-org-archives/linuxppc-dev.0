Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [82.161.242.14])
	by ozlabs.org (Postfix) with ESMTP id DB51BDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 16:48:07 +1000 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l4N6kbN02234
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 May 2007 08:46:37 +0200 (MEST)
Message-ID: <4653E3A3.8020600@dutchspace.nl>
Date: Wed, 23 May 2007 08:48:03 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problems with access to PCI on MVME3100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am working on porting a PCI driver from I386-Linux to PPC (MVME-3100). 
The device is a Reflective Memory card (VMIC 5565), and we use a driver 
based on the standard Linux driver, provided by the supplier.

I try to start a DMA transfer (using the DMA engine on the PCI card) 
from user space, but then I get a PCI Error. The following data is 
displayed:
PCI Error!
PCI ERROR DETECT REG 0x00000042
PCI ERROR ADDRESS REG 0x00fffa00
PCI ERROR EXT ADDRESS REG 0x00000000
PCI ERROR ATTRIBUTES REG 0x0000c001
PCI ERROR DATA HIGH REG 0x60010004
PCI ERROR DATA LOW REG 0x10060020
PCI STATUS REG 0x0000
PCI GASKET TIMER REG 0x00003fff
PCI PCIX TIMER REG 0x01ffffff

Access to the registers from kernel mode is no problem. I did an mmap to 
map the registers into user space, and then access the registers as an 
array of chars or ints. Is there a limitation in access to PCI registers 
from user space on PPC?

When I try to do this in kernel mode I don't get any errors, but the 
transfer is not started. I am not sure if this is a SW problem, or that 
it might be caused by the PCI-PCI bridge.

The code runs perfectly on a I386 platform, and I use read[bwl] and 
write[bwl] to access the registers, so this should fix the endianess 
problems that exist.

Below is the PCI information from the card:
01:00.0 Network controller: VMIC: Unknown device 5565 (rev 01)
       Subsystem: PLX Technology, Inc.: Unknown device 9656
       Flags: 66Mhz, medium devsel, IRQ 52
       Memory at 00000000dfeffe00 (32-bit, non-prefetchable) [size=512]
       I/O ports at e0ffff00 [size=256]
       Memory at 00000000dfeffdc0 (32-bit, non-prefetchable) [size=64]
       Memory at 00000000d8000000 (32-bit, non-prefetchable) [size=64M]
       Capabilities: [40] Power Management version 2
       Capabilities: [48] #00 [0080]

Kind regards,
    Johan Borkhuis
