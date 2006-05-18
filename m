Return-Path: <benh@kernel.crashing.org>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060518002142.GA23182@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 18 May 2006 15:32:55 +1000
Message-Id: <1147930376.17679.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-17 at 17:21 -0700, Mark A. Greer wrote:
> Hi,
> 
> This is a patch with some very rough code that adds support for the
> sandpoint to arch/powerpc.  I'm posting it now in the hope that it
> will spark a deeper discussion on exactly how we're going to support
> flattened device tree code in the bootwrapper for non-OF platforms.
> I'm also hoping that it will help others that are working on the same
> sort of thing so we can help each other.
> 
> Again, the code is rough with lots of hacks but it boots and is
> something we can point to during this discussion.
> 
> So...I am on the right path?

Well, we'll see, let's have a look :)

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6729c98..de09eac 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -323,7 +323,10 @@ config PPC_ISERIES
>  
>  config EMBEDDED6xx
>  	bool "Embedded 6xx/7xx/7xxx-based board"
> -	depends on PPC32 && BROKEN
> +	depends on PPC32
> +	select PPC_UDBG_16550
> +	select MPIC
> +	select MPIC_SERIAL

Not totally related to your patch but I'm tempted to turn that into a
"Generic 6xx/7xx/7xxx" rather than "embedded" if we manage to always
avoid board specific code most of the time, but instead add necessary
bits in the device-tree. We still need a per-board Kconfig option I
think that will just select the necessary bits and pieces (and more than
one can be selected at one time). Also, I think right now, the embedded
stuff is +/- exclusive from the MULTIPLATFORM stuff, that must be fixed
asap. We are all living in the same kernel now :)
 
> +
> +config MPIC_SERIAL
> +	depends on EMBEDDED6xx
> +	bool
> +	default n

Not sure what the above is, I'll have a look further in the patch but I
can already tell you that it should be your per-board
CONFIG_PPC_SANDPOINT for example that "selects" the various bits you
need, and thus the above should depend on it, not EMBEDDED6xx... In fact
I'm wondering wether we should kill EMBEDDED6xx :) Unless it's purely a
reference to arch/powerpc/platforms/embedded6xx/ as a storage place for
board setup_xxx.c files which is useful for platforms that really don't
need more than one or 2 files in there.
 
> +ifeq ($(CONFIG_EMBEDDED6xx),y)
> +src-boot += prom_embedded.c ns16550.c dts/sandpoint.S \
> +	dt_utils.c sandpoint.c mpc10x.c
> +else
> +src-boot += prom.c
> +endif

Again, I think CONFIG_EMBEDDED6xx is the wrong approach. I'd like to
avoid the word "embedded" altogether anyway :) Thing is, it would be
good if ultimately, embedded boards firmware was capable of passing a
device-tree. Thus, embedded a device-tree in the zImage wrapper is more
like a "fallback" solution which has the side effect of creating machine
specific zImage's.

That is why, I think, what we should do is have rules for building
separate zImage wrappers. The basic OF one (which exists in both real
and virtual mode versions and that I'd like to make capable of also
working if a flat device-tree is passed in), the zImage.sandpoint, the
zImage.prep, and whatever...

Thus enabling CONFIG_PPC_MYBOARD should trigger the build of the
board-flavored version of the wrapper in addition to all the other ones
for the other boards built as part of a given config.

I know it's a bit difficult because the current boot Kbuild rules aren't
really design for multiple targets but I think that's the way to go.
 
 .../...

About the .dts file, we should look into "shipping" a pre-built one so
that dtc is not required for building a kernel. I think we already have
a mecanism for providing "shipped" versions of files and having the
option of rebuilding them from source (though I don't have the details
in mind at the moment) 

> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h

 .../.. io stuffs ...

Well... io accessors in here can't harm, the question is more how they
are used ;)

