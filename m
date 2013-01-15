Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 675142C008C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 13:29:50 +1100 (EST)
From: Peter Chen <peter.chen@freescale.com>
To: <shawn.guo@linaro.org>, <balbi@ti.com>, <kernel@pengutronix.de>,
 <gregkh@linuxfoundation.org>, <r58472@freescale.com>
Subject: [PATCH v5 0/3] Fix the Build error for fsl_mxc_udc.c
Date: Tue, 15 Jan 2013 10:29:32 +0800
Message-ID: <1358216975-1404-1-git-send-email-peter.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes for v5:
- Using strcmp to get specific SoC
- Delete one cpu_is_mx35() as it has already pdata runtime check

Changes for v4:
- Using pdev's struct resource to do ioremap
- Add ioremap return value check

Changes for v3:
- Split the one big patch into three patches

Changes for v2:
- Add const for fsl_udc_devtype
- Do ioremap for phy address at fsl-mxc-udc

Peter Chen (3):
  usb: fsl-mxc-udc: replace cpu_is_xxx() with platform_device_id
  usb: fsl_mxc_udc: replace MX35_IO_ADDRESS to ioremap
  ARM: i.MX clock: Change the connection-id for fsl-usb2-udc

 arch/arm/mach-imx/clk-imx25.c                     |    6 +-
 arch/arm/mach-imx/clk-imx27.c                     |    6 +-
 arch/arm/mach-imx/clk-imx31.c                     |    6 +-
 arch/arm/mach-imx/clk-imx35.c                     |    6 +-
 arch/arm/mach-imx/clk-imx51-imx53.c               |    6 +-
 arch/arm/mach-imx/devices/devices-common.h        |    1 +
 arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c |   15 ++++---
 drivers/usb/gadget/fsl_mxc_udc.c                  |   40 ++++++++++++------
 drivers/usb/gadget/fsl_udc_core.c                 |   46 +++++++++++++--------
 drivers/usb/gadget/fsl_usb2_udc.h                 |    5 +-
 10 files changed, 82 insertions(+), 55 deletions(-)
