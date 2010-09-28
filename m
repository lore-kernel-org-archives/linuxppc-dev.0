Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 118E9B70D3
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 19:36:46 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH v2 0/3] Add USB Host support for MPC5121 SoC
Date: Tue, 28 Sep 2010 11:36:31 +0200
Message-Id: <1285666594-21150-1-git-send-email-agust@denx.de>
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

This is version 2 of patches to add MPC512x USB support in
mainline kernel. USB OTG support is not included in this
patch series, it will be submitted later.

The patches have been rebased on current linux-next tree
and reworked to address comments from Grant.

Anatolij Gustschin (3):
  powerpc/fsl_soc.c: remove FSL USB platform code
  USB: add of_platform glue driver for FSL USB DR controller
  USB: add USB EHCI support for MPC5121 SoC

 Documentation/powerpc/dts-bindings/fsl/usb.txt |   22 ++
 arch/powerpc/sysdev/fsl_soc.c                  |  163 -------------
 drivers/usb/Kconfig                            |    1 +
 drivers/usb/gadget/Kconfig                     |    1 +
 drivers/usb/host/Kconfig                       |   10 +-
 drivers/usb/host/Makefile                      |    1 +
 drivers/usb/host/ehci-fsl.c                    |   99 ++++++---
 drivers/usb/host/ehci-fsl.h                    |   13 +-
 drivers/usb/host/ehci-mem.c                    |    2 +-
 drivers/usb/host/fsl-mph-dr-of.c               |  302 ++++++++++++++++++++++++
 include/linux/fsl_devices.h                    |   15 ++
 11 files changed, 434 insertions(+), 195 deletions(-)
 create mode 100644 drivers/usb/host/fsl-mph-dr-of.c