> +#define	PCI_DEVFN(slot,func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
> +
> +/* Indirect PCI config space access routines */
> +static inline void
> +pci_indirect_read_config_byte(u32 *cfg_addr, u32 *cfg_data, int devfn,
> +		int offset, u8 *val)
> +{
> +	out_be32(cfg_addr,
> +		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
> +	*val = in_8((u8 *)(cfg_data + (offset & 3)));
> +	return;
> +}
> +
> +static inline void
> +pci_indirect_read_config_dword(u32 *cfg_addr, u32 *cfg_data, int devfn,
> +		int offset, u32 *val)
> +{
> +	out_be32(cfg_addr,
> +		((offset & 0xfc) << 24) | (devfn << 16) | (0 << 8) | 0x80);
> +	*val = in_le32(cfg_data + (offset & 3));
> +	return;
> +}

That's more annoying... if we start having PCI config space access in
the boot wrapper how far will it stop ? I'd rather keep that sort of
stuff local to myboard.c file unless it's really worth sharing... Unless
we end up with really common need for them in which case those should be
in separate files, possibly in a separate dir (thinking about it, prep
will probably need that too)

The main problem is how do we do printf kind of things from such a
bootloader. That needs IO, thus uart drivers etc... possibly parsing
from the device-tree etc... I'm tempted to just have a global
"boot_puts" function pointer set by the board and/or OF code to use
through the bootloader, maybe a shared uart.c file with various uart
bits and keep the gory implementation details of mapping the uart and
using those uart bits in the myboard.c file...
 
> +#ifdef CONFIG_PPC_OF
>  typedef void (*kernel_entry_t)( unsigned long,
>                                  unsigned long,
>                                  void *,
>  				void *);
> +#else
> +void platform_fixups(void *dt_blob);
> +extern void *dt_blob_start;
> +extern void *dt_blob_end;
> +void edit_cmdline(void *dt_blob_start);
> +typedef void (*kernel_entry_t)(void *dtb_addr, void *kernel_entry_paddr,
> +		void *must_be_null);
> +#endif

Why 2 different prototypes for kernel_entry ?

I think we need something like CONFIG_PPC_BOOT_HAS_BUILTIN_DT that
enables various DT related stuff in a clean way and have a builtin_dt.h
file with related prototypes & definitions.
 
>  #undef DEBUG
> @@ -218,7 +227,7 @@ void start(unsigned long a1, unsigned lo
>  	if (getprop(chosen_handle, "stdout", &stdout, sizeof(stdout)) != 4)
>  		exit();
>  
> -	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
> +	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start,sp);

Gratuituous uglyfication :)

