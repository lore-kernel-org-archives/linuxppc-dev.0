Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from ns1.gatteins.it (ns1.gatteins.it [193.58.239.94])
 by ozlabs.org (Postfix) with ESMTP id AEA302C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 04:42:12 +1100 (EST)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Add MPC5125 platform support
Date: Wed, 20 Mar 2013 18:41:51 +0100
Message-Id: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: gregkh@linuxfoundation.org,
 Matteo Facchinetti <matteo.facchinetti@sirius-es.it>, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add MPC5125 SoC in mpc512x family.

Inconvenient of MPC5125 SoC is to have differences in certain register
access between the others in the same family.

This patches add MPC5125 SoC unless adding configuration macro but
using general MPC512x kernel configuration.

Tested on Freescale MPC5125 tower system evaluation board.


Matteo Facchinetti (3):
  powerpc/512x: move mpc5121_generic platform to mpc512x_generic.
  serial/mpc52xx_uart: add PSC UART support for MPC5125 platforms.
  powerpc/mpc512x: add platform code for MPC5125.

 arch/powerpc/boot/dts/mpc5125twr.dts               |  238 ++++++++++++
 arch/powerpc/configs/mpc512x_defconfig             |    2 +-
 arch/powerpc/include/asm/mpc52xx_psc.h             |   49 +++
 arch/powerpc/platforms/512x/Kconfig                |    8 +-
 arch/powerpc/platforms/512x/Makefile               |    2 +-
 arch/powerpc/platforms/512x/clock.c                |    9 +-
 arch/powerpc/platforms/512x/mpc512x.h              |    1 +
 .../512x/{mpc5121_generic.c => mpc512x_generic.c}  |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   24 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  407 ++++++++++++++++++--
 10 files changed, 691 insertions(+), 50 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc5125twr.dts
 rename arch/powerpc/platforms/512x/{mpc5121_generic.c => mpc512x_generic.c} (98%)

-- 
1.7.10.4
