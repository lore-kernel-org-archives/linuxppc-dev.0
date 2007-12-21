Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1E243DDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:26:27 +1100 (EST)
Date: Fri, 21 Dec 2007 23:28:24 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/4] PowerPC: implement GPIO API
Message-ID: <20071221202824.GA4607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
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

OF device tree GPIOs bindings are similar to IRQs:

pario0: gpio-controller@0 {
	#gpio-cells = <2>;
	num-ports = <7>;
};

device@0 {
	gpios = <bank pin bank pin bank pin>;
	gpio-parent = <&pario0>;
};

"bank pin" scheme is controller specific, so controllers that want
to implement flat mappings or any other could do so.

So far I implemented GPIO API for QE and CPM2 chips. GPIO API for
CPM1 implemented by Jochen Friedrich <jochen@scram.de>, included in
this patchset.

- QE GPIO API tested to work with FSL UPM NAND driver and
  MPC8360E-RDK (STMicro NAND512W3A2BN6E);
- CPM2 GPIO API tested to work with MPC8555E+Samsung HY27UF081G6 (LP);
- CPM1 GPIO API untested.

GPIO API is described in Documentation/gpio.txt, and these
patches are tend to support most of it.

As an additional bonus, PowerPC now gets access to few pleasing
drivers:

- drivers/leds/leds-gpio.c (we could use it to play with
  on-board LEDs);
- drivers/i2c/busses/i2c-gpio.c (generic I2C bit-banging driver);
- drivers/input/keyboard/gpio_keys.c - gpio keys (requires
  gpio_to_irq, so far not implemented);
- Could be more (I named the ones I knew about).

Also, in the upcoming kernels, there will be GPIOLIB[1] addition to
the generic GPIO API, to support off-chip GPIO expanders (like MFDs
on I2C/LBC). But so far we support on-chip GPIOs only, with single
controller built-in.

Changes since RFC:
- Implemented #gpio-cells handling;
- Per-bank spinlocks removed;
- Added a patch which implements GPIO API for CPM1;
- Few minor fixes.

Thanks,

[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc4/2.6.24-rc4-mm1/broken-out/generic-gpio-gpio_chip-support.patch

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