>  	/*
>  	 * The first available claim_base must be above the end of the
> @@ -238,7 +247,7 @@ void start(unsigned long a1, unsigned lo
>  		gunzip(elfheader, sizeof(elfheader),
>  				(unsigned char *)vmlinuz.addr, &len);
>  	} else
> -		memcpy(elfheader, (const void *)vmlinuz.addr, sizeof(elfheader));
> +		memcpy(elfheader, (const void *)vmlinuz.addr,sizeof(elfheader));

Gratuituous uglyfication (bis) :)
 
>  	if (!is_elf64(elfheader) && !is_elf32(elfheader)) {
>  		printf("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
> @@ -263,18 +272,21 @@ void start(unsigned long a1, unsigned lo
>  	initrd.size = (unsigned long)(_initrd_end - _initrd_start);
>  	initrd.memsize = initrd.size;
>  	if ( initrd.size > 0 ) {
> -		printf("Allocating 0x%lx bytes for initrd ...\n\r", initrd.size);
> +		printf("Allocating 0x%lx bytes for initrd ...\n\r",initrd.size);

Gratuituous uglyfication (ter) :)

>  		initrd.addr = try_claim(initrd.size);
>  		if (initrd.addr == 0) {
> -			printf("Can't allocate memory for initial ramdisk !\n\r");
> +			printf("Can't allocate memory for initial "
> +					"ramdisk !\n\r");
>  			exit();
>  		}
>  		a1 = initrd.addr;
>  		a2 = initrd.size;
> -		printf("initial ramdisk moving 0x%lx <- 0x%lx (0x%lx bytes)\n\r",
> -		       initrd.addr, (unsigned long)_initrd_start, initrd.size);
> -		memmove((void *)initrd.addr, (void *)_initrd_start, initrd.size);
> -		printf("initrd head: 0x%lx\n\r", *((unsigned long *)initrd.addr));
> +		printf("initial ramdisk moving 0x%lx <- 0x%lx "
> +			"(0x%lx bytes)\n\r", initrd.addr,
> +			(unsigned long)_initrd_start, initrd.size);
> +		memmove((void *)initrd.addr, (void *)_initrd_start,initrd.size);
> +		printf("initrd head: 0x%lx\n\r",
> +				*((unsigned long *)initrd.addr));
>  	}
>  
>  	/* Eventually gunzip the kernel */
> @@ -299,6 +311,7 @@ #endif
>  	flush_cache((void *)vmlinux.addr, vmlinux.size);
>  
>  	kernel_entry = (kernel_entry_t)vmlinux.addr;
> +#ifdef CONFIG_PPC_OF
>  #ifdef DEBUG
>  	printf( "kernel:\n\r"
>  		"        entry addr = 0x%lx\n\r"
> @@ -311,9 +324,20 @@ #ifdef DEBUG
>  #endif

>  	kernel_entry(a1, a2, prom, NULL);
> +#else /* !CONFIG_PPC_OF ==> flattened device tree */
> +#ifdef DEBUG
> +	printf("kernel:\n\r"
> +		"        entry addr   = 0x%lx\n\r"
> +		"        flattened dt = 0x%lx\n\r",
> +		(unsigned long)kernel_entry, &dt_blob_start);
> +#endif
> +	edit_cmdline(&dt_blob_start);
> +	platform_fixups(&dt_blob_start);
>  
> +	kernel_entry(&dt_blob_start, (void *)vmlinux.addr, NULL);
> +#endif

Let's avoid #ifdef's if we can... provide function pointers where it
matter setup by the board/OF init code maybe but not ifdef's. Afaik,
only WD actually _likes_ ifdef's :)

> +++ b/arch/powerpc/boot/mpc10x.c

We'll need some subdirs here or it will get messy quick...

> diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c

Same comment as above

> +/* XXXX Get info from dt instead */
> +static struct {
> +	int baud_base;
> +	unsigned long com_port;
> +	u16 iomem_reg_shift;
> +} rs_table[RS_TABLE_SIZE] = {
> +        { BASE_BAUD, SANDPOINT_SERIAL_0, 0 },
> +        { BASE_BAUD, SANDPOINT_SERIAL_1, 0 },
> +};

Well, your own comment says it all :) I think we might need an
equivalent of prom_parse.c in the bootloader
+
> +/* #ifndef CONFIG_PPC_OF XXXX */
> +
> +/* Definitions used by the flattened device tree */
> +#define OF_DT_HEADER		0xd00dfeed	/* marker */
> +#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
> +#define OF_DT_END_NODE		0x2		/* End node */
> +#define OF_DT_PROP		0x3		/* Property: name off, size,
> +						 * content */
> +#define OF_DT_NOP		0x4		/* nop */
> +#define OF_DT_END		0x9
> +
> +#define OF_DT_VERSION		0x10

   .../... (flat DT definitions)

Can't we share the kernel definition here ? Maybe split the kenrel one
in two if necessary ? I don't like that sort of duplication...

> +unsigned long serial_init(int chan, void *ignored);
> +void serial_putc(unsigned long com_port, unsigned char c);
> +unsigned char serial_getc(unsigned long com_port);
> +int serial_tstc(unsigned long com_port);

Forgot to mention that earlier, but those should be uart_* imho (or even
16550_*) since we'll surely have different species of serial ports to
deal with and I don't like name mixup. Unless we consider that only ever
one of those serial files get built in a given zImage wrapper in which
case it makes some sense...

