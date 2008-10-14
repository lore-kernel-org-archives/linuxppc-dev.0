Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 55BCDDDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 18:55:33 +1100 (EST)
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48F39B97.6030602@freescale.com>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
	<48F393EB.6000100@freescale.com>
	<02f501c92d65$828b64d0$87a22e70$@Tjernlund@transmode.se>
	<48F39B97.6030602@freescale.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 09:55:31 +0200
Message-Id: <1223970931.32141.80.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 14:03 -0500, Scott Wood wrote:
> Joakim Tjernlund wrote:
> > Because all the kernel comments I can see still implies that this should work
> 
> Which kernel comments?

The one already mentioned and in i2c-boardinfo.c

> 
> > and because this was the only way in earlier releases to add an i2c device.
> 
> We've supported enumerating i2c-mpc devices using the device tree for 
> almost as long as there's been new-style i2c devices.

Don't know how long that has been but looking at the mpc832x_mds dts
file it has been there less than a year.

> 
> >> The obvious and easy way is to just use the device tree.
> >>
> >> If that isn't possible (such as due to device trees embedded in existing
> >> firmware), you can find the adapter device as a child of the of_device.
> > 
> > Possible yes, safe no. As is now I cannot use 2.6.27 on my current u-boot. 
> 
> Why not?  U-boot allows you to pass in a device tree dynamically.

I don't use a dynamic device tree, mine is built in.

> 
> > I always had the impression that OF was an optional add on, but now it seems
> > that it is mandatory for i2c?
> 
> It's mandatory for device drivers such as i2c-mpc that expect it.

This is the main point, up to now I belived that OF only drivers was a
bug that should be fixed but since no one is supports my view I guess
I have misunderstod. 

> 
> >> Finding the of_device from the device_node may be difficult, though.
> >> We could have i2c-mpc set node->data to the of_device (or maybe the
> >> adapter struct), or maybe should add an of_device member of device_node
> >> that gets filled in by of_platform?
> > 
> > hmm, no easy way out then? I need a way to do this from my board code without
> > adding new stuff to the driver. A hack that only works in 2.6.27 will do.
> 
> You could add the node to the device tree from platform code, if you run 
> before the i2c adapter's probe() runs.  Or, if you really want to stick 
> with your current way of doing things, and are willing to own both 
> pieces if it breaks, you can comment out this test in 
> i2c_register_adapter, and always call i2c_scan_static_board_info:
> 
> if (adap->nr < __i2c_first_dynamic_bus_num)
> 	i2c_scan_static_board_info(adap);

No, I don't want to hack general i2c code. I guess I will
just have to update our boot too.

 Jocke
