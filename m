Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 8E62A10082F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:48:56 +1100 (EST)
Received: by yxe9 with SMTP id 9so4905396yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 14:48:54 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 15:48:34 -0700
Message-ID: <fa686aa40911221448y7b803e98y6effa6f86a28652f@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] powerpc: nintendo gamecube and wii support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> The following patches add the base support for the Nintendo GameCube
> and Wii video game consoles on the powerpc arch.

w00t!

Per-patch review to follow, but this is great.  Thanks!

g.

>
> For each video game console, the following is included:
> - a device tree source
> - bootwrapper support
> - udbg console option
> - early udbg console option
> - interrupt controller support
> - platform support
>
> The Nintendo Wii patches also include support for:
> - recognition of the broadway processor
> - ipc communication with the open source 'mini' firmware replacement
>
> With these patches both video game consoles can fully boot up to the
> root filesystem mount phase.
>
> Albert Herranz (19):
> =A0powerpc: gamecube/wii: usbgecko bootwrapper console support
> =A0powerpc: gamecube: device tree
> =A0powerpc: gamecube: bootwrapper bits
> =A0powerpc: wii: device tree
> =A0powerpc: wii: bootwrapper bits
> =A0powerpc: gamecube/wii: introduce GAMECUBE_COMMON
> =A0powerpc: gamecube/wii: declare as non-coherent platforms
> =A0powerpc: gamecube/wii: do not include PCI support
> =A0powerpc: gamecube/wii: udbg support for usbgecko
> =A0powerpc: gamecube/wii: early debugging using usbgecko
> =A0powerpc: gamecube/wii: flipper interrupt controller support
> =A0powerpc: gamecube: platform support
> =A0powerpc: gamecube: default config
> =A0powerpc: allow ioremap within reserved fake ram regions
> =A0powerpc: broadway processor support
> =A0powerpc: wii: hollywood interrupt controller support
> =A0powerpc: wii: bootmii starlet 'mini' firmware support
> =A0powerpc: wii: platform support
> =A0powerpc: wii: default config
>
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/powerpc/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A08 +
> =A0arch/powerpc/boot/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A07 +-
> =A0arch/powerpc/boot/dts/gamecube.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0135 ++
> =A0arch/powerpc/boot/dts/wii.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0244 ++++
> =A0arch/powerpc/boot/gamecube.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 78 ++
> =A0arch/powerpc/boot/ugecon.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0128 ++
> =A0arch/powerpc/boot/ugecon.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 25 +
> =A0arch/powerpc/boot/wii.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0173 +++
> =A0arch/powerpc/boot/wrapper =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A03 +
> =A0arch/powerpc/configs/gamecube_defconfig =A0 =A0 =A0 =A0 =A0 =A0| 1061 =
+++++++++++++++
> =A0arch/powerpc/configs/wii_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1=
406 ++++++++++++++++++++
> =A0arch/powerpc/include/asm/starlet-mini.h =A0 =A0 =A0 =A0 =A0 =A0| =A017=
5 +++
> =A0arch/powerpc/include/asm/starlet.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 26 +
> =A0arch/powerpc/include/asm/udbg.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
> =A0arch/powerpc/kernel/cputable.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 28 +-
> =A0arch/powerpc/kernel/head_32.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 21 +
> =A0arch/powerpc/kernel/udbg.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +
> =A0arch/powerpc/mm/pgtable_32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 19 +-
> =A0arch/powerpc/platforms/Kconfig.cputype =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +-
> =A0arch/powerpc/platforms/embedded6xx/Kconfig =A0 =A0 =A0 =A0 | =A0 57 +
> =A0arch/powerpc/platforms/embedded6xx/Makefile =A0 =A0 =A0 =A0| =A0 =A06 =
+
> =A0arch/powerpc/platforms/embedded6xx/flipper-pic.c =A0 | =A0247 ++++
> =A0arch/powerpc/platforms/embedded6xx/flipper-pic.h =A0 | =A0 25 +
> =A0arch/powerpc/platforms/embedded6xx/gamecube.c =A0 =A0 =A0| =A0112 ++
> =A0arch/powerpc/platforms/embedded6xx/gamecube_dev.c =A0| =A0 34 +
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.c =A0 =A0 =A0| =A0238 ++++
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.h =A0 =A0 =A0| =A0 22 +
> =A0arch/powerpc/platforms/embedded6xx/starlet-mipc.c =A0| 1053 ++++++++++=
+++++
> =A0arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c | =A0318 +++++
> =A0arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h | =A0 36 +
> =A0arch/powerpc/platforms/embedded6xx/wii.c =A0 =A0 =A0 =A0 =A0 | =A0270 =
++++
> =A0arch/powerpc/platforms/embedded6xx/wii_dev.c =A0 =A0 =A0 | =A0 47 +
> =A033 files changed, 5988 insertions(+), 21 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/gamecube.dts
> =A0create mode 100644 arch/powerpc/boot/dts/wii.dts
> =A0create mode 100644 arch/powerpc/boot/gamecube.c
> =A0create mode 100644 arch/powerpc/boot/ugecon.c
> =A0create mode 100644 arch/powerpc/boot/ugecon.h
> =A0create mode 100644 arch/powerpc/boot/wii.c
> =A0create mode 100644 arch/powerpc/configs/gamecube_defconfig
> =A0create mode 100644 arch/powerpc/configs/wii_defconfig
> =A0create mode 100644 arch/powerpc/include/asm/starlet-mini.h
> =A0create mode 100644 arch/powerpc/include/asm/starlet.h
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/gamecube_dev.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/starlet-mipc.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.h
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/wii_dev.c
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
