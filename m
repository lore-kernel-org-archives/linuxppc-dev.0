Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 39C1E679F6
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:50:04 +1100 (EST)
Date: Fri, 31 Mar 2006 16:48:58 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 2/2] Base pSeries PCIe support
Message-ID: <20060331224858.GC952@pb15.lixom.net>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331161330.3c723103.moilanen@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060331161330.3c723103.moilanen@austin.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 31, 2006 at 04:13:30PM -0600, Jake Moilanen wrote:
> This patch hooks our current interrupt subsystem and sets up a single
> vector MSI as if it was a LSI.  Multiple MSI vectors is coming in the
> future.
> 
> The NR_IRQS got bumped up to 1024, as vectors can go much higher.
> Unfortunately, this number was arbitrarily picked as there is no claim
> at what the max number really is by either the firmware team, or the
> PAPR+.

What does this do to the kernel size?

> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
> 
> ---
> 
> Index: 2.6.16/arch/powerpc/kernel/prom.c
> ===================================================================
> --- 2.6.16.orig/arch/powerpc/kernel/prom.c	2006-03-31 15:11:20.000000000 -0600
> +++ 2.6.16/arch/powerpc/kernel/prom.c	2006-03-31 15:37:10.000000000 -0600
> @@ -88,6 +88,8 @@
>  struct device_node *dflt_interrupt_controller;
>  int num_interrupt_controllers;
>  
> +void __init finish_msi_node(struct device_node *dn, unsigned long *mem_start, int measure_only);

The other one is called "finish_node_interrupts", "finish_node_msi"
would make sense here.

> +
>  /*
>   * Wrapper for allocating memory for various data that needs to be
>   * attached to device nodes as they are processed at boot or when
> @@ -120,6 +122,22 @@
>  	return NULL;
>  }
>  
> +int
> +property_present(struct device_node *np, const char *name)
> +{
> +	struct property *pp;
> +
> +	read_lock(&devtree_lock);
> +	for (pp = np->properties; pp != 0; pp = pp->next)
> +		if (strcmp(pp->name, name) == 0) {
> +			return 1;
> +		}
> +	read_unlock(&devtree_lock);
> +
> +	return 0;
> +}

Please use of_find_property() instead of reimplementing it, i.e. do what
get_property() does now, just don't return the value.

I assume you can't use get_property() because the properties you look
for lack values, right?

> +
>  /*
>   * Find the interrupt parent of a node.
>   */
> @@ -341,6 +359,14 @@
>  		return 0;
>  	}
>  
> +#ifdef CONFIG_PPC_PSERIES
> +	if(property_present(np, "ibm,req#msi")) {
> +		printk(KERN_EMERG "Found MSI\n");

KERN_DEBUG, if anything, right?

Also, get rid of the ifdef.

> +		finish_msi_node(np, mem_start, measure_only);
> +		return 0;
> +	}
> +#endif
> +
>  	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
>  	TRACE("ints=%p, intlen=%d\n", ints, intlen);
>  	if (ints == NULL)
> @@ -503,6 +529,80 @@
>  	DBG(" <- finish_device_tree\n");
>  }
>  
> +void __init finish_msi_node(struct device_node *dn, unsigned long *mem_start, int measure_only)

I know you said no hotplug support yet, but in preparation, it might
make sense to mark it as __devinit instead.

> +{
> +	static int seq_num = 1;
> +	int i;
> +	int rc;
> +	int query_token = rtas_token("ibm,query-interrupt-source-number");
> +	int devfn;
> +	int busno;
> +	u32 *reg;
> +	int reglen;
> +	int ret[3];
> +	unsigned int virq;
> +	unsigned int addr;
> +	unsigned long buid = -1;
> +	unsigned long wait_time;
> +
> +	reg = (u32 *) get_property(dn, "reg", &reglen);
> +	if (reg == NULL || reglen < 20)
> +		return;
> +
> +	devfn = (reg[0] >> 8) & 0xff;
> +	busno = (reg[0] >> 16) & 0xff;
> +
> +	buid = get_phb_buid(dn->parent);
> +	addr = (busno << 16) | (devfn << 8);
> +
> +	while (1) {
> +		rc = rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
> +			       buid >> 32, buid & 0xffffffff,
> +			       1, 1, seq_num);
> +
> +		if (!rc)
> +			break;
> +		else if (rc == RTAS_BUSY)
> +			udelay(1);
> +		else if (rtas_is_extended_busy(rc)) {
> +			wait_time = rtas_extended_busy_delay_time(rc);
> +			udelay(wait_time * 1000);
> +		} else {
> +			printk(KERN_WARNING "error[%d]: getting the number of"
> +			       "MSI interrupts for %s\n", rc, dn->name);
> +			return;
> +		}

This is reimplemented with a few variations in a few places now. They
should be consolidated into a single function that will handle the
delay itself.

> +
> +		seq_num = ret[1];
> +	}
> +
> +	dn->n_intrs = ret[0];
> +
> +	dn->intrs = prom_alloc(dn->n_intrs * sizeof(*(dn->intrs)), mem_start);
> +	if (!dn->intrs) {
> +		printk(KERN_EMERG "finish_msi_node: can't allocate space\n");
> +		return;
> +	}
> +
> +	if (measure_only)
> +		return;

You probably want to return from measure_only _before_ you allocate and
populate intrs...

> +
> +	for (i = 0; i < dn->n_intrs; i++) {
> +		rc = rtas_call(query_token, 4, 3, ret, addr, buid >> 32, buid & 0xffffffff, i);
> +
> +		if (!rc) {
> +			virq = virt_irq_create_mapping(ret[0]);
> +
> +			dn->intrs[i].line = irq_offset_up(virq);
> +			dn->intrs[i].sense = ret[1];
> +		} else {
> +			printk(KERN_WARNING "error[%d]: query-interrupt-source-number for %s\n",
> +			       rc, dn->name);
> +		}
> +	}
> +
> +}
> +
>  static inline char *find_flat_dt_string(u32 offset)
>  {
>  	return ((char *)initial_boot_params) +
> Index: 2.6.16/include/asm-powerpc/irq.h
> ===================================================================
> --- 2.6.16.orig/include/asm-powerpc/irq.h	2006-03-31 15:11:12.000000000 -0600
> +++ 2.6.16/include/asm-powerpc/irq.h	2006-03-31 15:15:46.000000000 -0600
> @@ -47,7 +47,7 @@
>  /*
>   * Maximum number of interrupt sources that we can handle.
>   */
> -#define NR_IRQS		512
> +#define NR_IRQS		1024
>  
>  /* Interrupt numbers are virtual in case they are sparsely
>   * distributed by the hardware.
> Index: 2.6.16/include/asm-powerpc/pci-bridge.h
> ===================================================================
> --- 2.6.16.orig/include/asm-powerpc/pci-bridge.h	2006-03-31 15:11:36.000000000 -0600
> +++ 2.6.16/include/asm-powerpc/pci-bridge.h	2006-03-31 15:34:50.000000000 -0600
> @@ -141,6 +141,7 @@
>  void pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus);
>  
>  extern int pcibios_remove_root_bus(struct pci_controller *phb);
> +extern unsigned long __devinit get_phb_buid (struct device_node *phb);

I think the get_phb_buid() call from prom.c might break 32-bit, since
rtas_pci.c isn't always built there.  An empty declaration here for
#ifndef CONFIG_<x> would take care of it.

>  
>  static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
>  {
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