> +call_prom(const char *service, int nargs, int nret, ...)
> +{
> +
> +	static struct {
> +		char	*service;
> +		int	((*rtn)(int nargs, int nret, va_list args));
> +	} services[] = {
> +		{ "exit", service_exit },
> +		{ "finddevice", service_finddevice },
> +		{ "getprop", service_getprop },
> +		/* { "write", service_write }, */
> +	};
> +	va_list args;
> +	int i, rc = 0;
> +
> +	for (i=0; i<ARRAY_SIZE(services); i++)
> +		if (!strcmp(service, services[i].service)) {
> +			va_start(args, nret);
> +			rc = services[i].rtn(nargs, nret, args);
> +			va_end(args);
> +		}
> +
> +	return (nret > 0)? rc : 0;
> +}

I don't think call_prom is the right abstraction :) We have to decide
here, we have two choices:

 - Either a given zImage wrapper can be booted from both a real OF and
have an embedded flat DT, in which case we need function pointers and I
think the right abstraction is for individual prom functions to have
their function pointer rathaer than "multiplex" through call_prom

 - Or a given zImage wrapper is a single board thingy. That is it is
either the OF wrapper _or_ it can contain an embedded DT. Probably
easier that way and no need for funciton pointers nor mux at all... I
tend to think that might be the right way to go at this point...
Especially since as I wrote before, I'm tempted to think we should just
in that case build multiple zImage wrappers. The only thing there is
that if we go that route, I'd like the "OF" one to also be able to boot
with a flat DT passed on entry to it so it will be useable as a generic
zImage for firmwares that have a flat DT to pass to the kernel. The only
"issue" with that is it might be difficult to have console output unless
we do the putc function pointer thing I described earlier and have
several "uart" impleentations with differnet names and enough
device-tree parsing to be able to instanciate them (almost a copy of
kernel's legacy serial stuff). Another option if we want console output
is to add something to the DT header specifically for use by such early
boot code that specifies a function that can be called back for
displaying thing as long as a given memory range isn't overriden (the FW
itself)

Comments are welcome here, this is I think the most tricky point and
where we need to make a decision...

> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index 6e67b5b..2feca55 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -147,9 +147,11 @@ static int __init add_legacy_isa_port(st
>  	if (reg == NULL)
>  		return -1;
>  
> +#if 0 /* XXXX */
>  	/* Verify it's an IO port, we don't support anything else */
>  	if (!(reg[0] & 0x00000001))
>  		return -1;
> +#endif

Gack ? Care to explain ?

> +obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/

Hrmph.... (random noises)


> +/*
> + * Define all of the IRQ senses and polarities.  Taken from the
> + * Sandpoint X3 User's manual.
> + */
> +static u_char sandpoint_openpic_initsenses[] __initdata = {
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 0: SIOINT */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 1: XXXX FILL?? */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 2: PCI Slot 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 3: PCI Slot 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 4: PCI Slot 3 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 5: PCI Slot 4 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 6: XXXX FILL?? */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 7: XXXX FILL?? */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 8: IDE (INT C) */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 9: IDE (INT D) */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 10: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 11: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 12: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 13: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 14: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* 15: */
> +};

Of course you already know that this has to go into the device-tree :)

> +/*
> + * Interrupt setup and service.  Interrrupts on the Sandpoint come
> + * from the four PCI slots plus the 8259 in the Winbond Super I/O (SIO).
> + * The 8259 is cascaded from EPIC IRQ0, IRQ1-4 map to PCI slots 1-4,
> + * IDE is on EPIC 7 and 8.
> + */
> +static void __init
> +sandpoint_init_IRQ(void)
> +{
> +	struct mpic *mpic;
> +	phys_addr_t openpic_paddr = 0xfc000000 + /* XXXX */
> +		MPC10X_EUMB_EPIC_OFFSET;
> +
> +	/* This doesn't handle i2c, dma, i2o, or timer intrs right now XXXX */
> +	mpic = mpic_alloc(openpic_paddr, MPIC_PRIMARY,
> +			16 /* XXXX otherwise num_sources used */ ,
> +			NUM_8259_INTERRUPTS,
> +			0, /* was 16 */
> +			NR_IRQS - 4 /* XXXX */,
> +			sandpoint_openpic_initsenses,
> +			sizeof(sandpoint_openpic_initsenses), " EPIC     ");
> +
> +	BUG_ON(mpic == NULL); /* XXXX */
> +	mpic_assign_isu(mpic,  0, openpic_paddr + 0x10200);
> +	mpic_init(mpic);
> +	mpic_setup_cascade(NUM_8259_INTERRUPTS, i8259_irq_cascade, NULL);
> +	i8259_init(0xfef00000, 0); /* pci iack addr */
> +}

