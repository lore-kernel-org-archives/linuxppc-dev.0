Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D87D267B69
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 08:42:45 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7FMghZP012968
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 15:42:43 -0700 (MST)
Received: from [10.82.17.56] ([10.82.17.56])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7FMggjr018143
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 17:42:42 -0500 (CDT)
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <7B853E2B-4156-4601-A272-9A9098310240@freescale.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
From: Andy Fleming <afleming@freescale.com>
Subject: Trouble with 85xx CDS cascade irq (i8259)
Date: Tue, 15 Aug 2006 17:42:41 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I've been pounding my head into a wall over this thing for too  
long now, and after combing through the source files line by line, I  
am no closer to figuring this out.  So let me describe my symptoms  
and show you all my code, and maybe someone will be able to point out  
the stupid mistake that I can't see.

I'm currently working on getting the 85xx platform working with the  
new IRQ code.  Specifically, I'm working on the 8555 CDS right now.   
The 85xx CDS consists of a PCI carrier card (with the 8555 processor,  
serial, and networking interfaces), placed in one of 4 PCI slots on a  
custom motherboard (the Arcadia).  The PCI interrupts are routed into  
the carrier card through the standard PCI interrupt pins, which  
requires some mucking around with interrupt assignments depending on  
which slot the card is in.  There is also a VIA chipset on the  
Arcadia motherboard, which provides IDE (among other things), and the  
i8259 PIC in there is routed in through PCI interrupt A.

When I try to boot, I get this:
Using MPC85xx CDS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.18-rc2-gea0c3729-dirty (afleming@ld0175-tx32) (gcc  
version 3.4.3) #26 Tue Aug 15 15:15:17 CDT 2006
setup_arch: bootmem
mpc85xx_cds_setup_arch()
CDS Version = 0x11 in slot 1

Found MPC85xx PCI host bridge at 0x00000000e0008000. Firmware bus  
number: 0->1
Found MPC85xx PCI host bridge at 0x00000000e0009000. Firmware bus  
number: 2->2
arch: exit
Built 1 zonelists.  Total pages: 65536
Kernel command line: root=/dev/nfs rw nfsroot=192.168.1.1:/nfsroot0/ 
ppc_82xx  
ip=192.168.1.119:192.168.1.1:192.168.1.1:255.255.254.0:spacely:eth0:off  
console=ttyS1,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 4, shift: 2, mask: 3
mpic: Initializing for 60 sources
i8259 legacy interrupt controller initialized
PID hash table entries: 2048 (order: 11, 8192 bytes)


At this point, I have determined that I am caught in a never-ending  
cycle of interrupts on the i8259 cascade (that is, the mpic interrupt  
that the i8259 is cascaded through).  i8259_irq() returns that it's  
irq 7.  I've tried booting the arch/ppc kernel, and it works.  I've  
added code to print out the i8259 registers, which didn't seem to  
work (just got 0xff), but it did cause the kernel to boot  
intermittently, or get further (frequently, it would fail when it  
tried to get the interrupt for the e1000 I was using to test PCI  
interrupts).  Removing the debug code would not always return things  
to the above state.

Here's the code that seems relevant.  Any help is greatly appreciated:

