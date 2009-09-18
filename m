Return-Path: <gr1xmail@gmail.com>
Received: from mail-fx0-f219.google.com (mail-fx0-f219.google.com
	[209.85.220.219]) by ozlabs.org (Postfix) with ESMTP id ABEC5B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Sep 2009 01:37:59 +1000 (EST)
Received: by fxm19 with SMTP id 19so872899fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Sep 2009 08:37:56 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Sep 2009 23:37:56 +0800
Message-ID: <8abf57fa0909180837sc3864bcwb0cc2cb7b211c17d@mail.gmail.com>
Subject: Powerpc Kernel 2.6.26.5 boot panic when call cfi_probe_chip()
From: g r1x <gr1xmail@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00c09ffb593d8576010473dbea4d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09ffb593d8576010473dbea4d
Content-Type: text/plain; charset=ISO-8859-1

I'm working on a 440GX demo board with a flash chip s29gl256p(128k sector
size, 32M total, CFI). I have tried 2 ways to add mtd partiton to the
kernel, but failed with kernel panic. (kernel version: 2.6.26.5)
1. device tree, based on taishan board's dts.
 /dts-v1/;

/ {
#address-cells = <2>;
#size-cells = <1>;
model = "amcc,cerberus";
compatible = "amcc,cerberus";
dcr-parent = <&{/cpus/cpu@0}>;

aliases {
ethernet0 = &EMAC2;
ethernet1 = &EMAC3;
serial0 = &UART0;
serial1 = &UART1;
};

cpus {
#address-cells = <1>;
#size-cells = <0>;

cpu@0 {
device_type = "cpu";
model = "PowerPC,440GX";
reg = <0x00000000>;
clock-frequency = <0x1DCD6500>; // 500MHz, 2FAF0800 800MHz
timebase-frequency = <0>; // Fix Me
i-cache-line-size = <0x32>;
d-cache-line-size = <0x32>;
i-cache-size = <0x8000>; /* 32 kB */
d-cache-size = <0x8000>; /* 32 kB */
dcr-controller;
dcr-access-method = "native";
};
};

memory {
device_type = "memory";
reg = <0x00000000 0x00000000 0x10000000>; // Fix me
};


UICB0: interrupt-controller-base {
compatible = "ibm,uic-440gx", "ibm,uic";
interrupt-controller;
cell-index = <0x3>;
dcr-reg = <0x200 0x009>;
#address-cells = <0>;
#size-cells = <0>;
#interrupt-cells = <0x2>;
};


UIC0: interrupt-controller0 {
compatible = "ibm,uic-440gx", "ibm,uic";
interrupt-controller;
cell-index = <0>;
dcr-reg = <0x0c0 0x009>;
#address-cells = <0>;
#size-cells = <0>;
#interrupt-cells = <2>;
interrupts = <0x1 0x4 0x0 0x4>; /* cascade - first non-critical */
interrupt-parent = <&UICB0>;

};

UIC1: interrupt-controller1 {
compatible = "ibm,uic-440gx", "ibm,uic";
interrupt-controller;
cell-index = <1>;
dcr-reg = <0x0d0 0x009>;
#address-cells = <0>;
#size-cells = <0>;
#interrupt-cells = <2>;
interrupts = <0x3 0x4 0x2 0x4>; /* cascade */
interrupt-parent = <&UICB0>;
};

UIC2: interrupt-controller2 {
compatible = "ibm,uic-440gx", "ibm,uic";
interrupt-controller;
cell-index = <2>; /* was 1 */
dcr-reg = <0x210 0x009>;
#address-cells = <0>;
#size-cells = <0>;
#interrupt-cells = <2>;
interrupts = <0x5 0x4 0x4 0x4>; /* cascade */
interrupt-parent = <&UICB0>;
};


CPC0: cpc {
compatible = "ibm,cpc-440gp";
dcr-reg = <0x0b0 0x003 0x0e0 0x010>;
// FIXME: anything else?
};

L2C0: l2c {
compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
dcr-reg = <0x020 0x008 /* Internal SRAM DCR's */
   0x030 0x008>; /* L2 cache DCR's */
cache-line-size = <0x20>; /* 32 bytes */
cache-size = <0x40000>; /* L2, 256K */
interrupt-parent = <&UIC2>;
interrupts = <0x17 0x1>;
};

plb {
compatible = "ibm,plb-440gx", "ibm,plb4";
#address-cells = <2>;
#size-cells = <1>;
ranges;
clock-frequency = <0x9896800>; // 160MHz, fixed me

SDRAM0: memory-controller {
compatible = "ibm,sdram-440gp";
dcr-reg = <0x010 0x002>;
// FIXME: anything else?
};

SRAM0: sram {
compatible = "ibm,sram-440gp";
dcr-reg = <0x020 0x008 0x00a 0x001>;
};

DMA0: dma {
// FIXME: ???
compatible = "ibm,dma-440gp";
dcr-reg = <0x100 0x027>;
};

MAL0: mcmal {
compatible = "ibm,mcmal-440gx", "ibm,mcmal2";
dcr-reg = <0x180 0x062>;
num-tx-chans = <4>;
num-rx-chans = <4>;
interrupt-parent = <&MAL0>;
interrupts = <0x0 0x1 0x2 0x3 0x4>;
#interrupt-cells = <1>;
#address-cells = <0>;
#size-cells = <0>;
interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
   /*RXEOB*/ 0x1 &UIC0 0xb 0x4
 /*SERR*/  0x2 &UIC1 0x0 0x4
 /*TXDE*/  0x3 &UIC1 0x1 0x4
 /*RXDE*/  0x4 &UIC1 0x2 0x4>;
interrupt-map-mask = <0xffffffff>;
};

PCIDMA: pci_dma {
compatible = "ibm,pci_dma_440gx","ibm,pci_dma";
interrupt-parent = <&PCIDMA>;
#interrupt-cells = <1>;
#address-cells = <0>;
#size-cells = <0>;
interrupts = <0x0 0x1 0x2 0x3>;
interrupt-map = < /* PCI MSG IN  */ 0x0 &UIC0 0x4  0x4
                  /* DMAChannel0 */ 0x1 &UIC0 0xc  0x4
  /* DMAChannel1 */ 0x2 &UIC0 0xd  0x4
  /* IRQ5        */ 0x3 &UIC0 0x1c 0x3>;
interrupt-map-mask = <0xffffffff>;
};

POB0: opb {
compatible = "ibm,opb-440gx", "ibm,opb";
#address-cells = <1>;
#size-cells = <1>;
/* Wish there was a nicer way of specifying a full 32-bit
   range */
ranges = <0x00000000 0x00000001 0x00000000 0x80000000
     0x80000000 0x00000001 0x80000000 0x80000000>;
dcr-reg = <0x090 0x00b>;
interrupt-parent = <&UIC1>;
interrupts = <0x7 0x4>;
clock-frequency = <0x4C4B400>; // 80MHz


EBC0: ebc {
compatible = "ibm,ebc-440gx", "ibm,ebc";
dcr-reg = <0x012 0x002>;
#address-cells = <2>;
#size-cells = <1>;
clock-frequency = <0x4C4B400>; // 80MHz

/* ranges property is supplied by zImage
 * based on firmware's configuration of the
 * EBC bridge */

interrupts = <0x5 0x4>;
interrupt-parent = <&UIC1>;

nor_flash@0,0 {
compatible = "cfi-flash";
bank-width = <2>;
device-width = <1>;
#address-cells = <1>;
#size-cells = <1>;
reg = <0x0 0x0 0x2000000>;
partition@0 {
label = "user";
reg = <0x0 0x1000000>;
};
partition@1000000 {
label = "root";
reg = <0x1000000 0xB00000>;
};
partition@1B00000 {
label = "kernel";
reg = <0x1B00000 0x480000>;
};
partition@1F80000 {
label = "fdt";
reg = <0x1F80000 0x20000>;
};
partition@1FA0000 {
label = "env";
reg = <0x1FA0000 0x20000>;
};
partition@1FC0000 {
label = "u-boot";
reg = <0x1fc0000 0x40000>;
};
};

};



UART0: serial@40000200 {
device_type = "serial";
compatible = "ns16550";
reg = <0x40000200 0x00000008>;
virtual-reg = <0xe0000200>;
  clock-frequency = <0xA8C000>;
current-speed = <0x1C200>; /* 115200 */
interrupt-parent = <&UIC0>;
interrupts = <0x0 0x4>;
};

UART1: serial@40000300 {
device_type = "serial";
compatible = "ns16550";
reg = <0x40000300 0x00000008>;
virtual-reg = <0xe0000300>;
clock-frequency = <0xA8C000>;
current-speed = <0x1C200>; /* 115200 */
interrupt-parent = <&UIC0>;
interrupts = <0x1 0x4>;
};

IIC0: i2c@40000400 {
/* FIXME */
compatible = "ibm,iic-440gp", "ibm,iic";
reg = <0x40000400 0x00000014>;
interrupt-parent = <&UIC0>;
interrupts = <0x2 0x4>;
index = <0>;
/* clock-frequency = <0x186a0>; */
};
IIC1: i2c@40000500 {
/* FIXME */
compatible = "ibm,iic-440gp", "ibm,iic";
reg = <0x40000500 0x00000014>;
interrupt-parent = <&UIC0>;
interrupts = <0x3 0x4>;
index = <1>;
#address-cells = <0x1>;
#size-cells = <0>;
rtc@68 {
compatible = "dallas,ds1338";
reg = <0x68>;
};
};

GPIO0: gpio@40000700 {
/* FIXME */
compatible = "ibm,gpio-440gp";
reg = <0x40000700 0x00000020>;
};

ZMII0: emac-zmii@40000780 {
compatible = "ibm,zmii-440gx", "ibm,zmii";
reg = <0x40000780 0x0000000c>;
};

RGMII0: emac-rgmii@40000790 {
compatible = "ibm,rgmii";
reg = <0x40000790 0x00000008>;
};

TAH0: emac-tah@40000b50 {
compatible = "ibm,tah-440gx", "ibm,tah";
reg = <0x40000b50 0x00000030>;
};

TAH1: emac-tah@40000d50 {
compatible = "ibm,tah-440gx", "ibm,tah";
reg = <0x40000d50 0x00000030>;
};

EMAC0: ethernet@40000800 {
unused = <0x1>;
device_type = "network";
compatible = "ibm,emac-440gx", "ibm,emac4";
interrupt-parent = <&UIC1>;
interrupts = <0x1c 0x4 0x1d 0x4>;
reg = <0x40000800 0x00000074>;
local-mac-address = [000000000000]; // Fill me
mal-device = <&MAL0>;
mal-tx-channel = <0>;
mal-rx-channel = <0>;
cell-index = <0>;
max-frame-size = <0x5DC>;
rx-fifo-size = <0x1000>;
tx-fifo-size = <0x800>;
phy-mode = "rmii";
phy-map = <0x00000004>;
zmii-device = <&ZMII0>;
zmii-channel = <0>;
};

 EMAC1: ethernet@40000900 {
unused = <0x1>;
device_type = "network";
compatible = "ibm,emac-440gx", "ibm,emac4";
interrupt-parent = <&UIC1>;
interrupts = <0x1e 0x4 0x1f 0x4>;
reg = <0x40000900 0x00000074>;
local-mac-address = [000000000000]; // Fill me
mal-device = <&MAL0>;
mal-tx-channel = <1>;
mal-rx-channel = <1>;
cell-index = <1>;
max-frame-size = <0x5DC>;
rx-fifo-size = <0x1000>;
tx-fifo-size = <0x800>;
phy-mode = "rmii";
phy-map = <0x00000003>;
  zmii-device = <&ZMII0>;
zmii-channel = <1>;
};

 EMAC2: ethernet@40000c00 {
// unused = <0x1>;
device_type = "network";
compatible = "ibm,emac-440gx", "ibm,emac4";
interrupt-parent = <&UIC2>;
interrupts = <0x0 0x4 0x1 0x4>;
reg = <0x40000c00 0x00000074>;
local-mac-address = [000000000000]; // Fill me
mal-device = <&MAL0>;
mal-tx-channel = <2>;
mal-rx-channel = <2>;
cell-index = <2>;
max-frame-size = <0x2328>;
rx-fifo-size = <0x1000>;
tx-fifo-size = <0x800>;
phy-mode = "rgmii";
phy-map = <0x00000002>;
rgmii-device = <&RGMII0>;
rgmii-channel = <0>;
  zmii-device = <&ZMII0>;
zmii-channel = <2>;
tah-device = <&TAH0>;
tah-channel = <0>;
};

 EMAC3: ethernet@40000e00 {
device_type = "network";
compatible = "ibm,emac-440gx", "ibm,emac4";
interrupt-parent = <&UIC2>;
interrupts = <0x2 0x4 0x3 0x4>;
reg = <0x40000e00 0x00000074>;
local-mac-address = [000000000000]; // Fill me
mal-device = <&MAL0>;
mal-tx-channel = <3>;
mal-rx-channel = <3>;
cell-index = <3>;
max-frame-size = <0x2328>;
rx-fifo-size = <0x1000>;
tx-fifo-size = <0x800>;
phy-mode = "rgmii";
phy-map = <0x00000001>;
rgmii-device = <&RGMII0>;
rgmii-channel = <1>;
  zmii-device = <&ZMII0>;
zmii-channel = <3>;
tah-device = <&TAH1>;
tah-channel = <0>;
};


GPT0: gpt@40000a00 {
/* FIXME */
reg = <0x40000a00 0x000000d4>;
interrupt-parent = <&UIC0>;
interrupts = <0x12 0x4 0x13 0x4 0x14 0x4 0x15 0x4 0x16 0x4>;
};

};

PCIX0: pci@20ec00000 {
device_type = "pci";
#interrupt-cells = <1>;
#size-cells = <2>;
#address-cells = <3>;
compatible = "ibm,plb440gp-pcix", "ibm,plb-pcix";
primary;
large-inbound-windows;
enable-msi-hole;
reg = <0x00000002 0x0ec00000 0x00000008 /* Config space access */
       0x00000000 0x00000000 0x00000000 /* no IACK cycles */
       0x00000002 0x0ed00000 0x00000004   /* Special cycles */
       0x00000002 0x0ec80000 0x00000100 /* Internal registers */
       0x00000002 0x0ec80100 0x000000fc>; /* Internal messaging registers */

/* Outbound ranges, one memory and one IO,
 * later cannot be changed
 */
 /*     Type          PCIAddr          PLBAddr          Size
  *   PCI Memory      0x80000000      0x380000000        2GB
  *       I/O         0x0             0x208000000        64KB
  */
ranges = <0x02000000 0x00000000 0x80000000 0x00000003 0x80000000 0x00000000
0x80000000
     0x01000000 0x00000000 0x00000000 0x00000002 0x08000000 0x00000000
0x00010000>;

/* Inbound 2GB range starting at 0 */
          /*     Type          PCIAddr          PLBAddr          Size
  *   PCI Memory         0x0              0x0            2GB
  *  (prefetchable)  (Fixed in linux?)
  */
dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;

interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
interrupt-map = <
/* IDSEL 1 */
0x0800 0x0 0x0 0x1 &UIC0 0x17 0x8
0x0800 0x0 0x0 0x2 &UIC0 0x18 0x8
0x0800 0x0 0x0 0x3 &UIC0 0x19 0x8
0x0800 0x0 0x0 0x4 &UIC0 0x1a 0x8

/* IDSEL 2 */
0x1000 0x0 0x0 0x1 &UIC0 0x18 0x8
0x1000 0x0 0x0 0x2 &UIC0 0x19 0x8
0x1000 0x0 0x0 0x3 &UIC0 0x1a 0x8
0x1000 0x0 0x0 0x4 &UIC0 0x17 0x8
>;
};


};
When kernel boots, panic happens

2. As I doubt error exists in dts, so I add a mtd map driver for the board
instead, but kernel boots panic all the same
#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>
#include <asm/io.h>
#define CFG_FLASH_BUS_WIDTH     2
#define CFG_FLASH_SIZE          0x2000000       /* Bytes */
#define CFG_FLASH_ADDR          0x1FE000000ULL

#define FLASH_MSG_PREFIX        "S29GL-NOR:"
#define MTD_ID                  "s29gl-nor"


struct map_info s29gl_map = {
        .name = "Nor Flash on Cerberus",
        .size = CFG_FLASH_SIZE,
        .bankwidth = CFG_FLASH_BUS_WIDTH,
};


static struct mtd_partition cerberus_partition[] = {
        {
         .name = "user",
         .offset = 0x0,
         .size = 0x1000000,
         },
        {
         .name = "root",
         .offset = 0x1000000,
         .size = 0xB00000,
         },
        {
         .name = "kernel",
         .offset = 0x1B00000,
         .size = 0x480000,
         },
        {
         .name = "fdt",
         .offset = 0x1F80000,
         .size = 0x20000,
         },
        {
         .name = "env",
         .offset = 0x1FA0000,
         .size = 0x20000,
         },
        {
         .name = "u-boot",
         .offset = 0x1FC0000,
         .size = 0x40000,
        }
};


static struct mtd_info *s29gl_mtd_info;
static struct mtd_partition *mtd_parts = 0;

int __init s29gl_init(void)
{
        phys_addr_t flash_base = CFG_FLASH_ADDR;
        printk(KERN_NOTICE FLASH_MSG_PREFIX "0x%08x at 0x%llx\n",
               CFG_FLASH_SIZE,CFG_FLASH_ADDR);
        s29gl_map.phys = flash_base;
        s29gl_map.virt=ioremap(CFG_FLASH_ADDR,CFG_FLASH_SIZE);
        if (!s29gl_map.virt){
                printk(KERN_ERR FLASH_MSG_PREFIX"failed to ioremap\n");
                return -EIO;
        }
        simple_map_init(&s29gl_map);
        s29gl_mtd_info = do_map_probe("cfi_probe",&s29gl_map);
        if (s29gl_mtd_info){
                s29gl_mtd_info->owner=THIS_MODULE;
                add_mtd_partitions(s29gl_mtd_info,cerberus_partition,
                                   ARRAY_SIZE(cerberus_partition));
        } else {
                printk(KERN_ERR FLASH_MSG_PREFIX"Map probe failed\n");
                iounmap((void*)s29gl_map.virt);
                s29gl_map.virt=0;
        }
}

static void __exit s29gl_exit(void)
{
        if(s29gl_mtd_info){
                del_mtd_partitions(s29gl_mtd_info);
                map_destroy(s29gl_mtd_info);
        }
        if(s29gl_map.virt){
                iounmap((void*)s29gl_map.virt);
                s29gl_map.virt=0;
        }
}

module_init(s29gl_init);
module_exit(s29gl_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("MTD map and partition for 440GX boards");

---------------------kernel panic log------------------
/plb/opb/emac-rgmii@40000790: input 0 in RGMII mode
eth0: EMAC-2 /plb/opb/ethernet@40000c00, MAC 00:22:33:44:55:66
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@40000790: input 1 in RGMII mode
eth1: EMAC-3 /plb/opb/ethernet@40000e00, MAC 00:33:44:55:66:77
eth1: found Marvell 88E1111 Ethernet PHY (0x03)
S29GL-NOR:0x02000000 at 0x1fe000000
HERE1
Machine check in kernel mode.
Data Write PLB Error
Oops: Machine check, sig: 7 [#1]
Cerberus
Modules linked in:
NIP: c01943f8 LR: c018e5c8 CTR: c01943a0
REGS: c02daf50 TRAP: 0214   Not tainted  (2.6.26.5)
MSR: 00029000 <EE,ME>  CR: 42344a22  XER: 00000000
TASK = cf828000[1] 'swapper' THREAD: cf82c000
GPR00: 0000f0f0 cf82de50 cf828000 c02cd1a0 cf82de58 00000000 cf82de98 000000
GPR08: 00000000 d1180000 00000002 00000001 82344a22 40350100 c0256850 c02568
GPR16: c0256828 c0256810 cf82df98 c02b5de0 c02b0000 00000000 cf82de58 c02b00
GPR24: cf82df58 c02b5d7c 00000000 c02cd1a0 cf82de98 00000000 c02ccd1c c02cd1
NIP [c01943f8] simple_map_write+0x58/0x60
LR [c018e5c8] cfi_probe_chip+0xcc/0xeb4
Call Trace:
[cf82de50] [c001d5b4] printk+0x50/0x60 (unreliable)
[cf82de90] [c019404c] mtd_do_chip_probe+0xa4/0x3ac
[cf82df00] [c018e4ec] cfi_probe+0x1c/0x2c
[cf82df10] [c018e25c] do_map_probe+0x34/0x90
[cf82df30] [c02ac28c] s29gl_init+0x74/0xf0
[cf82df50] [c02971b0] kernel_init+0xa8/0x28c
[cf82dff0] [c000c3dc] kernel_thread+0x44/0x60
Instruction dump:
81230010 7c05492e 7c0004ac 4e800020 81230010 5400063e 7c0549ae 7c0004ac
4e800020 81230010 5400043e 7c054b2e <7c0004ac> 4e800020 81230018 2b890004
---[ end trace 5fac80aef6224e66 ]---
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..

The above panic log prints "HERE1" 'cause I changed mtd_do_chip_probe() as
follows.
struct mtd_info *mtd_do_chip_probe(struct map_info *map, struct chip_probe
*cp)
{
        struct mtd_info *mtd = NULL;
        struct cfi_private *cfi;
        printk(KERN_WARNING "HERE1\n");
        /* First probe the map to see if we have CFI stuff there. */
        cfi = genprobe_ident_chips(map, cp);
        printk(KERN_WARNING "HERE2\n");

        if (!cfi)
                return NULL;
        printk(KERN_WARNING "HERE3\n");

        map->fldrv_priv = cfi;
        /* OK we liked it. Now find a driver for the command set it talks */

        mtd = check_cmd_set(map, 1); /* First the primary cmdset */
        printk(KERN_WARNING "HERE4\n");

        if (!mtd){
                mtd = check_cmd_set(map, 0); /* Then the secondary */
                printk(KERN_WARNING "HERE5\n");
        }
        if (mtd) {
                if (mtd->size > map->size) {
                        printk(KERN_WARNING "Reducing visibility of %ldKiB
chip to %ldKiB\n",
                               (unsigned long)mtd->size >> 10,
                               (unsigned long)map->size >> 10);
                        mtd->size = map->size;
                }
        printk(KERN_WARNING "HERE6\n");

                return mtd;
        }

        printk(KERN_WARNING"gen_probe: No supported Vendor Command Set
found\n");

        kfree(cfi->cfiq);
        kfree(cfi);
        map->fldrv_priv = NULL;
        return NULL;
}
EXPORT_SYMBOL(mtd_do_chip_probe)

---------------------------------
Follow is my .config
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.25-rc2
# Fri Feb 15 21:40:44 2008
#
# CONFIG_PPC64 is not set

#
# Processor support
#
# CONFIG_6xx is not set
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
CONFIG_44x=y
# CONFIG_E200 is not set
CONFIG_4xx=y
CONFIG_BOOKE=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_NOT_COHERENT_CACHE=y
CONFIG_PPC32=y
CONFIG_WORD_SIZE=32
CONFIG_PPC_MERGE=y
CONFIG_MMU=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_HARDIRQS=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
CONFIG_IRQ_PER_CPU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_FIND_NEXT_BIT=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_OF=y
CONFIG_PPC_UDBG_16550=y
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_DEFAULT_UIMAGE is not set
CONFIG_PPC_DCR_NATIVE=y
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_PPC_DCR=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
CONFIG_GROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_USER_SCHED=y
# CONFIG_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
# CONFIG_NAMESPACES is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_COMPAT_BRK=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_BLOCK=y
CONFIG_LBD=y
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_CLASSIC_RCU=y
# CONFIG_PREEMPT_RCU is not set
# CONFIG_PPC4xx_PCI_EXPRESS is not set

#
# Platform support
#
# CONFIG_PPC_MPC512x is not set
# CONFIG_PPC_MPC5121 is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PQ2ADS is not set
# CONFIG_BAMBOO is not set
# CONFIG_EBONY is not set
# CONFIG_SEQUOIA is not set
# CONFIG_GALAXY=y is not set
CONFIG_CERBERUS=y

# CONFIG_KATMAI is not set
# CONFIG_RAINIER is not set
# CONFIG_WARP is not set
CONFIG_440GX=y
# CONFIG_IPIC is not set
# CONFIG_MPIC is not set
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_INDIRECT_IO is not set
# CONFIG_GENERIC_IOMAP is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_FSL_ULI1575 is not set

#
# Kernel options
#
# CONFIG_HIGHMEM is not set
# CONFIG_TICK_ONESHOT is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
# CONFIG_SCHED_HRTICK is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_RCU_TRACE=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_IOMMU_HELPER is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_POPULATES_NODE_MAP=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_RESOURCES_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_PROC_DEVICETREE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options (PCI etc.)
#
# CONFIG_PCI is not set
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_PCCARD is not set


#

# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0xc0000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x01000000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#
#Allow userspace driver core code to be built
CONFIG_UIO=y
#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=y
CONFIG_MTD_JEDECPROB=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
# CONFIG_MTD_CERBERUS is not set
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
CONFIG_MTD_COMPLEX_MAPPINGS=y

CONFIG_OF_DEVICE=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=35000
# CONFIG_BLK_DEV_XIP is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_XILINX_SYSACE is not set
CONFIG_MISC_DEVICES=y
# CONFIG_PHANTOM is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HAVE_IDE
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_MAC_EMUMOUSEBTN is not set
# CONFIG_WINDFARM is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_ARCNET is not set
CONFIG_PHYLIB=y
CONFIG_MARVELL_PHY=y
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_IBM_NEW_EMAC=y
CONFIG_IBM_NEW_EMAC_RXB=128
CONFIG_IBM_NEW_EMAC_TXB=64
CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
# CONFIG_IBM_NEW_EMAC_DEBUG is not set
CONFIG_IBM_NEW_EMAC_ZMII=y
CONFIG_IBM_NEW_EMAC_RGMII=y
CONFIG_IBM_NEW_EMAC_TAH=y
CONFIG_IBM_NEW_EMAC_EMAC4=y
# CONFIG_NET_PCI is not set
# CONFIG_B44 is not set
CONFIG_NETDEV_1000=y
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_E1000E is not set
# CONFIG_E1000E_ENABLED is not set
# CONFIG_IP1000 is not set
# CONFIG_IGB is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set
# CONFIG_QLA3XXX is not set
# CONFIG_ATL1 is not set
CONFIG_NETDEV_10000=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_NIU is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_TEHUTI is not set
# CONFIG_BNX2X is not set
# CONFIG_TR is not set

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_PCI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_TEXT_DEBUG=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_OF_PLATFORM=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_IBM_IIC=y
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_CHIP=y
CONFIG_I2C_DEBUG_BUS=y
#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
# CONFIG_DAB is noet set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Sound
#
# CONFIG_SOUND is not set
# CONFIG_USB_SUPPORT is not set
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set
# CONFIG_USB_ARCH_HAS_EHCI is not set
# CONFIG_USB is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
# CONFIG_INFINIBAND is not set
# CONFIG_EDAC is not set
CONFIG_RTC_CLASS=y
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DEBUG=y
CONFIG_RTC_DRV_TEST=y
CONFIG_RTC_DRV_PPC=y
#
# Userspace I/O
#
# CONFIG_UIO is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4DEV_FS is not set
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_DNOTIFY=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_BIND34 is not set
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
CONFIG_CIFS=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set
# CONFIG_DLM is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y
CONFIG_DMADEVICES=y

#
# Kernel hacking
#
CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUGGER=y
CONFIG_KGDB=y
CONFIG_KGDB_TTYS0=y
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
CONFIG_VIRQ_DEBUG is not set
# CONFIG_BDI_SWITCH is not set
#CONFIG_PPC_EARLY_DEBUG=y
CONFIG_EARLY_PRINTK=y
#CONFIG_PPC_EARLY_DEBUG_44x=y
#CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=0x40000200

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_HIFN_795X is not set
# CONFIG_PPC_CLOCK is not set
CONFIG_SENSORS_EEPROM=y

--00c09ffb593d8576010473dbea4d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m working on a 440GX demo board with a flash chip s29gl256p(128k sect=
or size, 32M total, CFI). I have tried 2 ways to add mtd partiton to the ke=
rnel, but failed with kernel panic. (kernel version: 2.6.26.5)<div><br></di=
v>
<div>1. device tree, based on taishan board&#39;s dts.</div><div>=A0/dts-v1=
/;</div><div><br></div><div>/ {</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>#address-cells =3D &lt;2&gt;;</div><div><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>#size-cells =
=3D &lt;1&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>model=
 =3D &quot;amcc,cerberus&quot;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">	</span>compatible =3D &quot;amcc,cerberus&quot;;</=
div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>dcr-parent=
 =3D &lt;&amp;{/cpus/cpu@0}&gt;;</div><div><br></div><div><span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span>aliases {</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ethernet0 =3D &a=
mp;EMAC2;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ethe=
rnet1 =3D &amp;EMAC3;</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>serial0 =3D &amp;UART0;</div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">		</span>serial1 =3D &amp;UART1;</di=
v>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>cpus {</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">		</span>#address-cells =3D &lt;1&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#siz=
e-cells =3D &lt;0&gt;;</div><div><br></div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">		</span>cpu@0 {</div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">			</span>device_type =3D &quot;cpu&=
quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>mod=
el =3D &quot;PowerPC,440GX&quot;;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			</span>reg =3D &lt;0x00000000&gt;;</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>clock-fre=
quency =3D &lt;0x1DCD6500&gt;; // 500MHz, 2FAF0800 800MHz</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>tim=
ebase-frequency =3D &lt;0&gt;; // Fix Me</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">			</span>i-cache-line-size =3D &lt;0x32&g=
t;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>d-c=
ache-line-size =3D &lt;0x32&gt;;</div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">			</span>i-cache-size =3D &lt;0x8000&gt;; /* 32 k=
B */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>d-c=
ache-size =3D &lt;0x8000&gt;; /* 32 kB */</div><div><span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">			</span>dcr-controller;</div><div><span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>dcr-access-me=
thod =3D &quot;native&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>};</=
div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>}=
;</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>memory {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>devi=
ce_type =3D &quot;memory&quot;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">		</span>reg =3D &lt;0x00000000 0x00000000 0x100000=
00&gt;; // Fix me</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv><div><br></div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>UICB0: interrupt-controller-base {</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>compatible=
 =3D &quot;ibm,uic-440gx&quot;, &quot;ibm,uic&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupt-controller;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>cell-index =3D &lt;0x3&gt;;</div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">		</span>dcr-reg =3D &lt;0x200 0x009=
&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#add=
ress-cells =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>#size-cells =3D &lt;0&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#interrupt-cells =3D=
 &lt;0x2&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv><div><br></div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>UIC0: interrupt-controller0 {</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>compatible =3D =
&quot;ibm,uic-440gx&quot;, &quot;ibm,uic&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupt-controller;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>cell-index =3D &lt;0&gt;;</div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">		</span>dcr-reg =3D &lt;0x0c0 0x009&g=
t;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#add=
ress-cells =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>#size-cells =3D &lt;0&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#interrupt-cells =3D=
 &lt;2&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupts =3D &lt;0x1 0x4 0x0 0x4&gt;; /* cascade - first non-critical */</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>int=
errupt-parent =3D &lt;&amp;UICB0&gt;;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>};</div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>UIC1: interrupt-controller1 {</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>compatible =3D =
&quot;ibm,uic-440gx&quot;, &quot;ibm,uic&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupt-controller;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>cell-index =3D &lt;1&gt;;</div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">		</span>dcr-reg =3D &lt;0x0d0 0x009&g=
t;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#add=
ress-cells =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>#size-cells =3D &lt;0&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#interrupt-cells =3D=
 &lt;2&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupts =3D &lt;0x3 0x4 0x2 0x4&gt;; /* cascade */</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">		</span>interrupt-parent =3D &lt=
;&amp;UICB0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">	</span>UIC2: interrupt-controller2 {</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">		</span>compatible =3D &quot;ibm,uic-44=
0gx&quot;, &quot;ibm,uic&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupt-controller;</div><div><span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">		</span>cell-index =3D &lt;2&gt;; /* was 1 */</div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dcr-reg =3D &lt;0=
x210 0x009&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#add=
ress-cells =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>#size-cells =3D &lt;0&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#interrupt-cells =3D=
 &lt;2&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupts =3D &lt;0x5 0x4 0x4 0x4&gt;; /* cascade */</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">		</span>interrupt-parent =3D &lt=
;&amp;UICB0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv><div><br></div><div><br></div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>CPC0: cpc {</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">		</span>compatible =3D &quot;ibm,cpc-440g=
p&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dcr-=
reg =3D &lt;0x0b0 0x003 0x0e0 0x010&gt;;</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">		</span>// FIXME: anything else?</div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>L2C0: l2c {</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">		</span>compatible =3D &quot;ibm,l2-cache-440gx&quot;, &quot=
;ibm,l2-cache&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>dcr-=
reg =3D &lt;0x020 0x008<span class=3D"Apple-tab-span" style=3D"white-space:=
pre">			</span>/* Internal SRAM DCR&#39;s */</div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">			</span> =A0 0x030 0x008&gt;;<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>/* L2 cache DCR&=
#39;s */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>cach=
e-line-size =3D &lt;0x20&gt;;<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">		</span>/* 32 bytes */</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">		</span>cache-size =3D &lt;0x40000&gt;;<span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">		</span>/* L2, 256K */</d=
iv>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>inte=
rrupt-parent =3D &lt;&amp;UIC2&gt;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">		</span>interrupts =3D &lt;0x17 0x1&gt;;</div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>};</d=
iv>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">	</span>plb {</div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">		</span>compatible =3D &quot;ibm,plb-440gx&quot;, &quot;ibm,plb4&q=
uot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>#add=
ress-cells =3D &lt;2&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">		</span>#size-cells =3D &lt;1&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span>ranges;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>cloc=
k-frequency =3D &lt;0x9896800&gt;; // 160MHz, fixed me</div><div><br></div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>SDRA=
M0: memory-controller {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>com=
patible =3D &quot;ibm,sdram-440gp&quot;;</div><div><span class=3D"Apple-tab=
-span" style=3D"white-space:pre">			</span>dcr-reg =3D &lt;0x010 0x002&gt;;=
</div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>// FIXME=
: anything else?</div><div><span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">		</span>};</div><div><br></div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">		</span>SRAM0: sram {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>com=
patible =3D &quot;ibm,sram-440gp&quot;;</div><div><span class=3D"Apple-tab-=
span" style=3D"white-space:pre">			</span>dcr-reg =3D &lt;0x020 0x008 0x00a=
 0x001&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>};</=
div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">		</span>DMA0: dma {</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>// FIXME: ???</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>com=
patible =3D &quot;ibm,dma-440gp&quot;;</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">			</span>dcr-reg =3D &lt;0x100 0x027&gt;;</=
div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>};</div><=
div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>		</span>MAL0: mcmal {</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">			</span>compatible =3D &quot;ibm,mcmal-440gx&quot;, &quot=
;ibm,mcmal2&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>dcr=
-reg =3D &lt;0x180 0x062&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>num-tx-chans =3D &lt;4&gt;;</div><div><span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>num-rx-chans =
=3D &lt;4&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>int=
errupt-parent =3D &lt;&amp;MAL0&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">			</span>interrupts =3D &lt;0x0 0x1 0x2 0x3 0=
x4&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>#in=
terrupt-cells =3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>#address-cells =3D &lt;0&gt;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>#size-cells =
=3D &lt;0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>int=
errupt-map =3D &lt;/*TXEOB*/ 0x0 &amp;UIC0 0xa 0x4</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">						</span> =A0<span class=3D"=
Apple-tab-span" style=3D"white-space:pre">	</span> /*RXEOB*/ 0x1 &amp;UIC0 =
0xb 0x4</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">							</span=
> /*SERR*/ =A00x2 &amp;UIC1 0x0 0x4</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">							</span> /*TXDE*/ =A00x3 &amp;UIC1 0x1 0x=
4</div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">							</span> /*R=
XDE*/ =A00x4 &amp;UIC1 0x2 0x4&gt;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">			</span>interrupt-map-mask =3D &lt;0xffffffff=
&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>};</=
div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space=
:pre">		</span>PCIDMA: pci_dma {</div><div><span class=3D"Apple-tab-span" s=
tyle=3D"white-space:pre">				</span>compatible =3D &quot;ibm,pci_dma_440gx&=
quot;,&quot;ibm,pci_dma&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;PCIDMA&gt;;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span></div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>#interrupt-cells =3D &lt;1&gt;;<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">							</span></div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>#a=
ddress-cells =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">				</span>#size-cells =3D &lt;0&gt;;</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>interrupts =
=3D &lt;0x0 0x1 0x2 0x3&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-map =3D &lt; /* PCI MSG IN =A0*/ 0x0 &amp;UIC0 0x4 =A00x4</div><div=
><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DMAChannel0 */ 0x1 &amp;UIC0 0xc =A00x4</=
div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">						</span>=
 =A0/* DMAChannel1 */ 0x2 &amp;UIC0 0xd =A00x4</div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">						</span> =A0/* IRQ5 =A0 =A0 =A0=
 =A0*/ 0x3 &amp;UIC0 0x1c 0x3&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-map-mask =3D &lt;0xffffffff&gt;;<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">		</span> =A0</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">		</span>};<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">		</span></div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span>POB0: opb {</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">			</span>compatible =3D &quot;ibm,opb-440gx&quot;, &quot;ib=
m,opb&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>#ad=
dress-cells =3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>#size-cells =3D &lt;1&gt;;</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>/* Wish there w=
as a nicer way of specifying a full 32-bit</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0 range */</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">			</span>ranges =3D &lt;0x00000000 0x00000001 0x00000000 0x80000000</=
div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</spa=
n> =A0 <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =
=A00x80000000 0x00000001 0x80000000 0x80000000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>dcr=
-reg =3D &lt;0x090 0x00b&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>interrupt-parent =3D &lt;&amp;UIC1&gt;;</di=
v><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>i=
nterrupts =3D &lt;0x7 0x4&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>clo=
ck-frequency =3D &lt;0x4C4B400&gt;; // 80MHz</div><div><br></div><div><br><=
/div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</spa=
n>EBC0: ebc {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>co=
mpatible =3D &quot;ibm,ebc-440gx&quot;, &quot;ibm,ebc&quot;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>dcr-reg =3D=
 &lt;0x012 0x002&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>#a=
ddress-cells =3D &lt;2&gt;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">				</span>#size-cells =3D &lt;1&gt;;</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>clock-frequen=
cy =3D &lt;0x4C4B400&gt;; // 80MHz</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>/* ranges property is supplied by zImage</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">				</span> * based on firmwa=
re&#39;s configuration of the</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> *=
 EBC bridge */</div><div><br></div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>interrupts =3D &lt;0x5 0x4&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>interru=
pt-parent =3D &lt;&amp;UIC1&gt;;</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>nor_flash@0,0 {</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">					</span>compatible =3D &quot;cfi-flash&quot;;</div=
><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>bank-w=
idth =3D &lt;2&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">					</span>device-width =3D &lt;1&gt;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">					</span>#address-cells =
=3D &lt;1&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>#=
size-cells =3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">					</span>reg =3D &lt;0x0 0x0 0x2000000&gt;;<span class=
=3D"Apple-tab-span" style=3D"white-space:pre">		</span></div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>p=
artition@0 {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:=
pre">						</span>label =3D &quot;user&quot;;</div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">						</span>reg =3D &lt;0x0 0x100000=
0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>}=
;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					<=
/span>partition@1000000 {</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">						</span>label =3D &quot;root&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">						</span>=
reg =3D &lt;0x1000000 0xB00000&gt;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">					</span>};</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">					</span>partition@1B00000 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">						</span>=
label =3D &quot;kernel&quot;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">						</span>reg =3D &lt;0x1B00000 0x480000&gt;;</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>=
};</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>p=
artition@1F80000 {</div><div><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">						</span>label =3D &quot;fdt&quot;;</div><div><span class=3D=
"Apple-tab-span" style=3D"white-space:pre">						</span>reg =3D &lt;0x1F800=
00 0x20000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>}=
;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					<=
/span>partition@1FA0000 {</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">						</span>label =3D &quot;env&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">						</span>=
reg =3D &lt;0x1FA0000 0x20000&gt;;</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">					</span>};</div><div><span class=3D"Apple-ta=
b-span" style=3D"white-space:pre">					</span>partition@1FC0000 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">						</span>=
label =3D &quot;u-boot&quot;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">						</span>reg =3D &lt;0x1fc0000 0x40000&gt;;</div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">					</span>}=
;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>};=
</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spa=
ce:pre">			</span>};</div><div><br></div><div><br></div><div><br></div><div=
><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>UART0: =
serial@40000200 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;serial&quot;;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">				</span>compatible =3D &quot;ns16550&quot;;</d=
iv><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>reg =3D=
 &lt;0x40000200 0x00000008&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>virtual-reg =3D &lt;0xe0000200&gt;;</div=
><div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</spa=
n>clock-frequency =3D &lt;0xA8C000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>cu=
rrent-speed =3D &lt;0x1C200&gt;; /* 115200 */</div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">				</span>interrupt-parent =3D &lt;&=
amp;UIC0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupts =3D &lt;0x0 0x4&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>};</div><div><br></div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">			</span>UART1: serial@40000300 =
{</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;serial&quot;;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">				</span>compatible =3D &quot;ns16550&quot;;</d=
iv><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>reg =3D=
 &lt;0x40000300 0x00000008&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>virtual-reg =3D &lt;0xe0000300&gt;;</div=
><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>c=
lock-frequency =3D &lt;0xA8C000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>cu=
rrent-speed =3D &lt;0x1C200&gt;; /* 115200 */</div><div><span class=3D"Appl=
e-tab-span" style=3D"white-space:pre">				</span>interrupt-parent =3D &lt;&=
amp;UIC0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupts =3D &lt;0x1 0x4&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>};</div><div><br></div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">			</span>IIC0: i2c@40000400 {</d=
iv>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>/*=
 FIXME */</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>compatible =3D &quot;ibm,iic-440gp&quot;, &quot;ibm,iic&quot;;=
</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000400 0x00000014&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>interrupt-parent =3D &lt;&amp;UIC0&=
gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupts =3D &lt;0x2 0x4&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>index =3D &lt;0&gt;;</div><div>/*<span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">				</span>clock-frequency =
=3D &lt;0x186a0&gt;;<span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>*/</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</spa=
n>IIC1: i2c@40000500 {</div><div><span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">				</span>/* FIXME */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>co=
mpatible =3D &quot;ibm,iic-440gp&quot;, &quot;ibm,iic&quot;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>reg =3D &lt=
;0x40000500 0x00000014&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;UIC0&gt;;</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">				</span>interrupts =3D &lt;0x3 0x4&gt;;</d=
iv><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>index =
=3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">				</span>#address-cells =3D &lt;0x1&gt;;</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">				</span>#size-cells =3D &lt;0&=
gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rt=
c@68 {</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
				</span>compatible =3D &quot;dallas,ds1338&quot;;</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">					</span>reg =3D &lt;0x68&=
gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>};=
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</sp=
an>};</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"whit=
e-space:pre">			</span>GPIO0: gpio@40000700 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>/*=
 FIXME */</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>compatible =3D &quot;ibm,gpio-440gp&quot;;</div><div><span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">				</span>reg =3D &lt;0x40=
000700 0x00000020&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">			</span>ZMII0: emac-zmii@40000780 {</div><div><span class=3D"Apple=
-tab-span" style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,zm=
ii-440gx&quot;, &quot;ibm,zmii&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000780 0x0000000c&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">			</span>};</div><div><br></div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>RGMII0: emac-rgm=
ii@40000790 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>co=
mpatible =3D &quot;ibm,rgmii&quot;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>reg =3D &lt;0x40000790 0x00000008&gt=
;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">			</span>TAH0: emac-tah@40000b50 {</div><div><span class=3D"Apple-t=
ab-span" style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,tah-=
440gx&quot;, &quot;ibm,tah&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000b50 0x00000030&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">			</span>};</div><div><br></div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>TAH1: emac-tah@4=
0000d50 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>co=
mpatible =3D &quot;ibm,tah-440gx&quot;, &quot;ibm,tah&quot;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>reg =3D &lt=
;0x40000d50 0x00000030&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">			</span>EMAC0: ethernet@40000800 {</div><div><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">				</span>unused =3D &lt;0x1&gt;;</div=
>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;network&quot;;</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,emac-440gx&q=
uot;, &quot;ibm,emac4&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;UIC1&gt;;</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">				</span>interrupts =3D &lt;0x1c 0x4 0x1d 0=
x4&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000800 0x00000074&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>local-mac-address =3D [000000000000=
]; // Fill me</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ma=
l-device =3D &lt;&amp;MAL0&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>mal-tx-channel =3D &lt;0&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>mal-rx-=
channel =3D &lt;0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ce=
ll-index =3D &lt;0&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">				</span>max-frame-size =3D &lt;0x5DC&gt;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rx-fifo-siz=
e =3D &lt;0x1000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tx=
-fifo-size =3D &lt;0x800&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>phy-mode =3D &quot;rmii&quot;;</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>phy-map =
=3D &lt;0x00000004&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>zm=
ii-device =3D &lt;&amp;ZMII0&gt;;</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">				</span>zmii-channel =3D &lt;0&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>EMAC1: ethernet@40000900 {</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">				</span>unused =3D &lt;0x1&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;network&quot;;</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,emac-440gx&q=
uot;, &quot;ibm,emac4&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;UIC1&gt;;</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">				</span>interrupts =3D &lt;0x1e 0x4 0x1f 0=
x4&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000900 0x00000074&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>local-mac-address =3D [000000000000=
]; // Fill me</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ma=
l-device =3D &lt;&amp;MAL0&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>mal-tx-channel =3D &lt;1&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>mal-rx-=
channel =3D &lt;1&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ce=
ll-index =3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">				</span>max-frame-size =3D &lt;0x5DC&gt;;</div><div><spa=
n class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rx-fifo-siz=
e =3D &lt;0x1000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tx=
-fifo-size =3D &lt;0x800&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>phy-mode =3D &quot;rmii&quot;;</div><div><=
span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>phy-map =
=3D &lt;0x00000003&gt;;</div>
<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span=
>zmii-device =3D &lt;&amp;ZMII0&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>zmii-channel =3D &lt;1&gt;;</div><d=
iv><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};</d=
iv>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">		</span> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</spa=
n>EMAC2: ethernet@40000c00 {</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>//<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>unused =3D &lt;0x1&gt;;=A0</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;network&quot;;</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,emac-440gx&q=
uot;, &quot;ibm,emac4&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;UIC2&gt;;</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">				</span>interrupts =3D &lt;0x0 0x4 0x1 0x4=
&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000c00 0x00000074&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>local-mac-address =3D [000000000000=
]; // Fill me</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ma=
l-device =3D &lt;&amp;MAL0&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>mal-tx-channel =3D &lt;2&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>mal-rx-=
channel =3D &lt;2&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ce=
ll-index =3D &lt;2&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">				</span>max-frame-size =3D &lt;0x2328&gt;;</div><div><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rx-fifo-si=
ze =3D &lt;0x1000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tx=
-fifo-size =3D &lt;0x800&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>phy-mode =3D &quot;rgmii&quot;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>phy-map=
 =3D &lt;0x00000002&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rg=
mii-device =3D &lt;&amp;RGMII0&gt;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>rgmii-channel =3D &lt;0&gt;;</div><d=
iv>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>z=
mii-device =3D &lt;&amp;ZMII0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>zm=
ii-channel =3D &lt;2&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">				</span>tah-device =3D &lt;&amp;TAH0&gt;;</div><div><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tah-chann=
el =3D &lt;0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-spac=
e:pre">		</span> <span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>EMAC3: ethernet@40000e00 {</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>de=
vice_type =3D &quot;network&quot;;</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">				</span>compatible =3D &quot;ibm,emac-440gx&q=
uot;, &quot;ibm,emac4&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupt-parent =3D &lt;&amp;UIC2&gt;;</div><div><span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">				</span>interrupts =3D &lt;0x2 0x4 0x3 0x4=
&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000e00 0x00000074&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>local-mac-address =3D [000000000000=
]; // Fill me</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ma=
l-device =3D &lt;&amp;MAL0&gt;;</div><div><span class=3D"Apple-tab-span" st=
yle=3D"white-space:pre">				</span>mal-tx-channel =3D &lt;3&gt;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>mal-rx-=
channel =3D &lt;3&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>ce=
ll-index =3D &lt;3&gt;;</div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">				</span>max-frame-size =3D &lt;0x2328&gt;;</div><div><sp=
an class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rx-fifo-si=
ze =3D &lt;0x1000&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tx=
-fifo-size =3D &lt;0x800&gt;;</div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">				</span>phy-mode =3D &quot;rgmii&quot;;</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>phy-map=
 =3D &lt;0x00000001&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>rg=
mii-device =3D &lt;&amp;RGMII0&gt;;</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>rgmii-channel =3D &lt;1&gt;;</div><d=
iv>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>z=
mii-device =3D &lt;&amp;ZMII0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>zm=
ii-channel =3D &lt;3&gt;;</div><div><span class=3D"Apple-tab-span" style=3D=
"white-space:pre">				</span>tah-device =3D &lt;&amp;TAH1&gt;;</div><div><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>tah-chann=
el =3D &lt;0&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};<=
/div><div><br></div><div><br></div><div><span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">			</span>GPT0: gpt@40000a00 {</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">				</span>/* FIXME */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>re=
g =3D &lt;0x40000a00 0x000000d4&gt;;</div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">				</span>interrupt-parent =3D &lt;&amp;UIC0&=
gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>in=
terrupts =3D &lt;0x12 0x4 0x13 0x4 0x14 0x4 0x15 0x4 0x16 0x4&gt;;</div><di=
v><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>};</di=
v><div>
<br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		<=
/span>};</div><div><br></div><div><span class=3D"Apple-tab-span" style=3D"w=
hite-space:pre">		</span>PCIX0: pci@20ec00000 {</div><div><span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">			</span>device_type =3D &quot;pci=
&quot;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>#in=
terrupt-cells =3D &lt;1&gt;;</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">			</span>#size-cells =3D &lt;2&gt;;</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>#address-cells =
=3D &lt;3&gt;;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>com=
patible =3D &quot;ibm,plb440gp-pcix&quot;, &quot;ibm,plb-pcix&quot;;</div><=
div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>prim=
ary;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>lar=
ge-inbound-windows;</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">			</span>enable-msi-hole;</div><div><span class=3D"Apple-tab-s=
pan" style=3D"white-space:pre">			</span>reg =3D &lt;0x00000002 0x0ec00000 =
0x00000008<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span=
>/* Config space access */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0 =A0 =A0 0x00000000 0x00000000 0x00000000<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>/* no IACK cycles */</div><div><span cla=
ss=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =A0 =A0 =A0 0x00=
000002 0x0ed00000 0x00000004 =A0 <span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>/* Special cycles */</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0 =A0 =A0 0x00000002 0x0ec80000 0x00000100<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>/* Internal registers */</div><div><span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =A0 =A0 =A0 =
0x00000002 0x0ec80100 0x000000fc&gt;;<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>/* Internal messaging registers */</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">			</span>/* Outbound ranges, one memory and one IO,</div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">			</span> * later cannot be=
 changed</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> */=
</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</sp=
an> /*<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =A0=
 =A0 Type =A0 =A0 =A0 =A0 =A0PCIAddr =A0 =A0 =A0 =A0 =A0PLBAddr =A0 =A0 =A0=
 =A0 =A0Size</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0* =A0 PCI Memory =A0 =A0 =A00x80000000 =A0 =A0 =A00x380000000 =A0 =A0 =
=A0 =A02GB =A0 =A0</div><div><span class=3D"Apple-tab-span" style=3D"white-=
space:pre">			</span> =A0* =A0 =A0 =A0 I/O =A0 =A0 =A0 =A0 0x0 =A0 =A0 =A0 =
=A0 =A0 =A0 0x208000000 =A0 =A0 =A0 =A064KB=A0</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0*/=A0</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>			</span>ranges =3D &lt;0x02000000 0x00000000 0x80000000 0x00000003 0x800=
00000 0x00000000 0x80000000</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
=A0 <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =A00x=
01000000 0x00000000 0x00000000 0x00000002 0x08000000 0x00000000 0x00010000&=
gt;;=A0</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">			</span>/* Inbound 2GB range starting at 0 */</div><div><span class=3D"=
Apple-tab-span" style=3D"white-space:pre">			</span></div><div>=A0=A0 =A0 =
=A0 =A0 <span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> /=
*<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span> =A0 =A0 =
Type =A0 =A0 =A0 =A0 =A0PCIAddr =A0 =A0 =A0 =A0 =A0PLBAddr =A0 =A0 =A0 =A0 =
=A0Size<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span></=
div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0* =A0 PCI Memory =A0 =A0 =A0 =A0 0x0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0 =A0 =
=A0 =A0 =A0 =A0 =A02GB =A0 =A0</div><div><span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">			</span> =A0* =A0(prefetchable) =A0(Fixed in linux=
?)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span> =
=A0*/=A0</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>			</span>dma-ranges =3D &lt;0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000&gt;=
;</div><div>
<br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			=
</span>interrupt-map-mask =3D &lt;0xf800 0x0 0x0 0x7&gt;;</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">			</span>interrupt-map =
=3D &lt;</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>/*=
 IDSEL 1 */</div><div><span class=3D"Apple-tab-span" style=3D"white-space:p=
re">				</span>0x0800 0x0 0x0 0x1 &amp;UIC0 0x17 0x8</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">				</span>0x0800 0x0 0x0 0x2=
 &amp;UIC0 0x18 0x8</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>0x=
0800 0x0 0x0 0x3 &amp;UIC0 0x19 0x8</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>0x0800 0x0 0x0 0x4 &amp;UIC0 0x1a 0x=
8</div>
<div><br></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre=
">				</span>/* IDSEL 2 */</div><div><span class=3D"Apple-tab-span" style=
=3D"white-space:pre">				</span>0x1000 0x0 0x0 0x1 &amp;UIC0 0x18 0x8</div>=
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>0x=
1000 0x0 0x0 0x2 &amp;UIC0 0x19 0x8</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span>0x=
1000 0x0 0x0 0x3 &amp;UIC0 0x1a 0x8</div><div><span class=3D"Apple-tab-span=
" style=3D"white-space:pre">				</span>0x1000 0x0 0x0 0x4 &amp;UIC0 0x17 0x=
8</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>&gt=
;;</div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">		</s=
pan>};</div><div><br></div><div><br></div><div><span class=3D"Apple-tab-spa=
n" style=3D"white-space:pre">	</span>};</div>
<div>When kernel boots, panic happens</div><div><br></div><div>2. As I doub=
t error exists in dts, so I add a mtd map driver for the board instead, but=
 kernel boots panic all the same</div><div><div>#include &lt;linux/module.h=
&gt;</div>
<div>#include &lt;linux/types.h&gt;</div><div>#include &lt;linux/kernel.h&g=
t;</div><div>#include &lt;linux/init.h&gt;</div><div>#include &lt;linux/mtd=
/mtd.h&gt;</div><div>#include &lt;linux/mtd/map.h&gt;</div><div>#include &l=
t;linux/mtd/partitions.h&gt;</div>
<div>#include &lt;asm/io.h&gt;</div><div>#define CFG_FLASH_BUS_WIDTH =A0 =
=A0 2</div><div>#define CFG_FLASH_SIZE =A0 =A0 =A0 =A0 =A00x2000000 =A0 =A0=
 =A0 /* Bytes */</div><div>#define CFG_FLASH_ADDR =A0 =A0 =A0 =A0 =A00x1FE0=
00000ULL</div><div><br></div>
<div>#define FLASH_MSG_PREFIX =A0 =A0 =A0 =A0&quot;S29GL-NOR:&quot;</div><d=
iv>#define MTD_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;s29gl-nor&quot;<=
/div><div><br></div><div><br></div><div>struct map_info s29gl_map =3D {</di=
v><div>=A0=A0 =A0 =A0 =A0.name =3D &quot;Nor Flash on Cerberus&quot;,</div>
<div>=A0=A0 =A0 =A0 =A0.size =3D CFG_FLASH_SIZE,</div><div>=A0=A0 =A0 =A0 =
=A0.bankwidth =3D CFG_FLASH_BUS_WIDTH,</div><div>};</div><div><br></div><di=
v><br></div><div>static struct mtd_partition cerberus_partition[] =3D {</di=
v><div>=A0=A0 =A0 =A0 =A0{</div><div>
=A0=A0 =A0 =A0 =A0 .name =3D &quot;user&quot;,</div><div>=A0=A0 =A0 =A0 =A0=
 .offset =3D 0x0,</div><div>=A0=A0 =A0 =A0 =A0 .size =3D 0x1000000,</div><d=
iv>=A0=A0 =A0 =A0 =A0 },</div><div>=A0=A0 =A0 =A0 =A0{</div><div>=A0=A0 =A0=
 =A0 =A0 .name =3D &quot;root&quot;,</div><div>=A0=A0 =A0 =A0 =A0 .offset =
=3D 0x1000000,</div>
<div>=A0=A0 =A0 =A0 =A0 .size =3D 0xB00000,</div><div>=A0=A0 =A0 =A0 =A0 },=
</div><div>=A0=A0 =A0 =A0 =A0{</div><div>=A0=A0 =A0 =A0 =A0 .name =3D &quot=
;kernel&quot;,</div><div>=A0=A0 =A0 =A0 =A0 .offset =3D 0x1B00000,</div><di=
v>=A0=A0 =A0 =A0 =A0 .size =3D 0x480000,</div><div>=A0=A0 =A0 =A0 =A0 },</d=
iv>
<div>=A0=A0 =A0 =A0 =A0{</div><div>=A0=A0 =A0 =A0 =A0 .name =3D &quot;fdt&q=
uot;,</div><div>=A0=A0 =A0 =A0 =A0 .offset =3D 0x1F80000,</div><div>=A0=A0 =
=A0 =A0 =A0 .size =3D 0x20000,</div><div>=A0=A0 =A0 =A0 =A0 },</div><div>=
=A0=A0 =A0 =A0 =A0{</div><div>=A0=A0 =A0 =A0 =A0 .name =3D &quot;env&quot;,=
</div>
<div>=A0=A0 =A0 =A0 =A0 .offset =3D 0x1FA0000,</div><div>=A0=A0 =A0 =A0 =A0=
 .size =3D 0x20000,</div><div>=A0=A0 =A0 =A0 =A0 },</div><div>=A0=A0 =A0 =
=A0 =A0{</div><div>=A0=A0 =A0 =A0 =A0 .name =3D &quot;u-boot&quot;,</div><d=
iv>=A0=A0 =A0 =A0 =A0 .offset =3D 0x1FC0000,</div><div>=A0=A0 =A0 =A0 =A0 .=
size =3D 0x40000,</div>
<div>=A0=A0 =A0 =A0 =A0}</div><div>};</div><div><br></div><div><br></div><d=
iv>static struct mtd_info *s29gl_mtd_info;</div><div>static struct mtd_part=
ition *mtd_parts =3D 0;</div><div><br></div><div>int __init s29gl_init(void=
)</div><div>
{</div><div>=A0=A0 =A0 =A0 =A0phys_addr_t flash_base =3D CFG_FLASH_ADDR;</d=
iv><div>=A0=A0 =A0 =A0 =A0printk(KERN_NOTICE FLASH_MSG_PREFIX &quot;0x%08x =
at 0x%llx\n&quot;,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 CFG_FLASH_SIZE,=
CFG_FLASH_ADDR);</div><div>=A0=A0 =A0 =A0 =A0s29gl_map.phys =3D flash_base;=
</div>
<div>=A0=A0 =A0 =A0 =A0s29gl_map.virt=3Dioremap(CFG_FLASH_ADDR,CFG_FLASH_SI=
ZE);</div><div>=A0=A0 =A0 =A0 =A0if (!s29gl_map.virt){</div><div>=A0=A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR FLASH_MSG_PREFIX&quot;failed to ior=
emap\n&quot;);</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;</di=
v>
<div>=A0=A0 =A0 =A0 =A0}</div><div>=A0=A0 =A0 =A0 =A0simple_map_init(&amp;s=
29gl_map);</div><div>=A0=A0 =A0 =A0 =A0s29gl_mtd_info =3D do_map_probe(&quo=
t;cfi_probe&quot;,&amp;s29gl_map);</div><div>=A0=A0 =A0 =A0 =A0if (s29gl_mt=
d_info){</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s29gl_mtd_info-&gt;own=
er=3DTHIS_MODULE;</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_mtd_partitions(s29gl_mtd_info,ce=
rberus_partition,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(cerberus_partition));</div><div>=A0=A0 =
=A0 =A0 =A0} else {</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN=
_ERR FLASH_MSG_PREFIX&quot;Map probe failed\n&quot;);</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap((void*)s29gl_map.virt);</div=
><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s29gl_map.virt=3D0;</div><div>=A0=
=A0 =A0 =A0 =A0}</div><div>}</div><div><br></div><div>static void __exit s2=
9gl_exit(void)</div><div>{</div><div>=A0=A0 =A0 =A0 =A0if(s29gl_mtd_info){<=
/div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0del_mtd_partitions(s29gl_mtd_info);<=
/div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_destroy(s29gl_mtd_info);</d=
iv><div>=A0=A0 =A0 =A0 =A0}</div><div>=A0=A0 =A0 =A0 =A0if(s29gl_map.virt){=
</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap((void*)s29gl_map.virt)=
;</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s29gl_map.virt=3D0;</div><div>=A0=A0=
 =A0 =A0 =A0}</div><div>}</div><div><br></div><div>module_init(s29gl_init);=
