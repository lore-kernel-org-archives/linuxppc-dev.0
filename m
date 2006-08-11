Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3681F67BC4
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 07:10:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] Adding MTD to device tree
Date: Fri, 11 Aug 2006 23:10:40 +0200
References: <20060614213643.137680b8@vitb.ru.mvista.com>
	<20060709001435.7a94294e@localhost.localdomain>
	<44DCA2BF.1030002@ru.mvista.com>
In-Reply-To: <44DCA2BF.1030002@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200608112310.41110.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 August 2006 17:31, Sergei Shtylyov wrote:
> + =A0 h) MTD nodes
> +
> + =A0 Memory Technology Devices are flash, ROM, and similar chips, often =
used
> + =A0 for solid state file systems on embedded devices.
> +
> + =A0 Required properties:
> +
> + =A0 =A0- device_type : has to be "mtd"
> + =A0 =A0- compatible : Should be the name of the MTD driver. Currently, =
this is
> + =A0 =A0 =A0most likely to be "physmap".
> + =A0 =A0- reg : Offset and length of the register set for the device.

I would prefer to call them something different in the device tree.
The name 'mtd' is very specific to Linux, but the device tree
is a more generic concept.

I understand that the booting-without-of.txt file is by definition
Linux specific as well, but we should be prepared for making parts
of it a OS independent binding at the point where we put the same
device nodes into actual OF implementations that able to boot
different operating systems.

I would prefer a naming that has=20

   Required properties:
    - device_type : one of "nand-flash", "nor-flash", or "rom".
    - model : an identifier for the actual controller chip used.
    - compatible : Should be the name of the MTD driver. For
      type "rom", this is most likely "physmap".

	Arnd <><
