Date: Wed, 5 Jan 2000 16:41:19 -0700
From: Matt Porter <mmporter@home.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
Message-ID: <20000105164119.C20193@cx258813-a.chnd1.az.home.com>
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
In-Reply-To: <20000104222421.A31468@hq.fsmlabs.com>; from cort@fsmlabs.com on Tue, Jan 04, 2000 at 10:24:21PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii

On Tue, Jan 04, 2000 at 10:24:21PM -0700, Cort Dougan wrote:
> 
> } Attached is a patch which allows to work Motorola PREP hardware (like
> } Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
> } selectively introduce the changes for the Motorola hardware only.
> } IBM's can stay with their irq 13 for IDE and with their preferred
> } method of non swapped data stream. I have no chance to test on IBM.
> 
> How would this work if both irqs arrive at the same time?
> 
> Johnnie, Matt - can you test this out on your systems?

Alois' IDE patch is a subset of the functionality that has made it into
2.2.14 from our IDE patch.  This patch doesn't account for the secondary
IDE controller on irq 15 among other things.  I'm attaching our full
patch as submitted versus 2.2.14pre4 so everybody can see the code I'm
talking about.  Note that changes to ide-pci.c, ide-probe.c, and sl82c105.c
in the patch got dropped and Alan said "maybe for 2.2.15".  The full patch
was tested on every board MCG has made with IDE. 

As for the 8259 patch, I think it may help the problem but will 
probably cause some bad situations disabling interrupts like that.  I
will test it out and see if it can be used or made better so we can
get these PReP 8259 problems behind us.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prepide-2.2.14pre4.patch"

Index: linux/arch/ppc/kernel/prep_pci.c
diff -u linux/arch/ppc/kernel/prep_pci.c:1.1.1.1.2.3 linux/arch/ppc/kernel/prep_pci.c:1.1.1.1.2.3.2.3
--- linux/arch/ppc/kernel/prep_pci.c:1.1.1.1.2.3	Wed Sep  1 09:44:56 1999
+++ linux/arch/ppc/kernel/prep_pci.c	Wed Nov  3 15:03:27 1999
@@ -170,7 +170,7 @@
 	0,	/* Slot 8  - unused */
 	0,	/* Slot 9  - unused */
 	0,	/* Slot 10 - unxued */
-	0,	/* Slot 11 - unused */
+	0x1e,	/* Slot 11 - PCI-ISA/IDE/USB */
 	0,	/* Slot 12 - unused */
 	0,	/* Slot 13 - unused */
 	2,	/* Slot 14 - Ethernet */
@@ -198,7 +198,7 @@
 	0,      /* Slot 8  - unused */
 	0,      /* Slot 9  - unused */
 	0,      /* Slot 10 - unxued */
-	0,      /* Slot 11 - unused */
+	0x1e,   /* Slot 11 - PCI-ISA/IDE/USB */
 	0,      /* Slot 12 - unused */
 	0,      /* Slot 13 - unused */
 	2,      /* Slot 14 - Ethernet */
@@ -224,7 +224,7 @@
 	0,	/* Slot 8  - unused */
 	0,	/* Slot 9  - unused */
 	0,	/* Slot 10 - unused */
-	0,	/* Slot 11 - unused */
+	0x1e,	/* Slot 11 - PCI-ISA/IDE/USB */
 	3,	/* Slot 12 - SCSI */
 	0,	/* Slot 13 - unused */
 	2,	/* Slot 14 - Ethernet */
@@ -253,7 +253,7 @@
         0,      /* Slot 8  - unused */
         0,      /* Slot 9  - unused */
         0,      /* Slot 10 - unused */
-        0,      /* Slot 11 - unused */
+        0x1e,   /* Slot 11 - PCI-ISA/IDE/USB */
         3,      /* Slot 12 - SCSI */
         0,      /* Slot 13 - unused */
         2,      /* Slot 14 - Ethernet 1 */
@@ -1076,40 +1076,91 @@
 	return;
 }
 
