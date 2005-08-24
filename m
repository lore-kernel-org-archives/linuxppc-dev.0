Return-Path: <Keith_Henrickson@net.com>
Received: from mx02.net.com (mx02.net.com [134.56.3.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FE0B67FEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 05:12:27 +1000 (EST)
Received: from mx02-int.net.com (mx02-int.net.com [134.56.112.14])
	by mx02.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	j7OImRTL017915 for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 11:48:28 -0700 (PDT)
Received: from fmt-ex01.net.com (fmt-exchange.net.com [134.56.112.251])
	by mx02-int.net.com (Switch-3.1.3/Switch-3.1.0) with ESMTP id
	j7OImNds022863 for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 11:48:23 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 24 Aug 2005 11:45:17 -0700
Message-ID: <CE711B0E5D7A1A4096A808997E00832982AD31@fmt-ex01.net.com>
From: "Keith Henrickson" <Keith_Henrickson@net.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: I2C for the 8270
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to get the 85xx driver in Linux 2.6.11 to work on the 8270,
which also has a CPM2.

I'm not sure if the driver itself works, as I cannot even get it to
fully load.

I have enabled the 'MPC (8xx and 8xxx) CPM I2C Interface' I2C Algorithm,
and the 'Motorola MPC8xx and MPC85xx CPM I2C' Hardware Bus.

So far, I have gotten it to create '/sys/bus/platform/drivers/fsl-i2c',
although there is nothing in this directory.  I get this to happen by
bypassing the device_register() call and just forcing the device to
i2c_cpm_add_bus().

What I do NOT get are the devices in /dev, or any evidence in /sys that
there is a device that SHOULD go in /dev.  Any ideas what I am missing?


The kernel messages that come out are as follows.
i2c /dev entries driver
device class 'i2c-dev': registering
bus i2c: add driver dev_driver
i2c-core: driver dev_driver registered.
fsl-cpm-i2c: CPM2 i2c driver
bus platform: add driver fsl-i2c
bus i2c: add driver eeprom
i2c-core: driver eeprom registered.
i2c-algo-cpm: CPM2 I2C algorithm module version 0.1 (Mar 22, 2005)