It would be really nice if we could define properties to put in the
"mpic" node that defines the various attributes to pass to it and that
sort of thing so that we can have a generic "mpic_init_IRQ" that walks
all MPICs and instanciate & link them in cascade when necessary... Oh
well, food for thought, no high priority there.

> +/*
> + * Freescale Sandpoint interrupt routing.
> + */
> +static inline int
> +x3_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
> +{
> +	static char pci_irq_table[][4] =
> +	/*
> +	 *	PCI IDSEL/INTPIN->INTLINE
> +	 * 	   A   B   C   D
> +	 */
> +	{
> +		{ 16,  0,  0,  0 },	/* IDSEL 11 - i8259 on Winbond */
> +		{  0,  0,  0,  0 },	/* IDSEL 12 - unused */
> +		{ 18, 21, 20, 19 },	/* IDSEL 13 - PCI slot 1 */
> +		{ 19, 18, 21, 20 },	/* IDSEL 14 - PCI slot 2 */
> +		{ 20, 19, 18, 21 },	/* IDSEL 15 - PCI slot 3 */
> +		{ 21, 20, 19, 18 },	/* IDSEL 16 - PCI slot 4 */
> +	};
> +
> +	const long min_idsel = 11, max_idsel = 16, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP;
> +}

Of course you also know that the above has to go into the device-tree as
well :)

> +static void __init
> +sandpoint_setup_winbond_83553(struct pci_controller *hose)
> +{
> +	int		devfn;
> +
> +	/*
> +	 * Route IDE interrupts directly to the 8259's IRQ 14 & 15.
> +	 * We can't route the IDE interrupt to PCI INTC# or INTD# because those
> +	 * woule interfere with the PMC's INTC# and INTD# lines.
> +	 */
> +	/*
> +	 * Winbond Fcn 0
> +	 */
> +	devfn = PCI_DEVFN(11,0);
> +
> +	early_write_config_byte(hose,
> +				0,
> +				devfn,
> +				0x43, /* IDE Interrupt Routing Control */
> +				0xef);
> +	early_write_config_word(hose,
> +				0,
> +				devfn,
> +				0x44, /* PCI Interrupt Routing Control */
> +				0x0000);
> +
> +	/* Want ISA memory cycles to be forwarded to PCI bus */
> +	early_write_config_byte(hose,
> +				0,
> +				devfn,
> +				0x48, /* ISA-to-PCI Addr Decoder Control */
> +				0xf0);
> +
> +	/* Enable Port 92.  */
> +	early_write_config_byte(hose,
> +				0,
> +				devfn,
> +				0x4e,	/* AT System Control Register */
> +				0x06);
> +	/*
> +	 * Winbond Fcn 1
> +	 */
> +	devfn = PCI_DEVFN(11,1);
> +
> +	/* Put IDE controller into native mode. */
> +	early_write_config_byte(hose,
> +				0,
> +				devfn,
> +				0x09,	/* Programming interface Register */
> +				0x8f);
> +
> +	/* Init IRQ routing, enable both ports, disable fast 16 */
> +	early_write_config_dword(hose,
> +				0,
> +				devfn,
> +				0x40,	/* IDE Control/Status Register */
> +				0x00ff0011);
> +	return;
> +}

How much of the above could/should be done by the wrapper since it does
config space access hacks ? My idea is that we might be able to remove
pretty much _everything_ from this sandpoint.c file ... My dream would
be to have a generic board support that matches a list of known boards
for which no special code is needed, only the device-tree (and possibly
the zImage wrapper).