+int motopenpic_to_irq(int n)
+{
+       if (n & 0xF0) {
+               return (n & 0x0F);
+       } else {
+               return(openpic_to_irq(n));
+       }
+}
+
+void prep_pib_init(void)
+{
+unsigned char   reg;
+unsigned short  short_reg;
+
+struct pci_dev *dev = NULL;
+
+	if (( _prep_type == _PREP_Motorola) && (OpenPIC)) {
+		/*
+		 * Perform specific configuration for the Via Tech or
+		 * or Winbond PCI-ISA-Bridge part.
+		 */
+		if ((dev = pci_find_device(PCI_VENDOR_ID_VIA, 
+					PCI_DEVICE_ID_VIA_82C586_1, dev))) {
+			/*
+			 * PPCBUG does not set the enable bits
+			 * for the IDE device. Force them on here.
+			 */
+			pcibios_read_config_byte(dev->bus->number, 
+					dev->devfn, 0x40, &reg);
+
+			reg |= 0x03; /* IDE: Chip Enable Bits */
+			pcibios_write_config_byte(dev->bus->number, 
+					dev->devfn, 0x40, reg);
+
+		} else if ((dev = pci_find_device(PCI_VENDOR_ID_WINBOND, 
+					PCI_DEVICE_ID_WINBOND_83C553, dev))) {
+			/*
+			 * Clear the PCI Interrupt Routing Control Register.
+			 */
+			short_reg = 0x0000;
+			pcibios_write_config_word(dev->bus->number, 
+					dev->devfn, 0x44, short_reg);
+		}
+	}
+}
 __initfunc(
 void
 prep_pcibios_fixup(void))
 {
-        struct pci_dev *dev;
-        extern unsigned char *Motherboard_map;
-        extern unsigned char *Motherboard_routes;
-        unsigned char i;
-
-        if ( _prep_type == _PREP_Radstone )
-        {
-                printk("Radstone boards require no PCI fixups\n");
+extern unsigned char *Motherboard_map;
+extern unsigned char *Motherboard_routes;
+unsigned char	i;
+struct pci_dev  *dev;
+
+	if (_prep_type == _PREP_Radstone) {
+		printk("Radstone boards require no PCI fixups\n");
 		return;
-        }
+	}
 
 	prep_route_pci_interrupts();
 
+	prep_pib_init();
+
 	printk("Setting PCI interrupts for a \"%s\"\n", Motherboard_map_name);
+
 	if (OpenPIC) {
-		/* PCI interrupts are controlled by the OpenPIC */
-		for(dev=pci_devices; dev; dev=dev->next) {
-			if (dev->bus->number == 0) {
-                       		dev->irq = openpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
-				pcibios_write_config_byte(dev->bus->number, dev->devfn, PCI_INTERRUPT_PIN, dev->irq);
-			} else {
-				if (Motherboard_non0 != NULL)
-					Motherboard_non0(dev);
-			}
+
+	    /* PCI interrupts are controlled by the OpenPIC */
+	    for(dev=pci_devices; dev; dev=dev->next) {
+		if (dev->bus->number == 0) {
+		    dev->irq = 
+		       motopenpic_to_irq(Motherboard_map[PCI_SLOT(dev->devfn)]);
+
+		    pcibios_write_config_byte(dev->bus->number, dev->devfn, 
+					      PCI_INTERRUPT_PIN, dev->irq);
+		} else {
+			if (Motherboard_non0 != NULL)
+				Motherboard_non0(dev);
 		}
-		return;
+
+	    }
+	return;
 	}
 
-	for(dev=pci_devices; dev; dev=dev->next)
-	{
+	for(dev=pci_devices; dev; dev=dev->next) {
 		/*
 		 * Use our old hard-coded kludge to figure out what
 		 * irq this device uses.  This is necessary on things
@@ -1118,29 +1169,26 @@
 		unsigned char d = PCI_SLOT(dev->devfn);
 		dev->irq = Motherboard_routes[Motherboard_map[d]];
 
-		for ( i = 0 ; i <= 5 ; i++ )
-		{
-		        if ( dev->base_address[i] > 0x10000000 )
-		        {
-		                printk("Relocating PCI address %lx -> %lx\n",
-		                       dev->base_address[i],
-		                       (dev->base_address[i] & 0x00FFFFFF)
-		                       | 0x01000000);
-		                dev->base_address[i] =
-		                  (dev->base_address[i] & 0x00FFFFFF) | 0x01000000;
-		                pci_write_config_dword(dev,
-		                        PCI_BASE_ADDRESS_0+(i*0x4),
-		                       dev->base_address[i] );
-		        }
+		for ( i = 0 ; i <= 5 ; i++ ) {
+			if ( dev->base_address[i] > 0x10000000 ) {
+				printk("Relocating PCI address %lx -> %lx\n",
+				dev->base_address[i],
+				(dev->base_address[i] & 0x00FFFFFF)|0x01000000);
+
+				dev->base_address[i] = (dev->base_address[i] & 
+							0x00FFFFFF)|0x01000000;
+				pci_write_config_dword(dev, 
+						PCI_BASE_ADDRESS_0+(i*0x4),
+						dev->base_address[i] );
+			}
 		}
 #if 0
-		/*
-		 * If we have residual data and if it knows about this
-		 * device ask it what the irq is.
-		 *  -- Cort
-		 */
-		ppcd = residual_find_device_id( ~0L, dev->device,
-		                                -1,-1,-1, 0);
+	/*
+	 * If we have residual data and if it knows about this
+	 * device ask it what the irq is.
+	 *  -- Cort
+	 */
+	ppcd = residual_find_device_id( ~0L, dev->device, -1,-1,-1, 0);
 #endif
 	}
 }
Index: linux/arch/ppc/kernel/prep_setup.c
diff -u linux/arch/ppc/kernel/prep_setup.c:1.1.1.1.2.3 linux/arch/ppc/kernel/prep_setup.c:1.1.1.1.2.3.2.2
--- linux/arch/ppc/kernel/prep_setup.c:1.1.1.1.2.3	Wed Sep  1 09:44:56 1999
+++ linux/arch/ppc/kernel/prep_setup.c	Thu Oct 21 15:53:24 1999
@@ -628,25 +628,36 @@
 void
 prep_ide_insw(ide_ioreg_t port, void *buf, int ns)
 {
-	_insw((unsigned short *)((port)+_IO_BASE), buf, ns);
+	ide_insw(((port)+(_IO_BASE)), buf, ns);
 }
 
 void
 prep_ide_outsw(ide_ioreg_t port, void *buf, int ns)
 {
-	_outsw((unsigned short *)((port)+_IO_BASE), buf, ns);
+	ide_outsw(((port)+_IO_BASE), buf, ns);
 }
 
 int
 prep_ide_default_irq(ide_ioreg_t base)
 {
-	switch (base) {
-		case 0x1f0: return 13;
-		case 0x170: return 13;
-		case 0x1e8: return 11;
-		case 0x168: return 10;
-		default:
-                        return 0;
+	if ( _prep_type == _PREP_IBM ) {
+		switch (base) {
+			case 0x1f0: return 13;
+			case 0x170: return 13;
+			case 0x1e8: return 11;
+			case 0x168: return 10;
+			default:
+				return 0;
+		}
+	} else {
+		switch (base) {
+			case 0x1f0: return 14;
+			case 0x170: return 14;
+			case 0x1e8: return 15;
+			case 0x168: return 15;
+			default:
+				return 0;
+		}
 	}
 }
 
@@ -687,6 +698,7 @@
 void
 prep_ide_fix_driveid(struct hd_driveid *id)
 {
+	ppc_generic_ide_fix_driveid(id);
 }
 
 __initfunc(void
Index: linux/drivers/block/ide-pci.c
diff -u linux/drivers/block/ide-pci.c:1.1.1.1 linux/drivers/block/ide-pci.c:1.1.1.1.6.1
--- linux/drivers/block/ide-pci.c:1.1.1.1	Wed Jul 14 10:06:39 1999
+++ linux/drivers/block/ide-pci.c	Wed Oct 13 09:54:39 1999
@@ -322,6 +322,7 @@
 	/*
 	 * Can we trust the reported IRQ?
 	 */
+
 	pciirq = dev->irq;
 	if ((dev->class & ~(0xfa)) != ((PCI_CLASS_STORAGE_IDE << 8) | 5)) {
 		printk("%s: not 100%% native mode: will probe irqs later\n", d->name);
@@ -381,8 +382,10 @@
 				mate->serialized = 1;
 			}
 		}
-		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A) ||
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886BF))
+		if ( (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886A)) ||
+		     (IDE_PCI_DEVID_EQ(d->devid, DEVID_UM8886BF)) ||
+                     (IDE_PCI_DEVID_EQ(d->devid, DEVID_W82C105)) ||
+		     (IDE_PCI_DEVID_EQ(d->devid, DEVID_VP_IDE)) )
 			hwif->irq = hwif->channel ? 15 : 14;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
