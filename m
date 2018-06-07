Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411g6r2rRHzF338
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 19:22:27 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
Date: Thu,  7 Jun 2018 17:20:40 +0800
Message-Id: <20180607092050.46128-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is to support DPAA FMAN PTP clock and HW timestamping.
It had been verified on both ARM platform and PPC platform.
- The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
  ptp_qoriq driver.
- The patch #6 to patch #10 are to add HW timestamping support in
  DPAA ethernet driver.

Yangbo Lu (10):
  fsl/fman: share the event interrupt
  ptp: support DPAA FMan 1588 timer in ptp_qoriq
  dt-binding: ptp_qoriq: add DPAA FMan support
  powerpc/mpc85xx: move ptp timer out of fman in dts
  arm64: dts: fsl: move ptp timer out of fman
  fsl/fman: add set_tstamp interface
  fsl/fman_port: support getting timestamp
  fsl/fman: define frame description command UPD
  dpaa_eth: add support for hardware timestamping
  dpaa_eth: add the get_ts_info interface for ethtool

 Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-----
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   88 ++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
 drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
 drivers/net/ethernet/freescale/fman/fman.h         |    1 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
 drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
 drivers/net/ethernet/freescale/fman/fman_port.h    |    2 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
 drivers/net/ethernet/freescale/fman/mac.c          |    3 +
 drivers/net/ethernet/freescale/fman/mac.h          |    1 +
 drivers/ptp/Kconfig                                |    2 +-
 drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++-------
 include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
 26 files changed, 361 insertions(+), 115 deletions(-)
