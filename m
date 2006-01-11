Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 19484681B4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 09:25:29 +1100 (EST)
Date: Wed, 11 Jan 2006 23:18:46 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: "John W. Linville" <linville@tuxdriver.com>
MIME-Version: 1.0
References: <20060111215218.GF27985@tuxdriver.com>
Message-ID: <17892.1137017926@www78.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> --- Ursprüngliche Nachricht ---
> Von: "John W. Linville" <linville@tuxdriver.com>
> An: Gerhard Pircher <gerhard_stamer@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: AGPGART driver for ArticiaS - ioremap() problem
> Datum: Wed, 11 Jan 2006 16:52:21 -0500
> 
> It probably wouldn't hurt to include the source (or a url pointing
> to it)... :-)

Probably not, so here is it: ;-)

####### START ########

/*
 * ArticiaS AGPGART routines.
 */

#include <linux/types.h>
#include <linux/module.h>
#include <linux/pagemap.h>
#include <linux/pci.h>
#include <asm/pci-bridge.h>
#include <linux/init.h>
#include <linux/agp_backend.h>
#include "agp.h"

static struct pci_device_id agp_articias_pci_table[];

#define ARTICIAS_DEBUG

//#define ARTICIAS_FROMUNINORTH

#define ARTICIAS_AGP_EN		0x49	/* bit 0 -> AGP enable */
#define ARTICIAS_GART_EN	0x58	/* bit 6 -> GART enable */
#define ARTICIAS_APSIZE		0x59	/* bits 2:0 set size */
#define ARTICIAS_APBASE		0x59	/* TLB address Base [31:12]*/
#define ARTICIAS_GATTBASE	0x10	/* GART base address register */
#define ARTICIAS_TLB_BASE	0x5A	/* bits 16:31 of TLB base address #define
ARTICIAS_GATT_MASK	0xF0000000
#define ARTICIAS_SIZE_MASK	0x07	/* Mask aperture size bits. */

static int articias_fetch_size(void)
{
	int i;
	u8 temp;
	struct aper_size_info_8 *values;

	values = A_SIZE_8(agp_bridge->driver->aperture_sizes);
	pci_read_config_byte(agp_bridge->dev, ARTICIAS_APSIZE, &temp);

#ifdef ARTICIAS_DEBUG	
	printk(KERN_INFO PFX "[ARTICIAS] articias_fetch_size()\n");
	printk(KERN_INFO PFX "[ARTICIAS] * non masked temp = 0x%x\n", temp);
#endif

	/* Mask the GART/Aperture size selection bits. */
	temp = temp & ARTICIAS_SIZE_MASK;

	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {

#ifdef ARTICIAS_DEBUG
	void *temp2;

	printk(KERN_INFO PFX "[ARTICIAS] * aperature size loop index #%d\n", i);
	printk(KERN_INFO PFX "[ARTICIAS] * values[%d].size_value = %x\n", i, (u32)
values[i].size_value);
#endif
		if (temp == values[i].size_value) {
			agp_bridge->previous_size =
			    agp_bridge->current_size = (void *) (values + i);
			agp_bridge->aperture_size_idx = i;

#ifdef ARTICIAS_DEBUG
			temp2 = agp_bridge->current_size;

			printk(KERN_INFO PFX "[ARTICIAS] * masked temp = 0x%x\n", temp);
			printk(KERN_INFO PFX "[ARTICIAS] * values[%d].size = %d\n", i,
values[i].size);
			printk(KERN_INFO PFX "[ARTICIAS] * current_size->size = %d\n",
A_SIZE_8(temp2)->size);
			printk(KERN_INFO PFX "[ARTICIAS] * current_size->page_order = %d\n",
A_SIZE_8(temp2)->page_order);
			printk(KERN_INFO PFX "[ARTICIAS] * current_size->num_entries = %d\n",
A_SIZE_8(temp2)->num_entries);
			printk(KERN_INFO PFX "[ARTICIAS] * current_size->size_value = %d\n",
A_SIZE_8(temp2)->size_value);
#endif
			return values[i].size;
		}
	}

#ifdef ARTICIAS_FROMUNINORTH
	agp_bridge->previous_size =
	    agp_bridge->current_size = (void *) (values + 1);
	agp_bridge->aperture_size_idx = 1;
	return values[1].size;
#endif

	printk(KERN_ERR PFX "Unknown aperture size from AGP bridge (0x%x)\n",
temp);

	return 0;
}

