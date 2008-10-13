Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4A3DDE36D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 06:06:39 +1100 (EST)
Message-ID: <48F39B97.6030602@freescale.com>
Date: Mon, 13 Oct 2008 14:03:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>	
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
	<48F393EB.6000100@freescale.com>
	<02f501c92d65$828b64d0$87a22e70$@Tjernlund@transmode.se>
In-Reply-To: <02f501c92d65$828b64d0$87a22e70$@Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Because all the kernel comments I can see still implies that this should work

Which kernel comments?

> and because this was the only way in earlier releases to add an i2c device.

We've supported enumerating i2c-mpc devices using the device tree for 
almost as long as there's been new-style i2c devices.

>> The obvious and easy way is to just use the device tree.
>>
>> If that isn't possible (such as due to device trees embedded in existing
>> firmware), you can find the adapter device as a child of the of_device.
> 
> Possible yes, safe no. As is now I cannot use 2.6.27 on my current u-boot. 

Why not?  U-boot allows you to pass in a device tree dynamically.

> I always had the impression that OF was an optional add on, but now it seems
> that it is mandatory for i2c?

It's mandatory for device drivers such as i2c-mpc that expect it.

>> Finding the of_device from the device_node may be difficult, though.
>> We could have i2c-mpc set node->data to the of_device (or maybe the
>> adapter struct), or maybe should add an of_device member of device_node
>> that gets filled in by of_platform?
> 
> hmm, no easy way out then? I need a way to do this from my board code without
> adding new stuff to the driver. A hack that only works in 2.6.27 will do.

You could add the node to the device tree from platform code, if you run 
before the i2c adapter's probe() runs.  Or, if you really want to stick 
with your current way of doing things, and are willing to own both 
pieces if it breaks, you can comment out this test in 
i2c_register_adapter, and always call i2c_scan_static_board_info:

if (adap->nr < __i2c_first_dynamic_bus_num)
	i2c_scan_static_board_info(adap);

-Scott
