Return-Path: <punnaiah.choudary.kalluri@xilinx.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7238014009C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 02:23:47 +1000 (EST)
From: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
To: <leoli@freescale.com>, <balbi@ti.com>, <michal.simek@xilinx.c>
Subject: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb controller
Date: Sun, 20 Apr 2014 21:53:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <cd97cc6f-7944-4aac-963a-0dedc7bed938@CH1EHSMHS032.ehs.local>
Cc: Punnaiah Choudary Kalluri <punnaia@xilinx.com>, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zynq soc contains a dual role usb controller and this IP is from synopsys. We
observed that there is driver available for this controller from freescale and
decided to reuse this driver for zynq use.

Here is the link for zynq soc TRM. Please refer chapter 15 for usb controller
related information.
http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf

The following series of patches add initial support for zynq soc in fsl gadget controller
driver and fsl host controller driver.

Based on these patches, I have the following concerns and sugesstions

Since the freescale usb driver is for synopsys IP, Please consider rebranding
this driver name and config options to reflect that it is a sysnopsys IP. So
that other vendors who using this IP can reuse thie driver.

Also the ehci-fsl.c is for powerpc based soc's, and zynq is ARM based, i have
protected the code which is specifc to freescale with CONFIG_FSL_SOC. Please
suggest if there is a better way of doing this?

Punnaiah Choudary Kalluri (2):
  usb: gadget: fsl_udc: Add support for zynq usb device controller
  usb: ehci-fsl: Add support for zynq usb host controller

 drivers/usb/gadget/Kconfig        |    2 +-
 drivers/usb/gadget/Makefile       |    1 +
 drivers/usb/gadget/fsl_mxc_udc.c  |   21 ++++++++++++
 drivers/usb/gadget/fsl_udc_core.c |    5 +++
 drivers/usb/gadget/fsl_usb2_udc.h |    2 +-
 drivers/usb/host/Kconfig          |    2 +-
 drivers/usb/host/ehci-fsl.c       |   63 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/fsl-mph-dr-of.c  |    9 +++++
 8 files changed, 101 insertions(+), 4 deletions(-)

-- 
1.7.4
