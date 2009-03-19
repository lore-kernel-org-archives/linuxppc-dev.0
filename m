Return-Path: <daniel.ng1234@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 26461DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 19:32:43 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so254339waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 01:32:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
References: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
Date: Thu, 19 Mar 2009 19:32:42 +1100
Message-ID: <547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>
Subject: Re: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
From: Daniel Ng <daniel.ng1234@gmail.com>
To: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sergej,

On Wed, Mar 18, 2009 at 7:30 PM, Stepanov, Sergej
<Sergej.Stepanov@ids.de> wrote:
> in the attachment i send a spi driver (little bit "of") done by myself

Thanks for your driver. I've already got a SPI Controller driver, I
just want to hook it up to spidev.c so that it is has a Userspace
interface via /dev/spi-0.

I'm looking at the I2C driver for some ideas.

i2cdev_attach_adapter() handles the creation of the /dev/i2c-0 dev
node, and associates the i2c driver with this dev node.
cpm_i2c_probe() seems to end up calling i2cdev_attach_adapter() via
the following chain:

cpm_i2c_probe() -> i2c_add_adapter() -> i2c_register_adapter() ->
i2c_do_add_adaptor -> i2cdev_attach_adapter()

It seems like spidev_probe() does generally the same thing as
i2cdev_attach_adapter() for SPI.

So, I tried to call spidev_probe() directly from the probe() function
of my SPI Controller driver. However in this case spidev_probe()
failed because its call to device_create_drvdata() failed with error
code ENODEV. Why would this be?

This is how I make the call from my SPI Controller driver:

spidev_probe(to_spi_device(&ofdev->dev));

And this is the relevant code in spidev_probe():

dev = device_create_drvdata(spidev_class, &spi->dev, spidev->devt,
spidev, "spidev%d.%d",
                               /*spi->master->bus_num*/0, spi->chip_select);
				
Note that if I uncomment the spi->master->bus_num parameter and get
rid of the hacked-in '0', the above results in a crash. I guess this
means that spi->master has not been set up. But it *has* been set up
in my SPI Controller's probe() function using platform_set_drvdata():

static int __devinit XXX_spi_probe(struct of_device *ofdev, const
struct of_device_id *match)
{
	struct spi_master *master;
	struct XXX_spi *sp;
  int res=0;

	master = spi_alloc_master(&ofdev->dev, sizeof(struct XXX_spi));

	if (master == NULL) {
		dev_err(&ofdev->dev, "failed to allocate spi master\n");
		return -ENOMEM;
	}

  master->bus_num = 0;
  master->num_chipselect = XXX_MAX_CHIPSEL;

  sp = spi_master_get_devdata(master);

  platform_set_drvdata(ofdev, sp);			

  res = spidev_probe(to_spi_device(&ofdev->dev));
  if(res)
  {
    printk("XXX_spi_probe()- spidev_probe() FAILED\n");
  }
  return res;
}


Inserting the below just before the call to spidev_probe() solves the
problem of the crash:

  {
    struct spi_device *spidev;
    spidev = to_spi_device(&ofdev->dev);
    spidev->master = master;
  }

But I still get the ENODEV error mentioned above. Can anyone explain why?

Cheers,
Daniel
