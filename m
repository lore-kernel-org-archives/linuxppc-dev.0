Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF88BDE38D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Aug 2008 01:47:20 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7FFlFPC020748 for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 08:47:15 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m7FFlECv013959
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 10:47:14 -0500 (CDT)
Date: Fri, 15 Aug 2008 10:47:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: liran raz <liranrazlinux@gmail.com>
Subject: Re: flash partitioning
Message-ID: <20080815154713.GA1790@ld0162-tx32.am.freescale.net>
References: <e3b3ab5c0808150723o5a4ff1f4je677c7a4475f89b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3b3ab5c0808150723o5a4ff1f4je677c7a4475f89b7@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 15, 2008 at 10:23:29AM -0400, liran raz wrote:
>  localbus@f0010100 {
>   compatible = "fsl,mpc8272-localbus",
>                "fsl,pq2-localbus";
>   #address-cells = <2>;
>   #size-cells = <1>;
>   reg = <f0010100 40>;
> 
>   ranges = <0 0 fc000000 04000000>;
>         };
> 
> flash@fc000000 {
>                 device_type = "rom";
>                 compatible = "direct-mapped";
>                 probe-type = "CFI";
>   reg = <fc000000 04000000>;
>   bank-width = <4>;
>   device-width = <2>;
>   #address-cells = <1>;
>   #size-cells = <1>;
>                 partitions = <0 200000
>                               2000000 a00000
>                               c000000 a00000
>                               16000000 600000
>                               1c000000 e00000
>                               2a000000 600000
>                               30000000 e00000
>                               3e000000 100000
>                               3f000000 80000
>                               3f800000 40000
>                               3fc00000 40000>;
>                 partition-names =
> "part01","part02","part03","part04","part05","part06","part07","part08","part09","part10","part11";
>  };

This is an obsolete binding; please use the current one described in
Documentation/powerpc/booting-without-of.txt, and demonstrated in the
current device tree files.

> I can't see the different partitions linked to the /dev/mtd<x>
> devices in the startup messages. When testing the devices
> I see that only /dev/mtd0 is actually linked to the beginning
> of the flash. (other /dev/mtd1 etc.. can't be opened).
> I included below also the relevant startup messages.
> Does anyone have any idea what is wrong with my flash
> configuration format?
> Thanks, Liran.
> 
> Linux version: 2.6.24
> Processor: mpc8272
> Startup messages:
> physmap platform flash device: 04000000 at fc000000
> physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> physmap-flash.0: CFI does not contain boot bank location. Assuming top.
> number of CFI chips: 1
> cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.

You're using physmap; you need to use physmap_of.  You may need to use a
newer kernel, as well.

-Scott
