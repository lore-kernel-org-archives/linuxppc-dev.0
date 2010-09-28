Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A1B94B7123
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 04:55:41 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH v3 0/2] Add USB Host support for MPC5121 SoC
Date: Tue, 28 Sep 2010 20:55:19 +0200
Message-Id: <1285700121-9991-1-git-send-email-agust@denx.de>
In-Reply-To: <1285666594-21150-1-git-send-email-agust@denx.de>
References: <1285666594-21150-1-git-send-email-agust@denx.de>
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

Version 3 of the patches to add MPC512x USB support in
mainline kernel. USB OTG support is not included in
this patch series, it will be submitted later.

There are only two patches now: patches 1/3 and 2/3 of
the previous version are merged into the first patch and
now bisectable. Additionally the 2nd patch of the previous
version is changed as requested by Grant. Please consider
for inclusion in 2.6.37.

Anatolij Gustschin (2):
  USB: add platform glue driver for FSL USB DR controller
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
 drivers/usb/host/fsl-mph-dr-of.c               |  308 ++++++++++++++++++++++++
 include/linux/fsl_devices.h                    |   15 ++
 11 files changed, 440 insertions(+), 195 deletions(-)
 create mode 100644 drivers/usb/host/fsl-mph-dr-of.c