</div><div>module_exit(s29gl_exit);</div><div><br></div><div>MODULE_LICENSE=
(&quot;GPL&quot;);</div><div>
MODULE_DESCRIPTION(&quot;MTD map and partition for 440GX boards&quot;);</di=
v><div><br></div><div>---------------------kernel panic log----------------=
--</div><div><div>/plb/opb/emac-rgmii@40000790: input 0 in RGMII mode</div>
<div>eth0: EMAC-2 /plb/opb/ethernet@40000c00, MAC 00:22:33:44:55:66</div><d=
iv>eth0: found Generic MII PHY (0x00)</div><div>/plb/opb/emac-rgmii@4000079=
0: input 1 in RGMII mode</div><div>eth1: EMAC-3 /plb/opb/ethernet@40000e00,=
 MAC 00:33:44:55:66:77</div>
<div>eth1: found Marvell 88E1111 Ethernet PHY (0x03)</div><div>S29GL-NOR:0x=
02000000 at 0x1fe000000</div><div>HERE1</div><div>Machine check in kernel m=
ode.</div><div>Data Write PLB Error</div><div>Oops: Machine check, sig: 7 [=
#1]</div>
<div>Cerberus</div><div>Modules linked in:</div><div>NIP: c01943f8 LR: c018=
e5c8 CTR: c01943a0</div><div>REGS: c02daf50 TRAP: 0214 =A0 Not tainted =A0(=
2.6.26.5)</div><div>MSR: 00029000 &lt;EE,ME&gt; =A0CR: 42344a22 =A0XER: 000=
00000</div>
<div>TASK =3D cf828000[1] &#39;swapper&#39; THREAD: cf82c000</div><div>GPR0=
0: 0000f0f0 cf82de50 cf828000 c02cd1a0 cf82de58 00000000 cf82de98 000000</d=
iv><div>GPR08: 00000000 d1180000 00000002 00000001 82344a22 40350100 c02568=
50 c02568</div>
<div>GPR16: c0256828 c0256810 cf82df98 c02b5de0 c02b0000 00000000 cf82de58 =
c02b00</div><div>GPR24: cf82df58 c02b5d7c 00000000 c02cd1a0 cf82de98 000000=
00 c02ccd1c c02cd1</div><div>NIP [c01943f8] simple_map_write+0x58/0x60</div=
>
<div>LR [c018e5c8] cfi_probe_chip+0xcc/0xeb4</div><div>Call Trace:</div><di=
v>[cf82de50] [c001d5b4] printk+0x50/0x60 (unreliable)</div><div>[cf82de90] =
[c019404c] mtd_do_chip_probe+0xa4/0x3ac</div><div>[cf82df00] [c018e4ec] cfi=
_probe+0x1c/0x2c</div>
<div>[cf82df10] [c018e25c] do_map_probe+0x34/0x90</div><div>[cf82df30] [c02=
ac28c] s29gl_init+0x74/0xf0</div><div>[cf82df50] [c02971b0] kernel_init+0xa=
8/0x28c</div><div>[cf82dff0] [c000c3dc] kernel_thread+0x44/0x60</div><div>
Instruction dump:</div><div>81230010 7c05492e 7c0004ac 4e800020 81230010 54=
00063e 7c0549ae 7c0004ac</div><div>4e800020 81230010 5400043e 7c054b2e &lt;=
7c0004ac&gt; 4e800020 81230018 2b890004</div><div>---[ end trace 5fac80aef6=
224e66 ]---</div>
<div>Kernel panic - not syncing: Attempted to kill init!</div><div>Rebootin=
g in 180 seconds..</div><div><br></div><div>The above panic log prints &quo=
t;HERE1&quot; &#39;cause I changed=A0mtd_do_chip_probe() as follows.</div>
<div><div>struct mtd_info *mtd_do_chip_probe(struct map_info *map, struct c=
hip_probe *cp)</div><div>{</div><div>=A0=A0 =A0 =A0 =A0struct mtd_info *mtd=
 =3D NULL;</div><div>=A0=A0 =A0 =A0 =A0struct cfi_private *cfi;</div><div>=
=A0=A0 =A0 =A0 =A0printk(KERN_WARNING &quot;HERE1\n&quot;);</div>
<div>=A0=A0 =A0 =A0 =A0/* First probe the map to see if we have CFI stuff t=
here. */</div><div>=A0=A0 =A0 =A0 =A0cfi =3D genprobe_ident_chips(map, cp);=
</div><div>=A0=A0 =A0 =A0 =A0printk(KERN_WARNING &quot;HERE2\n&quot;);</div=
><div><br></div><div>=A0=A0 =A0 =A0 =A0if (!cfi)</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;</div><div>=A0=A0 =A0 =
=A0 =A0printk(KERN_WARNING &quot;HERE3\n&quot;);</div><div><br></div><div>=
=A0=A0 =A0 =A0 =A0map-&gt;fldrv_priv =3D cfi;</div><div>=A0=A0 =A0 =A0 =A0/=
* OK we liked it. Now find a driver for the command set it talks */</div>
<div><br></div><div>=A0=A0 =A0 =A0 =A0mtd =3D check_cmd_set(map, 1); /* Fir=
st the primary cmdset */</div><div>=A0=A0 =A0 =A0 =A0printk(KERN_WARNING &q=
uot;HERE4\n&quot;);</div><div><br></div><div>=A0=A0 =A0 =A0 =A0if (!mtd){</=
div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtd =3D check_cmd_set(map, 0); /=
* Then the secondary */</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING &quot;HERE5\n&qu=
ot;);</div><div>=A0=A0 =A0 =A0 =A0}</div><div>=A0=A0 =A0 =A0 =A0if (mtd) {<=
/div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mtd-&gt;size &gt; map-&gt;s=
ize) {</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(K=
ERN_WARNING &quot;Reducing visibility of %ldKiB chip to %ldKiB\n&quot;,</di=
v>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long)mtd-&gt;size &gt;&gt; 10,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)map-&gt;size &gt;&gt; 10);</=
div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtd-&gt;size =3D=
 map-&gt;size;</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}</div><div>=A0=A0 =A0 =A0 =A0printk=
