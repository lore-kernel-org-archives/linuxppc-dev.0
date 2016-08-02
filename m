Return-Path: <chenhui.zhao@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0064.outbound.protection.outlook.com [104.47.34.64])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3ZsJ5Y1kzDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 22:15:16 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@nxp.com>
To: <oss@buserror.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
CC: <jason.jin@nxp.com>, <z.chenhui@gmail.com>, Chenhui Zhao
 <chenhui.zhao@nxp.com>
Subject: [PATCH v3 0/5] powerpc/pm: QorIQ deep sleep
Date: Tue, 2 Aug 2016 19:59:28 +0800
Message-ID: <1470139172-12699-2-git-send-email-chenhui.zhao@nxp.com>
In-Reply-To: <1470139172-12699-1-git-send-email-chenhui.zhao@nxp.com>
References: <1470139172-12699-1-git-send-email-chenhui.zhao@nxp.com>
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

Changes for v3:
* add mcke-gpios in dts to specify the GPIO pin which works as MCKE signal

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
  powerpc/dts: add mcke-gpios for PM feature
  powerpc/85xx: support sleep feature on QorIQ SoCs with RCPM
  powerpc: pm: add EPU FSM configuration for deep sleep
  powerpc/pm: support deep sleep feature on T104x
  powerpc/pm: save and restore registers during deep sleep

 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  13 +
 arch/powerpc/Kconfig                               |   3 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   3 +
 arch/powerpc/include/asm/fsl_pm.h                  |  28 +-
 arch/powerpc/kernel/asm-offsets.c                  |  12 +
 arch/powerpc/kernel/fsl_booke_entry_mapping.S      |  10 +
 arch/powerpc/kernel/head_64.S                      |   2 +-
 arch/powerpc/platforms/85xx/Kconfig                |   5 +
 arch/powerpc/platforms/85xx/Makefile               |   2 +
 arch/powerpc/platforms/85xx/deepsleep.c            | 384 +++++++++++++++
 arch/powerpc/platforms/85xx/qoriq_pm.c             |  84 ++++
 arch/powerpc/platforms/85xx/sleep_fsm.c            | 267 +++++++++++
 arch/powerpc/platforms/85xx/sleep_fsm.h            |  92 ++++
 arch/powerpc/platforms/85xx/t104x_deepsleep.S      | 531 +++++++++++++++++++++
 arch/powerpc/platforms/86xx/Kconfig                |   1 +
 arch/powerpc/sysdev/fsl_rcpm.c                     |  28 +-
 16 files changed, 1446 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/deepsleep.c
 create mode 100644 arch/powerpc/platforms/85xx/qoriq_pm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
 create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h
 create mode 100644 arch/powerpc/platforms/85xx/t104x_deepsleep.S

-- 
1.9.1
