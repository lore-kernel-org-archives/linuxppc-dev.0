Return-Path: <richard.whitlo@btconnect.com>
Received: from c2beaomr09.btconnect.com (c2beaomr09.btconnect.com
	[213.123.26.187]) by ozlabs.org (Postfix) with ESMTP id 9225DDE06C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 20:29:42 +1000 (EST)
Message-ID: <48AAA1AD.9070209@btconnect.com>
Date: Tue, 19 Aug 2008 11:34:21 +0100
From: Richard Whitlock <richard.whitlo@btconnect.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 8347 PCI IDE with Promise 20275 problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: richw@netcomuk.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

We have a board closely based on the A&M asp8347 with the addition of a 
promise technologies 20275 ATA controller.
Starting with the ASP dts file I have added the following:

  pci0: pci@ff008500 {
        cell-index = <1>;
        interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
        interrupt-map = <

                /* IDSEL 0x11 */
                 0x8800 0x0 0x0 0x1 &ipic 19 0x8
                 0x8800 0x0 0x0 0x2 &ipic 19 0x8
                 0x8800 0x0 0x0 0x3 &ipic 19 0x8
                 0x8800 0x0 0x0 0x4 &ipic 19 0x8>;

        interrupt-parent = <&ipic>;
        interrupts = <0x42 0x8>;
        bus-range = <0 0>;
        ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x10000000
              0x42000000 0x0 0xb0000000 0xb0000000 0x0 0x00100000
              0x01000000 0x0 0x00000000 0xb8000000 0x0 0x00100000>;
        clock-frequency = <33333333>;
        #interrupt-cells = <1>;
        #size-cells = <2>;
        #address-cells = <3>;
        reg = <0xff008500 0x100>;
        compatible = "fsl,mpc8349-pci";
        device_type = "pci";
    };

I have based the numbers around what I found in our original 2.6.20 ppc 
port which works fine.
The following is from the ppc tree platform specific header for our board:

----------------------------------------------------------------------------------
#define _IRQ1 MPC83xx_IRQ_EXT3
#define _IRQ2 MPC83xx_IRQ_EXT4
#define PCI_IRQ_INFO()                                                  \
    static char pci_irq_table[][4] =                                \
        /*                                                          \
         *      PCI IDSEL/INTPIN->INTLINE                           \
         *       A      B      C      D                             \
         */                                                         \
    {                                                               \
            { _IRQ1, _IRQ1, _IRQ1, _IRQ1 }, /* IDSEL 11 = IDE disk       
*/ \
            {     0,     0,     0,     0 }, /* IDSEL 12                  
*/ \
            { _IRQ2, _IRQ2, _IRQ2, _IRQ2 }, /* IDSEL 13 = USB controller 
*/ \
    };                                                              \
                                                                        \
    const long min_idsel = 11, max_idsel = 13, irqs_per_slot = 4;

#define EXT_IRQ_SENSES()                                \
    u8 senses[8] = {                                    \
        0,            /* EXT 0 */             \
        0,            /* EXT 1 */             \
        0,            /* EXT 2 */             \
        IRQ_SENSE_LEVEL,    /* EXT 3 = PCI.11 */    \
        IRQ_SENSE_LEVEL,    /* EXT 4 = PCI.13 */    \
        IRQ_SENSE_LEVEL,    /* EXT 5 = JCB */       \
        0,            /* EXT 6 */             \
        0,            /* EXT 7 */             \
    };
#endif


// Note: these need to match how RedBoot has set up the hardware.
// In particular, the PCILAWRn/PCILBAWRn registers (PCI address window)

#define MPC83xx_PCI1_LOWER_IO    0x00000000
#define MPC83xx_PCI1_UPPER_IO    0x000FFFFF
#define MPC83xx_PCI1_IO_BASE    0xB8000000
#define MPC83xx_PCI1_IO_SIZE    0x00100000

#define MPC83xx_PCI1_LOWER_MEM    0xC0000000
#define MPC83xx_PCI1_UPPER_MEM    0xCFFFFFFF
#define MPC83xx_PCI1_MEM_OFFSET    0x00000000

----------------------------------------------------------------------------------

The driver we are using is pata_pdc2027x. Everything seems to work OK, 
except that every time we read from the hardware, we get all f's.
Specifically, pdc_detect_pll_input_clock() fails, since the clock 
frequency appears to be 0Hz.

On boot I get the following:

Found MPC83xx PCI host bridge at 0x00000000ff008500. Firmware bus 
number: 0->0
PCI host bridge /pci@ff008500 (primary) ranges:
 MEM 0x00000000c0000000..0x00000000cfffffff -> 0x00000000c0000000
 MEM 0x00000000b0000000..0x00000000b00fffff -> 0x00000000b0000000 Prefetch
  IO 0x00000000b8000000..0x00000000b80fffff -> 0x0000000000000000
Top of RAM: 0x8000000, Total RAM: 0x8000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00008000
  Normal   0x00008000 -> 0x00008000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00008000
On node 0 totalpages: 32768
free_area_init_node: node 0, pgdat c032f8cc, node_mem_map c040c000
  DMA zone: 32512 pages, LIFO batch:7
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/nfs 
nfsroot=192.168.111.41:/tftpboot/powerpc_q2_



and on trying to mount a CF card I get this:

Mapping pci region - start: c8100000, length: 16384
pata_pdc2027x 0000:00:0b.0: PLL input clock 0 kHz
pata_pdc2027x: Invalid PLL input clock 0kHz, give up!
scsi0 : pata_pdc2027x
scsi1 : pata_pdc2027x
ata1: PATA max UDMA/133 mmio m16384@0xc8100000 cmd 0xc81017c0 irq 16
ata2: PATA max UDMA/133 mmio m16384@0xc8100000 cmd 0xc81015c0 irq 16
pata_pdc2027x: 40-conductor cable detected on port 0
pata_pdc2027x: 40-conductor cable detected on port 1
Could not mount CF card - mountStatus = -1



Any ideas?


Thanks,





Richard.