(KERN_WARNING &quot;HERE6\n&quot;);</div><div><br></div><div>=A0=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0return mtd;</div><div>=A0=A0 =A0 =A0 =A0}</div><div><br=
></div><div>=A0=A0 =A0 =A0 =A0printk(KERN_WARNING&quot;gen_probe: No suppor=
ted Vendor Command Set found\n&quot;);</div>
<div><br></div><div>=A0=A0 =A0 =A0 =A0kfree(cfi-&gt;cfiq);</div><div>=A0=A0=
 =A0 =A0 =A0kfree(cfi);</div><div>=A0=A0 =A0 =A0 =A0map-&gt;fldrv_priv =3D =
NULL;</div><div>=A0=A0 =A0 =A0 =A0return NULL;</div><div>}</div><div>EXPORT=
_SYMBOL(mtd_do_chip_probe)</div><div><br>
</div><div>---------------------------------</div><div>Follow is my .config=
</div><div><div>#</div><div># Automatically generated make config: don&#39;=
t edit</div><div># Linux kernel version: 2.6.25-rc2</div><div># Fri Feb 15 =
21:40:44 2008</div>
<div>#</div><div># CONFIG_PPC64 is not set</div><div><br></div><div>#</div>=
<div># Processor support</div><div>#</div><div># CONFIG_6xx is not set</div=
><div># CONFIG_PPC_85xx is not set</div><div># CONFIG_PPC_8xx is not set</d=
iv>
<div># CONFIG_40x is not set</div><div>CONFIG_44x=3Dy</div><div># CONFIG_E2=
00 is not set</div><div>CONFIG_4xx=3Dy</div><div>CONFIG_BOOKE=3Dy</div><div=
>CONFIG_PTE_64BIT=3Dy</div><div>CONFIG_PHYS_64BIT=3Dy</div><div># CONFIG_PP=
C_MM_SLICES is not set</div>
<div>CONFIG_NOT_COHERENT_CACHE=3Dy</div><div>CONFIG_PPC32=3Dy</div><div>CON=
FIG_WORD_SIZE=3D32</div><div>CONFIG_PPC_MERGE=3Dy</div><div>CONFIG_MMU=3Dy<=
/div><div>CONFIG_GENERIC_CMOS_UPDATE=3Dy</div><div>CONFIG_GENERIC_TIME=3Dy<=
/div><div>
CONFIG_GENERIC_TIME_VSYSCALL=3Dy</div><div>CONFIG_GENERIC_CLOCKEVENTS=3Dy</=
div><div>CONFIG_GENERIC_HARDIRQS=3Dy</div><div># CONFIG_HAVE_SETUP_PER_CPU_=
AREA is not set</div><div>CONFIG_IRQ_PER_CPU=3Dy</div><div>CONFIG_RWSEM_XCH=
GADD_ALGORITHM=3Dy</div>
<div>CONFIG_ARCH_HAS_ILOG2_U32=3Dy</div><div>CONFIG_GENERIC_HWEIGHT=3Dy</di=
v><div>CONFIG_GENERIC_CALIBRATE_DELAY=3Dy</div><div>CONFIG_GENERIC_FIND_NEX=
T_BIT=3Dy</div><div># CONFIG_ARCH_NO_VIRT_TO_BUS is not set</div><div>CONFI=
G_PPC=3Dy</div>
<div>CONFIG_EARLY_PRINTK=3Dy</div><div>CONFIG_GENERIC_NVRAM=3Dy</div><div>C=
ONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy</div><div>CONFIG_ARCH_MAY_HAVE_PC_=
FDC=3Dy</div><div>CONFIG_PPC_OF=3Dy</div><div>CONFIG_OF=3Dy</div><div>CONFI=
G_PPC_UDBG_16550=3Dy</div>
<div># CONFIG_GENERIC_TBSYNC is not set</div><div>CONFIG_AUDIT_ARCH=3Dy</di=
v><div>CONFIG_GENERIC_BUG=3Dy</div><div># CONFIG_DEFAULT_UIMAGE is not set<=
/div><div>CONFIG_PPC_DCR_NATIVE=3Dy</div><div># CONFIG_PPC_DCR_MMIO is not =
set</div>
<div>CONFIG_PPC_DCR=3Dy</div><div>CONFIG_DEFCONFIG_LIST=3D&quot;/lib/module=
s/$UNAME_RELEASE/.config&quot;</div><div><br></div><div>#</div><div># Gener=
al setup</div><div>#</div><div>CONFIG_EXPERIMENTAL=3Dy</div><div>CONFIG_BRO=
KEN_ON_SMP=3Dy</div>
<div>CONFIG_INIT_ENV_ARG_LIMIT=3D32</div><div>CONFIG_LOCALVERSION=3D&quot;&=
quot;</div><div>CONFIG_LOCALVERSION_AUTO=3Dy</div><div>CONFIG_SWAP=3Dy</div=
><div>CONFIG_SYSVIPC=3Dy</div><div>CONFIG_SYSVIPC_SYSCTL=3Dy</div><div>CONF=
IG_POSIX_MQUEUE=3Dy</div>
<div># CONFIG_BSD_PROCESS_ACCT is not set</div><div># CONFIG_TASKSTATS is n=
ot set</div><div># CONFIG_AUDIT is not set</div><div>CONFIG_IKCONFIG is not=
 set</div><div>CONFIG_LOG_BUF_SHIFT=3D14</div><div># CONFIG_CGROUPS is not =
