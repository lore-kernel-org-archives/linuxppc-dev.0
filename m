Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 27681DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 00:43:53 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2282993wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 07:43:52 -0700 (PDT)
Message-ID: <fa686aa40708280743i7b3b4ef3g9df015e4be39a9cd@mail.gmail.com>
Date: Tue, 28 Aug 2007 08:43:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46D42D40.9040204@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de> <46D2CFFB.6050602@fz-juelich.de>
	<fa686aa40708270719s1fd230e9g188948ef02b3eda7@mail.gmail.com>
	<46D41298.7060109@fz-juelich.de>
	<fa686aa40708280606p67fd74p9287d041d955c538@mail.gmail.com>
	<46D4221D.8030500@fz-juelich.de>
	<fa686aa40708280630x67856334qaf2e0dd59ecb95bf@mail.gmail.com>
	<46D4257C.7060208@fz-juelich.de>
	<fa686aa40708280655mf0c08cct43eb9dbd75452690@mail.gmail.com>
	<46D42D40.9040204@fz-juelich.de>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> Okay, im really blind i think, so i started again :
>
> - 2.6.22 kernel from kernel.org
> - cp /arch/ppc/configs/ml300_defconfig .config
> - edit Makefile to use ARCH=3Dppc and CROSS_COMPILE=3Dpowerpc-405-linux-g=
nu-
> - copy xparams
> - make menuconfig -> no SYSACE blockdevice :((( *aaaaargh*

grant@trillian:~/linux-hacking/linux-2.6$ grep SYSACE drivers/block/Kconfig=
 -A 6
config XILINX_SYSACE
        tristate "Xilinx SystemACE support"
        depends on 4xx
        help
          Include support for the Xilinx SystemACE CompactFlash interface

>
> i will try the grant kernel now :)
>
> G
>
>
> Grant Likely wrote:
> > On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> >
> >> Grant Likely wrote:
> >>
> >>> On 8/28/07, schardt <g.schardt@fz-juelich.de> wrote:
> >>>
> >>>
> >>>> Grant Likely wrote:
> >>>>
> >>>>
> >>>>> You've got 2 choices:
> >>>>> 1. use the new sysace driver; it's already in mainline.  The new
> >>>>> driver is faster, but it doesn't handle hotswap of the CF card (yet=
)
> >>>>>
> >>>>>
> >>>>>
> >>>> But where in menuconfig could i find the sysace driver ? i'm blind, =
i
> >>>> think :)
> >>>>
> >>>>
> >>> Which version of kernel are you using?  The new sysace driver was
> >>> merged into 2.6.22
> >>>
> >>>
> >>>
> >> linux-2.6.22.5
> >>
> >
> > Should be under drivers->block devices then.
> >
> >
> >>>>> 2. use the EDK driver; easiest way is to use my tree which already =
hasGrant Likely <grant.likely@secretlab.ca>
> >>>>> it merged:  http://git.secretlab.ca
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>> i made an EDK update and now i have the linux_2_2 os in the software
> >>>> options. the bsp with all drivers is generated.
> >>>> and now ?
> >>>>  - copy to kernel tree
> >>>>  - use the xmake  to build the kernel, or make ?
> >>>>
> >>>>
> >>> Grant Likely <grant.likely@secretlab.ca>
> >>> Don't use EDK to build you're kernel.  It's too fragile and you need
> >>> to use the *exact* version of kernel that EDK expects.  You're better
> >>> off to manually copy the xparams file from the generated BSP.  (ie.
> >>> Don't let EDK know where your real kernel source tree is)
> >>>
> >>>
> >> wuh ? i dont need all the driver from the generatet bsp files ? what
> >> about the gpios and leds  ?
> >>
> >
> > Most drivers are already in my tree; any that are missing you can copy
> > over manually.
> >
> >
> >> i compile the kernel with a self made cross toolchain, not with the ed=
k.
> >> until now i copied the bsp files into the kernel tree (modfied some
> >> defines) und compile with "make zImage". But know with the linux_2_6
> >> option there is some more stuff in the bsp directory and i don't know
> >> what to do with :)
> >>
> >>
> >>>> and why is there no dokumentation :)
> >>>>
> >>> Care to write some?
> >>>
> >>>
> >> huh, not really :)
> >> im just a little newbie
> >>
> >
> > best way to learn.  :-)
> >
> > g.
> >
>
>
>
> -------------------------------------------------------------------------=
----------------
> -------------------------------------------------------------------------=
----------------
> Forschungszentrum J=FClich GmbH
> 52425 J=FClich
>
> Sitz der Gesellschaft: J=FClich
> Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
> Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stell=
v.
> Vorsitzender)
> -------------------------------------------------------------------------=
----------------
> -------------------------------------------------------------------------=
----------------
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
