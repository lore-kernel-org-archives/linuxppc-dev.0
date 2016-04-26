Return-Path: <chenhui.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0076.outbound.protection.outlook.com [157.55.234.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvKSX1cfvzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 20:43:23 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: "oss@buserror.net" <oss@buserror.net>, Yang-Leo Li <leoyang.li@nxp.com>
CC: Zhengxiong Jin <jason.jin@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 0/5] powerpc/pm: QorIQ deep sleep
Date: Tue, 26 Apr 2016 10:27:53 +0000
Message-ID: <HE1PR04MB11643986E8F0D4DC9861353F95630@HE1PR04MB1164.eurprd04.prod.outlook.com>
References: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
In-Reply-To: <1460718797-21744-1-git-send-email-chenhui.zhao@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Any comment?

Thanks,
Chenhui

________________________________________
From: Chenhui Zhao <chenhui.zhao@nxp.com>
Sent: Friday, April 15, 2016 7:13 PM
To: linuxppc-dev@lists.ozlabs.org; oss@buserror.net
Cc: Zhengxiong Jin; Chenhui Zhao
Subject: [PATCH v2 0/5] powerpc/pm: QorIQ deep sleep

Changes for v2:
* Ioremap every dts node used in the patches.
* Check the board compatible string to see if the board supports deep sleep=
.
* Can not reserve the first page of DDR memory, because PPC64 doesn't suppo=
rt
  changing the kernel base address. So still save and restore the first 128=
 bytes
  of DDR memory.
* Still save and restoer CCSR registers in kernel, because bootloader doesn=
't
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
 arch/powerpc/platforms/85xx/t104x_deepsleep.S | 531 ++++++++++++++++++++++=
++++
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
