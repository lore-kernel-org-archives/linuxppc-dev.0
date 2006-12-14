Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4720A67CAC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:52:25 +1100 (EST)
Date: Thu, 14 Dec 2006 10:52:17 +0900 (JST)
Message-Id: <200612140152.kBE1qIh7011979@toshiba.co.jp>
To: geoffrey.levand@am.sony.com
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
In-Reply-To: <457EE633.2070208@am.sony.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Geoff-san,

Thanks for your comments.
Many of files in celleb/ directory are copy-and-modified from that of
pseries/ directory, so you can found many similarities in our code.

> Ishizaki Kou wrote:
> > This patch adds base support for Celleb platform.
> > +++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile	Mon Dec 11 18:11:35 2006
> > @@ -0,0 +1,10 @@
> > +obj-$(CONFIG_PPC_CELLEB)		+= interrupt.o iommu.o setup.o \
> > +								          lpar.o beat.o pci.o \
> > +												   scc_epci.o scc_uhc.o
> > +

> I think this can just be obj-y, since this makefile is only used when CONFIG_PPC_CELLEB=y

> > +ifeq ($(CONFIG_SMP),y)
> > +obj-$(CONFIG_PPC_CELLEB)		+= smp.o
> > +endif

> Can't this just be obj-$(CONFIG_SMP) += smp.o, again, since CONFIG_PPC_CELLEB=y here?

> > +spu-priv1-$(CONFIG_PPC_CELLEB)	  += spu_priv1.o spu_manage.o
> > +obj-$(CONFIG_SPU_BASE)				 += $(spu-priv1-y)

> Again, can't this be obj-$(CONFIG_SPU_BASE) += spu_priv1.o spu_manage.o?

These points will be corrected, thank you.

> > +}
> > +
> > +#if 0
> > +/* returns 0 if couldn't find or use /chosen/stdout as console */
> > +void __init celleb_find_udbg_vterm(void)
> ...


> Why is this dead code in here?  If this is broken, it should go into
> another patch to be submitted later.  If it is for debugging, this
> should be reworked so that the usage is more clear.

Simply it's forgotten to remove. These codes will be removed at next time.

