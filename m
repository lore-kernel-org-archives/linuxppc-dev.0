Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x22c.google.com (mail-pf0-x22c.google.com
 [IPv6:2607:f8b0:400e:c00::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxt1F23YdzDqnt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 10:18:57 +1100 (AEDT)
Received: by mail-pf0-x22c.google.com with SMTP id v26so2261162pfl.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 15:18:57 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v3 00/11] ASoC: fsl_ssi: Clean up - coding style level
Date: Wed, 13 Dec 2017 15:18:17 -0800
Message-Id: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

==Changelog==
v2->v3
 * Added Tested-by and Reviewed-by from Maciej
 * Revised PATCH-03 "Refine all comments" by adding Maciej advice
 * Revised PATCH-05 "Refine indentations and wrappings"
v1->v2
 * Dropped one patch to remove "struct device"
 * Revised PATCH-03 "Refine all comments"
 * Revised PATCH-05 "Refine indentations and wrappings"
 * Rebased all other patches
 * Added PATCH-10 "Rename i2smode to i2s_net"
 * Added PATCH-11 "Define ternary macros to simplify code"

 # Detialed changes are described in each updated patch.

==Background==
The fsl_ssi driver was designed for PPC originally and then it has
been updated to support different modes for i.MX Series, including
SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
contributors for different use cases in different coding styles.

Additionally, in order to fix/work-around hardware bugs and design
flaws, the driver made a lot of compromise so now its program flow
looks very complicated and it's getting hard to maintain or update.

So I am going to clean up the driver on both coding style level and
program flow level.

==Introduction==
This series of patches is the first set to clean up fsl_ssi driver
in the coding style level. Any patch here is not supposed to change
the program flow.

==Verification==
Theoretically, since these patches do not change program flow, they
only need code review, build or sanity tests. I have done build and
sanity tests on an i.MX6SoloX with WM8962 using imx_v6_v7_defconfig
and playback/record tests in I2S Master/Slave modes.

Nicolin Chen (11):
  ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
  ASoC: fsl_ssi: Cache pdev->dev pointer
  ASoC: fsl_ssi: Refine all comments
  ASoC: fsl_ssi: Rename registers and fields macros
  ASoC: fsl_ssi: Refine indentations and wrappings
  ASoC: fsl_ssi: Refine printk outputs
  ASoC: fsl_ssi: Rename cpu_dai parameter to dai
  ASoC: fsl_ssi: Rename scr_val to scr
  ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
  ASoC: fsl_ssi: Rename i2smode to i2s_net
  ASoC: fsl_ssi: Define ternary macros to simplify code

 sound/soc/fsl/fsl_ssi.c     | 1374 +++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  427 ++++++++------
 sound/soc/fsl/fsl_ssi_dbg.c |   59 +-
 3 files changed, 879 insertions(+), 981 deletions(-)

-- 
2.1.4
