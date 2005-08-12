Return-Path: <cajus.hahn@de.abb.com>
Received: from nse3.abb.com (nse3.abb.com [129.35.204.69])
	by ozlabs.org (Postfix) with ESMTP id DBAAA680D9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 17:49:16 +1000 (EST)
Received: from abb-despk-smtp.de.abb.com (deehn-s-cc1gw54.de.abb.com
	[10.51.20.40])
	by nse3.abb.com (8.11.6/8.11.6) with ESMTP id j7C7n8q24285
	for <linuxppc-embedded@ozlabs.org>; Fri, 12 Aug 2005 09:49:11 +0200
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF29EF0D8D.F0A40A5C-ONC125705B.0028FA70-C125705B.002AF212@de.abb.com>
From: cajus.hahn@de.abb.com
Date: Fri, 12 Aug 2005 09:49:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





Hello Tjernlund, Hello Debora

>Try changing all
>  i2c->i2c_i2com |= 0x80;           /* Begin transmission */
>to
>  i2c->i2c_i2com |= 0x80 | 0x01;          /* Begin transmission */
>
>That should remove the need to do force_reinit(cpm) I hope.

This is NOT working in every case!

It will work, on short bus-disturbances on the SCL line.
I suggest adding the "| 0x01" even this will not help on every transmission
problem.

If you have longer disturbances on SCL or SDA, something in  the CPM will
prevent the I2C bus to continue working after the disturbances are gone.
Perhaps there is a problem with the buffer allocation.
I changed the i2c-algo-8xx.c to work with your patch and without the
force_reinit() code.
Then I set the SCL line to ground to simulate a longer bus disturbance.
After some timeouts my SPI bus, yes the SPI bus, reportet transmission
errors. Both bus-interfaces use the CPM. It looks like the SPI buffer gets
garbaged by the I2C interface.
With the force_reinit() this problem did not occur.

Cajus