static int articias_configure(void)
{
	u32 temp = 0;
	u16 shift16 = 0;
	u8 shift8 = 0;
	struct aper_size_info_8 *current_size;

#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] articias_configure()\n");
#endif

	/* Get current aperture size */
	current_size = A_SIZE_8(agp_bridge->current_size);

        printk(KERN_INFO PFX "configuring for size idx: %d\n",
	       current_size->size_value);

	temp = (u32) agp_bridge->gatt_table_real;
	/* Get upper word from dword. */
	shift16 = (u16) (temp>>16);

#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] * temp = 0x%x, shift16 = 0x%x\n", temp,
shift16);
#endif

	pci_write_config_word(agp_bridge->dev, ARTICIAS_TLB_BASE, shift16);
	/* Get the byte 1 from dword and mask it out with the aperture size. */
	shift8 = (u8) (temp>>8);
	shift8 &= ~(ARTICIAS_SIZE_MASK);
	shift8 |= current_size->size_value;
	pci_write_config_byte(agp_bridge->dev, ARTICIAS_APBASE, shift8);

#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] * temp = 0x%x, shift8 = 0x%x\n", temp,
shift8);
#endif

	/* Get address to map too */
	pci_read_config_dword(agp_bridge->dev, ARTICIAS_GATTBASE, (void *)&temp);
	temp = temp & ARTICIAS_GATT_MASK;

	agp_bridge->gart_bus_addr = temp;

	/* GART control register */
	/* Enable GART and bus concurrency */
	pci_write_config_byte(agp_bridge->dev, ARTICIAS_GART_EN, 0x41);
	/* Enable AGP operation */
	pci_write_config_byte(agp_bridge->dev, ARTICIAS_AGP_EN, 0x01);

	return 0;
}

#ifdef ARTICIAS_FROMUNINORTH

/* Taken from the Uninorth driver (START). */
static int articias_insert_memory(struct agp_memory *mem, off_t pg_start,
int type)
{
	int i, j, num_entries;
	void *temp;

	temp = agp_bridge->current_size;
	num_entries = A_SIZE_8(temp)->num_entries;

	if (type != 0 || mem->type != 0)
		/* We know nothing of memory types */
		return -EINVAL;
	if ((pg_start + mem->page_count) > num_entries)
		return -EINVAL;

	j = pg_start;

	while (j < (pg_start + mem->page_count)) {
		if (!PGE_EMPTY(agp_bridge, agp_bridge->gatt_table[j]))
			return -EBUSY;
		j++;
	}

	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
		agp_bridge->gatt_table[j] = cpu_to_le32((mem->memory[i] & 0xfe000000) |
0x00000001UL);
		flush_dcache_range((unsigned long)__va(mem->memory[i]),
				   (unsigned long)__va(mem->memory[i])+0x1000);
	}
	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
	mb();
	flush_dcache_range((unsigned long)&agp_bridge->gatt_table[pg_start], 
		(unsigned long)&agp_bridge->gatt_table[pg_start + mem->page_count]);

	/* Geri: We should perform a TLB flush too!. */
	//articias_tlbflush(mem);

	return 0;
}

/* Taken from the Uninorth driver */
static int articias_create_gatt_table(void)
{
	char *table;
	char *table_end;
	int size;
	int page_order;
	int num_entries;
	int i;
	void *temp;
	struct page *page;

	/* We can't handle 2 level gatt's */
	if (agp_bridge->driver->size_type == LVL2_APER_SIZE)
		return -EINVAL;

	table = NULL;
	i = agp_bridge->aperture_size_idx;
	temp = agp_bridge->current_size;
	size = page_order = num_entries = 0;

	do {
		size = A_SIZE_8(temp)->size;
		page_order = A_SIZE_8(temp)->page_order;
		num_entries = A_SIZE_8(temp)->num_entries;

		table = (char *) __get_free_pages(GFP_KERNEL, page_order);

		if (table == NULL) {
			i++;
			agp_bridge->current_size = A_IDX8(agp_bridge);
		} else {
			agp_bridge->aperture_size_idx = i;
		}
	} while (!table && (i < agp_bridge->driver->num_aperture_sizes));

	if (table == NULL)
		return -ENOMEM;

	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);

	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
		SetPageReserved(page);

	agp_bridge->gatt_table_real = (u32 *) table;
	agp_bridge->gatt_table = (u32 *)table;
	agp_bridge->gatt_bus_addr = virt_to_phys(table);

	for (i = 0; i < num_entries; i++) {
		agp_bridge->gatt_table[i] =
		    (unsigned long) agp_bridge->scratch_page;
	}

	flush_dcache_range((unsigned long)table, (unsigned long)table_end);

	return 0;
}