The main things preventing us from doing that at the moment is that we
need to define enough standard nodes/properties to have the ability to
the setup interrupt controller tree entirely from it, and the PCI host
bridges as well. For the later, that means encoding enough of the bridge
type and config access method to allow having a generic device-tree
based piece of code that does what add_bridges() does in a generic way. 

> +static int
> +x3_exclude_device(u_char bus, u_char devfn)
> +{
> +	if ((bus == 0) && (PCI_SLOT(devfn) == 0))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}

If we need to exclude devices in a generic way, we could define a
specific exclude list property... or use what I think has already been
defined by OF for indicating which slots should be probed :)
 
> +static int __init
> +add_bridge(struct device_node *dev)
> +{
> +	int len;
> +	struct pci_controller *hose;
> +	int *bus_range;
> +
> +	printk("Adding PCI host bridge %s\n", dev->full_name);
> +
> +	bus_range = (int *) get_property(dev, "bus-range", &len);
> +	if (bus_range == NULL || len < 2 * sizeof(int))
> +		printk(KERN_WARNING "Can't get bus-range for %s, assume"
> +				" bus 0\n", dev->full_name);
> +
> +	hose = pcibios_alloc_controller();
> +	if (hose == NULL)
> +		return -ENOMEM;
> +	hose->first_busno = bus_range ? bus_range[0] : 0;
> +	hose->last_busno = bus_range ? bus_range[1] : 0xff;
> +	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
> +
> +	/* Interpret the "ranges" property */
> +	/* This also maps the I/O region and sets isa_io/mem_base */
> +	pci_process_bridge_OF_ranges(hose, dev, 1);
> +
> +	return 0;
> +}

See above comments.... Looks ok but how many boards will end up having
very small variations of that same code and thus can we find a way to
make that totally generic...
 
> +u32 mag_dbg = 0;
> +
> +static void __init
> +sandpoint_setup_arch(void)
> +{
> +	loops_per_jiffy = 100000000 / HZ;
> +	isa_io_base = 0xfe000000;
> +	isa_mem_base = 0x80000000;
> +	pci_dram_offset = 0;

The isa stuff should probably be deduced from the device-tree, the
default LPJ too, probably not even useful anymore since we are using the
timebase nowadays.

> +#ifdef CONFIG_BLK_DEV_INITRD
> +	if (initrd_start)
> +		ROOT_DEV = Root_RAM0;
> +	else
> +#endif
> +#ifdef	CONFIG_ROOT_NFS
> +		ROOT_DEV = Root_NFS;
> +#else
> +		ROOT_DEV = Root_HDA1;
> +#endif

Same comment as above, this is fairly generic and we could even imagine
something like a linux,default-boot-device thing in the DT...

> +#if 1 /* XXXX NEW */
> +	{
> +		struct device_node *np;
> +
> +		mag_dbg = 1;
> +		for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +			add_bridge(np);
> +		mag_dbg = 0;
> +
> +		ppc_md.pci_swizzle = common_swizzle;
> +		ppc_md.pci_map_irq = x3_map_irq;
> +		ppc_md.pci_exclude_device = x3_exclude_device; /* XXXX */
> +	}
> +#endif

The problem of IRQ mapping & swizzling will be solved real soon
(hopefully early 2.6.18) so that we can completely rely on the
device-tree without needing device_node's for every PCI device. Only P2P
bridges that don't do standard swizzling (typically bridges soldered on
the motherboard) will require device nodes. I'm working on it :)

The idea is that the host bridge will need the standard interrupt-map &
interrupt-map-mask which will indicate the interrupt mapping for every
line of every slot/device in the standard way handled by OF (that
already works). And I'll add code that will be able to handle PCI
devices without a node by artificially building their "interrupts"
property based on the interrupt pin config space entry and walking up
the PCI tree, doing standard swizzling when encountering a P2P bridge
until we hit something with a device-node in which case we hook our
result to the interrupt-map of that device-node.
 
