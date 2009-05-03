Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 74783DDE07
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 05:26:08 +1000 (EST)
To: "Landau, Bracha" <BLandau@nds.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: help with MPC8272ADS board
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM>
References: <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM>
Date: Sun, 03 May 2009 21:26:03 +0200
Message-Id: <20090503192604.012C783420E8@gemini.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Bracha,

In message <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM> you wrote:
> 
> I'm trying to get the MPC8272ADS evaluation board up and running with
> the latest versions of u-boot and Denx linux (2.6.24).

2.6.24 is actually very old and not even close to latest. "Latest" is
(as I'm typing this) v2.6.30-rc4.

> I use the device tree file (mpc8272ads.dts) provided. Based on
> another post, I updated the MPC8260ADS.h file, changing OF_CPU from
> "cpu@0<mailto:cpu@0>" to "PowerPC,8272@0", because I was getting an
> error.

No such changes should be necessary.

I  just  tried  this  (using  both  the  kernel.org  tree,  and   our
linux-2.6-denx  repository),  with the same results (i. e. zero build
problems):

	$ export CROSS_COMPILE=ppc_6xx- 
	$ export ARCH=powerpc

	$ make CROSS_COMPILE=ppc_6xx- ARCH=powerpc mpc8272_ads_defconfig    
	$ make -j6 CROSS_COMPILE=ppc_6xx- ARCH=powerpc uImage

	$ make mpc8272ads.dtb

Then use the images in "arch/powerpc/boot/uImage" and
"arch/powerpc/boot/mpc8272ads.dtb", resp.

[Sorry, I cannot test this myself as we don't have a mpc8272_ads board
in our lab.]

> I tried booting both using a cuImage (cuImage.mpc8272ads) and a
> uImage with a device tree blob. Neither boot was successful, with no
> helpful information printed to the serial port.
> 
> Is there any change that has to be made in order to get the board to
> boot?

Maybe you did not pass the right "console=" boot  argument?  Keep  in
ind  that the serial ports are named "ttyCPM*" now, not "ttyS*" as it
used to be with very old kernel versions.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I thought my people would grow tired of killing. But you were  right,
they  see it is easier than trading. And it has its pleasures. I feel
it myself. Like the hunt, but with richer rewards.
	-- Apella, "A Private Little War", stardate 4211.8
