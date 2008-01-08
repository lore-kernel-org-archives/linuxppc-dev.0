Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9A601DDFB9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:34:30 +1100 (EST)
Date: Tue, 8 Jan 2008 21:43:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 0/3] PowerPC: implement support for GPIO LIB API
Message-ID: <20080108184341.GA29753@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Arnd Bergmann <arnd@arndb.de>, David Gibson <david@gibson.dropbear.id.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Thanks for the previous review and ideas. Here is the RFC for the
GPIO LIB support.

I'm using it like this:

	qe_pio_a: gpio-controller@1400 {
		#gpio-cells = <1>;
		compatible = "fsl,qe-pario-bank";
		reg = <0x1400 0x18>;
		gpio-controller;
	};

	qe_pio_e: gpio-controller@1460 {
		#gpio-cells = <1>;
		compatible = "fsl,qe-pario-bank";
		reg = <0x1460 0x18>;
		gpio-controller;
	};

	nand-flash@1,0 {
		compatible = "stmicro,NAND512W3A2BN6E", "fsl,upm-nand";
		reg = <1 0 1>;
		width = <1>;
		upm = "A";
		upm-addr-offset = <16>;
		upm-cmd-offset = <8>;
		gpios = <&qe_pio_e 18 &qe_pio_a 9>;
		wait-pattern;
		wait-write;
	};

As you can see I've split single "par_io" node into banks, thus
the benefits:
- we can handle banks of different width (Jochen Friedrich asked for
  this, IIRC. Or I've misunderstood ;-).
- we can handle banks with different paddings (no more #ifdef PPC85xx).

Also, it's possible to specify different gpio-controllers in the
gpios = <> property. gpio-specifier is controller specific.


The remaining question is about gpio.c placement. prom_parse.c doesn't
feel as the appropriate place anymore. I think of:

- drivers/gpio/of_gpio.c (driver/gpio/ is in -mm tree);
- drivers/of/gpio.c
- keep it in arch/powerpc/kernel/ (though, there is nothing
  much PowerPC specific).


So, to try these patches you'll need apply these from the -mm tree:
generic-gpio-gpio_chip-support.patch
generic-gpio-gpio_chip-support-fix.patch
generic-gpio-gpio_chip-support-gpiolib-locking-simplified.patch

Or just issue this in your working tree:

  git pull git://git.infradead.org/users/cbou/powerpc-gpio.git gpiolib

powerpc-gpio.git's gpiolib branch is galak/powerpc.git master branch +
-mm patches + these patches.


Support for CPM2 is pending.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
