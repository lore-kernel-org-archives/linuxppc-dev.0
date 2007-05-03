Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7AB4EDE00D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 17:17:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Date: Thu, 3 May 2007 09:17:46 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
	<20070502214609.GE27253@xyzzy.farnsworth.org>
In-Reply-To: <20070502214609.GE27253@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705030917.47037.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 May 2007, Dale Farnsworth wrote:

> Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
> ===================================================================
> --- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile
> +++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
> @@ -16,6 +16,10 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>  obj-$(CONFIG_MV64X60)		+= mv64x60_pic.o mv64x60_dev.o
>  
> +ifeq ($(CONFIG_PCI),y)
> +obj-$(CONFIG_MV64X60)		+= mv64x60_pci.o
> +endif
> +

I'd write this as

mv64x60-$(CONFIG_INDIRECT_PCI)	+= mv64x60_pci.o
obj-$(CONFIG_MV64X60)		+= mv64x60-y

though that doesn't make much difference any more

> +#ifdef CONFIG_SYSFS
> +/* 32-bit hex or dec stringified number + '\n' */
> +#define MV64X60_VAL_LEN_MAX		11
> +#define MV64X60_PCICFG_CPCI_HOTSWAP	0x68
> +
> +DECLARE_MUTEX(mv64x60_hs_lock);

Please avoid using struct semephores in new code, we now have struct mutex
for this, which gets defined as

static DEFINE_MUTEX(mv64x60_hs_mutex);

> +static ssize_t mv64x60_hs_reg_read(struct kobject *kobj, char *buf, loff_t off,
> +				   size_t count)
> +{
> +	u32 v;
> +	int save_exclude;
> +
> +	if (off > 0)
> +		return 0;
> +	if (count < MV64X60_VAL_LEN_MAX)
> +		return -EINVAL;
> +
> +	if (down_interruptible(&mv64x60_hs_lock))
> +		return -ERESTARTSYS;
> +	save_exclude = mv64x60_pci_exclude_bridge;
> +	mv64x60_pci_exclude_bridge = 0;
> +	early_read_config_dword(mv64x60_primary_hose, 0, PCI_DEVFN(0, 0),
> +				MV64X60_PCICFG_CPCI_HOTSWAP, &v);

Why do you use early_read_config_dword, not pci_read_config_dword()?

> +	mv64x60_pci_exclude_bridge = save_exclude;
> +	up(&mv64x60_hs_lock);
> +
> +	return sprintf(buf, "0x%08x\n", v);
> +}

<snip>

> +static int mv64x60_exclude_device(u_char bus, u_char devfn)
> +{
> +       if ((bus == 0 || bus == mv64x60_pci2_busno) &&
> +           PCI_SLOT(devfn) == 0 && mv64x60_pci_exclude_bridge)
> +               return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}

The locking here looks wrong. If you call mv64x60_exclude_device() from one thread
thread while another one is calling mv64x60_hs_reg_read(), the bridge will
not be excluded.

	Arnd <><
