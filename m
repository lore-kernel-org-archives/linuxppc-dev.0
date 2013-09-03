Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE0032C008E
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Sep 2013 06:39:28 +1000 (EST)
Date: Tue, 3 Sep 2013 22:39:14 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20130903223914.78c7b44e@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull mpc5xxx patches for v3.12.

There are cleanups for some mpc5121 specific drivers and DTS files
in preparation to switch mpc5121 clock support to a clock driver
based on common clock framework. Additionally Sebastian fixed the
mpc52xx PIC driver so that it builds when using older gcc versions.

All these patches have already been in linux-next for a while.

Thanks,

Anatolij


The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git next

for you to fetch changes up to f2110cb961200e5c382e9d0878ded015109b5dd6:

  dts: mpc512x: prepare for preprocessor support (2013-08-24 00:18:55 +0200)

----------------------------------------------------------------
Gerhard Sittig (6):
      serial: mpc512x: cleanup clock API use
      USB: fsl-mph-dr-of: cleanup clock API use
      mtd: mpc5121_nfc: cleanup clock API use
      fsl-viu: cleanup clock API use
      powerpc: mpc512x: array decl for MCLK registers in CCM
      dts: mpc512x: prepare for preprocessor support

Sebastian Siewior (1):
      powerpc: 52xx: provide a default in mpc52xx_irqhost_map()

 arch/powerpc/boot/dts/ac14xx.dts          |    2 +-
 arch/powerpc/boot/dts/include/dt-bindings |    1 +
 arch/powerpc/boot/dts/mpc5121ads.dts      |    2 +-
 arch/powerpc/boot/dts/pdm360ng.dts        |    2 +-
 arch/powerpc/include/asm/mpc5121.h        |   18 +-----
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    3 +-
 drivers/media/platform/fsl-viu.c          |   23 ++++---
 drivers/mtd/nand/mpc5121_nfc.c            |   21 ++++---
 drivers/tty/serial/mpc52xx_uart.c         |   98 ++++++++++++++++++++++++-----
 drivers/usb/host/fsl-mph-dr-of.c          |   16 ++---
 10 files changed, 123 insertions(+), 63 deletions(-)
 create mode 120000 arch/powerpc/boot/dts/include/dt-bindings
