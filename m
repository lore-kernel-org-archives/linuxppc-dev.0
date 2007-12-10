Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0312CDDE9A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:43:48 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 469EF8816
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 01:43:47 +0400 (SAMT)
Date: Mon, 10 Dec 2007 23:47:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071210204705.GA31263@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
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

Here are patches to support NAND on UPM. That driver is generic for
all processors with FSL UPMs. And because of that, few more patches are
needed -- GPIO API and generic FSL UPM functions.

This is early RFC, all patches are in single thread, so everyone could
make up overall picture of what is going on. I'll split the thread by
topics after that RFC.

Ok, the patches and what they are for:

1,2,3,4. GPIO API:
------------------
Usually NAND chips exports RNB (Ready-Not-Busy) pin, so drivers
could read it and get a hint when chip is ready.

Often, WP (write protect) pin is also connected to GPIO. So, GPIO API
is mandatory for generic drivers.

OF device tree GPIOs bindings are similar to IRQs:

node {
	gpios = <bank pin bank pin bank pin>;
	gpio-parent = <&par_io_controller>;
};

"bank pin" scheme is controller specific, so controllers that want
to implement flat mappings or any other could do so.

So far I implemented GPIO API for QE and CPM2 chips.

QE GPIO API tested to work with FSL UPM NAND driver and MPC8360E-RDK
(STMicro NAND512W3A2BN6E).

CPM2 GPIO API tested to work with MPC8555E+Samsung HY27UF081G6 (LP).

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
on I2C/LBC).

[1] http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.24-rc4/2.6.24-rc4-mm1/broken-out/generic-gpio-gpio_chip-support.patch

But so far we support on-chip GPIOs only.

5 - FSL UPM infrastructure:
---------------------------
UPM address register is shared among UPMs, so we have to do
proper locking. On the other hand, if we know that specific
board using only one UPM we could bypass locking, and gain some
performance win.


6. FSL UPM NAND driver:
-----------------------
It's using FSL UPM functions and GPIO API. It does not implement
device tree partitions parsing. That issue is completely other
matter, that is, I have to factor out parsing functions from
physmap_of.c. This desires separate patch on top of the whole
series. If anyone currently working on this, let me know.


7. Example of usage.
--------------------
MPC8360E-RDK as an example.


I would appreciate any comments and suggestions, thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
