Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0144.outbound.protection.outlook.com [65.55.169.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2AE1A30E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:47:48 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC v3 00/10] Freescale DPAA B/QMan drivers
Date: Mon, 9 Mar 2015 09:41:45 -0500
Message-ID: <1425912115-27398-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v3:	Addressed feedback from Kumar and Scott (partially, more in the next round)
	Moved public headers into include/soc/fsl and code into drivers/soc/fsl
	Various clean-up

v2:	Moved out of staging into soc/freescale

To do:	Add a maintainer(s) entry
	Add module(s) support
	Some important clean-ups

Geoff Thorpe (8):
  fsl_bman: Add drivers for the Freescale DPAA BMan
  fsl_qman: Add drivers for the Freescale DPAA QMan
  powerpc/mpc85xx: Add platform support for the Freescale DPAA BMan
  powerpc/mpc85xx: Add platform support for the Freescale DPAA QMan
  fsl_bman: Add self-tester
  fsl_qman: Add self-tester
  fsl_bman: Add debugfs support
  fsl_qman: Add debugfs support

Hai-Ying Wang (2):
  fsl_bman: Add HOTPLUG_CPU support
  fsl_qman: Add HOTPLUG_CPU support

 arch/powerpc/Kconfig                          |   33 +-
 arch/powerpc/configs/mpc85xx_defconfig        |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig    |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |   11 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   28 +-
 arch/powerpc/platforms/85xx/p1023_rdb.c       |   28 +-
 drivers/soc/fsl/Kconfig                       |  188 ++
 drivers/soc/fsl/Makefile                      |   22 +-
 drivers/soc/fsl/bman.c                        |  610 ++++++
 drivers/soc/fsl/bman.h                        |  523 +++++
 drivers/soc/fsl/bman_api.c                    | 1054 ++++++++++
 drivers/soc/fsl/bman_debugfs.c                |  118 ++
 drivers/soc/fsl/bman_portal.c                 |  372 ++++
 drivers/soc/fsl/bman_priv.h                   |  148 ++
 drivers/soc/fsl/bman_test.c                   |   55 +
 drivers/soc/fsl/bman_test.h                   |   43 +
 drivers/soc/fsl/bman_test_api.c               |  180 ++
 drivers/soc/fsl/bman_test_thresh.c            |  195 ++
 drivers/soc/fsl/dpaa_alloc.c                  |  572 ++++++
 drivers/soc/fsl/dpaa_sys.h                    |  293 +++
 drivers/soc/fsl/qbman_driver.c                |   84 +
 drivers/soc/fsl/qman.c                        |  990 ++++++++++
 drivers/soc/fsl/qman.h                        | 1301 ++++++++++++
 drivers/soc/fsl/qman_api.c                    | 2623 +++++++++++++++++++++++++
 drivers/soc/fsl/qman_debugfs.c                | 1325 +++++++++++++
 drivers/soc/fsl/qman_portal.c                 |  547 ++++++
 drivers/soc/fsl/qman_priv.h                   |  282 +++
 drivers/soc/fsl/qman_test.c                   |   56 +
 drivers/soc/fsl/qman_test.h                   |   42 +
 drivers/soc/fsl/qman_test_api.c               |  212 ++
 drivers/soc/fsl/qman_test_stash.c             |  496 +++++
 drivers/soc/fsl/qman_utils.c                  |  128 ++
 include/soc/fsl/bman.h                        |  516 +++++
 include/soc/fsl/qman.h                        | 1954 ++++++++++++++++++
 34 files changed, 15004 insertions(+), 27 deletions(-)
 create mode 100644 drivers/soc/fsl/bman.c
 create mode 100644 drivers/soc/fsl/bman.h
 create mode 100644 drivers/soc/fsl/bman_api.c
 create mode 100644 drivers/soc/fsl/bman_debugfs.c
 create mode 100644 drivers/soc/fsl/bman_portal.c
 create mode 100644 drivers/soc/fsl/bman_priv.h
 create mode 100644 drivers/soc/fsl/bman_test.c
 create mode 100644 drivers/soc/fsl/bman_test.h
 create mode 100644 drivers/soc/fsl/bman_test_api.c
 create mode 100644 drivers/soc/fsl/bman_test_thresh.c
 create mode 100644 drivers/soc/fsl/dpaa_alloc.c
 create mode 100644 drivers/soc/fsl/dpaa_sys.h
 create mode 100644 drivers/soc/fsl/qbman_driver.c
 create mode 100644 drivers/soc/fsl/qman.c
 create mode 100644 drivers/soc/fsl/qman.h
 create mode 100644 drivers/soc/fsl/qman_api.c
 create mode 100644 drivers/soc/fsl/qman_debugfs.c
 create mode 100644 drivers/soc/fsl/qman_portal.c
 create mode 100644 drivers/soc/fsl/qman_priv.h
 create mode 100644 drivers/soc/fsl/qman_test.c
 create mode 100644 drivers/soc/fsl/qman_test.h
 create mode 100644 drivers/soc/fsl/qman_test_api.c
 create mode 100644 drivers/soc/fsl/qman_test_stash.c
 create mode 100644 drivers/soc/fsl/qman_utils.c
 create mode 100644 include/soc/fsl/bman.h
 create mode 100644 include/soc/fsl/qman.h

-- 
2.3.0
