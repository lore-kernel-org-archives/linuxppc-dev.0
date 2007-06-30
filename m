Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C2A7DDF8E
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 14:25:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5U4PoEl014230
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 21:25:50 -0700 (MST)
Received: from Artemis.local (mvp-10-214-73-6.am.freescale.net [10.214.73.6])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	l5U4PnNl029684
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 23:25:50 -0500 (CDT)
Message-ID: <4685DB63.7040705@freescale.com>
Date: Fri, 29 Jun 2007 23:26:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: current-speed property in serial devices causes kernel panic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I see this code in function of_platform_serial_setup():

static int __devinit of_platform_serial_setup(struct of_device *ofdev,
                                        int type, struct uart_port *port)
{
        struct resource resource;
        struct device_node *np = ofdev->node;
        const unsigned int *clk, *spd;
        int ret;
                     
        memset(port, 0, sizeof *port);
        spd = of_get_property(np, "current-speed", NULL);
...
        port->custom_divisor = *clk / (16 * (*spd));
        
        return 0;
}

There is no check in this code to make sure spd is not null.  And sure enough, in most DTS files, current-speed does not exist.  So whenever this function is called on a node like this, the kernel panics.

I'm adding support for a new 86xx platform, and I'm also creating a driver for a new SOC device.  In my platform driver, I have this code:

static struct of_device_id mpc86xx_ids[] = {
        { .type = "soc", },
        {}
};
   
static int __init mpc86xx_declare_of_platform_devices(void)  
{
        printk(KERN_ALERT "%s\n", __FUNCTION__);

        if (!machine_is(mpc86xx_hpcn))
                return 0;

        of_platform_bus_probe(NULL, mpc86xx_ids, NULL);

        return 0;
}
device_initcall(mpc86xx_declare_of_platform_devices);

The kernel panic occurs only if I call of_platform_bus_probe().

If you look at the code for the 836x platform, you'll see that it also has serial SOC devices and it also calls of_platform_bus_probe(), but it doesn't experience kernel panics.

Is the call to of_platform_bus_probe() effectively trying to probe the serial devices twice?  I just don't understand why this code isn't working.
