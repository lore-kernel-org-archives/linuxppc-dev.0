Message-Id: <m117LAK-0000WZC@tri-yann.crf.canon.fr>
Date: Thu, 22 Jul 1999 17:53:48 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: mporter@phx.mcd.mot.com
CC: Geert.Uytterhoeven@cs.kuleuven.ac.be, mmporter@home.com,
        jpeters@phx.mcd.mot.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.10.9907220749570.10882-100000@fwrsl-11.phx.mcd.mot.com>
	(message from Matt Porter on Thu, 22 Jul 1999 08:01:11 -0700 (MST))
Subject: Re: Is the vger 2.2 kernel branch dead
References: <Pine.LNX.4.10.9907220749570.10882-100000@fwrsl-11.phx.mcd.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Matt" == Matt Porter <mporter@phx.mcd.mot.com> writes:

Matt> On Thu, 22 Jul 1999, VALETTE Eric wrote:
>> >>>>> "Geert" == Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> writes:
>> 
Geert> AFAIK Cort is not on vacation. He checks in patches at vger on a daily base.
>> 
>> So why did I get no single comment on patches I submitted?
>> The Prep IDE handling is broken...

Matt> Define "PReP IDE handling is broken" because it isn't broken on systems
Matt> that use only the legacy PIC.  I only see breakage on MPIC Mot. systems
Matt> here with positive results on PowerStacks etc...

No no. Ide Byte swapping is broken again for PREP machines and 2.2.10 kernel...
(same type of patch you've send months ago)...

*** ./arch/ppc/kernel/prep_setup.c~	Fri Jun  4 22:30:47 1999
--- ./arch/ppc/kernel/prep_setup.c	Tue Jul  6 17:00:39 1999
***************
*** 629,641 ****
  void
  prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
  {
! 	_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  void
  prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
  {
! 	_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  int
--- 629,641 ----
  void
  prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
  {
! 	ide_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  void
  prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
  {
! 	ide_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
  }
  
  int
***************
*** 688,693 ****
--- 688,694 ----
  void
  prep_ide_fix_driveid(struct hd_driveid *id)
  {
+   	ppc_generic_ide_fix_driveid(id);
  }
  
  __initfunc(void

Matt> I assume you are referring to the MCP750 level inversion problem for one.

This problem is MCP750 specific and I did submit a patch for it...

Matt> The other problem is how the pci-ide driver snags interrupt 16 from the
Matt> PIB config space on all Mot. Raven/Hawk boards as the IDE interrupt.  I've
Matt> got patches for these things. They are not in the patch that Johnnie sent
Matt> in because there is an outstanding issue of the MTX IDE driver hanging on
Matt> the partition check that I would like to fix as well (even though nobody
Matt> should be using IDE if they paid for an MTX :).

Here is my patch for the via + ide...
Pease note that as IDE interrupt source can be assigned directly
at via level, the ultimate patche is in the via speciifc driver 
as I did...

*** ./drivers/block/via82c586.c~	Fri Nov 13 19:29:44 1998
--- ./drivers/block/via82c586.c	Tue Jul  6 18:03:18 1999
***************
*** 82,86 ****
--- 82,106 ----
  void ide_init_via82c586 (ide_hwif_t *hwif)
  {
  	set_via_timings(hwif);
+ #ifdef __powerpc__
+ 	/*
+ 	 * We are running in full DMA mode so we cannot use the PCI IRQ
+ 	 * for both ide0 and ide1 (which would happen if the follwoing code
+ 	 * was absent...)
+ 	 *
+ 	 * In theory we should go back and scan the PCI/ISA bridge PCI
+ 	 * configuration register (function 0 while hwif->pci_dev is function 1)
+ 	 * at offset 0x4a (IDE interrupt routing)
+ 	 *
+ 	 * The value below are the default value in the VIA doc...
+ 	 */
+ 	if (!(strcmp(hwif->name, "ide0"))) {
+ 	  hwif->irq = 14;
+ 	}
+ 	if (!(strcmp(hwif->name, "ide1"))) {
+ 	  hwif->irq = 15;
+ 	}
+ #endif	  
+ 	    
  }
  
*** ./drivers/block/ide-pci.c~	Mon Jan 25 06:54:35 1999
--- ./drivers/block/ide-pci.c	Tue Jul  6 17:39:39 1999
***************
*** 346,353 ****
  	for (port = 0; port <= 1; ++port) {
  		unsigned long base = 0, ctl = 0;
  		ide_pci_enablebit_t *e = &(d->enablebits[port]);
  		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask) != e->val))
! 			continue;	/* port not enabled */
  		if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE || (dev->class & (port ? 4 : 1)) != 0) {
  			ctl  = dev->base_address[(2*port)+1] & PCI_BASE_ADDRESS_IO_MASK;
  			base = dev->base_address[2*port] & ~7;
--- 346,365 ----
  	for (port = 0; port <= 1; ++port) {
  		unsigned long base = 0, ctl = 0;
  		ide_pci_enablebit_t *e = &(d->enablebits[port]);
+ #ifndef __powerpc__
  		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask) != e->val))
! 		  continue;	/* port not enabled */
! #else
! 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask) != e->val)) {
! 		  pci_write_config_byte(dev, e->reg, tmp | e->val);
! 		  if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) || (tmp & e->mask) != e->val))
! 		    printk("did not manage to enable port %d\n", port);
! 		}
! 		tmp = 0;
! 		pci_read_config_byte(dev, 0x9, &tmp);
! 		pci_write_config_byte(dev, 0x9, tmp | 0x1);
! 		pci_write_config_byte(dev, 0x3c, 0xf);
! #endif		
  		if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE || (dev->class & (port ? 4 : 1)) != 0) {
  			ctl  = dev->base_address[(2*port)+1] & PCI_BASE_ADDRESS_IO_MASK;
  			base = dev->base_address[2*port] & ~7;



-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