set</div>
<div>CONFIG_GROUP_SCHED=3Dy</div><div>CONFIG_FAIR_GROUP_SCHED=3Dy</div><div=
># CONFIG_RT_GROUP_SCHED is not set</div><div>CONFIG_USER_SCHED=3Dy</div><d=
iv># CONFIG_CGROUP_SCHED is not set</div><div>CONFIG_SYSFS_DEPRECATED=3Dy</=
div>
<div># CONFIG_RELAY is not set</div><div># CONFIG_NAMESPACES is not set</di=
v><div>CONFIG_BLK_DEV_INITRD=3Dy</div><div>CONFIG_INITRAMFS_SOURCE=3D&quot;=
&quot;</div><div># CONFIG_CC_OPTIMIZE_FOR_SIZE is not set</div><div>CONFIG_=
SYSCTL=3Dy</div>
<div>CONFIG_EMBEDDED=3Dy</div><div>CONFIG_SYSCTL_SYSCALL=3Dy</div><div>CONF=
IG_KALLSYMS=3Dy</div><div># CONFIG_KALLSYMS_ALL is not set</div><div># CONF=
IG_KALLSYMS_EXTRA_PASS is not set</div><div>CONFIG_HOTPLUG=3Dy</div><div>CO=
NFIG_PRINTK=3Dy</div>
<div>CONFIG_BUG=3Dy</div><div>CONFIG_ELF_CORE=3Dy</div><div>CONFIG_COMPAT_B=
RK=3Dy</div><div>CONFIG_BASE_FULL=3Dy</div><div>CONFIG_FUTEX=3Dy</div><div>=
CONFIG_ANON_INODES=3Dy</div><div>CONFIG_EPOLL=3Dy</div><div>CONFIG_SIGNALFD=
=3Dy</div><div>
CONFIG_TIMERFD=3Dy</div><div>CONFIG_EVENTFD=3Dy</div><div>CONFIG_SHMEM=3Dy<=
/div><div>CONFIG_VM_EVENT_COUNTERS=3Dy</div><div>CONFIG_SLUB_DEBUG=3Dy</div=
><div># CONFIG_SLAB is not set</div><div>CONFIG_SLUB=3Dy</div><div># CONFIG=
_SLOB is not set</div>
<div># CONFIG_PROFILING is not set</div><div># CONFIG_MARKERS is not set</d=
iv><div>CONFIG_HAVE_OPROFILE=3Dy</div><div># CONFIG_KPROBES is not set</div=
><div>CONFIG_HAVE_KPROBES=3Dy</div><div>CONFIG_PROC_PAGE_MONITOR=3Dy</div><=
div>
CONFIG_SLABINFO=3Dy</div><div>CONFIG_RT_MUTEXES=3Dy</div><div># CONFIG_TINY=
_SHMEM is not set</div><div>CONFIG_BASE_SMALL=3D0</div><div>CONFIG_MODULES=
=3Dy</div><div>CONFIG_MODULE_UNLOAD=3Dy</div><div># CONFIG_MODULE_FORCE_UNL=
OAD is not set</div>
<div># CONFIG_MODVERSIONS is not set</div><div># CONFIG_MODULE_SRCVERSION_A=
LL is not set</div><div>CONFIG_KMOD=3Dy</div><div>CONFIG_BLOCK=3Dy</div><di=
v>CONFIG_LBD=3Dy</div><div># CONFIG_BLK_DEV_IO_TRACE is not set</div><div>#=
 CONFIG_LSF is not set</div>