Index: linux/drivers/block/ide-probe.c
diff -u linux/drivers/block/ide-probe.c:1.1.1.1 linux/drivers/block/ide-probe.c:1.1.1.1.6.1
--- linux/drivers/block/ide-probe.c:1.1.1.1	Wed Jul 14 10:06:38 1999
+++ linux/drivers/block/ide-probe.c	Wed Oct 13 09:54:39 1999
@@ -133,15 +133,7 @@
 	 */
 	if (id->config & (1<<7))
 		drive->removable = 1;
-	/*
-	 * Prevent long system lockup probing later for non-existant
-	 * slave drive if the hwif is actually a flash memory card of some variety:
-	 */
-	if (drive_is_flashcard(drive)) {
-		ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
-		mate->present = 0;
-		mate->noprobe = 1;
-	}
+
 	drive->media = ide_disk;
 	printk("ATA DISK drive\n");
 	return;
Index: linux/drivers/block/sl82c105.c
diff -u linux/drivers/block/sl82c105.c:1.1.1.1 linux/drivers/block/sl82c105.c:1.1.1.1.6.1
--- linux/drivers/block/sl82c105.c:1.1.1.1	Wed Jul 14 10:06:40 1999
+++ linux/drivers/block/sl82c105.c	Wed Oct 13 09:54:39 1999
@@ -17,20 +17,73 @@
 
 void ide_init_sl82c105(ide_hwif_t *hwif)
 {
+	static char done_once = 0;
 	struct pci_dev *dev = hwif->pci_dev;
 	unsigned short t16;
 	unsigned int t32;
-	pci_read_config_word(dev, PCI_COMMAND, &t16);
-	printk("SL82C105 command word: %x\n",t16);
-        t16 |= PCI_COMMAND_IO;
-        pci_write_config_word(dev, PCI_COMMAND, t16);
-	/* IDE timing */
-	pci_read_config_dword(dev, 0x44, &t32);
-	printk("IDE timing: %08x, resetting to PIO0 timing\n",t32);
-	pci_write_config_dword(dev, 0x44, 0x03e4);
-#ifndef CONFIG_MBX
-	pci_read_config_dword(dev, 0x40, &t32);
-	printk("IDE control/status register: %08x\n",t32);
-	pci_write_config_dword(dev, 0x40, 0x10ff08a1);
-#endif /* CONFIG_MBX */
+	/* 
+	 * Consult the WinBond Manual and your drive specification
+	 * before making changes to the drive mode operation.
+	 * Not all drives support the different modes.
+	 * 0x05ed  PIO0 
+	 * 0x04e7  PIO1
+	 * 0x03e4  PIO2
+	 * 0x02e2  PIO3
+	 * 0x02e0  PIO4
+	 * 0x01e0  PIO5
+	 */
+	unsigned int timing_mode = 0x03e4; /* PIO2: Default setting */
+
+	if (!done_once) {
+		pci_read_config_word(dev, PCI_COMMAND, &t16);
+		printk("SL82C105 command word: %x\n",t16);
+		t16 |= PCI_COMMAND_IO;
+		pci_write_config_word(dev, PCI_COMMAND, t16);
+
+		/* Initialize the IDE Control/Status Register */
+		pci_read_config_dword(dev, 0x40, &t32);
+		printk("IDE control/status register: %08x\n",t32);
+		pci_write_config_dword(dev, 0x40, 0x10ff0033);
+
+		done_once = 1;
+	}
+
+	/*
+	 * Initialize the Port x Drive x Control Registers.
+	 */
+	switch (hwif->major) {
+	case IDE0_MAJOR: 
+		/* IDE timing */
+
+		/* Port 0 Drive 0 */
+		pci_read_config_dword(dev, 0x44, &t32);
+		printk("Setting %s from 0x%x to PIO2 timing, 0x%x\n",
+				hwif->drives[0].name, t32, timing_mode);
+		pci_write_config_dword(dev, 0x44, timing_mode);
+
+		/* Port 0 Drive 1 */
+		pci_read_config_dword(dev, 0x48, &t32);
+		printk("Setting %s from 0x%x to PIO2 timing, 0x%x\n",
+				hwif->drives[1].name, t32, timing_mode);
+		pci_write_config_dword(dev, 0x48, timing_mode);
+		break;
+	case IDE1_MAJOR: 
+		/* IDE timing */
+
+		/* Port 1 Drive 0 */
+		pci_read_config_dword(dev, 0x4c, &t32);
+		printk("Setting %s from 0x%x to PIO2 timing, 0x%x\n",
+				hwif->drives[0].name, t32, timing_mode);
+		pci_write_config_dword(dev, 0x4c, timing_mode);
+
+		/* Port 1 Drive 1 */
+		pci_read_config_dword(dev, 0x50, &t32);
+		printk("Setting %s from 0x%x to PIO2 timing, 0x%x\n",
+				hwif->drives[1].name, t32, timing_mode);
+		pci_write_config_dword(dev, 0x50, timing_mode);
+		break;
+
+	default:
+		printk("%s: Unable to set IDE Timing\n", hwif->name);
+	}
 }

--vkogqOf2sHV7VnPd--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
