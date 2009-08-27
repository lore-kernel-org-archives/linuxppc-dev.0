Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 87AE6B7C29
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 23:11:56 +1000 (EST)
To: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: LITE5200 configuration
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>
References: <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>
Date: Thu, 27 Aug 2009 15:11:51 +0200
Message-Id: <20090827131151.537EC833DBD2@gemini.denx.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear "FIXED-TERM Seeh Thomas (BEG/EMS1)",

In message <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com> you wrote:
>
> I'll try to run a 2.6.31-rc7 kernel on my Lite5200 board.

Is this really a Lite5200, or is it a Lite5200B?

Hint: if U-Boot prints something like "CPU: MPC5200B v2.2, Core v1.4"
then its a 5200B, and thus a Lite5200 board.

> For the device tree I use lite5200.dts and compiled it simply with
> 
>         make ARCH=powerpc CROSS_COMPILE=ppc_6xx- lite5200.dtb

For a Lite5200B you should use the lite5200b device tree.

> But I'm not sure what configuration for the kernel I should choose. There is no
> lite5200_defconfig only one for the lite5200b.

Rigth. Because there are virtually no lite5200 boards out there.

> I tried it with mpc5200_defconfig and lite5200b_defconfig, but I'm not sure which
> is the right way.

Both will work. On a Lite5200 board I would use lite5200b_defconfig,
though.

> For compiling the kernel I use:
>
>         make ARCH=powerpc CROSS_COMPILE=ppc_6xx- "CONFIG_FILE"

That's:

	make ARCH=powerpc CROSS_COMPILE=ppc_6xx- mrproper
	make ARCH=powerpc CROSS_COMPILE=ppc_6xx- 52xx/lite5200b_defconfig

>         make ARCH=powerpc CROSS_COMPILE=ppc_6xx- uImage
>         make ARCH=powerpc CROSS_COMPILE=ppc_6xx- modules
>         make ARCH=powerpc CROSS_COMPILE=ppc_6xx- modules_install


> I use U-Boot 2009.06, with the following settings for bootup:

Looks as if you have a Rev. B CPU with the wrong device tree.

Unfortunaltey you omit the interesting part (i. e. the U-Boot boot
message) which would contain this important piece of information.

> --_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_
> Content-Type: text/html; charset"iso-8859-1"
> Content-Transfer-Encoding: quoted-printable

And *please* do not post HTML to mailing lists. Never ever do that.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I ever needed a brain transplant, I'd choose a teenager's  because
I'd want a brain that had never been used.
