Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 9DD14DE20D
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 13:15:47 +1000 (EST)
Date: Sat, 12 Apr 2008 23:15:45 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH 2/5] Platform code
Message-ID: <20080412231545.0befcccb@lappy.seanm.ca>
In-Reply-To: <20080412140325.69e1df3b@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412140325.69e1df3b@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the complete warp.c. It is probably easier to read this then
the patch.

Cheers,
   Sean

/*
 * PIKA Warp(tm) board specific routines
 *
 * Copyright (c) 2008 PIKA Technologies
 *   Sean MacLennan <smaclennan at pikatech.com>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */
#include <linux/init.h>
#include <linux/of_platform.h>
#include <linux/kthread.h>
#include <linux/i2c.h>
#include <linux/interrupt.h>
#include <linux/pika.h>

#include <asm/machdep.h>
#include <asm/prom.h>
#include <asm/udbg.h>
#include <asm/time.h>
#include <asm/uic.h>

#include "44x.h"


static __initdata struct of_device_id warp_of_bus[] = {
	{ .compatible = "ibm,plb4", },
	{ .compatible = "ibm,opb", },
	{ .compatible = "ibm,ebc", },
	{},
};

static __initdata struct i2c_board_info warp_i2c_info[] = {
	{ I2C_BOARD_INFO("ad7414", 0x4a) }
};

static int __init warp_arch_init(void)
{
	/* This should go away once support is moved to the dts. */
	i2c_register_board_info(0, warp_i2c_info, ARRAY_SIZE(warp_i2c_info));
	return 0;
}
machine_arch_initcall(warp, warp_arch_init);

static int __init warp_device_probe(void)
{
	of_platform_bus_probe(NULL, warp_of_bus, NULL);
	return 0;
}
machine_device_initcall(warp, warp_device_probe);

static int __init warp_probe(void)
{
	unsigned long root = of_get_flat_dt_root();

	return of_flat_dt_is_compatible(root, "pika,warp");
}

define_machine(warp) {
	.name		= "Warp",
	.probe 		= warp_probe,
	.progress 	= udbg_progress,
	.init_IRQ 	= uic_init_tree,
	.get_irq 	= uic_get_irq,
	.restart	= ppc44x_reset_system,
	.calibrate_decr = generic_calibrate_decr,
};


/* I am not sure this is the best place for this... */
static int __init warp_post_info(void)
{
	struct device_node *np;
	void __iomem *fpga;
	u32 post1, post2;

	/* Sighhhh... POST information is in the sd area. */
	np = of_find_compatible_node(NULL, NULL, "pika,fpga-sd");
	if (np == NULL)
		return -ENOENT;

	fpga = of_iomap(np, 0);
	of_node_put(np);
	if (fpga == NULL)
		return -ENOENT;

	post1 = in_be32(fpga + 0x40);
	post2 = in_be32(fpga + 0x44);

	iounmap(fpga);

	if (post1 || post2)
		printk(KERN_INFO "Warp POST %08x %08x\n", post1, post2);
	else
		printk(KERN_INFO "Warp POST OK\n");

	return 0;
}
machine_late_initcall(warp, warp_post_info);


#ifdef CONFIG_SENSORS_AD7414

static LIST_HEAD(dtm_shutdown_list);
static void __iomem *dtm_fpga;

struct dtm_shutdown {
	struct list_head list;
	void (*func)(void *arg);
	void *arg;
};


int dtm_register_shutdown(void (*func)(void *arg), void *arg)
{
	struct dtm_shutdown *shutdown;

	shutdown = kmalloc(sizeof(struct dtm_shutdown), GFP_KERNEL);
	if (shutdown == NULL)
		return -ENOMEM;

	shutdown->func = func;
	shutdown->arg = arg;

	list_add(&shutdown->list, &dtm_shutdown_list);

	return 0;
}
EXPORT_SYMBOL(dtm_register_shutdown);

int dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
{
	struct dtm_shutdown *shutdown;

	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
		if (shutdown->func == func && shutdown->arg == arg) {
			list_del(&shutdown->list);
			kfree(shutdown);
			return 0;
		}

	return -EINVAL;
}
EXPORT_SYMBOL(dtm_unregister_shutdown);

static long wdt_keepalive(long time)
{
	if (dtm_fpga) {
		unsigned reset = in_be32(dtm_fpga + 0x14);
		out_be32(dtm_fpga + 0x14, reset);
	}

	return 0;
}

static irqreturn_t temp_isr(int irq, void *context)
{
	struct dtm_shutdown *shutdown;

	/* Run through the shutdown list. */
	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
		shutdown->func(shutdown->arg);

	panic_timeout = 1800;
	panic_blink = wdt_keepalive;
	panic("Critical Temperature Shutdown");
	return IRQ_HANDLED;
}

static void pika_setup_critical_temp(struct i2c_client *client)
{
	struct device_node *np;
	int irq, rc;

	/* These registers are in 1 degree increments. */
	i2c_smbus_write_byte_data(client, 2, 55); /* Thigh */
	i2c_smbus_write_byte_data(client, 3, 50); /* Tlow */

	np = of_find_compatible_node(NULL, NULL, "adi,ad7414");
	if (np == NULL) {
		printk(KERN_ERR __FILE__ ": Unable to find ad7414\n");
		return;
	}

	irq = irq_of_parse_and_map(np, 0);
	of_node_put(np);
	if (irq  == NO_IRQ) {
		printk(KERN_ERR __FILE__ ": Unable to get ad7414 irq\n");
		return;
	}

	rc = request_irq(irq, temp_isr, 0, "ad7414", NULL);
	if (rc) {
		printk(KERN_ERR __FILE__
		       ": Unable to request ad7414 irq %d = %d\n", irq, rc);
		return;
	}
}

static inline void pika_dtm_check_fan(void __iomem *fpga)
{
	static int fan_state;
	u32 fan = in_be32(fpga + 0x34) & (1 << 14);

	if (fan_state != fan) {
		fan_state = fan;
		if (fan)
			printk(KERN_WARNING "Fan rotation error detected."
				   " Please check hardware.\n");
	}
}

static int pika_dtm_thread(void __iomem *fpga)
{
	struct i2c_adapter *adap;
	struct i2c_client *client;

	/* We loop in case either driver was compiled as a module and
	 * has not been insmoded yet.
	 */
	while (!(adap = i2c_get_adapter(0))) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(HZ);
	}

	while (1) {
		list_for_each_entry(client, &adap->clients, list)
			if (client->addr == 0x4a)
				goto found_it;

		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(HZ);
	}

found_it:
	i2c_put_adapter(adap);

	pika_setup_critical_temp(client);

	printk(KERN_INFO "PIKA DTM thread running.\n");

	while (!kthread_should_stop()) {
		u16 temp = swab16(i2c_smbus_read_word_data(client, 0));
		out_be32(fpga + 0x20, temp);

		pika_dtm_check_fan(fpga);

		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(HZ);
	}

	return 0;
}


static int __init pika_dtm_start(void)
{
	struct task_struct *dtm_thread;
	struct device_node *np;

	np = of_find_compatible_node(NULL, NULL, "pika,fpga");
	if (np == NULL)
		return -ENOENT;

	dtm_fpga = of_iomap(np, 0);
	of_node_put(np);
	if (dtm_fpga == NULL)
		return -ENOENT;

	dtm_thread = kthread_run(pika_dtm_thread, dtm_fpga, "pika-dtm");
	if (IS_ERR(dtm_thread)) {
		iounmap(dtm_fpga);
		return PTR_ERR(dtm_thread);
	}

	return 0;
}
machine_late_initcall(warp, pika_dtm_start);
#endif
