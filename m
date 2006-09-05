Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id EF8F467A3A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 07:49:42 +1000 (EST)
Date: Tue, 5 Sep 2006 16:48:55 -0500
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [4/5] powerpc: PA Semi PWRficient platform support
Message-ID: <20060905164855.3c4a73da@localhost.localdomain>
In-Reply-To: <200609052337.11557.arnd@arndb.de>
References: <20060904175742.5472a6fa@localhost.localdomain>
	<20060905122956.2cebd36d@localhost.localdomain>
	<200609052337.11557.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 5 Sep 2006 23:37:10 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 05 September 2006 19:29, Olof Johansson wrote:
> > Base patch for PA6T and PA6T-1682M. This introduces the
> > arch/powerpc/platform/pasemi directory, together with basic
> > implementations for various setup.
> > 
> > Much of this was based on other platform code, i.e. Maple, etc.
>  
> Very nice patch set, as expected ;-)
> 
> See below for the mandatory nitpicking.

Thanks Arnd, good feedback, see some comments below.

> 
> 
> > Index: merge/arch/powerpc/Kconfig
> > ===================================================================
> > --- merge.orig/arch/powerpc/Kconfig
> > +++ merge/arch/powerpc/Kconfig
> > @@ -413,6 +409,17 @@ config PPC_MAPLE
> >            This option enables support for the Maple 970FX Evaluation Board.
> >  	  For more informations, refer to <http://www.970eval.com>
> >  
> > +config PPC_PASEMI
> > +	depends on PPC_MULTIPLATFORM && PPC64
> > +	bool "PA Semi SoC-based platforms"
> > +	default n
> > +	select MPIC
> > +	select PPC_UDBG_16550
> > +	select GENERIC_TBSYNC
> > +	help
> > +	  This option enables support for PA Semi's PWRficient line
> > +	  of SoC processors, including PA6T-1682M
> 
> IIRC, the GENERIC_TBSYNC code is really inefficient. Don't you
> have any other way of implementing that?

Yes, we do. It'll be submitted in a later patch for various reasons. We'll use 
the generic sync for now.

> > +
> > +#undef DEBUG
> > +
> 
> I know that this is done in other places as well, but it seems
> rather pointless, and it provides setting DEBUG from EXTRA_CFLAGS
> in the Makefile.

Yes, mostly leftovers from older debug code. I've taken a few out already, 
will go through and take care of the rest.

> > +static struct pci_ops pa_pxp_ops =
> > +{
> > +	pa_pxp_read_config,
> > +	pa_pxp_write_config
> > +};
> 
> spacing: '{' after '=', and ',' after the final member.
> 
> > +
> > +static void __init setup_pa_pxp(struct pci_controller* hose)
> > +{
> > +	hose->ops = &pa_pxp_ops;
> > +	hose->cfg_data = ioremap(0xe0000000, 0x1000000);
> > +}
> 
> Shouldn't that be in the device tree?

I was torn between using device tree and hardcoded values here, and went with 
hardcoded since that's what maple uses. They're not movable on the chip, but 
for future versions I guess device tree makes more sense (if it for some 
reason will move).

> 
> > +	bus_range = (int *) get_property(dev, "bus-range", &len);
> 
> Unneeded cast
> 
> > +	if (bus_range == NULL || len < 2 * sizeof(int)) {
> > +		printk(KERN_WARNING "Can't get bus-range for %s, assume bus 0\n",
> > +		dev->full_name);
> > +	}
> 
> if (!bus_range || len < 2 * sizeof(int)) {
> 
> > +
> > +	hose = pcibios_alloc_controller(dev);
> > +	if (hose == NULL)
> > +		return -ENOMEM;
> 
> if (!hose)
> 
> > +	if (root == NULL) {
> 
> if (!root)
> > +#undef DEBUG
> 
> remove
> 
> > +extern int pas_set_rtc_time(struct rtc_time *tm);
> > +extern void pas_get_rtc_time(struct rtc_time *tm);
> > +extern unsigned long pas_get_boot_time(void);
> > +extern void pas_pci_init(void);
> > +extern void pas_pcibios_fixup(void);
> 
> Extern declarations should never be in a source file, please
> move them to a header
> 
> > +static void iommu_dev_setup_null(struct pci_dev *dev) { }
> > +static void iommu_bus_setup_null(struct pci_bus *bus) { }
> > +
> > +static void __init pas_init_early(void)
> > +{
> > +	/* No iommu code yet */
> > +	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
> > +	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
> > +	pci_direct_iommu_init();
> > +}
> > +
> > +/* No legacy IO on our parts */
> > +static int pas_check_legacy_ioport(unsigned int baseport)
> > +{
> > +	return -ENODEV;
> > +}
> 
> Should we maybe change the default behavior so that you don't need
> to provide nops for these functions?

Good point, most platforms no longer implement this anyway. I'll code that up 
as a separate patch and submit later.

> 
> > +
> > +static __init void pas_init_IRQ(void)
> > +{
> > +	struct device_node *np = NULL;
> > +	struct device_node *root, *mpic_node  = NULL;
> > +	unsigned long openpic_addr = 0;
> 
> These three should not be initialized.
> 
> 
> > +	BUG_ON(mpic == NULL);
> 
> BUG_ON(!mpic);
> 
> > +
> > +#undef DEBUG
> 
> remove
> 
> > +void pas_get_rtc_time(struct rtc_time *tm)
> > +{
> > +}
> > +
> > +int pas_set_rtc_time(struct rtc_time *tm)
> > +{
> > +	return -ENODEV;
> > +}
> 
> again, it probably makes sense to not have to provide these.

Yep, I could take out the #if 0 as well. It's all a big placeholder anyway.


-Olof
