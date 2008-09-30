Return-Path: <m.fortini@selcomgroup.com>
Received: from xseries02.selcomgroup.com (mail.selcomgroup.com [85.18.34.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94400DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Sep 2008 21:12:59 +1000 (EST)
Received: from [172.26.6.73] ([172.26.6.73]) (authenticated bits=0)
	by xseries02.selcomgroup.com (8.13.4/8.13.4) with ESMTP id
	m8UBCqFa017220
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Sep 2008 13:12:52 +0200
Message-ID: <48E209B6.7070203@selcomgroup.com>
Date: Tue, 30 Sep 2008 13:12:54 +0200
From: Matteo Fortini <m.fortini@selcomgroup.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: gpt frequency input/pwm driver for MPC512x
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are developing a couple of gpt drivers (one for input capture and 
frequency measurement, one for pwm lcd backlight control) for an 
MPC512x, and we'd like to find the proper way of inserting it into the 
kernel.

Currently, the frequency input driver is reserving a character device 
and registering as a platform device driver with the 
of_register_platform_driver() calls.
The character device interface is given through the old-style cdev_t 
allocation and deallocation, but I see that maybe this kind of devices, 
which seems not to conform to any device type, should register as 
"miscdevice"s, is that correct? This would leave me with only 14 minor 
numbers free to be allocated. Moreover, there seems to be no way of 
getting to the device data when using miscdevice's file operations, so 
we would be on our own allocating more than one frequency input.

Same for the backlight driver: I'd like to have a pmw driver, which I 
can register a new platform driver, but how do I "glue" it with the 
backlight driver? I'd prefer not to have direct pwm  register calls in 
the backlight driver, but I'd rather have the backlight driver call a 
generic pwm driver in order to do its job.

Thanks,
Matteo
