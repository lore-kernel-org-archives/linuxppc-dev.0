Return-Path: <nd@bplan-gmbh.de>
Date: Wed, 1 Nov 2006 10:24:22 +0100 (MET)
Message-ID: <454867AB.2010904@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx
	Interrupt	controller	support	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>	
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>	
	<4546F7DE.6070104@bplan-gmbh.de>	
	<1162280335.25682.302.camel@localhost.localdomain>	
	<4547086D.2050808@bplan-gmbh.de>	
	<1162284176.25682.320.camel@localhost.localdomain>	
	<454712A4.3000501@bplan-gmbh.de> <4547AC30.3090208@bplan-gmbh.de>
	<1162331943.25682.358.camel@localhost.localdomain>
In-Reply-To: <1162331943.25682.358.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------090707090105080304000000"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090707090105080304000000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-31 at 21:04 +0100, Nicolas DET wrote:
> 
>> Here is is ;-).
>> As my mailer can insert a file, I copy paste. I hope it's still ok...
> 
> No, your patch got wrapped. Its damaged. I see you used Thunderbird. I
> have no experience with sending patches with it, so I don't know what
> the trick is to have them undamaged. With evolution, the trick is to use
> the pre-defined style "preformat".
> 

I'll figure uot something...

> Anyway, minor comments, we're getting there...
> 

Everything fixed.


>> +
>> +define_machine(efika)
>> +{
>> +	.name = EFIKA_PLATFORM_NAME,
>> +	.probe = efika_probe,
>> +	.setup_arch = efika_setup_arch,
>> +	.init = efika_init,
>> +	.show_cpuinfo = efika_show_cpuinfo,
>> +	.init_IRQ = efika_init_IRQ,
>> +	.get_irq = mpc52xx_get_irq,
>> +	.restart = rtas_restart,
>> +	.power_off = rtas_power_off,
>> +	.halt = rtas_halt,
>> +	.set_rtc_time = rtas_set_rtc_time,
>> +	.get_rtc_time = rtas_get_rtc_time,
>> +	.progress = rtas_progress,
>> +	.get_boot_time = rtas_get_boot_time,
>> +	.calibrate_decr = generic_calibrate_decr,
>> +	.phys_mem_access_prot = pci_phys_mem_access_prot,
>> +	.pcibios_fixup = efika_pciirq_map,
>> +};
> 
> The later can go away if you apply the patch I posted last week 
> [PATCH] Powerpc:  Make pci_read_irq_line the default: on mpc7448hpc2
> board. First.
> 

Ok.


> 
> The whole function is not needed. Just apply my other patch first.
> 

Compiling...

>> +	default y
>> +
>> +config PPC_EFIKA
>> +	bool "bPlan Efika 5k2. MPC5200B based computer"
>> +	depends on PPC_MULTIPLATFORM && PPC32
>> +	select PPC_RTAS
>> +	select RTAS_PROC
>> +	select PPC_MPC52xx
>> +	select PPC_MPC52xx_PIC
>> +	default y
>> +
>>   config PPC_PMAC
>>   	bool "Apple PowerMac based machines"
>>   	depends on PPC_MULTIPLATFORM
>>
> 
> PIC patch separate please.
> 

Ok.

>> +/*
>> + * Critial interrupt irq_chip
>> +*/
>> +static void mpc52xx_crit_mask(unsigned int virq)
>> +{
>> +	int irq;
>> +	int l2irq;
>> +
>> +	irq = irq_map[virq].hwirq;
>> +	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
>> +
>> +	pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
>> +
>> +	BUG_ON(l2irq != 0);
>> +
>> +	io_be_clrbit(&intr->ctrl, 11);
>> +}
> 
> I'm not sure you understood my previous comment... any reason why crit
> and mainirq are two different sets of functions and a different level 1
> since crit is just basically mainirq 0 ? And main & mainirq, on the
> contrary, should be different L1s since they are ... different :)

In my opinion, as it reflects a bit better hwow the hw itself is 
architectured (critical, main, peripheral...) it's better to do it like 
this. I do not wish to change this. Moreover, it's yet working pretty well.


>> +	mpc52xx_irqhost =
>> +	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, 0xd0,
>> +			   &mpc52xx_irqhost_ops, -1);
> 
> I would prefer that 0xd0 to be a symbolic constant in the .h

Ok. will be done

>> +	if (mpc52xx_irqhost)
>> +		mpc52xx_irqhost->host_data = (void *)find_mpc52xx_picnode();
> 
> Casting to void * is fairly useless :)
> 

Removed.

>> +#ifdef CONFIG_PCI
>> +#define _IO_BASE        isa_io_base
>> +#define _ISA_MEM_BASE   isa_mem_base
>> +#define PCI_DRAM_OFFSET pci_dram_offset
>> +#else
>> +#define _IO_BASE        0
>> +#define _ISA_MEM_BASE   0
>> +#define PCI_DRAM_OFFSET 0
>> +#endif
> 
> I told you several times to remove the above. The whole thing is
> duplicate of io.h.
> 
> The fact that the former has a special case for CONFIG_PPC_MPC52xx is
> bogus in the first place... you might want to turn -that- into a

It normaly does not compile if I remove it as state earlier. I'll remove 
them and fixed the compile issue.

> if defined(CONFIG_PPC_MPC52xx) && !defined(CONFIG_PPC_MERGE)
> 
>> +/* 
>> ======================================================================== */
>> +/* Main registers/struct addresses 
>>       */
>> +/* 
>> ======================================================================== */
>> +
>> +/* MBAR position */
>> +#define MPC52xx_MBAR		0xf0000000	/* Phys address */
>> +#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
>> +#define MPC52xx_MBAR_SIZE	0x00010000
>> +
>> +#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
>> +#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
> 
> The above definitions are all bogus for arch/powerpc, just remove them.

Ok.

>> +/*
>> + * 24 peripherals ints
>> + * + 16 mains ints
>> + * + 4 crit
>> + * + 16 bestcomm task
>> + * = 64
>> +*/
>> +#define MPC52xx_IRQ_MAXCOUNT     (64)
> 
> The above is both not correct anymore and not used. Please fix it and
> use it instead of hard coding.

Will be removed and replace by another define to reflect the highest 
virq (0xd0).

#define MPC52xx_IRQ_MACVIRQ 		(0xd0)

sounds ok ?

>> +static inline struct device_node *find_mpc52xx_picnode(void)
>> +{
>> +	return of_find_compatible_node(NULL, "interrupt-controller",
>> +				       "mpc5200-pic");
>> +}
> 
> Any reason why you need that inline since it's not used anywhere else
> but the PIC code ? Just put that of_find_compatible_node() statement in
> the .c and be done with it.
> 

Done.

>> +	/* Matching of PSC function */
>> +struct mpc52xx_psc_func {
>> +	int id;
>> +	char *func;
>> +};
>>
>> +extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
>> +extern struct mpc52xx_psc_func mpc52xx_psc_functions[];
>> +	/* This array is to be defined in platform file */
> 
> The above doesn't look like it should migrate to arch/powerpc... what is
> it supposed to be ?
> 

Removed.

I'll re submit the patch as soon as 'done, compiled, tested'.

Bye


--------------090707090105080304000000
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------090707090105080304000000--
