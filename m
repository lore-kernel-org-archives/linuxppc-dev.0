Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 4F1E7DE35B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 05:10:29 +1100 (EST)
Message-ID: <48F4E091.7080105@harris.com>
Date: Tue, 14 Oct 2008 14:10:25 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: pca9539 I2C gpio expander
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am attempting to use a pca9539 I2C gpio driver on a PPC440EPx board.  The
driver is "drivers/gpio/pca953x.c".  I've added an entry to the .dts file:

IIC0: i2c@ef600700 {
	compatible = "ibm,iic-440epx", "ibm,iic";
	...
	pca9539@76 {
		compatible = "ti,pca9539";
		reg = <76>;
	};
};

of_register_i2c_devices sees this entry and calls i2c_new_device.
i2c_new_device copies info->platform_data to client->dev.platform_data, but
I think that this structure is empty (at least I don't see where
of_register_i2c_devices would set it).

pca953x_probe is eventually called, but it expects to find its "lowest gpio
number" in client->dev.platform_data->gpio_base, which has not been set.  So
pca953x_probe returns -ENODEV.

I don't understand where the disconnect is.  Should I be able to use the
pca953x.c driver, or is it somehow incompatible?

If it is incompatible, is there a strategy for making it compatible?

	Steve
