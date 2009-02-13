Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f159.google.com (mail-gx0-f159.google.com
	[209.85.217.159]) by ozlabs.org (Postfix) with ESMTP id ADD72DDDA5
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 02:19:06 +1100 (EST)
Received: by gxk3 with SMTP id 3so1118835gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:19:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ae4f76fd0902130240g72b3cdf1l21b8f7ec8ad17e76@mail.gmail.com>
References: <ae4f76fd0810290643o27c357d7k2ccde459d9e52a7b@mail.gmail.com>
	<fa686aa40810290745k5c34c5e1m835351837e39248e@mail.gmail.com>
	<ae4f76fd0902130240g72b3cdf1l21b8f7ec8ad17e76@mail.gmail.com>
Date: Fri, 13 Feb 2009 08:19:04 -0700
Message-ID: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
From: Grant Likely <grant.likely@secretlab.ca>
To: Henk Stegeman <henk.stegeman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 13, 2009 at 3:40 AM, Henk Stegeman <henk.stegeman@gmail.com> wrote:
> I'm busy adding support for slave deviced behind mpc52xx-psc-spi.
> One complication I have is that my SPI slave device has an interrupt output
> to the CPU.
> My idea is to add it as a gpios property in the slave device's
> configuration:
>
>         spi@2400 {        // PSC3 (SPI IF to the IO-controller )
>             device_type = "spi";
>             #address-cells = <1>;
>             #size-cells = <0>;
>             compatible = "fsl,mpc5200-psc-spi","fsl,mpc5200b-psc-spi";
>             cell-index = <2>;
>             reg = <0x2400 0x100>;
>             interrupts = <2 3 0>;
>             interrupt-parent = <&mpc5200_pic>;
>             gpios = <&gpt4 0 0>;
>
>             io-controller@0 {
>                 compatible = "microkey,smc4000io";
>                 spi-max-frequency = <1000000>;
>                 reg = <0>;
>                 // gpios: first is IRQ to cpu
>                 gpios = <&gpt6 0 0>;
>             };

There is a better way to do this, and driver support for it is
currently merged into Ben Herrenschmidt's -next tree.

Do this instead:
        io-controller@0 {
                compatible = "microkey,smc4000io";
                spi-max-frequency = <1000000>;
                reg = <0>;
                interrupt-controller = < &gpt6 >;     // Use GPT6 as
the IRQ controller
                interrupts = < 1 >;    // And make it rising edge.
        };

Then add these two properties to the GPT node:

        interrupt-controller;
        #interrupt-cells = <1>;

Then you can use normal irq_of_parse_and_map() to set up your handler.

> How should I then register my spi slave driver? My smc4000io_probe function
> gets called correctly by of_spi support but when I register as follows:
>
> static struct spi_driver smc4000io_driver = {
>     .driver = {
>         .name    = "smc4000io",
>         .bus    = &spi_bus_type,
>         .owner    = THIS_MODULE,
>     },
>     .probe        = smc4000io_probe,
>     .remove        = __devexit_p(smc4000io_remove),
> };
>
> static int __init smc4000io_init(void)
> {
>     return spi_register_driver(&smc4000io_driver);
> }
>
> static void __exit smc4000io_exit(void)
> {
>     spi_unregister_driver(&smc4000io_driver);
> }
>
> module_init(smc4000io_init);

Yes, this is right.  The psc_spi driver automatically registers all
spi children that it finds in the device tree onto the SPI bus.
Therefore registering an spi_driver() is the right thing to do.

> But when I do:
>
> static struct of_platform_driver smc4000_spi_of_driver = {
>     .name = "smc4000io",
>     .match_table = smc4000io_of_match,
>     .probe = smc4000io_of_probe,
>     .remove        = __devexit_p(smc4000io_of_remove),
> };
>
> static int __init smc4000io_init(void)
> {
>     return of_register_platform_driver(&smc4000_spi_of_driver);
> }
> module_init(smc4000io_init);
>
> Then my smc4000io_of_probe function never gets called.

Correct.  of_platform_driver isn't useful in this case because the
device cannot exist independently of the SPI bus.  Plus an
of_platform_device doesn't provide any information about the SPI bus
itself.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
