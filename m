Return-Path: <meador_inge@mentor.com>
Message-ID: <4DFB5B74.3050808@mentor.com>
Date: Fri, 17 Jun 2011 08:49:40 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [openmcapi-dev] Re: [PATCH v3 2/2] powerpc: add support for MPIC
	message register API
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>	
	<1306869543-18812-3-git-send-email-meador_inge@mentor.com>
	<1308288784.32158.30.camel@pasglop>
In-Reply-To: <1308288784.32158.30.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2011 12:33 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-05-31 at 14:19 -0500, Meador Inge wrote:
>> Some MPIC implementations contain one or more blocks of message registers
>> that are used to send messages between cores via IPIs.  A simple API has
>> been added to access (get/put, read, write, etc ...) these message registers.
>> The available message registers are initially discovered via nodes in the
>> device tree.  A separate commit contains a binding for the message register
>> nodes.
> 
> Ok, so I finally got to look at that in a bit more details...
>> +#ifndef _ASM_MPIC_MSGR_H
>> +#define _ASM_MPIC_MSGR_H
>> +
>> +#include <linux/types.h>
>> +
>> +struct mpic_msgr {
>> +	u32 __iomem *addr;
>> +	u32 __iomem *mer;
>> +	u32 __iomem	*msr;
>> +	int irq;
>> +	atomic_t in_use;
>> +	int num;
>> +};
> 
> General comment... I'm really not fan of "msgr", I'd rather see
> "mpic_message_*", it's a tad more verbose but looks a lot better, no ?

It reads a little better.  I got 'msgr' from the HW manual.  Also, 'msgr'
is used in the device tree and file names too.  So I would like to use
'msgr' or 'message' everywhere.  I am OK with 'msgr'.

> Also do you need those 3 iomem pointers ? Not just one with fixed
> offsets ? Or do they come from vastly different sources ?

I can drop the 'msr' field as it is not used anymore.  I wouldn't say the
others are vastly different, but they are not right next to each other.  On the
MPC8572DS, for example, there is one MER for every message register block.  The
first block starts at offset 0x1400 (MSGR1), 0x1410 (MSGR2), 0x1420 (MSGR2),
0x1430 (MSGR3).  So you could do the math to get the MER from the MSGR.

> atomic_t in_use looks fishy, but let's see how you use it...
> 
>> +extern struct mpic_msgr* mpic_msgr_get(unsigned int reg_num);
>> +extern void mpic_msgr_put(struct mpic_msgr* msgr);
>> +extern void mpic_msgr_enable(struct mpic_msgr *msgr);
>> +extern void mpic_msgr_disable(struct mpic_msgr *msgr);
>> +extern void mpic_msgr_write(struct mpic_msgr *msgr, u32 message);
>> +extern u32 mpic_msgr_read(struct mpic_msgr *msgr);
>> +extern void mpic_msgr_clear(struct mpic_msgr *msgr);
>> +extern void mpic_msgr_set_destination(struct mpic_msgr *msgr, u32 cpu_num);
>> +extern int mpic_msgr_get_irq(struct mpic_msgr *msgr);
> 
> Documentation of the API please.

Will do.

>> +#endif
>> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
>> index f7b0772..4d65593 100644
>> --- a/arch/powerpc/platforms/Kconfig
>> +++ b/arch/powerpc/platforms/Kconfig
>> @@ -78,6 +78,14 @@ config MPIC_WEIRD
>>  	bool
>>  	default n
>>  
>> +config MPIC_MSGR
>> +	bool "MPIC message register support"
>> +	depends on MPIC
>> +	default n
>> +	help
>> +	  Enables support for the MPIC message registers.  These
>> +	  registers are used for inter-processor communication.
>> +
>>  config PPC_I8259
>>  	bool
>>  	default n
>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
>> index 1e0c933..6d40185 100644
>> --- a/arch/powerpc/sysdev/Makefile
>> +++ b/arch/powerpc/sysdev/Makefile
>> @@ -3,7 +3,8 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>>  ccflags-$(CONFIG_PPC64)		:= -mno-minimal-toc
>>  
>>  mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
>> -obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
>> +mpic-msgr-obj-$(CONFIG_MPIC_MSGR)	+= mpic_msgr.o
>> +obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y) $(mpic-msgr-obj-y)
>>  fsl-msi-obj-$(CONFIG_PCI_MSI)	+= fsl_msi.o
>>  obj-$(CONFIG_PPC_MSI_BITMAP)	+= msi_bitmap.o
>>  
>> diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
>> new file mode 100644
>> index 0000000..bfa0612
>> --- /dev/null
>> +++ b/arch/powerpc/sysdev/mpic_msgr.c
>> @@ -0,0 +1,279 @@
>> +/*
>> + * Copyright 2011-2012, Meador Inge, Mentor Graphics Corporation.
>> + *
>> + * Some ideas based on un-pushed work done by Vivek Mahajan, Jason Jin, and
>> + * Mingkai Hu from Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; version 2 of the
>> + * License.
>> + *
>> + */
>> +
>> +#include <linux/list.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/errno.h>
>> +#include <asm/prom.h>
>> +#include <asm/hw_irq.h>
>> +#include <asm/ppc-pci.h>
>> +#include <asm/mpic_msgr.h>
>> +
>> +#define MPIC_MSGR_REGISTERS_PER_BLOCK 4
>> +#define MSGR_INUSE 0
>> +#define MSGR_FREE 1
>> +
>> +/* Internal structure used *only* for IO mapping register blocks. */
>> +struct mpic_msgr_block {
>> +	struct msgr {
>> +		u32 msgr;
>> +		u8 res[12];
>> +	} msgrs[MPIC_MSGR_REGISTERS_PER_BLOCK];
>> +	u8 res0[192];
>> +	u32 mer;
>> +	u8 res1[12];
>> +	u32 msr;
>> +};
> 
> So this represent HW registers ? Please make it clear in the comment.
> I'm not a terrible fan of using structures to map HW especially with so
> few registers.

