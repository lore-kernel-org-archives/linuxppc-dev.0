Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id 7B2CA2BF0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 19:55:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 27 Oct 2004 11:53:38 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0C65@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Neil Wilson" <NWilson@Airspan.com>,
	<linuxppc-embedded@ozlabs.org>
Cc: 
Subject: RE: 440GX + peek/poke utility
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>I probably just wasn't looking hard enough but would anyone know if a
>peek/poke type command line utility would exist for accessing physical
>addresses under Linux on a 440GX board ?  Thanks.

I have such, and I wanted to contribute them to busybox. My peek/poke
even support hotplug (as long as your hardware can do so :-).

On a background note, we used to access physical addresses under U-Boot, =

but the interface was not very confortable, especially for the hardware
guys who type with 2 fingers. They were quite happy when we switched to
Linux (full command line editing, shell scripts under NFS, remote =
operation,
etc.). This is nowadays possible thanks to all the opensource =
hardworkers
who make Linux ported quickly after U-Boot, if not at the same time.
Be they thanked all. REM: one has to know that accessing directly =
physical=20
addresses under an active OS like Linux can add some noise which does =
not
exist under a monitor like U-Boot.

Before contributing, I was wondering what would be a good command line=20
interface. Right now, here it is:

	peek <b|w|l> <addr> [count]
	poke <b|w|l> <addr> <data>

The base of the args is automatically chosen by strtoul().

The memory access is done by this snippet (code is GPL)
 =
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acces=
singPeripheralsFromUserSpace

I haven't contributed the code yet because I'm not satisfied with=20
the syntax. I would prefer setpci syntax, e.g: "3c.l=3D1,2,3" which=20
would translates to "write longword 1 to location at 3c, 2 at 40=20
and 3 at 44", and allow several on the command line.
As you often call several times peek/poke in a shell script, time=20
between I/O can be too significant and fall in side effects compared=20
to a real driver. Thus, ability to gather several writes would be nice.
What do you all think? Do you have other ideas?

Also currently missing:
* 64 bit support (addr on 64bit archs, data type 'q')
* flag to specify little/big endian operation
* poke of more than one value (cf. setpci syntax)
* option to peek/poke binary values (a kind of dd) to stdin/stdout
  so they can be piped with od -x, redirected to a file, etc.
* option to choose the base of values output by peek
* option to set a range with same value/pattern
* option -f to perform the operation on a file instead of /dev/mem
* and maybe syntax sugar to do atomic +1/-1 on a hardware reg,=20
  set_bit/clear_bit (ala linux/include/asm/bitops.h), ..

Wishlist anyone?

I guess it would be nice to have peek/poke working also for PCI devices
(ie. addr relative to PCI ressource base) and PC ISA I/O bus. While the =
PCI=20
access may be addressed by setpci, I don't see much activity with=20
the PC ISA I/O bus, except with parallel port tinkering :)


Best Regards

--=20
Stephane  [... speaking only on my own behalf]
