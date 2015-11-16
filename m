Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 721731A0273
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 02:49:06 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Scott Wood <scottwood@freescale.com>, Stefan Agner <stefan@agner.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Krill <ben@codiert.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] serial: fixes and cleanups
Date: Mon, 16 Nov 2015 16:48:08 +0100
Message-Id: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've had these patches sitting in my randconfig branch for a while,
but have now gotten around to sending them. The first three are
bug fixes for harmless problems that have shown up recently,
so they should go into 4.4.

The other three are part of a cleanup that we've been meaning
to do for a while but that is not urgent at all.

Arnd Bergmann (6):
  serial: export fsl8250_handle_irq
  serial: fsl-lpuart: move SERIAL_EARLYCON dependency to console
  serial: mid8250: select CONFIG_RATIONAL
  serial: remove NWP serial support
  serial: of: CONFIG_SERIAL_8250 is always set
  serial: 8250: move of_serial code to 8250 directory

 drivers/tty/serial/8250/8250_fsl.c                 |   1 +
 drivers/tty/serial/{of_serial.c => 8250/8250_of.c} |  32 --
 drivers/tty/serial/8250/Kconfig                    |  10 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |  29 +-
 drivers/tty/serial/Makefile                        |   2 -
 drivers/tty/serial/nwpserial.c                     | 477 ---------------------
 include/linux/nwpserial.h                          |  18 -
 include/uapi/linux/serial_core.h                   |   2 +-
 9 files changed, 14 insertions(+), 558 deletions(-)
 rename drivers/tty/serial/{of_serial.c => 8250/8250_of.c} (92%)
 delete mode 100644 drivers/tty/serial/nwpserial.c
 delete mode 100644 include/linux/nwpserial.h

-- 
2.1.0.rc2

Cc: Scott Wood <scottwood@freescale.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Krill <ben@codiert.org>
Cc: linuxppc-dev@lists.ozlabs.org
