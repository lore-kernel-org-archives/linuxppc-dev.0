Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 3928DDDE3E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:40:13 +1100 (EST)
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080114152859.GA26907@ld0162-tx32.am.freescale.net>
References: <20080111200705.GA696@loki.buserror.net>
	<1200234372.3990.24.camel@neuromancer.mindspace>
	<20080114152859.GA26907@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 14 Jan 2008 22:40:07 +0000
Message-Id: <1200350407.4061.19.camel@neuromancer.mindspace>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-01-14 at 09:28 -0600, Scott Wood wrote:
> On Sun, Jan 13, 2008 at 02:26:12PM +0000, Bryan O'Donoghue wrote:
> > I've applied your code against Linus' git v2.6.26-rc7 as at today.
> > I have to apply 
> 
> It should apply against paulus's tree.
> 
> > make adder87x-uboot_defconfig
> > 
> > make uImage
> 
> make zImage, not uImage.

Will try.

> > cp arch/powerpc/boot/uImage /tftpboot - which is my tftpd root
> > directory.
> 
> Use cuImage.8xx, not uImage.
> 
> > In U-Boot then.
> > 
> > => tftpboot 0x400000 uImage
> > => bootm 0x400000
> 
> 0x400000 is where u-boot is going to want to relocate the image to, so
> loading the uImage there may not work.

Hmm, some old code I did to make Linux boot from the former ppc stuff
works fine to the loading and booting @ 0x4000000 - this step is pretty
much fine, I think.

> Yes, a uImage target will be expecting to be handed a device tree.  The
> cuImage target has a device tree embedded and accepts the old-style bd_t.

Ah.

This explains eveything then.. there _is_ a magic image and I haven't
been booting it !

Typical.

I'll give the 8xx-centric ucImage a go.

> > /* pass open firmware flat tree */
> > #define CONFIG_OF_LIBFDT      1
> > #undef  CONFIG_OF_FLAT_TREE
> > #define CONFIG_OF_BOARD_SETUP 1
> > #define CONFIG_OF_HAS_BD_T    1
> > #define CONFIG_OF_HAS_UBOOT_ENV       1
> > 
> > #define OF_CPU                        "PowerPC,875 at 0"
> > #define OF_SOC                        "soc875 at ff000000"
> > #define OF_TBCLK              (bd->bi_busfreq / 4)
> 
> You'll probably need some 8xx-specific code if you want to go this route. 
> You'd also need to change the bootm command line to the three-argument
> version, with the third argument being the address of the device tree
> blob (the second argument can be - if there's no initrd).

Ah OK, I see so the procedure would be to dtc a dts representing the
Adder.

Download both this and a uImage ... and then as you say pass the address
of the blob to Linux via U-Boot.

It occurs to me that this type of procedure should really be added to
the Documentation... 

There's no mention of it in the Linux documentation, nor in the u-boot
documentation and uncle Google was not informative for the types of
searches I was doing....

Somebody - possibly even me, since I'm mentioning it - should write a
copule of paragraphs on booting a ucImage with a of-blob and add it to
both U-Boot and Linux..

> If you're not comfortable with the device tree stuff, I recommend just
> using cuImage for now.

Indeed.

Thanks for the response Scott. I'll try out the ucImage and all going
well with that will try the three parameter Linux + blob based on
the .dts, hopefully over the next three or four days....

If I'm unlucky I might bug you again... and if I have more luck, I'll do
a follow up on the list.

Happy Monday !

Regards,
Bryan