/* Taken from the Uninorth driver */
static int articias_free_gatt_table(void)
{
	int page_order;
	char *table, *table_end;
	void *temp;
	struct page *page;

	temp = agp_bridge->current_size;
	page_order = A_SIZE_8(temp)->page_order;

	/* Do not worry about freeing memory, because if this is
	 * called, then all agp memory is deallocated and removed
	 * from the table.
	 */

	table = (char *) agp_bridge->gatt_table_real;
	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);

	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
		ClearPageReserved(page);

	free_pages((unsigned long) agp_bridge->gatt_table_real, page_order);

	return 0;
}
/* Taken from the Uninorth driver (END). */

#endif /* ARTICIAS_FROMUNINORTH */

static void articias_cleanup(void)
{
	struct aper_size_info_8 *previous_size;

#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] articias_cleanup()\n");
#endif

	previous_size = A_SIZE_8(agp_bridge->previous_size);
	pci_write_config_byte(agp_bridge->dev, ARTICIAS_APSIZE,
			      previous_size->size_value);
}

static void articias_tlbflush(struct agp_memory *mem)
{
#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] agp_tlbflush()\n");
#endif
	return;
}

static struct aper_size_info_8 articias_generic_sizes[7] =
{
	/* size, num_entries, page_order, size_value */

	{4, 1024, 1, 1},
	{8, 2048, 1, 2},
	{16, 4096, 2, 3},
	{32, 8192, 3, 4},
	{64, 16384, 4, 5},
	{128, 32768, 5, 6},
	{256, 65536, 6, 7},

	/* Original code from MAI. */
/*
	{4, 1024, 1, 1},
	{8, 2048, 1, 2},
	{16, 4096, 2, 3},
	{32, 8192, 3, 4},
	{64, 16384, 4, 5},
	{128, 32768, 5, 6}
 */
};

static struct agp_bridge_driver articias_driver = {
	.owner			= THIS_MODULE,
	.aperture_sizes		= articias_generic_sizes,
	.size_type		= U8_APER_SIZE,
	/* Geri: Was 6 before. Added 256k entry for aperture size. */
	.num_aperture_sizes	= 7,
	.configure		= articias_configure,
	.fetch_size		= articias_fetch_size,
	.cleanup		= articias_cleanup,
	.tlb_flush		= articias_tlbflush,
	.mask_memory		= agp_generic_mask_memory,
	.masks			= NULL,
	.agp_enable		= agp_generic_enable,
	.cache_flush		= global_cache_flush,
#ifdef ARTICIAS_FROMUNINORTH
	/* David: new code borrowed from Uninorth driver. */
	.create_gatt_table	= articias_create_gatt_table,
	.free_gatt_table	= articias_free_gatt_table,
	.insert_memory		= articias_insert_memory,
#else
	/* Original code form MAI. */
	.create_gatt_table	= agp_generic_create_gatt_table,
	.free_gatt_table	= agp_generic_free_gatt_table,
	.insert_memory		= agp_generic_insert_memory,
#endif
	.remove_memory		= agp_generic_remove_memory,
	.alloc_by_type		= agp_generic_alloc_by_type,
	.free_by_type		= agp_generic_free_by_type,
	.agp_alloc_page		= agp_generic_alloc_page,
	.agp_destroy_page	= agp_generic_destroy_page,
//	.cant_use_aperture	= 1,
//	.needs_scratch_page	= 1,
};

static struct agp_device_ids articias_agp_device_ids[] __devinitdata =
{
	{
		.device_id	= PCI_DEVICE_ID_MAI_ARTICIAS,
		.chipset_name	= "ArticiaS",
	},

	{ }, /* dummy final entry, always present */
};

static int __devinit agp_articias_probe(struct pci_dev *pdev,
				   const struct pci_device_id *ent)
{
	struct agp_device_ids *devs = articias_agp_device_ids;
	struct agp_bridge_data *bridge;
	int j = 0;
	u8 cap_ptr;

	cap_ptr = pci_find_capability(pdev, PCI_CAP_ID_AGP);
	if (!cap_ptr)
		return -ENODEV;

	j = ent - agp_articias_pci_table;
	printk (KERN_INFO PFX "Detected MAI %s chipset\n", devs[j].chipset_name);

	bridge = agp_alloc_bridge();
	if (!bridge)
		return -ENOMEM;

	bridge->dev = pdev;
	bridge->capndx = cap_ptr;
	bridge->driver = &articias_driver;

	return agp_add_bridge(bridge);
}

