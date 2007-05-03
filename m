Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id A8536DDFE2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 23:46:06 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 3 May 2007 06:45:58 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-ID: <20070503134558.GC7491@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
	<20070502214609.GE27253@xyzzy.farnsworth.org>
	<200705030917.47037.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705030917.47037.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 09:17:46AM +0200, Arnd Bergmann wrote:
> On Wednesday 02 May 2007, Dale Farnsworth wrote:
> 
> > Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
> > ===================================================================
> > --- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile
> > +++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
> > @@ -16,6 +16,10 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
> >  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
> >  obj-$(CONFIG_MV64X60)		+= mv64x60_pic.o mv64x60_dev.o
> >  
> > +ifeq ($(CONFIG_PCI),y)
> > +obj-$(CONFIG_MV64X60)		+= mv64x60_pci.o
> > +endif
> > +
> 
> I'd write this as
> 
> mv64x60-$(CONFIG_INDIRECT_PCI)	+= mv64x60_pci.o
> obj-$(CONFIG_MV64X60)		+= mv64x60-y
> 
> though that doesn't make much difference any more
> 
> > +#ifdef CONFIG_SYSFS
> > +/* 32-bit hex or dec stringified number + '\n' */
> > +#define MV64X60_VAL_LEN_MAX		11
> > +#define MV64X60_PCICFG_CPCI_HOTSWAP	0x68
> > +
> > +DECLARE_MUTEX(mv64x60_hs_lock);
> 
> Please avoid using struct semephores in new code, we now have struct mutex
> for this, which gets defined as
> 
> static DEFINE_MUTEX(mv64x60_hs_mutex);

This is existing code being moved over from arch/ppc. I'll make the change.

> > +static ssize_t mv64x60_hs_reg_read(struct kobject *kobj, char *buf, loff_t off,
> > +				   size_t count)
> > +{
> > +	u32 v;
> > +	int save_exclude;
> > +
> > +	if (off > 0)
> > +		return 0;
> > +	if (count < MV64X60_VAL_LEN_MAX)
> > +		return -EINVAL;
> > +
> > +	if (down_interruptible(&mv64x60_hs_lock))
> > +		return -ERESTARTSYS;
> > +	save_exclude = mv64x60_pci_exclude_bridge;
> > +	mv64x60_pci_exclude_bridge = 0;
> > +	early_read_config_dword(mv64x60_primary_hose, 0, PCI_DEVFN(0, 0),
> > +				MV64X60_PCICFG_CPCI_HOTSWAP, &v);
> 
> Why do you use early_read_config_dword, not pci_read_config_dword()?

As above, this is existing code being moved over from arch/ppc.
I'll make the change.

> > +	mv64x60_pci_exclude_bridge = save_exclude;
> > +	up(&mv64x60_hs_lock);
> > +
> > +	return sprintf(buf, "0x%08x\n", v);
> > +}
> 
> <snip>
> 
> > +static int mv64x60_exclude_device(u_char bus, u_char devfn)
> > +{
> > +       if ((bus == 0 || bus == mv64x60_pci2_busno) &&
> > +           PCI_SLOT(devfn) == 0 && mv64x60_pci_exclude_bridge)
> > +               return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +       return PCIBIOS_SUCCESSFUL;
> > +}
> 
> The locking here looks wrong. If you call mv64x60_exclude_device() from one thread
> thread while another one is calling mv64x60_hs_reg_read(), the bridge will
> not be excluded.

Good catch.  Again, it's existing code, but clearly there's a race here.
I'm guessing that the mutex above was just to prevent nesting of setting
mv64x60_pci_exclude_bridge. A fix for the race doesn't look easy.
I'll look into it.

Thanks,
-Dale
