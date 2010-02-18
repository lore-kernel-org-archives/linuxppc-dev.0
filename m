Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 1AB72B7CC1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 17:38:05 +1100 (EST)
Received: by yxe8 with SMTP id 8so11628176yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 22:38:04 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Feb 2010 23:37:44 -0700
Message-ID: <fa686aa41002172237l1d3976avc7f88fd38755ca5e@mail.gmail.com>
Subject: Please pull mpc5xxx support for -next
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ernst Schwab <eschwab@online.de>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here's all the stuff I've got queued up for 2.6.34.  Mostly mpc5121
support, but some 5200 stuff too.  These commits have already had some
time in linux-next.

Cheers,
g.

The following changes since commit 724e6d3fe8003c3f60bf404bf22e4e331327c596:
  Linus Torvalds (1):
        Linux 2.6.33-rc8

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6.git next

Anatolij Gustschin (10):
      powerpc/mpc5121: avoid using arch_initcall for clock init
      powerpc/mpc5121: Add machine restart support
      rtc: Add MPC5121 Real time clock driver
      powerpc/mpc5121: create and register NFC device
      powerpc/mpc5121: update mpc5121ads DTS
      powerpc/mpc5121: Add default config for MPC5121
      serial: mpc52xx_uart: re-enable mpc5121 PSC UART support
      powerpc: doc/dts-bindings: document mpc5121 psc uart dts-bindings
      powerpc/mpc5121: enable support for more PSC UARTs
      powerpc/mpc5121: correct DIU compatible property

Ernst Schwab (1):
      powerpc/of: added documentation for spi chipselects

 .../powerpc/dts-bindings/fsl/mpc5121-psc.txt       |   70 +
 Documentation/powerpc/dts-bindings/fsl/spi.txt     |    7 +
 arch/powerpc/boot/dts/mpc5121ads.dts               |   55 +-
 arch/powerpc/configs/mpc512x_defconfig             | 1694 ++++++++++++++++++++
 arch/powerpc/include/asm/mpc5121.h                 |   24 +
 arch/powerpc/include/asm/mpc52xx_psc.h             |    4 +
 arch/powerpc/platforms/512x/clock.c                |    6 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c          |    3 +-
 arch/powerpc/platforms/512x/mpc5121_generic.c      |    3 +-
 arch/powerpc/platforms/512x/mpc512x.h              |    3 +
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   43 +
 drivers/rtc/Kconfig                                |   10 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-mpc5121.c                          |  387 +++++
 drivers/serial/mpc52xx_uart.c                      |  251 +++-
 drivers/video/fsl-diu-fb.c                         |    5 +
 16 files changed, 2522 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
 create mode 100644 arch/powerpc/configs/mpc512x_defconfig
 create mode 100644 arch/powerpc/include/asm/mpc5121.h
 create mode 100644 drivers/rtc/rtc-mpc5121.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