> > +static inline unsigned int beat_read_mask(unsigned hpte_group)
> > +{
> > +	unsigned long hpte_v0, hpte_v1, hpte_v2, hpte_v3, hpte_perms;
> > +	unsigned long rmask = 0;
> > +
> > +	beat_read_htab_entries(0, hpte_group + 0,
> > +				  &hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
> > +				  if (!(hpte_v0 & HPTE_V_BOLTED))
> > +				     rmask |= 0x8000;
> > +				     if (!(hpte_v1 & HPTE_V_BOLTED))
> > +					rmask |= 0x4000;
> > +					if (!(hpte_v2 & HPTE_V_BOLTED))
> > +					   rmask |= 0x2000;
> > +					   if (!(hpte_v3 & HPTE_V_BOLTED))
> > +					      rmask |= 0x1000;
> > +					      beat_read_htab_entries(0, hpte_group + 4,
> > +									&hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
> > +									if (!(hpte_v0 & HPTE_V_BOLTED))
> > +									   rmask |= 0x0800;
> > +									   if (!(hpte_v1 & HPTE_V_BOLTED))
> > +									      rmask |= 0x0400;
> > +									      if (!(hpte_v2 & HPTE_V_BOLTED))
> > +										 rmask |= 0x0200;
> > +										 if (!(hpte_v3 & HPTE_V_BOLTED))
> > +										    rmask |= 0x0100;
> > +										    hpte_group = ~hpte_group & (htab_hash_mask * HPTES_PER_GROUP);
> > +										    beat_read_htab_entries(0, hpte_group + 0,
> > +													      &hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
> > +													      if (!(hpte_v0 & HPTE_V_BOLTED))
> > +														 rmask |= 0x80;
> > +														 if (!(hpte_v1 & HPTE_V_BOLTED))
> > +														    rmask |= 0x40;
> > +														    if (!(hpte_v2 & HPTE_V_BOLTED))
> > +														       rmask |= 0x20;
> > +														       if (!(hpte_v3 & HPTE_V_BOLTED))
> > +															  rmask |= 0x10;
> > +															  beat_read_htab_entries(0, hpte_group + 4,
> > +																		    &hpte_v0, &hpte_v1, &hpte_v2, &hpte_v3, &hpte_perms);
> > +																		    if (!(hpte_v0 & HPTE_V_BOLTED))
> > +																		       rmask |= 0x08;
> > +																		       if (!(hpte_v1 & HPTE_V_BOLTED))
> > +																			  rmask |= 0x04;
> > +																			  if (!(hpte_v2 & HPTE_V_BOLTED))
> > +																			     rmask |= 0x02;
> > +																			     if (!(hpte_v3 & HPTE_V_BOLTED))
> > +																				rmask |= 0x01;
> > +																				return rmask;
> > +}


> These pagetable routines need to go into a separate file, I think this
> request was made the last time this patch was posted.

New file will be created at next patch.
 
> > Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
> > diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.3
> > --- /dev/null     Mon Dec 11 20:37:31 2006
> > +++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Mon Dec 11 19:55:10 2006
> > @@ -0,0 +1,314 @@
> > +/*
> > + * Celleb setup code
> > + *
> > + * (C) Copyright 2006 TOSHIBA CORPORATION
> > + *
> > + * This code is based on arch/powerpc/platforms/cell/setup.c:
> > + *  Copyright (C) 1995  Linus Torvalds
> > + *  Adapted from 'alpha' version by Gary Thomas
> > + *  Modified by Cort Dougan (cort@cs.nmt.edu)
> > + *  Modified by PPC64 Team, IBM Corp
> > + *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#undef DEBUG


> This should be removed so that DEBUG can be set via the build system.  I saw
> this in a few other files also.

We think that this CPP symbol "DEBUG" is not for product,
just for debugging lower layer in the kernel.

> > +static int celleb_pci_probe_mode(struct pci_bus *bus){
> > +
> > +	struct device_node *node;
> > +	const char *name;
> > +
> > +	node = (struct device_node *)bus->sysdata;
> > +	name = get_property(node, "name", NULL);
> > +
> > +	if (strcmp(name, "pci-pseudo") == 0)
> > +	   return PCI_PROBE_DEVTREE;
> > +
> > +	return PCI_PROBE_NORMAL;
> > +}
> > +
> > +static void celleb_kexec_cpu_down(int crash, int secondary)
> > +{
> > +	extern void	beatic_deinit_IRQ(void);
> > +
> > +	beatic_deinit_IRQ();
> > +}
> > +
> > +#ifdef CONFIG_SERIAL_TXX9
> > +/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
> > +    mmio=0xfff000-0x1000,0xff2000-0x1000 */
> > +static int txx9_serial_bitmap = 0;
> > +
> > +static struct {
> > +	    uint32_t offset;
> > +	    uint32_t index;
> > +} txx9_spider_tab[3] = {
> > +  { 0x300, 0 },	  /* 0xFFF300 */
> > +  { 0x400, 0 },	  /* 0xFFF400 */
> > +  { 0x800, 1 }	  /* 0xFF2800 */
> > +};

> Setup.c is not the proper place for these PCI and serial UART
> device routines.

On PCI bus, it was moved to celleb/pci.c. On serial port, we created
new file.

> There is already a Linux driver for the txx9_serial, why did you create
> another one here?  Why can't you re-use the existing txx9_serial driver,
> or rework it to support this platform?

Code stays in celleb/setup.c is not a driver, but a registerer.
The SIO has no proper properties in our device-tree, so we have
to hard-code to register the SIO block in SCC.

> > Index: linux-powerpc-git/include/asm-powerpc/mmu.h
> > diff -u linux-powerpc-git/include/asm-powerpc/mmu.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/mmu.h:1.2
> > --- linux-powerpc-git/include/asm-powerpc/mmu.h:1.1.1.1	Wed Dec  6 08:24:04 2006
> > +++ linux-powerpc-git/include/asm-powerpc/mmu.h		Wed Dec  6 08:43:16 2006
> > @@ -247,6 +247,7 @@
> >  extern void hpte_init_native(void);
> >  extern void hpte_init_lpar(void);
> >  extern void hpte_init_iSeries(void);
> > +extern void hpte_init_beat(void);
> >  
> >  extern void stabs_alloc(void);
> >  extern void slb_initialize(void);
> > Index: linux-powerpc-git/include/asm-powerpc/smp.h
> > diff -u linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/smp.h:1.2
> > --- linux-powerpc-git/include/asm-powerpc/smp.h:1.1.1.1	Wed Dec  6 08:24:04 2006
> > +++ linux-powerpc-git/include/asm-powerpc/smp.h		Wed Dec  6 08:43:16 2006
> > @@ -75,6 +75,7 @@
> >  void smp_init_iSeries(void);
> >  void smp_init_pSeries(void);
> >  void smp_init_cell(void);
> > +void smp_init_celleb(void);
> >  void smp_setup_cpu_maps(void);

> Since these routines are defined and used all inside in arch/powerpc/platforms/celleb, these
> declarations should go into a header file in that directory.

Older Linux code uses hpte_init_* code in generic space,
so we inserted these extern function declaration at shared header
file. I think these declarations will be decay in long term.

Best regards,
Kou Ishizaki
