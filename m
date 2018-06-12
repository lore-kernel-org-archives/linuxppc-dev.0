Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00052.outbound.protection.outlook.com [40.107.0.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414sfm0DgYzF4Pf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 00:27:42 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: "Y.b. Lu" <yangbo.lu@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "David S .
 Miller" <davem@davemloft.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v3, 00/10] Support DPAA PTP clock and timestamping
Date: Tue, 12 Jun 2018 14:27:35 +0000
Message-ID: <AM6PR04MB400853DACF980BE0E117D9C6EC7F0@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Thursday, June 7, 2018 12:21 PM
> To: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Richard Cochran <richardcochran@gmail.com>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> David S . Miller <davem@davemloft.net>
> Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Y.b. Lu
> <yangbo.lu@nxp.com>
> Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
>=20
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.
>=20
> Yangbo Lu (10):
>   fsl/fman: share the event interrupt
>   ptp: support DPAA FMan 1588 timer in ptp_qoriq
>   dt-binding: ptp_qoriq: add DPAA FMan support
>   powerpc/mpc85xx: move ptp timer out of fman in dts
>   arm64: dts: fsl: move ptp timer out of fman
>   fsl/fman: add set_tstamp interface
>   fsl/fman_port: support getting timestamp
>   fsl/fman: define frame description command UPD
>   dpaa_eth: add support for hardware timestamping
>   dpaa_eth: add the get_ts_info interface for ethtool
>=20
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-----
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++-
>  arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   88
> ++++++++++++++++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
>  drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
>  drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
>  drivers/net/ethernet/freescale/fman/fman.h         |    1 +
>  drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
>  drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
>  drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
>  drivers/net/ethernet/freescale/fman/fman_port.h    |    2 +
>  drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
>  drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
>  drivers/net/ethernet/freescale/fman/mac.c          |    3 +
>  drivers/net/ethernet/freescale/fman/mac.h          |    1 +
>  drivers/ptp/Kconfig                                |    2 +-
>  drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++--=
-----
>  include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
>  26 files changed, 361 insertions(+), 115 deletions(-)

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
