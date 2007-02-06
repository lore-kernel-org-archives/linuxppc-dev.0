Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 910D0DDE35
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 01:24:26 +1100 (EST)
In-Reply-To: <200702061407.24843.arnd@arndb.de>
References: <45C6F46C.9000000@freescale.com>
	<297BF1F9-551F-43AD-9E76-00C79EC8BF31@kernel.crashing.org>
	<200702061407.24843.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C9D8CBA2-7ED6-4433-BE70-966BDC94FA13@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] add soc setup code for USB DR OTG mode
Date: Tue, 6 Feb 2007 08:23:19 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 7:07 AM, Arnd Bergmann wrote:

> On Monday 05 February 2007 16:15, Kumar Gala wrote:
>>> +                     usb_data.operating_mode = FSL_USB2_DR_HOST;
>>> +                     usb_dev_dr_host =  
>>> platform_device_register_simple(
>>> +                                     "fsl-ehci", i, r, 2);
>>> +                     if (IS_ERR(usb_dev_dr_host)) {
>>> +                             ret = PTR_ERR(usb_dev_dr_host);
>>> +                             goto err;
>
> I just saw that this file has a number of calls to
> platform_device_register_simple() for devices that come from the OF
> device tree.
>
> Can this be converted to use of_register_platform_driver() and
> of_platform_device_probe() instead?

This is an ongoing issue and will help once arch/ppc consumers of  
these drivers go away.  Until then we will continue to use  
platform_devices.

- k
