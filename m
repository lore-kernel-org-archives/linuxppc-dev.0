Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 44E951007DD
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 00:01:00 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 0/5] Rework MPC5121 DIU support (for 2.6.36)
Date: Fri, 23 Jul 2010 16:00:34 +0200
Message-Id: <1279893639-24333-1-git-send-email-agust@denx.de>
Cc: linux-fbdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, devicetree-discuss@lists.ozlabs.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support for MPC5121 DIU in mainline kernel is currently
brocken. The intention of this patch series is to provide
working 5121 DIU support in v2.6.36.

This patch series rework DIU support patches submitted
previously. Comments to the previos patch series have
been addressed, not related changes are dropped and some
changes are split out to separate patches to simplify
review. Furthermore a patch has been added to support
setting display mode using EDID block in the device tree.

v4 series is rebased to apply on current tree. Timur did
some testing of patches from previous version to ensure
that these do not break DIU support for MPC8610 HPCD.
He then has send his Acked-by, so I added it to the
related patches.

The first patch is changed to provide another complete
workaround to the observed issue as suggested by Freescale
technical support.

Anatolij Gustschin (5):
  fsl-diu-fb: fix issue with re-enabling DIU area descriptor
  fsl-diu-fb: move fsl-diu-fb.h to include/linux
  powerpc/mpc5121: shared DIU framebuffer support
  powerpc: doc/dts-bindings: update doc of FSL DIU bindings
  fsl-diu-fb: Support setting display mode using EDID

 Documentation/powerpc/dts-bindings/fsl/diu.txt |   20 ++-
 arch/powerpc/include/asm/mpc5121.h             |   32 +++
 arch/powerpc/platforms/512x/mpc5121_ads.c      |    2 +
 arch/powerpc/platforms/512x/mpc5121_generic.c  |    2 +
 arch/powerpc/platforms/512x/mpc512x.h          |    2 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |  284 ++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                  |    1 +
 drivers/video/Kconfig                          |    1 +
 drivers/video/fsl-diu-fb.c                     |  137 ++++++++++--
 {drivers/video => include/linux}/fsl-diu-fb.h  |    0
 10 files changed, 455 insertions(+), 26 deletions(-)
 rename {drivers/video => include/linux}/fsl-diu-fb.h (100%)
