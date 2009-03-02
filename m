Return-Path: <wb1hbu@runbox.com>
Received: from aibo.runbox.com (aibo.runbox.com [87.238.52.70])
	by ozlabs.org (Postfix) with ESMTP id 6B921DDED5
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 11:58:38 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
From: "Eric Cottrell" <wb1hbu@runbox.com>
To: mbergandi@gmail.com
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
Date: Sun, 01 Mar 2009 19:58:00 -0500 (EST)
References: <E1LbNft-0007z6-Pf@garm.runbox.com> <49A3EBFF.4030906@aimvalley.nl>
	<1c641bc80902241055j33984de6re0f9a887494fa93a@mail.gmail.com>
In-Reply-To: <1c641bc80902241055j33984de6re0f9a887494fa93a@mail.gmail.com>
Message-Id: <E1LdwTo-0004h7-Aw@fenris.runbox.com>
Cc: linuxppc-dev@ozlabs.org, nvbolhuis@aimvalley.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I got brave enough this weekend to try flashing uBoot using uBoot.  I used =
the uBoot image that is in my ltib rootfs/boot directory.  The build is 1.3=
.0 (Dec 22 2008 - 11:19:29) MPC83XX.  It worked.  On reboot the checksum on=
 the uBoot environment was bad so it used the default environment.  I just =
did a saveenv, put in the bootm command with the right flash addresses, and=
 it booted the default flash image.  Next I am going to configure to boot t=
he ltib images in ram.

So the U-Boot 1.3.3 (Dec 8 2008 - 09:51:15) MPC83XX must have been a custom=
 build that did not quite work or needed the additional things in the FDT. =
 I am going to research it before trying a later uBoot version.

So I am good to go.  Thanks for the help.

If there is a Rev C out soon I am going to wait and maybe buy the Rev C.

73 Eric
----- Start Original Message -----
Sent: Tue, 24 Feb 2009 13:55:53 -0500
From: Michael Bergandi <mbergandi@gmail.com>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image

>=20
> Hi guys,

I have the Rev B board and I have it working quite well. I'll share what
I have
discovered so far.=20

In Eric's case, the board seems suspect. There is already a Rev C of this
board, but
I am not sure if it is actually available yet. You may want to check on
that.

Regarding U-Boot, mine shipped with v. 1.3.0. The LTIB provided dts files
follow
the original dts format. There is a new dts spec and if you ever intend
to use
a mainline kernel, you will need to use the newer dts provided in the
kernel
source. Did I mention this board has at least basic support in 2.6.28 :).
I have
not determined the extent of the support though.

I have successfully used the provided U-Boot v1.3.0 to boot a 2.6.28
kernel with
the dts-v1 device tree. Hence, I hope that will clear your speculation
about the
device tree being the problem.

I have seen the same problem that you guys have seen where U-Boot gets to
the "Uncompressing kernel ..." then reboots. This happened to me when I
passed the wrong device tree .dtb. I have also had this happen if I made
a change to the kernel config. I haven't been able to determine what
exactly
that I changed that caused the problem though.

Also, if you are feeling adventurous, you can also get the latest U-Boot.
There
is a specifc branch for this board:

$ git clone git://git.denx.de/u-boot-mpc83xx.git

I haven't attempted this since I don't currently have a probe to recovery
a
bad boot loader flash.

Hope this helps,

Mike


----- End Original Message -----
