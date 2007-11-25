Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 9D0A1DDDFA
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 13:13:49 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so392217wag
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 18:13:49 -0800 (PST)
Message-ID: <9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
Date: Sat, 24 Nov 2007 21:13:40 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Access to PCI Expansion ROMs on PPC
In-Reply-To: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/24/07, Robin H. Johnson <robbat2@gentoo.org> wrote:
> Following up from initial conversation with benh in #ppc64, I did a bit
> of testing (and then a bit more).
>
> Two PCIe cards for my testing:
> a) sata_sil24 eSATA (x86 BIOS)
> b) ATI X700 graphics (x86 BIOS)
>
> I put the card into an amd64 box, found the relevant 'rom' node ($ROM) under
> /sys/device/pci*, and dumped it as follows:
> # echo 1>$ROM
> # cat $ROM >/tmp/dump
> # echo 0>$ROM
> On amd64, this produced the ROM for the cards fine (contained
> recognizable strings).
>
> I then repeated the same on my G5 (PM11,2), while the $ROM files have a
> non-zero size in sysfs (that corresponds to the size shown by lspci
> -vv), reading them always results in a 0-byte output.
>
> Is the PPC kernel broken? Does something in the PPC architecture forbid
> this? Instructions to muck with PCI code welcome.

The ROM is mapped in drivers/pci/rom.c

You could add some printks and see if there is an error and if the ROM
is accessible

        rom = ioremap(start, *size);
        if (!rom) {
                /* restore enable if ioremap fails */
                if (!(res->flags & (IORESOURCE_ROM_ENABLE |
                                    IORESOURCE_ROM_SHADOW |
                                    IORESOURCE_ROM_COPY)))
                        pci_disable_rom(pdev);
                return NULL;
        }



>
> This was under 2.6.24_rc3-git1, kernel .config available if needed.
>
> Why am I trying to access the PCI ROM? To make my newer X1900 card work
> under at least one of the newer (ati,radeonhd,avivo) drivers, that all
> try to access the ATI AtomBIOS for varying data.
>
> --
> Robin Hugh Johnson
> Gentoo Linux Developer & Infra Guy
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
