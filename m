Message-ID: <394306A3.3D4DFE85@mandrakesoft.com>
Date: Sat, 10 Jun 2000 23:25:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: cort@fsmlabs.com, paulus@linuxcare.com, dan@synergymicro.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: PATCH: ncr885e PPC patch look ok to you?
Content-Type: multipart/mixed;
 boundary="------------A99C6FEDAB0E26089069FF2F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------A99C6FEDAB0E26089069FF2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Does this patch, against 2.4.0-test1-ac13, look ok to you guys?

It includes the following changes for 2.3/2.4:

* Use init_etherdev's second argument to allocate automatically a
private structure for each board instance.  This eliminates some code
during board init

* do not loop on pci_find_device and then break out of the loop, because
we only support finding and initializing a single board

* use pci_enable_device to wake up device, and turn on PIO and MMIO
areas as necessary

* do not read base address registers and IRQ line directly from
hardware.  Read from struct pci_dev instead.  Use pci_resource_xxx where
appropriate to wrap direct pci-dev struct access.

* use pci_set_master to set busmastering and raise min latency, removing
code which did it "the manual way"

NOTE:  Maybe a PPC kernel expert can tell me whether pci_enable_device
on PPC actually enabled PIO/MMIO regions correctly?  If so, this patch
can, in addition to the change above, also remove the "manual" setting
of the PIO bit in PCI_COMMAND.

Regards,

	Jeff






--
Jeff Garzik              | Liberty is always dangerous, but
Building 1024            | it is the safest thing we have.
MandrakeSoft, Inc.       |      -- Harry Emerson Fosdick
--------------A99C6FEDAB0E26089069FF2F
Content-Type: text/plain; charset=us-ascii;
 name="ncr885e.patch"
Content-Disposition: inline;
 filename="ncr885e.patch"
Content-Transfer-Encoding: 7bit

Index: drivers/net/ncr885e.c
===================================================================
RCS file: /g/cvslan/linux_2_3/drivers/net/ncr885e.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 ncr885e.c
--- drivers/net/ncr885e.c	2000/05/21 10:52:34	1.1.1.9
+++ drivers/net/ncr885e.c	2000/06/11 03:19:15
@@ -1144,18 +1144,11 @@
 	unsigned char *p;
 	int  i;

-	dev = init_etherdev(NULL, 0 );
-
-	/* construct private data for the 885 ethernet */
-	dev->priv = kmalloc( sizeof( struct ncr885e_private ), GFP_KERNEL );
-
-	if ( dev->priv == NULL ) {
-		release_region( ioaddr, NCR885E_TOTAL_SIZE );
+	dev = init_etherdev( NULL, sizeof( struct ncr885e_private ) );
+	if (!dev)
 		return -ENOMEM;
-	}

-	sp = (struct ncr885e_private *) dev->priv;
-	memset( sp, 0, sizeof( struct ncr885e_private ));
+	sp = dev->priv;

 	/* snag the station address and display it */
 	for( i = 0; i < 3; i++ ) {
@@ -1210,7 +1203,8 @@
 	unsigned short cmd;
 	unsigned char irq, latency;

-	while(( pdev = pci_find_device( PCI_VENDOR_ID_NCR,
+	/* use 'if' not 'while' where because driver only supports one device */
+	if (( pdev = pci_find_device( PCI_VENDOR_ID_NCR,
 					PCI_DEVICE_ID_NCR_53C885_ETHERNET,
 					pdev )) != NULL ) {

@@ -1219,11 +1213,13 @@
 			printk( KERN_INFO "%s", version );
 		}

+		if (pci_enable_device(pdev))
+			continue;
+
 		/* Use I/O space */
-		pci_read_config_dword( pdev, PCI_BASE_ADDRESS_0, &ioaddr );
-		pci_read_config_byte( pdev, PCI_INTERRUPT_LINE, &irq );
+		ioaddr = pci_resource_start (pdev, 0);
+		irq = pdev->irq;

-		ioaddr &= ~3;
 		/* Adjust around the Grackle... */
 #ifdef CONFIG_GEMINI
 		ioaddr |= 0xfe000000;
@@ -1237,28 +1233,16 @@

 			chips++;

+			pci_set_master (pdev);
+
 			/* Access is via I/O space, bus master enabled... */
 			pci_read_config_word( pdev, PCI_COMMAND, &cmd );

-			if ( !(cmd & PCI_COMMAND_MASTER) ) {
-				printk( KERN_INFO "  PCI master bit not set! Now setting.\n");
-				cmd |= PCI_COMMAND_MASTER;
-				pci_write_config_word( pdev, PCI_COMMAND, cmd );
-			}
-
 			if ( !(cmd & PCI_COMMAND_IO) ) {
 				printk( KERN_INFO "  Enabling I/O space.\n" );
 				cmd |= PCI_COMMAND_IO;
 				pci_write_config_word( pdev, PCI_COMMAND, cmd );
 			}
-
-			pci_read_config_byte( pdev, PCI_LATENCY_TIMER, &latency );
-
-			if ( latency < 10 ) {
-				printk( KERN_INFO "  PCI latency timer (CFLT) is unreasonably"
-					" low at %d.  Setting to 255.\n", latency );
-				pci_write_config_byte( pdev, PCI_LATENCY_TIMER, 255 );
-			}
 		}
 	}

@@ -1401,14 +1385,10 @@

 static void __exit cleanup_module(void)
 {
-	struct ncr885e_private *np;
-
 	if ( root_dev ) {
-
 		unregister_netdev( root_dev );
-		np = (struct ncr885e_private *) root_dev->priv;
 		release_region( root_dev->base_addr, NCR885E_TOTAL_SIZE );
-		kfree( root_dev->priv );
+		kfree( root_dev );
 		root_dev = NULL;
 	}
 }

--------------A99C6FEDAB0E26089069FF2F--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
