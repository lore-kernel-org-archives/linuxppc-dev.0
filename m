Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id 43EC9DDE03
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 07:28:24 +1000 (EST)
Message-ID: <48BDAFF3.2090803@mlbassoc.com>
Date: Tue, 02 Sep 2008 15:28:19 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Initialization order
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm working with a couple FreeScale platforms and having
trouble getting the RTC which is connected via I2C to work.
I had this working fine in the old arch/ppc tree, but it's
failing in the arch/powerpc world.

Here's the problem - the RTC driver gets initialized *before*
the I2C bus and as far as I can tell, the RTC 'probe' function
never gets executed.  I've peppered the device/bus/driver init
code with some extra prints to see the flow:

*** ds1307_init.548
*** i2c_register_driver.662
*** i2c_register_driver.674
*** i2c_register_driver.682
*** driver_register.228 (rtc-ds1307) - called from c01963cc
*** bus_add_driver.657 - bus: 'i2c', driver: 'rtc-ds1307'
*** i2c_register_driver.689
i2c /dev entries driver
*** i2c_register_driver.662
*** i2c_register_driver.674
*** i2c_register_driver.682
*** driver_register.228 (dev_driver) - called from c01963cc
*** bus_add_driver.657 - bus: 'i2c', driver: 'dev_driver'
*** i2c_register_driver.689
*** platform_driver_register.456 (fsl-i2c) - called from c02bbc54
*** driver_register.228 (fsl-i2c) - called from c0162f88
*** bus_add_driver.657 - bus: 'platform', driver: 'fsl-i2c'
*** fsl_i2c_probe.361
*** fsl_i2c_probe.361

There is a similar print in the 'ds1307_probe()' function,
but as you can see, it's never called :-(

Can someone explain what drives the order of these init functions?
I can see that it's based on the __XXXinit sections, but I don't
see why the RTC functions happen before the FSL-I2C ones.  From
my system map:

c02bb738 t rtc_hctosys
c02bb87c t rtc_init
c02bb918 T rtc_dev_init
c02bb97c T rtc_sysfs_init
c02bb98c t ds1307_init
c02bb9d0 T i2c_register_board_info
c02bbaf4 t i2c_init
c02bbb80 t i2c_dev_init
c02bbc3c t fsl_i2c_init

Any ideas how I can affect this ordering?  or should it matter
and there's something else going on?

Thanks for any pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
