Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 9BD4867A64
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 18:40:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 1 Apr 2005 10:40:53 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B19@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: "Josh Boyer" <jwboyer@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : How to read/write in flash memories (MTD)?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh,

Your reply confirmed my feeling. So I've decided to use the MTD but with =
my own driver as I found in a tutorial. So I made the file (module) =
/drivers/mtd/maps/myBoardFlash.c in order to support my 2 flash =
memories. You can see the code below, but once again (sorry...) I have =
some questions and doubts on it.=20
1- Is that driver correct for my case?=20
2- Are those R/W routines are usable?
3- In our application we want to download source code and achievable =
code using Ethernet (so R/W operations). Do I need a filesystem for that =
as JFFS 2 ?=20
4- Giving this driver, what is the process to use my R/W routines (if =
they are correct...) from the user space?


#include <linux/module.h>
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/mtd/mtd.h>
#include <linux/mtd/map.h>
#include <linux/mtd/partitions.h>
#include <linux/config.h>
#include <linux/version.h>
#include <asm/io.h>

static struct mtd_info *boot_flash;
static struct mtd_info *oper_flash;

/*************************************************/
/*                Mapping infos                  */
/*************************************************/

/* Map infos for the boot flash */
static struct map_info myboard_flash_boot_map =3D {
        .name      =3D   "MYBOARD boot flash",
        .size      =3D   BOARD_BOOT_FLASH_SIZE,
        .buswidth  =3D   1,
        .read8     =3D   myboard_flash_read8,
        .read16    =3D   myboard_flash_read16,
        .read32    =3D   myboard_flash_read32,
        .copy_from =3D   myboard_flash_copy_from,
        .write8    =3D   myboard_flash_write8,
        .write16   =3D   myboard_flash_write16,
        .write32   =3D   myboard_flash_write32,
        .copy_to   =3D   myboard_flash_copy_to
};


/* Map infos for the operationnal flash */
static struct map_info myboard_flash_oper_map =3D {
        .name      =3D   "MYBOARD oper flash",
        .size      =3D   BOARD_OPER_FLASH_SIZE,
        .buswidth  =3D   2,
        .read8     =3D   myboard_flash_read8,
        .read16    =3D   myboard_flash_read16,
        .read32    =3D   myboard_flash_read32,
        .copy_from =3D   myboard_flash_copy_from,
        .write8    =3D   myboard_flash_write8,
        .write16   =3D   myboard_flash_write16,
        .write32   =3D   myboard_flash_write32,
        .copy_to   =3D   myboard_flash_copy_to       =20
};


            =20
/*************************************************/
/*           Partitionning infos                 */
/*************************************************/

/* Boot flash partionning infos */
static struct mtd_partition myboard_flash_boot_partitions[] =3D {
        {
                .name =3D   "Boot flash partition",
                .offset =3D 0x0,
                .size =3D   BOARD_BOOT_FLASH_SIZE,
        }
};


/* Oper flash partionning infos */
static struct mtd_partition myboard_flash_oper_partitions[] =3D {
        {
                .name =3D   "Oper flash partition", =20
                .offset =3D 0x0,
                .size =3D   BOARD_OPER_FLASH_SIZE,       =20
        }
};



/**************************************************/
/*          Read/Write routines                   */
/**************************************************/

__u8 myboard_flash_read8(struct map_info *map, unsigned long ofs)
{
  return __raw_readb(map->map_priv_1 + ofs);
}

__u16 myboard_flash_read16(struct map_info *map, unsigned long ofs)
{
  return __raw_readw(map->map_priv_1 + ofs);
}

__u32 myboard_flash_read32(struct map_info *map, unsigned long ofs)
{
  return __raw_readl(map->map_priv_1 + ofs);
}

void myboard_flash_copy_from(struct map_info *map, void *to, unsigned =
long from, ssize_t len)
{
  memcpy_fromio(to, map->map_priv_1 + from, len);
}

void myboard_flash_write8(struct map_info *map, __u8 d, unsigned long =
adr)
{
  __raw_writeb(d, map->map_priv_1 + adr);
  mb();
}

void myboard_flash_write16(struct map_info *map, __u16 d, unsigned long =
adr)
{
  __raw_writew(d, map->map_priv_1 + adr);
  mb();
}

void myboard_flash_write32(struct map_info *map, __u32 d, unsigned long =
adr)
{
  __raw_writel(d, map->map_priv_1 + adr);
  mb();
}



/**********************************************/
/*              Module Init                   */
/**********************************************/

