Return-Path: <chenhui.zhao@nxp.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0060.outbound.protection.outlook.com [207.46.100.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmbMR1KF7zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 21:45:38 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <oss@buserror.net>
CC: <jason.jin@nxp.com>, <chenhui.zhao@nxp.com>
Subject: [PATCH v2 0/5] powerpc/pm: QorIQ deep sleep
Date: Fri, 15 Apr 2016 19:13:12 +0800
Message-ID: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
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

Changes for v2:
* Ioremap every dts node used in the patches.
* Check the board compatible string to see if the board supports deep sleep.
* Can not reserve the first page of DDR memory, because PPC64 doesn't support
  changing the kernel base address. So still save and restore the first 128 bytes
  of DDR memory.
* Still save and restoer CCSR registers in kernel, because bootloader doesn't
  know what register values to restore
* Changed copyright and email address from freescale to NXP

Please refer to the version 1:
[1/4] powerpc/85xx: support sleep feature on QorIQ SoCs with RCPM
http://patchwork.ozlabs.org/patch/502549/

[2/4] powerpc: get the physical base address of DCSR
http://patchwork.ozlabs.org/patch/502551/
It is removed.

[3/4] powerpc: pm: add EPU FSM configuration for deep sleep
http://patchwork.ozlabs.org/patch/502548/

[4/4] powerpc: pm: support deep sleep feature on T104x
http://patchwork.ozlabs.org/patch/502550/


Chenhui Zhao (5):
  powerpc/85xx: support sleep feature on QorIQ SoCs with RCPM
  powerpc: pm: add EPU FSM configuration for deep sleep
  powerpc/dts: add a compatible string to gpio0
  powerpc/pm: support deep sleep feature on T104x
  powerpc/pm: save and restore registers during deep sleep

 arch/powerpc/Kconfig                          |   3 +-
 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi   |   2 +-
 arch/powerpc/include/asm/fsl_pm.h             |  28 +-
 arch/powerpc/kernel/asm-offsets.c             |  12 +
 arch/powerpc/kernel/fsl_booke_entry_mapping.S |  10 +
 arch/powerpc/kernel/head_64.S                 |   2 +-
 arch/powerpc/platforms/85xx/Kconfig           |   5 +
 arch/powerpc/platforms/85xx/Makefile          |   2 +
 arch/powerpc/platforms/85xx/deepsleep.c       | 365 ++++++++++++++++++
 arch/powerpc/platforms/85xx/qoriq_pm.c        |  84 ++++
 arch/powerpc/platforms/85xx/sleep_fsm.c       | 267 +++++++++++++
 arch/powerpc/platforms/85xx/sleep_fsm.h       |  92 +++++
 arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531 ++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig           |   1 +
 arch/powerpc/sysdev/fsl_rcpm.c                |  28 +-
 15 files changed, 1412 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
 create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h
 create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S

-- 
1.9.1
