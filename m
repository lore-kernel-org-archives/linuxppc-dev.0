Return-Path: <daniel.ng1234@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 7FEB8DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 18:36:32 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so223611waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 00:36:30 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 18 Mar 2009 18:36:30 +1100
Message-ID: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
Subject: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
From: Daniel Ng <daniel.ng1234@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to get the spidev.c driver working in Kernel 2.6.27.19 on a ppc8247.

Firstly, would I need to convert it to an 'of'-style driver?

Assuming this is the case, I've changed spidev_init() to use
of_register_platform_driver() with what I think is an appropriate
parameter:

static struct of_platform_driver spidev_spi = {
    .name         = "spidev",
    .match_table  = spidev_match,
    .probe        = spidev_probe,
    .remove       = __devexit_p(spidev_remove),
};

spidev_probe() now looks like the below. I've had to change the
spidev_probe() function signature, which meant I needed to use
to_spi_device() in the function (there are no other changes).

static int __devinit spidev_probe(struct of_device *ofdev, const
struct of_device_id *match)
{
	struct spidev_data	*spidev;
	int			status;
	unsigned long		minor;
                struct spi_device *spi;

                spi = to_spi_device(&ofdev->dev);

	/* Allocate driver data */
	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
	if (!spidev)
		return -ENOMEM;

	/* Initialize the driver data */
	spidev->spi = spi;
	spin_lock_init(&spidev->spi_lock);
	mutex_init(&spidev->buf_lock);

	INIT_LIST_HEAD(&spidev->device_entry);

	/* If we can allocate a minor number, hook up this device.
	 * Reusing minors is fine so long as udev or mdev is working.
	 */
	mutex_lock(&device_list_lock);
	minor = find_first_zero_bit(minors, N_SPI_MINORS);
	if (minor < N_SPI_MINORS) {
		struct device *dev;

		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);

		dev = device_create_drvdata(spidev_class, &spi->dev,
				spidev->devt, spidev,
				"spidev%d.%d",
				spi->master->bus_num, spi->chip_select);
    printk("spidev_probe(): CREATED spidev%d.%d\n",
spi->master->bus_num, spi->chip_select);
		status = IS_ERR(dev) ? PTR_ERR(dev) : 0;
.
.
/////// (the rest of this function is unchanged)
.

}

It all executes ok until the above call to device_create_drvdata(),
where it crashes (see below). Can anyone explain why?

Can I still use the 'old-style' device_create_drvdata() function with
the 'of new-style' driver framework?

Am I going about this the right way?

Unable to handle kernel paging request for data at address 0x00000120
Faulting instruction address: 0xc028e484
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT XXX
NIP: c028e484 LR: c028e478 CTR: c01511c8
REGS: c1819d60 TRAP: 0300   Not tainted  (2.6.27.19-800-OS-03050107)
MSR: 00009032 <EE,ME,IR,DR>  CR: 42044024  XER: 00000000
DAR: 00000120, DSISR: 20000000
TASK = c1814400[1] 'swapper' THREAD: c1818000
GPR00: c028e478 c1819e10 c1814400 0000000b 0000150c 0e400000 00000008 c0270000
GPR08: f0000038 00000000 0000150c c1818000 f0000020 fffffffe 01ff8000 00000000
GPR16: 01fed694 01ff56f0 00000000 00000000 00000000 00000000 c02d0000 c184ec10
GPR24: c02d2610 c1963288 c02d260c c02aafa4 00000000 ffffffed c1963280 c184ec10
NIP [c028e484] spidev_probe+0xec/0x1c8
LR [c028e478] spidev_probe+0xe0/0x1c8
Call Trace:
[c1819e10] [c028e478] spidev_probe+0xe0/0x1c8 (unreliable)
[c1819e40] [c01814a4] of_platform_device_probe+0x5c/0x84
[c1819e60] [c01552c8] driver_probe_device+0xe8/0x240
[c1819e90] [c01554a4] __driver_attach+0x84/0x88
[c1819eb0] [c01548fc] bus_for_each_dev+0x5c/0x98
[c1819ee0] [c01550a0] driver_attach+0x24/0x34
[c1819ef0] [c0154eac] bus_add_driver+0x1b4/0x220
[c1819f10] [c01557b4] driver_register+0x5c/0x158
[c1819f30] [c018136c] of_register_driver+0x54/0x70
[c1819f40] [c0289a28] spidev_init+0x6c/0xf8
[c1819f60] [c00038e8] do_one_initcall+0x38/0x188
[c1819fd0] [c0278180] kernel_init+0x8c/0xf8
[c1819ff0] [c000f6fc] kernel_thread+0x44/0x60
Instruction dump:
4be90481 2b83001f 7c7c1b78 419d00d8 64600e40 901e0000 3c60c027 38638f04
4bd8ea31 813f0120 80be0000 3ce0c027 <a9090120> 38e78f10 893f0128 7fe4fb78
---[ end trace 8d59482f3bf88fe6 ]---

Cheers,
Daniel
