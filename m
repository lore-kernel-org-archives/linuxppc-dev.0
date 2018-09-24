Return-Path: <clabbe@baylibre.com>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jtt76NXnzF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:04:29 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id v16-v6so20791241wro.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 12:04:29 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
 airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
 benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
 galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com,
 maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au,
 mporter@kernel.crashing.org, narmstrong@baylibre.com,
 nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
 peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
 wens@csie.org
Cc: cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Date: Mon, 24 Sep 2018 19:04:09 +0000
Message-Id: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello

This patchset adds a new set of functions which are open-coded in lot of
place.
Basicly the pattern is always the same, "read, modify a bit, write"
some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)

The first patch rename some powerpc funtions for being consistent with
the new name convention.

The second patch adds the header with all setbits functions.

The third patch is a try to implement a coccinelle semantic patch to
find all place where xxxbits function could be used.
It should not be merged since it is un-finalized.
For the moment, the "add setbits.h header" is not working and need a future
coccinelle version.

The four last patch are example of some drivers convertion.
Thoses patchs give an example of the reduction of code won by using xxxbits32.

I would like to thanks Julia Lawall for her help on the coccinelle
patch.

Regards

Changes since v1:
- renamed LE functions to _leXX
- updated coccinnelle patch with JLawall's comments

Corentin Labbe (7):
  powerpc: rename setbits32/clrbits32 to setbits32_be/clrbits32_be
  include: add
    setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
    linux/setbits.h
  coccinelle: add xxxsetbitsXX converting spatch
  ata: ahci_sunxi: use xxxsetbits32 functions
  net: ethernet: stmmac: dwmac-sun8i: use xxxsetbits32
  drm: meson: use xxxsetbits32
  net: stmmac: dwmac-meson8b: use xxxsetbits32

 arch/powerpc/include/asm/fsl_lbc.h                 |   2 +-
 arch/powerpc/include/asm/io.h                      |   5 +-
 arch/powerpc/platforms/44x/canyonlands.c           |   4 +-
 arch/powerpc/platforms/4xx/gpio.c                  |  28 +-
 arch/powerpc/platforms/512x/pdm360ng.c             |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   6 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |  10 +-
 arch/powerpc/platforms/82xx/ep8248e.c              |   2 +-
 arch/powerpc/platforms/82xx/km82xx.c               |   6 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c          |  10 +-
 arch/powerpc/platforms/82xx/pq2.c                  |   2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   4 +-
 arch/powerpc/platforms/82xx/pq2fads.c              |  10 +-
 arch/powerpc/platforms/83xx/km83xx.c               |   6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   2 +-
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c       |   4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   4 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |   4 +-
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   4 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |   2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   4 +-
 arch/powerpc/platforms/8xx/adder875.c              |   2 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |   4 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c       |   4 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |  28 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   6 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   8 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |  10 +-
 arch/powerpc/sysdev/cpm1.c                         |  26 +-
 arch/powerpc/sysdev/cpm2.c                         |  16 +-
 arch/powerpc/sysdev/cpm_common.c                   |   4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   8 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   8 +-
 arch/powerpc/sysdev/fsl_pmc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_rcpm.c                     |  74 ++--
 arch/powerpc/sysdev/fsl_rio.c                      |   4 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   8 +-
 arch/powerpc/sysdev/mpic_timer.c                   |  12 +-
 drivers/ata/ahci_sunxi.c                           |  51 +--
 drivers/gpu/drm/meson/meson_crtc.c                 |  14 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  33 +-
 drivers/gpu/drm/meson/meson_plane.c                |  13 +-
 drivers/gpu/drm/meson/meson_registers.h            |   3 -
 drivers/gpu/drm/meson/meson_venc.c                 |  13 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |   4 +-
 drivers/gpu/drm/meson/meson_viu.c                  |  65 +--
 drivers/gpu/drm/meson/meson_vpp.c                  |  22 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  56 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  62 +--
 include/linux/setbits.h                            |  88 ++++
 scripts/add_new_include_in_source.py               |  61 +++
 scripts/coccinelle/misc/setbits32.cocci            | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits32_relaxed.cocci    | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits64.cocci            | 487 +++++++++++++++++++++
 scripts/coccinelle/misc/setbits_dev.cocci          | 235 ++++++++++
 58 files changed, 2159 insertions(+), 377 deletions(-)
 create mode 100644 include/linux/setbits.h
 create mode 100755 scripts/add_new_include_in_source.py
 create mode 100644 scripts/coccinelle/misc/setbits32.cocci
 create mode 100644 scripts/coccinelle/misc/setbits32_relaxed.cocci
 create mode 100644 scripts/coccinelle/misc/setbits64.cocci
 create mode 100644 scripts/coccinelle/misc/setbits_dev.cocci

-- 
2.16.4
