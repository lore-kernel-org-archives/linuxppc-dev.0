Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8zvD03f7zDqcS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 00:21:11 +1100 (AEDT)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: qiang.zhao@nxp.com, oss@buserror.net,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [RFC 2/3] soc/fsl/qe: only apply QE_General4 workaround on affected
 SoCs
Date: Fri, 27 Jan 2017 14:15:16 +0100
Message-Id: <1485522917-2150-3-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1485522917-2150-1-git-send-email-valentin.longchamp@keymile.com>
References: <1485522917-2150-1-git-send-email-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The QE_General4 workaround is only valid for the MPC832x and MPC836x
SoCs. The other SoCs that embed a QUICC engine are not affected by this
hardware bug and thus can use the computed divisors (this was
successfully tested on the T1040).

Similalry to what was done in commit 8ce795cb0c6b ("i2c: mpc: assign the
correct prescaler from SVR") in order to avoid changes in
the device tree nodes of the QE (with maybe a variant of the compatible
property), the PVR reg is read out to find out if the workaround must be
applied or not.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/soc/fsl/qe/qe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 5482302..8cf9493 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -202,6 +202,9 @@ unsigned int qe_get_brg_clk(void)
 }
 EXPORT_SYMBOL(qe_get_brg_clk);
 
+#define PVR_VER_836x	0x8083
+#define PVR_VER_832x	0x8084
+
 /* Program the BRG to the given sampling rate and multiplier
  *
  * @brg: the BRG, QE_BRG1 - QE_BRG16
@@ -228,8 +231,9 @@ int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier)
 	/* Errata QE_General4, which affects some MPC832x and MPC836x SOCs, says
 	   that the BRG divisor must be even if you're not using divide-by-16
 	   mode. */
-	if (!div16 && (divisor & 1) && (divisor > 3))
-		divisor++;
+	if (pvr_version_is(PVR_VER_836x) || pvr_version_is(PVR_VER_832x))
+		if (!div16 && (divisor & 1) && (divisor > 3))
+			divisor++;
 
 	tempval = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
 		QE_BRGC_ENABLE | div16;
-- 
1.8.3.1