<div># CONFIG_BLK_DEV_BSG is not set</div><div><br></div><div>#</div><div>#=
 IO Schedulers</div><div>#</div><div>CONFIG_IOSCHED_NOOP=3Dy</div><div>CONF=
IG_IOSCHED_AS=3Dy</div><div>CONFIG_IOSCHED_DEADLINE=3Dy</div><div>CONFIG_IO=
SCHED_CFQ=3Dy</div>
<div>CONFIG_DEFAULT_AS=3Dy</div><div># CONFIG_DEFAULT_DEADLINE is not set</=
div><div># CONFIG_DEFAULT_CFQ is not set</div><div># CONFIG_DEFAULT_NOOP is=
 not set</div><div>CONFIG_DEFAULT_IOSCHED=3D&quot;anticipatory&quot;</div><=
div>
CONFIG_CLASSIC_RCU=3Dy</div><div># CONFIG_PREEMPT_RCU is not set</div><div>=
# CONFIG_PPC4xx_PCI_EXPRESS is not set</div><div><br></div><div>#</div><div=
># Platform support</div><div>#</div><div># CONFIG_PPC_MPC512x is not set</=
div>
<div># CONFIG_PPC_MPC5121 is not set</div><div># CONFIG_PPC_CELL is not set=
</div><div># CONFIG_PPC_CELL_NATIVE is not set</div><div># CONFIG_PQ2ADS is=
 not set</div><div># CONFIG_BAMBOO is not set</div><div># CONFIG_EBONY is n=
