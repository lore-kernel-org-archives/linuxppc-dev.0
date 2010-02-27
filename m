Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CC746B7DAA
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 08:59:31 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)
Date: Sat, 27 Feb 2010 22:58:19 +0100
Message-Id: <1267307902-31939-1-git-send-email-agust@denx.de>
In-Reply-To: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series rework DIU support patch submitted
previously with the patch series for updating MPC5121
support in mainline. It doesn't add new panel timing data
to the framebuffer driver anymore. Instead we now allow
encoding this data in the device tree. First two patches
add this support.

The third patch for DIU support is rebased, but still
depends on patches for adding MPC5121 USB support (because
it touches shared platform code).

It is intended for inclusion in 2.6.34, since without
DIU support patch framebuffer doesn't work on mpc5121.

Anatolij Gustschin (3):
  video: add support for getting video mode from device tree
  fbdev: fsl-diu-fb.c: allow setting panel video mode from DT
  powerpc/mpc5121: shared DIU framebuffer support

 arch/powerpc/platforms/512x/mpc5121_ads.c     |    7 +
 arch/powerpc/platforms/512x/mpc5121_generic.c |   13 ++
 arch/powerpc/platforms/512x/mpc512x.h         |    3 +
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  282 +++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/Kconfig                         |    6 +
 drivers/video/Makefile                        |    1 +
 drivers/video/fsl-diu-fb.c                    |   88 +++++---
 drivers/video/fsl-diu-fb.h                    |  223 -------------------
 drivers/video/ofmode.c                        |   95 +++++++++
 drivers/video/ofmode.h                        |    6 +
 include/linux/fsl-diu-fb.h                    |  223 +++++++++++++++++++
 12 files changed, 693 insertions(+), 255 deletions(-)
 delete mode 100644 drivers/video/fsl-diu-fb.h
 create mode 100644 drivers/video/ofmode.c
 create mode 100644 drivers/video/ofmode.h
 create mode 100644 include/linux/fsl-diu-fb.h