void __init mpc85xx_cds_pic_init(void)
{
         struct mpic *mpic;
         struct resource r;
         struct device_node *np = NULL;
         struct device_node *cascade_node = NULL;
         int cascade_irq;

         np = of_find_node_by_type(np, "open-pic");

         if (np == NULL) {
                 printk(KERN_ERR "Could not find open-pic node\n");
                 return;
         }

         of_address_to_resource(np, 0, &r);

         mpic = mpic_alloc(np, r.start,
                         MPIC_PRIMARY | MPIC_WANTS_RESET |  
MPIC_BIG_ENDIAN,
                         4, 0, " OpenPIC  ");
         BUG_ON(mpic == NULL);

         mpic_assign_isu(mpic, 0, r.start + 0x10200);
         mpic_assign_isu(mpic, 1, r.start + 0x10280);
         mpic_assign_isu(mpic, 2, r.start + 0x10300);
         mpic_assign_isu(mpic, 3, r.start + 0x10380);
         mpic_assign_isu(mpic, 4, r.start + 0x10400);
         mpic_assign_isu(mpic, 5, r.start + 0x10480);
         mpic_assign_isu(mpic, 6, r.start + 0x10500);
         mpic_assign_isu(mpic, 7, r.start + 0x10580);

         /* Used only for 8548 so far, but no harm in
          * allocating them for everyone */
         mpic_assign_isu(mpic, 8, r.start + 0x10600);
         mpic_assign_isu(mpic, 9, r.start + 0x10680);
         mpic_assign_isu(mpic, 10, r.start + 0x10700);
         mpic_assign_isu(mpic, 11, r.start + 0x10780);

         /* External Interrupts */
         mpic_assign_isu(mpic, 12, r.start + 0x10000);
         mpic_assign_isu(mpic, 13, r.start + 0x10080);
         mpic_assign_isu(mpic, 14, r.start + 0x10100);

         mpic_init(mpic);

#ifdef CONFIG_PCI
         /* Initialize the i8259 controller */
         for_each_node_by_type(np, "interrupt-controller")
                 if (device_is_compatible(np, "chrp,iic")) {
                         cascade_node = np;
                         break;
                 }

         if (cascade_node == NULL) {
                 printk(KERN_DEBUG "Could not find i8259 PIC\n");
                 return;
         }

         cascade_irq = irq_of_parse_and_map(cascade_node, 0);
         if (cascade_irq == NO_IRQ) {
                 printk(KERN_ERR "Failed to map cascade interrupt\n");
                 return;
         }

         set_irq_chained_handler(cascade_irq, mpc85xx_8259_cascade);

         i8259_init(cascade_node, 0);
#endif /* CONFIG_PCI */
}

static void mpc85xx_8259_cascade(unsigned int irq, struct
                 irq_desc *desc, struct pt_regs *regs)
{
         unsigned int cascade_irq = i8259_irq(regs);

         // cascade_irq is returned to be 7
         if (cascade_irq != NO_IRQ)
                 generic_handle_irq(cascade_irq, regs);

         desc->chip->eoi(irq);
}


// --> This is where the PCI interrupts are scanned from the device tree
void __init
mpc85xx_cds_pcibios_fixup(void)
{
         struct pci_dev *dev;
         u_char          c;

         if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_1,  
NULL))) {
                 /*
                  * U-Boot does not set the enable bits
                  * for the IDE device. Force them on here.
                  */
                 pci_read_config_byte(dev, 0x40, &c);
                 c |= 0x03; /* IDE: Chip Enable Bits */
                 pci_write_config_byte(dev, 0x40, c);

                 /*
                  * Since only primary interface works, force the
                  * IDE function to standard primary IDE interrupt
                  * w/ 8259 offset
                  */
                 dev->irq = 14;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev- 
 >irq);
                 pci_dev_put(dev);
         }

         /*
          * Force legacy USB interrupt routing
          */
         if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_2,  
NULL))) {
                 dev->irq = 10;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
                 pci_dev_put(dev);
         }

         if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
                                         PCI_DEVICE_ID_VIA_82C586_2,  
dev))) {
                 dev->irq = 11;
                 pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
                 pci_dev_put(dev);
         }

         /* Now map all the PCI irqs */
         dev = NULL;
         for_each_pci_dev(dev)
                 pci_read_irq_line(dev);
}


Here's the relevant device tree portions:


/ {
         model = "MPC8555CDS";
         compatible = "MPC85xxCDS";

         soc8555@e0000000 {
                 #address-cells = <1>;
                 #size-cells = <1>;
                 #interrupt-cells = <2>;
                 device_type = "soc";
                 ranges = <0 e0000000 00100000>;
                 reg = <e0000000 00100000>;      // CCSRBAR 1M
                 bus-frequency = <0>;

                 ethernet@24000 {
                         #address-cells = <1>;
                         #size-cells = <0>;
                         device_type = "network";
                         model = "TSEC";
                         compatible = "gianfar";
                         reg = <24000 1000>;
                         address = [ 00 E0 0C 00 73 00 ];
                         interrupts = <0d 2 0e 2 12 2>;
                         interrupt-parent = <40000>;
                         phy-handle = <2452000>;
                 };

                 pci@8000 {
                         linux,phandle = <8000>;
                         interrupt-map-mask = <1f800 0 0 7>;
                         interrupt-map = <

                                 /* IDSEL 0x10 */
                                 08000 0 0 1 40000 30 1
                                 08000 0 0 2 40000 31 1
                                 08000 0 0 3 40000 32 1
                                 08000 0 0 4 40000 33 1

                                 /* IDSEL 0x11 */
                                 08800 0 0 1 40000 30 1
                                 08800 0 0 2 40000 31 1
                                 08800 0 0 3 40000 32 1
                                 08800 0 0 4 40000 33 1

                                 /* IDSEL 0x12 (Slot 1) */
                                 09000 0 0 1 40000 30 1
                                 09000 0 0 2 40000 31 1
                                 09000 0 0 3 40000 32 1
                                 09000 0 0 4 40000 33 1

                                 /* IDSEL 0x13 (Slot 2) */
                                 09800 0 0 1 40000 31 1
                                 09800 0 0 2 40000 32 1
                                 09800 0 0 3 40000 33 1
                                 09800 0 0 4 40000 30 1

                                 /* IDSEL 0x14 (Slot 3) */
                                 0a000 0 0 1 40000 32 1
                                 0a000 0 0 2 40000 33 1
                                 0a000 0 0 3 40000 30 1
                                 0a000 0 0 4 40000 31 1

                                 /* IDSEL 0x15 (Slot 4) */
                                 0a800 0 0 1 40000 33 1
                                 0a800 0 0 2 40000 30 1
                                 0a800 0 0 3 40000 31 1
                                 0a800 0 0 4 40000 32 1

                                 /* Bus 1 (Tundra Bridge) */
                                 /* IDSEL 0x12 (ISA bridge) */
                                 19000 0 0 1 40000 30 1
                                 19000 0 0 2 40000 31 1
                                 19000 0 0 3 40000 32 1
                                 19000 0 0 4 40000 33 1>;
                         interrupt-parent = <40000>;
                         interrupts = <08 2>;
                         bus-range = <0 0>;
                         ranges = <02000000 0 80000000 80000000 0  
20000000
                                   01000000 0 00000000 e2000000 0  
00100000>;
                         clock-frequency = <3f940aa>;
                         #interrupt-cells = <1>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         reg = <8000 1000>;
                         compatible = "85xx";
                         device_type = "pci";

                         i8259@19000 {
                                 linux,phandle = <19000>;
                                 clock-frequency = <0>;
                                 interrupt-controller;
                                 device_type = "interrupt-controller";
                                 reg = <19000 0 0 0 1>;
                                 #address-cells = <0>;
                                 #interrupt-cells = <2>;
                                 built-in;
                                 compatible = "chrp,iic";
                                 big-endian;
                                 interrupts = <1>;
                                 interrupt-parent = <8000>;
                         };
                 };

                 pci@9000 {
                         linux,phandle = <9000>;
                         interrupt-map-mask = <f800 0 0 7>;
                         interrupt-map = <

                                 /* IDSEL 0x15 */
                                 a800 0 0 1 40000 3b 1
                                 a800 0 0 2 40000 3b 1
                                 a800 0 0 3 40000 3b 1
                                 a800 0 0 4 40000 3b 1>;
                         interrupt-parent = <40000>;
                         interrupts = <09 2>;
                         bus-range = <0 0>;
                         ranges = <02000000 0 a0000000 a0000000 0  
20000000
                                   01000000 0 00000000 e3000000 0  
00100000>;
                         clock-frequency = <3f940aa>;
                         #interrupt-cells = <1>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         reg = <9000 1000>;
                         compatible = "85xx";
                         device_type = "pci";
                 };

                 pic@40000 {
                         linux,phandle = <40000>;
                         clock-frequency = <0>;
                         interrupt-controller;
                         #address-cells = <0>;
                         #interrupt-cells = <2>;
                         reg = <40000 40000>;
                         built-in;
                         compatible = "chrp,open-pic";
                         device_type = "open-pic";
                         big-endian;
                 };
         };
};