int __init init_myboard_flash(void)                  map_info
{
    /*
     * Boot flash init
     */
=20
    printk(KERN_NOTICE "myboard boot flash: %x at %x\n", =
BOARD_BOOT_FLASH_SIZE, MYBOARD_FLASH_BOOT_BASE);
    /* Obtain a virtual address for the physic one given ibn order to =
perform R/W operations */
    myboard_flash_boot_map.map_priv_1 =3D (unsigned =
long)ioremap(MYBOARD_FLASH_BOOT_BASE, BOARD_BOOT_FLASH_SIZE);
    if (!myboard_flash_boot_map.map_priv_1)
    {
        printk("Failed to ioremap for boot flash!!\n");
        return -EIO;
    }
   =20
    boot_flash =3D do_map_probe("cfi_probe", &myboard_flash_boot_map);
    if (boot_flash)
    {
        boot_flash->module =3D THIS_MODULE;
        boot_flash->erasesize =3D 0x10000;
    }
    else
    {
        printk("map probe failed for boot flash!!\n");
        return -ENXIO;
    }

   =20
    /*
     * Oper flash init
     */

    printk(KERN_NOTICE "myboard oper flash: %x at %x\n", =
BOARD_OPER_FLASH_SIZE, MYBOARD_FLASH_OPER_BASE);
    /* Obtain a virtual address for the physic one given ibn order to =
perform R/W operations */
    myboard_flash_boot_map.map_priv_1 =3D (unsigned =
long)ioremap(MYBOARD_FLASH_OPER_BASE, BOARD_OPER_FLASH_SIZE);
    if (!myboard_flash_oper_map.map_priv_1)
    {
        printk("Failed to ioremap for oper flash!!\n");
        return -EIO;
    }

    oper_flash =3D do_map_probe("cfi_probe", &myboard_flash_oper_map);
    if (oper_flash)
    {
        oper_flash->module =3D THIS_MODULE;
        oper_flash->erasesize =3D 0x10000;
    }
    else
    {
        printk("map probe failed for oper flash!!\n"); =20
        return -ENXIO;
    }


    /*
     * Create partitions
     */
    =20
    if(boot_flash && oper_flash)
    {
        =
add_mtd_partitions(boot_flash,myboard_flash_boot_partitions,sizeof(myboar=
d_flash_boot_partitions)/sizeof(struct mtd_partition));
        =
add_mtd_partitions(oper_flash,myboard_flash_oper_partitions,sizeof(myboar=
d_flash_oper_partitions)/sizeof(struct mtd_partition));
        return 0;=20
    }
    else
    {
        /* Free the obtained virtual addresses */
        iounmap((void *)myboard_flash_boot_map.map_priv_1);
        iounmap((void *)myboard_flash_oper_map.map_priv_1);
        return -ENXIO;
    }
}



/**********************************************/
/*              Module Cleanup                */
/**********************************************/

static void __exit cleanup_myboard_flash(void)
{
    /*
     * Delete partitions
     */
    =20
    if (boot_flash)
    {
        del_mtd_partitions(boot_flash);
        map_destroy(boot_flash);
    }
    if (oper_flash)
    {
        del_mtd_partitions(oper_flash);
        map_destroy(oper_flash);
    }

   =20
    /*
     * Free Free the obtained virtual addresses=20
     */
    =20
    if (myboard_flash_boot_map.map_priv_1)
    {
        iounmap((void *)myboard_flash_boot_map.map_priv_1);
        myboard_flash_boot_map.map_priv_1 =3D 0;
    }
    if (myboard_flash_oper_map.map_priv_1)
    {
        iounmap((void *)myboard_flash_oper_map.map_priv_1);
        myboard_flash_oper_map.map_priv_1 =3D 0;
    }
}

 =20

module_init(init_myboard_flash);
module_exit(cleanup_myboard_flash);




-------- Message d'origine--------
De: Josh Boyer [mailto:jwboyer@jdub.homelinux.org]
Date: ven. 01/04/2005 01:34
=C0: Garcia J=E9r=E9mie
Cc: linuxppc-dev@ozlabs.org
Objet : Re: How to read/write in flash memories (MTD)?
=20
On Thu, 2005-03-31 at 11:59 +0200, Garcia J=E9r=E9mie wrote:
> L&G,
> Although I'm a newbie in linux kernel development, I'm in charge of =
adapting a Montavista LSP to fit our hardware. In our platform, we use 2 =
AMD flash memories (AM29LV) in which one we would like to process =
read/write operations. So I'm looking for a way to do that. I saw that =
at compilation time, there is MTD item which seems to be created for =
that. But I guess activate that will not be enough to reach my =
objective.

You need to enable MTD with the appropriate chip drivers and either the
MTD character device or the MTD block device (or both).  These will
create /dev/mtdX and /dev/mtdblockX respectively.  If you are using
devfs or sysfs + udev, they should show up in /dev.  Otherwise, you'll
need to use mknod to create them.

> Indeed, we are developping an application (in the user-space) which =
will initiate operation on the 2 flash memories. So, how can I access =
them from my application?
> Please help me cause I'm getting lost in the linux sources....

I'm not sure what kind of operations you mean, but the block and char
devices allow read/write operation.  If you are looking for a filesystem
to run on these devices, take a look at JFFS2.  Cramfs or squashfs can
also be used, but they are read-only.

josh
