Date: Fri, 22 Mar 2002 21:01:03 -0700
From: Val Henson <val@nmt.edu>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020322210103.C3363@boardwalk>
References: <20020320161931.GF3762@opus.bloom.county> <20020320165825.31210@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020320165825.31210@mailhost.mipsys.com>; from benh@kernel.crashing.org on Wed, Mar 20, 2002 at 05:58:25PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for writing this up, Ben!  My main objection is that I really
don't see any reason to make bi_recs more complicated than:

record type
size
data

What added functionality does the whole "structure" concept give us?
Here's the current bi_rec parsing code:

while (rec->tag != BI_LAST) {
  /* fiddle with each individual record */
  rec = (struct bi_record *)((ulong)rec + rec->size);
}

The simplicity of this system is valuable - I don't want to give it up
unless we get lots and lots of added functionality in return.  Dan
Malek's comments suggest that bi_recs should only be used for only a
small, simple class of information.  In this context, I don't see what
structures buy us.

I have to admit, bi_rec structures are a really cool idea, but I
prefer simplicity over coolness. :)

-VAL

On Wed, Mar 20, 2002 at 05:58:25PM +0100, benh@kernel.crashing.org wrote:
>
> Ok, here is my older document, though now that I re-read it, I find
> it rather too bloated. Food for though...
>
> Ben.
>
> /* Here's a try at defining new birecs a bit more
>  *
>  * Of course, most of this is _optional_, OF based machines
>  * won't use but a few of these, embedded developers may use
>  * and customize these, we will try to make embedded specific
>  * driver rely solely on defined bi_recs....
>  *
>  * Note. The high 8 bits of the size field contains a type code
>  * for the bi_rec. The types are defined below. The composite
>  * type allow embedding of "properties", in that case the birec
>  * tag is considered as a "name". For records of type meminfo,
>  * bootinfo, and cpuinfo, the tag identify the information passed.
>  * All lowercase tags are reserved for future use by the kernel,
>  * All uppercase or mixed case tags can be freely used by board
>  * implementors for custom applications.
>  */
>
> struct bi_record {
>     unsigned long tag;		/* tag ID */
>     unsigned long size;		/* size of record (in bytes) */
>     unsigned long data[0];	/* data */
> };
>
> #define BI_SIZEMASK		0x00ffffff
> #define BI_TYPEMASK		0xff000000
>
> #define BI_TYPE_FIRST		0x01000000
> #define BI_TYPE_CPUINFO		0x02000000	/* single values, fixed type */
> #define BI_TYPE_BOARDINFO	0x03000000	/* single values, fixed type */
> #define BI_TYPE_MEMINFO		0x04000000	/* physical memory layout */
> #define BI_TYPE_BOOTINFO	0x05000000	/* boot infos (cmdline, ...) */
> #define BI_TYPE_COMPOSITE	0x42000000	/* more birecs after a bi_composite */
> #define BI_TYPE_SINGLE_MASK	0x80000000	/* single value (no size, value in
> size field */
> #define BI_TYPE_END_COMPOSITE	0xfe000000
> #define BI_TYPE_LAST		0xff000000
>
> /*
>  * CPU Info
>  */
> #define BI_CPU_4xx_CORE_CLOCK	'cclk'		/* Core clock of a 4xx (ulong, Hz) */
> #define BI_CPU_4xx_PLB_CLOCK	'pclk'		/* PLB clock of a 4xx (ulong, Hz) */
> #define BI_CPU_4xx_OPB_CLOCK	'oclk'		/* OPB clock of a 4xx (ulong, Hz) */
> #define BI_CPU_4xx_PCI_CLOCK	'iclk'		/* PCI clock of a 4xx (ulong, Hz) */
>
> /*
>  * Board info
>  */
> #define BI_BOARD_NAME		'name'		/* 0 term string */
> #define BI_BOARD_MACHINE_TYPE	'mach'		/* Machine type (common config) */
> #define BI_BOARD_MACHINE_MODEL	'modl'		/* Model within machine type */
> #define BI_BOARD_MACHINE_FAMILY	'fami'		/* Familly within machine type */
>
> #define BI_BOARD_SERIALNUMBER	'sern'		/* Why not ? 0 term string */
>
> 	/* To be defined, or specific to a given board */
>
> /*
>  * Mem info
>  */
> #define BI_MEM_TOTALMEM		'totm'		/* Total memory */
> #define BI_MEM_PHYSMAP		'phym'		/* Physmap, contiguous @ 0 if absent */
> #define BI_MEM_DIMMMAP		'dimm'		/* Why not ? ... */
>
> /*
>  * Boot info
>  */
> #define BI_BOOT_CMDLINE		'cmdl'		/* Command line (0 term string) */
> #define BI_BOOT_INITRD		'rimg'		/* Initial ramdisk */
> 	struct bi_boot_initrd {
> 		unsigned long	addr;		/* Physical address */
> 		unsigned long	csize;		/* Compressed size */
> 		unsigned long	msize;		/* Memory size (max rd driver size) */
> 	};
> 	/* Note: we may want to define a format for scattered ramdisks */
> #define BI_BOOT_ROOT_DEVICE	'root'		/* Major & minor of root device in
> 2x32 bits ! */
>
> /*
>  * Composite record format is a suite of bi_recs finishing
>  * with a BI_TYPE_END_COMPOSITE.
>  * They have a "name" which is the tag of the composite
>  * record, and they begin with a "type" long. Then, is
>  * a suite of bi_recs.
>  */
> struct bi_composite {
>     unsigned long type_tag;		/* type tag */
>     unsigned long data[0];		/* more birecs */
> };
>
> /* Here are some defined type tags */
>
> #define BI_COMP_DEVGROUP	'dgrp'	/* A group of devices (more composite) */
> #define BI_COMP_DEVICE		'devi'	/* Generic device */
> #define BI_COMP_PCI_HOST	'phst'	/* PCI host (contains it's devices !) */
> #define BI_COMP_PCI_DEVICE	'pdev'	/* PCI device */
> #define BI_COMP_CPU_DEVICE	'pdev'	/* CPU embedded device */
> #define BI_COMP_IRQ_NODE	'irqn'	/* Interrupt node (controller or bridge) */
>
> /*
>  * An interrupt node defines interrupt routing.
>  */
>
> /* To be written ;) */
>
>
> /*
>  * A device has those generic properties defined.
>  */
>
> /* An IO resource is an abstract entity to designate a memory
>  * or IO region used by a device. The exact meaning of those
>  * fields depends on the atualy type of device (the bus where
>  * resides). A generic device is meant to be used for your own
>  * motherboard devices, you can use the values below the way
>  * you want, each driver defines it's own meaning there.
>  * It wouldn't be efficient to provide more abstraction imho.
>  */
> #define BI_PROP_IO_RESOURCE		'iors'
> struct bi_prop_io_resource {
> 	unsigned long	base_addr;
> 	unsigned long	size;
> 	unsigned long	flags;
> };
>
> /* An interrupt is designated by a parent node ID and a
>  * number. The parent node structure will be then define
>  * routing informations. If the interrupt is wired to the
>  * CPU's internal interrupt controller directly, it's parent
>  * node ID is 0, and the number represents an interrupt number
>  * in the native CPU numbering.
>  * Additionally, flags are added to the interrupt definition.
>  * Only 2 bits are currently defined for those, the high 16
>  * bits are free to be used by the implementor of a given board.
>  */
> #define BI_PROP_INTERRUPT		'irq '
> struct bi_prop_interrupt {
> 	unsigned long	parent;		/* tagID of the parent node */
> 	unsigned long	number;		/* Interrupt number */
> 	unsigned long	flags;		/* see below */
> };
> #define BI_IRQ_LEVEL	0x00000000	/* bit 0 = 0 */
> #define BI_IRQ_EDGE	0x00000001	/* bit 0 = 1 */
> #define BI_IRQ_NEG	0x00000000	/* bit 1 = 0 */
> #define BI_IRQ_POS	0x00000002	/* bit 1 = 1 */
>
> /* The device type (or class), mostly for information purpose for now */
> #define BI_PROP_DEVICE_CLASS		'clas'	/* ulong */
> #define  BI_DEV_CLASS_ETHERNET		'eth '
> #define  BI_DEV_CLASS_UART		'uart'
> #define  BI_DEV_CLASS_SCC		'scc '
> 	/* etc... */
>
> /* The driver is used to define "standard" type of devices, like
>  * PC-like uart. Note that devices defined below rely on a specific
>  * format of the io resources and eventual additional properties
>  */
> #define BI_PROP_DEVICE_DRIVER		'drvr' /* ulong */
>
>  /* define required properties of legacy serial here */
>
> /*
>  * Properties relative to PCI hosts
>  */
>
>   /* define bus numbers, and bases here along with a type
>    * property indicating the host type, a generic type can
>    * be used for indirect
>    */
>
> /*
>  * Properties relative to PCI devices. This includes the
>  * above properties (all of them eventually). The IO resource
>  * property additionally defines some flags. The actual mapping
>  * of the host bridge (ISA, etc...) isn't defined here but is
>  * defined
>  */
> #define BI_PROP_PCI_DEVFN		'dvfn' /* ulong */
> #define BI_PROP_PCI_VENDORID		'vid ' /* Do we need that here ? */
> #define BI_PROP_PCI_DEVICEID		'did ' /* Do we need that here ? */
>
> /* Note: I appologize for bit numbering ;) */
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
