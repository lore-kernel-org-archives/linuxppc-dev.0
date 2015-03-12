Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0104.outbound.protection.outlook.com [207.46.100.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 039041A078D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 06:11:08 +1100 (AEDT)
From: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
To: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2,00/11] Freescale DPAA FMan FLIB(s)
Date: Thu, 12 Mar 2015 19:11:02 +0000
Message-ID: <DM2PR03MB38328109F9D55CD059BE432E6060@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1426050232-12075-1-git-send-email-igal.liberman@freescale.com>
In-Reply-To: <1426050232-12075-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,=20

In v2 of DPAA FMan FLIBs we've made the following updates:
- Split the header patch ([v2,01/11] soc/fman: Add the FMan FLIB headers) f=
rom one big patch to smaller patches - Kumar's feedback.
- Removed the KILOBYTE defines - Kumar's feedback.
- Addressed several comments from Scott on [v2,02/11] soc/fman: Add the FMa=
n FLIB.

Best regards,
Igal Liberman.

> -----Original Message-----
> From: Igal.Liberman [mailto:igal.liberman@freescale.com]
> Sent: Wednesday, March 11, 2015 7:04 AM
> To: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Wood Scott-B07421; Liberman Igal-B31950
> Subject: [v2,00/11] Freescale DPAA FMan FLIB(s)
>=20
> From: Igal Liberman <Igal.Liberman@freescale.com>
>=20
> The Freescale Data Path Acceleration Architecture (DPAA) is a set of
> hardware components on specific QorIQ multicore processors. This
> architecture provides the infrastructure to support simplified sharing of
> networking interfaces and accelerators by multiple CPU cores and the
> accelerators.
>=20
> One of the DPAA accelerators is the Frame Manager (FMan) which enables
> the Ethernet network interfaces.
>=20
> This patch presents the FMan Foundation Libraries (FLIB) headers.
> The FMan FLIB adds basic support for the DPAA FMan hardware register
> access.
>=20
> Igal Liberman (7):
>   soc/fman: Add the FMan FLIB headers
>   soc/fman: Add the FMan FLIB
>   soc/fman: Add the FMan port FLIB
>   soc/fman: Add the FMan MAC FLIB
>   soc/fman: Add the FMan parser and KeyGen FLIB(s)
>   soc/fman: Add the FMan RTC FLIB
>   soc/fman: Add the FMan SP FLIB
>=20
> Madalin Bucur (4):
>   soc/fman: Add the FMan port FLIB headers
>   soc/fman: Add the FMan MAC FLIB headers
>   soc/fman: Add the FMan parser and KeyGen FLIB headers
>   soc/fman: Add the FMan RTC FLIB header
>=20
>  drivers/soc/Kconfig                                |    1 +
>  drivers/soc/Makefile                               |    1 +
>  drivers/soc/fsl/Kconfig                            |    1 +
>  drivers/soc/fsl/Makefile                           |    1 +
>  drivers/soc/fsl/fman/Kconfig                       |   35 +
>  drivers/soc/fsl/fman/Makefile                      |   11 +
>  drivers/soc/fsl/fman/flib/common/general.h         |   41 +
>  drivers/soc/fsl/fman/flib/fman_common.h            |   73 +
>  drivers/soc/fsl/fman/flib/fsl_enet.h               |  275 ++++
>  drivers/soc/fsl/fman/flib/fsl_fman.h               |  802 ++++++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h         | 1016 +++++++++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h |  103 ++
>  drivers/soc/fsl/fman/flib/fsl_fman_kg.h            |  505 +++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_memac.h         |  494 +++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h |   76 +
>  drivers/soc/fsl/fman/flib/fsl_fman_port.h          |  601 ++++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_prs.h           |  106 ++
>  drivers/soc/fsl/fman/flib/fsl_fman_rtc.h           |  414 ++++++
>  drivers/soc/fsl/fman/flib/fsl_fman_sp.h            |  132 ++
>  drivers/soc/fsl/fman/flib/fsl_fman_tgec.h          |  483 ++++++
>  drivers/soc/fsl/fman/fman.c                        | 1355 ++++++++++++++=
+++
>  drivers/soc/fsl/fman/mac/Makefile                  |    5 +
>  drivers/soc/fsl/fman/mac/fman_crc32.c              |  116 ++
>  drivers/soc/fsl/fman/mac/fman_crc32.h              |   39 +
>  drivers/soc/fsl/fman/mac/fman_dtsec.c              |  838 +++++++++++
>  drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c      |  168 +++
>  drivers/soc/fsl/fman/mac/fman_memac.c              |  510 +++++++
>  drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c      |  217 +++
>  drivers/soc/fsl/fman/mac/fman_tgec.c               |  371 +++++
>  drivers/soc/fsl/fman/pcd/Makefile                  |    3 +
>  drivers/soc/fsl/fman/pcd/fman_kg.c                 |  849 +++++++++++
>  drivers/soc/fsl/fman/pcd/fman_prs.c                |  126 ++
>  drivers/soc/fsl/fman/port/Makefile                 |    3 +
>  drivers/soc/fsl/fman/port/fman_port.c              | 1535
> ++++++++++++++++++++
>  drivers/soc/fsl/fman/rtc/Makefile                  |    3 +
>  drivers/soc/fsl/fman/rtc/fman_rtc.c                |  353 +++++
>  drivers/soc/fsl/fman/sp/Makefile                   |    3 +
>  drivers/soc/fsl/fman/sp/fman_sp.c                  |  203 +++
>  38 files changed, 11868 insertions(+)
>  create mode 100644 drivers/soc/fsl/Kconfig  create mode 100644
> drivers/soc/fsl/Makefile  create mode 100644 drivers/soc/fsl/fman/Kconfig
> create mode 100644 drivers/soc/fsl/fman/Makefile  create mode 100644
> drivers/soc/fsl/fman/flib/common/general.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fman_common.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_enet.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_kg.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_port.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_prs.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_rtc.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_sp.h
>  create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_tgec.h
>  create mode 100644 drivers/soc/fsl/fman/fman.c  create mode 100644
> drivers/soc/fsl/fman/mac/Makefile  create mode 100644
> drivers/soc/fsl/fman/mac/fman_crc32.c
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_crc32.h
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec.c
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_memac.c
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c
>  create mode 100644 drivers/soc/fsl/fman/mac/fman_tgec.c
>  create mode 100644 drivers/soc/fsl/fman/pcd/Makefile  create mode
> 100644 drivers/soc/fsl/fman/pcd/fman_kg.c
>  create mode 100644 drivers/soc/fsl/fman/pcd/fman_prs.c
>  create mode 100644 drivers/soc/fsl/fman/port/Makefile
>  create mode 100644 drivers/soc/fsl/fman/port/fman_port.c
>  create mode 100644 drivers/soc/fsl/fman/rtc/Makefile  create mode 100644
> drivers/soc/fsl/fman/rtc/fman_rtc.c
>  create mode 100644 drivers/soc/fsl/fman/sp/Makefile  create mode 100644
> drivers/soc/fsl/fman/sp/fman_sp.c
>=20
> --
> 1.7.9.5
