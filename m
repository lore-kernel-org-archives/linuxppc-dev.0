Return-Path: <MCarey@nearfield.com>
Received: from webmail.nearfield.com (webmail.nearfield.com [63.200.6.70])
	by ozlabs.org (Postfix) with ESMTP id 20AFBDDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Jan 2007 11:31:23 +1100 (EST)
Message-Id: <45A3BE1F0200007100004438@webmail.nearfield.com>
Date: Tue, 09 Jan 2007 16:09:03 -0800
From: "Michael Carey" <MCarey@nearfield.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: ELDK 3.1.1: PCI Video Cards on Lite5200B
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ed_ Jubenville <ed@dacsco.com>, Dan Slater <dslater@ix.netcom.com>,
	Craig Javid <CJavid@nearfield.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone gotten a pci video card to work on a Lite5200B board?

I have tried several types of ATI PCI cards in our board (based on
Lite5200B reference design).

The simplest card I have tried is a Ati Rage XL.  Its Vendor ID and
Device ID are 1002 & 474D.  I was able to find references to it in
devlist.h and pci_ids.h but I could not find anything in atyfb_base.c. 
I created an entry in atychips[] which was based on a hopefully similar
device ID = 4752.

When I booted linux with this configuration, I got the following debug
sequence:
The MJC messages are my debug output messages.
**************************
MJC: chr_dev_init in mem.c:770
MJC: registering devfs chrdev. chr_dev_init in mem.c:771
MJC: registering memory devfs. chr_dev_init in mem.c:774
MJC: memory_devfs_register in mem.c:756
MJC: rand initializing. chr_dev_init in mem.c:776
MJC: initing fbmem. chr_dev_init in mem.c:783
MJC: fbmem_init in drivers/video/fbmem.c:936
MJC: initing pref funcs. fbmem_init in drivers/video/fbmem.c:954
MJC: initing fb drivers. fbmem_init in drivers/video/fbmem.c:958
mjc: atyfb_init in drivers/video/aty/atyfb_base.c:2475
mjc: pci_find_device in drivers/pci/pci.c:129
mjc: pci_find_subsys in drivers/pci/pci.c:100
             pdev->device=474d, i=21, pci_id=474d
mjc: kmalloc workd; info points in memory: atyfb_init in
drivers/video/aty/atyfb_base.c:2522
rp->start=0:0
mjc:  apparently not a IORESOURCE_IO: atyfb_init in
drivers/video/aty/atyfb_base.c:2543
mjc: pci_find_device in drivers/pci/pci.c:129
mjc: pci_find_subsys in drivers/pci/pci.c:100
mjc: atyfb_init in drivers/video/aty/atyfb_base.c:3066
mjc: done: atyfb_init in drivers/video/aty/atyfb_base.c:3123
mjc: aty128fb_init in drivers/video/aty128fb.c:2013
mjc: pci_find_device in drivers/pci/pci.c:129
mjc: pci_find_subsys in drivers/pci/pci.c:100
mjc: aty128_pci_register in drivers/video/aty128fb.c:2046
mjc: pci_enable_device in drivers/pci/pci.c:416
mjc: pci_enable_device_bars in drivers/pci/pci.c:398
mjc: pci_set_power_state in drivers/pci/pci.c:274
mjc: pci_find_capability in drivers/pci/pci.c:192
MJC: pcibios_enable_device in arch/ppc/kernel/pci.c:1549
aty128fb: cannot reserve frame buffer memory
Trying to free nonexistent resource <00000000-ffffffff>
mjc: pci_find_device in drivers/pci/pci.c:129
mjc: pci_find_subsys in drivers/pci/pci.c:100
*************************
I realize that I was just guessing by adding an entry into atychips[],
and I am not tied to that video card.  I have tried an ATI  7500 card as
it seems to be supported although EXPERIMENTAL ly, but u-boot doesnt
seem to recognize its configuration space or at least report a card
present. 

Has anyone had success in trying to get 2D graphics or even text to
display from a pci video card on a Lite5200B board?

Thanks in advance for any help or information you could provide.

Michael Carey
