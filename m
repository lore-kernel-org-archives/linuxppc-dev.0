Return-Path: <wg@denx.de>
From: Wolfgang Grandegger <wg@grandegger.com>
To: Netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] can: mscan-mpc5xxx: add support for the
	Freescale MPC512x
Date: Thu,  7 Jan 2010 15:10:18 +0100
Message-Id: <1262873421-6863-1-git-send-email-wg@grandegger.com>
Cc: Socketcan-core@lists.berlios.de, Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support for the MPC512x from Freescale to the
mpc5xxx_can MSCAN driver. It has been tested on a MPC5121 and MPC5200B
board.

Changes since v2:

- Debugging for development code remove.
- Bus-off recovery tested and fixed for MPC5121.

Changes since v1:

- Various coding style issues, print formats, variable names, error
  messages and typos fixes or improved.

- MPC5xxx specific data are now passed to mpc5xxx_can_probe() via
  "of_device_id->data".

- The index of the MPC512x CAN controller is now derived directly
  from the reg property. This allows using of_iomap() as before.

- It has been documented that MPC512x Rev.1 CPUs are not supported.

Wolfgang

Wolfgang Grandegger (3):
  can: mscan: fix improper return if dlc < 8 in start_xmit function
  can: mscan-mpc5xxx: add support for the MPC512x processor
  powerpc/mpc5xxx: add OF platform binding doc for FSL MSCAN devices

 Documentation/powerpc/dts-bindings/fsl/can.txt     |   53 +++++
 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |    9 +-
 drivers/net/can/mscan/Kconfig                      |    7 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |  246 ++++++++++++++++----
 drivers/net/can/mscan/mscan.c                      |   62 ++++-
 drivers/net/can/mscan/mscan.h                      |   86 ++++----
 6 files changed, 357 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/can.txt
