Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id D84FAB6F18
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 03:06:50 +1000 (EST)
Received: by iwn36 with SMTP id 36so2942806iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 02 Jul 2010 10:06:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C2CF9A7.7010801@freescale.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
	<4C2CD395.90409@freescale.com>
	<AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
	<4C2CF9A7.7010801@freescale.com>
Date: Fri, 2 Jul 2010 10:06:47 -0700
Message-ID: <AANLkTikELusybzh2uTh3KJ6QwelgSHW6HWWPLh-4Zc0b@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> =A0 =A0 =A0 =A0localbus@fa200100 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc885-localbus", "fs=
l,pq1-localbus",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "simple-bus";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D<2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D<1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D<0xfa200100 0x40>;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D<
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 0 0xfe000000 0x01000000=
 =A0 =A0// I'm not sure about
>> this?
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>;
>> =A0 =A0 =A0 =A0};
>
> Change 0xfe000000 to wherever u-boot maps your flash, and 0x01000000 to
> whatever the size of the flash localbus mapping is.
>
> Or more generally update this section to hold whatever is connected to th=
e
> localbus on your board. =A0The first cell is the chipselect.

The chipselect? Isn't it just the child-bus-addr? BTW, do we have to
define the #address-cells to 2? 1 is not enough?

SDRAM uses CS0/6, each 64MB. BDI2000 configuration is as follows.
; init memory controller
WM32    0xFA200104      0xfe000ff6      ;;OR0: Flash 32MB
WM32    0xFA200100      0xfc000001      ;;BR0: Flash at 0xFC000000,
32bit, R/W, no parity, use GPCM
WM32    0xFA20010C      0xfc000e00      ;;OR1: SDRAM 64MB, all accesses
WM32    0xFA200108      0x00000081      ;;BR1: SDRAM at 0x00000000,
32bit, R/W, no parity, use UPMA
WM32    0xFA200134      0xfc000e00      ;;OR6: SDRAM 64MB, all accesses
WM32    0xFA200130      0x04000081      ;;BR6: SDRAM at 0x04000000, 32bit, =
R/W,
no parity, use UPMA

When defining memory's reg property, can a single pair <0 0x08000000>
be enough? Or must it be <0 0x04000000 0x04000000 0x04000000>?

Thanks,
-Shawn.