ot set</div>
<div># CONFIG_SEQUOIA is not set</div><div># CONFIG_GALAXY=3Dy is not set</=
div><div>CONFIG_CERBERUS=3Dy</div><div><br></div><div># CONFIG_KATMAI is no=
t set</div><div># CONFIG_RAINIER is not set</div><div># CONFIG_WARP is not =
set</div>
<div>CONFIG_440GX=3Dy</div><div># CONFIG_IPIC is not set</div><div># CONFIG=
_MPIC is not set</div><div># CONFIG_MPIC_WEIRD is not set</div><div># CONFI=
G_PPC_I8259 is not set</div><div># CONFIG_PPC_RTAS is not set</div><div># C=
ONFIG_MMIO_NVRAM is not set</div>
<div># CONFIG_PPC_MPC106 is not set</div><div># CONFIG_PPC_970_NAP is not s=
et</div><div># CONFIG_PPC_INDIRECT_IO is not set</div><div># CONFIG_GENERIC=
_IOMAP is not set</div><div># CONFIG_CPU_FREQ is not set</div><div># CONFIG=
_FSL_ULI1575 is not set</div>
<div><br></div><div>#</div><div># Kernel options</div><div>#</div><div># CO=
NFIG_HIGHMEM is not set</div><div># CONFIG_TICK_ONESHOT is not set</div><di=
v># CONFIG_NO_HZ is not set</div><div># CONFIG_HIGH_RES_TIMERS is not set</=
div>
<div>CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy</div><div># CONFIG_HZ_100 is not =
set</div><div>CONFIG_HZ_250=3Dy</div><div># CONFIG_HZ_300 is not set</div><=
div># CONFIG_HZ_1000 is not set</div><div>CONFIG_HZ=3D250</div><div># CONFI=
G_SCHED_HRTICK is not set</div>
<div>CONFIG_PREEMPT_NONE=3Dy</div><div># CONFIG_PREEMPT_VOLUNTARY is not se=
t</div><div># CONFIG_PREEMPT is not set</div><div>CONFIG_RCU_TRACE=3Dy</div=
><div>CONFIG_BINFMT_ELF=3Dy</div><div># CONFIG_BINFMT_MISC is not set</div>=
<div>
# CONFIG_MATH_EMULATION is not set</div><div># CONFIG_IOMMU_HELPER is not s=
et</div><div>CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy</div><div>CONFIG_ARCH_HA=
S_WALK_MEMORY=3Dy</div><div>CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy</div><d=
iv>
CONFIG_ARCH_FLATMEM_ENABLE=3Dy</div><div>CONFIG_ARCH_POPULATES_NODE_MAP=3Dy=
</div><div>CONFIG_SELECT_MEMORY_MODEL=3Dy</div><div>CONFIG_FLATMEM_MANUAL=
=3Dy</div><div># CONFIG_DISCONTIGMEM_MANUAL is not set</div><div># CONFIG_S=
PARSEMEM_MANUAL is not set</div>
<div>CONFIG_FLATMEM=3Dy</div><div>CONFIG_FLAT_NODE_MEM_MAP=3Dy</div><div># =
CONFIG_SPARSEMEM_STATIC is not set</div><div># CONFIG_SPARSEMEM_VMEMMAP_ENA=
BLE is not set</div><div>CONFIG_SPLIT_PTLOCK_CPUS=3D4</div><div>CONFIG_RESO=
URCES_64BIT=3Dy</div>
<div>CONFIG_ZONE_DMA_FLAG=3D1</div><div>CONFIG_BOUNCE=3Dy</div><div>CONFIG_=
VIRT_TO_BUS=3Dy</div><div>CONFIG_PROC_DEVICETREE=3Dy</div><div>CONFIG_CMDLI=
NE_BOOL=3Dy</div><div>CONFIG_CMDLINE=3D&quot;&quot;</div><div>CONFIG_SECCOM=
P=3Dy</div>
<div>CONFIG_ISA_DMA_API=3Dy</div><div><br></div><div>#</div><div># Bus opti=
ons (PCI etc.)</div><div>#</div><div># CONFIG_PCI is not set</div><div># CO=
NFIG_PCI_GOBIOS is not set</div><div># CONFIG_PCI_GOMMCONFIG is not set</di=
v>
<div># CONFIG_PCI_GODIRECT is not set</div><div># CONFIG_PCI_GOOLPC is not =
set</div><div># CONFIG_PCI_GOANY is not set</div><div># CONFIG_ARCH_SUPPORT=
S_MSI is not set</div><div># CONFIG_ISA is not set</div><div># CONFIG_MCA i=
s not set</div>
<div># CONFIG_SCx200 is not set</div><div># CONFIG_OLPC is not set</div><di=
v># CONFIG_PCCARD is not set</div><div><br></div><div><br></div><div>#</div=
><div><br></div><div># Advanced setup</div><div>#</div><div># CONFIG_ADVANC=
ED_OPTIONS is not set</div>
<div><br></div><div>#</div><div># Default settings for advanced configurati=
on options are used</div><div>#</div><div>CONFIG_HIGHMEM_START=3D0xfe000000=
</div><div>CONFIG_LOWMEM_SIZE=3D0x30000000</div><div>CONFIG_KERNEL_START=3D=
0xc0000000</div>
<div>CONFIG_TASK_SIZE=3D0xc0000000</div><div>CONFIG_CONSISTENT_START=3D0xff=
100000</div><div>CONFIG_CONSISTENT_SIZE=3D0x00200000</div><div>CONFIG_BOOT_=
LOAD=3D0x01000000</div><div><br></div><div>#</div><div># Networking</div><d=
iv>#</div>
<div>CONFIG_NET=3Dy</div><div><br></div><div>#</div><div># Networking optio=
ns</div><div>#</div><div>CONFIG_PACKET=3Dy</div><div># CONFIG_PACKET_MMAP i=
s not set</div><div>CONFIG_UNIX=3Dy</div><div># CONFIG_NET_KEY is not set</=
div>
<div>CONFIG_INET=3Dy</div><div># CONFIG_IP_MULTICAST is not set</div><div>C=
ONFIG_IP_ADVANCED_ROUTER=3Dy</div><div>CONFIG_IP_FIB_HASH=3Dy</div><div>CON=
FIG_IP_PNP=3Dy</div><div>CONFIG_IP_PNP_DHCP=3Dy</div><div>CONFIG_IP_PNP_BOO=
TP=3Dy</div>
<div># CONFIG_IP_PNP_RARP is not set</div><div># CONFIG_NET_IPIP is not set=
</div><div># CONFIG_NET_IPGRE is not set</div><div># CONFIG_ARPD is not set=
</div><div>CONFIG_SYN_COOKIES=3Dy</div><div># CONFIG_INET_AH is not set</di=
v>
<div># CONFIG_INET_ESP is not set</div><div># CONFIG_INET_IPCOMP is not set=
</div><div># CONFIG_INET_XFRM_TUNNEL is not set</div><div># CONFIG_INET_TUN=
NEL is not set</div><div># CONFIG_INET_XFRM_MODE_TRANSPORT is not set</div>
<div># CONFIG_INET_XFRM_MODE_TUNNEL is not set</div><div># CONFIG_INET_XFRM=
_MODE_BEET is not set</div><div># CONFIG_INET_LRO is not set</div><div>CONF=
IG_INET_DIAG=3Dy</div><div>CONFIG_INET_TCP_DIAG=3Dy</div><div># CONFIG_TCP_=
CONG_ADVANCED is not set</div>
<div>CONFIG_TCP_CONG_CUBIC=3Dy</div><div>CONFIG_DEFAULT_TCP_CONG=3D&quot;cu=
bic&quot;</div><div># CONFIG_TCP_MD5SIG is not set</div><div># CONFIG_IPV6 =
is not set</div><div># CONFIG_INET6_XFRM_TUNNEL is not set</div><div># CONF=
IG_INET6_TUNNEL is not set</div>
<div># CONFIG_NETWORK_SECMARK is not set</div><div>CONFIG_NETFILTER=3Dy</di=
v><div># CONFIG_IP_DCCP is not set</div><div># CONFIG_IP_SCTP is not set</d=
iv><div># CONFIG_TIPC is not set</div><div># CONFIG_ATM is not set</div><di=
v>
# CONFIG_BRIDGE is not set</div><div># CONFIG_VLAN_8021Q is not set</div><d=
iv># CONFIG_DECNET is not set</div><div># CONFIG_LLC2 is not set</div><div>=
# CONFIG_IPX is not set</div><div># CONFIG_ATALK is not set</div><div># CON=
FIG_X25 is not set</div>
<div># CONFIG_LAPB is not set</div><div># CONFIG_ECONET is not set</div><di=
v># CONFIG_WAN_ROUTER is not set</div><div># CONFIG_NET_SCHED is not set</d=
iv><div><br></div><div>#</div><div># Network testing</div><div>#</div><div>
# CONFIG_NET_PKTGEN is not set</div><div># CONFIG_HAMRADIO is not set</div>=
<div># CONFIG_CAN is not set</div><div># CONFIG_IRDA is not set</div><div>#=
 CONFIG_BT is not set</div><div># CONFIG_AF_RXRPC is not set</div><div>
