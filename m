Return-Path: <michael.firth@bt.com>
Received: from smtp2.smtp.bt.com (smtp2.smtp.bt.com [217.32.164.150])
	by ozlabs.org (Postfix) with ESMTP id A220BDDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Dec 2007 01:33:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Changes to Freescale I2C driver makes it stop working for us moving
	from 2.6.22 to 2.6.23.9
Date: Fri, 21 Dec 2007 14:33:02 -0000
Message-ID: <36D7B34A3A79F84F82FA0C154F299F25063D2948@E03MVX1-UKDY.domain1.systemhost.net>
From: <michael.firth@bt.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We've recently updated the kernel on one of our Freescale MPC834x
systems from 2.6.22 to 2.6.23.9.

Everything seemed to be working fine, until we tried the I2C buses. This
had been working find on 2.6.22, but on 2.6.23.9 it fails on trying to
open the I2C devices.

Looking in to the code, the 'fsl_i2c_probe' function has changed
slightly between the releases. Changing this back to the way it was in
2.6.22 make things work again.

Old code:
	i2c->adap =3D mpc_ops;
	i2c_set_adapdata(&i2c->adap, i2c);
	i2c->adap.dev.parent =3D &pdev->dev;
	if ((result =3D i2c_add_adapter(&i2c->adap)) < 0) {
		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
		goto fail_add;
	}

New code:
	i2c->adap =3D mpc_ops;
	i2c->adap.nr =3D pdev->id;
	i2c_set_adapdata(&i2c->adap, i2c);
	i2c->adap.dev.parent =3D &pdev->dev;
	if ((result =3D i2c_add_numbered_adapter(&i2c->adap)) < 0) {
		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
		goto fail_add;
	}

Presumably the new code puts additional requirements on the
'platform_device' registration - can anyone let me know what I'll need
to add to get this working with the new driver code?

Thanks in advance

Michael
