Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BD52DDF71
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 06:48:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4EKmNhZ001386
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 13:48:24 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4EKmNud001504
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 15:48:23 -0500 (CDT)
Message-ID: <482B5017.7080804@freescale.com>
Date: Wed, 14 May 2008 15:48:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: New-style I2C driver not getting probed because
	of_register_i2c_devices() is not setting info.driver_name
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm converting sound/soc/codecs/cs4270.c into a new-style I2C driver, and this
driver is not getting probed.  I believe the problem is that i2c_device_match()
is returning failure, because of this line:

	return strcmp(client->driver_name, drv->name) == 0;

when this line is executed, client->drivername is blank.  Therefore, the strcmp
never matches.

I think this string is blank because when of_register_i2c_devices() in fsl_soc.c
calls i2c_register_board_info(), the info.driver_name field is also blank.
i2c_new_device() copies info->driver_name to client->driver_name.

I don't understand why this code doesn't work for me.  Most of the core I2C code
has been in place for a year, and I can't see how my driver is different from
any other new-style I2C driver that works on OF platforms.

Can anyone help me?

-- 
Timur Tabi
Linux kernel developer at Freescale
