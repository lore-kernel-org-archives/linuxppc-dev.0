Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 8E394B7B91
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 09:58:15 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:43 +0100
Message-Id: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: updates to the mscan-driver in net-next
Cc: socketcan-core@lists.berlios.de, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

here are the patches which fix the issues for the mscan & mpc52xx_can drivers
raised by Wolfgang Grandegger and Grant Likely. They are based on the initial
version of the drivers I sent a few days ago. Devicetree-discuss has been added
for the property changes. I will also update my branch on pengutronix.de
tomorrow, I seem to have issues when trying that from home :(^

Regards,

   Wolfram


Wolfram Sang (11):
      net/can/mscan: move defines into .h file
      net/can/mscan: trivial fixes
      net/can/mscan: drop support for CAN_MODE_{SLEEP|STOP}
      net/can/mscan: use {clr|set}bits8 macros
      net/can/mscan: fix function annotations
      net/can/mscan: drop assignment in while-construct
      net/can/mpc52xx_can: refactor clock-get routine
      net/can/mpc52xx_can: improve properties and their description
      net/can/mscan: replace hardcoded values with defines
      net/can/mscan: add error path to mscan_open()
      net/can/mscan: improve build

 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |    9 +-
 drivers/net/can/Kconfig                            |   19 +---
 drivers/net/can/mscan/Kconfig                      |   23 ++++
 drivers/net/can/mscan/Makefile                     |    4 +-
 .../net/can/mscan/{mpc52xx_can.c => mpc5xxx_can.c} |   64 ++++-------
 drivers/net/can/mscan/mscan.c                      |  121 +++++++------------
 drivers/net/can/mscan/mscan.h                      |   36 ++++++-
 7 files changed, 133 insertions(+), 143 deletions(-)
 create mode 100644 drivers/net/can/mscan/Kconfig
 rename drivers/net/can/mscan/{mpc52xx_can.c => mpc5xxx_can.c} (90%)
