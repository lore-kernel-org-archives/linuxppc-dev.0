Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA1B8DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:33:52 +1100 (EST)
Message-ID: <48F393EB.6000100@freescale.com>
Date: Mon, 13 Oct 2008 13:31:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>	
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1223918059.32141.62.camel@gentoo-jocke.transmode.se>
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
> On Mon, 2008-10-13 at 11:31 -0500, Scott Wood wrote:
>> i2c-mpc.c now registers as a dynamically-numbered bus; you need to either
>> use the device tree, or call i2c_new_device().
> 
> Thanks, but is this really so? Reading include/linux/i2c.h makes me
> wonder if not the i2c_register_board_info() should still work.

Why?  Note that the "add-on" versus "mainboard" distinction in the 
comment is just an example; the actual distinction is 
dynamically-numbered versus statically-numbered.  Since the controller 
itself is probed from the device tree, there's no good way of statically 
assigning a bus number to it.

> Calling i2c_new_device() from an initcall() procedure does not
> seem easy/possible, you need the adapter to do that. Maybe I just
> missing something obvious?

The obvious and easy way is to just use the device tree.

If that isn't possible (such as due to device trees embedded in existing 
firmware), you can find the adapter device as a child of the of_device.

Finding the of_device from the device_node may be difficult, though.
We could have i2c-mpc set node->data to the of_device (or maybe the 
adapter struct), or maybe should add an of_device member of device_node 
that gets filled in by of_platform?

-Scott