> +	if (cpu_has_feature(CPU_FTR_SPEC7450))
> +		/* 745x is different.  We only want to pass along enable. */
> +		_set_L2CR(L2CR_L2E);
> +	else if (cpu_has_feature(CPU_FTR_L2CR))
> +		/* All modules have 1MB of L2.  We also assume that an
> +		 * L2 divisor of 3 will work.
> +		 */
> +		_set_L2CR(L2CR_L2E | L2CR_L2SIZ_1MB | L2CR_L2CLK_DIV3
> +				| L2CR_L2RAM_PIPE | L2CR_L2OH_1_0 | L2CR_L2DF);

Keeping in mind my idea of having as much generic code as possible,
whould we do the above in the boot wrapper or if not, should we provide
some DT entries indicating that L2CR should be reset and to which
values ?

> +#if 0
> +	/* Untested right now. */
> +	if (cpu_has_feature(CPU_FTR_L3CR)) {
> +		/* Magic value. */
> +		_set_L3CR(0x8f032000);
> +	}
> +#endif
> +}

Same comment as above but for L3CR

 .../...

> +/*
> + * Fix IDE interrupts.
> + */
> +static int __init
> +sandpoint_fix_winbond_83553(void)
> +{
> +	/* Make some 8259 interrupt level sensitive */
> +	outb(0xe0, 0x4d0);
> +	outb(0xde, 0x4d1);
> +
> +	return 0;
> +}
> +
> +arch_initcall(sandpoint_fix_winbond_83553);
> +
> +/*
> + * Initialize the ISA devices on the Nat'l PC87308VUL SuperIO chip.
> + */
> +static int __init
> +sandpoint_setup_natl_87308(void)
> +{
> +	u_char	reg;
> +
> +	/*
> +	 * Enable all the devices on the Super I/O chip.
> +	 */
> +	SANDPOINT_87308_SELECT_DEV(0x00); /* Select kbd logical device */
> +	SANDPOINT_87308_CFG_OUTB(0xf0, 0x00); /* Set KBC clock to 8 Mhz */
> +	SANDPOINT_87308_DEV_ENABLE(0x00); /* Enable keyboard */
> +	SANDPOINT_87308_DEV_ENABLE(0x01); /* Enable mouse */
> +	SANDPOINT_87308_DEV_ENABLE(0x02); /* Enable rtc */
> +	SANDPOINT_87308_DEV_ENABLE(0x03); /* Enable fdc (floppy) */
> +	SANDPOINT_87308_DEV_ENABLE(0x04); /* Enable parallel */
> +	SANDPOINT_87308_DEV_ENABLE(0x05); /* Enable UART 2 */
> +	SANDPOINT_87308_CFG_OUTB(0xf0, 0x82); /* Enable bank select regs */
> +	SANDPOINT_87308_DEV_ENABLE(0x06); /* Enable UART 1 */
> +	SANDPOINT_87308_CFG_OUTB(0xf0, 0x82); /* Enable bank select regs */
> +
> +	/* Set up floppy in PS/2 mode */
> +	outb(0x09, SIO_CONFIG_RA);
> +	reg = inb(SIO_CONFIG_RD);
> +	reg = (reg & 0x3F) | 0x40;
> +	outb(reg, SIO_CONFIG_RD);
> +	outb(reg, SIO_CONFIG_RD);	/* Have to write twice to change! */
> +
> +	return 0;
> +}

Looks like zImage wrapper work to me... Unless we ever get booted by a
firmware that both provides a flat DT and doesn't do the above....

Ok, I'm not _ABSOLUTELY_ trying to remove the need for a myboar.c file
here ... but it might be worth doing something generic enough so that
it's either reduced to the strict minimum in many cases _or_ made
completely unnecessary if we can...
 
> +arch_initcall(sandpoint_setup_natl_87308);
> +
> +static int __init
> +sandpoint_request_io(void)
> +{
> +	request_region(0x00,0x20,"dma1");
> +	request_region(0x20,0x20,"pic1");
> +	request_region(0x40,0x20,"timer");
> +	request_region(0x80,0x10,"dma page reg");
> +	request_region(0xa0,0x20,"pic2");
> +	request_region(0xc0,0x20,"dma2");
> +
> +	return 0;
> +}

