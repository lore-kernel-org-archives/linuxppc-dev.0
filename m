Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 2950867A81
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 22:54:21 +1100 (EST)
To: srinivas.surabhi@wipro.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Feb 2005 16:02:48 +0530."
	<EF9B29C78F41FA488927FCBC7750AF0E011DA5C5@hyd-mdp-msg.wipro.com>
Date: Tue, 15 Feb 2005 12:53:57 +0100
Sender: wd@denx.de
Message-Id: <20050215115402.86E49C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <EF9B29C78F41FA488927FCBC7750AF0E011DA5C5@hyd-mdp-msg.wipro.com> you wrote:
> 
> Today somehow after removing many options I build the kernel and able to
> succeed till the VFS: "Mounted root (cramfs filesystem) readonly." But
> then I am seeming "kernel panic". Actually what option has to be given
> for init. We have given init=/bin/sh but no luck.

You have to provide a working root filesystem in the first place.

> One more observation is that the U-boot bootargs are overwriting the
> Kernel boot arguments given at the time of build. Even though using

This is normal. If you use U-boot  there  is  no  need  to  have  any
pre-compiled  boot arguments; more: there is no need to use the whole
bootstrap loader which supplied these precompiled bootargs.

> setenv I removed the bootargs but still the kernel arguments given at
> the time of build using devrocket are not still active.

Just define the required bootargs in U-Boot.

> VFS: Mounted root (cramfs filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 60k init
> Warning: unable to open an initial console.
> Error -3 while decompressing!

Do not ignore this error. How big is your cramfs iage? How  much  RAM
do you have?

> 0015fd20(1928974736)->00141000(4096)

Is there any chance that you built your cramfs image on a x08 (or any
other little-endian) system and forgot  to  give  the  "-r"  (reverse
endian-ness of filesystem) option to mkcramfs??

Best regards,

Wolfgang Denk

-- 
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In the strict scientific sense we all feed on death -- even
vegetarians.
	-- Spock, "Wolf in the Fold", stardate 3615.4
