Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 254CFDDE3D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 02:30:28 +1100 (EST)
Date: Mon, 14 Jan 2008 09:28:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-ID: <20080114152859.GA26907@ld0162-tx32.am.freescale.net>
References: <20080111200705.GA696@loki.buserror.net>
	<1200234372.3990.24.camel@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200234372.3990.24.camel@neuromancer.mindspace>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 13, 2008 at 02:26:12PM +0000, Bryan O'Donoghue wrote:
> I've applied your code against Linus' git v2.6.26-rc7 as at today.
> I have to apply 

It should apply against paulus's tree.

> make adder87x-uboot_defconfig
> 
> make uImage

make zImage, not uImage.

> cp arch/powerpc/boot/uImage /tftpboot - which is my tftpd root
> directory.

Use cuImage.8xx, not uImage.

> In U-Boot then.
> 
> => tftpboot 0x400000 uImage
> => bootm 0x400000

0x400000 is where u-boot is going to want to relocate the image to, so
loading the uImage there may not work.

> Which doesn't boot.
> 
> Attaching a BDI2000 to the target board I see that the kernel is
> panicing somewhere around line 104 of arch/powerpc/kernel/prom.c in
> of_scan_flat_dt - presumably because the kernel cannot find an
> OpenFirmware tree..

Yes, a uImage target will be expecting to be handed a device tree.  The
cuImage target has a device tree embedded and accepts the old-style bd_t.

> I admit not understanding everything I should about where the output
> of .dts & dtc "go" with respect to booting Linux.... but, didn't want to
> ask on the list - lest I display a "lack of knowledge" ...

Nothing wrong with asking...  doing so on the list just means a larger
pool of people to respond, and that others with the same question can see
the answer.

> /* pass open firmware flat tree */
> #define CONFIG_OF_LIBFDT      1
> #undef  CONFIG_OF_FLAT_TREE
> #define CONFIG_OF_BOARD_SETUP 1
> #define CONFIG_OF_HAS_BD_T    1
> #define CONFIG_OF_HAS_UBOOT_ENV       1
> 
> #define OF_CPU                        "PowerPC,875 at 0"
> #define OF_SOC                        "soc875 at ff000000"
> #define OF_TBCLK              (bd->bi_busfreq / 4)

You'll probably need some 8xx-specific code if you want to go this route. 
You'd also need to change the bootm command line to the three-argument
version, with the third argument being the address of the device tree
blob (the second argument can be - if there's no initrd).

If you're not comfortable with the device tree stuff, I recommend just
using cuImage for now.

-Scott
