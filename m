Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 6E434B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 10:53:08 +1100 (EST)
Received: by yxe9 with SMTP id 9so1420112yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 15:53:06 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 16:52:42 -0700
Message-ID: <fa686aa40912111552m28d1cc40we072cebef675f100@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] powerpc: nintendo wii support
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

Hi Albert.

I'm ready to pick up your Gamecube and Wii patch sets for merging.
You seem to have 4 distinct patch sets.  What order do they need to be
applied in, and what kernel version are they based on?

Thanks,
g.

On Thu, Dec 3, 2009 at 3:47 PM, Albert Herranz <albert_herranz@yahoo.es> wr=
ote:
> The following patches add the base support for the Nintendo Wii
> video game console on the powerpc arch.
>
> The following is included:
> - a device tree source
> - bootwrapper support
> - recognition of the Broadway processor
> - native interrupt controller support
> - platform support
> - default configuration
>
> With these patches the video game console can fully boot up to the
> root filesystem mount phase.
>
> Note that at this stage the video game console will _only_ use the
> first contiguous memory range (MEM1, 24MB) as RAM.
> Changes needed to support the second memory range (MEM2, 64MB) will
> be posted separately to simplify the review and possible merging.
>
> Albert Herranz (6):
> =A0powerpc: wii: device tree
> =A0powerpc: wii: bootwrapper bits
> =A0powerpc: broadway processor support
> =A0powerpc: wii: hollywood interrupt controller support
> =A0powerpc: wii: platform support
> =A0powerpc: wii: default config
>
> =A0.../powerpc/dts-bindings/nintendo/wii.txt =A0 =A0 =A0 =A0 =A0| =A0184 =
+++
> =A0arch/powerpc/boot/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A03 +-
> =A0arch/powerpc/boot/dts/wii.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0218 +++
> =A0arch/powerpc/boot/wii-head.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0142 ++
> =A0arch/powerpc/boot/wii.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 46 +
> =A0arch/powerpc/boot/wrapper =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/configs/wii_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1=
406 ++++++++++++++++++++
> =A0arch/powerpc/kernel/cputable.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A06 +-
> =A0arch/powerpc/platforms/embedded6xx/Kconfig =A0 =A0 =A0 =A0 | =A0 =A08 =
+
> =A0arch/powerpc/platforms/embedded6xx/Makefile =A0 =A0 =A0 =A0| =A0 =A01 =
+
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.c =A0 =A0 =A0| =A0241 ++++
> =A0arch/powerpc/platforms/embedded6xx/hlwd-pic.h =A0 =A0 =A0| =A0 22 +
> =A0arch/powerpc/platforms/embedded6xx/wii.c =A0 =A0 =A0 =A0 =A0 | =A0195 =
+++
> =A013 files changed, 2469 insertions(+), 5 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/nintendo/wii.txt
> =A0create mode 100644 arch/powerpc/boot/dts/wii.dts
> =A0create mode 100644 arch/powerpc/boot/wii-head.S
> =A0create mode 100644 arch/powerpc/boot/wii.c
> =A0create mode 100644 arch/powerpc/configs/wii_defconfig
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h
> =A0create mode 100644 arch/powerpc/platforms/embedded6xx/wii.c
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