static void __devexit agp_articias_remove(struct pci_dev *pdev)
{
	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);

	agp_remove_bridge(bridge);
	agp_put_bridge(bridge);
}

#ifdef CONFIG_PM

static int agp_articias_suspend(struct pci_dev *pdev, pm_message_t state)
{
	pci_save_state (pdev);
	pci_set_power_state (pdev, PCI_D3hot);

	return 0;
}

static int agp_articias_resume(struct pci_dev *pdev)
{
	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);

	pci_set_power_state (pdev, PCI_D0);
	pci_restore_state(pdev);

	if (bridge->driver == &articias_driver)
		return articias_configure();

	return 0;
}

#endif /* CONFIG_PM */

/* must be the same order as name table above */
static struct pci_device_id agp_articias_pci_table[] = {
#define ID(x) \
	{						\
	.class		= (PCI_CLASS_BRIDGE_HOST << 8),	\
	.class_mask	= ~0,				\
	.vendor		= PCI_VENDOR_ID_MAI,		\
	.device		= x,				\
	.subvendor	= PCI_ANY_ID,			\
	.subdevice	= PCI_ANY_ID,			\
	}
	ID(PCI_DEVICE_ID_MAI_ARTICIAS),
	{ }
};

MODULE_DEVICE_TABLE(pci, agp_articias_pci_table);

static struct pci_driver agp_articias_pci_driver = {
	.name		= "agpgart-articias",
	.id_table	= agp_articias_pci_table,
	.probe		= agp_articias_probe,
	.remove		= agp_articias_remove,
#ifdef CONFIG_PM
	.suspend	= agp_articias_suspend,
	.resume		= agp_articias_resume,
#endif
};

static int __init agp_articias_init(void)
{
	if (agp_off)
	{
#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] agp_articias_init return EINVAL.\n");
#endif
		return -EINVAL;
	}

#ifdef ARTICIAS_DEBUG
	printk(KERN_INFO PFX "[ARTICIAS] agp_articias_init return pci driver
struct.\n");
#endif
	return pci_register_driver(&agp_articias_pci_driver);
}

static void __exit agp_articias_cleanup(void)
{
	pci_unregister_driver(&agp_articias_pci_driver);
}

module_init(agp_articias_init);
module_exit(agp_articias_cleanup);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>"); 

####### END ######

The code contains a lot of debug code. The driver was based on the VIA
AGPGART driver, but we also tried to get it working with parts of the
Uninorth AGPGART driver.

This is the debug output, if the Uninorth code is not compiled in, but the
generic AGP GATT table create function is used:

Jan 11 22:42:49 localhost kernel: Linux agpgart interface v0.101 (c) Dave
Jones
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] agp_articias_init
return pci driver struct.
Jan 11 22:42:49 localhost kernel: agpgart: Detected MAI ArticiaS chipset
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] articias_fetch_size()
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * non masked temp =
0x41
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * aperature size loop
index #0
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * values[0].size_value
= 1
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * masked temp = 0x1
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * values[0].size = 4
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] * current_size->size =
4
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] *
current_size->page_order = 1
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] *
current_size->num_entries = 1024
Jan 11 22:42:49 localhost kernel: agpgart: [ARTICIAS] *
current_size->size_value = 1
Jan 11 22:42:49 localhost kernel: __ioremap(): phys addr 1fb56000 is RAM lr
c000ec60
Jan 11 22:42:49 localhost kernel: agpgart: unable to get memory for graphics
translation table.
Jan 11 22:42:49 localhost kernel: agpgart: agp_backend_initialize() failed.
Jan 11 22:42:49 localhost kernel: agpgart-articias: probe of 0000:00:00.0
failed with error -12

If the Uninorth code is used, then the driver detects the aperture size as
4MB@0x0:

Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] articias_fetch_size()
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * non masked temp =
0x41
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * aperature size loop
index #0
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * values[0].size_value
= 1
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * masked temp = 0x1
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * values[0].size = 4
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] * current_size->size =
4
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] *
current_size->page_order = 1
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] *
current_size->num_entries = 1024
Jan 11 20:34:12 localhost kernel: agpgart: [ARTICIAS] *
current_size->size_value = 1
Jan 11 20:34:12 localhost kernel: agpgart: AGP aperture is 4M @ 0x0

Regards,

Gerhard

-- 
10 GB Mailbox, 100 FreeSMS/Monat http://www.gmx.net/de/go/topmail
+++ GMX - die erste Adresse für Mail, Message, More +++
