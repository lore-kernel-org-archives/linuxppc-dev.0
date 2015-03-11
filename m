Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0146.outbound.protection.outlook.com [157.56.110.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EF341A1121
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 20:27:34 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,0/8] Freescale DPAA FMan
Date: Wed, 11 Mar 2015 07:07:38 +0200
Message-ID: <1426050458-12474-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

The Freescale Data Path Acceleration Architecture (DPAA) is a set of
hardware components on specific QorIQ multicore processors. This
architecture provides the infrastructure to support simplified
sharing of networking interfaces and accelerators by multiple CPU
cores and the accelerators.

One of the DPAA accelerators is the Frame Manager (FMan) which
enables the Ethernet network interfaces.

Igal Liberman (7):
  soc/fman: Add FMan MURAM support
  soc/fman: Add Frame Manager support
  soc/fman: Add FMan Real Time Clock support
  soc/fman: Add FMan Parser and Keygen support
  soc/fman: Add FMan MAC support
  soc/fman: Add FMan SP support
  soc/fman: Add FMan MAC driver

Madalin Bucur (1):
  soc/fman: Add FMan Port Support

 drivers/soc/fsl/fman/Kconfig                    |   94 +
 drivers/soc/fsl/fman/Makefile                   |    6 +-
 drivers/soc/fsl/fman/fm.c                       | 2483 +++++++++++++++++++++++
 drivers/soc/fsl/fman/fm.h                       |  502 +++++
 drivers/soc/fsl/fman/fm_common.h                |  644 ++++++
 drivers/soc/fsl/fman/fm_drv.c                   | 1217 +++++++++++
 drivers/soc/fsl/fman/fm_drv.h                   |  149 ++
 drivers/soc/fsl/fman/fm_muram.c                 |  174 ++
 drivers/soc/fsl/fman/fm_port_drv.c              |  540 +++++
 drivers/soc/fsl/fman/fm_sp_common.h             |  112 +
 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h     |  343 ++++
 drivers/soc/fsl/fman/inc/dpaa_ext.h             |  253 +++
 drivers/soc/fsl/fman/inc/dpaa_integration_ext.h |  126 ++
 drivers/soc/fsl/fman/inc/enet_ext.h             |  199 ++
 drivers/soc/fsl/fman/inc/fm_ext.h               |  749 +++++++
 drivers/soc/fsl/fman/inc/fm_mac_ext.h           |  660 ++++++
 drivers/soc/fsl/fman/inc/fm_muram_ext.h         |   98 +
 drivers/soc/fsl/fman/inc/fm_pcd_ext.h           |  167 ++
 drivers/soc/fsl/fman/inc/fm_port_ext.h          |  650 ++++++
 drivers/soc/fsl/fman/inc/fm_rtc_ext.h           |  398 ++++
 drivers/soc/fsl/fman/inc/fsl_fman_drv.h         |  257 +++
 drivers/soc/fsl/fman/inc/mac.h                  |  142 ++
 drivers/soc/fsl/fman/inc/net_ext.h              |  534 +++++
 drivers/soc/fsl/fman/inc/service.h              |   90 +
 drivers/soc/fsl/fman/mac/Makefile               |   10 +-
 drivers/soc/fsl/fman/mac/dtsec.c                | 1655 +++++++++++++++
 drivers/soc/fsl/fman/mac/dtsec.h                |  187 ++
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c        |   82 +
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h        |   43 +
 drivers/soc/fsl/fman/mac/fm_mac.c               |  701 +++++++
 drivers/soc/fsl/fman/mac/fm_mac.h               |  203 ++
 drivers/soc/fsl/fman/mac/mac-api.c              |  671 ++++++
 drivers/soc/fsl/fman/mac/mac.c                  |  522 +++++
 drivers/soc/fsl/fman/mac/memac.c                | 1115 ++++++++++
 drivers/soc/fsl/fman/mac/memac.h                |  103 +
 drivers/soc/fsl/fman/mac/memac_mii_acc.c        |   66 +
 drivers/soc/fsl/fman/mac/memac_mii_acc.h        |   50 +
 drivers/soc/fsl/fman/mac/tgec.c                 | 1030 ++++++++++
 drivers/soc/fsl/fman/mac/tgec.h                 |  112 +
 drivers/soc/fsl/fman/mac/tgec_mii_acc.h         |   66 +
 drivers/soc/fsl/fman/pcd/Makefile               |    2 +-
 drivers/soc/fsl/fman/pcd/fm_pcd.c               |  428 ++++
 drivers/soc/fsl/fman/pcd/fm_pcd.h               |  145 ++
 drivers/soc/fsl/fman/pcd/fm_prs.c               |  276 +++
 drivers/soc/fsl/fman/pcd/fm_prs.h               |  163 ++
 drivers/soc/fsl/fman/port/Makefile              |    2 +-
 drivers/soc/fsl/fman/port/fm_port.c             | 2427 ++++++++++++++++++++++
 drivers/soc/fsl/fman/port/fm_port.h             |  743 +++++++
 drivers/soc/fsl/fman/rtc/Makefile               |    2 +-
 drivers/soc/fsl/fman/rtc/fm_rtc.c               |  763 +++++++
 drivers/soc/fsl/fman/rtc/fm_rtc.h               |   89 +
 drivers/soc/fsl/fman/sp/Makefile                |    2 +-
 drivers/soc/fsl/fman/sp/fm_sp.c                 |  429 ++++
 53 files changed, 22665 insertions(+), 9 deletions(-)
 create mode 100644 drivers/soc/fsl/fman/fm.c
 create mode 100644 drivers/soc/fsl/fman/fm.h
 create mode 100644 drivers/soc/fsl/fman/fm_common.h
 create mode 100644 drivers/soc/fsl/fman/fm_drv.c
 create mode 100644 drivers/soc/fsl/fman/fm_drv.h
 create mode 100644 drivers/soc/fsl/fman/fm_muram.c
 create mode 100644 drivers/soc/fsl/fman/fm_port_drv.c
 create mode 100644 drivers/soc/fsl/fman/fm_sp_common.h
 create mode 100644 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/dpaa_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/dpaa_integration_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/enet_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_mac_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_muram_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_pcd_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_port_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_rtc_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fsl_fman_drv.h
 create mode 100644 drivers/soc/fsl/fman/inc/mac.h
 create mode 100644 drivers/soc/fsl/fman/inc/net_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/service.h
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.h
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.c
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.h
 create mode 100644 drivers/soc/fsl/fman/mac/mac-api.c
 create mode 100644 drivers/soc/fsl/fman/mac/mac.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac.h
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.c
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_pcd.c
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_pcd.h
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_prs.c
 create mode 100644 drivers/soc/fsl/fman/pcd/fm_prs.h
 create mode 100644 drivers/soc/fsl/fman/port/fm_port.c
 create mode 100644 drivers/soc/fsl/fman/port/fm_port.h
 create mode 100644 drivers/soc/fsl/fman/rtc/fm_rtc.c
 create mode 100644 drivers/soc/fsl/fman/rtc/fm_rtc.h
 create mode 100644 drivers/soc/fsl/fman/sp/fm_sp.c

-- 
1.7.9.5
