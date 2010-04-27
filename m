Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C970EB7D76
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:11:38 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH 0/4] Add USB Host and OTG support for MPC5121 SoC
Date: Tue, 27 Apr 2010 18:11:34 +0200
Message-Id: <1272384698-4359-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin (4):
  powerpc/fsl_soc.c: prepare for addition of mpc5121 USB code
  powerpc/mpc5121: add USB host support
  USB: add USB OTG support for MPC5121 SoC
  powerpc/mpc5121: select options for USB OTG support

 Documentation/powerpc/dts-bindings/fsl/usb.txt |   22 +
 arch/powerpc/include/asm/fsl_usb_io.h          |  106 +++
 arch/powerpc/platforms/512x/Kconfig            |   11 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_usb.c      |  131 +++
 arch/powerpc/platforms/512x/mpc512x.h          |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |    1 +
 arch/powerpc/sysdev/fsl_soc.c                  |  249 +++---
 arch/powerpc/sysdev/fsl_soc.h                  |    9 +
 drivers/usb/gadget/fsl_udc_core.c              |  357 ++++++--
 drivers/usb/gadget/fsl_usb2_udc.h              |   14 +
 drivers/usb/host/ehci-fsl.c                    |  372 ++++++--
 drivers/usb/host/ehci-fsl.h                    |   22 +-
 drivers/usb/host/ehci-hub.c                    |   39 +
 drivers/usb/host/ehci-mem.c                    |    2 +-
 drivers/usb/host/ehci.h                        |    5 +
 drivers/usb/otg/Kconfig                        |    8 +
 drivers/usb/otg/Makefile                       |    2 +
 drivers/usb/otg/fsl_otg.c                      | 1199 ++++++++++++++++++++++++
 drivers/usb/otg/fsl_otg.h                      |  418 +++++++++
 drivers/usb/otg/otg.c                          |   17 +
 drivers/usb/otg/otg_fsm.c                      |  368 ++++++++
 drivers/usb/otg/otg_fsm.h                      |  154 +++
 include/linux/fsl_devices.h                    |   28 +
 24 files changed, 3285 insertions(+), 252 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_usb_io.h
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_usb.c
 create mode 100644 drivers/usb/otg/fsl_otg.c
 create mode 100644 drivers/usb/otg/fsl_otg.h
 create mode 100644 drivers/usb/otg/otg_fsm.c
 create mode 100644 drivers/usb/otg/otg_fsm.h
