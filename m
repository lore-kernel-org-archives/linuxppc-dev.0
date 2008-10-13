Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 34938DE496
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:57:26 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Scott Wood'" <scottwood@freescale.com>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>	
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
	<48F393EB.6000100@freescale.com>
In-Reply-To: <48F393EB.6000100@freescale.com>
Subject: RE: MPC8321,
	ethernet and i2c problems after upgrade from 2.6.25 to 2.6.27
Date: Mon, 13 Oct 2008 20:57:15 +0200
Message-ID: <02f501c92d65$828b64d0$87a22e70$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Sent: den 13 oktober 2008 20:31
> To: joakim.tjernlund@transmode.se
> Cc: 'linuxppc-dev Development'
> Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25 to 2.6.27
> 
> Joakim Tjernlund wrote:
> > On Mon, 2008-10-13 at 11:31 -0500, Scott Wood wrote:
> >> i2c-mpc.c now registers as a dynamically-numbered bus; you need to either
> >> use the device tree, or call i2c_new_device().
> >
> > Thanks, but is this really so? Reading include/linux/i2c.h makes me
> > wonder if not the i2c_register_board_info() should still work.
> 
> Why?  Note that the "add-on" versus "mainboard" distinction in the
> comment is just an example; the actual distinction is
> dynamically-numbered versus statically-numbered.  Since the controller
> itself is probed from the device tree, there's no good way of statically
> assigning a bus number to it.

Because all the kernel comments I can see still implies that this should work
and because this was the only way in earlier releases to add an i2c device.

> 
> > Calling i2c_new_device() from an initcall() procedure does not
> > seem easy/possible, you need the adapter to do that. Maybe I just
> > missing something obvious?
> 
> The obvious and easy way is to just use the device tree.
> 
> If that isn't possible (such as due to device trees embedded in existing
> firmware), you can find the adapter device as a child of the of_device.

Possible yes, safe no. As is now I cannot use 2.6.27 on my current u-boot. 
and that may cause trouble in the field.

I always had the impression that OF was an optional add on, but now it seems
that it is mandatory for i2c?
 
> Finding the of_device from the device_node may be difficult, though.
> We could have i2c-mpc set node->data to the of_device (or maybe the
> adapter struct), or maybe should add an of_device member of device_node
> that gets filled in by of_platform?

hmm, no easy way out then? I need a way to do this from my board code without
adding new stuff to the driver. A hack that only works in 2.6.27 will do.

 Jocke
