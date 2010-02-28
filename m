Return-Path: <R58495@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3A819B7D4B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 01:32:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1SEWEIT000579
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 07:32:14 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o1SEeDtk022314
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 08:40:14 -0600 (CST)
Message-ID: <10cb201cab882$d0026955$0c23400a@fsl.freescale.net>
Content-Type: text/plain;
	charset="utf-8"
From: "sun york-R58495" <R58495@freescale.com>
To: "Anatolij Gustschin" <agust@denx.de>
Subject: RE: [PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)
MIME-Version: 1.0
Date: Sun, 28 Feb 2010 08:32:06 -0600
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, jrigby@gmail.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I agree device tree is the right direction to go.=0A=
=0A=
Sent from my Android phone=0A=
----- Original Message -----=0A=
From:"Anatolij Gustschin" <agust@denx.de>=0A=
To:"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>=0A=
Cc:"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, =
"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, =
"yorksun@freescale.com" <yorksun@freescale.com>, "dzu@denx.de" =
<dzu@denx.de>, "wd@denx.de" <wd@denx.de>, "jrigby@gmail.com" =
<jrigby@gmail.com>, "Anatolij Gustschin" <agust@denx.de>=0A=
Sent:02-27-2010 16:00=0A=
Subject:[PATCH 0/3] Rework MPC5121 DIU support (for 2.6.34)=0A=
=0A=
=0A=
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
 arch/powerpc/platforms/512x/mpc512x_shared.c  |  282 =
+++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h                 |    1 +
 drivers/video/Kconfig                         |    6 +
 drivers/video/Makefile                        |    1 +
 drivers/video/fsl-diu-fb.c                    |   88 +++++---
 drivers/video/fsl-diu-fb.h                    |  223 =
-------------------
 drivers/video/ofmode.c                        |   95 +++++++++
 drivers/video/ofmode.h                        |    6 +
 include/linux/fsl-diu-fb.h                    |  223 =
+++++++++++++++++++
 12 files changed, 693 insertions(+), 255 deletions(-)
 delete mode 100644 drivers/video/fsl-diu-fb.h
 create mode 100644 drivers/video/ofmode.c
 create mode 100644 drivers/video/ofmode.h
 create mode 100644 include/linux/fsl-diu-fb.h
