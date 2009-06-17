Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A539AB71B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 17:22:54 +1000 (EST)
Received: from mail-yx0-f198.google.com (mail-yx0-f198.google.com
	[209.85.210.198]) by ozlabs.org (Postfix) with ESMTP id 003ECDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 17:22:53 +1000 (EST)
Received: by yxe36 with SMTP id 36so104472yxe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 00:22:51 -0700 (PDT)
MIME-Version: 1.0
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 01:22:31 -0600
Message-ID: <fa686aa40906170022y703e31b3vfe6da5bfc633bf52@mail.gmail.com>
Subject: Please pull mpc5xxx & virtex merge branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here's the xilinxfb fix plus some outstanding 5xxx changes that I
didn't get to the first time around.

Cheers,
g.

The following changes since commit 313485175da221c388f6a8ecf4c30062ba9bea17:
  Geert Uytterhoeven (1):
        usb/ps3: Add missing annotations

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Anton Vorontsov (1):
      powerpc/5200: convert mpc52xx_psc_spi to use cs_control callback

Grant Likely (1):
      fbdev/xilinxfb: Fix improper casting and tighen up probe path

Wolfgang Denk (1):
      powerpc/5xxx: Add common mpc5xxx_get_bus_frequency() function

Wolfram Sang (2):
      powerpc/5200: Update pcm030.dts to add i2c eeprom and delete cruft
      powerpc/5121: make clock debug output more readable

 arch/powerpc/boot/dts/pcm030.dts                  |   26 ++--------
 arch/powerpc/include/asm/mpc52xx.h                |    2 +-
 arch/powerpc/include/asm/{mpc512x.h => mpc5xxx.h} |   10 ++--
 arch/powerpc/platforms/512x/clock.c               |   10 ++--
 arch/powerpc/platforms/512x/mpc512x.h             |    1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c      |   23 --------
 arch/powerpc/platforms/52xx/mpc52xx_common.c      |   32 +-----------
 arch/powerpc/sysdev/Makefile                      |    3 +
 arch/powerpc/sysdev/mpc5xxx_clocks.c              |   33 ++++++++++++
 drivers/ata/pata_mpc52xx.c                        |    2 +-
 drivers/i2c/busses/i2c-mpc.c                      |    2 +-
 drivers/net/fec_mpc52xx.c                         |    2 +-
 drivers/net/fec_mpc52xx_phy.c                     |    2 +-
 drivers/serial/mpc52xx_uart.c                     |    5 +-
 drivers/spi/mpc52xx_psc_spi.c                     |   22 +++-----
 drivers/video/xilinxfb.c                          |   59 ++++++++-------------
 drivers/watchdog/mpc5200_wdt.c                    |    2 +-
 include/linux/fsl_devices.h                       |    4 --
 18 files changed, 91 insertions(+), 149 deletions(-)
 rename arch/powerpc/include/asm/{mpc512x.h => mpc5xxx.h} (65%)
 create mode 100644 arch/powerpc/sysdev/mpc5xxx_clocks.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
