Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A8CEDB6F06
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 02:25:28 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH 0/3] Add USB Host support for MPC5121 SoC
Date: Thu, 22 Jul 2010 18:25:19 +0200
Message-Id: <1279815922-27198-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is new attempt to add MPC512x USB support in mainline kernel.
USB OTG support is not included in this patch series, it will be
submitted later.

Anatolij Gustschin (3):
  powerpc/fsl_soc.c: remove FSL USB platform code
  USB: add of_platform glue driver for FSL USB DR controller
  USB: add USB EHCI support for MPC5121 SoC

 Documentation/powerpc/dts-bindings/fsl/usb.txt |   22 ++
 arch/powerpc/sysdev/fsl_soc.c                  |  163 --------------
 drivers/usb/Kconfig                            |    1 +
 drivers/usb/gadget/Kconfig                     |    1 +
 drivers/usb/host/Kconfig                       |   11 +-
 drivers/usb/host/Makefile                      |    1 +
 drivers/usb/host/ehci-fsl.c                    |  107 +++++++---
 drivers/usb/host/ehci-fsl.h                    |   19 ++-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 drivers/usb/host/fsl-mph-dr-of.c               |  278 ++++++++++++++++++++++++
 include/linux/fsl_devices.h                    |   15 ++
 11 files changed, 425 insertions(+), 195 deletions(-)
 create mode 100644 drivers/usb/host/fsl-mph-dr-of.c