<br></div><div>#</div><div># Wireless</div><div>#</div><div># CONFIG_CFG802=
11 is not set</div><div># CONFIG_WIRELESS_EXT is not set</div><div># CONFIG=
_MAC80211 is not set</div><div># CONFIG_IEEE80211 is not set</div><div>
# CONFIG_RFKILL is not set</div><div># CONFIG_NET_9P is not set</div><div><=
br></div><div>#</div><div># Device Drivers</div><div>#</div><div>#Allow use=
rspace driver core code to be built</div><div>CONFIG_UIO=3Dy</div><div>#</d=
iv>
<div># Generic Driver Options</div><div>#</div><div>CONFIG_UEVENT_HELPER_PA=
TH=3D&quot;/sbin/hotplug&quot;</div><div>CONFIG_STANDALONE=3Dy</div><div>CO=
NFIG_PREVENT_FIRMWARE_BUILD=3Dy</div><div>CONFIG_FW_LOADER=3Dy</div><div># =
CONFIG_DEBUG_DRIVER is not set</div>
<div># CONFIG_DEBUG_DEVRES is not set</div><div># CONFIG_SYS_HYPERVISOR is =
not set</div><div>CONFIG_CONNECTOR=3Dy</div><div>CONFIG_PROC_EVENTS=3Dy</di=
v><div>CONFIG_MTD=3Dy</div><div>CONFIG_MTD_JEDECPROB=3Dy</div><div>CONFIG_M=
TD_CFI=3Dy</div>
<div>CONFIG_MTD_CHAR=3Dy</div><div>CONFIG_MTD_BLOCK=3Dy</div><div>CONFIG_MT=
D_PARTITIONS=3Dy</div><div>CONFIG_MTD_OF_PARTS=3Dy</div><div>CONFIG_MTD_CMD=
LINE_PARTS=3Dy</div><div>CONFIG_MTD_DEBUG=3Dy</div><div>CONFIG_MTD_DEBUG_VE=
RBOSE=3D3</div>
<div># CONFIG_MTD_CERBERUS is not set</div><div>CONFIG_MTD_PHYSMAP_OF=3Dy</=
div><div>CONFIG_MTD_CFI_AMDSTD=3Dy</div><div>CONFIG_MTD_CFI_AMDSTD_RETRY=3D=
0</div><div>CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy</div><div>CONFIG_MTD_MAP_BANK_W=
IDTH_2=3Dy</div>
<div>CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy</div><div>CONFIG_MTD_CFI_I1=3Dy</div><=
div>CONFIG_MTD_CFI_I2=3Dy</div><div>CONFIG_MTD_GEN_PROBE=3Dy</div><div>CONF=
IG_MTD_CFI_ADV_OPTIONS=3Dy</div><div>CONFIG_MTD_CFI_NOSWAP=3Dy</div><div>CO=
NFIG_MTD_COMPLEX_MAPPINGS=3Dy</div>
<div><br></div><div>CONFIG_OF_DEVICE=3Dy</div><div># CONFIG_PARPORT is not =
set</div><div>CONFIG_BLK_DEV=3Dy</div><div># CONFIG_BLK_DEV_FD is not set</=
div><div># CONFIG_BLK_CPQ_DA is not set</div><div># CONFIG_BLK_CPQ_CISS_DA =
is not set</div>
<div># CONFIG_BLK_DEV_DAC960 is not set</div><div># CONFIG_BLK_DEV_UMEM is =
not set</div><div># CONFIG_BLK_DEV_COW_COMMON is not set</div><div># CONFIG=
_BLK_DEV_LOOP is not set</div><div># CONFIG_BLK_DEV_NBD is not set</div>
<div># CONFIG_BLK_DEV_SX8 is not set</div><div>CONFIG_BLK_DEV_RAM=3Dy</div>=
<div>CONFIG_BLK_DEV_RAM_COUNT=3D16</div><div>CONFIG_BLK_DEV_RAM_SIZE=3D3500=
0</div><div># CONFIG_BLK_DEV_XIP is not set</div><div># CONFIG_CDROM_PKTCDV=
D is not set</div>
<div># CONFIG_ATA_OVER_ETH is not set</div><div># CONFIG_XILINX_SYSACE is n=
ot set</div><div>CONFIG_MISC_DEVICES=3Dy</div><div># CONFIG_PHANTOM is not =
set</div><div># CONFIG_EEPROM_93CX6 is not set</div><div># CONFIG_SGI_IOC4 =
is not set</div>
<div># CONFIG_TIFM_CORE is not set</div><div># CONFIG_ENCLOSURE_SERVICES is=
 not set</div><div># CONFIG_HAVE_IDE</div><div># CONFIG_IDE is not set</div=
><div><br></div><div>#</div><div># SCSI device support</div><div>#</div>
<div># CONFIG_RAID_ATTRS is not set</div><div># CONFIG_SCSI is not set</div=
><div># CONFIG_SCSI_DMA is not set</div><div># CONFIG_SCSI_NETLINK is not s=
et</div><div># CONFIG_ATA is not set</div><div># CONFIG_MD is not set</div>
<div># CONFIG_FUSION is not set</div><div><br></div><div>#</div><div># IEEE=
 1394 (FireWire) support</div><div>#</div><div># CONFIG_FIREWIRE is not set=
</div><div># CONFIG_IEEE1394 is not set</div><div># CONFIG_I2O is not set</=
div>
<div># CONFIG_MACINTOSH_DRIVERS is not set</div><div># CONFIG_MAC_EMUMOUSEB=
TN is not set</div><div># CONFIG_WINDFARM is not set</div><div>CONFIG_NETDE=
VICES=3Dy</div><div># CONFIG_NETDEVICES_MULTIQUEUE is not set</div><div># C=
ONFIG_DUMMY is not set</div>
<div># CONFIG_BONDING is not set</div><div># CONFIG_MACVLAN is not set</div=
><div># CONFIG_EQUALIZER is not set</div><div># CONFIG_TUN is not set</div>=
<div># CONFIG_VETH is not set</div><div># CONFIG_ARCNET is not set</div>
<div>CONFIG_PHYLIB=3Dy</div><div>CONFIG_MARVELL_PHY=3Dy</div><div>CONFIG_NE=
T_ETHERNET=3Dy</div><div># CONFIG_MII is not set</div><div># CONFIG_HAPPYME=
AL is not set</div><div># CONFIG_SUNGEM is not set</div><div># CONFIG_CASSI=
NI is not set</div>
<div># CONFIG_NET_VENDOR_3COM is not set</div><div># CONFIG_NET_TULIP is no=
t set</div><div># CONFIG_HP100 is not set</div><div>CONFIG_IBM_NEW_EMAC=3Dy=
</div><div>CONFIG_IBM_NEW_EMAC_RXB=3D128</div><div>CONFIG_IBM_NEW_EMAC_TXB=
=3D64</div>
<div>CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=3D32</div><div>CONFIG_IBM_NEW_EMAC_RX_=
COPY_THRESHOLD=3D256</div><div>CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=3D0</div=
><div># CONFIG_IBM_NEW_EMAC_DEBUG is not set</div><div>CONFIG_IBM_NEW_EMAC_=
ZMII=3Dy</div>
<div>CONFIG_IBM_NEW_EMAC_RGMII=3Dy</div><div>CONFIG_IBM_NEW_EMAC_TAH=3Dy</d=
iv><div>CONFIG_IBM_NEW_EMAC_EMAC4=3Dy</div><div># CONFIG_NET_PCI is not set=
</div><div># CONFIG_B44 is not set</div><div>CONFIG_NETDEV_1000=3Dy</div><d=
iv># CONFIG_ACENIC is not set</div>
<div># CONFIG_DL2K is not set</div><div># CONFIG_E1000 is not set</div><div=
># CONFIG_E1000E is not set</div><div># CONFIG_E1000E_ENABLED is not set</d=
iv><div># CONFIG_IP1000 is not set</div><div># CONFIG_IGB is not set</div>
<div># CONFIG_NS83820 is not set</div><div># CONFIG_HAMACHI is not set</div=
><div># CONFIG_YELLOWFIN is not set</div><div># CONFIG_R8169 is not set</di=
v><div># CONFIG_SIS190 is not set</div><div># CONFIG_SKGE is not set</div>
<div># CONFIG_SKY2 is not set</div><div># CONFIG_SK98LIN is not set</div><d=
iv># CONFIG_VIA_VELOCITY is not set</div><div># CONFIG_TIGON3 is not set</d=
iv><div># CONFIG_BNX2 is not set</div><div># CONFIG_QLA3XXX is not set</div=
>
<div># CONFIG_ATL1 is not set</div><div>CONFIG_NETDEV_10000=3Dy</div><div>#=
 CONFIG_CHELSIO_T1 is not set</div><div># CONFIG_CHELSIO_T3 is not set</div=
><div># CONFIG_IXGBE is not set</div><div># CONFIG_IXGB is not set</div><di=
v>
# CONFIG_S2IO is not set</div><div># CONFIG_MYRI10GE is not set</div><div>#=
 CONFIG_NETXEN_NIC is not set</div><div># CONFIG_NIU is not set</div><div>#=
 CONFIG_MLX4_CORE is not set</div><div># CONFIG_TEHUTI is not set</div>
<div># CONFIG_BNX2X is not set</div><div># CONFIG_TR is not set</div><div><=
br></div><div>#</div><div># Wireless LAN</div><div>#</div><div># CONFIG_WLA=
N_PRE80211 is not set</div><div># CONFIG_WLAN_80211 is not set</div><div>
# CONFIG_WAN is not set</div><div># CONFIG_FDDI is not set</div><div># CONF=
IG_HIPPI is not set</div><div># CONFIG_PPP is not set</div><div># CONFIG_SL=
IP is not set</div><div># CONFIG_NETCONSOLE is not set</div><div># CONFIG_N=
ETPOLL is not set</div>
<div># CONFIG_NET_POLL_CONTROLLER is not set</div><div># CONFIG_ISDN is not=
 set</div><div># CONFIG_PHONE is not set</div><div><br></div><div>#</div><d=
iv># Input device support</div><div>#</div><div># CONFIG_INPUT is not set</=
div>
<div><br></div><div>#</div><div># Hardware I/O ports</div><div>#</div><div>=
# CONFIG_SERIO is not set</div><div># CONFIG_GAMEPORT is not set</div><div>=
<br></div><div>#</div><div># Character devices</div><div>#</div><div># CONF=
IG_VT is not set</div>
<div># CONFIG_SERIAL_NONSTANDARD is not set</div><div># CONFIG_NOZOMI is no=
t set</div><div><br></div><div>#</div><div># Serial drivers</div><div>#</di=
v><div>CONFIG_SERIAL_8250=3Dy</div><div>CONFIG_SERIAL_8250_CONSOLE=3Dy</div=
>
<div># CONFIG_SERIAL_8250_PCI is not set</div><div>CONFIG_SERIAL_8250_NR_UA=
RTS=3D4</div><div>CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4</div><div>CONFIG_SER=
IAL_8250_EXTENDED=3Dy</div><div># CONFIG_SERIAL_8250_MANY_PORTS is not set<=
/div>
<div>CONFIG_SERIAL_8250_SHARE_IRQ=3Dy</div><div># CONFIG_SERIAL_8250_DETECT=
_IRQ is not set</div><div># CONFIG_SERIAL_8250_RSA is not set</div><div>CON=
FIG_SERIAL_TEXT_DEBUG=3Dy</div><div><br></div><div>#</div><div># Non-8250 s=
erial port support</div>
<div>#</div><div># CONFIG_SERIAL_UARTLITE is not set</div><div>CONFIG_SERIA=
L_CORE=3Dy</div><div>CONFIG_SERIAL_CORE_CONSOLE=3Dy</div><div># CONFIG_SERI=
AL_JSM is not set</div><div>CONFIG_SERIAL_OF_PLATFORM=3Dy</div><div>CONFIG_=
UNIX98_PTYS=3Dy</div>
<div>CONFIG_LEGACY_PTYS=3Dy</div><div>CONFIG_LEGACY_PTY_COUNT=3D256</div><d=
iv># CONFIG_IPMI_HANDLER is not set</div><div># CONFIG_HW_RANDOM is not set=
</div><div># CONFIG_NVRAM is not set</div><div># CONFIG_GEN_RTC is not set<=
/div>
<div># CONFIG_R3964 is not set</div><div># CONFIG_APPLICOM is not set</div>=
<div># CONFIG_RAW_DRIVER is not set</div><div># CONFIG_TCG_TPM is not set</=
div><div>CONFIG_DEVPORT=3Dy</div><div>CONFIG_I2C=3Dy</div><div>CONFIG_I2C_C=
HARDEV=3Dy</div>
<div>CONFIG_I2C_HELPER_AUTO=3Dy</div><div>CONFIG_I2C_IBM_IIC=3Dy</div><div>=
CONFIG_I2C_DEBUG_CORE=3Dy</div><div>CONFIG_I2C_DEBUG_CHIP=3Dy</div><div>CON=
FIG_I2C_DEBUG_BUS=3Dy</div><div>#</div><div># SPI support</div><div>#</div>=
<div># CONFIG_SPI is not set</div>
<div># CONFIG_SPI_MASTER is not set</div><div># CONFIG_W1 is not set</div><=
div># CONFIG_POWER_SUPPLY is not set</div><div># CONFIG_HWMON is not set</d=
iv><div># CONFIG_THERMAL is not set</div><div># CONFIG_WATCHDOG is not set<=
/div>
<div><br></div><div>#</div><div># Sonics Silicon Backplane</div><div>#</div=
><div>CONFIG_SSB_POSSIBLE=3Dy</div><div># CONFIG_SSB is not set</div><div><=
br></div><div>#</div><div># Multifunction device drivers</div><div>#</div>
<div># CONFIG_MFD_SM501 is not set</div><div><br></div><div>#</div><div># M=
ultimedia devices</div><div>#</div><div># CONFIG_VIDEO_DEV is not set</div>=
<div># CONFIG_DVB_CORE is not set</div><div># CONFIG_DAB is noet set</div>
<div><br></div><div>#</div><div># Graphics support</div><div>#</div><div># =
CONFIG_AGP is not set</div><div># CONFIG_DRM is not set</div><div># CONFIG_=
VGASTATE is not set</div><div># CONFIG_VIDEO_OUTPUT_CONTROL is not set</div=
>
<div># CONFIG_FB is not set</div><div># CONFIG_BACKLIGHT_LCD_SUPPORT is not=
 set</div><div><br></div><div>#</div><div># Display device support</div><di=
