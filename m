Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0115.outbound.protection.outlook.com [65.55.169.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDCAD1A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 16:30:55 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Freescale DPAA FMan FLIB(s)
Date: Wed, 4 Mar 2015 23:45:44 -0600
Message-ID: <1425534351-1065-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Igal Liberman <Igal.Liberman@Freescale.com>
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
hardware components on specific QorIQ P and T series multicore processors.
This architecture provides the infrastructure to support simplified
sharing of networking interfaces and accelerators by multiple CPU cores,
and the accelerators themselves.

One of the DPAA accelerators is the Frame Manager (FMan), which
combines the Ethernet network interfaces with packet distribution
logic to provide intelligent distribution and queuing decisions for
incoming traffic at line rate.

This patch presents the FMan Foundation Libraries (FLIB) headers.
The FMan FLIB suite adds basic support for the DPAA FMan hardware register access.
The FMan FLIB suite is used in Freescale's SDK Releases.

Igal Liberman (7):
  soc/fman: Add the FMan FLIB headers
  soc/fman: Add the FMan FLIB
  soc/fman: Add the FMan port FLIB
  soc/fman: Add the FMan MAC FLIB
  soc/fman: Add the FMan parser and KeyGen FLIB(s)
  soc/fman: Add the FMan RTC FLIB
  soc/fman: Add the FMan SP FLIB

 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/fsl/Kconfig                            |    1 +
 drivers/soc/fsl/Makefile                           |    1 +
 drivers/soc/fsl/fman/Kconfig                       |   35 +
 drivers/soc/fsl/fman/Makefile                      |   19 +
 drivers/soc/fsl/fman/flib/common/general.h         |   45 +
 drivers/soc/fsl/fman/flib/fman_common.h            |   74 +
 drivers/soc/fsl/fman/flib/fsl_enet.h               |  276 ++++
 drivers/soc/fsl/fman/flib/fsl_fman.h               |  801 ++++++++++
 drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h         | 1017 +++++++++++++
 drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h |  104 ++
 drivers/soc/fsl/fman/flib/fsl_fman_kg.h            |  506 +++++++
 drivers/soc/fsl/fman/flib/fsl_fman_memac.h         |  492 +++++++
 drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h |   77 +
 drivers/soc/fsl/fman/flib/fsl_fman_port.h          |  602 ++++++++
 drivers/soc/fsl/fman/flib/fsl_fman_prs.h           |  106 ++
 drivers/soc/fsl/fman/flib/fsl_fman_rtc.h           |  415 ++++++
 drivers/soc/fsl/fman/flib/fsl_fman_sp.h            |  133 ++
 drivers/soc/fsl/fman/flib/fsl_fman_tgec.h          |  484 ++++++
 drivers/soc/fsl/fman/fman.c                        | 1396 ++++++++++++++++++
 drivers/soc/fsl/fman/mac/Makefile                  |   15 +
 drivers/soc/fsl/fman/mac/fman_crc32.c              |  117 ++
 drivers/soc/fsl/fman/mac/fman_crc32.h              |   40 +
 drivers/soc/fsl/fman/mac/fman_dtsec.c              |  844 +++++++++++
 drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c      |  169 +++
 drivers/soc/fsl/fman/mac/fman_memac.c              |  504 +++++++
 drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c      |  218 +++
 drivers/soc/fsl/fman/mac/fman_tgec.c               |  372 +++++
 drivers/soc/fsl/fman/pcd/Makefile                  |   13 +
 drivers/soc/fsl/fman/pcd/fman_kg.c                 |  850 +++++++++++
 drivers/soc/fsl/fman/pcd/fman_prs.c                |  127 ++
 drivers/soc/fsl/fman/port/Makefile                 |   13 +
 drivers/soc/fsl/fman/port/fman_port.c              | 1536 ++++++++++++++++++++
 drivers/soc/fsl/fman/rtc/Makefile                  |   13 +
 drivers/soc/fsl/fman/rtc/fman_rtc.c                |  354 +++++
 drivers/soc/fsl/fman/sp/Makefile                   |   13 +
 drivers/soc/fsl/fman/sp/fman_sp.c                  |  204 +++
 38 files changed, 11988 insertions(+)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/fman/Kconfig
 create mode 100644 drivers/soc/fsl/fman/Makefile
 create mode 100644 drivers/soc/fsl/fman/flib/common/general.h
 create mode 100644 drivers/soc/fsl/fman/flib/fman_common.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_enet.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_kg.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_port.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_prs.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_rtc.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_sp.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_tgec.h
 create mode 100644 drivers/soc/fsl/fman/fman.c
 create mode 100644 drivers/soc/fsl/fman/mac/Makefile
 create mode 100644 drivers/soc/fsl/fman/mac/fman_crc32.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_crc32.h
 create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_memac.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_tgec.c
 create mode 100644 drivers/soc/fsl/fman/pcd/Makefile
 create mode 100644 drivers/soc/fsl/fman/pcd/fman_kg.c
 create mode 100644 drivers/soc/fsl/fman/pcd/fman_prs.c
 create mode 100644 drivers/soc/fsl/fman/port/Makefile
 create mode 100644 drivers/soc/fsl/fman/port/fman_port.c
 create mode 100644 drivers/soc/fsl/fman/rtc/Makefile
 create mode 100644 drivers/soc/fsl/fman/rtc/fman_rtc.c
 create mode 100644 drivers/soc/fsl/fman/sp/Makefile
 create mode 100644 drivers/soc/fsl/fman/sp/fman_sp.c

-- 
2.3.1
