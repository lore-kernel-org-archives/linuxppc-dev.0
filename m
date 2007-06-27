Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 7404CDDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 21:20:22 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070625010311.GA31355@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <024cbfe00dde1c97bb249b925f55ebee@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] pcmcia: CompactFlash driver for PA Semi Electra boards
Date: Wed, 27 Jun 2007 06:20:27 -0500
To: Olof Johansson <olof@lixom.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof.

On Mon Jun 25 11:03:11 EST 2007, Olof Johansson wrote:
> Driver for the CompactFlash slot on the PA Semi Electra eval board. 
> It's
> a simple device sitting on localbus, with interrupts and detect/voltage
> control over GPIO.
>
> The driver is implemented as an of_platform driver, and adds localbus
> as a bus being probed by the of_platform framework.

...
> +
> +static int __devinit electra_cf_probe(struct of_device *ofdev,
> +                                     const struct of_device_id *match)
> +{
> +       struct device *device = &ofdev->dev;
> +       struct device_node *np = ofdev->node;
> +       struct electra_cf_socket   *cf;
> +       struct resource mem, io;
> +       int status;
> +       const unsigned int *prop;
> +       int err;
> +
> +       err = of_address_to_resource(np, 0, &mem);
> +       if (err)
> +               return -EINVAL;
> +
> +       err = of_address_to_resource(np, 1, &io);
> +       if (err)
> +               return -EINVAL;
> +
> +       cf = kzalloc(sizeof *cf, GFP_KERNEL);
> +       if (!cf)
> +               return -ENOMEM;
> +
> +       init_timer(&cf->timer);
> +       cf->timer.function = electra_cf_timer;
> +       cf->timer.data = (unsigned long) cf;
> +
> +       cf->ofdev = ofdev;
> +       cf->mem_phys = mem.start;
> +       cf->mem_base = ioremap(mem.start, mem.end - mem.start);
> +       cf->io_size = PAGE_ALIGN(io.end - io.start);
> +
> +       cf->io_virt = reserve_phb_iospace(cf->io_size);
> +
> +       cf->gpio_base = ioremap(0xfc103000, 0x1000);
> +       dev_set_drvdata(device, cf);
> +
> +       if (!cf->mem_base || !cf->io_virt || !cf->gpio_base) {
> +               dev_err(device, "can't ioremap ranges\n");
> +               status = -ENOMEM;
> +               goto fail1;
> +       }
> +
> +       __ioremap_explicit(io.start, (unsigned long)cf->io_virt, 
> cf->io_size,
> +                          _PAGE_NO_CACHE | _PAGE_GUARDED);
> +
> +       cf->io_base = (unsigned long)cf->io_virt - VMALLOC_END;
> +
> +       cf->iomem.start = (unsigned long)cf->mem_base;
> +       cf->iomem.end = (unsigned long)cf->mem_base + (mem.end - 
> mem.start);
> +       cf->iomem.flags = IORESOURCE_MEM;
> +
> +       cf->irq = irq_of_parse_and_map(np, 0);
> +
> +       status = request_irq(cf->irq, electra_cf_irq, IRQF_SHARED,
> +                            driver_name, cf);
> +       if (status < 0) {
> +               dev_err(device, "request_irq failed\n");
> +               goto fail1;
> +       }
> +
> +       cf->socket.pci_irq = cf->irq;
> +
> +       prop = get_property(np, "card-detect-gpio", NULL);
> +       cf->gpio_detect = *prop;
> +       prop = get_property(np, "card-vsense-gpio", NULL);
> +       cf->gpio_vsense = *prop;
> +       prop = get_property(np, "card-3v-gpio", NULL);
> +       cf->gpio_3v = *prop;
> +       prop = get_property(np, "card-5v-gpio", NULL);
> +       cf->gpio_5v = *prop;
> +

get_property is now a #define for of_get_property.  I think the use of 
get_property is being deprecated.

If of_get_property fails to find the property, then you will 
dereference a NULL pointer in a probe function and will leave the 
bus_type locked.

> +       cf->socket.io_offset = cf->io_base;
> +
> +       /* reserve chip-select regions */
> +       if (!request_mem_region(mem.start, mem.end + 1 - mem.start,
> +                               driver_name)) {
> +               status = -ENXIO;
> +               dev_err(device, "Can't claim memory region\n");
> +               goto fail1;
> +       }
> +
> +       if (!request_region(cf->io_base, cf->io_size, driver_name)) {
> +               status = -ENXIO;
> +               dev_err(device, "Can't claim I/O region\n");
> +               goto fail2;
> +       }
> +
> +       cf->socket.owner = THIS_MODULE;
> +       cf->socket.dev.parent = &ofdev->dev;
> +       cf->socket.ops = &electra_cf_ops;
> +       cf->socket.resource_ops = &pccard_static_ops;
> +       cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP |
> +                               SS_CAP_MEM_ALIGN;
> +       cf->socket.map_size = 0x800;
> +
> +       status = pcmcia_register_socket(&cf->socket);
> +       if (status < 0) {
> +               dev_err(device, "pcmcia_register_socket failed\n");
> +               goto fail3;
> +       }
> +
> +       dev_info(device, "at mem 0x%lx io 0x%lx irq %d\n",
> +                mem.start, io.start, cf->irq);
> +
> +       cf->active = 1;
> +       electra_cf_timer((unsigned long)cf);
> +       return 0;
> +
> +fail3:
> +       release_mem_region(io.start, io.end + 1 - io.start);
> +fail2:
> +       release_mem_region(mem.start, mem.end + 1 - mem.start);
> +fail1:
> +       /* XXX No way to undo the io reservation at this time */

What io reservation is this comment referring to?


Where is the request_irq undone?

> +       if (cf->mem_base)
> +               iounmap(cf->mem_base);
> +       if (cf->gpio_base)
> +               iounmap(cf->gpio_base);
> +       device_init_wakeup(&ofdev->dev, 0);
> +       kfree(cf);
> +       return status;
> +
> +}
> +
> +static int __devexit electra_cf_remove(struct of_device *ofdev)
> +{
> +       struct device *device = &ofdev->dev;
> +       struct electra_cf_socket *cf;
> +
> +       cf = dev_get_drvdata(device);
> +
> +       cf->active = 0;
> +       pcmcia_unregister_socket(&cf->socket);
> +       free_irq(cf->irq, cf);
> +       del_timer_sync(&cf->timer);
> +
> +       iounmap(cf->mem_base);
> +       iounmap(cf->gpio_base);
> +       release_mem_region(cf->mem_phys, cf->mem_size);
> +       release_region(cf->io_base, cf->io_size);
> +
>

irq_request?

> +       kfree(cf);
> +
> +       return 0;
> +}
> +
> +static int bus_notify(struct notifier_block *nb, unsigned long action,
> +                     void *data)
> +{
> +       struct device *dev = data;
> +
> +       printk("bus notify called\n");
> +
> +       /* We are only intereted in device addition */
> +       if (action != BUS_NOTIFY_ADD_DEVICE)
> +               return 0;
> +
> +       /* We use the direct ops for localbus */
> +       dev->archdata.dma_ops = &dma_direct_ops;
> +

I'm also replying to your reply to hch's reply.  Is that enough of a 
reply? :-)

> +       return 0;
> +}
> +
> +static struct notifier_block bus_notifier = {
> +       .notifier_call = bus_notify,
> +};
> +
> +static struct of_device_id electra_cf_match[] =
> +{
> +       {
> +               .compatible   = "electra-cf",
> +       },
> +       {},
> +};
> +
> +static struct of_platform_driver electra_cf_driver =
> +{
> +       .name      = (char *)driver_name,
> +       .match_table    = electra_cf_match,
> +       .probe    = electra_cf_probe,
> +       .remove   = electra_cf_remove,
> +};
> +
> +static int __init electra_cf_init(void)
> +{
> +       bus_register_notifier(&pcmcia_bus_type, &bus_notifier);
> +       return of_register_platform_driver(&electra_cf_driver);
> +}
> +module_init(electra_cf_init);
> +
> +static void __exit electra_cf_exit(void)
> +{
> +       bus_unregister_notifier(&pcmcia_bus_type, &bus_notifier);
> +       of_unregister_platform_driver(&electra_cf_driver);

Should these be reversed?  (if we keep it here)

> +}
> +module_exit(electra_cf_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR ("Olof Johansson <olof at lixom.net>");
> +MODULE_DESCRIPTION("PA Semi Electra CF driver");
> +

cheers,
milton