Yes, HW registers.  I will change the comment.

>> +	if (atomic_cmpxchg(&msgr->in_use, MSGR_FREE, MSGR_INUSE) == MSGR_FREE)
>> +		return msgr;
>> +
>> +	return ERR_PTR(-EBUSY);
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_get);
> 
> So how are those things intended to be used ? Clients get a fixed
> "register" number to use ? It looks like this stuff would have been
> better off using some kind of allocator no ? A bitmap would have done
> the job... or do you really need to have some kind of fixed numbering
> associated with clients ?

A fixed numbering scheme really is needed.  We are using these registers
to communicate b/w different kernels in an AMP system.  In order
to do this each kernel has to be using the same numbering so that they
can communicate.

>> +void mpic_msgr_put(struct mpic_msgr* msgr)
>> +{
>> +	atomic_set(&msgr->in_use, MSGR_FREE);
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_put);
> 
> Shouldn't it be disabled too while at it ?

Yes.

>> +void mpic_msgr_enable(struct mpic_msgr *msgr)
>> +{
>> +	out_be32(msgr->mer, in_be32(msgr->mer) | (1 << msgr->num));
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_enable);
> 
> Why are all those exported non-GPL ? We have a policy of making new
> in-kernel APIs generally GPL only.

Oversight on my part, I will fix it.

>> +void mpic_msgr_disable(struct mpic_msgr *msgr)
>> +{
>> +	out_be32(msgr->mer, in_be32(msgr->mer) & ~(1 << msgr->num));
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_disable);
> 
> I see read-modify-write cycles here with no synchronization/locking
> whatsoever... Might be ok as long as you document it in the doc of the
> API, ie, the caller is required to synchronize.

I will add locking.

>> +void mpic_msgr_write(struct mpic_msgr *msgr, u32 message)
>> +{
>> +	out_be32(msgr->addr, message);
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_write);
>> +
>> +u32 mpic_msgr_read(struct mpic_msgr *msgr)
>> +{
>> +	return in_be32(msgr->addr);
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_read);
> 
> Those look like significant bloat/overhead for what is just an MMIO
> wrapper on a register access, why not make them static inline's
> instead ?

I will make them 'static inline'.

>> +int mpic_msgr_get_irq(struct mpic_msgr *msgr)
>> +{
>> +	return msgr->irq;
>> +}
>> +EXPORT_SYMBOL(mpic_msgr_get_irq);
>> +
>> +/* The following three functions are used to compute the order and number of
>> + * the message register blocks.  They are clearly very inefficent.  However,
>> + * they are called *only* a few times during device initialization.
>> + */
>> +static unsigned int mpic_msgr_number_of_blocks(void)
>> +{
>> +	unsigned int count;
>> +	struct device_node *aliases;
>> +
>> +	count = 0;
>> +	aliases = of_find_node_by_name(NULL, "aliases");
>> +
>> +	if (aliases) {
>> +		char buf[32];
>> +
>> +		for (;;) {
>> +			snprintf(buf, sizeof(buf), "mpic-msgr-block%d", count);
>> +			if (!of_find_property(aliases, buf, NULL))
>> +				break;
>> +
>> +			count += 1;
>> +		}
>> +	}
>> +
>> +	return count;
>> +}
> 
> I don't like relying on aliases as a way to figure out what HW is
> present, that's not right. You should find the actual devices themselves
> based on their compatible properties.

In this case, the device is a block of message registers.  These are found by
probing the compatible properties.  However, once a _block_ is found the
register within it are numbered using the found aliases.  This is
due to the need for a fixed number scheme as mentioned previously.

Why a fixed numbering scheme is needed is always this first question about this
patch.  So, I should add a comment explaining all of this in the implementation.

> Ok, so we have another scheme of:
> 
>  - Count all devices in the system of a given type
>  - Assign them numbers
>  - API uses number
> 
> That sucks... unless you have an allocator. And even then.
> 
> I'd rather clients use something like struct mpic_msgr (or msg_reg or
> message_reg) as the "handle" to one of these things.

Most of the APIs *do* use a 'mpic_msgr' handle.  The only one that doesn't
is 'mpic_msgr_get', which takes the register number to retrieve.  We discussed
in the beginning having an allocator, but it didn't fit well with the AMP use
case we are working on.  There was a recent discussion on how a dynamic
allocator could be added in addition to the static one in PATCH v0:
http://patchwork.ozlabs.org/patch/92037/.

Thanks a lot for the review Ben.  Much appreciated.

-- 
Meador Inge
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software
