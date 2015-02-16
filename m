Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B661F1A0F1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 02:51:28 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 00/10] Freescale DPAA B/QMan drivers
Date: Mon, 16 Feb 2015 09:46:11 -0600
Message-ID: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
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

v2:	Moved out of staging into soc/freescale

Hello,


This is the se attempt to publish the . They are
not to be applied yet.  

These are the Freescale DPAA B/QMan drivers. At this stage, this is more or less
the drivers from the Freescale PowerPC SDK roughly squashed and split in a
sequence of component patches. They still needs some work and cleanup before we
expect to have them applied, but we appreciate early feedback

To do:	Add a maintainer(s) entry
	Add module(s) support
	Some important clean-ups

Cheers,


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

 arch/powerpc/Kconfig                          |    5 +
 arch/powerpc/configs/mpc85xx_defconfig        |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig    |    1 +
 arch/powerpc/platforms/85xx/Kconfig           |    1 +
 arch/powerpc/platforms/85xx/corenet_generic.c |   22 +
 arch/powerpc/platforms/85xx/p1023_rdb.c       |   20 +
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/freescale/Kconfig                 |  187 ++
 drivers/soc/freescale/Makefile                |   21 +
 drivers/soc/freescale/bman.c                  |  611 ++++++
 drivers/soc/freescale/bman.h                  |  524 +++++
 drivers/soc/freescale/bman_api.c              | 1055 ++++++++++
 drivers/soc/freescale/bman_debugfs.c          |  119 ++
 drivers/soc/freescale/bman_portal.c           |  373 ++++
 drivers/soc/freescale/bman_priv.h             |  149 ++
 drivers/soc/freescale/bman_test.c             |   56 +
 drivers/soc/freescale/bman_test.h             |   44 +
 drivers/soc/freescale/bman_test_api.c         |  181 ++
 drivers/soc/freescale/bman_test_thresh.c      |  196 ++
 drivers/soc/freescale/dpaa_alloc.c            |  573 ++++++
 drivers/soc/freescale/dpaa_sys.h              |  294 +++
 drivers/soc/freescale/qbman_driver.c          |   85 +
 drivers/soc/freescale/qman.c                  |  991 ++++++++++
 drivers/soc/freescale/qman.h                  | 1302 ++++++++++++
 drivers/soc/freescale/qman_api.c              | 2624 +++++++++++++++++++++++++
 drivers/soc/freescale/qman_debugfs.c          | 1326 +++++++++++++
 drivers/soc/freescale/qman_portal.c           |  548 ++++++
 drivers/soc/freescale/qman_priv.h             |  283 +++
 drivers/soc/freescale/qman_test.c             |   57 +
 drivers/soc/freescale/qman_test.h             |   43 +
 drivers/soc/freescale/qman_test_api.c         |  213 ++
 drivers/soc/freescale/qman_test_stash.c       |  497 +++++
 drivers/soc/freescale/qman_utils.c            |  129 ++
 include/linux/fsl_bman.h                      |  517 +++++
 include/linux/fsl_qman.h                      | 1955 ++++++++++++++++++
 36 files changed, 15005 insertions(+)
 create mode 100644 drivers/soc/freescale/Kconfig
 create mode 100644 drivers/soc/freescale/Makefile
 create mode 100644 drivers/soc/freescale/bman.c
 create mode 100644 drivers/soc/freescale/bman.h
 create mode 100644 drivers/soc/freescale/bman_api.c
 create mode 100644 drivers/soc/freescale/bman_debugfs.c
 create mode 100644 drivers/soc/freescale/bman_portal.c
 create mode 100644 drivers/soc/freescale/bman_priv.h
 create mode 100644 drivers/soc/freescale/bman_test.c
 create mode 100644 drivers/soc/freescale/bman_test.h
 create mode 100644 drivers/soc/freescale/bman_test_api.c
 create mode 100644 drivers/soc/freescale/bman_test_thresh.c
 create mode 100644 drivers/soc/freescale/dpaa_alloc.c
 create mode 100644 drivers/soc/freescale/dpaa_sys.h
 create mode 100644 drivers/soc/freescale/qbman_driver.c
 create mode 100644 drivers/soc/freescale/qman.c
 create mode 100644 drivers/soc/freescale/qman.h
 create mode 100644 drivers/soc/freescale/qman_api.c
 create mode 100644 drivers/soc/freescale/qman_debugfs.c
 create mode 100644 drivers/soc/freescale/qman_portal.c
 create mode 100644 drivers/soc/freescale/qman_priv.h
 create mode 100644 drivers/soc/freescale/qman_test.c
 create mode 100644 drivers/soc/freescale/qman_test.h
 create mode 100644 drivers/soc/freescale/qman_test_api.c
 create mode 100644 drivers/soc/freescale/qman_test_stash.c
 create mode 100644 drivers/soc/freescale/qman_utils.c
 create mode 100644 include/linux/fsl_bman.h
 create mode 100644 include/linux/fsl_qman.h

-- 
2.3.0
