Return-Path: <rider4ever@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.185])
	by ozlabs.org (Postfix) with ESMTP id 5FB2FDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 01:29:26 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so148509gvf.14
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 08:29:24 -0700 (PDT)
Message-ID: <ed84ed090805050829s72b819f0tda48ea749bb27350@mail.gmail.com>
Date: Mon, 5 May 2008 17:29:22 +0200
From: "Fabrizio Garetto" <fabrizio.garetto@gmail.com>
Sender: rider4ever@gmail.com
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: MPC52xx and SPI (native one, NOT psc)
In-Reply-To: <fa686aa40805050655j20e617edy9d69f2c351705fd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ed84ed090805050100y4d33bf05vf6ab9b73ad0547c4@mail.gmail.com>
	<fa686aa40805050655j20e617edy9d69f2c351705fd2@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, please, I'll appreciate very much.

Currently I'm working of 2.6.22 kernel version, but I can test it on
the 2.6.24 as well.
I've found also this patch that should enable the native spi on my mpc52xx
http://cba.si/slefika/kernel/patches/mpc5200-spi.patch

but I've various problems: first of all, if I select to enable that
SPI using menuconfig, the relative CONFIG_SPI_MPC5200=y is saved in
the .config file, but when I start the compilation that setting
disappears and the file is skipped.

Forcing CONFIG_SPI_MPC5200=y by hand I got the following errors:
In file included from include/linux/of_device.h:6,
                 from include/linux/of_platform.h:18,
                 from arch/ppc/include/asm/of_platform.h:15,
                 from drivers/spi/mpc5200_spi.c:24:
include/linux/of.h:39: error: expected identifier or '(' before 'void'
include/linux/of.h:39: error: expected ')' before numeric constant
include/linux/of.h:45: error: expected ')' before 'handle'
include/linux/of.h:54: error: expected identifier or '(' before 'void'
include/linux/of.h:54: error: expected ')' before numeric constant
In file included from drivers/spi/mpc5200_spi.c:24:
arch/ppc/include/asm/of_platform.h:32: error: expected ')' before 'ph'
drivers/spi/mpc5200_spi.c: In function 'mpc5200_spi_txrx':
drivers/spi/mpc5200_spi.c:215: error: implicit declaration of function 'udelay'
drivers/spi/mpc5200_spi.c: In function 'mpc5200_spi_probe':
drivers/spi/mpc5200_spi.c:251: error: implicit declaration of function
'of_address_to_resource'
drivers/spi/mpc5200_spi.c:256: error: implicit declaration of function
'irq_of_parse_and_map'
drivers/spi/mpc5200_spi.c:281: error: implicit declaration of function
'mpc52xx_find_ipb_freq'
make[2]: *** [drivers/spi/mpc5200_spi.o] Error 1
make[1]: *** [drivers/spi] Error 2
make: *** [drivers] Error 2

Regards,
F. Garetto

On Mon, May 5, 2008 at 3:55 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>
> On Mon, May 5, 2008 at 2:00 AM, Fabrizio Garetto
>  <fabrizio.garetto@gmail.com> wrote:
>  > Hello to everyone,
>  >  I was trying to enable the SPI of a lite5200 board. I've seen that
>  >  there's something related to this in
>  >  arch/powerpc/boot/dts/lite5200b.dts
>  >
>  >  >spi@f00 {
>  >  >                       device_type = "spi";
>  >  >                       compatible = "mpc5200b-spi\0mpc5200-spi";
>  >  >                       reg = <f00 20>;
>  >  >                       interrupts = <2 d 0 2 e 0>;
>  >  >                       interrupt-parent = <&mpc5200_pic>;
>  >  >               };
>  >  >
>  >
>  >  but I'm not able to find where to enable it in menuconfig. Under
>  >  device drivers -> Spi support there only the PSC SPI.
>  >  Where am I wrong?
>
>  The device tree describes the hardware; even if there isn't a driver
>  for it.  The non-PSC SPI does not have a driver right now.
>
>  I'm actually working on a driver for it *right now*.  Are you able to
>  help with testing?
>
>  Cheers,
>  g.
>
>  --
>  Grant Likely, B.Sc., P.Eng.
>  Secret Lab Technologies Ltd.
>
