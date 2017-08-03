Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0055.outbound.protection.outlook.com [104.47.33.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNGR61vlJzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 13:54:58 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <tglx@linutronix.de>
CC: <oss@buserror.net>, <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v9 0/4] this patchset is to remove PPCisms for QEIC
Date: Thu, 3 Aug 2017 11:38:06 +0800
Message-ID: <1501731490-34402-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

QEIC is supported more than just powerpc boards, so remove PPCisms.

changelog:
	Changes for v8:
	- use IRQCHIP_DECLARE() instead of subsys_initcall in qeic driver
	- remove include/soc/fsl/qe/qe_ic.h
	Changes for v9:
	- rebase 
	- fix the compile issue when apply the second patch, in fact, there was no compile issue 
	  when apply all the patches of this patchset

Zhao Qiang (4):
  irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
	Changes for v2:
		- modify the subject and commit msg
	Changes for v3:
		- merge .h file to .c, rename it with irq-qeic.c
	Changes for v4:
		- modify comments
	Changes for v5:
		- disable rename detection
	Changes for v6:
		- rebase
	Changes for v7:
		- na

  irqchip/qeic: merge qeic init code from platforms to a common function
	Changes for v2:
		- modify subject and commit msg
		- add check for qeic by type
	Changes for v3:
		- na
	Changes for v4:
		- na
	Changes for v5:
		- na
	Changes for v6:
		- rebase
	Changes for v7:
		- na
	Changes for v8:
		- use IRQCHIP_DECLARE() instead of subsys_initcall

  irqchip/qeic: merge qeic_of_init into qe_ic_init
	Changes for v2:
		- modify subject and commit msg
		- return 0 and add put node when return in qe_ic_init
	Changes for v3:
		- na
	Changes for v4:
		- na
	Changes for v5:
		- na
	Changes for v6:
		- rebase
	Changes for v7:
		- na

  irqchip/qeic: remove PPCisms for QEIC
	Changes for v6:
		- new added
	Changes for v7:
		- fix warning
	Changes for v8:
		- remove include/soc/fsl/qe/qe_ic.h

Zhao Qiang (4):
  irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
  irqchip/qeic: merge qeic init code from platforms to a common function
  irqchip/qeic: merge qeic_of_init into qe_ic_init
  irqchip/qeic: remove PPCisms for QEIC

 MAINTAINERS                                   |   6 +
 arch/powerpc/platforms/83xx/km83xx.c          |   1 -
 arch/powerpc/platforms/83xx/misc.c            |  16 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
 arch/powerpc/platforms/85xx/corenet_generic.c |  10 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  15 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  17 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |  15 -
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-qeic.c                    | 605 ++++++++++++++++++++++++++
 drivers/soc/fsl/qe/Makefile                   |   2 +-
 drivers/soc/fsl/qe/qe_ic.c                    | 512 ----------------------
 drivers/soc/fsl/qe/qe_ic.h                    | 103 -----
 include/soc/fsl/qe/qe_ic.h                    | 139 ------
 17 files changed, 613 insertions(+), 833 deletions(-)
 create mode 100644 drivers/irqchip/irq-qeic.c
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.c
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

-- 
2.1.0.27.g96db324
