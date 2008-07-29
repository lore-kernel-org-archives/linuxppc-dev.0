Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA54EDE3DD
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 05:43:14 +1000 (EST)
Message-ID: <488F72C8.8010909@freescale.com>
Date: Tue, 29 Jul 2008 14:43:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: I2C node in device tree breaks old-style drivers
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to debug an I2C problem I've found in my old-style driver:
sound/soc/codecs/cs4270.c.  My I2C probe function is working, but the I2C
subsystem cannot find my device.  I know it's there, because U-Boot can probe it
just fine.

At first, I thought my problem was this:

static struct i2c_driver cs4270_i2c_driver = {
	.driver = {
		.name = "CS4270 I2C",
		.owner = THIS_MODULE,
	},
	.id =             I2C_DRIVERID_CS4270,
	.attach_adapter = cs4270_i2c_attach,
	.detach_client =  cs4270_i2c_detach,
};

In a slightly older kernel (still 2.6.27), I had to change "CS4270 I2C" to
"cs4270" to get it to work.  However, that change no longer makes a difference.

I turned on debugging and this is what I see:

i2c-core: driver [CS4270 I2C] registered
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x48
i2c-adapter i2c-0: master_xfer[0] W, addr=0x48, len=0
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x49
i2c-adapter i2c-0: master_xfer[0] W, addr=0x49, len=0
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4a
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4a, len=0
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4b
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4b, len=0
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4c
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4c, len=0
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4c, len=1
i2c-adapter i2c-0: master_xfer[1] R, addr=0x4c, len=1
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4d
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4d, len=0
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4d, len=1
i2c-adapter i2c-0: master_xfer[1] R, addr=0x4d, len=1
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4e
i2c-adapter i2c-0: master_xfer[0] W, addr=0x4e, len=0
i2c-adapter i2c-0: found normal entry for adapter 0, addr 0x4f

My device is at address 4F.  The device tree defines a node for this device.
You can see it in arch/powerpc/boot/dts/mpc8610_hpcd.dts.

When I change the device tree so that it lists the device at an address other
than 4F, (e.g. "reg = <0x48>"), then my driver works.

So my conclusion is that specifying an I2C node in the device tree *requires*
that the driver be new-style.  Is there any way we can fix this?  I'm not going
to have time to update the CS4270 driver to a new-style interface before the
2.6.27 window closes.

-- 
Timur Tabi
Linux kernel developer at Freescale
