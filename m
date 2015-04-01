Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0132.outbound.protection.outlook.com [207.46.100.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FABC1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 02:37:51 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC,v2,00/12] Freescale DPAA FMan
Date: Wed, 1 Apr 2015 14:35:29 +0300
Message-ID: <1427888129-24079-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 madalin.bucur@freescale.com
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
contains a series of hardware blocks: ports, Ethernet MACs, a multi
user RAM (MURAM) and Storage Profile (SP).

This patch set introduced the FMan driver code that configures
and initializes the FMan hardware blocks, offering support for
three different types of MACs.
The first 6 patches present the FMan Foundation Libraries (FLIBs),
the FMan FLib provides the basic API used by the FMan drivers to
configure and control the FMan hardware.
The following patches present the FMan driver itself, split into
patches for each required hardware module.


v2:	- This set of patches combines the following submissions:
		- v2 of FMan (RFC)
		- v3 of FMan FLib
	- Reduced FMan code size:
		- Reduced FMan FLib's size:
			Removed code for future support.
		- Removed Priority Flow Control (PFC) support.
		- Removed rate-limiter.
		- Removed some MAC features.
		- Removed Real Time Clock (RTC) support.

Igal Liberman (12):
  soc/fman: Add the FMan FLIB headers
  soc/fman: Add the FMan FLIB
  soc/fman: Add the FMan port FLIB headers
  soc/fman: Add the FMan port FLIB
  soc/fman: Add the FMan MAC FLIB headers
  soc/fman: Add the FMan MAC FLIB
  soc/fman: Add FMan MURAM support
  soc/fman: Add Frame Manager support
  soc/fman: Add FMan MAC support
  soc/fman: Add FMan SP support
  soc/fman: Add FMan Port Support
  soc/fman: Add FMan MAC driver

 drivers/soc/fsl/Kconfig                            |    2 +
 drivers/soc/fsl/Makefile                           |    2 +
 drivers/soc/fsl/fman/Kconfig                       |   46 +
 drivers/soc/fsl/fman/Makefile                      |   12 +
 drivers/soc/fsl/fman/flib/common/general.h         |   41 +
 drivers/soc/fsl/fman/flib/fman_common.h            |   73 +
 drivers/soc/fsl/fman/flib/fsl_enet.h               |  275 +++
 drivers/soc/fsl/fman/flib/fsl_fman.h               |  743 +++++++
 drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h         |  791 ++++++++
 drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h |  103 +
 drivers/soc/fsl/fman/flib/fsl_fman_memac.h         |  453 +++++
 drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h |   76 +
 drivers/soc/fsl/fman/flib/fsl_fman_port.h          |  462 +++++
 drivers/soc/fsl/fman/flib/fsl_fman_sp.h            |   66 +
 drivers/soc/fsl/fman/flib/fsl_fman_tgec.h          |  409 ++++
 drivers/soc/fsl/fman/fm.c                          | 2088 ++++++++++++++++++++
 drivers/soc/fsl/fman/fm.h                          |  486 +++++
 drivers/soc/fsl/fman/fm_common.h                   |  538 +++++
 drivers/soc/fsl/fman/fm_drv.c                      |  967 +++++++++
 drivers/soc/fsl/fman/fm_drv.h                      |  123 ++
 drivers/soc/fsl/fman/fm_muram.c                    |  174 ++
 drivers/soc/fsl/fman/fm_port_drv.c                 |  536 +++++
 drivers/soc/fsl/fman/fm_sp_common.h                |  104 +
 drivers/soc/fsl/fman/fman.c                        |  978 +++++++++
 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h        |  343 ++++
 drivers/soc/fsl/fman/inc/dpaa_ext.h                |  253 +++
 drivers/soc/fsl/fman/inc/dpaa_integration_ext.h    |  120 ++
 drivers/soc/fsl/fman/inc/enet_ext.h                |  199 ++
 drivers/soc/fsl/fman/inc/fm_ext.h                  |  715 +++++++
 drivers/soc/fsl/fman/inc/fm_mac_ext.h              |  452 +++++
 drivers/soc/fsl/fman/inc/fm_muram_ext.h            |   98 +
 drivers/soc/fsl/fman/inc/fm_port_ext.h             |  397 ++++
 drivers/soc/fsl/fman/inc/fsl_fman_drv.h            |  192 ++
 drivers/soc/fsl/fman/inc/mac.h                     |  125 ++
 drivers/soc/fsl/fman/inc/net_ext.h                 |  534 +++++
 drivers/soc/fsl/fman/inc/service.h                 |   90 +
 drivers/soc/fsl/fman/mac/Makefile                  |    9 +
 drivers/soc/fsl/fman/mac/dtsec.c                   | 1226 ++++++++++++
 drivers/soc/fsl/fman/mac/dtsec.h                   |  185 ++
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c           |   82 +
 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h           |   43 +
 drivers/soc/fsl/fman/mac/fm_mac.c                  |  510 +++++
 drivers/soc/fsl/fman/mac/fm_mac.h                  |  183 ++
 drivers/soc/fsl/fman/mac/fman_crc32.c              |  116 ++
 drivers/soc/fsl/fman/mac/fman_crc32.h              |   39 +
 drivers/soc/fsl/fman/mac/fman_dtsec.c              |  571 ++++++
 drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c      |  168 ++
 drivers/soc/fsl/fman/mac/fman_memac.c              |  365 ++++
 drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c      |  217 ++
 drivers/soc/fsl/fman/mac/fman_tgec.c               |  217 ++
 drivers/soc/fsl/fman/mac/mac-api.c                 |  605 ++++++
 drivers/soc/fsl/fman/mac/mac.c                     |  521 +++++
 drivers/soc/fsl/fman/mac/memac.c                   |  837 ++++++++
 drivers/soc/fsl/fman/mac/memac.h                   |  103 +
 drivers/soc/fsl/fman/mac/memac_mii_acc.c           |   66 +
 drivers/soc/fsl/fman/mac/memac_mii_acc.h           |   50 +
 drivers/soc/fsl/fman/mac/tgec.c                    |  797 ++++++++
 drivers/soc/fsl/fman/mac/tgec.h                    |  112 ++
 drivers/soc/fsl/fman/mac/tgec_mii_acc.h            |   66 +
 drivers/soc/fsl/fman/port/Makefile                 |    3 +
 drivers/soc/fsl/fman/port/fm_port.c                | 1484 ++++++++++++++
 drivers/soc/fsl/fman/port/fm_port.h                |  711 +++++++
 drivers/soc/fsl/fman/port/fman_port.c              |  728 +++++++
 drivers/soc/fsl/fman/sp/Makefile                   |    3 +
 drivers/soc/fsl/fman/sp/fm_sp.c                    |  398 ++++
 65 files changed, 23481 insertions(+)
 create mode 100644 drivers/soc/fsl/fman/Kconfig
 create mode 100644 drivers/soc/fsl/fman/Makefile
 create mode 100644 drivers/soc/fsl/fman/flib/common/general.h
 create mode 100644 drivers/soc/fsl/fman/flib/fman_common.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_enet.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_dtsec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_memac_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_port.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_sp.h
 create mode 100644 drivers/soc/fsl/fman/flib/fsl_fman_tgec.h
 create mode 100644 drivers/soc/fsl/fman/fm.c
 create mode 100644 drivers/soc/fsl/fman/fm.h
 create mode 100644 drivers/soc/fsl/fman/fm_common.h
 create mode 100644 drivers/soc/fsl/fman/fm_drv.c
 create mode 100644 drivers/soc/fsl/fman/fm_drv.h
 create mode 100644 drivers/soc/fsl/fman/fm_muram.c
 create mode 100644 drivers/soc/fsl/fman/fm_port_drv.c
 create mode 100644 drivers/soc/fsl/fman/fm_sp_common.h
 create mode 100644 drivers/soc/fsl/fman/fman.c
 create mode 100644 drivers/soc/fsl/fman/inc/crc_mac_addr_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/dpaa_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/dpaa_integration_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/enet_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_mac_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_muram_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fm_port_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/fsl_fman_drv.h
 create mode 100644 drivers/soc/fsl/fman/inc/mac.h
 create mode 100644 drivers/soc/fsl/fman/inc/net_ext.h
 create mode 100644 drivers/soc/fsl/fman/inc/service.h
 create mode 100644 drivers/soc/fsl/fman/mac/Makefile
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec.h
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/dtsec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.c
 create mode 100644 drivers/soc/fsl/fman/mac/fm_mac.h
 create mode 100644 drivers/soc/fsl/fman/mac/fman_crc32.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_crc32.h
 create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_dtsec_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_memac.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_memac_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/fman_tgec.c
 create mode 100644 drivers/soc/fsl/fman/mac/mac-api.c
 create mode 100644 drivers/soc/fsl/fman/mac/mac.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac.h
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.c
 create mode 100644 drivers/soc/fsl/fman/mac/memac_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.c
 create mode 100644 drivers/soc/fsl/fman/mac/tgec.h
 create mode 100644 drivers/soc/fsl/fman/mac/tgec_mii_acc.h
 create mode 100644 drivers/soc/fsl/fman/port/Makefile
 create mode 100644 drivers/soc/fsl/fman/port/fm_port.c
 create mode 100644 drivers/soc/fsl/fman/port/fm_port.h
 create mode 100644 drivers/soc/fsl/fman/port/fman_port.c
 create mode 100644 drivers/soc/fsl/fman/sp/Makefile
 create mode 100644 drivers/soc/fsl/fman/sp/fm_sp.c

-- 
1.7.9.5
