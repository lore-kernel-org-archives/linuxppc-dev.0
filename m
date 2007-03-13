Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (unknown [82.161.242.14])
	by ozlabs.org (Postfix) with ESMTP id B6F5EDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 02:40:12 +1100 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l2DFRat01158
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 16:27:36 +0100 (MET)
Message-ID: <45F6C301.6080502@dutchspace.nl>
Date: Tue, 13 Mar 2007 16:28:01 +0100
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problem initialising PCI device
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

I am working with a MEN A14C board (PPC 8540), and I am trying to get a 
Reflective Memory card (VMIC 5565) working in one of the PMC slots 
using  Linux (ELinOS).

When I load the driver I am able to access the registers of the card 
using the pci access routines (pci_read_config_word, etc.), but when I 
try to access the registers or the memory on the card using memory 
mapped access this does not work.

The PMC bus is separated from the main PCI bus by a PCI-PCI bridge (Hint 
Corp HB2 PCI-PCI Bridge (rev 04), vendor 0x3388, device 0x0026). For 
some other devices (that are connected directly to the PCI bus) I don't 
have any problems accessing the memory directly.

Am I forgetting something, or is there something else wrong here?

Below is the code I use to access the reflective memory card (this code 
is cut from the _init_one function):

 pci_enable_device(dev);

 err = pci_request_regions(dev, "RFM");
 if (err != 0) {
   os_print(OS_ERR "Cannot obtain PCI resources\n");
   return( -ENOMEM );
 }

 /* Get the physical address of the local and runtime registers */
 unit->physAddrOr = pci_resource_start(dev, 0);
 data->orRegs = ioremap_nocache(unit->physAddrOr, 0x40);

 /* Get the physical address of the control and status registers */
 unit->physAddrCs = pci_resource_start(dev, 2);
 data->csRegs = ioremap_nocache(unit->physAddrCs, 0x40);

   printk(KERN_ERR "OR: %8.8x, CS: %8.8x\n", unit->physAddrOr, 
unit->physAddrCs);
   printk(KERN_ERR "OR: %8.8x, CS: %8.8x\n", data->orRegs, data->csRegs);
   for(i = 0; i < 4; i++)
   {
       printk( KERN_ERR"%2.2x: %8.8x\n", i, os_readl(data->csRegs + i*4));
   }

The code above generates the following output:

OR: dffffe00, CS: dffffdc0
OR: e106ae00, CS: e106cdc0
00: 86000300
01: 86000300
02: 86000300
03: 86000300

I would expect the data from the card, as reported by lspci. So instead 
of "00: 86000300" I would expect something like "00:5565114a", which is 
the ident of the card.

Thank you for your time and (hopefully) your answer.

Kind regard,
    Johan Borkhuis
