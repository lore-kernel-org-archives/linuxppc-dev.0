Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CEBFDDF18
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 06:37:48 +1100 (EST)
Message-ID: <49889CFA.7070308@freescale.com>
Date: Tue, 03 Feb 2009 13:37:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, linux-i2c@vger.kernel.org
Subject: Calling wait_event_interruptible_timeout() in I2C wait functions
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In i2c-mpc.c, the i2c_wait() function has this:

	} else {
		/* Interrupt mode */
		result = wait_event_interruptible_timeout(i2c->queue,
			(i2c->interrupt & CSR_MIF), timeout * HZ);

		if (unlikely(result < 0)) {
			pr_debug("I2C: wait interrupted\n");
			writeccr(i2c, 0);
		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {

That is, the driver calls wait_event_interruptible_timeout() to wait for
a response from the I2C controller after a read or write operation.

However, it appears that this is not common behavior for I2C driver.  In
fact, only these six drivers ever call wait_event_interruptible_timeout():

i2c-cpm.c
i2c-ibm_iic.c
i2c-mpc.c
i2c-taos-evm.c
i2c-iop3xx.c
i2c-mv64xxx.c

Although one would think that calling wait_event_interruptible_timeout()
is a good idea, it fails in one situation: when the abrupt termination
of a process causes an I2C operation to occur.  That is, you press ^C in
your application, and the driver issues a final I2C operation to shut
down the device.  In this situation, wait_event_interruptible_timeout()
returns -ERESTARTSYS, which is then passed up through
i2c_smbus_write_byte_data().

So my question is, is i2c-mpc.c wrong in using
wait_event_interruptible_timeout()?

-- 
Timur Tabi
Linux kernel developer at Freescale