The above has to go... not sure yet what is the best way but it's just a
pain... Could be made dependent on the OFDT too

> +arch_initcall(sandpoint_request_io);
> +#endif
> +
> +static void __init
> +sandpoint_map_io(void)
> +{
> +	io_block_mapping(0xfe000000, 0xfe000000, 0x02000000, _PAGE_IO);
> +}

To kill absolutely. What is it there for ? At the very least, make
io_block_mapping allocate virtual space as discussed earlier. I'd like
to keep BATs for RAM anyway

> +static void
> +sandpoint_restart(char *cmd)
> +{
> +	local_irq_disable();
> +
> +	/* Set exception prefix high - to the firmware */
> +	_nmask_and_or_msr(0, MSR_IP);
> +
> +	/* Reset system via Port 92 */
> +	outb(0x00, 0x92);
> +	outb(0x01, 0x92);
> +
> +	for(;;);	/* Spin until reset happens */
> +}

The above is fairly common. (Or variations of it). In the context of a
"generic" board, we could imagine having a list of known "reboot
methods" and have a DT node indicating which one to use...

> +static void
> +sandpoint_power_off(void)
> +{
> +	local_irq_disable();
> +	for(;;);	/* No way to shut power off with software */
> +	/* NOTREACHED */
> +}

The above is _VERY_ commmon :) probably worth just not having a callback
in ppc_md. at all...

> +static void
> +sandpoint_halt(void)
> +{
> +	sandpoint_power_off();
> +	/* NOTREACHED */
> +}

Same comment as before.

> +static void
> +sandpoint_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: Freescale\n");
> +	seq_printf(m, "machine\t\t: Sandpoint\n");
> +}

Do we need that ? We could define standard DT properties that get
printed in cpuinfo and have that in setup-common.c ...

 .../... (commented out IDE code)

This is a windbond ? Can't it just be probed/detected using normal PCI
probing ?

> +
> +/*
> + * Set BAT 3 to map 0xf8000000 to end of physical memory space 1-to-1.
> + */
> +static __inline__ void
> +sandpoint_set_bat(void)
> +{
> +	unsigned long bat3u, bat3l;
> +
> +	__asm__ __volatile__(
> +			" lis %0,0xf800\n	\
> +			ori %1,%0,0x002a\n	\
> +			ori %0,%0,0x0ffe\n	\
> +			mtspr 0x21e,%0\n	\
> +			mtspr 0x21f,%1\n	\
> +			isync\n			\
> +			sync "
> +			: "=r" (bat3u), "=r" (bat3l));
> +}

WTF ?

> +TODC_ALLOC();
> +
> +static int __init
> +sandpoint_probe(void)
> +{
> +	return 1;
> +}

WTF (bis) ? :)

> +define_machine(sandpoint) {
> +	.name			= "Sandpoint",
> +	.probe			= sandpoint_probe,
> +	.setup_arch		= sandpoint_setup_arch,
> +	.setup_io_mappings	= sandpoint_map_io,
> +	.init_IRQ		= sandpoint_init_IRQ,
> +	.show_cpuinfo		= sandpoint_show_cpuinfo,
> +	.get_irq		= mpic_get_irq,
> +	.restart		= sandpoint_restart,
> +	.power_off		= sandpoint_power_off,
> +	.halt			= sandpoint_halt,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	/*
> +	.progress		= udbg_progress,
> +	*/
> +};

So on the TODO list, replace as much as we can of the above with
generic_* equivalents until nothing remains :)
 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 7dcdfcb..1badbec 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -629,6 +629,13 @@ #endif /* CONFIG_SMP */
>  			mb();
>  	}
>  
> +#ifdef CONFIG_MPIC_SERIAL
> +	/* For serial interrupts & set clock ratio */
> +	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
> +		mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
> +			| (1<<27) | (0x7<<28));
> +#endif

This should not be an #ifdef.... this should be an MPIC init flag passed
when initializing it. (and if we do generic device-tree instanciation of
PIC's, we could define standard properties to put in the MPIC node to
enable those flags).

Keep up the good work ! :)

Cheers,
Ben.