v>#</div><div># CONFIG_DISPLAY_SUPPORT is not set</div><div><br></div><div>
#</div><div># Sound</div><div>#</div><div># CONFIG_SOUND is not set</div><d=
iv># CONFIG_USB_SUPPORT is not set</div><div># CONFIG_USB_ARCH_HAS_HCD is n=
ot set</div><div># CONFIG_USB_ARCH_HAS_OHCI is not set</div><div># CONFIG_U=
SB_ARCH_HAS_EHCI is not set</div>
<div># CONFIG_USB is not set</div><div><br></div><div>#</div><div># NOTE: U=
SB_STORAGE enables SCSI, and &#39;SCSI disk support&#39;</div><div>#</div><=
div># CONFIG_USB_GADGET is not set</div><div># CONFIG_MMC is not set</div>
<div># CONFIG_MEMSTICK is not set</div><div>CONFIG_NEW_LEDS=3Dy</div><div>#=
 CONFIG_INFINIBAND is not set</div><div># CONFIG_EDAC is not set</div><div>=
CONFIG_RTC_CLASS=3Dy</div><div>CONFIG_RTC_INTF_SYSFS=3Dy</div><div>CONFIG_R=
TC_DRV_DS1307=3Dy</div>
<div>CONFIG_RTC_DEBUG=3Dy</div><div>CONFIG_RTC_DRV_TEST=3Dy</div><div>CONFI=
G_RTC_DRV_PPC=3Dy</div><div>#</div><div># Userspace I/O</div><div>#</div><d=
iv># CONFIG_UIO is not set</div><div><br></div><div>#</div><div># File syst=
ems</div>
<div>#</div><div>CONFIG_EXT2_FS=3Dy</div><div># CONFIG_EXT2_FS_XATTR is not=
 set</div><div># CONFIG_EXT2_FS_XIP is not set</div><div># CONFIG_EXT3_FS i=
s not set</div><div># CONFIG_EXT4DEV_FS is not set</div><div># CONFIG_REISE=
RFS_FS is not set</div>
<div>CONFIG_JFS_FS=3Dy</div><div># CONFIG_FS_POSIX_ACL is not set</div><div=
># CONFIG_XFS_FS is not set</div><div># CONFIG_GFS2_FS is not set</div><div=
># CONFIG_OCFS2_FS is not set</div><div>CONFIG_DNOTIFY=3Dy</div><div>CONFIG=
_INOTIFY=3Dy</div>
<div>CONFIG_INOTIFY_USER=3Dy</div><div># CONFIG_QUOTA is not set</div><div>=
# CONFIG_AUTOFS_FS is not set</div><div># CONFIG_AUTOFS4_FS is not set</div=
><div># CONFIG_FUSE_FS is not set</div><div><br></div><div>#</div><div># CD=
-ROM/DVD Filesystems</div>
<div>#</div><div># CONFIG_ISO9660_FS is not set</div><div># CONFIG_UDF_FS i=
s not set</div><div><br></div><div>#</div><div># DOS/FAT/NT Filesystems</di=
v><div>#</div><div># CONFIG_MSDOS_FS is not set</div><div># CONFIG_VFAT_FS =
is not set</div>
<div># CONFIG_NTFS_FS is not set</div><div><br></div><div>#</div><div># Pse=
udo filesystems</div><div>#</div><div>CONFIG_PROC_FS=3Dy</div><div>CONFIG_P=
ROC_KCORE=3Dy</div><div>CONFIG_PROC_SYSCTL=3Dy</div><div>CONFIG_SYSFS=3Dy</=
div>
<div>CONFIG_TMPFS=3Dy</div><div># CONFIG_TMPFS_POSIX_ACL is not set</div><d=
iv># CONFIG_HUGETLB_PAGE is not set</div><div># CONFIG_CONFIGFS_FS is not s=
et</div><div><br></div><div>#</div><div># Miscellaneous filesystems</div>
<div>#</div><div># CONFIG_ADFS_FS is not set</div><div># CONFIG_AFFS_FS is =
not set</div><div># CONFIG_HFS_FS is not set</div><div># CONFIG_HFSPLUS_FS =
is not set</div><div># CONFIG_BEFS_FS is not set</div><div># CONFIG_BFS_FS =
is not set</div>
<div># CONFIG_EFS_FS is not set</div><div>CONFIG_CRAMFS=3Dy</div><div># CON=
FIG_VXFS_FS is not set</div><div># CONFIG_MINIX_FS is not set</div><div># C=
ONFIG_HPFS_FS is not set</div><div># CONFIG_QNX4FS_FS is not set</div><div>
# CONFIG_ROMFS_FS is not set</div><div># CONFIG_SYSV_FS is not set</div><di=
v># CONFIG_UFS_FS is not set</div><div>CONFIG_NETWORK_FILESYSTEMS=3Dy</div>=
<div>CONFIG_NFS_FS=3Dy</div><div>CONFIG_NFS_V3=3Dy</div><div>CONFIG_NFS_V3_=
ACL=3Dy</div>
<div># CONFIG_NFS_V4 is not set</div><div># CONFIG_NFS_DIRECTIO is not set<=
/div><div># CONFIG_NFSD is not set</div><div>CONFIG_ROOT_NFS=3Dy</div><div>=
CONFIG_LOCKD=3Dy</div><div>CONFIG_LOCKD_V4=3Dy</div><div>CONFIG_NFS_COMMON=
=3Dy</div>
<div>CONFIG_SUNRPC=3Dy</div><div># CONFIG_SUNRPC_BIND34 is not set</div><di=
v># CONFIG_RPCSEC_GSS_KRB5 is not set</div><div># CONFIG_RPCSEC_GSS_SPKM3 i=
s not set</div><div># CONFIG_SMB_FS is not set</div><div>CONFIG_CIFS=3Dy</d=
iv>
<div># CONFIG_NCP_FS is not set</div><div># CONFIG_CODA_FS is not set</div>=
<div># CONFIG_AFS_FS is not set</div><div><br></div><div>#</div><div># Part=
ition Types</div><div>#</div><div># CONFIG_PARTITION_ADVANCED is not set</d=
iv>
<div>CONFIG_MSDOS_PARTITION=3Dy</div><div># CONFIG_NLS is not set</div><div=
># CONFIG_DLM is not set</div><div><br></div><div>#</div><div># Library rou=
tines</div><div>#</div><div>CONFIG_BITREVERSE=3Dy</div><div># CONFIG_CRC_CC=
ITT is not set</div>
<div># CONFIG_CRC16 is not set</div><div># CONFIG_CRC_ITU_T is not set</div=
><div>CONFIG_CRC32=3Dy</div><div># CONFIG_CRC7 is not set</div><div># CONFI=
G_LIBCRC32C is not set</div><div>CONFIG_ZLIB_INFLATE=3Dy</div><div>CONFIG_P=
LIST=3Dy</div>
<div>CONFIG_HAS_IOMEM=3Dy</div><div>CONFIG_HAS_IOPORT=3Dy</div><div>CONFIG_=
HAS_DMA=3Dy</div><div>CONFIG_DMADEVICES=3Dy</div><div><br></div><div>#</div=
><div># Kernel hacking</div><div>#</div><div>CONFIG_PRINTK_TIME is not set<=
/div>
<div>CONFIG_ENABLE_WARN_DEPRECATED=3Dy</div><div>CONFIG_ENABLE_MUST_CHECK=
=3Dy</div><div>CONFIG_MAGIC_SYSRQ=3Dy</div><div># CONFIG_UNUSED_SYMBOLS is =
not set</div><div>CONFIG_DEBUG_FS=3Dy</div><div># CONFIG_HEADERS_CHECK is n=
ot set</div>
<div>CONFIG_DEBUG_KERNEL=3Dy</div><div># CONFIG_DEBUG_SHIRQ is not set</div=
><div>CONFIG_DETECT_SOFTLOCKUP=3Dy</div><div>CONFIG_SCHED_DEBUG=3Dy</div><d=
iv># CONFIG_SCHEDSTATS is not set</div><div># CONFIG_TIMER_STATS is not set=
</div>
<div># CONFIG_SLUB_DEBUG_ON is not set</div><div># CONFIG_SLUB_STATS is not=
 set</div><div># CONFIG_DEBUG_RT_MUTEXES is not set</div><div># CONFIG_RT_M=
UTEX_TESTER is not set</div><div># CONFIG_DEBUG_SPINLOCK is not set</div>
<div># CONFIG_DEBUG_MUTEXES is not set</div><div># CONFIG_DEBUG_SPINLOCK_SL=
EEP is not set</div><div># CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set</d=
iv><div># CONFIG_DEBUG_KOBJECT is not set</div><div># CONFIG_DEBUG_BUGVERBO=
SE is not set</div>
<div>CONFIG_DEBUG_INFO=3Dy</div><div># CONFIG_DEBUG_VM is not set</div><div=
># CONFIG_DEBUG_LIST is not set</div><div># CONFIG_DEBUG_SG is not set</div=
><div># CONFIG_BOOT_PRINTK_DELAY is not set</div><div># CONFIG_RCU_TORTURE_=
TEST is not set</div>
<div># CONFIG_BACKTRACE_SELF_TEST is not set</div><div># CONFIG_FAULT_INJEC=
TION is not set</div><div># CONFIG_SAMPLES is not set</div><div># CONFIG_DE=
BUG_STACKOVERFLOW is not set</div><div># CONFIG_DEBUG_STACK_USAGE is not se=
t</div>
<div># CONFIG_DEBUG_PAGEALLOC is not set</div><div>CONFIG_DEBUGGER=3Dy</div=
><div>CONFIG_KGDB=3Dy</div><div>CONFIG_KGDB_TTYS0=3Dy</div><div># CONFIG_KG=
DB is not set</div><div># CONFIG_XMON is not set</div><div>CONFIG_VIRQ_DEBU=
G is not set</div>
<div># CONFIG_BDI_SWITCH is not set</div><div>#CONFIG_PPC_EARLY_DEBUG=3Dy</=
div><div>CONFIG_EARLY_PRINTK=3Dy</div><div>#CONFIG_PPC_EARLY_DEBUG_44x=3Dy<=
/div><div>#CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=3D0x40000200</div><div><br></=
div>
<div>#</div><div># Security options</div><div>#</div><div># CONFIG_KEYS is =
not set</div><div># CONFIG_SECURITY is not set</div><div># CONFIG_SECURITY_=
FILE_CAPABILITIES is not set</div><div>CONFIG_CRYPTO=3Dy</div><div>CONFIG_C=
RYPTO_ALGAPI=3Dy</div>
<div>CONFIG_CRYPTO_BLKCIPHER=3Dy</div><div># CONFIG_CRYPTO_SEQIV is not set=
</div><div>CONFIG_CRYPTO_MANAGER=3Dy</div><div># CONFIG_CRYPTO_HMAC is not =
set</div><div># CONFIG_CRYPTO_XCBC is not set</div><div># CONFIG_CRYPTO_NUL=
L is not set</div>
<div># CONFIG_CRYPTO_MD4 is not set</div><div>CONFIG_CRYPTO_MD5=3Dy</div><d=
iv># CONFIG_CRYPTO_SHA1 is not set</div><div># CONFIG_CRYPTO_SHA256 is not =
set</div><div># CONFIG_CRYPTO_SHA512 is not set</div><div># CONFIG_CRYPTO_W=
P512 is not set</div>
<div># CONFIG_CRYPTO_TGR192 is not set</div><div># CONFIG_CRYPTO_GF128MUL i=
s not set</div><div>CONFIG_CRYPTO_ECB=3Dy</div><div>CONFIG_CRYPTO_CBC=3Dy</=
div><div>CONFIG_CRYPTO_PCBC=3Dy</div><div># CONFIG_CRYPTO_LRW is not set</d=
iv>
<div># CONFIG_CRYPTO_XTS is not set</div><div># CONFIG_CRYPTO_CTR is not se=
t</div><div># CONFIG_CRYPTO_GCM is not set</div><div># CONFIG_CRYPTO_CCM is=
 not set</div><div># CONFIG_CRYPTO_CRYPTD is not set</div><div>CONFIG_CRYPT=
O_DES=3Dy</div>
<div># CONFIG_CRYPTO_FCRYPT is not set</div><div># CONFIG_CRYPTO_BLOWFISH i=
s not set</div><div># CONFIG_CRYPTO_TWOFISH is not set</div><div># CONFIG_C=
RYPTO_SERPENT is not set</div><div># CONFIG_CRYPTO_AES is not set</div>
<div># CONFIG_CRYPTO_CAST5 is not set</div><div># CONFIG_CRYPTO_CAST6 is no=
t set</div><div># CONFIG_CRYPTO_TEA is not set</div><div># CONFIG_CRYPTO_AR=
C4 is not set</div><div># CONFIG_CRYPTO_KHAZAD is not set</div><div># CONFI=
G_CRYPTO_ANUBIS is not set</div>
<div># CONFIG_CRYPTO_SEED is not set</div><div># CONFIG_CRYPTO_SALSA20 is n=
ot set</div><div># CONFIG_CRYPTO_DEFLATE is not set</div><div># CONFIG_CRYP=
TO_MICHAEL_MIC is not set</div><div># CONFIG_CRYPTO_CRC32C is not set</div>
<div># CONFIG_CRYPTO_CAMELLIA is not set</div><div># CONFIG_CRYPTO_TEST is =
not set</div><div># CONFIG_CRYPTO_AUTHENC is not set</div><div># CONFIG_CRY=
PTO_LZO is not set</div><div>CONFIG_CRYPTO_HW=3Dy</div><div># CONFIG_CRYPTO=
_DEV_HIFN_795X is not set</div>
<div># CONFIG_PPC_CLOCK is not set</div><div>CONFIG_SENSORS_EEPROM=3Dy</div=
><div><br></div></div></div></div></div>

--00c09ffb593d8576010473dbea4d--
