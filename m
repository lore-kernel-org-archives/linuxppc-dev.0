Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5ED6567A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 04:38:09 +1100 (EST)
In-Reply-To: <4227400A.2040704@anagramm.de>
References: <4227400A.2040704@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <efa0dd16adf3fd276dbcf160d03486c8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 3 Mar 2005 11:38:01 -0600
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: ppcembed Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel 2.6.11 SERIAL_PORT_DFNS broken in MPC8540_ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ahh, this is because we dont build the boot code for 85xx.  Since the=20
only bootloader I'm aware of is u-boot, we do the following:

$ make uImage

- kumar

On Mar 3, 2005, at 10:49 AM, Clemens Koller wrote:

> Hello, Kumar,
>
> I guess you are the right person to help me with the MPC85xx devices
>  and platforms.
>  Maybe you remember that I use a MPC8540 on the Board from Microsys.
>  (www.microsys.de).
>
> The Problem: 2.6.11 (as well as 2.6.11-rc4) breaks due to a
>  missing SERIAL_PORT_DFNS for mpc8540_ads in ns16550:
>
> root@ecam:/share/kernel/linux$ make
>  =A0=A0 CHK=A0=A0=A0=A0 include/linux/version.h
> make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
>  =A0=A0 CHK=A0=A0=A0=A0 include/linux/compile.h
> =A0=A0 CHK=A0=A0=A0=A0 usr/initramfs_list
> make[1]: `arch/ppc/boot/images/uImage' is up to date.
>  =A0=A0 CC=A0=A0=A0=A0=A0 arch/ppc/boot/common/ns16550.o
> arch/ppc/boot/common/ns16550.c:20: error: `SERIAL_PORT_DFNS' =
undeclared
> here (not in a function)
>  arch/ppc/boot/common/ns16550.c:20: error: initializer element is not
> constant
>  arch/ppc/boot/common/ns16550.c:20: error: (near initialization for
>  `rs_table[0]')
>  make[2]: *** [arch/ppc/boot/common/ns16550.o] Error 1
>  make[1]: *** [arch/ppc/boot/common] Error 2
>  make: *** [zImage] Error 2
>
>
>
> Well, I see that you try to get rid of the mess... but I still
>  didn't understand all your changes and the different flavors of
>  the platforms. (Uses the SBC8560 non-std. serial ports on external
>  interrupts? But all the others are 'normal' MPC85xx_DUART types?)
>
> STD_SERIAL_PORT_DFNS are also missing... so, how can I tell that
>  I want to use the same as I did in 2.6.10? Can I use STD_UART_OP?
> Or is it deprecated to use an extra define if I don't have any
>  special non std. hardware.
>
> What is the best way for me to integrate my board (which will be used
>  in another system with some more PCI devices not part of the Microsys
>  platform) into your platform / device structures?
>
> Currently, only minor changes were necessary to get 2.6.10 mpc8540ads
>  working with my board. I needed to change only
>  the PHY addresses (ids) on the FECs)
>  and the PCI Interrupt routing (IDSEL -> IRQ ABCD)
>  as they are wired up slightly different.
>
>
>
> Best greets,
>
> Clemens Koller
> _______________________________
> R&D Imaging Devices
>  Anagramm GmbH
>  Rupert-Mayer-Str. 45/1
>  81379 Muenchen
>  Germany
>
> http://www.anagramm.de
> Phone: +49-89-741518-50
>  Fax: +49-89-741518-19
