Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKR71J2PzF0pP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:39 +1100 (AEDT)
Received: by mail-pg0-x236.google.com with SMTP id t4so7361879pgp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:39 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 00/17] ASoC: fsl_ssi: Clean up - program flow level
Date: Mon, 12 Feb 2018 14:03:08 -0800
Message-Id: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ The v6 just rebased the series and fixed the comments in probe().
  There is no need to re-test it except the uncovered tests listed
  at the end of this cover letter.
  
  Timur, these patches have been in the list for quite a long time
  and there has been no review for nearly a month since last ver.
  Would you please give a review and send an ack? Thanks a lot. ]

==Change log==
v6
 * Added Tested-by and Reviewed-by from Maciej.
 * Fixed one line of comments in the probe() suggested by Maciej.
 * Rebased all patches since there's a change of fsl_ssi merged
   recently.
v5
 * Reworked the series by taking suggestions from Maciej for AC97
   + Fixed SSI lockup issue by changing cleanup sequence in PATCH-13
   + Moved fsl_ssi_hw_clean() after unregistering the CODEC device
     in PATCH-13
   + Set NULL as the parent of CODEC platform device to fix a NULL
     pointer dereference bug in PATCH-16
 * Updated comments of three variables/pointers in struct fsl_ssi
   to describe them more accurately in PATCH-16
v4
 * Reworked the series by taking suggestions from Maciej
   + Added TXBIT0 bit back to play safe in PATCH-14
   + Made bool synchronous exclusive with AC97 mode in PATCH-16
v3
 * Reworked the series by taking suggestions from Maciej
   + Added PATCH-01 to make RX and TX more clearly defined
   + Replaced "bool dir" with "int dir" in PATCH-04
   + Replaced "!dir" with "int adir" in PATCH-05
   + Put CBM_CFS behind the baudclk check to keep the same
     program flow in PATCH-14
   + Removed all cpu_dai_drv changes in PATCH-15
v2
 * Reworked the series by taking suggestions from Maciej
   + Added PATCH-01 to keep all ssi->i2s_net updated
   + Replaced bool tx with bool dir in PATCH-03 and PATCH-06
   + Moved all initial register configurations from dai probe() to
     platform probe() so as to let AC97 CODEC successfully probe.
 * Added Tested-by from Caleb for TDM test cases.

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
This series of patches is the second set to clean up fsl_ssi driver
in the program flow level. Any patch here may impact a fundamental
test case like playback or record.

==Verification==
This series of patches require to be fully tested. I have done such
tests on i.MX6SoloX with WM8962 using imx_v6_v7_defconfig as:
 - Playback via I2S Master and Slave mode
 - Record via I2S Master and Slave mode
 - Simultaneous playback and record via I2S Master and Slave mode
 - Background playback with foreground record (starting at different
   time) via I2S Master and Slave mode
 - Background record with foreground playback (starting at different
   time) via I2S Master and Slave mode
 * All tests above by hacking offline_config to true in imx51.

Caleb has tested all versions with TDM lookback tests on i.MX6.

Maciej has tested v5 with AC97 tests on i.MX6.

Example of uncovered tests: PowerPC and FIQ.

Nicolin Chen (17):
  ASoC: fsl_ssi: Redefine RX and TX macros
  ASoC: fsl_ssi: Keep ssi->i2s_net updated
  ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
  ASoC: fsl_ssi: Maintain a mask of active streams
  ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
  ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
  ASoC: fsl_ssi: Clean up helper functions of trigger()
  ASoC: fsl_ssi: Add DAIFMT define for AC97
  ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
  ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
  ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
  ASoC: fsl_ssi: Move one-time configurations to probe()
  ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
  ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
  ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode
  ASoC: fsl_ssi: Move DT related code to a separate probe()
  ASoC: fsl_ssi: Use ssi->streams instead of reading register

 sound/soc/fsl/fsl_ssi.c | 756 +++++++++++++++++++++++++-----------------------
 sound/soc/fsl/fsl_ssi.h |   3 -
 2 files changed, 395 insertions(+), 364 deletions(-)

-- 
2.1.4
