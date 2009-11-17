Return-Path: <dbaryshkov@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 30A36B7B7C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 02:42:36 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so64691fga.3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 07:42:33 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
Subject: [RFC 0/5] Rework OpenFirmware GPIO handling
Date: Tue, 17 Nov 2009 18:42:21 +0300
Message-Id: <1258472546-31343-1-git-send-email-dbaryshkov@gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an RFC serie of patches containing rework of OpenFirmware GPIO binding.

It permits very simple binding of most i2c/spi/etc. GPIO expanders (e.g.
to use pcf8574x driver I had only to patch in support for working w/o platform
data, no OF-specific code at all).

Dmitry Eremin-Solenikov (5):
      Rework OpenFirmware GPIO handling
      mcu_mpc8349emitx: port to new of gpio interface
      mpc8xxx_gpio: port to new of gpio interface
      simple_gpio: port to new of gpio interface
      qe_gpio: port to new of gpio interface

 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   11 +++---
 arch/powerpc/sysdev/mpc8xxx_gpio.c             |    2 +-
 arch/powerpc/sysdev/qe_lib/gpio.c              |    4 +-
 arch/powerpc/sysdev/simple_gpio.c              |    2 +-
 drivers/gpio/gpiolib.c                         |    6 +++
 drivers/of/gpio.c                              |   42 ++++++++++++++++++++---
 include/asm-generic/gpio.h                     |   19 +++++++++++
 include/linux/of_gpio.h                        |   29 +++++++++-------
 8 files changed, 86 insertions(+), 29 deletions(-)
