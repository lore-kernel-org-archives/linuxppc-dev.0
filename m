Message-ID: <3BE83FC2.6090300@oerlikon.ca>
Date: Tue, 06 Nov 2001 14:53:38 -0500
From: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: AKC@pel.dk
Subject: JFFS on RPX-CLLF board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are using an Embedded Planet RPX-CLLF board and want to install
JFFS, here is a source file that I have modify to define a JFFS/MTD
partition.

Place this file in:  /opt/.. <linux>../drivers/mtd

This was tested with linux kernel 2.4.4 (PPC).

Hope this can help other saving some time...
If you find any bugs, let me know. I'm not a specialist linux programmer!


/*
 * $Id: rpxlite.c,v 1.15 2001/10/02 15:05:14 dwmw2 Exp $
 *
 * Handle mapping of the flash on the RPX Lite and CLLF boards
 * Modified by S.Perusse / S.Ruel 06/11/2001
 *
 */

#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <asm/io.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>

#define NB_OF(x)  (sizeof(x)/sizeof(x[0]))

// For 32 MB FLASH
//#define WINDOW_ADDR 0xfe000000
//#define WINDOW_SIZE 0x800000

// For 16 MB FLASH (RPX-CLLF board)
#define WINDOW_ADDR 0xff000000
#define WINDOW_SIZE 0x400000

// Define one partition: part 0 = 14MB for JFFS filesystem.
// This partition is offset from 2MB to leave plenty of space for
bootloader & linux kernel image in flash.
static struct mtd_partition partition_info[]={
   /* { name: "RPX flash boot partition",
      offset: 0,
      size: 0x200000 },*/
    { name: "RPX flash partition 1 (root fs)",
      offset: 0x200000,
      size: 0xE00000 },

};

static struct mtd_partition *parsed_parts;
static struct mtd_info *mymtd;

__u8 rpxlite_read8(struct map_info *map, unsigned long ofs)
{
    return __raw_readb(map->map_priv_1 + ofs);
}

__u16 rpxlite_read16(struct map_info *map, unsigned long ofs)
{
    return __raw_readw(map->map_priv_1 + ofs);
}

__u32 rpxlite_read32(struct map_info *map, unsigned long ofs)
{
    return __raw_readl(map->map_priv_1 + ofs);
}

void rpxlite_copy_from(struct map_info *map, void *to, unsigned long
from, ssize_t len)
{
    memcpy_fromio(to, (void *)(map->map_priv_1 + from), len);
}

void rpxlite_write8(struct map_info *map, __u8 d, unsigned long adr)
{
    __raw_writeb(d, map->map_priv_1 + adr);
    mb();
}

void rpxlite_write16(struct map_info *map, __u16 d, unsigned long adr)
{
    __raw_writew(d, map->map_priv_1 + adr);
    mb();
}

void rpxlite_write32(struct map_info *map, __u32 d, unsigned long adr)
{
    __raw_writel(d, map->map_priv_1 + adr);
    mb();
}

void rpxlite_copy_to(struct map_info *map, unsigned long to, const void
*from, ssize_t len)
{
    memcpy_toio((void *)(map->map_priv_1 + to), from, len);
}

static struct map_info rpxlite_map = {
    name: "RPX",
    size: WINDOW_SIZE,
    buswidth: 4,
    read8: rpxlite_read8,
    read16: rpxlite_read16,
    read32: rpxlite_read32,
    copy_from: rpxlite_copy_from,
    write8: rpxlite_write8,
    write16: rpxlite_write16,
    write32: rpxlite_write32,
    copy_to: rpxlite_copy_to
};



int __init init_rpxlite(void)
{

    struct mtd_partition *parts;
    int nb_parts = 0;
    int parsed_nr_parts = 0;
    char *part_type;

    part_type = "static";
    parts = partition_info;
    nb_parts = NB_OF(partition_info);

    printk(KERN_NOTICE "RPX Lite or CLLF flash device: %x at %x\n",
WINDOW_SIZE*4, WINDOW_ADDR);
    rpxlite_map.map_priv_1 = (unsigned long)ioremap(WINDOW_ADDR,
WINDOW_SIZE * 4);

    if (!rpxlite_map.map_priv_1) {
        printk("Failed to ioremap\n");
        return -EIO;
    }
    mymtd = do_map_probe("cfi_probe", &rpxlite_map);
    if (!mymtd)
        return -ENXIO;


    mymtd->module = THIS_MODULE;


    if (parsed_nr_parts > 0) {
        parts = parsed_parts;
        nb_parts = parsed_nr_parts;
    }

    if (nb_parts == 0) {
        printk(KERN_NOTICE "RPX flash: no partition info available,
registering whole flash at once\n");
        add_mtd_device(mymtd);
    } else {
        printk(KERN_NOTICE "Using %s partition definition\n", part_type);
        add_mtd_partitions(mymtd, parts, nb_parts);
    }
    return 0;


    iounmap((void *)rpxlite_map.map_priv_1);
    return -ENXIO;
}


static void __exit cleanup_rpxlite(void)
{
    if (mymtd) {
        del_mtd_device(mymtd);
        map_destroy(mymtd);
    }
    if (rpxlite_map.map_priv_1) {
        iounmap((void *)rpxlite_map.map_priv_1);
        rpxlite_map.map_priv_1 = 0;
    }
}

module_init(init_rpxlite);
module_exit(cleanup_rpxlite);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Arnold Christensen <AKC@pel.dk>");
MODULE_DESCRIPTION("MTD map driver for RPX Lite and CLLF boards");


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
