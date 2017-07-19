Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0078.outbound.protection.outlook.com [104.47.1.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC6vm3V63zDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:44:36 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "oss@buserror.net" <oss@buserror.net>
Subject: RE: [PATCH 2/3] soc/fsl/qe: only apply QE_General4 workaround on
 affected SoCs
Date: Wed, 19 Jul 2017 06:44:30 +0000
Message-ID: <AM3PR04MB11856946C0C3F88260E039CF91A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1487327387-26370-1-git-send-email-valentin.longchamp@keymile.com>
 <1487327387-26370-3-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1487327387-26370-3-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Valentin,

This patch you added make the compiling issue on armv8.
Could you send another patch to resolve it?

CC      drivers/soc/samsung/pm_domains.o
  CC      drivers/soc/sunxi/sunxi_sram.o
  CC      drivers/soc/renesas/rcar-rst.o
  CC      drivers/soc/fsl/qe/qe_io.o
drivers/soc/fsl/qe/qe.c: In function 'qe_setbrg':
drivers/soc/fsl/qe/qe.c:248:2: error: implicit declaration of function 'pvr=
_version_is' [-Werror=3Dimplicit-function-declaration]
  if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
  ^
  CC      drivers/soc/fsl/qe/ucc.o
  CC      drivers/soc/renesas/rcar-sysc.o
  CHK     kernel/config_data.h
cc1: some warnings being treated as errors
  CC      drivers/soc/tegra/fuse/fuse-tegra.o
  LD      drivers/soc/rockchip/built-in.o
  CC      drivers/soc/tegra/fuse/fuse-tegra30.o
scripts/Makefile.build:302: recipe for target 'drivers/soc/fsl/qe/qe.o' fai=
led
make[4]: *** [drivers/soc/fsl/qe/qe.o] Error 1

-----Original Message-----
From: Valentin Longchamp [mailto:valentin.longchamp@keymile.com]=20
Sent: Friday, February 17, 2017 6:30 PM
To: linuxppc-dev@lists.ozlabs.org; Qiang Zhao <qiang.zhao@nxp.com>
Cc: oss@buserror.net; Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH 2/3] soc/fsl/qe: only apply QE_General4 workaround on affec=
ted SoCs

The QE_General4 workaround is only valid for the MPC832x and MPC836x SoCs. =
The other SoCs that embed a QUICC engine are not affected by this hardware =
bug and thus can use the computed divisors (this was successfully tested on=
 the T1040).

Similalry to what was done in commit 8ce795cb0c6b ("i2c: mpc: assign the co=
rrect prescaler from SVR") in order to avoid changes in the device tree nod=
es of the QE (with maybe a variant of the compatible property), the PVR reg=
 is read out to find out if the workaround must be applied or not.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/soc/fsl/qe/qe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c index 03874d=
f..b66157fc 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -202,6 +202,9 @@ unsigned int qe_get_brg_clk(void)  }  EXPORT_SYMBOL(qe_=
get_brg_clk);
=20
+#define PVR_VER_836x	0x8083
+#define PVR_VER_832x	0x8084
+
 /* Program the BRG to the given sampling rate and multiplier
  *
  * @brg: the BRG, QE_BRG1 - QE_BRG16
@@ -228,8 +231,9 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, uns=
igned int multiplier)
 	/* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
 	   that the BRG divisor must be even if you're not using divide-by-16
 	   mode. */
-	if (!div16 && (divisor & 1) && (divisor > 3))
-		divisor++;
+	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
+		if (!div16 && (divisor & 1) && (divisor > 3))
+			divisor++;
=20
 	tempval =3D ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
 		QE_BRGC_ENABLE | div16;
--
1.8.3.1
