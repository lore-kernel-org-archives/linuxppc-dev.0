Return-Path: <tomeu.vizoso@gmail.com>
Received: from mail-wi0-x234.google.com (mail-wi0-x234.google.com
 [IPv6:2a00:1450:400c:c05::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 362BE1A071C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 23:58:18 +1000 (EST)
Received: by mail-wi0-f180.google.com with SMTP id n3so3262276wiv.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Aug 2014 06:58:14 -0700 (PDT)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v5 3/6] clk: Move all drivers to use internal API
Date: Wed,  6 Aug 2014 15:57:48 +0200
Message-Id: <1407333468-32180-1-git-send-email-tomeu.vizoso@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Tomasz Figa <t.figa@samsung.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Daniel Walker <dwalker@fifo99.com>, linux-arch@vger.kernel.org,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>,
 =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
 Takashi Iwai <tiwai@suse.de>, Michal Simek <michal.simek@xilinx.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, patches@opensource.wolfsonmicro.com,
 Viresh Kumar <viresh.linux@gmail.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>, Dinh Nguyen <dinguyen@altera.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 spear-devel@list.st.com, Barry Song <baohua@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org,
 Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawn.guo@freescale.com>, Paul Walmsley <paul@pwsan.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>, linux-kernel@vger.kernel.org,
 rabin@rab.in, Bryan Huntsman <bryanh@codeaurora.org>,
 Santosh Shilimkar <santosh.shilimkar@ti.com>,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, linux-media@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to change the public API to return a per-user clk structure,
remove any usage of this public API from the clock implementations.

The reason for having this in a separate commit from the one that introduces
the implementation of the new functions is to separate the changes generated
with Coccinelle from the rest, and keep the patches' size reasonable.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/mach-dove/common.c                   |  10 +-
 arch/arm/mach-imx/clk-busy.c                  |   8 +-
 arch/arm/mach-imx/clk-fixup-div.c             |   4 +-
 arch/arm/mach-imx/clk-fixup-mux.c             |   4 +-
 arch/arm/mach-imx/clk-gate2.c                 |   4 +-
 arch/arm/mach-imx/clk-imx1.c                  |   2 +-
 arch/arm/mach-imx/clk-imx21.c                 |   2 +-
 arch/arm/mach-imx/clk-imx25.c                 |   8 +-
 arch/arm/mach-imx/clk-imx27.c                 |   4 +-
 arch/arm/mach-imx/clk-imx31.c                 |  10 +-
 arch/arm/mach-imx/clk-imx35.c                 |  22 +-
 arch/arm/mach-imx/clk-imx51-imx53.c           |  77 +++---
 arch/arm/mach-imx/clk-imx6q.c                 |  38 +--
 arch/arm/mach-imx/clk-imx6sl.c                |  13 +-
 arch/arm/mach-imx/clk-imx6sx.c                |  97 ++++---
 arch/arm/mach-imx/clk-pfd.c                   |   4 +-
 arch/arm/mach-imx/clk-pllv1.c                 |   4 +-
 arch/arm/mach-imx/clk-pllv2.c                 |   4 +-
 arch/arm/mach-imx/clk-pllv3.c                 |   4 +-
 arch/arm/mach-imx/clk-vf610.c                 |  42 +--
 arch/arm/mach-imx/clk.c                       |   8 +-
 arch/arm/mach-imx/clk.h                       |  38 +--
 arch/arm/mach-kirkwood/common.c               |  22 +-
 arch/arm/mach-msm/clock-pcom.c                |   2 +-
 arch/arm/mach-mv78xx0/common.c                |   2 +-
 arch/arm/mach-omap2/cclock2420_data.c         | 168 ++++++------
 arch/arm/mach-omap2/cclock2430_data.c         | 186 ++++++-------
 arch/arm/mach-omap2/cclock3xxx_data.c         | 370 +++++++++++++-------------
 arch/arm/mach-omap2/clkt2xxx_dpll.c           |   4 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c       |   4 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c  |  10 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c        |   2 +-
 arch/arm/mach-omap2/clkt_clksel.c             |  46 ++--
 arch/arm/mach-omap2/clkt_dpll.c               |   8 +-
 arch/arm/mach-omap2/clock.c                   |  52 ++--
 arch/arm/mach-omap2/clock.h                   |  20 +-
 arch/arm/mach-omap2/clock3xxx.c               |  22 +-
 arch/arm/mach-omap2/clock3xxx.h               |   4 +-
 arch/arm/mach-omap2/clock_common_data.c       |   2 +-
 arch/arm/mach-omap2/clockdomain.c             |   8 +-
 arch/arm/mach-omap2/clockdomain.h             |   4 +-
 arch/arm/mach-omap2/display.c                 |   4 +-
 arch/arm/mach-omap2/dpll3xxx.c                |  28 +-
 arch/arm/mach-omap2/dpll44xx.c                |   4 +-
 arch/arm/mach-omap2/mcbsp.c                   |   4 +-
 arch/arm/mach-omap2/omap_device.c             |   8 +-
 arch/arm/mach-omap2/omap_hwmod.c              |  42 +--
 arch/arm/mach-omap2/omap_hwmod.h              |  12 +-
 arch/arm/mach-omap2/pm24xx.c                  |  12 +-
 arch/arm/mach-orion5x/common.c                |   2 +-
 arch/arm/plat-orion/common.c                  |  20 +-
 arch/arm/plat-orion/include/plat/common.h     |  12 +-
 arch/powerpc/platforms/512x/clock-commonclk.c |  48 ++--
 drivers/clk/at91/clk-main.c                   |  24 +-
 drivers/clk/at91/clk-master.c                 |   6 +-
 drivers/clk/at91/clk-peripheral.c             |  12 +-
 drivers/clk/at91/clk-pll.c                    |   6 +-
 drivers/clk/at91/clk-plldiv.c                 |   6 +-
 drivers/clk/at91/clk-programmable.c           |  10 +-
 drivers/clk/at91/clk-slow.c                   |  24 +-
 drivers/clk/at91/clk-smd.c                    |   6 +-
 drivers/clk/at91/clk-system.c                 |   6 +-
 drivers/clk/at91/clk-usb.c                    |  18 +-
 drivers/clk/at91/clk-utmi.c                   |   6 +-
 drivers/clk/bcm/clk-kona-setup.c              |   6 +-
 drivers/clk/bcm/clk-kona.c                    |  12 +-
 drivers/clk/bcm/clk-kona.h                    |   2 +-
 drivers/clk/berlin/berlin2-avpll.c            |   4 +-
 drivers/clk/berlin/berlin2-avpll.h            |   4 +-
 drivers/clk/berlin/berlin2-div.c              |   2 +-
 drivers/clk/berlin/berlin2-div.h              |   2 +-
 drivers/clk/berlin/berlin2-pll.c              |   2 +-
 drivers/clk/berlin/berlin2-pll.h              |   2 +-
 drivers/clk/berlin/bg2.c                      |  12 +-
 drivers/clk/berlin/bg2q.c                     |   8 +-
 drivers/clk/clk-axi-clkgen.c                  |   2 +-
 drivers/clk/clk-axm5516.c                     |   4 +-
 drivers/clk/clk-bcm2835.c                     |   2 +-
 drivers/clk/clk-composite.c                   |   6 +-
 drivers/clk/clk-divider.c                     |   8 +-
 drivers/clk/clk-efm32gg.c                     |   2 +-
 drivers/clk/clk-fixed-factor.c                |   6 +-
 drivers/clk/clk-fixed-rate.c                  |   8 +-
 drivers/clk/clk-fractional-divider.c          |   4 +-
 drivers/clk/clk-gate.c                        |   4 +-
 drivers/clk/clk-highbank.c                    |   8 +-
 drivers/clk/clk-ls1x.c                        |  16 +-
 drivers/clk/clk-max77686.c                    |  10 +-
 drivers/clk/clk-moxart.c                      |   8 +-
 drivers/clk/clk-mux.c                         |   6 +-
 drivers/clk/clk-nomadik.c                     |  14 +-
 drivers/clk/clk-nspire.c                      |   4 +-
 drivers/clk/clk-ppc-corenet.c                 |   8 +-
 drivers/clk/clk-s2mps11.c                     |   6 +-
 drivers/clk/clk-si5351.c                      |  17 +-
 drivers/clk/clk-si570.c                       |   4 +-
 drivers/clk/clk-twl6040.c                     |   2 +-
 drivers/clk/clk-u300.c                        |  12 +-
 drivers/clk/clk-vt8500.c                      |   4 +-
 drivers/clk/clk-wm831x.c                      |   6 +-
 drivers/clk/clk-xgene.c                       |  12 +-
 drivers/clk/clk.h                             |   4 +-
 drivers/clk/hisilicon/clk-hi3620.c            |   8 +-
 drivers/clk/hisilicon/clk.c                   |  16 +-
 drivers/clk/hisilicon/clk.h                   |   2 +-
 drivers/clk/hisilicon/clkgate-separated.c     |   4 +-
 drivers/clk/keystone/gate.c                   |   6 +-
 drivers/clk/keystone/pll.c                    |  10 +-
 drivers/clk/mmp/clk-apbc.c                    |   4 +-
 drivers/clk/mmp/clk-apmu.c                    |   4 +-
 drivers/clk/mmp/clk-frac.c                    |   4 +-
 drivers/clk/mmp/clk-mmp2.c                    |  14 +-
 drivers/clk/mmp/clk-pxa168.c                  |  12 +-
 drivers/clk/mmp/clk-pxa910.c                  |  12 +-
 drivers/clk/mmp/clk.h                         |   8 +-
 drivers/clk/mvebu/clk-corediv.c               |   4 +-
 drivers/clk/mvebu/clk-cpu.c                   |   8 +-
 drivers/clk/mvebu/common.c                    |  14 +-
 drivers/clk/mxs/clk-div.c                     |   4 +-
 drivers/clk/mxs/clk-frac.c                    |   4 +-
 drivers/clk/mxs/clk-imx23.c                   |   4 +-
 drivers/clk/mxs/clk-imx28.c                   |   4 +-
 drivers/clk/mxs/clk-pll.c                     |   4 +-
 drivers/clk/mxs/clk-ref.c                     |   4 +-
 drivers/clk/mxs/clk.h                         |  16 +-
 drivers/clk/qcom/clk-rcg.c                    |   6 +-
 drivers/clk/qcom/clk-rcg2.c                   |  14 +-
 drivers/clk/qcom/clk-regmap.c                 |   2 +-
 drivers/clk/qcom/clk-regmap.h                 |   2 +-
 drivers/clk/qcom/common.c                     |   6 +-
 drivers/clk/qcom/gcc-msm8660.c                |   2 +-
 drivers/clk/qcom/gcc-msm8960.c                |   2 +-
 drivers/clk/qcom/gcc-msm8974.c                |   2 +-
 drivers/clk/qcom/mmcc-msm8960.c               |   6 +-
 drivers/clk/rockchip/clk-rockchip.c           |   2 +-
 drivers/clk/samsung/clk-exynos-audss.c        |  16 +-
 drivers/clk/samsung/clk-exynos4.c             |   6 +-
 drivers/clk/samsung/clk-pll.c                 |   6 +-
 drivers/clk/samsung/clk-pll.h                 |   2 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c        |  10 +-
 drivers/clk/samsung/clk.c                     |  22 +-
 drivers/clk/samsung/clk.h                     |   2 +-
 drivers/clk/shmobile/clk-div6.c               |   2 +-
 drivers/clk/shmobile/clk-emev2.c              |   4 +-
 drivers/clk/shmobile/clk-mstp.c               |   6 +-
 drivers/clk/shmobile/clk-r8a7740.c            |   6 +-
 drivers/clk/shmobile/clk-r8a7779.c            |   6 +-
 drivers/clk/shmobile/clk-rcar-gen2.c          |  10 +-
 drivers/clk/shmobile/clk-rz.c                 |   6 +-
 drivers/clk/sirf/clk-atlas6.c                 |   2 +-
 drivers/clk/sirf/clk-common.c                 |  30 +--
 drivers/clk/sirf/clk-prima2.c                 |   2 +-
 drivers/clk/socfpga/clk-gate.c                |   2 +-
 drivers/clk/socfpga/clk-periph.c              |   2 +-
 drivers/clk/socfpga/clk-pll.c                 |   4 +-
 drivers/clk/spear/clk-aux-synth.c             |   8 +-
 drivers/clk/spear/clk-frac-synth.c            |   4 +-
 drivers/clk/spear/clk-gpt-synth.c             |   4 +-
 drivers/clk/spear/clk-vco-pll.c               |   8 +-
 drivers/clk/spear/clk.h                       |  14 +-
 drivers/clk/spear/spear1310_clock.c           |   2 +-
 drivers/clk/spear/spear1340_clock.c           |   2 +-
 drivers/clk/spear/spear3xx_clock.c            |  16 +-
 drivers/clk/spear/spear6xx_clock.c            |   2 +-
 drivers/clk/st/clkgen-fsyn.c                  |  22 +-
 drivers/clk/st/clkgen-mux.c                   |  32 +--
 drivers/clk/st/clkgen-pll.c                   |  34 +--
 drivers/clk/sunxi/clk-a10-hosc.c              |   2 +-
 drivers/clk/sunxi/clk-a20-gmac.c              |   2 +-
 drivers/clk/sunxi/clk-factors.c               |   4 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c      |   2 +-
 drivers/clk/sunxi/clk-sun6i-apb0.c            |   2 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c           |   6 +-
 drivers/clk/sunxi/clk-sunxi.c                 |  18 +-
 drivers/clk/tegra/clk-audio-sync.c            |   4 +-
 drivers/clk/tegra/clk-divider.c               |   4 +-
 drivers/clk/tegra/clk-periph-gate.c           |   4 +-
 drivers/clk/tegra/clk-periph.c                |   8 +-
 drivers/clk/tegra/clk-pll-out.c               |   4 +-
 drivers/clk/tegra/clk-pll.c                   |  40 +--
 drivers/clk/tegra/clk-super.c                 |   4 +-
 drivers/clk/tegra/clk-tegra-audio.c           |   4 +-
 drivers/clk/tegra/clk-tegra-fixed.c           |   8 +-
 drivers/clk/tegra/clk-tegra-periph.c          |  12 +-
 drivers/clk/tegra/clk-tegra-pmc.c             |   4 +-
 drivers/clk/tegra/clk-tegra-super-gen4.c      |   8 +-
 drivers/clk/tegra/clk-tegra114.c              |  10 +-
 drivers/clk/tegra/clk-tegra124.c              |   6 +-
 drivers/clk/tegra/clk-tegra20.c               |  12 +-
 drivers/clk/tegra/clk-tegra30.c               |   8 +-
 drivers/clk/tegra/clk.c                       |  24 +-
 drivers/clk/tegra/clk.h                       |  38 +--
 drivers/clk/ti/apll.c                         |   8 +-
 drivers/clk/ti/clk-2xxx.c                     |   8 +-
 drivers/clk/ti/clk-33xx.c                     |  18 +-
 drivers/clk/ti/clk-3xxx.c                     |   8 +-
 drivers/clk/ti/clk-43xx.c                     |   8 +-
 drivers/clk/ti/clk-44xx.c                     |  16 +-
 drivers/clk/ti/clk-54xx.c                     |  25 +-
 drivers/clk/ti/clk-7xx.c                      |  16 +-
 drivers/clk/ti/clk-dra7-atl.c                 |   6 +-
 drivers/clk/ti/clk.c                          |   2 +-
 drivers/clk/ti/clockdomain.c                  |   4 +-
 drivers/clk/ti/composite.c                    |   2 +-
 drivers/clk/ti/divider.c                      |   6 +-
 drivers/clk/ti/dpll.c                         |   8 +-
 drivers/clk/ti/fixed-factor.c                 |   2 +-
 drivers/clk/ti/gate.c                         |   2 +-
 drivers/clk/ti/interface.c                    |   2 +-
 drivers/clk/ti/mux.c                          |   6 +-
 drivers/clk/ux500/abx500-clk.c                |   2 +-
 drivers/clk/ux500/clk-prcc.c                  |   8 +-
 drivers/clk/ux500/clk-prcmu.c                 |  16 +-
 drivers/clk/ux500/clk-sysctrl.c               |  10 +-
 drivers/clk/ux500/clk.h                       |  22 +-
 drivers/clk/ux500/u8500_clk.c                 |   2 +-
 drivers/clk/ux500/u8500_of_clk.c              |  12 +-
 drivers/clk/ux500/u8540_clk.c                 |   2 +-
 drivers/clk/versatile/clk-icst.c              |   4 +-
 drivers/clk/versatile/clk-icst.h              |   2 +-
 drivers/clk/versatile/clk-impd1.c             |  18 +-
 drivers/clk/versatile/clk-integrator.c        |   2 +-
 drivers/clk/versatile/clk-realview.c          |   2 +-
 drivers/clk/versatile/clk-sp810.c             |  30 ++-
 drivers/clk/versatile/clk-vexpress-osc.c      |   2 +-
 drivers/clk/versatile/clk-vexpress.c          |   6 +-
 drivers/clk/x86/clk-lpt.c                     |   2 +-
 drivers/clk/zynq/clkc.c                       |  22 +-
 drivers/clk/zynq/pll.c                        |   4 +-
 drivers/media/platform/exynos4-is/media-dev.c |  16 +-
 drivers/media/platform/exynos4-is/media-dev.h |   6 +-
 include/asm-generic/clkdev.h                  |   4 +-
 include/linux/clk/ti.h                        |  10 +-
 include/linux/clk/zynq.h                      |   2 +-
 include/linux/platform_data/si5351.h          |   4 +-
 235 files changed, 1523 insertions(+), 1486 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d1a892..4d95685 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -71,9 +71,9 @@ void __init dove_map_io(void)
 static int dove_tclk;
 
 static DEFINE_SPINLOCK(gating_lock);
-static struct clk *tclk;
+static struct clk_core *tclk;
 
-static struct clk __init *dove_register_gate(const char *name,
+static struct clk_core __init *dove_register_gate(const char *name,
 					     const char *parent, u8 bit_idx)
 {
 	return clk_register_gate(NULL, name, parent, 0,
@@ -83,9 +83,9 @@ static struct clk __init *dove_register_gate(const char *name,
 
 static void __init dove_clk_init(void)
 {
-	struct clk *usb0, *usb1, *sata, *pex0, *pex1, *sdio0, *sdio1;
-	struct clk *nand, *camera, *i2s0, *i2s1, *crypto, *ac97, *pdma;
-	struct clk *xor0, *xor1, *ge, *gephy;
+	struct clk_core *usb0, *usb1, *sata, *pex0, *pex1, *sdio0, *sdio1;
+	struct clk_core *nand, *camera, *i2s0, *i2s1, *crypto, *ac97, *pdma;
+	struct clk_core *xor0, *xor1, *ge, *gephy;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
 				       dove_tclk);
diff --git a/arch/arm/mach-imx/clk-busy.c b/arch/arm/mach-imx/clk-busy.c
index 4bb1bc4..e4161ed 100644
--- a/arch/arm/mach-imx/clk-busy.c
+++ b/arch/arm/mach-imx/clk-busy.c
@@ -78,12 +78,12 @@ static struct clk_ops clk_busy_divider_ops = {
 	.set_rate = clk_busy_divider_set_rate,
 };
 
-struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
+struct clk_core *imx_clk_busy_divider(const char *name, const char *parent_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift)
 {
 	struct clk_busy_divider *busy;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
@@ -152,12 +152,12 @@ static struct clk_ops clk_busy_mux_ops = {
 	.set_parent = clk_busy_mux_set_parent,
 };
 
-struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+struct clk_core *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-fixup-div.c b/arch/arm/mach-imx/clk-fixup-div.c
index 21db020..8a62bfd 100644
--- a/arch/arm/mach-imx/clk-fixup-div.c
+++ b/arch/arm/mach-imx/clk-fixup-div.c
@@ -92,12 +92,12 @@ static const struct clk_ops clk_fixup_div_ops = {
 	.set_rate = clk_fixup_div_set_rate,
 };
 
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_core *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val))
 {
 	struct clk_fixup_div *fixup_div;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	if (!fixup)
diff --git a/arch/arm/mach-imx/clk-fixup-mux.c b/arch/arm/mach-imx/clk-fixup-mux.c
index 0d40b35..e29dc62 100644
--- a/arch/arm/mach-imx/clk-fixup-mux.c
+++ b/arch/arm/mach-imx/clk-fixup-mux.c
@@ -71,12 +71,12 @@ static const struct clk_ops clk_fixup_mux_ops = {
 	.set_parent = clk_fixup_mux_set_parent,
 };
 
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_core *imx_clk_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char **parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	if (!fixup)
diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
index 84acdfd..d78f409 100644
--- a/arch/arm/mach-imx/clk-gate2.c
+++ b/arch/arm/mach-imx/clk-gate2.c
@@ -108,14 +108,14 @@ static struct clk_ops clk_gate2_ops = {
 	.is_enabled = clk_gate2_is_enabled,
 };
 
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk_core *clk_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate2_flags, spinlock_t *lock,
 		unsigned int *share_count)
 {
 	struct clk_gate2 *gate;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	gate = kzalloc(sizeof(struct clk_gate2), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 7f739be..94b7cfa 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -50,7 +50,7 @@ enum imx1_clks {
 	usbd_gate, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 
 int __init mx1_clocks_init(unsigned long fref)
 {
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index bdc2e46..1fc76c5 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -62,7 +62,7 @@ enum imx21_clks {
 	gpio_gate, i2c_gate, kpp_gate, owire_gate, rtc_gate, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 
 /*
  * must be called very early to get information about the
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index ae578c0..3772eb1 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -89,7 +89,7 @@ enum mx25_clks {
 	wdt_ipg, cko_div, cko_sel, cko, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 
 static int __init __mx25_clocks_init(unsigned long osc_rate)
 {
@@ -229,10 +229,10 @@ static int __init __mx25_clocks_init(unsigned long osc_rate)
 			pr_err("i.MX25 clk %d: register failed with %ld\n",
 				i, PTR_ERR(clk[i]));
 
-	clk_prepare_enable(clk[emi_ahb]);
+	clk_provider_prepare_enable(clk[emi_ahb]);
 
 	/* Clock source for gpt must be derived from AHB */
-	clk_set_parent(clk[per5_sel], clk[ahb]);
+	clk_provider_set_parent(clk[per5_sel], clk[ahb]);
 
 	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
@@ -241,7 +241,7 @@ static int __init __mx25_clocks_init(unsigned long osc_rate)
 	 * Let's initially set up CLKO parent as ipg, since this configuration
 	 * is used on some imx25 board designs to clock the audio codec.
 	 */
-	clk_set_parent(clk[cko_sel], clk[ipg]);
+	clk_provider_set_parent(clk[cko_sel], clk[ipg]);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 317a662..071fe2b 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -86,7 +86,7 @@ enum mx27_clks {
 	rtic_ahb_gate, mshc_baud_gate, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 int __init mx27_clocks_init(unsigned long fref)
@@ -278,7 +278,7 @@ int __init mx27_clocks_init(unsigned long fref)
 
 	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
-	clk_prepare_enable(clk[emi_ahb_gate]);
+	clk_provider_prepare_enable(clk[emi_ahb_gate]);
 
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 4a9de08..3db06ac 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -45,7 +45,7 @@ enum mx31_clks {
 	gacc_gate, emi_gate, rtic_gate, firi_gate, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 int __init mx31_clocks_init(unsigned long fref)
@@ -180,11 +180,11 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 
-	clk_set_parent(clk[csi], clk[upll]);
-	clk_prepare_enable(clk[emi_gate]);
-	clk_prepare_enable(clk[iim_gate]);
+	clk_provider_set_parent(clk[csi], clk[upll]);
+	clk_provider_prepare_enable(clk[emi_gate]);
+	clk_provider_prepare_enable(clk[iim_gate]);
 	mx31_revision();
-	clk_disable_unprepare(clk[iim_gate]);
+	clk_provider_disable_unprepare(clk[iim_gate]);
 
 	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
 
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index 71c86a2..4433d08 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -67,7 +67,7 @@ enum mx35_clks {
 	gpu2d_gate, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 
 int __init mx35_clocks_init(void)
 {
@@ -100,7 +100,7 @@ int __init mx35_clocks_init(void)
 	else
 		clk[arm] = imx_clk_fixed_factor("arm", "mpll", 1, aad->arm);
 
-	if (clk_get_rate(clk[arm]) > 400000000)
+	if (clk_provider_get_rate(clk[arm]) > 400000000)
 		hsp_div = hsp_div_532;
 	else
 		hsp_div = hsp_div_400;
@@ -261,14 +261,14 @@ int __init mx35_clocks_init(void)
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
 	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
 
-	clk_prepare_enable(clk[spba_gate]);
-	clk_prepare_enable(clk[gpio1_gate]);
-	clk_prepare_enable(clk[gpio2_gate]);
-	clk_prepare_enable(clk[gpio3_gate]);
-	clk_prepare_enable(clk[iim_gate]);
-	clk_prepare_enable(clk[emi_gate]);
-	clk_prepare_enable(clk[max_gate]);
-	clk_prepare_enable(clk[iomuxc_gate]);
+	clk_provider_prepare_enable(clk[spba_gate]);
+	clk_provider_prepare_enable(clk[gpio1_gate]);
+	clk_provider_prepare_enable(clk[gpio2_gate]);
+	clk_provider_prepare_enable(clk[gpio3_gate]);
+	clk_provider_prepare_enable(clk[iim_gate]);
+	clk_provider_prepare_enable(clk[emi_gate]);
+	clk_provider_prepare_enable(clk[max_gate]);
+	clk_provider_prepare_enable(clk[iomuxc_gate]);
 
 	/*
 	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
@@ -276,7 +276,7 @@ int __init mx35_clocks_init(void)
 	 * handled here and not needed for mmc) and IIM (which is enabled
 	 * unconditionally above).
 	 */
-	clk_prepare_enable(clk[scc_gate]);
+	clk_provider_prepare_enable(clk[scc_gate]);
 
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 21d2b11..88894cd 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -83,7 +83,7 @@ static const char *spdif_sel[] = { "pll1_sw", "pll2_sw", "pll3_sw", "spdif_xtal_
 static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
 static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
 
-static struct clk *clk[IMX5_CLK_END];
+static struct clk_core *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static void __init mx5_clocks_common_init(unsigned long rate_ckil,
@@ -298,26 +298,28 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[IMX5_CLK_EPIT2_HF_GATE], "per", "imx-epit.1");
 
 	/* Set SDHC parents to be PLL2 */
-	clk_set_parent(clk[IMX5_CLK_ESDHC_A_SEL], clk[IMX5_CLK_PLL2_SW]);
-	clk_set_parent(clk[IMX5_CLK_ESDHC_B_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_provider_set_parent(clk[IMX5_CLK_ESDHC_A_SEL],
+				clk[IMX5_CLK_PLL2_SW]);
+	clk_provider_set_parent(clk[IMX5_CLK_ESDHC_B_SEL],
+				clk[IMX5_CLK_PLL2_SW]);
 
 	/* move usb phy clk to 24MHz */
-	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
-
-	clk_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
-	clk_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
-	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
-	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ2]); /* fec */
-	clk_prepare_enable(clk[IMX5_CLK_SPBA]);
-	clk_prepare_enable(clk[IMX5_CLK_EMI_FAST_GATE]); /* fec */
-	clk_prepare_enable(clk[IMX5_CLK_EMI_SLOW_GATE]); /* eim */
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSC1_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSC2_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_ESC_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_MIPI_HSP_GATE]);
-	clk_prepare_enable(clk[IMX5_CLK_TMAX1]);
-	clk_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
-	clk_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
+	clk_provider_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
+
+	clk_provider_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
+	clk_provider_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_AIPS_TZ2]); /* fec */
+	clk_provider_prepare_enable(clk[IMX5_CLK_SPBA]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_EMI_FAST_GATE]); /* fec */
+	clk_provider_prepare_enable(clk[IMX5_CLK_EMI_SLOW_GATE]); /* eim */
+	clk_provider_prepare_enable(clk[IMX5_CLK_MIPI_HSC1_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_MIPI_HSC2_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_MIPI_ESC_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_MIPI_HSP_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_TMAX1]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
+	clk_provider_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
 }
 
 static void __init mx50_clocks_init(struct device_node *np)
@@ -361,15 +363,15 @@ static void __init mx50_clocks_init(struct device_node *np)
 	mx5_clocks_common_init(0, 0, 0, 0);
 
 	/* set SDHC root clock to 200MHZ*/
-	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
-	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
 
-	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX50", IMX_CHIP_REVISION_1_1);
-	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
-	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
-	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
+	r = clk_provider_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
+	clk_provider_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
 	mxc_timer_init_dt(of_find_compatible_node(NULL, NULL, "fsl,imx50-gpt"));
 }
@@ -447,18 +449,19 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_register_clkdev(clk[IMX5_CLK_ESDHC4_PER_GATE], "per", "sdhci-esdhc-imx51.3");
 
 	/* set the usboh3 parent to pll2_sw */
-	clk_set_parent(clk[IMX5_CLK_USBOH3_SEL], clk[IMX5_CLK_PLL2_SW]);
+	clk_provider_set_parent(clk[IMX5_CLK_USBOH3_SEL],
+				clk[IMX5_CLK_PLL2_SW]);
 
 	/* set SDHC root clock to 166.25MHZ*/
-	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 166250000);
-	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 166250000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 166250000);
 
 	/* System timer */
 	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR), MX51_INT_GPT);
 
-	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
-	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
 	/*
 	 * Reference Manual says: Functionality of CCDR[18] and CLPCR[23] is no
@@ -571,18 +574,18 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk_register_clkdev(clk[IMX5_CLK_ESDHC4_PER_GATE], "per", "sdhci-esdhc-imx53.3");
 
 	/* set SDHC root clock to 200MHZ*/
-	clk_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
-	clk_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_A_PODF], 200000000);
+	clk_provider_set_rate(clk[IMX5_CLK_ESDHC_B_PODF], 200000000);
 
 	/* move can bus clk to 24MHz */
-	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
+	clk_provider_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
 
-	clk_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_prepare_enable(clk[IMX5_CLK_IIM_GATE]);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
-	clk_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
+	clk_provider_disable_unprepare(clk[IMX5_CLK_IIM_GATE]);
 
-	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
-	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
+	r = clk_provider_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
+	clk_provider_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
 	mxc_timer_init_dt(of_find_compatible_node(NULL, NULL, "fsl,imx53-gpt"));
 }
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 8556c78..59a001a 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -110,7 +110,7 @@ enum mx6q_clks {
 	lvds1_sel, lvds2_sel, lvds1_gate, lvds2_gate, esai_ahb, clk_max
 };
 
-static struct clk *clk[clk_max];
+static struct clk_core *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum mx6q_clks const clks_init_on[] __initconst = {
@@ -448,50 +448,50 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 
 	if ((imx_get_soc_revision() != IMX_CHIP_REVISION_1_0) ||
 	    cpu_is_imx6dl()) {
-		clk_set_parent(clk[ldb_di0_sel], clk[pll5_video_div]);
-		clk_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
+		clk_provider_set_parent(clk[ldb_di0_sel], clk[pll5_video_div]);
+		clk_provider_set_parent(clk[ldb_di1_sel], clk[pll5_video_div]);
 	}
 
-	clk_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
-	clk_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
-	clk_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
-	clk_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
-	clk_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
-	clk_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
-	clk_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
-	clk_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
+	clk_provider_set_parent(clk[ipu1_di0_pre_sel], clk[pll5_video_div]);
+	clk_provider_set_parent(clk[ipu1_di1_pre_sel], clk[pll5_video_div]);
+	clk_provider_set_parent(clk[ipu2_di0_pre_sel], clk[pll5_video_div]);
+	clk_provider_set_parent(clk[ipu2_di1_pre_sel], clk[pll5_video_div]);
+	clk_provider_set_parent(clk[ipu1_di0_sel], clk[ipu1_di0_pre]);
+	clk_provider_set_parent(clk[ipu1_di1_sel], clk[ipu1_di1_pre]);
+	clk_provider_set_parent(clk[ipu2_di0_sel], clk[ipu2_di0_pre]);
+	clk_provider_set_parent(clk[ipu2_di1_sel], clk[ipu2_di1_pre]);
 
 	/*
 	 * The gpmi needs 100MHz frequency in the EDO/Sync mode,
 	 * We can not get the 100MHz from the pll2_pfd0_352m.
 	 * So choose pll2_pfd2_396m as enfc_sel's parent.
 	 */
-	clk_set_parent(clk[enfc_sel], clk[pll2_pfd2_396m]);
+	clk_provider_set_parent(clk[enfc_sel], clk[pll2_pfd2_396m]);
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clk[clks_init_on[i]]);
+		clk_provider_prepare_enable(clk[clks_init_on[i]]);
 
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clk[usbphy1_gate]);
-		clk_prepare_enable(clk[usbphy2_gate]);
+		clk_provider_prepare_enable(clk[usbphy1_gate]);
+		clk_provider_prepare_enable(clk[usbphy2_gate]);
 	}
 
 	/*
 	 * Let's initially set up CLKO with OSC24M, since this configuration
 	 * is widely used by imx6q board designs to clock audio codec.
 	 */
-	ret = clk_set_parent(clk[cko2_sel], clk[osc]);
+	ret = clk_provider_set_parent(clk[cko2_sel], clk[osc]);
 	if (!ret)
-		ret = clk_set_parent(clk[cko], clk[cko2]);
+		ret = clk_provider_set_parent(clk[cko], clk[cko2]);
 	if (ret)
 		pr_warn("failed to set up CLKO: %d\n", ret);
 
 	/* Audio-related clocks configuration */
-	clk_set_parent(clk[spdif_sel], clk[pll3_pfd3_454m]);
+	clk_provider_set_parent(clk[spdif_sel], clk[pll3_pfd3_454m]);
 
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
-		clk_set_parent(clk[lvds1_sel], clk[sata_ref_100m]);
+		clk_provider_set_parent(clk[lvds1_sel], clk[sata_ref_100m]);
 
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index 5408ca7..29e5d3c 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -79,7 +79,7 @@ static struct clk_div_table video_div_table[] = {
 	{ }
 };
 
-static struct clk *clks[IMX6SL_CLK_END];
+static struct clk_core *clks[IMX6SL_CLK_END];
 static struct clk_onecell_data clk_data;
 static void __iomem *ccm_base;
 static void __iomem *anatop_base;
@@ -361,7 +361,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clks[IMX6SL_CLK_GPT_SERIAL], "per", "imx-gpt.0");
 
 	/* Ensure the AHB clk is at 132MHz. */
-	ret = clk_set_rate(clks[IMX6SL_CLK_AHB], 132000000);
+	ret = clk_provider_set_rate(clks[IMX6SL_CLK_AHB], 132000000);
 	if (ret)
 		pr_warn("%s: failed to set AHB clock rate %d!\n",
 			__func__, ret);
@@ -371,15 +371,16 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	 * usecount and enabling/disabling of parent PLLs.
 	 */
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
+		clk_provider_prepare_enable(clks[clks_init_on[i]]);
 
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
+		clk_provider_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
+		clk_provider_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
 	}
 
 	/* Audio-related clocks configuration */
-	clk_set_parent(clks[IMX6SL_CLK_SPDIF0_SEL], clks[IMX6SL_CLK_PLL3_PFD3]);
+	clk_provider_set_parent(clks[IMX6SL_CLK_SPDIF0_SEL],
+				clks[IMX6SL_CLK_PLL3_PFD3]);
 
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 72f8902..81ee7f6 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -82,7 +82,7 @@ static const char *lvds_sels[]	= {
 	"dummy", "dummy", "pcie_ref_125m", "dummy", "usbphy1", "usbphy2",
 };
 
-static struct clk *clks[IMX6SX_CLK_CLK_END];
+static struct clk_core *clks[IMX6SX_CLK_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static int const clks_init_on[] __initconst = {
@@ -133,12 +133,14 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	clks[IMX6SX_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 
-	clks[IMX6SX_CLK_CKIL] = of_clk_get_by_name(ccm_node, "ckil");
-	clks[IMX6SX_CLK_OSC] = of_clk_get_by_name(ccm_node, "osc");
+	clks[IMX6SX_CLK_CKIL] = of_clk_provider_get_by_name(ccm_node, "ckil");
+	clks[IMX6SX_CLK_OSC] = of_clk_provider_get_by_name(ccm_node, "osc");
 
 	/* ipp_di clock is external input */
-	clks[IMX6SX_CLK_IPP_DI0] = of_clk_get_by_name(ccm_node, "ipp_di0");
-	clks[IMX6SX_CLK_IPP_DI1] = of_clk_get_by_name(ccm_node, "ipp_di1");
+	clks[IMX6SX_CLK_IPP_DI0] = of_clk_provider_get_by_name(ccm_node,
+							       "ipp_di0");
+	clks[IMX6SX_CLK_IPP_DI1] = of_clk_provider_get_by_name(ccm_node,
+							       "ipp_di1");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
@@ -455,65 +457,80 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_register_clkdev(clks[IMX6SX_CLK_GPT_SERIAL], "per", "imx-gpt.0");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
+		clk_provider_prepare_enable(clks[clks_init_on[i]]);
 
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clks[IMX6SX_CLK_USBPHY2_GATE]);
+		clk_provider_prepare_enable(clks[IMX6SX_CLK_USBPHY1_GATE]);
+		clk_provider_prepare_enable(clks[IMX6SX_CLK_USBPHY2_GATE]);
 	}
 
 	/* Set the default 132MHz for EIM module */
-	clk_set_parent(clks[IMX6SX_CLK_EIM_SLOW_SEL], clks[IMX6SX_CLK_PLL2_PFD2]);
-	clk_set_rate(clks[IMX6SX_CLK_EIM_SLOW], 132000000);
+	clk_provider_set_parent(clks[IMX6SX_CLK_EIM_SLOW_SEL],
+				clks[IMX6SX_CLK_PLL2_PFD2]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_EIM_SLOW], 132000000);
 
 	/* set parent clock for LCDIF1 pixel clock */
-	clk_set_parent(clks[IMX6SX_CLK_LCDIF1_PRE_SEL], clks[IMX6SX_CLK_PLL5_VIDEO_DIV]);
-	clk_set_parent(clks[IMX6SX_CLK_LCDIF1_SEL], clks[IMX6SX_CLK_LCDIF1_PODF]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_LCDIF1_PRE_SEL],
+				clks[IMX6SX_CLK_PLL5_VIDEO_DIV]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_LCDIF1_SEL],
+				clks[IMX6SX_CLK_LCDIF1_PODF]);
 
 	/* Set the parent clks of PCIe lvds1 and pcie_axi to be pcie ref, axi */
-	if (clk_set_parent(clks[IMX6SX_CLK_LVDS1_SEL], clks[IMX6SX_CLK_PCIE_REF_125M]))
+	if (clk_provider_set_parent(clks[IMX6SX_CLK_LVDS1_SEL], clks[IMX6SX_CLK_PCIE_REF_125M]))
 		pr_err("Failed to set pcie bus parent clk.\n");
-	if (clk_set_parent(clks[IMX6SX_CLK_PCIE_AXI_SEL], clks[IMX6SX_CLK_AXI]))
+	if (clk_provider_set_parent(clks[IMX6SX_CLK_PCIE_AXI_SEL], clks[IMX6SX_CLK_AXI]))
 		pr_err("Failed to set pcie parent clk.\n");
 
 	/*
 	 * Init enet system AHB clock, set to 200Mhz
 	 * pll2_pfd2_396m-> ENET_PODF-> ENET_AHB
 	 */
-	clk_set_parent(clks[IMX6SX_CLK_ENET_PRE_SEL], clks[IMX6SX_CLK_PLL2_PFD2]);
-	clk_set_parent(clks[IMX6SX_CLK_ENET_SEL], clks[IMX6SX_CLK_ENET_PODF]);
-	clk_set_rate(clks[IMX6SX_CLK_ENET_PODF], 200000000);
-	clk_set_rate(clks[IMX6SX_CLK_ENET_REF], 125000000);
-	clk_set_rate(clks[IMX6SX_CLK_ENET2_REF], 125000000);
+	clk_provider_set_parent(clks[IMX6SX_CLK_ENET_PRE_SEL],
+				clks[IMX6SX_CLK_PLL2_PFD2]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_ENET_SEL],
+				clks[IMX6SX_CLK_ENET_PODF]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_ENET_PODF], 200000000);
+	clk_provider_set_rate(clks[IMX6SX_CLK_ENET_REF], 125000000);
+	clk_provider_set_rate(clks[IMX6SX_CLK_ENET2_REF], 125000000);
 
 	/* Audio clocks */
-	clk_set_rate(clks[IMX6SX_CLK_PLL4_AUDIO_DIV], 393216000);
-
-	clk_set_parent(clks[IMX6SX_CLK_SPDIF_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
-	clk_set_rate(clks[IMX6SX_CLK_SPDIF_PODF], 98304000);
-
-	clk_set_parent(clks[IMX6SX_CLK_AUDIO_SEL], clks[IMX6SX_CLK_PLL3_USB_OTG]);
-	clk_set_rate(clks[IMX6SX_CLK_AUDIO_PODF], 24000000);
-
-	clk_set_parent(clks[IMX6SX_CLK_SSI1_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
-	clk_set_parent(clks[IMX6SX_CLK_SSI2_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
-	clk_set_parent(clks[IMX6SX_CLK_SSI3_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
-	clk_set_rate(clks[IMX6SX_CLK_SSI1_PODF], 24576000);
-	clk_set_rate(clks[IMX6SX_CLK_SSI2_PODF], 24576000);
-	clk_set_rate(clks[IMX6SX_CLK_SSI3_PODF], 24576000);
-
-	clk_set_parent(clks[IMX6SX_CLK_ESAI_SEL], clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
-	clk_set_rate(clks[IMX6SX_CLK_ESAI_PODF], 24576000);
+	clk_provider_set_rate(clks[IMX6SX_CLK_PLL4_AUDIO_DIV], 393216000);
+
+	clk_provider_set_parent(clks[IMX6SX_CLK_SPDIF_SEL],
+				clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_SPDIF_PODF], 98304000);
+
+	clk_provider_set_parent(clks[IMX6SX_CLK_AUDIO_SEL],
+				clks[IMX6SX_CLK_PLL3_USB_OTG]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_AUDIO_PODF], 24000000);
+
+	clk_provider_set_parent(clks[IMX6SX_CLK_SSI1_SEL],
+				clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_SSI2_SEL],
+				clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_SSI3_SEL],
+				clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_SSI1_PODF], 24576000);
+	clk_provider_set_rate(clks[IMX6SX_CLK_SSI2_PODF], 24576000);
+	clk_provider_set_rate(clks[IMX6SX_CLK_SSI3_PODF], 24576000);
+
+	clk_provider_set_parent(clks[IMX6SX_CLK_ESAI_SEL],
+				clks[IMX6SX_CLK_PLL4_AUDIO_DIV]);
+	clk_provider_set_rate(clks[IMX6SX_CLK_ESAI_PODF], 24576000);
 
 	/* Set parent clock for vadc */
-	clk_set_parent(clks[IMX6SX_CLK_VID_SEL], clks[IMX6SX_CLK_PLL3_USB_OTG]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_VID_SEL],
+				clks[IMX6SX_CLK_PLL3_USB_OTG]);
 
 	/* default parent of can_sel clock is invalid, manually set it here */
-	clk_set_parent(clks[IMX6SX_CLK_CAN_SEL], clks[IMX6SX_CLK_PLL3_60M]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_CAN_SEL],
+				clks[IMX6SX_CLK_PLL3_60M]);
 
 	/* Update gpu clock from default 528M to 720M */
-	clk_set_parent(clks[IMX6SX_CLK_GPU_CORE_SEL], clks[IMX6SX_CLK_PLL3_PFD0]);
-	clk_set_parent(clks[IMX6SX_CLK_GPU_AXI_SEL], clks[IMX6SX_CLK_PLL3_PFD0]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_GPU_CORE_SEL],
+				clks[IMX6SX_CLK_PLL3_PFD0]);
+	clk_provider_set_parent(clks[IMX6SX_CLK_GPU_AXI_SEL],
+				clks[IMX6SX_CLK_PLL3_PFD0]);
 
 	/* Set initial power mode */
 	imx6q_set_lpm(WAIT_CLOCKED);
diff --git a/arch/arm/mach-imx/clk-pfd.c b/arch/arm/mach-imx/clk-pfd.c
index 0b0f6f6..8f7590a 100644
--- a/arch/arm/mach-imx/clk-pfd.c
+++ b/arch/arm/mach-imx/clk-pfd.c
@@ -128,11 +128,11 @@ static const struct clk_ops clk_pfd_ops = {
 	.is_enabled     = clk_pfd_is_enabled,
 };
 
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_core *imx_clk_pfd(const char *name, const char *parent_name,
 			void __iomem *reg, u8 idx)
 {
 	struct clk_pfd *pfd;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index d21d14c..fbe33f3 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -97,11 +97,11 @@ static struct clk_ops clk_pllv1_ops = {
 	.recalc_rate = clk_pllv1_recalc_rate,
 };
 
-struct clk *imx_clk_pllv1(const char *name, const char *parent,
+struct clk_core *imx_clk_pllv1(const char *name, const char *parent,
 		void __iomem *base)
 {
 	struct clk_pllv1 *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
index 20889d5..7882848 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -237,11 +237,11 @@ static struct clk_ops clk_pllv2_ops = {
 	.set_rate = clk_pllv2_set_rate,
 };
 
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_core *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base)
 {
 	struct clk_pllv2 *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 6136405..3edcfdc 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -320,13 +320,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
 	.recalc_rate	= clk_pllv3_enet_recalc_rate,
 };
 
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+struct clk_core *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 			  const char *parent_name, void __iomem *base,
 			  u32 div_mask)
 {
 	struct clk_pllv3 *pll;
 	const struct clk_ops *ops;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index 22dc3ee..b383e96 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -95,7 +95,7 @@ static struct clk_div_table pll4_main_div_table[] = {
 	{ }
 };
 
-static struct clk *clk[VF610_CLK_END];
+static struct clk_core *clk[VF610_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static void __init vf610_clocks_init(struct device_node *ccm_node)
@@ -303,20 +303,32 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DMAMUX2] = imx_clk_gate2("dmamux2", "platform_bus", CCM_CCGR6, CCM_CCGRx_CGn(1));
 	clk[VF610_CLK_DMAMUX3] = imx_clk_gate2("dmamux3", "platform_bus", CCM_CCGR6, CCM_CCGRx_CGn(2));
 
-	clk_set_parent(clk[VF610_CLK_QSPI0_SEL], clk[VF610_CLK_PLL1_PFD4]);
-	clk_set_rate(clk[VF610_CLK_QSPI0_X4_DIV], clk_get_rate(clk[VF610_CLK_QSPI0_SEL]) / 2);
-	clk_set_rate(clk[VF610_CLK_QSPI0_X2_DIV], clk_get_rate(clk[VF610_CLK_QSPI0_X4_DIV]) / 2);
-	clk_set_rate(clk[VF610_CLK_QSPI0_X1_DIV], clk_get_rate(clk[VF610_CLK_QSPI0_X2_DIV]) / 2);
-
-	clk_set_parent(clk[VF610_CLK_QSPI1_SEL], clk[VF610_CLK_PLL1_PFD4]);
-	clk_set_rate(clk[VF610_CLK_QSPI1_X4_DIV], clk_get_rate(clk[VF610_CLK_QSPI1_SEL]) / 2);
-	clk_set_rate(clk[VF610_CLK_QSPI1_X2_DIV], clk_get_rate(clk[VF610_CLK_QSPI1_X4_DIV]) / 2);
-	clk_set_rate(clk[VF610_CLK_QSPI1_X1_DIV], clk_get_rate(clk[VF610_CLK_QSPI1_X2_DIV]) / 2);
-
-	clk_set_parent(clk[VF610_CLK_SAI0_SEL], clk[VF610_CLK_AUDIO_EXT]);
-	clk_set_parent(clk[VF610_CLK_SAI1_SEL], clk[VF610_CLK_AUDIO_EXT]);
-	clk_set_parent(clk[VF610_CLK_SAI2_SEL], clk[VF610_CLK_AUDIO_EXT]);
-	clk_set_parent(clk[VF610_CLK_SAI3_SEL], clk[VF610_CLK_AUDIO_EXT]);
+	clk_provider_set_parent(clk[VF610_CLK_QSPI0_SEL],
+				clk[VF610_CLK_PLL1_PFD4]);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI0_X4_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI0_SEL]) / 2);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI0_X2_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI0_X4_DIV]) / 2);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI0_X1_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI0_X2_DIV]) / 2);
+
+	clk_provider_set_parent(clk[VF610_CLK_QSPI1_SEL],
+				clk[VF610_CLK_PLL1_PFD4]);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI1_X4_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI1_SEL]) / 2);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI1_X2_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI1_X4_DIV]) / 2);
+	clk_provider_set_rate(clk[VF610_CLK_QSPI1_X1_DIV],
+			      clk_provider_get_rate(clk[VF610_CLK_QSPI1_X2_DIV]) / 2);
+
+	clk_provider_set_parent(clk[VF610_CLK_SAI0_SEL],
+				clk[VF610_CLK_AUDIO_EXT]);
+	clk_provider_set_parent(clk[VF610_CLK_SAI1_SEL],
+				clk[VF610_CLK_AUDIO_EXT]);
+	clk_provider_set_parent(clk[VF610_CLK_SAI2_SEL],
+				clk[VF610_CLK_AUDIO_EXT]);
+	clk_provider_set_parent(clk[VF610_CLK_SAI3_SEL],
+				clk[VF610_CLK_AUDIO_EXT]);
 
 	/* Add the clocks to provider list */
 	clk_data.clks = clk;
diff --git a/arch/arm/mach-imx/clk.c b/arch/arm/mach-imx/clk.c
index edc35df..d776fe1 100644
--- a/arch/arm/mach-imx/clk.c
+++ b/arch/arm/mach-imx/clk.c
@@ -7,10 +7,10 @@
 
 DEFINE_SPINLOCK(imx_ccm_lock);
 
-static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
+static struct clk_core * __init imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
-	struct clk *clk = ERR_PTR(-ENODEV);
+	struct clk_core *clk = ERR_PTR(-ENODEV);
 	char *path;
 
 	path = kasprintf(GFP_KERNEL, "/clocks/%s", name);
@@ -27,10 +27,10 @@ static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 	return clk;
 }
 
-struct clk * __init imx_obtain_fixed_clock(
+struct clk_core * __init imx_obtain_fixed_clock(
 			const char *name, unsigned long rate)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = imx_obtain_fixed_clock_from_dt(name);
 	if (IS_ERR(clk))
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index e29f6eb..421af46 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -8,10 +8,10 @@ extern spinlock_t imx_ccm_lock;
 
 extern void imx_cscmr1_fixup(u32 *val);
 
-struct clk *imx_clk_pllv1(const char *name, const char *parent,
+struct clk_core *imx_clk_pllv1(const char *name, const char *parent,
 		void __iomem *base);
 
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_core *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
 enum imx_pllv3_type {
@@ -22,26 +22,26 @@ enum imx_pllv3_type {
 	IMX_PLLV3_ENET,
 };
 
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+struct clk_core *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
 
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk_core *clk_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock,
 		unsigned int *share_count);
 
-struct clk * imx_obtain_fixed_clock(
+struct clk_core * imx_obtain_fixed_clock(
 			const char *name, unsigned long rate);
 
-static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
+static inline struct clk_core *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0, &imx_ccm_lock, NULL);
 }
 
-static inline struct clk *imx_clk_gate2_shared(const char *name,
+static inline struct clk_core *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
@@ -49,38 +49,38 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 			shift, 0, &imx_ccm_lock, share_count);
 }
 
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_core *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
-struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
+struct clk_core *imx_clk_busy_divider(const char *name, const char *parent_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
 
-struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
+struct clk_core *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
 
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_core *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
 
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_core *imx_clk_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char **parents,
 			      int num_parents, void (*fixup)(u32 *val));
 
-static inline struct clk *imx_clk_fixed(const char *name, int rate)
+static inline struct clk_core *imx_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
 }
 
-static inline struct clk *imx_clk_divider(const char *name, const char *parent,
+static inline struct clk_core *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
 	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_divider_flags(const char *name,
+static inline struct clk_core *imx_clk_divider_flags(const char *name,
 		const char *parent, void __iomem *reg, u8 shift, u8 width,
 		unsigned long flags)
 {
@@ -88,14 +88,14 @@ static inline struct clk *imx_clk_divider_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_gate(const char *name, const char *parent,
+static inline struct clk_core *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
+static inline struct clk_core *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
 	return clk_register_mux(NULL, name, parents, num_parents,
@@ -103,7 +103,7 @@ static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_mux_flags(const char *name,
+static inline struct clk_core *imx_clk_mux_flags(const char *name,
 		void __iomem *reg, u8 shift, u8 width, const char **parents,
 		int num_parents, unsigned long flags)
 {
@@ -112,7 +112,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_fixed_factor(const char *name,
+static inline struct clk_core *imx_clk_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
 	return clk_register_fixed_factor(NULL, name, parent,
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 255f33a..b87a92e 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -159,7 +159,7 @@ static void clk_gate_fn_disable(struct clk_hw *hw)
 
 static struct clk_ops clk_gate_fn_ops;
 
-static struct clk __init *clk_register_gate_fn(struct device *dev,
+static struct clk_core __init *clk_register_gate_fn(struct device *dev,
 		const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
@@ -167,7 +167,7 @@ static struct clk __init *clk_register_gate_fn(struct device *dev,
 		void (*fn_en)(void), void (*fn_dis)(void))
 {
 	struct clk_gate_fn *gate_fn;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	gate_fn = kzalloc(sizeof(struct clk_gate_fn), GFP_KERNEL);
@@ -208,15 +208,15 @@ static struct clk __init *clk_register_gate_fn(struct device *dev,
 }
 
 static DEFINE_SPINLOCK(gating_lock);
-static struct clk *tclk;
+static struct clk_core *tclk;
 
-static struct clk __init *kirkwood_register_gate(const char *name, u8 bit_idx)
+static struct clk_core __init *kirkwood_register_gate(const char *name, u8 bit_idx)
 {
 	return clk_register_gate(NULL, name, "tclk", 0, CLOCK_GATING_CTRL,
 				 bit_idx, 0, &gating_lock);
 }
 
-static struct clk __init *kirkwood_register_gate_fn(const char *name,
+static struct clk_core __init *kirkwood_register_gate_fn(const char *name,
 						    u8 bit_idx,
 						    void (*fn_en)(void),
 						    void (*fn_dis)(void))
@@ -225,12 +225,12 @@ static struct clk __init *kirkwood_register_gate_fn(const char *name,
 				    bit_idx, 0, &gating_lock, fn_en, fn_dis);
 }
 
-static struct clk *ge0, *ge1;
+static struct clk_core *ge0, *ge1;
 
 void __init kirkwood_clk_init(void)
 {
-	struct clk *runit, *sata0, *sata1, *usb0, *sdio;
-	struct clk *crypto, *xor0, *xor1, *pex0, *pex1, *audio;
+	struct clk_core *runit, *sata0, *sata1, *usb0, *sdio;
+	struct clk_core *crypto, *xor0, *xor1, *pex0, *pex1, *audio;
 
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL,
 				       CLK_IS_ROOT, kirkwood_tclk);
@@ -278,7 +278,7 @@ void __init kirkwood_clk_init(void)
 	/* Marvell says runit is used by SPI, UART, NAND, TWSI, ...,
 	 * so should never be gated.
 	 */
-	clk_prepare_enable(runit);
+	clk_provider_prepare_enable(runit);
 }
 
 /*****************************************************************************
@@ -300,7 +300,7 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 			IRQ_KIRKWOOD_GE00_ERR, 1600);
 	/* The interface forgets the MAC address assigned by u-boot if
 	the clock is turned off, so claim the clk now. */
-	clk_prepare_enable(ge0);
+	clk_provider_prepare_enable(ge0);
 }
 
 
@@ -312,7 +312,7 @@ void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
 	orion_ge01_init(eth_data,
 			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
 			IRQ_KIRKWOOD_GE01_ERR, 1600);
-	clk_prepare_enable(ge1);
+	clk_provider_prepare_enable(ge1);
 }
 
 
diff --git a/arch/arm/mach-msm/clock-pcom.c b/arch/arm/mach-msm/clock-pcom.c
index 9a80449..14352c4 100644
--- a/arch/arm/mach-msm/clock-pcom.c
+++ b/arch/arm/mach-msm/clock-pcom.c
@@ -132,7 +132,7 @@ static int msm_clock_pcom_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pdata->num_lookups; i++) {
 		const struct clk_pcom_desc *desc = &pdata->lookup[i];
-		struct clk *c;
+		struct clk_core *c;
 		struct clk_pcom *p;
 		struct clk_hw *hw;
 		struct clk_init_data init;
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index e6ac679..fee2643 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -164,7 +164,7 @@ void __init mv78xx0_map_io(void)
 /*****************************************************************************
  * CLK tree
  ****************************************************************************/
-static struct clk *tclk;
+static struct clk_core *tclk;
 
 static void __init clk_init(void)
 {
diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 3662f4d..59d6323 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -57,7 +57,7 @@ DEFINE_CLK_FIXED_RATE(func_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
 DEFINE_CLK_FIXED_RATE(mcbsp_clks, CLK_IS_ROOT, 0x0, 0x0);
 
-static struct clk osc_ck;
+static struct clk_core osc_ck;
 
 static const struct clk_ops osc_ck_ops = {
 	.recalc_rate	= &omap2_osc_clk_recalc,
@@ -69,7 +69,7 @@ static struct clk_hw_omap osc_ck_hw = {
 	},
 };
 
-static struct clk osc_ck = {
+static struct clk_core osc_ck = {
 	.name	= "osc_ck",
 	.ops	= &osc_ck_ops,
 	.hw	= &osc_ck_hw.hw,
@@ -78,7 +78,7 @@ static struct clk osc_ck = {
 
 DEFINE_CLK_FIXED_RATE(secure_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
-static struct clk sys_ck;
+static struct clk_core sys_ck;
 
 static const char *sys_ck_parent_names[] = {
 	"osc_ck",
@@ -105,7 +105,7 @@ static struct dpll_data dpll_dd = {
 	.max_divider	= 16,
 };
 
-static struct clk dpll_ck;
+static struct clk_core dpll_ck;
 
 static const char *dpll_ck_parent_names[] = {
 	"sys_ck",
@@ -130,7 +130,7 @@ static struct clk_hw_omap dpll_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll_ck, dpll_ck_parent_names, dpll_ck_ops);
 
-static struct clk core_ck;
+static struct clk_core core_ck;
 
 static const char *core_ck_parent_names[] = {
 	"dpll_ck",
@@ -153,7 +153,7 @@ DEFINE_CLK_DIVIDER(l4_ck, "core_l3_ck", &core_l3_ck, 0x0,
 		   OMAP24XX_CLKSEL_L4_SHIFT, OMAP24XX_CLKSEL_L4_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk aes_ick;
+static struct clk_core aes_ick;
 
 static const char *aes_ick_parent_names[] = {
 	"l4_ck",
@@ -178,7 +178,7 @@ static struct clk_hw_omap aes_ick_hw = {
 
 DEFINE_STRUCT_CLK(aes_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk apll54_ck;
+static struct clk_core apll54_ck;
 
 static const struct clk_ops apll54_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -200,7 +200,7 @@ static struct clk_hw_omap apll54_ck_hw = {
 
 DEFINE_STRUCT_CLK(apll54_ck, dpll_ck_parent_names, apll54_ck_ops);
 
-static struct clk apll96_ck;
+static struct clk_core apll96_ck;
 
 static const struct clk_ops apll96_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -222,7 +222,7 @@ static struct clk_hw_omap apll96_ck_hw = {
 
 DEFINE_STRUCT_CLK(apll96_ck, dpll_ck_parent_names, apll96_ck_ops);
 
-static struct clk func_96m_ck;
+static struct clk_core func_96m_ck;
 
 static const char *func_96m_ck_parent_names[] = {
 	"apll96_ck",
@@ -231,7 +231,7 @@ static const char *func_96m_ck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(func_96m_ck, "wkup_clkdm");
 DEFINE_STRUCT_CLK(func_96m_ck, func_96m_ck_parent_names, core_ck_ops);
 
-static struct clk cam_fck;
+static struct clk_core cam_fck;
 
 static const char *cam_fck_parent_names[] = {
 	"func_96m_ck",
@@ -248,7 +248,7 @@ static struct clk_hw_omap cam_fck_hw = {
 
 DEFINE_STRUCT_CLK(cam_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk cam_ick;
+static struct clk_core cam_ick;
 
 static struct clk_hw_omap cam_ick_hw = {
 	.hw = {
@@ -262,7 +262,7 @@ static struct clk_hw_omap cam_ick_hw = {
 
 DEFINE_STRUCT_CLK(cam_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk des_ick;
+static struct clk_core des_ick;
 
 static struct clk_hw_omap des_ick_hw = {
 	.hw = {
@@ -358,7 +358,7 @@ static const char *dss1_fck_parent_names[] = {
 	"sys_ck", "core_ck",
 };
 
-static struct clk dss1_fck;
+static struct clk_core dss1_fck;
 
 static const struct clk_ops dss1_fck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -407,7 +407,7 @@ static const char *func_48m_ck_parent_names[] = {
 	"apll96_ck", "alt_ck",
 };
 
-static struct clk func_48m_ck;
+static struct clk_core func_48m_ck;
 
 static const struct clk_ops func_48m_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -456,7 +456,7 @@ DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0,
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH,
 	       0x0, NULL);
 
-static struct clk dss_54m_fck;
+static struct clk_core dss_54m_fck;
 
 static const char *dss_54m_fck_parent_names[] = {
 	"func_54m_ck",
@@ -474,7 +474,7 @@ static struct clk_hw_omap dss_54m_fck_hw = {
 
 DEFINE_STRUCT_CLK(dss_54m_fck, dss_54m_fck_parent_names, aes_ick_ops);
 
-static struct clk dss_ick;
+static struct clk_core dss_ick;
 
 static struct clk_hw_omap dss_ick_hw = {
 	.hw = {
@@ -488,7 +488,7 @@ static struct clk_hw_omap dss_ick_hw = {
 
 DEFINE_STRUCT_CLK(dss_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk eac_fck;
+static struct clk_core eac_fck;
 
 static struct clk_hw_omap eac_fck_hw = {
 	.hw = {
@@ -502,7 +502,7 @@ static struct clk_hw_omap eac_fck_hw = {
 
 DEFINE_STRUCT_CLK(eac_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk eac_ick;
+static struct clk_core eac_ick;
 
 static struct clk_hw_omap eac_ick_hw = {
 	.hw = {
@@ -516,7 +516,7 @@ static struct clk_hw_omap eac_ick_hw = {
 
 DEFINE_STRUCT_CLK(eac_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk emul_ck;
+static struct clk_core emul_ck;
 
 static struct clk_hw_omap emul_ck_hw = {
 	.hw = {
@@ -531,7 +531,7 @@ DEFINE_STRUCT_CLK(emul_ck, dss_54m_fck_parent_names, aes_ick_ops);
 
 DEFINE_CLK_FIXED_FACTOR(func_12m_ck, "func_48m_ck", &func_48m_ck, 0x0, 1, 4);
 
-static struct clk fac_fck;
+static struct clk_core fac_fck;
 
 static const char *fac_fck_parent_names[] = {
 	"func_12m_ck",
@@ -549,7 +549,7 @@ static struct clk_hw_omap fac_fck_hw = {
 
 DEFINE_STRUCT_CLK(fac_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk fac_ick;
+static struct clk_core fac_ick;
 
 static struct clk_hw_omap fac_ick_hw = {
 	.hw = {
@@ -586,7 +586,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gfx_3d_fck, "gfx_clkdm", gfx_fck_clksel,
 			 OMAP24XX_EN_3D_SHIFT, &clkhwops_wait,
 			 gfx_2d_fck_parent_names, dsp_fck_ops);
 
-static struct clk gfx_ick;
+static struct clk_core gfx_ick;
 
 static const char *gfx_ick_parent_names[] = {
 	"core_l3_ck",
@@ -604,7 +604,7 @@ static struct clk_hw_omap gfx_ick_hw = {
 
 DEFINE_STRUCT_CLK(gfx_ick, gfx_ick_parent_names, aes_ick_ops);
 
-static struct clk gpios_fck;
+static struct clk_core gpios_fck;
 
 static const char *gpios_fck_parent_names[] = {
 	"func_32k_ck",
@@ -622,7 +622,7 @@ static struct clk_hw_omap gpios_fck_hw = {
 
 DEFINE_STRUCT_CLK(gpios_fck, gpios_fck_parent_names, aes_ick_ops);
 
-static struct clk gpios_ick;
+static struct clk_core gpios_ick;
 
 static const char *gpios_ick_parent_names[] = {
 	"sys_ck",
@@ -640,7 +640,7 @@ static struct clk_hw_omap gpios_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpios_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk gpmc_fck;
+static struct clk_core gpmc_fck;
 
 static struct clk_hw_omap gpmc_fck_hw = {
 	.hw = {
@@ -678,7 +678,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT10_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt10_ick;
+static struct clk_core gpt10_ick;
 
 static struct clk_hw_omap gpt10_ick_hw = {
 	.hw = {
@@ -699,7 +699,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt11_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT11_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt11_ick;
+static struct clk_core gpt11_ick;
 
 static struct clk_hw_omap gpt11_ick_hw = {
 	.hw = {
@@ -720,7 +720,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt12_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT12_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt12_ick;
+static struct clk_core gpt12_ick;
 
 static struct clk_hw_omap gpt12_ick_hw = {
 	.hw = {
@@ -753,7 +753,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt1_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT1_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, gpt1_fck_ops);
 
-static struct clk gpt1_ick;
+static struct clk_core gpt1_ick;
 
 static struct clk_hw_omap gpt1_ick_hw = {
 	.hw = {
@@ -774,7 +774,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt2_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT2_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt2_ick;
+static struct clk_core gpt2_ick;
 
 static struct clk_hw_omap gpt2_ick_hw = {
 	.hw = {
@@ -795,7 +795,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt3_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT3_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt3_ick;
+static struct clk_core gpt3_ick;
 
 static struct clk_hw_omap gpt3_ick_hw = {
 	.hw = {
@@ -816,7 +816,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt4_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT4_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt4_ick;
+static struct clk_core gpt4_ick;
 
 static struct clk_hw_omap gpt4_ick_hw = {
 	.hw = {
@@ -837,7 +837,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt5_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT5_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt5_ick;
+static struct clk_core gpt5_ick;
 
 static struct clk_hw_omap gpt5_ick_hw = {
 	.hw = {
@@ -858,7 +858,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt6_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT6_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt6_ick;
+static struct clk_core gpt6_ick;
 
 static struct clk_hw_omap gpt6_ick_hw = {
 	.hw = {
@@ -879,7 +879,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt7_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT7_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt7_ick;
+static struct clk_core gpt7_ick;
 
 static struct clk_hw_omap gpt7_ick_hw = {
 	.hw = {
@@ -900,7 +900,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt8_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT8_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt8_ick;
+static struct clk_core gpt8_ick;
 
 static struct clk_hw_omap gpt8_ick_hw = {
 	.hw = {
@@ -921,7 +921,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt9_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT9_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt9_ick;
+static struct clk_core gpt9_ick;
 
 static struct clk_hw_omap gpt9_ick_hw = {
 	.hw = {
@@ -935,7 +935,7 @@ static struct clk_hw_omap gpt9_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpt9_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk hdq_fck;
+static struct clk_core hdq_fck;
 
 static struct clk_hw_omap hdq_fck_hw = {
 	.hw = {
@@ -949,7 +949,7 @@ static struct clk_hw_omap hdq_fck_hw = {
 
 DEFINE_STRUCT_CLK(hdq_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk hdq_ick;
+static struct clk_core hdq_ick;
 
 static struct clk_hw_omap hdq_ick_hw = {
 	.hw = {
@@ -963,7 +963,7 @@ static struct clk_hw_omap hdq_ick_hw = {
 
 DEFINE_STRUCT_CLK(hdq_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk i2c1_fck;
+static struct clk_core i2c1_fck;
 
 static struct clk_hw_omap i2c1_fck_hw = {
 	.hw = {
@@ -977,7 +977,7 @@ static struct clk_hw_omap i2c1_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2c1_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk i2c1_ick;
+static struct clk_core i2c1_ick;
 
 static struct clk_hw_omap i2c1_ick_hw = {
 	.hw = {
@@ -991,7 +991,7 @@ static struct clk_hw_omap i2c1_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk i2c2_fck;
+static struct clk_core i2c2_fck;
 
 static struct clk_hw_omap i2c2_fck_hw = {
 	.hw = {
@@ -1005,7 +1005,7 @@ static struct clk_hw_omap i2c2_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2c2_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk i2c2_ick;
+static struct clk_core i2c2_ick;
 
 static struct clk_hw_omap i2c2_ick_hw = {
 	.hw = {
@@ -1026,7 +1026,7 @@ DEFINE_CLK_OMAP_MUX_GATE(iva1_ifck, "iva1_clkdm", dsp_fck_clksel,
 			 OMAP2420_EN_IVA_COP_SHIFT, &clkhwops_wait,
 			 dsp_fck_parent_names, dsp_fck_ops);
 
-static struct clk iva1_mpu_int_ifck;
+static struct clk_core iva1_mpu_int_ifck;
 
 static const char *iva1_mpu_int_ifck_parent_names[] = {
 	"iva1_ifck",
@@ -1054,7 +1054,7 @@ static struct clk_hw_omap iva1_mpu_int_ifck_hw = {
 DEFINE_STRUCT_CLK(iva1_mpu_int_ifck, iva1_mpu_int_ifck_parent_names,
 		  iva1_mpu_int_ifck_ops);
 
-static struct clk mailboxes_ick;
+static struct clk_core mailboxes_ick;
 
 static struct clk_hw_omap mailboxes_ick_hw = {
 	.hw = {
@@ -1095,7 +1095,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP24XX_EN_MCBSP1_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp1_ick;
+static struct clk_core mcbsp1_ick;
 
 static struct clk_hw_omap mcbsp1_ick_hw = {
 	.hw = {
@@ -1116,7 +1116,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP24XX_EN_MCBSP2_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp2_ick;
+static struct clk_core mcbsp2_ick;
 
 static struct clk_hw_omap mcbsp2_ick_hw = {
 	.hw = {
@@ -1130,7 +1130,7 @@ static struct clk_hw_omap mcbsp2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcbsp2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mcspi1_fck;
+static struct clk_core mcspi1_fck;
 
 static const char *mcspi1_fck_parent_names[] = {
 	"func_48m_ck",
@@ -1148,7 +1148,7 @@ static struct clk_hw_omap mcspi1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk mcspi1_ick;
+static struct clk_core mcspi1_ick;
 
 static struct clk_hw_omap mcspi1_ick_hw = {
 	.hw = {
@@ -1162,7 +1162,7 @@ static struct clk_hw_omap mcspi1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mcspi2_fck;
+static struct clk_core mcspi2_fck;
 
 static struct clk_hw_omap mcspi2_fck_hw = {
 	.hw = {
@@ -1176,7 +1176,7 @@ static struct clk_hw_omap mcspi2_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk mcspi2_ick;
+static struct clk_core mcspi2_ick;
 
 static struct clk_hw_omap mcspi2_ick_hw = {
 	.hw = {
@@ -1190,7 +1190,7 @@ static struct clk_hw_omap mcspi2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mmc_fck;
+static struct clk_core mmc_fck;
 
 static struct clk_hw_omap mmc_fck_hw = {
 	.hw = {
@@ -1204,7 +1204,7 @@ static struct clk_hw_omap mmc_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmc_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk mmc_ick;
+static struct clk_core mmc_ick;
 
 static struct clk_hw_omap mmc_ick_hw = {
 	.hw = {
@@ -1223,7 +1223,7 @@ DEFINE_CLK_DIVIDER(mpu_ck, "core_ck", &core_ck, 0x0,
 		   OMAP24XX_CLKSEL_MPU_SHIFT, OMAP24XX_CLKSEL_MPU_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk mpu_wdt_fck;
+static struct clk_core mpu_wdt_fck;
 
 static struct clk_hw_omap mpu_wdt_fck_hw = {
 	.hw = {
@@ -1237,7 +1237,7 @@ static struct clk_hw_omap mpu_wdt_fck_hw = {
 
 DEFINE_STRUCT_CLK(mpu_wdt_fck, gpios_fck_parent_names, aes_ick_ops);
 
-static struct clk mpu_wdt_ick;
+static struct clk_core mpu_wdt_ick;
 
 static struct clk_hw_omap mpu_wdt_ick_hw = {
 	.hw = {
@@ -1251,7 +1251,7 @@ static struct clk_hw_omap mpu_wdt_ick_hw = {
 
 DEFINE_STRUCT_CLK(mpu_wdt_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk mspro_fck;
+static struct clk_core mspro_fck;
 
 static struct clk_hw_omap mspro_fck_hw = {
 	.hw = {
@@ -1265,7 +1265,7 @@ static struct clk_hw_omap mspro_fck_hw = {
 
 DEFINE_STRUCT_CLK(mspro_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk mspro_ick;
+static struct clk_core mspro_ick;
 
 static struct clk_hw_omap mspro_ick_hw = {
 	.hw = {
@@ -1279,7 +1279,7 @@ static struct clk_hw_omap mspro_ick_hw = {
 
 DEFINE_STRUCT_CLK(mspro_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk omapctrl_ick;
+static struct clk_core omapctrl_ick;
 
 static struct clk_hw_omap omapctrl_ick_hw = {
 	.hw = {
@@ -1294,7 +1294,7 @@ static struct clk_hw_omap omapctrl_ick_hw = {
 
 DEFINE_STRUCT_CLK(omapctrl_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk pka_ick;
+static struct clk_core pka_ick;
 
 static struct clk_hw_omap pka_ick_hw = {
 	.hw = {
@@ -1308,7 +1308,7 @@ static struct clk_hw_omap pka_ick_hw = {
 
 DEFINE_STRUCT_CLK(pka_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk rng_ick;
+static struct clk_core rng_ick;
 
 static struct clk_hw_omap rng_ick_hw = {
 	.hw = {
@@ -1322,12 +1322,12 @@ static struct clk_hw_omap rng_ick_hw = {
 
 DEFINE_STRUCT_CLK(rng_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk sdma_fck;
+static struct clk_core sdma_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(sdma_fck, "core_l3_clkdm");
 DEFINE_STRUCT_CLK(sdma_fck, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sdma_ick;
+static struct clk_core sdma_ick;
 
 static struct clk_hw_omap sdma_ick_hw = {
 	.hw = {
@@ -1341,7 +1341,7 @@ static struct clk_hw_omap sdma_ick_hw = {
 
 DEFINE_STRUCT_CLK(sdma_ick, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sdrc_ick;
+static struct clk_core sdrc_ick;
 
 static struct clk_hw_omap sdrc_ick_hw = {
 	.hw = {
@@ -1356,7 +1356,7 @@ static struct clk_hw_omap sdrc_ick_hw = {
 
 DEFINE_STRUCT_CLK(sdrc_ick, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sha_ick;
+static struct clk_core sha_ick;
 
 static struct clk_hw_omap sha_ick_hw = {
 	.hw = {
@@ -1370,7 +1370,7 @@ static struct clk_hw_omap sha_ick_hw = {
 
 DEFINE_STRUCT_CLK(sha_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk ssi_l4_ick;
+static struct clk_core ssi_l4_ick;
 
 static struct clk_hw_omap ssi_l4_ick_hw = {
 	.hw = {
@@ -1411,7 +1411,7 @@ DEFINE_CLK_OMAP_MUX_GATE(ssi_ssr_sst_fck, "core_l3_clkdm",
 			 OMAP24XX_EN_SSI_SHIFT, &clkhwops_wait,
 			 ssi_ssr_sst_fck_parent_names, dsp_fck_ops);
 
-static struct clk sync_32k_ick;
+static struct clk_core sync_32k_ick;
 
 static struct clk_hw_omap sync_32k_ick_hw = {
 	.hw = {
@@ -1477,7 +1477,7 @@ DEFINE_CLK_DIVIDER(sys_clkout2, "sys_clkout2_src", &sys_clkout2_src, 0x0,
 		   OMAP2420_PRCM_CLKOUT_CTRL, OMAP2420_CLKOUT2_DIV_SHIFT,
 		   OMAP2420_CLKOUT2_DIV_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-static struct clk uart1_fck;
+static struct clk_core uart1_fck;
 
 static struct clk_hw_omap uart1_fck_hw = {
 	.hw = {
@@ -1491,7 +1491,7 @@ static struct clk_hw_omap uart1_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart1_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart1_ick;
+static struct clk_core uart1_ick;
 
 static struct clk_hw_omap uart1_ick_hw = {
 	.hw = {
@@ -1505,7 +1505,7 @@ static struct clk_hw_omap uart1_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk uart2_fck;
+static struct clk_core uart2_fck;
 
 static struct clk_hw_omap uart2_fck_hw = {
 	.hw = {
@@ -1519,7 +1519,7 @@ static struct clk_hw_omap uart2_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart2_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart2_ick;
+static struct clk_core uart2_ick;
 
 static struct clk_hw_omap uart2_ick_hw = {
 	.hw = {
@@ -1533,7 +1533,7 @@ static struct clk_hw_omap uart2_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk uart3_fck;
+static struct clk_core uart3_fck;
 
 static struct clk_hw_omap uart3_fck_hw = {
 	.hw = {
@@ -1547,7 +1547,7 @@ static struct clk_hw_omap uart3_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart3_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart3_ick;
+static struct clk_core uart3_ick;
 
 static struct clk_hw_omap uart3_ick_hw = {
 	.hw = {
@@ -1561,7 +1561,7 @@ static struct clk_hw_omap uart3_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart3_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk usb_fck;
+static struct clk_core usb_fck;
 
 static struct clk_hw_omap usb_fck_hw = {
 	.hw = {
@@ -1598,7 +1598,7 @@ DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_ick_clksel,
 			 OMAP24XX_EN_USB_SHIFT, &clkhwops_iclk_wait,
 			 usb_l4_ick_parent_names, dsp_fck_ops);
 
-static struct clk virt_prcm_set;
+static struct clk_core virt_prcm_set;
 
 static const char *virt_prcm_set_parent_names[] = {
 	"mpu_ck",
@@ -1649,7 +1649,7 @@ DEFINE_CLK_OMAP_MUX_GATE(vlynq_fck, "core_l3_clkdm", vlynq_fck_clksel,
 			 OMAP2420_EN_VLYNQ_SHIFT, &clkhwops_wait,
 			 vlynq_fck_parent_names, dss1_fck_ops);
 
-static struct clk vlynq_ick;
+static struct clk_core vlynq_ick;
 
 static struct clk_hw_omap vlynq_ick_hw = {
 	.hw = {
@@ -1663,7 +1663,7 @@ static struct clk_hw_omap vlynq_ick_hw = {
 
 DEFINE_STRUCT_CLK(vlynq_ick, gfx_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt1_ick;
+static struct clk_core wdt1_ick;
 
 static struct clk_hw_omap wdt1_ick_hw = {
 	.hw = {
@@ -1677,7 +1677,7 @@ static struct clk_hw_omap wdt1_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt3_fck;
+static struct clk_core wdt3_fck;
 
 static struct clk_hw_omap wdt3_fck_hw = {
 	.hw = {
@@ -1691,7 +1691,7 @@ static struct clk_hw_omap wdt3_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt3_fck, gpios_fck_parent_names, aes_ick_ops);
 
-static struct clk wdt3_ick;
+static struct clk_core wdt3_ick;
 
 static struct clk_hw_omap wdt3_ick_hw = {
 	.hw = {
@@ -1705,7 +1705,7 @@ static struct clk_hw_omap wdt3_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt3_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt4_fck;
+static struct clk_core wdt4_fck;
 
 static struct clk_hw_omap wdt4_fck_hw = {
 	.hw = {
@@ -1719,7 +1719,7 @@ static struct clk_hw_omap wdt4_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt4_fck, gpios_fck_parent_names, aes_ick_ops);
 
-static struct clk wdt4_ick;
+static struct clk_core wdt4_ick;
 
 static struct clk_hw_omap wdt4_ick_hw = {
 	.hw = {
@@ -1922,10 +1922,10 @@ int __init omap2420_clk_init(void)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(&sys_ck) / 1000000),
-		(clk_get_rate(&sys_ck) / 100000) % 10,
-		(clk_get_rate(&dpll_ck) / 1000000),
-		(clk_get_rate(&mpu_ck) / 1000000));
+		(clk_provider_get_rate(&sys_ck) / 1000000),
+		(clk_provider_get_rate(&sys_ck) / 100000) % 10,
+		(clk_provider_get_rate(&dpll_ck) / 1000000),
+		(clk_provider_get_rate(&mpu_ck) / 1000000));
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index 5e4b037..19d0361 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -55,7 +55,7 @@ DEFINE_CLK_FIXED_RATE(func_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
 DEFINE_CLK_FIXED_RATE(mcbsp_clks, CLK_IS_ROOT, 0x0, 0x0);
 
-static struct clk osc_ck;
+static struct clk_core osc_ck;
 
 static const struct clk_ops osc_ck_ops = {
 	.enable		= &omap2_enable_osc_ck,
@@ -69,7 +69,7 @@ static struct clk_hw_omap osc_ck_hw = {
 	},
 };
 
-static struct clk osc_ck = {
+static struct clk_core osc_ck = {
 	.name	= "osc_ck",
 	.ops	= &osc_ck_ops,
 	.hw	= &osc_ck_hw.hw,
@@ -78,7 +78,7 @@ static struct clk osc_ck = {
 
 DEFINE_CLK_FIXED_RATE(secure_32k_ck, CLK_IS_ROOT, 32768, 0x0);
 
-static struct clk sys_ck;
+static struct clk_core sys_ck;
 
 static const char *sys_ck_parent_names[] = {
 	"osc_ck",
@@ -105,7 +105,7 @@ static struct dpll_data dpll_dd = {
 	.max_divider	= 16,
 };
 
-static struct clk dpll_ck;
+static struct clk_core dpll_ck;
 
 static const char *dpll_ck_parent_names[] = {
 	"sys_ck",
@@ -130,7 +130,7 @@ static struct clk_hw_omap dpll_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll_ck, dpll_ck_parent_names, dpll_ck_ops);
 
-static struct clk core_ck;
+static struct clk_core core_ck;
 
 static const char *core_ck_parent_names[] = {
 	"dpll_ck",
@@ -153,7 +153,7 @@ DEFINE_CLK_DIVIDER(l4_ck, "core_l3_ck", &core_l3_ck, 0x0,
 		   OMAP24XX_CLKSEL_L4_SHIFT, OMAP24XX_CLKSEL_L4_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk aes_ick;
+static struct clk_core aes_ick;
 
 static const char *aes_ick_parent_names[] = {
 	"l4_ck",
@@ -178,7 +178,7 @@ static struct clk_hw_omap aes_ick_hw = {
 
 DEFINE_STRUCT_CLK(aes_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk apll54_ck;
+static struct clk_core apll54_ck;
 
 static const struct clk_ops apll54_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -200,7 +200,7 @@ static struct clk_hw_omap apll54_ck_hw = {
 
 DEFINE_STRUCT_CLK(apll54_ck, dpll_ck_parent_names, apll54_ck_ops);
 
-static struct clk apll96_ck;
+static struct clk_core apll96_ck;
 
 static const struct clk_ops apll96_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -230,7 +230,7 @@ DEFINE_CLK_MUX(func_96m_ck, func_96m_ck_parent_names, NULL, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1), OMAP2430_96M_SOURCE_SHIFT,
 	       OMAP2430_96M_SOURCE_WIDTH, 0x0, NULL);
 
-static struct clk cam_fck;
+static struct clk_core cam_fck;
 
 static const char *cam_fck_parent_names[] = {
 	"func_96m_ck",
@@ -247,7 +247,7 @@ static struct clk_hw_omap cam_fck_hw = {
 
 DEFINE_STRUCT_CLK(cam_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk cam_ick;
+static struct clk_core cam_ick;
 
 static struct clk_hw_omap cam_ick_hw = {
 	.hw = {
@@ -261,7 +261,7 @@ static struct clk_hw_omap cam_ick_hw = {
 
 DEFINE_STRUCT_CLK(cam_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk des_ick;
+static struct clk_core des_ick;
 
 static struct clk_hw_omap des_ick_hw = {
 	.hw = {
@@ -292,7 +292,7 @@ static const char *dsp_fck_parent_names[] = {
 	"core_ck",
 };
 
-static struct clk dsp_fck;
+static struct clk_core dsp_fck;
 
 static const struct clk_ops dsp_fck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -387,7 +387,7 @@ static const char *func_48m_ck_parent_names[] = {
 	"apll96_ck", "alt_ck",
 };
 
-static struct clk func_48m_ck;
+static struct clk_core func_48m_ck;
 
 static const struct clk_ops func_48m_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -435,7 +435,7 @@ DEFINE_CLK_MUX(func_54m_ck, func_54m_ck_parent_names, NULL, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP24XX_54M_SOURCE_SHIFT, OMAP24XX_54M_SOURCE_WIDTH, 0x0, NULL);
 
-static struct clk dss_54m_fck;
+static struct clk_core dss_54m_fck;
 
 static const char *dss_54m_fck_parent_names[] = {
 	"func_54m_ck",
@@ -453,7 +453,7 @@ static struct clk_hw_omap dss_54m_fck_hw = {
 
 DEFINE_STRUCT_CLK(dss_54m_fck, dss_54m_fck_parent_names, aes_ick_ops);
 
-static struct clk dss_ick;
+static struct clk_core dss_ick;
 
 static struct clk_hw_omap dss_ick_hw = {
 	.hw = {
@@ -467,7 +467,7 @@ static struct clk_hw_omap dss_ick_hw = {
 
 DEFINE_STRUCT_CLK(dss_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk emul_ck;
+static struct clk_core emul_ck;
 
 static struct clk_hw_omap emul_ck_hw = {
 	.hw = {
@@ -482,7 +482,7 @@ DEFINE_STRUCT_CLK(emul_ck, dss_54m_fck_parent_names, aes_ick_ops);
 
 DEFINE_CLK_FIXED_FACTOR(func_12m_ck, "func_48m_ck", &func_48m_ck, 0x0, 1, 4);
 
-static struct clk fac_fck;
+static struct clk_core fac_fck;
 
 static const char *fac_fck_parent_names[] = {
 	"func_12m_ck",
@@ -500,7 +500,7 @@ static struct clk_hw_omap fac_fck_hw = {
 
 DEFINE_STRUCT_CLK(fac_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk fac_ick;
+static struct clk_core fac_ick;
 
 static struct clk_hw_omap fac_ick_hw = {
 	.hw = {
@@ -537,7 +537,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gfx_3d_fck, "gfx_clkdm", gfx_fck_clksel,
 			 OMAP24XX_EN_3D_SHIFT, &clkhwops_wait,
 			 gfx_2d_fck_parent_names, dsp_fck_ops);
 
-static struct clk gfx_ick;
+static struct clk_core gfx_ick;
 
 static const char *gfx_ick_parent_names[] = {
 	"core_l3_ck",
@@ -555,7 +555,7 @@ static struct clk_hw_omap gfx_ick_hw = {
 
 DEFINE_STRUCT_CLK(gfx_ick, gfx_ick_parent_names, aes_ick_ops);
 
-static struct clk gpio5_fck;
+static struct clk_core gpio5_fck;
 
 static const char *gpio5_fck_parent_names[] = {
 	"func_32k_ck",
@@ -573,7 +573,7 @@ static struct clk_hw_omap gpio5_fck_hw = {
 
 DEFINE_STRUCT_CLK(gpio5_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk gpio5_ick;
+static struct clk_core gpio5_ick;
 
 static struct clk_hw_omap gpio5_ick_hw = {
 	.hw = {
@@ -587,7 +587,7 @@ static struct clk_hw_omap gpio5_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio5_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk gpios_fck;
+static struct clk_core gpios_fck;
 
 static struct clk_hw_omap gpios_fck_hw = {
 	.hw = {
@@ -601,7 +601,7 @@ static struct clk_hw_omap gpios_fck_hw = {
 
 DEFINE_STRUCT_CLK(gpios_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk gpios_ick;
+static struct clk_core gpios_ick;
 
 static const char *gpios_ick_parent_names[] = {
 	"sys_ck",
@@ -619,7 +619,7 @@ static struct clk_hw_omap gpios_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpios_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk gpmc_fck;
+static struct clk_core gpmc_fck;
 
 static struct clk_hw_omap gpmc_fck_hw = {
 	.hw = {
@@ -657,7 +657,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT10_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt10_ick;
+static struct clk_core gpt10_ick;
 
 static struct clk_hw_omap gpt10_ick_hw = {
 	.hw = {
@@ -678,7 +678,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt11_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT11_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt11_ick;
+static struct clk_core gpt11_ick;
 
 static struct clk_hw_omap gpt11_ick_hw = {
 	.hw = {
@@ -699,7 +699,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt12_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT12_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt12_ick;
+static struct clk_core gpt12_ick;
 
 static struct clk_hw_omap gpt12_ick_hw = {
 	.hw = {
@@ -732,7 +732,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt1_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT1_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, gpt1_fck_ops);
 
-static struct clk gpt1_ick;
+static struct clk_core gpt1_ick;
 
 static struct clk_hw_omap gpt1_ick_hw = {
 	.hw = {
@@ -753,7 +753,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt2_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT2_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt2_ick;
+static struct clk_core gpt2_ick;
 
 static struct clk_hw_omap gpt2_ick_hw = {
 	.hw = {
@@ -774,7 +774,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt3_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT3_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt3_ick;
+static struct clk_core gpt3_ick;
 
 static struct clk_hw_omap gpt3_ick_hw = {
 	.hw = {
@@ -795,7 +795,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt4_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT4_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt4_ick;
+static struct clk_core gpt4_ick;
 
 static struct clk_hw_omap gpt4_ick_hw = {
 	.hw = {
@@ -816,7 +816,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt5_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT5_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt5_ick;
+static struct clk_core gpt5_ick;
 
 static struct clk_hw_omap gpt5_ick_hw = {
 	.hw = {
@@ -837,7 +837,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt6_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT6_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt6_ick;
+static struct clk_core gpt6_ick;
 
 static struct clk_hw_omap gpt6_ick_hw = {
 	.hw = {
@@ -858,7 +858,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt7_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT7_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt7_ick;
+static struct clk_core gpt7_ick;
 
 static struct clk_hw_omap gpt7_ick_hw = {
 	.hw = {
@@ -872,7 +872,7 @@ static struct clk_hw_omap gpt7_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpt7_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk gpt8_fck;
+static struct clk_core gpt8_fck;
 
 DEFINE_CLK_OMAP_MUX_GATE(gpt8_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
@@ -881,7 +881,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt8_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT8_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt8_ick;
+static struct clk_core gpt8_ick;
 
 static struct clk_hw_omap gpt8_ick_hw = {
 	.hw = {
@@ -902,7 +902,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt9_fck, "core_l4_clkdm", omap24xx_gpt_clksel,
 			 OMAP24XX_EN_GPT9_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, dss1_fck_ops);
 
-static struct clk gpt9_ick;
+static struct clk_core gpt9_ick;
 
 static struct clk_hw_omap gpt9_ick_hw = {
 	.hw = {
@@ -916,7 +916,7 @@ static struct clk_hw_omap gpt9_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpt9_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk hdq_fck;
+static struct clk_core hdq_fck;
 
 static struct clk_hw_omap hdq_fck_hw = {
 	.hw = {
@@ -930,7 +930,7 @@ static struct clk_hw_omap hdq_fck_hw = {
 
 DEFINE_STRUCT_CLK(hdq_fck, fac_fck_parent_names, aes_ick_ops);
 
-static struct clk hdq_ick;
+static struct clk_core hdq_ick;
 
 static struct clk_hw_omap hdq_ick_hw = {
 	.hw = {
@@ -944,7 +944,7 @@ static struct clk_hw_omap hdq_ick_hw = {
 
 DEFINE_STRUCT_CLK(hdq_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk i2c1_ick;
+static struct clk_core i2c1_ick;
 
 static struct clk_hw_omap i2c1_ick_hw = {
 	.hw = {
@@ -958,7 +958,7 @@ static struct clk_hw_omap i2c1_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk i2c2_ick;
+static struct clk_core i2c2_ick;
 
 static struct clk_hw_omap i2c2_ick_hw = {
 	.hw = {
@@ -972,7 +972,7 @@ static struct clk_hw_omap i2c2_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk i2chs1_fck;
+static struct clk_core i2chs1_fck;
 
 static struct clk_hw_omap i2chs1_fck_hw = {
 	.hw = {
@@ -986,7 +986,7 @@ static struct clk_hw_omap i2chs1_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2chs1_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk i2chs2_fck;
+static struct clk_core i2chs2_fck;
 
 static struct clk_hw_omap i2chs2_fck_hw = {
 	.hw = {
@@ -1000,7 +1000,7 @@ static struct clk_hw_omap i2chs2_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2chs2_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk icr_ick;
+static struct clk_core icr_ick;
 
 static struct clk_hw_omap icr_ick_hw = {
 	.hw = {
@@ -1030,7 +1030,7 @@ DEFINE_CLK_OMAP_MUX_GATE(iva2_1_ick, "dsp_clkdm", dsp_ick_clksel,
 			 OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT, &clkhwops_wait,
 			 iva2_1_ick_parent_names, dsp_fck_ops);
 
-static struct clk mailboxes_ick;
+static struct clk_core mailboxes_ick;
 
 static struct clk_hw_omap mailboxes_ick_hw = {
 	.hw = {
@@ -1071,7 +1071,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP24XX_EN_MCBSP1_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp1_ick;
+static struct clk_core mcbsp1_ick;
 
 static struct clk_hw_omap mcbsp1_ick_hw = {
 	.hw = {
@@ -1092,7 +1092,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP24XX_EN_MCBSP2_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp2_ick;
+static struct clk_core mcbsp2_ick;
 
 static struct clk_hw_omap mcbsp2_ick_hw = {
 	.hw = {
@@ -1113,7 +1113,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp3_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP2430_EN_MCBSP3_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp3_ick;
+static struct clk_core mcbsp3_ick;
 
 static struct clk_hw_omap mcbsp3_ick_hw = {
 	.hw = {
@@ -1134,7 +1134,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp4_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP2430_EN_MCBSP4_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp4_ick;
+static struct clk_core mcbsp4_ick;
 
 static struct clk_hw_omap mcbsp4_ick_hw = {
 	.hw = {
@@ -1155,7 +1155,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp5_fck, "core_l4_clkdm", mcbsp_fck_clksel,
 			 OMAP2430_EN_MCBSP5_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, dss1_fck_ops);
 
-static struct clk mcbsp5_ick;
+static struct clk_core mcbsp5_ick;
 
 static struct clk_hw_omap mcbsp5_ick_hw = {
 	.hw = {
@@ -1169,7 +1169,7 @@ static struct clk_hw_omap mcbsp5_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcbsp5_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mcspi1_fck;
+static struct clk_core mcspi1_fck;
 
 static const char *mcspi1_fck_parent_names[] = {
 	"func_48m_ck",
@@ -1187,7 +1187,7 @@ static struct clk_hw_omap mcspi1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk mcspi1_ick;
+static struct clk_core mcspi1_ick;
 
 static struct clk_hw_omap mcspi1_ick_hw = {
 	.hw = {
@@ -1201,7 +1201,7 @@ static struct clk_hw_omap mcspi1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mcspi2_fck;
+static struct clk_core mcspi2_fck;
 
 static struct clk_hw_omap mcspi2_fck_hw = {
 	.hw = {
@@ -1215,7 +1215,7 @@ static struct clk_hw_omap mcspi2_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk mcspi2_ick;
+static struct clk_core mcspi2_ick;
 
 static struct clk_hw_omap mcspi2_ick_hw = {
 	.hw = {
@@ -1229,7 +1229,7 @@ static struct clk_hw_omap mcspi2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mcspi3_fck;
+static struct clk_core mcspi3_fck;
 
 static struct clk_hw_omap mcspi3_fck_hw = {
 	.hw = {
@@ -1243,7 +1243,7 @@ static struct clk_hw_omap mcspi3_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi3_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk mcspi3_ick;
+static struct clk_core mcspi3_ick;
 
 static struct clk_hw_omap mcspi3_ick_hw = {
 	.hw = {
@@ -1282,7 +1282,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mdm_ick, "mdm_clkdm", mdm_ick_clksel,
 			 &clkhwops_iclk_wait, mdm_ick_parent_names,
 			 dsp_fck_ops);
 
-static struct clk mdm_intc_ick;
+static struct clk_core mdm_intc_ick;
 
 static struct clk_hw_omap mdm_intc_ick_hw = {
 	.hw = {
@@ -1296,7 +1296,7 @@ static struct clk_hw_omap mdm_intc_ick_hw = {
 
 DEFINE_STRUCT_CLK(mdm_intc_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mdm_osc_ck;
+static struct clk_core mdm_osc_ck;
 
 static struct clk_hw_omap mdm_osc_ck_hw = {
 	.hw = {
@@ -1310,7 +1310,7 @@ static struct clk_hw_omap mdm_osc_ck_hw = {
 
 DEFINE_STRUCT_CLK(mdm_osc_ck, sys_ck_parent_names, aes_ick_ops);
 
-static struct clk mmchs1_fck;
+static struct clk_core mmchs1_fck;
 
 static struct clk_hw_omap mmchs1_fck_hw = {
 	.hw = {
@@ -1324,7 +1324,7 @@ static struct clk_hw_omap mmchs1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchs1_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk mmchs1_ick;
+static struct clk_core mmchs1_ick;
 
 static struct clk_hw_omap mmchs1_ick_hw = {
 	.hw = {
@@ -1338,7 +1338,7 @@ static struct clk_hw_omap mmchs1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mmchs1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mmchs2_fck;
+static struct clk_core mmchs2_fck;
 
 static struct clk_hw_omap mmchs2_fck_hw = {
 	.hw = {
@@ -1352,7 +1352,7 @@ static struct clk_hw_omap mmchs2_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchs2_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk mmchs2_ick;
+static struct clk_core mmchs2_ick;
 
 static struct clk_hw_omap mmchs2_ick_hw = {
 	.hw = {
@@ -1366,7 +1366,7 @@ static struct clk_hw_omap mmchs2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mmchs2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk mmchsdb1_fck;
+static struct clk_core mmchsdb1_fck;
 
 static struct clk_hw_omap mmchsdb1_fck_hw = {
 	.hw = {
@@ -1380,7 +1380,7 @@ static struct clk_hw_omap mmchsdb1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchsdb1_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk mmchsdb2_fck;
+static struct clk_core mmchsdb2_fck;
 
 static struct clk_hw_omap mmchsdb2_fck_hw = {
 	.hw = {
@@ -1399,7 +1399,7 @@ DEFINE_CLK_DIVIDER(mpu_ck, "core_ck", &core_ck, 0x0,
 		   OMAP24XX_CLKSEL_MPU_SHIFT, OMAP24XX_CLKSEL_MPU_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk mpu_wdt_fck;
+static struct clk_core mpu_wdt_fck;
 
 static struct clk_hw_omap mpu_wdt_fck_hw = {
 	.hw = {
@@ -1413,7 +1413,7 @@ static struct clk_hw_omap mpu_wdt_fck_hw = {
 
 DEFINE_STRUCT_CLK(mpu_wdt_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk mpu_wdt_ick;
+static struct clk_core mpu_wdt_ick;
 
 static struct clk_hw_omap mpu_wdt_ick_hw = {
 	.hw = {
@@ -1427,7 +1427,7 @@ static struct clk_hw_omap mpu_wdt_ick_hw = {
 
 DEFINE_STRUCT_CLK(mpu_wdt_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk mspro_fck;
+static struct clk_core mspro_fck;
 
 static struct clk_hw_omap mspro_fck_hw = {
 	.hw = {
@@ -1441,7 +1441,7 @@ static struct clk_hw_omap mspro_fck_hw = {
 
 DEFINE_STRUCT_CLK(mspro_fck, cam_fck_parent_names, aes_ick_ops);
 
-static struct clk mspro_ick;
+static struct clk_core mspro_ick;
 
 static struct clk_hw_omap mspro_ick_hw = {
 	.hw = {
@@ -1455,7 +1455,7 @@ static struct clk_hw_omap mspro_ick_hw = {
 
 DEFINE_STRUCT_CLK(mspro_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk omapctrl_ick;
+static struct clk_core omapctrl_ick;
 
 static struct clk_hw_omap omapctrl_ick_hw = {
 	.hw = {
@@ -1470,7 +1470,7 @@ static struct clk_hw_omap omapctrl_ick_hw = {
 
 DEFINE_STRUCT_CLK(omapctrl_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk pka_ick;
+static struct clk_core pka_ick;
 
 static struct clk_hw_omap pka_ick_hw = {
 	.hw = {
@@ -1484,7 +1484,7 @@ static struct clk_hw_omap pka_ick_hw = {
 
 DEFINE_STRUCT_CLK(pka_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk rng_ick;
+static struct clk_core rng_ick;
 
 static struct clk_hw_omap rng_ick_hw = {
 	.hw = {
@@ -1498,12 +1498,12 @@ static struct clk_hw_omap rng_ick_hw = {
 
 DEFINE_STRUCT_CLK(rng_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk sdma_fck;
+static struct clk_core sdma_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(sdma_fck, "core_l3_clkdm");
 DEFINE_STRUCT_CLK(sdma_fck, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sdma_ick;
+static struct clk_core sdma_ick;
 
 static struct clk_hw_omap sdma_ick_hw = {
 	.hw = {
@@ -1517,7 +1517,7 @@ static struct clk_hw_omap sdma_ick_hw = {
 
 DEFINE_STRUCT_CLK(sdma_ick, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sdrc_ick;
+static struct clk_core sdrc_ick;
 
 static struct clk_hw_omap sdrc_ick_hw = {
 	.hw = {
@@ -1532,7 +1532,7 @@ static struct clk_hw_omap sdrc_ick_hw = {
 
 DEFINE_STRUCT_CLK(sdrc_ick, gfx_ick_parent_names, core_ck_ops);
 
-static struct clk sha_ick;
+static struct clk_core sha_ick;
 
 static struct clk_hw_omap sha_ick_hw = {
 	.hw = {
@@ -1546,7 +1546,7 @@ static struct clk_hw_omap sha_ick_hw = {
 
 DEFINE_STRUCT_CLK(sha_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk ssi_l4_ick;
+static struct clk_core ssi_l4_ick;
 
 static struct clk_hw_omap ssi_l4_ick_hw = {
 	.hw = {
@@ -1586,7 +1586,7 @@ DEFINE_CLK_OMAP_MUX_GATE(ssi_ssr_sst_fck, "core_l3_clkdm",
 			 OMAP24XX_EN_SSI_SHIFT, &clkhwops_wait,
 			 ssi_ssr_sst_fck_parent_names, dsp_fck_ops);
 
-static struct clk sync_32k_ick;
+static struct clk_core sync_32k_ick;
 
 static struct clk_hw_omap sync_32k_ick_hw = {
 	.hw = {
@@ -1642,7 +1642,7 @@ DEFINE_CLK_DIVIDER(sys_clkout, "sys_clkout_src", &sys_clkout_src, 0x0,
 		   OMAP2430_PRCM_CLKOUT_CTRL, OMAP24XX_CLKOUT_DIV_SHIFT,
 		   OMAP24XX_CLKOUT_DIV_WIDTH, CLK_DIVIDER_POWER_OF_TWO, NULL);
 
-static struct clk uart1_fck;
+static struct clk_core uart1_fck;
 
 static struct clk_hw_omap uart1_fck_hw = {
 	.hw = {
@@ -1656,7 +1656,7 @@ static struct clk_hw_omap uart1_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart1_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart1_ick;
+static struct clk_core uart1_ick;
 
 static struct clk_hw_omap uart1_ick_hw = {
 	.hw = {
@@ -1670,7 +1670,7 @@ static struct clk_hw_omap uart1_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart1_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk uart2_fck;
+static struct clk_core uart2_fck;
 
 static struct clk_hw_omap uart2_fck_hw = {
 	.hw = {
@@ -1684,7 +1684,7 @@ static struct clk_hw_omap uart2_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart2_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart2_ick;
+static struct clk_core uart2_ick;
 
 static struct clk_hw_omap uart2_ick_hw = {
 	.hw = {
@@ -1698,7 +1698,7 @@ static struct clk_hw_omap uart2_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart2_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk uart3_fck;
+static struct clk_core uart3_fck;
 
 static struct clk_hw_omap uart3_fck_hw = {
 	.hw = {
@@ -1712,7 +1712,7 @@ static struct clk_hw_omap uart3_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart3_fck, mcspi1_fck_parent_names, aes_ick_ops);
 
-static struct clk uart3_ick;
+static struct clk_core uart3_ick;
 
 static struct clk_hw_omap uart3_ick_hw = {
 	.hw = {
@@ -1726,7 +1726,7 @@ static struct clk_hw_omap uart3_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart3_ick, aes_ick_parent_names, aes_ick_ops);
 
-static struct clk usb_fck;
+static struct clk_core usb_fck;
 
 static struct clk_hw_omap usb_fck_hw = {
 	.hw = {
@@ -1763,7 +1763,7 @@ DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_ick_clksel,
 			 OMAP24XX_EN_USB_SHIFT, &clkhwops_iclk_wait,
 			 usb_l4_ick_parent_names, dsp_fck_ops);
 
-static struct clk usbhs_ick;
+static struct clk_core usbhs_ick;
 
 static struct clk_hw_omap usbhs_ick_hw = {
 	.hw = {
@@ -1777,7 +1777,7 @@ static struct clk_hw_omap usbhs_ick_hw = {
 
 DEFINE_STRUCT_CLK(usbhs_ick, gfx_ick_parent_names, aes_ick_ops);
 
-static struct clk virt_prcm_set;
+static struct clk_core virt_prcm_set;
 
 static const char *virt_prcm_set_parent_names[] = {
 	"mpu_ck",
@@ -1792,7 +1792,7 @@ static const struct clk_ops virt_prcm_set_ops = {
 DEFINE_STRUCT_CLK_HW_OMAP(virt_prcm_set, NULL);
 DEFINE_STRUCT_CLK(virt_prcm_set, virt_prcm_set_parent_names, virt_prcm_set_ops);
 
-static struct clk wdt1_ick;
+static struct clk_core wdt1_ick;
 
 static struct clk_hw_omap wdt1_ick_hw = {
 	.hw = {
@@ -1806,7 +1806,7 @@ static struct clk_hw_omap wdt1_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_ick, gpios_ick_parent_names, aes_ick_ops);
 
-static struct clk wdt4_fck;
+static struct clk_core wdt4_fck;
 
 static struct clk_hw_omap wdt4_fck_hw = {
 	.hw = {
@@ -1820,7 +1820,7 @@ static struct clk_hw_omap wdt4_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt4_fck, gpio5_fck_parent_names, aes_ick_ops);
 
-static struct clk wdt4_ick;
+static struct clk_core wdt4_ick;
 
 static struct clk_hw_omap wdt4_ick_hw = {
 	.hw = {
@@ -2039,10 +2039,10 @@ int __init omap2430_clk_init(void)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(&sys_ck) / 1000000),
-		(clk_get_rate(&sys_ck) / 100000) % 10,
-		(clk_get_rate(&dpll_ck) / 1000000),
-		(clk_get_rate(&mpu_ck) / 1000000));
+		(clk_provider_get_rate(&sys_ck) / 1000000),
+		(clk_provider_get_rate(&sys_ck) / 100000) % 10,
+		(clk_provider_get_rate(&dpll_ck) / 1000000),
+		(clk_provider_get_rate(&mpu_ck) / 1000000));
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index eb8c75e..b593f2b 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -107,7 +107,7 @@ static struct dpll_data dpll3_dd = {
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 };
 
-static struct clk dpll3_ck;
+static struct clk_core dpll3_ck;
 
 static const char *dpll3_ck_parent_names[] = {
 	"sys_ck",
@@ -137,7 +137,7 @@ DEFINE_CLK_DIVIDER(dpll3_m2_ck, "dpll3_ck", &dpll3_ck, 0x0,
 		   OMAP3430_CORE_DPLL_CLKOUT_DIV_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk core_ck;
+static struct clk_core core_ck;
 
 static const char *core_ck_parent_names[] = {
 	"dpll3_m2_ck",
@@ -158,7 +158,7 @@ DEFINE_CLK_DIVIDER(l4_ick, "l3_ick", &l3_ick, 0x0,
 		   OMAP3430_CLKSEL_L4_SHIFT, OMAP3430_CLKSEL_L4_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk security_l4_ick2;
+static struct clk_core security_l4_ick2;
 
 static const char *security_l4_ick2_parent_names[] = {
 	"l4_ick",
@@ -167,7 +167,7 @@ static const char *security_l4_ick2_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(security_l4_ick2, NULL);
 DEFINE_STRUCT_CLK(security_l4_ick2, security_l4_ick2_parent_names, core_ck_ops);
 
-static struct clk aes1_ick;
+static struct clk_core aes1_ick;
 
 static const char *aes1_ick_parent_names[] = {
 	"security_l4_ick2",
@@ -190,7 +190,7 @@ static struct clk_hw_omap aes1_ick_hw = {
 
 DEFINE_STRUCT_CLK(aes1_ick, aes1_ick_parent_names, aes1_ick_ops);
 
-static struct clk core_l4_ick;
+static struct clk_core core_l4_ick;
 
 static const struct clk_ops core_l4_ick_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -199,7 +199,7 @@ static const struct clk_ops core_l4_ick_ops = {
 DEFINE_STRUCT_CLK_HW_OMAP(core_l4_ick, "core_l4_clkdm");
 DEFINE_STRUCT_CLK(core_l4_ick, security_l4_ick2_parent_names, core_l4_ick_ops);
 
-static struct clk aes2_ick;
+static struct clk_core aes2_ick;
 
 static const char *aes2_ick_parent_names[] = {
 	"core_l4_ick",
@@ -224,7 +224,7 @@ static struct clk_hw_omap aes2_ick_hw = {
 
 DEFINE_STRUCT_CLK(aes2_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk dpll1_fck;
+static struct clk_core dpll1_fck;
 
 static struct dpll_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
@@ -248,7 +248,7 @@ static struct dpll_data dpll1_dd = {
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 };
 
-static struct clk dpll1_ck;
+static struct clk_core dpll1_ck;
 
 static const struct clk_ops dpll1_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -279,7 +279,7 @@ DEFINE_CLK_DIVIDER(dpll1_x2m2_ck, "dpll1_x2_ck", &dpll1_x2_ck, 0x0,
 		   OMAP3430_MPU_DPLL_CLKOUT_DIV_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk mpu_ck;
+static struct clk_core mpu_ck;
 
 static const char *mpu_ck_parent_names[] = {
 	"dpll1_x2m2_ck",
@@ -293,7 +293,7 @@ DEFINE_CLK_DIVIDER(arm_fck, "mpu_ck", &mpu_ck, 0x0,
 		   OMAP3430_ST_MPU_CLK_SHIFT, OMAP3430_ST_MPU_CLK_WIDTH,
 		   0x0, NULL);
 
-static struct clk cam_ick;
+static struct clk_core cam_ick;
 
 static struct clk_hw_omap cam_ick_hw = {
 	.hw = {
@@ -358,7 +358,7 @@ static struct dpll_data dpll4_dd_3630 __initdata = {
 	.flags		= DPLL_J_TYPE
 };
 
-static struct clk dpll4_ck;
+static struct clk_core dpll4_ck;
 
 static const struct clk_ops dpll4_ck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -422,7 +422,7 @@ DEFINE_CLK_DIVIDER(dpll4_m5_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP3430_CLKSEL_CAM_SHIFT, OMAP3630_CLKSEL_CAM_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dpll4_m5x2_ck;
+static struct clk_core dpll4_m5x2_ck;
 
 static const char *dpll4_m5x2_ck_parent_names[] = {
 	"dpll4_m5_ck",
@@ -459,7 +459,7 @@ static struct clk_hw_omap dpll4_m5x2_ck_hw = {
 DEFINE_STRUCT_CLK_FLAGS(dpll4_m5x2_ck, dpll4_m5x2_ck_parent_names,
 			dpll4_m5x2_ck_ops, CLK_SET_RATE_PARENT);
 
-static struct clk dpll4_m5x2_ck_3630 = {
+static struct clk_core dpll4_m5x2_ck_3630 = {
 	.name		= "dpll4_m5x2_ck",
 	.hw		= &dpll4_m5x2_ck_hw.hw,
 	.parent_names	= dpll4_m5x2_ck_parent_names,
@@ -468,7 +468,7 @@ static struct clk dpll4_m5x2_ck_3630 = {
 	.flags		= CLK_SET_RATE_PARENT,
 };
 
-static struct clk cam_mclk;
+static struct clk_core cam_mclk;
 
 static const char *cam_mclk_parent_names[] = {
 	"dpll4_m5x2_ck",
@@ -483,7 +483,7 @@ static struct clk_hw_omap cam_mclk_hw = {
 	.clkdm_name	= "cam_clkdm",
 };
 
-static struct clk cam_mclk = {
+static struct clk_core cam_mclk = {
 	.name		= "cam_mclk",
 	.hw		= &cam_mclk_hw.hw,
 	.parent_names	= cam_mclk_parent_names,
@@ -512,7 +512,7 @@ DEFINE_CLK_DIVIDER(dpll4_m2_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP3430_DIV_96M_SHIFT, OMAP3630_DIV_96M_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dpll4_m2x2_ck;
+static struct clk_core dpll4_m2x2_ck;
 
 static const char *dpll4_m2x2_ck_parent_names[] = {
 	"dpll4_m2_ck",
@@ -531,7 +531,7 @@ static struct clk_hw_omap dpll4_m2x2_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll4_m2x2_ck, dpll4_m2x2_ck_parent_names, dpll4_m5x2_ck_ops);
 
-static struct clk dpll4_m2x2_ck_3630 = {
+static struct clk_core dpll4_m2x2_ck_3630 = {
 	.name		= "dpll4_m2x2_ck",
 	.hw		= &dpll4_m2x2_ck_hw.hw,
 	.parent_names	= dpll4_m2x2_ck_parent_names,
@@ -539,7 +539,7 @@ static struct clk dpll4_m2x2_ck_3630 = {
 	.ops		= &dpll4_m5x2_ck_3630_ops,
 };
 
-static struct clk omap_96m_alwon_fck;
+static struct clk_core omap_96m_alwon_fck;
 
 static const char *omap_96m_alwon_fck_parent_names[] = {
 	"dpll4_m2x2_ck",
@@ -549,7 +549,7 @@ DEFINE_STRUCT_CLK_HW_OMAP(omap_96m_alwon_fck, NULL);
 DEFINE_STRUCT_CLK(omap_96m_alwon_fck, omap_96m_alwon_fck_parent_names,
 		  core_ck_ops);
 
-static struct clk cm_96m_fck;
+static struct clk_core cm_96m_fck;
 
 static const char *cm_96m_fck_parent_names[] = {
 	"omap_96m_alwon_fck",
@@ -568,7 +568,7 @@ DEFINE_CLK_DIVIDER_TABLE(dpll4_m3_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP3430_CLKSEL_TV_SHIFT, OMAP3630_CLKSEL_TV_WIDTH,
 		   0, dpll4_mx_ck_div_table, NULL);
 
-static struct clk dpll4_m3x2_ck;
+static struct clk_core dpll4_m3x2_ck;
 
 static const char *dpll4_m3x2_ck_parent_names[] = {
 	"dpll4_m3_ck",
@@ -587,7 +587,7 @@ static struct clk_hw_omap dpll4_m3x2_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll4_m3x2_ck, dpll4_m3x2_ck_parent_names, dpll4_m5x2_ck_ops);
 
-static struct clk dpll4_m3x2_ck_3630 = {
+static struct clk_core dpll4_m3x2_ck_3630 = {
 	.name		= "dpll4_m3x2_ck",
 	.hw		= &dpll4_m3x2_ck_hw.hw,
 	.parent_names	= dpll4_m3x2_ck_parent_names,
@@ -651,7 +651,7 @@ static const char *omap_48m_fck_parent_names[] = {
 	"cm_96m_fck", "sys_altclk",
 };
 
-static struct clk omap_48m_fck;
+static struct clk_core omap_48m_fck;
 
 static const struct clk_ops omap_48m_fck_ops = {
 	.recalc_rate	= &omap2_clksel_recalc,
@@ -672,7 +672,7 @@ DEFINE_STRUCT_CLK(omap_48m_fck, omap_48m_fck_parent_names, omap_48m_fck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(omap_12m_fck, "omap_48m_fck", &omap_48m_fck, 0x0, 1, 4);
 
-static struct clk core_12m_fck;
+static struct clk_core core_12m_fck;
 
 static const char *core_12m_fck_parent_names[] = {
 	"omap_12m_fck",
@@ -681,7 +681,7 @@ static const char *core_12m_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(core_12m_fck, "core_l4_clkdm");
 DEFINE_STRUCT_CLK(core_12m_fck, core_12m_fck_parent_names, core_l4_ick_ops);
 
-static struct clk core_48m_fck;
+static struct clk_core core_48m_fck;
 
 static const char *core_48m_fck_parent_names[] = {
 	"omap_48m_fck",
@@ -698,7 +698,7 @@ DEFINE_CLK_MUX(omap_96m_fck, omap_96m_fck_parent_names, NULL, 0x0,
 	       OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	       OMAP3430_SOURCE_96M_SHIFT, OMAP3430_SOURCE_96M_WIDTH, 0x0, NULL);
 
-static struct clk core_96m_fck;
+static struct clk_core core_96m_fck;
 
 static const char *core_96m_fck_parent_names[] = {
 	"omap_96m_fck",
@@ -707,7 +707,7 @@ static const char *core_96m_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(core_96m_fck, "core_l4_clkdm");
 DEFINE_STRUCT_CLK(core_96m_fck, core_96m_fck_parent_names, core_l4_ick_ops);
 
-static struct clk core_l3_ick;
+static struct clk_core core_l3_ick;
 
 static const char *core_l3_ick_parent_names[] = {
 	"l3_ick",
@@ -718,7 +718,7 @@ DEFINE_STRUCT_CLK(core_l3_ick, core_l3_ick_parent_names, core_l4_ick_ops);
 
 DEFINE_CLK_FIXED_FACTOR(dpll3_m2x2_ck, "dpll3_m2_ck", &dpll3_m2_ck, 0x0, 2, 1);
 
-static struct clk corex2_fck;
+static struct clk_core corex2_fck;
 
 static const char *corex2_fck_parent_names[] = {
 	"dpll3_m2x2_ck",
@@ -727,7 +727,7 @@ static const char *corex2_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(corex2_fck, NULL);
 DEFINE_STRUCT_CLK(corex2_fck, corex2_fck_parent_names, core_ck_ops);
 
-static struct clk cpefuse_fck;
+static struct clk_core cpefuse_fck;
 
 static struct clk_hw_omap cpefuse_fck_hw = {
 	.hw = {
@@ -740,7 +740,7 @@ static struct clk_hw_omap cpefuse_fck_hw = {
 
 DEFINE_STRUCT_CLK(cpefuse_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk csi2_96m_fck;
+static struct clk_core csi2_96m_fck;
 
 static const char *csi2_96m_fck_parent_names[] = {
 	"core_96m_fck",
@@ -757,7 +757,7 @@ static struct clk_hw_omap csi2_96m_fck_hw = {
 
 DEFINE_STRUCT_CLK(csi2_96m_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk d2d_26m_fck;
+static struct clk_core d2d_26m_fck;
 
 static struct clk_hw_omap d2d_26m_fck_hw = {
 	.hw = {
@@ -771,7 +771,7 @@ static struct clk_hw_omap d2d_26m_fck_hw = {
 
 DEFINE_STRUCT_CLK(d2d_26m_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk des1_ick;
+static struct clk_core des1_ick;
 
 static struct clk_hw_omap des1_ick_hw = {
 	.hw = {
@@ -784,7 +784,7 @@ static struct clk_hw_omap des1_ick_hw = {
 
 DEFINE_STRUCT_CLK(des1_ick, aes1_ick_parent_names, aes1_ick_ops);
 
-static struct clk des2_ick;
+static struct clk_core des2_ick;
 
 static struct clk_hw_omap des2_ick_hw = {
 	.hw = {
@@ -803,7 +803,7 @@ DEFINE_CLK_DIVIDER(dpll1_fck, "core_ck", &core_ck, 0x0,
 		   OMAP3430_MPU_CLK_SRC_SHIFT, OMAP3430_MPU_CLK_SRC_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dpll2_fck;
+static struct clk_core dpll2_fck;
 
 static struct dpll_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
@@ -828,7 +828,7 @@ static struct dpll_data dpll2_dd = {
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 };
 
-static struct clk dpll2_ck;
+static struct clk_core dpll2_ck;
 
 static struct clk_hw_omap dpll2_ck_hw = {
 	.hw = {
@@ -857,7 +857,7 @@ DEFINE_CLK_DIVIDER(dpll3_m3_ck, "dpll3_ck", &dpll3_ck, 0x0,
 		   OMAP3430_DIV_DPLL3_SHIFT, OMAP3430_DIV_DPLL3_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dpll3_m3x2_ck;
+static struct clk_core dpll3_m3x2_ck;
 
 static const char *dpll3_m3x2_ck_parent_names[] = {
 	"dpll3_m3_ck",
@@ -876,7 +876,7 @@ static struct clk_hw_omap dpll3_m3x2_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll3_m3x2_ck, dpll3_m3x2_ck_parent_names, dpll4_m5x2_ck_ops);
 
-static struct clk dpll3_m3x2_ck_3630 = {
+static struct clk_core dpll3_m3x2_ck_3630 = {
 	.name		= "dpll3_m3x2_ck",
 	.hw		= &dpll3_m3x2_ck_hw.hw,
 	.parent_names	= dpll3_m3x2_ck_parent_names,
@@ -891,7 +891,7 @@ DEFINE_CLK_DIVIDER_TABLE(dpll4_m4_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP3430_CLKSEL_DSS1_SHIFT, OMAP3630_CLKSEL_DSS1_WIDTH,
 		   0, dpll4_mx_ck_div_table, NULL);
 
-static struct clk dpll4_m4x2_ck;
+static struct clk_core dpll4_m4x2_ck;
 
 static const char *dpll4_m4x2_ck_parent_names[] = {
 	"dpll4_m4_ck",
@@ -911,7 +911,7 @@ static struct clk_hw_omap dpll4_m4x2_ck_hw = {
 DEFINE_STRUCT_CLK_FLAGS(dpll4_m4x2_ck, dpll4_m4x2_ck_parent_names,
 		dpll4_m5x2_ck_ops, CLK_SET_RATE_PARENT);
 
-static struct clk dpll4_m4x2_ck_3630 = {
+static struct clk_core dpll4_m4x2_ck_3630 = {
 	.name		= "dpll4_m4x2_ck",
 	.hw		= &dpll4_m4x2_ck_hw.hw,
 	.parent_names	= dpll4_m4x2_ck_parent_names,
@@ -925,7 +925,7 @@ DEFINE_CLK_DIVIDER(dpll4_m6_ck, "dpll4_ck", &dpll4_ck, 0x0,
 		   OMAP3430_DIV_DPLL4_SHIFT, OMAP3630_DIV_DPLL4_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dpll4_m6x2_ck;
+static struct clk_core dpll4_m6x2_ck;
 
 static const char *dpll4_m6x2_ck_parent_names[] = {
 	"dpll4_m6_ck",
@@ -944,7 +944,7 @@ static struct clk_hw_omap dpll4_m6x2_ck_hw = {
 
 DEFINE_STRUCT_CLK(dpll4_m6x2_ck, dpll4_m6x2_ck_parent_names, dpll4_m5x2_ck_ops);
 
-static struct clk dpll4_m6x2_ck_3630 = {
+static struct clk_core dpll4_m6x2_ck_3630 = {
 	.name		= "dpll4_m6x2_ck",
 	.hw		= &dpll4_m6x2_ck_hw.hw,
 	.parent_names	= dpll4_m6x2_ck_parent_names,
@@ -976,7 +976,7 @@ static struct dpll_data dpll5_dd = {
 	.max_divider	= OMAP3_MAX_DPLL_DIV,
 };
 
-static struct clk dpll5_ck;
+static struct clk_core dpll5_ck;
 
 static struct clk_hw_omap dpll5_ck_hw = {
 	.hw = {
@@ -994,7 +994,7 @@ DEFINE_CLK_DIVIDER(dpll5_m2_ck, "dpll5_ck", &dpll5_ck, 0x0,
 		   OMAP3430ES2_DIV_120M_SHIFT, OMAP3430ES2_DIV_120M_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk dss1_alwon_fck_3430es1;
+static struct clk_core dss1_alwon_fck_3430es1;
 
 static const char *dss1_alwon_fck_3430es1_parent_names[] = {
 	"dpll4_m4x2_ck",
@@ -1013,7 +1013,7 @@ DEFINE_STRUCT_CLK_FLAGS(dss1_alwon_fck_3430es1,
 		dss1_alwon_fck_3430es1_parent_names, aes2_ick_ops,
 		CLK_SET_RATE_PARENT);
 
-static struct clk dss1_alwon_fck_3430es2;
+static struct clk_core dss1_alwon_fck_3430es2;
 
 static struct clk_hw_omap dss1_alwon_fck_3430es2_hw = {
 	.hw = {
@@ -1029,7 +1029,7 @@ DEFINE_STRUCT_CLK_FLAGS(dss1_alwon_fck_3430es2,
 		dss1_alwon_fck_3430es1_parent_names, aes2_ick_ops,
 		CLK_SET_RATE_PARENT);
 
-static struct clk dss2_alwon_fck;
+static struct clk_core dss2_alwon_fck;
 
 static struct clk_hw_omap dss2_alwon_fck_hw = {
 	.hw = {
@@ -1042,7 +1042,7 @@ static struct clk_hw_omap dss2_alwon_fck_hw = {
 
 DEFINE_STRUCT_CLK(dss2_alwon_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk dss_96m_fck;
+static struct clk_core dss_96m_fck;
 
 static struct clk_hw_omap dss_96m_fck_hw = {
 	.hw = {
@@ -1055,7 +1055,7 @@ static struct clk_hw_omap dss_96m_fck_hw = {
 
 DEFINE_STRUCT_CLK(dss_96m_fck, core_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk dss_ick_3430es1;
+static struct clk_core dss_ick_3430es1;
 
 static struct clk_hw_omap dss_ick_3430es1_hw = {
 	.hw = {
@@ -1069,7 +1069,7 @@ static struct clk_hw_omap dss_ick_3430es1_hw = {
 
 DEFINE_STRUCT_CLK(dss_ick_3430es1, security_l4_ick2_parent_names, aes2_ick_ops);
 
-static struct clk dss_ick_3430es2;
+static struct clk_core dss_ick_3430es2;
 
 static struct clk_hw_omap dss_ick_3430es2_hw = {
 	.hw = {
@@ -1083,7 +1083,7 @@ static struct clk_hw_omap dss_ick_3430es2_hw = {
 
 DEFINE_STRUCT_CLK(dss_ick_3430es2, security_l4_ick2_parent_names, aes2_ick_ops);
 
-static struct clk dss_tv_fck;
+static struct clk_core dss_tv_fck;
 
 static const char *dss_tv_fck_parent_names[] = {
 	"omap_54m_fck",
@@ -1100,7 +1100,7 @@ static struct clk_hw_omap dss_tv_fck_hw = {
 
 DEFINE_STRUCT_CLK(dss_tv_fck, dss_tv_fck_parent_names, aes2_ick_ops);
 
-static struct clk emac_fck;
+static struct clk_core emac_fck;
 
 static const char *emac_fck_parent_names[] = {
 	"rmii_ck",
@@ -1116,7 +1116,7 @@ static struct clk_hw_omap emac_fck_hw = {
 
 DEFINE_STRUCT_CLK(emac_fck, emac_fck_parent_names, aes1_ick_ops);
 
-static struct clk ipss_ick;
+static struct clk_core ipss_ick;
 
 static const char *ipss_ick_parent_names[] = {
 	"core_l3_ick",
@@ -1134,7 +1134,7 @@ static struct clk_hw_omap ipss_ick_hw = {
 
 DEFINE_STRUCT_CLK(ipss_ick, ipss_ick_parent_names, aes2_ick_ops);
 
-static struct clk emac_ick;
+static struct clk_core emac_ick;
 
 static const char *emac_ick_parent_names[] = {
 	"ipss_ick",
@@ -1152,7 +1152,7 @@ static struct clk_hw_omap emac_ick_hw = {
 
 DEFINE_STRUCT_CLK(emac_ick, emac_ick_parent_names, aes2_ick_ops);
 
-static struct clk emu_core_alwon_ck;
+static struct clk_core emu_core_alwon_ck;
 
 static const char *emu_core_alwon_ck_parent_names[] = {
 	"dpll3_m3x2_ck",
@@ -1162,7 +1162,7 @@ DEFINE_STRUCT_CLK_HW_OMAP(emu_core_alwon_ck, "dpll3_clkdm");
 DEFINE_STRUCT_CLK(emu_core_alwon_ck, emu_core_alwon_ck_parent_names,
 		  core_l4_ick_ops);
 
-static struct clk emu_mpu_alwon_ck;
+static struct clk_core emu_mpu_alwon_ck;
 
 static const char *emu_mpu_alwon_ck_parent_names[] = {
 	"mpu_ck",
@@ -1171,7 +1171,7 @@ static const char *emu_mpu_alwon_ck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(emu_mpu_alwon_ck, NULL);
 DEFINE_STRUCT_CLK(emu_mpu_alwon_ck, emu_mpu_alwon_ck_parent_names, core_ck_ops);
 
-static struct clk emu_per_alwon_ck;
+static struct clk_core emu_per_alwon_ck;
 
 static const char *emu_per_alwon_ck_parent_names[] = {
 	"dpll4_m6x2_ck",
@@ -1222,7 +1222,7 @@ static const struct clk_ops emu_src_ck_ops = {
 	.disable	= &omap2_clkops_disable_clkdm,
 };
 
-static struct clk emu_src_ck;
+static struct clk_core emu_src_ck;
 
 static struct clk_hw_omap emu_src_ck_hw = {
 	.hw = {
@@ -1241,7 +1241,7 @@ DEFINE_CLK_DIVIDER(atclk_fck, "emu_src_ck", &emu_src_ck, 0x0,
 		   OMAP3430_CLKSEL_ATCLK_SHIFT, OMAP3430_CLKSEL_ATCLK_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk fac_ick;
+static struct clk_core fac_ick;
 
 static struct clk_hw_omap fac_ick_hw = {
 	.hw = {
@@ -1255,7 +1255,7 @@ static struct clk_hw_omap fac_ick_hw = {
 
 DEFINE_STRUCT_CLK(fac_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk fshostusb_fck;
+static struct clk_core fshostusb_fck;
 
 static const char *fshostusb_fck_parent_names[] = {
 	"core_48m_fck",
@@ -1273,7 +1273,7 @@ static struct clk_hw_omap fshostusb_fck_hw = {
 
 DEFINE_STRUCT_CLK(fshostusb_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk gfx_l3_ck;
+static struct clk_core gfx_l3_ck;
 
 static struct clk_hw_omap gfx_l3_ck_hw = {
 	.hw = {
@@ -1292,7 +1292,7 @@ DEFINE_CLK_DIVIDER(gfx_l3_fck, "l3_ick", &l3_ick, 0x0,
 		   OMAP_CLKSEL_GFX_SHIFT, OMAP_CLKSEL_GFX_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk gfx_cg1_ck;
+static struct clk_core gfx_cg1_ck;
 
 static const char *gfx_cg1_ck_parent_names[] = {
 	"gfx_l3_fck",
@@ -1310,7 +1310,7 @@ static struct clk_hw_omap gfx_cg1_ck_hw = {
 
 DEFINE_STRUCT_CLK(gfx_cg1_ck, gfx_cg1_ck_parent_names, aes2_ick_ops);
 
-static struct clk gfx_cg2_ck;
+static struct clk_core gfx_cg2_ck;
 
 static struct clk_hw_omap gfx_cg2_ck_hw = {
 	.hw = {
@@ -1324,7 +1324,7 @@ static struct clk_hw_omap gfx_cg2_ck_hw = {
 
 DEFINE_STRUCT_CLK(gfx_cg2_ck, gfx_cg1_ck_parent_names, aes2_ick_ops);
 
-static struct clk gfx_l3_ick;
+static struct clk_core gfx_l3_ick;
 
 static const char *gfx_l3_ick_parent_names[] = {
 	"gfx_l3_ck",
@@ -1333,7 +1333,7 @@ static const char *gfx_l3_ick_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(gfx_l3_ick, "gfx_3430es1_clkdm");
 DEFINE_STRUCT_CLK(gfx_l3_ick, gfx_l3_ick_parent_names, core_l4_ick_ops);
 
-static struct clk wkup_32k_fck;
+static struct clk_core wkup_32k_fck;
 
 static const char *wkup_32k_fck_parent_names[] = {
 	"omap_32k_fck",
@@ -1342,7 +1342,7 @@ static const char *wkup_32k_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(wkup_32k_fck, "wkup_clkdm");
 DEFINE_STRUCT_CLK(wkup_32k_fck, wkup_32k_fck_parent_names, core_l4_ick_ops);
 
-static struct clk gpio1_dbck;
+static struct clk_core gpio1_dbck;
 
 static const char *gpio1_dbck_parent_names[] = {
 	"wkup_32k_fck",
@@ -1359,12 +1359,12 @@ static struct clk_hw_omap gpio1_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio1_dbck, gpio1_dbck_parent_names, aes2_ick_ops);
 
-static struct clk wkup_l4_ick;
+static struct clk_core wkup_l4_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(wkup_l4_ick, "wkup_clkdm");
 DEFINE_STRUCT_CLK(wkup_l4_ick, dpll3_ck_parent_names, core_l4_ick_ops);
 
-static struct clk gpio1_ick;
+static struct clk_core gpio1_ick;
 
 static const char *gpio1_ick_parent_names[] = {
 	"wkup_l4_ick",
@@ -1382,13 +1382,13 @@ static struct clk_hw_omap gpio1_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio1_ick, gpio1_ick_parent_names, aes2_ick_ops);
 
-static struct clk per_32k_alwon_fck;
+static struct clk_core per_32k_alwon_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(per_32k_alwon_fck, "per_clkdm");
 DEFINE_STRUCT_CLK(per_32k_alwon_fck, wkup_32k_fck_parent_names,
 		  core_l4_ick_ops);
 
-static struct clk gpio2_dbck;
+static struct clk_core gpio2_dbck;
 
 static const char *gpio2_dbck_parent_names[] = {
 	"per_32k_alwon_fck",
@@ -1405,12 +1405,12 @@ static struct clk_hw_omap gpio2_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio2_dbck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk per_l4_ick;
+static struct clk_core per_l4_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(per_l4_ick, "per_clkdm");
 DEFINE_STRUCT_CLK(per_l4_ick, security_l4_ick2_parent_names, core_l4_ick_ops);
 
-static struct clk gpio2_ick;
+static struct clk_core gpio2_ick;
 
 static const char *gpio2_ick_parent_names[] = {
 	"per_l4_ick",
@@ -1428,7 +1428,7 @@ static struct clk_hw_omap gpio2_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio2_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpio3_dbck;
+static struct clk_core gpio3_dbck;
 
 static struct clk_hw_omap gpio3_dbck_hw = {
 	.hw = {
@@ -1441,7 +1441,7 @@ static struct clk_hw_omap gpio3_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio3_dbck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk gpio3_ick;
+static struct clk_core gpio3_ick;
 
 static struct clk_hw_omap gpio3_ick_hw = {
 	.hw = {
@@ -1455,7 +1455,7 @@ static struct clk_hw_omap gpio3_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio3_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpio4_dbck;
+static struct clk_core gpio4_dbck;
 
 static struct clk_hw_omap gpio4_dbck_hw = {
 	.hw = {
@@ -1468,7 +1468,7 @@ static struct clk_hw_omap gpio4_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio4_dbck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk gpio4_ick;
+static struct clk_core gpio4_ick;
 
 static struct clk_hw_omap gpio4_ick_hw = {
 	.hw = {
@@ -1482,7 +1482,7 @@ static struct clk_hw_omap gpio4_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio4_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpio5_dbck;
+static struct clk_core gpio5_dbck;
 
 static struct clk_hw_omap gpio5_dbck_hw = {
 	.hw = {
@@ -1495,7 +1495,7 @@ static struct clk_hw_omap gpio5_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio5_dbck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk gpio5_ick;
+static struct clk_core gpio5_ick;
 
 static struct clk_hw_omap gpio5_ick_hw = {
 	.hw = {
@@ -1509,7 +1509,7 @@ static struct clk_hw_omap gpio5_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio5_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpio6_dbck;
+static struct clk_core gpio6_dbck;
 
 static struct clk_hw_omap gpio6_dbck_hw = {
 	.hw = {
@@ -1522,7 +1522,7 @@ static struct clk_hw_omap gpio6_dbck_hw = {
 
 DEFINE_STRUCT_CLK(gpio6_dbck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk gpio6_ick;
+static struct clk_core gpio6_ick;
 
 static struct clk_hw_omap gpio6_ick_hw = {
 	.hw = {
@@ -1536,7 +1536,7 @@ static struct clk_hw_omap gpio6_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpio6_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpmc_fck;
+static struct clk_core gpmc_fck;
 
 static struct clk_hw_omap gpmc_fck_hw = {
 	.hw = {
@@ -1565,7 +1565,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt10_fck, "core_l4_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT10_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt10_ick;
+static struct clk_core gpt10_ick;
 
 static struct clk_hw_omap gpt10_ick_hw = {
 	.hw = {
@@ -1586,7 +1586,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt11_fck, "core_l4_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT11_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt11_ick;
+static struct clk_core gpt11_ick;
 
 static struct clk_hw_omap gpt11_ick_hw = {
 	.hw = {
@@ -1600,7 +1600,7 @@ static struct clk_hw_omap gpt11_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpt11_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk gpt12_fck;
+static struct clk_core gpt12_fck;
 
 static const char *gpt12_fck_parent_names[] = {
 	"secure_32k_fck",
@@ -1609,7 +1609,7 @@ static const char *gpt12_fck_parent_names[] = {
 DEFINE_STRUCT_CLK_HW_OMAP(gpt12_fck, "wkup_clkdm");
 DEFINE_STRUCT_CLK(gpt12_fck, gpt12_fck_parent_names, core_l4_ick_ops);
 
-static struct clk gpt12_ick;
+static struct clk_core gpt12_ick;
 
 static struct clk_hw_omap gpt12_ick_hw = {
 	.hw = {
@@ -1630,7 +1630,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt1_fck, "wkup_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT1_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt1_ick;
+static struct clk_core gpt1_ick;
 
 static struct clk_hw_omap gpt1_ick_hw = {
 	.hw = {
@@ -1651,7 +1651,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt2_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT2_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt2_ick;
+static struct clk_core gpt2_ick;
 
 static struct clk_hw_omap gpt2_ick_hw = {
 	.hw = {
@@ -1672,7 +1672,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt3_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT3_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt3_ick;
+static struct clk_core gpt3_ick;
 
 static struct clk_hw_omap gpt3_ick_hw = {
 	.hw = {
@@ -1693,7 +1693,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt4_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT4_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt4_ick;
+static struct clk_core gpt4_ick;
 
 static struct clk_hw_omap gpt4_ick_hw = {
 	.hw = {
@@ -1714,7 +1714,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt5_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT5_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt5_ick;
+static struct clk_core gpt5_ick;
 
 static struct clk_hw_omap gpt5_ick_hw = {
 	.hw = {
@@ -1735,7 +1735,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt6_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT6_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt6_ick;
+static struct clk_core gpt6_ick;
 
 static struct clk_hw_omap gpt6_ick_hw = {
 	.hw = {
@@ -1756,7 +1756,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt7_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT7_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt7_ick;
+static struct clk_core gpt7_ick;
 
 static struct clk_hw_omap gpt7_ick_hw = {
 	.hw = {
@@ -1777,7 +1777,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt8_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT8_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt8_ick;
+static struct clk_core gpt8_ick;
 
 static struct clk_hw_omap gpt8_ick_hw = {
 	.hw = {
@@ -1798,7 +1798,7 @@ DEFINE_CLK_OMAP_MUX_GATE(gpt9_fck, "per_clkdm", omap343x_gpt_clksel,
 			 OMAP3430_EN_GPT9_SHIFT, &clkhwops_wait,
 			 gpt10_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk gpt9_ick;
+static struct clk_core gpt9_ick;
 
 static struct clk_hw_omap gpt9_ick_hw = {
 	.hw = {
@@ -1812,7 +1812,7 @@ static struct clk_hw_omap gpt9_ick_hw = {
 
 DEFINE_STRUCT_CLK(gpt9_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk hdq_fck;
+static struct clk_core hdq_fck;
 
 static const char *hdq_fck_parent_names[] = {
 	"core_12m_fck",
@@ -1830,7 +1830,7 @@ static struct clk_hw_omap hdq_fck_hw = {
 
 DEFINE_STRUCT_CLK(hdq_fck, hdq_fck_parent_names, aes2_ick_ops);
 
-static struct clk hdq_ick;
+static struct clk_core hdq_ick;
 
 static struct clk_hw_omap hdq_ick_hw = {
 	.hw = {
@@ -1844,7 +1844,7 @@ static struct clk_hw_omap hdq_ick_hw = {
 
 DEFINE_STRUCT_CLK(hdq_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk hecc_ck;
+static struct clk_core hecc_ck;
 
 static struct clk_hw_omap hecc_ck_hw = {
 	.hw = {
@@ -1858,7 +1858,7 @@ static struct clk_hw_omap hecc_ck_hw = {
 
 DEFINE_STRUCT_CLK(hecc_ck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk hsotgusb_fck_am35xx;
+static struct clk_core hsotgusb_fck_am35xx;
 
 static struct clk_hw_omap hsotgusb_fck_am35xx_hw = {
 	.hw = {
@@ -1871,7 +1871,7 @@ static struct clk_hw_omap hsotgusb_fck_am35xx_hw = {
 
 DEFINE_STRUCT_CLK(hsotgusb_fck_am35xx, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk hsotgusb_ick_3430es1;
+static struct clk_core hsotgusb_ick_3430es1;
 
 static struct clk_hw_omap hsotgusb_ick_3430es1_hw = {
 	.hw = {
@@ -1885,7 +1885,7 @@ static struct clk_hw_omap hsotgusb_ick_3430es1_hw = {
 
 DEFINE_STRUCT_CLK(hsotgusb_ick_3430es1, ipss_ick_parent_names, aes2_ick_ops);
 
-static struct clk hsotgusb_ick_3430es2;
+static struct clk_core hsotgusb_ick_3430es2;
 
 static struct clk_hw_omap hsotgusb_ick_3430es2_hw = {
 	.hw = {
@@ -1899,7 +1899,7 @@ static struct clk_hw_omap hsotgusb_ick_3430es2_hw = {
 
 DEFINE_STRUCT_CLK(hsotgusb_ick_3430es2, ipss_ick_parent_names, aes2_ick_ops);
 
-static struct clk hsotgusb_ick_am35xx;
+static struct clk_core hsotgusb_ick_am35xx;
 
 static struct clk_hw_omap hsotgusb_ick_am35xx_hw = {
 	.hw = {
@@ -1913,7 +1913,7 @@ static struct clk_hw_omap hsotgusb_ick_am35xx_hw = {
 
 DEFINE_STRUCT_CLK(hsotgusb_ick_am35xx, emac_ick_parent_names, aes2_ick_ops);
 
-static struct clk i2c1_fck;
+static struct clk_core i2c1_fck;
 
 static struct clk_hw_omap i2c1_fck_hw = {
 	.hw = {
@@ -1927,7 +1927,7 @@ static struct clk_hw_omap i2c1_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2c1_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk i2c1_ick;
+static struct clk_core i2c1_ick;
 
 static struct clk_hw_omap i2c1_ick_hw = {
 	.hw = {
@@ -1941,7 +1941,7 @@ static struct clk_hw_omap i2c1_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c1_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk i2c2_fck;
+static struct clk_core i2c2_fck;
 
 static struct clk_hw_omap i2c2_fck_hw = {
 	.hw = {
@@ -1955,7 +1955,7 @@ static struct clk_hw_omap i2c2_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2c2_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk i2c2_ick;
+static struct clk_core i2c2_ick;
 
 static struct clk_hw_omap i2c2_ick_hw = {
 	.hw = {
@@ -1969,7 +1969,7 @@ static struct clk_hw_omap i2c2_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c2_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk i2c3_fck;
+static struct clk_core i2c3_fck;
 
 static struct clk_hw_omap i2c3_fck_hw = {
 	.hw = {
@@ -1983,7 +1983,7 @@ static struct clk_hw_omap i2c3_fck_hw = {
 
 DEFINE_STRUCT_CLK(i2c3_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk i2c3_ick;
+static struct clk_core i2c3_ick;
 
 static struct clk_hw_omap i2c3_ick_hw = {
 	.hw = {
@@ -1997,7 +1997,7 @@ static struct clk_hw_omap i2c3_ick_hw = {
 
 DEFINE_STRUCT_CLK(i2c3_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk icr_ick;
+static struct clk_core icr_ick;
 
 static struct clk_hw_omap icr_ick_hw = {
 	.hw = {
@@ -2011,7 +2011,7 @@ static struct clk_hw_omap icr_ick_hw = {
 
 DEFINE_STRUCT_CLK(icr_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk iva2_ck;
+static struct clk_core iva2_ck;
 
 static const char *iva2_ck_parent_names[] = {
 	"dpll2_m2_ck",
@@ -2029,7 +2029,7 @@ static struct clk_hw_omap iva2_ck_hw = {
 
 DEFINE_STRUCT_CLK(iva2_ck, iva2_ck_parent_names, aes2_ick_ops);
 
-static struct clk mad2d_ick;
+static struct clk_core mad2d_ick;
 
 static struct clk_hw_omap mad2d_ick_hw = {
 	.hw = {
@@ -2043,7 +2043,7 @@ static struct clk_hw_omap mad2d_ick_hw = {
 
 DEFINE_STRUCT_CLK(mad2d_ick, core_l3_ick_parent_names, aes2_ick_ops);
 
-static struct clk mailboxes_ick;
+static struct clk_core mailboxes_ick;
 
 static struct clk_hw_omap mailboxes_ick_hw = {
 	.hw = {
@@ -2084,7 +2084,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp1_fck, "core_l4_clkdm", mcbsp_15_clksel,
 			 OMAP3430_EN_MCBSP1_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk mcbsp1_ick;
+static struct clk_core mcbsp1_ick;
 
 static struct clk_hw_omap mcbsp1_ick_hw = {
 	.hw = {
@@ -2098,7 +2098,7 @@ static struct clk_hw_omap mcbsp1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcbsp1_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk per_96m_fck;
+static struct clk_core per_96m_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(per_96m_fck, "per_clkdm");
 DEFINE_STRUCT_CLK(per_96m_fck, cm_96m_fck_parent_names, core_l4_ick_ops);
@@ -2120,7 +2120,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp2_fck, "per_clkdm", mcbsp_234_clksel,
 			 OMAP3430_EN_MCBSP2_SHIFT, &clkhwops_wait,
 			 mcbsp2_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk mcbsp2_ick;
+static struct clk_core mcbsp2_ick;
 
 static struct clk_hw_omap mcbsp2_ick_hw = {
 	.hw = {
@@ -2141,7 +2141,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp3_fck, "per_clkdm", mcbsp_234_clksel,
 			 OMAP3430_EN_MCBSP3_SHIFT, &clkhwops_wait,
 			 mcbsp2_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk mcbsp3_ick;
+static struct clk_core mcbsp3_ick;
 
 static struct clk_hw_omap mcbsp3_ick_hw = {
 	.hw = {
@@ -2162,7 +2162,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp4_fck, "per_clkdm", mcbsp_234_clksel,
 			 OMAP3430_EN_MCBSP4_SHIFT, &clkhwops_wait,
 			 mcbsp2_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk mcbsp4_ick;
+static struct clk_core mcbsp4_ick;
 
 static struct clk_hw_omap mcbsp4_ick_hw = {
 	.hw = {
@@ -2183,7 +2183,7 @@ DEFINE_CLK_OMAP_MUX_GATE(mcbsp5_fck, "core_l4_clkdm", mcbsp_15_clksel,
 			 OMAP3430_EN_MCBSP5_SHIFT, &clkhwops_wait,
 			 mcbsp1_fck_parent_names, clkout2_src_ck_ops);
 
-static struct clk mcbsp5_ick;
+static struct clk_core mcbsp5_ick;
 
 static struct clk_hw_omap mcbsp5_ick_hw = {
 	.hw = {
@@ -2197,7 +2197,7 @@ static struct clk_hw_omap mcbsp5_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcbsp5_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mcspi1_fck;
+static struct clk_core mcspi1_fck;
 
 static struct clk_hw_omap mcspi1_fck_hw = {
 	.hw = {
@@ -2211,7 +2211,7 @@ static struct clk_hw_omap mcspi1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk mcspi1_ick;
+static struct clk_core mcspi1_ick;
 
 static struct clk_hw_omap mcspi1_ick_hw = {
 	.hw = {
@@ -2225,7 +2225,7 @@ static struct clk_hw_omap mcspi1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi1_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mcspi2_fck;
+static struct clk_core mcspi2_fck;
 
 static struct clk_hw_omap mcspi2_fck_hw = {
 	.hw = {
@@ -2239,7 +2239,7 @@ static struct clk_hw_omap mcspi2_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk mcspi2_ick;
+static struct clk_core mcspi2_ick;
 
 static struct clk_hw_omap mcspi2_ick_hw = {
 	.hw = {
@@ -2253,7 +2253,7 @@ static struct clk_hw_omap mcspi2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi2_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mcspi3_fck;
+static struct clk_core mcspi3_fck;
 
 static struct clk_hw_omap mcspi3_fck_hw = {
 	.hw = {
@@ -2267,7 +2267,7 @@ static struct clk_hw_omap mcspi3_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi3_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk mcspi3_ick;
+static struct clk_core mcspi3_ick;
 
 static struct clk_hw_omap mcspi3_ick_hw = {
 	.hw = {
@@ -2281,7 +2281,7 @@ static struct clk_hw_omap mcspi3_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi3_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mcspi4_fck;
+static struct clk_core mcspi4_fck;
 
 static struct clk_hw_omap mcspi4_fck_hw = {
 	.hw = {
@@ -2295,7 +2295,7 @@ static struct clk_hw_omap mcspi4_fck_hw = {
 
 DEFINE_STRUCT_CLK(mcspi4_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk mcspi4_ick;
+static struct clk_core mcspi4_ick;
 
 static struct clk_hw_omap mcspi4_ick_hw = {
 	.hw = {
@@ -2309,7 +2309,7 @@ static struct clk_hw_omap mcspi4_ick_hw = {
 
 DEFINE_STRUCT_CLK(mcspi4_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mmchs1_fck;
+static struct clk_core mmchs1_fck;
 
 static struct clk_hw_omap mmchs1_fck_hw = {
 	.hw = {
@@ -2323,7 +2323,7 @@ static struct clk_hw_omap mmchs1_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchs1_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk mmchs1_ick;
+static struct clk_core mmchs1_ick;
 
 static struct clk_hw_omap mmchs1_ick_hw = {
 	.hw = {
@@ -2337,7 +2337,7 @@ static struct clk_hw_omap mmchs1_ick_hw = {
 
 DEFINE_STRUCT_CLK(mmchs1_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mmchs2_fck;
+static struct clk_core mmchs2_fck;
 
 static struct clk_hw_omap mmchs2_fck_hw = {
 	.hw = {
@@ -2351,7 +2351,7 @@ static struct clk_hw_omap mmchs2_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchs2_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk mmchs2_ick;
+static struct clk_core mmchs2_ick;
 
 static struct clk_hw_omap mmchs2_ick_hw = {
 	.hw = {
@@ -2365,7 +2365,7 @@ static struct clk_hw_omap mmchs2_ick_hw = {
 
 DEFINE_STRUCT_CLK(mmchs2_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk mmchs3_fck;
+static struct clk_core mmchs3_fck;
 
 static struct clk_hw_omap mmchs3_fck_hw = {
 	.hw = {
@@ -2379,7 +2379,7 @@ static struct clk_hw_omap mmchs3_fck_hw = {
 
 DEFINE_STRUCT_CLK(mmchs3_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk mmchs3_ick;
+static struct clk_core mmchs3_ick;
 
 static struct clk_hw_omap mmchs3_ick_hw = {
 	.hw = {
@@ -2393,7 +2393,7 @@ static struct clk_hw_omap mmchs3_ick_hw = {
 
 DEFINE_STRUCT_CLK(mmchs3_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk modem_fck;
+static struct clk_core modem_fck;
 
 static struct clk_hw_omap modem_fck_hw = {
 	.hw = {
@@ -2407,7 +2407,7 @@ static struct clk_hw_omap modem_fck_hw = {
 
 DEFINE_STRUCT_CLK(modem_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk mspro_fck;
+static struct clk_core mspro_fck;
 
 static struct clk_hw_omap mspro_fck_hw = {
 	.hw = {
@@ -2421,7 +2421,7 @@ static struct clk_hw_omap mspro_fck_hw = {
 
 DEFINE_STRUCT_CLK(mspro_fck, csi2_96m_fck_parent_names, aes2_ick_ops);
 
-static struct clk mspro_ick;
+static struct clk_core mspro_ick;
 
 static struct clk_hw_omap mspro_ick_hw = {
 	.hw = {
@@ -2435,13 +2435,13 @@ static struct clk_hw_omap mspro_ick_hw = {
 
 DEFINE_STRUCT_CLK(mspro_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk omap_192m_alwon_fck;
+static struct clk_core omap_192m_alwon_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(omap_192m_alwon_fck, NULL);
 DEFINE_STRUCT_CLK(omap_192m_alwon_fck, omap_96m_alwon_fck_parent_names,
 		  core_ck_ops);
 
-static struct clk omap_32ksync_ick;
+static struct clk_core omap_32ksync_ick;
 
 static struct clk_hw_omap omap_32ksync_ick_hw = {
 	.hw = {
@@ -2466,7 +2466,7 @@ static const struct clksel omap_96m_alwon_fck_clksel[] = {
 	{ .parent = NULL }
 };
 
-static struct clk omap_96m_alwon_fck_3630;
+static struct clk_core omap_96m_alwon_fck_3630;
 
 static const char *omap_96m_alwon_fck_3630_parent_names[] = {
 	"omap_192m_alwon_fck",
@@ -2487,7 +2487,7 @@ static struct clk_hw_omap omap_96m_alwon_fck_3630_hw = {
 	.clksel_mask	= OMAP3630_CLKSEL_96M_MASK,
 };
 
-static struct clk omap_96m_alwon_fck_3630 = {
+static struct clk_core omap_96m_alwon_fck_3630 = {
 	.name	= "omap_96m_alwon_fck",
 	.hw	= &omap_96m_alwon_fck_3630_hw.hw,
 	.parent_names	= omap_96m_alwon_fck_3630_parent_names,
@@ -2495,7 +2495,7 @@ static struct clk omap_96m_alwon_fck_3630 = {
 	.ops	= &omap_96m_alwon_fck_3630_ops,
 };
 
-static struct clk omapctrl_ick;
+static struct clk_core omapctrl_ick;
 
 static struct clk_hw_omap omapctrl_ick_hw = {
 	.hw = {
@@ -2520,17 +2520,17 @@ DEFINE_CLK_DIVIDER(pclkx2_fck, "emu_src_ck", &emu_src_ck, 0x0,
 		   OMAP3430_CLKSEL_PCLKX2_SHIFT, OMAP3430_CLKSEL_PCLKX2_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk per_48m_fck;
+static struct clk_core per_48m_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(per_48m_fck, "per_clkdm");
 DEFINE_STRUCT_CLK(per_48m_fck, core_48m_fck_parent_names, core_l4_ick_ops);
 
-static struct clk security_l3_ick;
+static struct clk_core security_l3_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(security_l3_ick, NULL);
 DEFINE_STRUCT_CLK(security_l3_ick, core_l3_ick_parent_names, core_ck_ops);
 
-static struct clk pka_ick;
+static struct clk_core pka_ick;
 
 static const char *pka_ick_parent_names[] = {
 	"security_l3_ick",
@@ -2552,7 +2552,7 @@ DEFINE_CLK_DIVIDER(rm_ick, "l4_ick", &l4_ick, 0x0,
 		   OMAP3430_CLKSEL_RM_SHIFT, OMAP3430_CLKSEL_RM_WIDTH,
 		   CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk rng_ick;
+static struct clk_core rng_ick;
 
 static struct clk_hw_omap rng_ick_hw = {
 	.hw = {
@@ -2565,7 +2565,7 @@ static struct clk_hw_omap rng_ick_hw = {
 
 DEFINE_STRUCT_CLK(rng_ick, aes1_ick_parent_names, aes1_ick_ops);
 
-static struct clk sad2d_ick;
+static struct clk_core sad2d_ick;
 
 static struct clk_hw_omap sad2d_ick_hw = {
 	.hw = {
@@ -2579,7 +2579,7 @@ static struct clk_hw_omap sad2d_ick_hw = {
 
 DEFINE_STRUCT_CLK(sad2d_ick, core_l3_ick_parent_names, aes2_ick_ops);
 
-static struct clk sdrc_ick;
+static struct clk_core sdrc_ick;
 
 static struct clk_hw_omap sdrc_ick_hw = {
 	.hw = {
@@ -2630,7 +2630,7 @@ static const char *sgx_fck_parent_names[] = {
 	"core_ck", "cm_96m_fck", "omap_192m_alwon_fck", "corex2_fck",
 };
 
-static struct clk sgx_fck;
+static struct clk_core sgx_fck;
 
 static const struct clk_ops sgx_fck_ops = {
 	.init		= &omap2_init_clk_clkdm,
@@ -2651,7 +2651,7 @@ DEFINE_CLK_OMAP_MUX_GATE(sgx_fck, "sgx_clkdm", sgx_clksel,
 			 OMAP3430ES2_CM_FCLKEN_SGX_EN_SGX_SHIFT,
 			 &clkhwops_wait, sgx_fck_parent_names, sgx_fck_ops);
 
-static struct clk sgx_ick;
+static struct clk_core sgx_ick;
 
 static struct clk_hw_omap sgx_ick_hw = {
 	.hw = {
@@ -2665,7 +2665,7 @@ static struct clk_hw_omap sgx_ick_hw = {
 
 DEFINE_STRUCT_CLK(sgx_ick, core_l3_ick_parent_names, aes2_ick_ops);
 
-static struct clk sha11_ick;
+static struct clk_core sha11_ick;
 
 static struct clk_hw_omap sha11_ick_hw = {
 	.hw = {
@@ -2678,7 +2678,7 @@ static struct clk_hw_omap sha11_ick_hw = {
 
 DEFINE_STRUCT_CLK(sha11_ick, aes1_ick_parent_names, aes1_ick_ops);
 
-static struct clk sha12_ick;
+static struct clk_core sha12_ick;
 
 static struct clk_hw_omap sha12_ick_hw = {
 	.hw = {
@@ -2692,7 +2692,7 @@ static struct clk_hw_omap sha12_ick_hw = {
 
 DEFINE_STRUCT_CLK(sha12_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk sr1_fck;
+static struct clk_core sr1_fck;
 
 static struct clk_hw_omap sr1_fck_hw = {
 	.hw = {
@@ -2706,7 +2706,7 @@ static struct clk_hw_omap sr1_fck_hw = {
 
 DEFINE_STRUCT_CLK(sr1_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk sr2_fck;
+static struct clk_core sr2_fck;
 
 static struct clk_hw_omap sr2_fck_hw = {
 	.hw = {
@@ -2720,17 +2720,17 @@ static struct clk_hw_omap sr2_fck_hw = {
 
 DEFINE_STRUCT_CLK(sr2_fck, dpll3_ck_parent_names, aes2_ick_ops);
 
-static struct clk sr_l4_ick;
+static struct clk_core sr_l4_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(sr_l4_ick, "core_l4_clkdm");
 DEFINE_STRUCT_CLK(sr_l4_ick, security_l4_ick2_parent_names, core_l4_ick_ops);
 
-static struct clk ssi_l4_ick;
+static struct clk_core ssi_l4_ick;
 
 DEFINE_STRUCT_CLK_HW_OMAP(ssi_l4_ick, "core_l4_clkdm");
 DEFINE_STRUCT_CLK(ssi_l4_ick, security_l4_ick2_parent_names, core_l4_ick_ops);
 
-static struct clk ssi_ick_3430es1;
+static struct clk_core ssi_ick_3430es1;
 
 static const char *ssi_ick_3430es1_parent_names[] = {
 	"ssi_l4_ick",
@@ -2748,7 +2748,7 @@ static struct clk_hw_omap ssi_ick_3430es1_hw = {
 
 DEFINE_STRUCT_CLK(ssi_ick_3430es1, ssi_ick_3430es1_parent_names, aes2_ick_ops);
 
-static struct clk ssi_ick_3430es2;
+static struct clk_core ssi_ick_3430es2;
 
 static struct clk_hw_omap ssi_ick_3430es2_hw = {
 	.hw = {
@@ -2813,7 +2813,7 @@ DEFINE_CLK_FIXED_FACTOR(ssi_sst_fck_3430es1, "ssi_ssr_fck_3430es1",
 DEFINE_CLK_FIXED_FACTOR(ssi_sst_fck_3430es2, "ssi_ssr_fck_3430es2",
 			&ssi_ssr_fck_3430es2, 0x0, 1, 2);
 
-static struct clk sys_clkout1;
+static struct clk_core sys_clkout1;
 
 static const char *sys_clkout1_parent_names[] = {
 	"osc_sys_ck",
@@ -2843,7 +2843,7 @@ DEFINE_CLK_DIVIDER(traceclk_fck, "traceclk_src_fck", &traceclk_src_fck, 0x0,
 		   OMAP3430_CLKSEL_TRACECLK_SHIFT,
 		   OMAP3430_CLKSEL_TRACECLK_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);
 
-static struct clk ts_fck;
+static struct clk_core ts_fck;
 
 static struct clk_hw_omap ts_fck_hw = {
 	.hw = {
@@ -2856,7 +2856,7 @@ static struct clk_hw_omap ts_fck_hw = {
 
 DEFINE_STRUCT_CLK(ts_fck, wkup_32k_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart1_fck;
+static struct clk_core uart1_fck;
 
 static struct clk_hw_omap uart1_fck_hw = {
 	.hw = {
@@ -2870,7 +2870,7 @@ static struct clk_hw_omap uart1_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart1_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart1_ick;
+static struct clk_core uart1_ick;
 
 static struct clk_hw_omap uart1_ick_hw = {
 	.hw = {
@@ -2884,7 +2884,7 @@ static struct clk_hw_omap uart1_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart1_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk uart2_fck;
+static struct clk_core uart2_fck;
 
 static struct clk_hw_omap uart2_fck_hw = {
 	.hw = {
@@ -2898,7 +2898,7 @@ static struct clk_hw_omap uart2_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart2_fck, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart2_ick;
+static struct clk_core uart2_ick;
 
 static struct clk_hw_omap uart2_ick_hw = {
 	.hw = {
@@ -2912,7 +2912,7 @@ static struct clk_hw_omap uart2_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart2_ick, aes2_ick_parent_names, aes2_ick_ops);
 
-static struct clk uart3_fck;
+static struct clk_core uart3_fck;
 
 static const char *uart3_fck_parent_names[] = {
 	"per_48m_fck",
@@ -2930,7 +2930,7 @@ static struct clk_hw_omap uart3_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart3_fck, uart3_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart3_ick;
+static struct clk_core uart3_ick;
 
 static struct clk_hw_omap uart3_ick_hw = {
 	.hw = {
@@ -2944,7 +2944,7 @@ static struct clk_hw_omap uart3_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart3_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk uart4_fck;
+static struct clk_core uart4_fck;
 
 static struct clk_hw_omap uart4_fck_hw = {
 	.hw = {
@@ -2958,7 +2958,7 @@ static struct clk_hw_omap uart4_fck_hw = {
 
 DEFINE_STRUCT_CLK(uart4_fck, uart3_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart4_fck_am35xx;
+static struct clk_core uart4_fck_am35xx;
 
 static struct clk_hw_omap uart4_fck_am35xx_hw = {
 	.hw = {
@@ -2972,7 +2972,7 @@ static struct clk_hw_omap uart4_fck_am35xx_hw = {
 
 DEFINE_STRUCT_CLK(uart4_fck_am35xx, fshostusb_fck_parent_names, aes2_ick_ops);
 
-static struct clk uart4_ick;
+static struct clk_core uart4_ick;
 
 static struct clk_hw_omap uart4_ick_hw = {
 	.hw = {
@@ -2986,7 +2986,7 @@ static struct clk_hw_omap uart4_ick_hw = {
 
 DEFINE_STRUCT_CLK(uart4_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
-static struct clk uart4_ick_am35xx;
+static struct clk_core uart4_ick_am35xx;
 
 static struct clk_hw_omap uart4_ick_am35xx_hw = {
 	.hw = {
@@ -3023,7 +3023,7 @@ DEFINE_CLK_OMAP_MUX_GATE(usb_l4_ick, "core_l4_clkdm", usb_l4_clksel,
 			 &clkhwops_iclk_wait, usb_l4_ick_parent_names,
 			 ssi_ssr_fck_3430es1_ops);
 
-static struct clk usbhost_120m_fck;
+static struct clk_core usbhost_120m_fck;
 
 static const char *usbhost_120m_fck_parent_names[] = {
 	"dpll5_m2_ck",
@@ -3041,7 +3041,7 @@ static struct clk_hw_omap usbhost_120m_fck_hw = {
 DEFINE_STRUCT_CLK(usbhost_120m_fck, usbhost_120m_fck_parent_names,
 		  aes2_ick_ops);
 
-static struct clk usbhost_48m_fck;
+static struct clk_core usbhost_48m_fck;
 
 static struct clk_hw_omap usbhost_48m_fck_hw = {
 	.hw = {
@@ -3055,7 +3055,7 @@ static struct clk_hw_omap usbhost_48m_fck_hw = {
 
 DEFINE_STRUCT_CLK(usbhost_48m_fck, core_48m_fck_parent_names, aes2_ick_ops);
 
-static struct clk usbhost_ick;
+static struct clk_core usbhost_ick;
 
 static struct clk_hw_omap usbhost_ick_hw = {
 	.hw = {
@@ -3069,7 +3069,7 @@ static struct clk_hw_omap usbhost_ick_hw = {
 
 DEFINE_STRUCT_CLK(usbhost_ick, security_l4_ick2_parent_names, aes2_ick_ops);
 
-static struct clk usbtll_fck;
+static struct clk_core usbtll_fck;
 
 static struct clk_hw_omap usbtll_fck_hw = {
 	.hw = {
@@ -3083,7 +3083,7 @@ static struct clk_hw_omap usbtll_fck_hw = {
 
 DEFINE_STRUCT_CLK(usbtll_fck, usbhost_120m_fck_parent_names, aes2_ick_ops);
 
-static struct clk usbtll_ick;
+static struct clk_core usbtll_ick;
 
 static struct clk_hw_omap usbtll_ick_hw = {
 	.hw = {
@@ -3124,7 +3124,7 @@ static const char *usim_fck_parent_names[] = {
 	"omap_96m_fck", "dpll5_m2_ck", "sys_ck",
 };
 
-static struct clk usim_fck;
+static struct clk_core usim_fck;
 
 static const struct clk_ops usim_fck_ops = {
 	.enable		= &omap2_dflt_clk_enable,
@@ -3142,7 +3142,7 @@ DEFINE_CLK_OMAP_MUX_GATE(usim_fck, NULL, usim_clksel,
 			 OMAP3430ES2_EN_USIMOCP_SHIFT, &clkhwops_wait,
 			 usim_fck_parent_names, usim_fck_ops);
 
-static struct clk usim_ick;
+static struct clk_core usim_ick;
 
 static struct clk_hw_omap usim_ick_hw = {
 	.hw = {
@@ -3156,7 +3156,7 @@ static struct clk_hw_omap usim_ick_hw = {
 
 DEFINE_STRUCT_CLK(usim_ick, gpio1_ick_parent_names, aes2_ick_ops);
 
-static struct clk vpfe_fck;
+static struct clk_core vpfe_fck;
 
 static const char *vpfe_fck_parent_names[] = {
 	"pclk_ck",
@@ -3172,7 +3172,7 @@ static struct clk_hw_omap vpfe_fck_hw = {
 
 DEFINE_STRUCT_CLK(vpfe_fck, vpfe_fck_parent_names, aes1_ick_ops);
 
-static struct clk vpfe_ick;
+static struct clk_core vpfe_ick;
 
 static struct clk_hw_omap vpfe_ick_hw = {
 	.hw = {
@@ -3186,12 +3186,12 @@ static struct clk_hw_omap vpfe_ick_hw = {
 
 DEFINE_STRUCT_CLK(vpfe_ick, emac_ick_parent_names, aes2_ick_ops);
 
-static struct clk wdt1_fck;
+static struct clk_core wdt1_fck;
 
 DEFINE_STRUCT_CLK_HW_OMAP(wdt1_fck, "wkup_clkdm");
 DEFINE_STRUCT_CLK(wdt1_fck, gpt12_fck_parent_names, core_l4_ick_ops);
 
-static struct clk wdt1_ick;
+static struct clk_core wdt1_ick;
 
 static struct clk_hw_omap wdt1_ick_hw = {
 	.hw = {
@@ -3205,7 +3205,7 @@ static struct clk_hw_omap wdt1_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt1_ick, gpio1_ick_parent_names, aes2_ick_ops);
 
-static struct clk wdt2_fck;
+static struct clk_core wdt2_fck;
 
 static struct clk_hw_omap wdt2_fck_hw = {
 	.hw = {
@@ -3219,7 +3219,7 @@ static struct clk_hw_omap wdt2_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt2_fck, gpio1_dbck_parent_names, aes2_ick_ops);
 
-static struct clk wdt2_ick;
+static struct clk_core wdt2_ick;
 
 static struct clk_hw_omap wdt2_ick_hw = {
 	.hw = {
@@ -3233,7 +3233,7 @@ static struct clk_hw_omap wdt2_ick_hw = {
 
 DEFINE_STRUCT_CLK(wdt2_ick, gpio1_ick_parent_names, aes2_ick_ops);
 
-static struct clk wdt3_fck;
+static struct clk_core wdt3_fck;
 
 static struct clk_hw_omap wdt3_fck_hw = {
 	.hw = {
@@ -3247,7 +3247,7 @@ static struct clk_hw_omap wdt3_fck_hw = {
 
 DEFINE_STRUCT_CLK(wdt3_fck, gpio2_dbck_parent_names, aes2_ick_ops);
 
-static struct clk wdt3_ick;
+static struct clk_core wdt3_ick;
 
 static struct clk_hw_omap wdt3_ick_hw = {
 	.hw = {
@@ -3661,10 +3661,10 @@ int __init omap3xxx_clk_init(void)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(&osc_sys_ck) / 1000000),
-		(clk_get_rate(&osc_sys_ck) / 100000) % 10,
-		(clk_get_rate(&core_ck) / 1000000),
-		(clk_get_rate(&arm_fck) / 1000000));
+		(clk_provider_get_rate(&osc_sys_ck) / 1000000),
+		(clk_provider_get_rate(&osc_sys_ck) / 100000) % 10,
+		(clk_provider_get_rate(&core_ck) / 1000000),
+		(clk_provider_get_rate(&arm_fck) / 1000000));
 
 	/*
 	 * Lock DPLL5 -- here only until other device init code can
@@ -3674,8 +3674,8 @@ int __init omap3xxx_clk_init(void)
 		omap3_clk_lock_dpll5();
 
 	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
-	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
-	arm_fck_p = clk_get(NULL, "arm_fck");
+	sdrc_ick_p = clk_provider_get(NULL, "sdrc_ick");
+	arm_fck_p = clk_provider_get(NULL, "arm_fck");
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index 82572e2..28a6d42 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -22,7 +22,7 @@
 
 /**
  * _allow_idle - enable DPLL autoidle bits
- * @clk: struct clk * of the DPLL to operate on
+ * @clk: struct clk_core * of the DPLL to operate on
  *
  * Enable DPLL automatic idle control.  The DPLL will enter low-power
  * stop when its downstream clocks are gated.  No return value.
@@ -39,7 +39,7 @@ static void _allow_idle(struct clk_hw_omap *clk)
 
 /**
  * _deny_idle - prevent DPLL from automatically idling
- * @clk: struct clk * of the DPLL to operate on
+ * @clk: struct clk_core * of the DPLL to operate on
  *
  * Disable DPLL automatic idle control.  No return value.
  */
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 59cf310..6723d916 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -48,7 +48,7 @@ static struct clk_hw_omap *dpll_core_ck;
  * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
  * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
  * (the latter is unusual).  This currently should be called with
- * struct clk *dpll_ck, which is a composite clock of dpll_ck and
+ * struct clk_core *dpll_ck, which is a composite clock of dpll_ck and
  * core_ck.
  */
 unsigned long omap2xxx_clk_get_core_rate(void)
@@ -179,7 +179,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 
 /**
  * omap2xxx_clkt_dpllcore_init - clk init function for dpll_ck
- * @clk: struct clk *dpll_ck
+ * @clk: struct clk_core *dpll_ck
  *
  * Store a local copy of @clk in dpll_core_ck so other code can query
  * the core rate without having to clk_get(), which can sleep.  Must
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 85e0b0c0..67014e1 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -198,14 +198,14 @@ void omap2xxx_clkt_vps_check_bootloader_rates(void)
  */
 void omap2xxx_clkt_vps_late_init(void)
 {
-	struct clk *c;
+	struct clk_core *c;
 
-	c = clk_get(NULL, "sys_ck");
+	c = clk_provider_get(NULL, "sys_ck");
 	if (IS_ERR(c)) {
 		WARN(1, "could not locate sys_ck\n");
 	} else {
-		sys_ck_rate = clk_get_rate(c);
-		clk_put(c);
+		sys_ck_rate = clk_provider_get_rate(c);
+		__clk_put(c);
 	}
 }
 
@@ -230,7 +230,7 @@ void omap2xxx_clkt_vps_init(void)
 {
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *hw = NULL;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name = "mpu_ck";
 	struct clk_lookup *lookup = NULL;
 
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index eb69acf..9e96363 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -38,7 +38,7 @@
 
 /**
  * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
- * @clk: struct clk * of DPLL to set
+ * @clk: struct clk_core * of DPLL to set
  * @rate: rounded target rate
  *
  * Program the DPLL M2 divider with the rounded target rate.  Returns
diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 7ee2610..b4796b3 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -51,15 +51,15 @@
 
 /**
  * _get_clksel_by_parent() - return clksel struct for a given clk & parent
- * @clk: OMAP struct clk ptr to inspect
- * @src_clk: OMAP struct clk ptr of the parent clk to search for
+ * @clk: OMAP struct clk_core ptr to inspect
+ * @src_clk: OMAP struct clk_core ptr of the parent clk to search for
  *
  * Scan the struct clksel array associated with the clock to find
  * the element associated with the supplied parent clock address.
  * Returns a pointer to the struct clksel on success or NULL on error.
  */
 static const struct clksel *_get_clksel_by_parent(struct clk_hw_omap *clk,
-						  struct clk *src_clk)
+						  struct clk_core *src_clk)
 {
 	const struct clksel *clks;
 
@@ -82,7 +82,7 @@ static const struct clksel *_get_clksel_by_parent(struct clk_hw_omap *clk,
 
 /**
  * _write_clksel_reg() - program a clock's clksel register in hardware
- * @clk: struct clk * to program
+ * @clk: struct clk_core * to program
  * @v: clksel bitfield value to program (with LSB at bit 0)
  *
  * Shift the clksel register bitfield value @v to its appropriate
@@ -107,10 +107,10 @@ static void _write_clksel_reg(struct clk_hw_omap *clk, u32 field_val)
 
 /**
  * _clksel_to_divisor() - turn clksel field value into integer divider
- * @clk: OMAP struct clk to use
+ * @clk: OMAP struct clk_core to use
  * @field_val: register field value to find
  *
- * Given a struct clk of a rate-selectable clksel clock, and a register field
+ * Given a struct clk_core of a rate-selectable clksel clock, and a register field
  * value to search for, find the corresponding clock divisor.  The register
  * field value should be pre-masked and shifted down so the LSB is at bit 0
  * before calling.  Returns 0 on error or returns the actual integer divisor
@@ -120,7 +120,7 @@ static u32 _clksel_to_divisor(struct clk_hw_omap *clk, u32 field_val)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
-	struct clk *parent;
+	struct clk_core *parent;
 
 	parent = __clk_get_parent(clk->hw.clk);
 
@@ -149,10 +149,10 @@ static u32 _clksel_to_divisor(struct clk_hw_omap *clk, u32 field_val)
 
 /**
  * _divisor_to_clksel() - turn clksel integer divisor into a field value
- * @clk: OMAP struct clk to use
+ * @clk: OMAP struct clk_core to use
  * @div: integer divisor to search for
  *
- * Given a struct clk of a rate-selectable clksel clock, and a clock
+ * Given a struct clk_core of a rate-selectable clksel clock, and a clock
  * divisor, find the corresponding register field value.  Returns the
  * register field value _before_ left-shifting (i.e., LSB is at bit
  * 0); or returns 0xFFFFFFFF (~0) upon error.
@@ -161,7 +161,7 @@ static u32 _divisor_to_clksel(struct clk_hw_omap *clk, u32 div)
 {
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
-	struct clk *parent;
+	struct clk_core *parent;
 
 	/* should never happen */
 	WARN_ON(div == 0);
@@ -191,7 +191,7 @@ static u32 _divisor_to_clksel(struct clk_hw_omap *clk, u32 div)
 
 /**
  * _read_divisor() - get current divisor applied to parent clock (from hdwr)
- * @clk: OMAP struct clk to use.
+ * @clk: OMAP struct clk_core to use.
  *
  * Read the current divisor register value for @clk that is programmed
  * into the hardware, convert it into the actual divisor value, and
@@ -215,7 +215,7 @@ static u32 _read_divisor(struct clk_hw_omap *clk)
 
 /**
  * omap2_clksel_round_rate_div() - find divisor for the given clock and rate
- * @clk: OMAP struct clk to use
+ * @clk: OMAP struct clk_core to use
  * @target_rate: desired clock rate
  * @new_div: ptr to where we should store the divisor
  *
@@ -233,7 +233,7 @@ u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 last_div = 0;
-	struct clk *parent;
+	struct clk_core *parent;
 	unsigned long parent_rate;
 	const char *clk_name;
 
@@ -286,7 +286,7 @@ u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
 
 /*
  * Clocktype interface functions to the OMAP clock code
- * (i.e., those used in struct clk field function pointers, etc.)
+ * (i.e., those used in struct clk_core field function pointers, etc.)
  */
 
 /**
@@ -309,7 +309,7 @@ u8 omap2_clksel_find_parent_index(struct clk_hw *hw)
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 r, found = 0;
-	struct clk *parent;
+	struct clk_core *parent;
 	const char *clk_name;
 	int ret = 0, f = 0;
 
@@ -345,11 +345,11 @@ u8 omap2_clksel_find_parent_index(struct clk_hw *hw)
 
 
 /**
- * omap2_clksel_recalc() - function ptr to pass via struct clk .recalc field
- * @clk: struct clk *
+ * omap2_clksel_recalc() - function ptr to pass via struct clk_core .recalc field
+ * @clk: struct clk_core *
  *
  * This function is intended to be called only by the clock framework.
- * Each clksel clock should have its struct clk .recalc field set to this
+ * Each clksel clock should have its struct clk_core .recalc field set to this
  * function.  Returns the clock's current rate, based on its parent's rate
  * and its current divisor setting in the hardware.
  */
@@ -376,7 +376,7 @@ unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long parent_rate)
 
 /**
  * omap2_clksel_round_rate() - find rounded rate for the given clock and rate
- * @clk: OMAP struct clk to use
+ * @clk: OMAP struct clk_core to use
  * @target_rate: desired clock rate
  *
  * This function is intended to be called only by the clock framework.
@@ -396,7 +396,7 @@ long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_rate,
 
 /**
  * omap2_clksel_set_rate() - program clock rate in hardware
- * @clk: struct clk * to program rate
+ * @clk: struct clk_core * to program rate
  * @rate: target rate to program
  *
  * This function is intended to be called only by the clock framework.
@@ -435,7 +435,7 @@ int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 /*
- * Clksel parent setting function - not passed in struct clk function
+ * Clksel parent setting function - not passed in struct clk_core function
  * pointer - instead, the OMAP clock code currently assumes that any
  * parent-setting clock is a clksel clock, and calls
  * omap2_clksel_set_parent() by default
@@ -443,8 +443,8 @@ int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 
 /**
  * omap2_clksel_set_parent() - change a clock's parent clock
- * @clk: struct clk * of the child clock
- * @new_parent: struct clk * of the new parent clock
+ * @clk: struct clk_core * of the child clock
+ * @new_parent: struct clk_core * of the new parent clock
  *
  * This function is intended to be called only by the clock framework.
  * Change the parent clock of clock @clk to @new_parent.  This is
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 67fd26a..c313b53 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -67,7 +67,7 @@
 
 /*
  * _dpll_test_fint - test whether an Fint value is valid for the DPLL
- * @clk: DPLL struct clk to test
+ * @clk: DPLL struct clk_core to test
  * @n: divider value (N) to test
  *
  * Tests whether a particular divider @n will result in a valid DPLL
@@ -200,7 +200,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
-	/* Reparent the struct clk in case the dpll is in bypass */
+	/* Reparent the struct clk_core in case the dpll is in bypass */
 	if (cpu_is_omap24xx()) {
 		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
@@ -220,7 +220,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 
 /**
  * omap2_get_dpll_rate - returns the current DPLL CLKOUT rate
- * @clk: struct clk * of a DPLL
+ * @clk: struct clk_core * of a DPLL
  *
  * DPLLs can be locked or bypassed - basically, enabled or disabled.
  * When locked, the DPLL output depends on the M and N values.  When
@@ -278,7 +278,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 
 /**
  * omap2_dpll_round_rate - round a target rate for an OMAP DPLL
- * @clk: struct clk * for a DPLL
+ * @clk: struct clk_core * for a DPLL
  * @target_rate: desired DPLL clock rate
  *
  * Given a DPLL and a desired target rate, round the target rate to a
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 591581a..072cc41 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -145,7 +145,7 @@ static int _wait_idlest_generic(struct clk_hw_omap *clk, void __iomem *reg,
 
 /**
  * _omap2_module_wait_ready - wait for an OMAP module to leave IDLE
- * @clk: struct clk * belonging to the module
+ * @clk: struct clk_core * belonging to the module
  *
  * If the necessary clocks for the OMAP hardware IP block that
  * corresponds to clock @clk are enabled, then wait for the module to
@@ -184,7 +184,7 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
  * @clk: OMAP clock struct ptr to use
  *
- * Convert a clockdomain name stored in a struct clk 'clk' into a
+ * Convert a clockdomain name stored in a struct clk_core 'clk' into a
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
@@ -225,7 +225,7 @@ void __init omap2_clk_disable_clkdm_control(void)
 
 /**
  * omap2_clk_dflt_find_companion - find companion clock to @clk
- * @clk: struct clk * to find the companion clock of
+ * @clk: struct clk_core * to find the companion clock of
  * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
  * @other_bit: u8 ** to return the companion clock bit shift in
  *
@@ -261,7 +261,7 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 
 /**
  * omap2_clk_dflt_find_idlest - find CM_IDLEST reg va, bit shift for @clk
- * @clk: struct clk * to find IDLEST info for
+ * @clk: struct clk_core * to find IDLEST info for
  * @idlest_reg: void __iomem ** to return the CM_IDLEST va in
  * @idlest_bit: u8 * to return the CM_IDLEST bit shift in
  * @idlest_val: u8 * to return the idle status indicator
@@ -511,14 +511,14 @@ __setup("mpurate=", omap_clk_setup);
 
 /**
  * omap2_init_clk_hw_omap_clocks - initialize an OMAP clock
- * @clk: struct clk * to initialize
+ * @clk: struct clk_core * to initialize
  *
  * Add an OMAP clock @clk to the internal list of OMAP clocks.  Used
  * temporarily for autoidle handling, until this support can be
  * integrated into the common clock framework code in some way.  No
  * return value.
  */
-void omap2_init_clk_hw_omap_clocks(struct clk *clk)
+void omap2_init_clk_hw_omap_clocks(struct clk_core *clk)
 {
 	struct clk_hw_omap *c;
 
@@ -575,11 +575,11 @@ int omap2_clk_disable_autoidle_all(void)
 
 /**
  * omap2_clk_deny_idle - disable autoidle on an OMAP clock
- * @clk: struct clk * to disable autoidle for
+ * @clk: struct clk_core * to disable autoidle for
  *
  * Disable autoidle on an OMAP clock.
  */
-int omap2_clk_deny_idle(struct clk *clk)
+int omap2_clk_deny_idle(struct clk_core *clk)
 {
 	struct clk_hw_omap *c;
 
@@ -594,11 +594,11 @@ int omap2_clk_deny_idle(struct clk *clk)
 
 /**
  * omap2_clk_allow_idle - enable autoidle on an OMAP clock
- * @clk: struct clk * to enable autoidle for
+ * @clk: struct clk_core * to enable autoidle for
  *
  * Enable autoidle on an OMAP clock.
  */
-int omap2_clk_allow_idle(struct clk *clk)
+int omap2_clk_allow_idle(struct clk_core *clk)
 {
 	struct clk_hw_omap *c;
 
@@ -623,12 +623,12 @@ int omap2_clk_allow_idle(struct clk *clk)
  */
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 {
-	struct clk *init_clk;
+	struct clk_core *init_clk;
 	int i;
 
 	for (i = 0; i < num_clocks; i++) {
-		init_clk = clk_get(NULL, clk_names[i]);
-		clk_prepare_enable(init_clk);
+		init_clk = clk_provider_get(NULL, clk_names[i]);
+		clk_provider_prepare_enable(init_clk);
 	}
 }
 
@@ -664,31 +664,31 @@ void __init omap_clocks_register(struct omap_clk oclks[], int cnt)
  * the OPP layer.  XXX This is intended to be handled by the OPP layer
  * code in the near future and should be removed from the clock code.
  * Returns -EINVAL if 'mpurate' is zero or if clk_set_rate() rejects
- * the rate, -ENOENT if the struct clk referred to by @mpurate_ck_name
+ * the rate, -ENOENT if the struct clk_core referred to by @mpurate_ck_name
  * cannot be found, or 0 upon success.
  */
 int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
 {
-	struct clk *mpurate_ck;
+	struct clk_core *mpurate_ck;
 	int r;
 
 	if (!mpurate)
 		return -EINVAL;
 
-	mpurate_ck = clk_get(NULL, mpurate_ck_name);
+	mpurate_ck = clk_provider_get(NULL, mpurate_ck_name);
 	if (WARN(IS_ERR(mpurate_ck), "Failed to get %s.\n", mpurate_ck_name))
 		return -ENOENT;
 
-	r = clk_set_rate(mpurate_ck, mpurate);
+	r = clk_provider_set_rate(mpurate_ck, mpurate);
 	if (r < 0) {
 		WARN(1, "clock: %s: unable to set MPU rate to %d: %d\n",
 		     mpurate_ck_name, mpurate, r);
-		clk_put(mpurate_ck);
+		__clk_put(mpurate_ck);
 		return -EINVAL;
 	}
 
 	calibrate_delay();
-	clk_put(mpurate_ck);
+	__clk_put(mpurate_ck);
 
 	return 0;
 }
@@ -709,25 +709,25 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 				      const char *core_ck_name,
 				      const char *mpu_ck_name)
 {
-	struct clk *hfclkin_ck, *core_ck, *mpu_ck;
+	struct clk_core *hfclkin_ck, *core_ck, *mpu_ck;
 	unsigned long hfclkin_rate;
 
-	mpu_ck = clk_get(NULL, mpu_ck_name);
+	mpu_ck = clk_provider_get(NULL, mpu_ck_name);
 	if (WARN(IS_ERR(mpu_ck), "clock: failed to get %s.\n", mpu_ck_name))
 		return;
 
-	core_ck = clk_get(NULL, core_ck_name);
+	core_ck = clk_provider_get(NULL, core_ck_name);
 	if (WARN(IS_ERR(core_ck), "clock: failed to get %s.\n", core_ck_name))
 		return;
 
-	hfclkin_ck = clk_get(NULL, hfclkin_ck_name);
+	hfclkin_ck = clk_provider_get(NULL, hfclkin_ck_name);
 	if (WARN(IS_ERR(hfclkin_ck), "Failed to get %s.\n", hfclkin_ck_name))
 		return;
 
-	hfclkin_rate = clk_get_rate(hfclkin_ck);
+	hfclkin_rate = clk_provider_get_rate(hfclkin_ck);
 
 	pr_info("Switched to new clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
 		(hfclkin_rate / 1000000), ((hfclkin_rate / 100000) % 10),
-		(clk_get_rate(core_ck) / 1000000),
-		(clk_get_rate(mpu_ck) / 1000000));
+		(clk_provider_get_rate(core_ck) / 1000000),
+		(clk_provider_get_rate(mpu_ck) / 1000000));
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 12f54d4..05e3d5b 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -40,7 +40,7 @@ struct omap_clk {
 struct clockdomain;
 
 #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
-	static struct clk _name = {				\
+	static struct clk_core _name = {				\
 		.name = #_name,					\
 		.hw = &_name##_hw.hw,				\
 		.parent_names = _parent_array_name,		\
@@ -50,7 +50,7 @@ struct clockdomain;
 
 #define DEFINE_STRUCT_CLK_FLAGS(_name, _parent_array_name,	\
 				_clkops_name, _flags)		\
-	static struct clk _name = {				\
+	static struct clk_core _name = {				\
 		.name = #_name,					\
 		.hw = &_name##_hw.hw,				\
 		.parent_names = _parent_array_name,		\
@@ -70,7 +70,7 @@ struct clockdomain;
 #define DEFINE_CLK_OMAP_MUX(_name, _clkdm_name, _clksel,	\
 			    _clksel_reg, _clksel_mask,		\
 			    _parent_names, _ops)		\
-	static struct clk _name;				\
+	static struct clk_core _name;				\
 	static struct clk_hw_omap _name##_hw = {		\
 		.hw = {						\
 			.clk = &_name,				\
@@ -86,7 +86,7 @@ struct clockdomain;
 				 _clksel_reg, _clksel_mask,	\
 				 _enable_reg, _enable_bit,	\
 				 _hwops, _parent_names, _ops)	\
-	static struct clk _name;				\
+	static struct clk_core _name;				\
 	static struct clk_hw_omap _name##_hw = {		\
 		.hw = {						\
 			.clk = &_name,				\
@@ -111,7 +111,7 @@ struct clockdomain;
 		},						\
 		{ .parent = NULL },				\
 	};							\
-	static struct clk _name;				\
+	static struct clk_core _name;				\
 	static const char *_name##_parent_names[] = {		\
 		_parent_name,					\
 	};							\
@@ -167,14 +167,14 @@ struct clksel_rate {
 
 /**
  * struct clksel - available parent clocks, and a pointer to their divisors
- * @parent: struct clk * to a possible parent clock
+ * @parent: struct clk_core * to a possible parent clock
  * @rates: available divisors for this parent clock
  *
  * A struct clksel is always associated with one or more struct clks
  * and one or more struct clksel_rates.
  */
 struct clksel {
-	struct clk		 *parent;
+	struct clk_core		 *parent;
 	const struct clksel_rate *rates;
 };
 
@@ -236,8 +236,8 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
 int omap2_clk_enable_autoidle_all(void);
-int omap2_clk_allow_idle(struct clk *clk);
-int omap2_clk_deny_idle(struct clk *clk);
+int omap2_clk_allow_idle(struct clk_core *clk);
+int omap2_clk_deny_idle(struct clk_core *clk);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
@@ -258,7 +258,7 @@ extern const struct clksel_rate gpt_32k_rates[];
 extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
-extern struct clk dummy_ck;
+extern struct clk_core dummy_ck;
 
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 0b02b41..17abc81 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -37,7 +37,7 @@
 #define DPLL5_FREQ_FOR_USBHOST		120000000
 
 /* needed by omap3_core_dpll_m2_set_rate() */
-struct clk *sdrc_ick_p, *arm_fck_p;
+struct clk_core *sdrc_ick_p, *arm_fck_p;
 int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -56,20 +56,20 @@ int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 
 void __init omap3_clk_lock_dpll5(void)
 {
-	struct clk *dpll5_clk;
-	struct clk *dpll5_m2_clk;
+	struct clk_core *dpll5_clk;
+	struct clk_core *dpll5_m2_clk;
 
-	dpll5_clk = clk_get(NULL, "dpll5_ck");
-	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
-	clk_prepare_enable(dpll5_clk);
+	dpll5_clk = clk_provider_get(NULL, "dpll5_ck");
+	clk_provider_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_provider_prepare_enable(dpll5_clk);
 
 	/* Program dpll5_m2_clk divider for no division */
-	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
-	clk_prepare_enable(dpll5_m2_clk);
-	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+	dpll5_m2_clk = clk_provider_get(NULL, "dpll5_m2_ck");
+	clk_provider_prepare_enable(dpll5_m2_clk);
+	clk_provider_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
 
-	clk_disable_unprepare(dpll5_m2_clk);
-	clk_disable_unprepare(dpll5_clk);
+	clk_provider_disable_unprepare(dpll5_m2_clk);
+	clk_provider_disable_unprepare(dpll5_clk);
 	return;
 }
 
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 78d9f56..063fbf1 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -12,8 +12,8 @@ int omap3xxx_clk_init(void);
 int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
 
-extern struct clk *sdrc_ick_p;
-extern struct clk *arm_fck_p;
+extern struct clk_core *sdrc_ick_p;
+extern struct clk_core *arm_fck_p;
 
 extern const struct clkops clkops_noncore_dpll_ops;
 
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index ef4d21b..31e3e79 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -119,7 +119,7 @@ const struct clksel_rate div31_1to31_rates[] = {
 
 static struct clk_ops dummy_ck_ops = {};
 
-struct clk dummy_ck = {
+struct clk_core dummy_ck = {
 	.name = "dummy_clk",
 	.ops = &dummy_ck_ops,
 	.flags = CLK_IS_BASIC,
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 2da3b5e..ce0971c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1141,7 +1141,7 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 /**
  * clkdm_clk_enable - add an enabled downstream clock to this clkdm
  * @clkdm: struct clockdomain *
- * @clk: struct clk * of the enabled downstream clock
+ * @clk: struct clk_core * of the enabled downstream clock
  *
  * Increment the usecount of the clockdomain @clkdm and ensure that it
  * is awake before @clk is enabled.  Intended to be called by
@@ -1152,7 +1152,7 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
  * by on-chip processors.  Returns -EINVAL if passed null pointers;
  * returns 0 upon success or if the clockdomain is in hwsup idle mode.
  */
-int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
+int clkdm_clk_enable(struct clockdomain *clkdm, struct clk_core *clk)
 {
 	/*
 	 * XXX Rewrite this code to maintain a list of enabled
@@ -1168,7 +1168,7 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 /**
  * clkdm_clk_disable - remove an enabled downstream clock from this clkdm
  * @clkdm: struct clockdomain *
- * @clk: struct clk * of the disabled downstream clock
+ * @clk: struct clk_core * of the disabled downstream clock
  *
  * Decrement the usecount of this clockdomain @clkdm when @clk is
  * disabled.  Intended to be called by clk_disable() code.  If the
@@ -1178,7 +1178,7 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  * pointers; -ERANGE if the @clkdm usecount underflows; or returns 0
  * upon success or if the clockdomain is in hwsup idle mode.
  */
-int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
+int clkdm_clk_disable(struct clockdomain *clkdm, struct clk_core *clk)
 {
 	if (!clkdm || !clk || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 82c37b1..f1a2cad 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -207,8 +207,8 @@ int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep_nolock(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
 
-int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
-int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
+int clkdm_clk_enable(struct clockdomain *clkdm, struct clk_core *clk);
+int clkdm_clk_disable(struct clockdomain *clkdm, struct clk_core *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 0f9e479..94b3232 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -524,7 +524,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_prepare_enable(oc->_clk);
+			clk_provider_prepare_enable(oc->_clk);
 
 	dispc_disable_outputs();
 
@@ -551,7 +551,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++)
 		if (oc->_clk)
-			clk_disable_unprepare(oc->_clk);
+			clk_provider_disable_unprepare(oc->_clk);
 
 	r = (c == MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOUT : 0;
 
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 6d7ba37..9c70696 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -291,7 +291,7 @@ static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, u8 n)
 
 /*
  * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
- * @clk:	struct clk * of DPLL to set
+ * @clk:	struct clk_core * of DPLL to set
  * @freqsel:	FREQSEL value to set
  *
  * Program the DPLL with the last M, N values calculated, and wait for
@@ -413,7 +413,7 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	int r;
 	struct dpll_data *dd;
-	struct clk *parent;
+	struct clk_core *parent;
 
 	dd = clk->dpll_data;
 	if (!dd)
@@ -464,7 +464,7 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
 
 /**
  * omap3_noncore_dpll_set_rate - set non-core DPLL rate
- * @clk: struct clk * of DPLL to set
+ * @clk: struct clk_core * of DPLL to set
  * @rate: rounded target rate
  *
  * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
@@ -477,7 +477,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct clk *new_parent = NULL;
+	struct clk_core *new_parent = NULL;
 	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
@@ -495,15 +495,15 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 			 __func__, __clk_get_name(hw->clk));
 
 		__clk_prepare(dd->clk_bypass);
-		clk_enable(dd->clk_bypass);
+		clk_provider_enable(dd->clk_bypass);
 		ret = _omap3_noncore_dpll_bypass(clk);
 		if (!ret)
 			new_parent = dd->clk_bypass;
-		clk_disable(dd->clk_bypass);
+		clk_provider_disable(dd->clk_bypass);
 		__clk_unprepare(dd->clk_bypass);
 	} else {
 		__clk_prepare(dd->clk_ref);
-		clk_enable(dd->clk_ref);
+		clk_provider_enable(dd->clk_ref);
 
 		if (dd->last_rounded_rate != rate)
 			rate = __clk_round_rate(hw->clk, rate);
@@ -524,7 +524,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		ret = omap3_noncore_dpll_program(clk, freqsel);
 		if (!ret)
 			new_parent = dd->clk_ref;
-		clk_disable(dd->clk_ref);
+		clk_provider_disable(dd->clk_ref);
 		__clk_unprepare(dd->clk_ref);
 	}
 	/*
@@ -534,7 +534,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 	* stuff is inherited for free
 	*/
 
-	if (!ret && clk_get_parent(hw->clk) != new_parent)
+	if (!ret && clk_provider_get_parent(hw->clk) != new_parent)
 		__clk_reparent(hw->clk, new_parent);
 
 	return 0;
@@ -544,10 +544,10 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 /**
  * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
- * @clk: struct clk * of the DPLL to read
+ * @clk: struct clk_core * of the DPLL to read
  *
  * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
- * -EINVAL if passed a null pointer or if the struct clk does not
+ * -EINVAL if passed a null pointer or if the struct clk_core does not
  * appear to refer to a DPLL.
  */
 u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
@@ -572,7 +572,7 @@ u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 
 /**
  * omap3_dpll_allow_idle - enable DPLL autoidle bits
- * @clk: struct clk * of the DPLL to operate on
+ * @clk: struct clk_core * of the DPLL to operate on
  *
  * Enable DPLL automatic idle control.  This automatic idle mode
  * switching takes effect only when the DPLL is locked, at least on
@@ -606,7 +606,7 @@ void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 
 /**
  * omap3_dpll_deny_idle - prevent DPLL from automatically idling
- * @clk: struct clk * of the DPLL to operate on
+ * @clk: struct clk_core * of the DPLL to operate on
  *
  * Disable DPLL automatic idle control.  No return value.
  */
@@ -636,7 +636,7 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 static struct clk_hw_omap *omap3_find_clkoutx2_dpll(struct clk_hw *hw)
 {
 	struct clk_hw_omap *pclk = NULL;
-	struct clk *parent;
+	struct clk_core *parent;
 
 	/* Walk up the parents of clk, looking for a DPLL */
 	do {
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 52f9438..0a09507 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -117,7 +117,7 @@ static void omap4_dpll_lpmode_recalc(struct dpll_data *dd)
 
 /**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to compute the rate for
+ * @clk: struct clk_core * of the DPLL to compute the rate for
  *
  * Compute the output rate for the OMAP4 DPLL represented by @clk.
  * Takes the REGM4XEN bit into consideration, which is needed for the
@@ -149,7 +149,7 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 
 /**
  * omap4_dpll_regm4xen_round_rate - round DPLL rate, considering REGM4XEN bit
- * @clk: struct clk * of the DPLL to round a rate for
+ * @clk: struct clk_core * of the DPLL to round a rate for
  * @target_rate: the desired rate of the DPLL
  *
  * Compute the rate that would be programmed into the DPLL hardware
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index b4ac3af..e7ea6ba 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -34,7 +34,7 @@
 #include "cm3xxx.h"
 #include "cm-regbits-34xx.h"
 
-static struct clk *mcbsp_iclks[5];
+static struct clk_core *mcbsp_iclks[5];
 
 static int omap3_enable_st_clock(unsigned int id, bool enable)
 {
@@ -98,7 +98,7 @@ static int __init omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
 		(struct omap_mcbsp_dev_attr *)(oh->dev_attr))->sidetone);
 		pdata->enable_st_clock = omap3_enable_st_clock;
 		sprintf(clk_name, "mcbsp%d_ick", id);
-		mcbsp_iclks[id] = clk_get(NULL, clk_name);
+		mcbsp_iclks[id] = clk_provider_get(NULL, clk_name);
 		count++;
 	}
 	pdev = omap_device_build_ss(name, id, oh_device, count, pdata,
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index fbe8cf0..350abb0 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -47,7 +47,7 @@
 static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 		       const char *clk_name)
 {
-	struct clk *r;
+	struct clk_core *r;
 	struct clk_lookup *l;
 
 	if (!clk_alias || !clk_name)
@@ -55,15 +55,15 @@ static void _add_clkdev(struct omap_device *od, const char *clk_alias,
 
 	dev_dbg(&od->pdev->dev, "Creating %s -> %s\n", clk_alias, clk_name);
 
-	r = clk_get_sys(dev_name(&od->pdev->dev), clk_alias);
+	r = clk_provider_get_sys(dev_name(&od->pdev->dev), clk_alias);
 	if (!IS_ERR(r)) {
 		dev_warn(&od->pdev->dev,
 			 "alias %s already exists\n", clk_alias);
-		clk_put(r);
+		__clk_put(r);
 		return;
 	}
 
-	r = clk_get(NULL, clk_name);
+	r = clk_provider_get(NULL, clk_name);
 	if (IS_ERR(r)) {
 		dev_err(&od->pdev->dev,
 			"clk_get for %s failed\n", clk_name);
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6c074f3..67b6635 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -753,7 +753,7 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 }
 
 /**
- * _init_main_clk - get a struct clk * for the the hwmod's main functional clk
+ * _init_main_clk - get a struct clk_core * for the the hwmod's main functional clk
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh _clk (main
@@ -767,7 +767,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	if (!oh->main_clk)
 		return 0;
 
-	oh->_clk = clk_get(NULL, oh->main_clk);
+	oh->_clk = clk_provider_get(NULL, oh->main_clk);
 	if (IS_ERR(oh->_clk)) {
 		pr_warning("omap_hwmod: %s: cannot clk_get main_clk %s\n",
 			   oh->name, oh->main_clk);
@@ -781,7 +781,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 	 * some point where subsystems like i2c and pmic become
 	 * available.
 	 */
-	clk_prepare(oh->_clk);
+	clk_provider_prepare(oh->_clk);
 
 	if (!_get_clkdm(oh))
 		pr_debug("omap_hwmod: %s: missing clockdomain for %s.\n",
@@ -791,7 +791,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 }
 
 /**
- * _init_interface_clks - get a struct clk * for the the hwmod's interface clks
+ * _init_interface_clks - get a struct clk_core * for the the hwmod's interface clks
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh OCP slave interface
@@ -801,7 +801,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 	struct list_head *p;
-	struct clk *c;
+	struct clk_core *c;
 	int i = 0;
 	int ret = 0;
 
@@ -812,7 +812,7 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 		if (!os->clk)
 			continue;
 
-		c = clk_get(NULL, os->clk);
+		c = clk_provider_get(NULL, os->clk);
 		if (IS_ERR(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get interface_clk %s\n",
 				   oh->name, os->clk);
@@ -828,14 +828,14 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 		 * some point where subsystems like i2c and pmic become
 		 * available.
 		 */
-		clk_prepare(os->_clk);
+		clk_provider_prepare(os->_clk);
 	}
 
 	return ret;
 }
 
 /**
- * _init_opt_clk - get a struct clk * for the the hwmod's optional clocks
+ * _init_opt_clk - get a struct clk_core * for the the hwmod's optional clocks
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh omap_hwmod_opt_clk
@@ -844,12 +844,12 @@ static int _init_interface_clks(struct omap_hwmod *oh)
 static int _init_opt_clks(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_opt_clk *oc;
-	struct clk *c;
+	struct clk_core *c;
 	int i;
 	int ret = 0;
 
 	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
-		c = clk_get(NULL, oc->clk);
+		c = clk_provider_get(NULL, oc->clk);
 		if (IS_ERR(c)) {
 			pr_warning("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
 				   oh->name, oc->clk);
@@ -865,7 +865,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
 		 * some point where subsystems like i2c and pmic become
 		 * available.
 		 */
-		clk_prepare(oc->_clk);
+		clk_provider_prepare(oc->_clk);
 	}
 
 	return ret;
@@ -887,7 +887,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
 
 	if (oh->_clk)
-		clk_enable(oh->_clk);
+		clk_provider_enable(oh->_clk);
 
 	p = oh->slave_ports.next;
 
@@ -895,7 +895,7 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		os = _fetch_next_ocp_if(&p, &i);
 
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
-			clk_enable(os->_clk);
+			clk_provider_enable(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -918,7 +918,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 	pr_debug("omap_hwmod: %s: disabling clocks\n", oh->name);
 
 	if (oh->_clk)
-		clk_disable(oh->_clk);
+		clk_provider_disable(oh->_clk);
 
 	p = oh->slave_ports.next;
 
@@ -926,7 +926,7 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		os = _fetch_next_ocp_if(&p, &i);
 
 		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
-			clk_disable(os->_clk);
+			clk_provider_disable(os->_clk);
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -945,7 +945,7 @@ static void _enable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: enable %s:%s\n", oc->role,
 				 __clk_get_name(oc->_clk));
-			clk_enable(oc->_clk);
+			clk_provider_enable(oc->_clk);
 		}
 }
 
@@ -960,7 +960,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 		if (oc->_clk) {
 			pr_debug("omap_hwmod: disable %s:%s\n", oc->role,
 				 __clk_get_name(oc->_clk));
-			clk_disable(oc->_clk);
+			clk_provider_disable(oc->_clk);
 		}
 }
 
@@ -2585,7 +2585,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 			/* XXX omap_iclk_deny_idle(c); */
 		} else {
 			/* XXX omap_iclk_allow_idle(c); */
-			clk_enable(os->_clk);
+			clk_provider_enable(os->_clk);
 		}
 	}
 
@@ -3389,7 +3389,7 @@ static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
  * Initialize and set up a single hwmod.  Intended to be used for a
  * small number of early devices, such as the timer IP blocks used for
  * the scheduler clock.  Must be called after omap2_clk_init().
- * Resolves the struct clk names to struct clk pointers for each
+ * Resolves the struct clk_core names to struct clk_core pointers for each
  * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
  * -EINVAL upon error or 0 upon success.
  */
@@ -3418,7 +3418,7 @@ int __init omap_hwmod_setup_one(const char *oh_name)
  *
  * Initialize and set up all IP blocks registered with the hwmod code.
  * Must be called after omap2_clk_init().  Resolves the struct clk
- * names to struct clk pointers for each registered omap_hwmod.  Also
+ * names to struct clk_core pointers for each registered omap_hwmod.  Also
  * calls _setup() on each hwmod.  Returns 0 upon success.
  */
 static int __init omap_hwmod_setup_all(void)
@@ -3785,7 +3785,7 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
  */
 struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 {
-	struct clk *c;
+	struct clk_core *c;
 	struct omap_hwmod_ocp_if *oi;
 	struct clockdomain *clkdm;
 	struct clk_hw_omap *clk;
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..46ffd06 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -207,7 +207,7 @@ struct omap_hwmod_rst_info {
  * struct omap_hwmod_opt_clk - optional clocks used by this hwmod
  * @role: "sys", "32k", "tv", etc -- for use in clk_get()
  * @clk: opt clock: OMAP clock name
- * @_clk: pointer to the struct clk (filled in at runtime)
+ * @_clk: pointer to the struct clk_core (filled in at runtime)
  *
  * The module's interface clock and main functional clock should not
  * be added as optional clocks.
@@ -215,7 +215,7 @@ struct omap_hwmod_rst_info {
 struct omap_hwmod_opt_clk {
 	const char	*role;
 	const char	*clk;
-	struct clk	*_clk;
+	struct clk_core	*_clk;
 };
 
 
@@ -289,7 +289,7 @@ struct omap_hwmod_addr_space {
  * @slave: struct omap_hwmod that responds to OCP transactions on this link
  * @addr: address space associated with this link
  * @clk: interface clock: OMAP clock name
- * @_clk: pointer to the interface struct clk (filled in at runtime)
+ * @_clk: pointer to the interface struct clk_core (filled in at runtime)
  * @fw: interface firewall data
  * @width: OCP data width
  * @user: initiators using this interface (see OCP_USER_* macros above)
@@ -306,7 +306,7 @@ struct omap_hwmod_ocp_if {
 	struct omap_hwmod		*slave;
 	struct omap_hwmod_addr_space	*addr;
 	const char			*clk;
-	struct clk			*_clk;
+	struct clk_core			*_clk;
 	union {
 		struct omap_hwmod_omap2_firewall omap2;
 	}				fw;
@@ -611,7 +611,7 @@ struct omap_hwmod_link {
  * @sdma_reqs: ptr to an array of System DMA request IDs
  * @prcm: PRCM data pertaining to this hwmod
  * @main_clk: main clock: OMAP clock name
- * @_clk: pointer to the main struct clk (filled in at runtime)
+ * @_clk: pointer to the main struct clk_core (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
  * @voltdm: pointer to voltage domain (filled in at runtime)
  * @dev_attr: arbitrary device attributes that can be passed to the driver
@@ -653,7 +653,7 @@ struct omap_hwmod {
 		struct omap_hwmod_omap4_prcm omap4;
 	}				prcm;
 	const char			*main_clk;
-	struct clk			*_clk;
+	struct clk_core			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index a5ea988..35633c5 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -60,7 +60,7 @@ static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 static struct powerdomain *mpu_pwrdm, *core_pwrdm;
 static struct clockdomain *dsp_clkdm, *mpu_clkdm, *wkup_clkdm, *gfx_clkdm;
 
-static struct clk *osc_ck, *emul_ck;
+static struct clk_core *osc_ck, *emul_ck;
 
 static int omap2_enter_full_retention(void)
 {
@@ -71,7 +71,7 @@ static int omap2_enter_full_retention(void)
 	 * oscillator itself it will be disabled if/when we enter retention
 	 * mode.
 	 */
-	clk_disable(osc_ck);
+	clk_provider_disable(osc_ck);
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
@@ -101,7 +101,7 @@ static int omap2_enter_full_retention(void)
 no_sleep:
 	omap2_gpio_resume_after_idle();
 
-	clk_enable(osc_ck);
+	clk_provider_enable(osc_ck);
 
 	/* clear CORE wake-up events */
 	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
@@ -288,17 +288,17 @@ int __init omap2_pm_init(void)
 		pr_err("PM: gfx_clkdm not found\n");
 
 
-	osc_ck = clk_get(NULL, "osc_ck");
+	osc_ck = clk_provider_get(NULL, "osc_ck");
 	if (IS_ERR(osc_ck)) {
 		printk(KERN_ERR "could not get osc_ck\n");
 		return -ENODEV;
 	}
 
 	if (cpu_is_omap242x()) {
-		emul_ck = clk_get(NULL, "emul_ck");
+		emul_ck = clk_provider_get(NULL, "emul_ck");
 		if (IS_ERR(emul_ck)) {
 			printk(KERN_ERR "could not get emul_ck\n");
-			clk_put(osc_ck);
+			__clk_put(osc_ck);
 			return -ENODEV;
 		}
 	}
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 6bbb7b5..6be2d2d 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -62,7 +62,7 @@ void __init orion5x_map_io(void)
 /*****************************************************************************
  * CLK tree
  ****************************************************************************/
-static struct clk *tclk;
+static struct clk_core *tclk;
 
 void __init clk_init(void)
 {
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 961b593..7bf2fe6 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -27,7 +27,7 @@
 
 /* Create a clkdev entry for a given device/clk */
 void __init orion_clkdev_add(const char *con_id, const char *dev_id,
-			     struct clk *clk)
+			     struct clk_core *clk)
 {
 	struct clk_lookup *cl;
 
@@ -40,7 +40,7 @@ void __init orion_clkdev_add(const char *con_id, const char *dev_id,
    Kirkwood has gated clocks for some of its peripherals, so creates
    its own clkdev entries. For all the other orion devices, create
    clkdev entries to the tclk. */
-void __init orion_clkdev_init(struct clk *tclk)
+void __init orion_clkdev_init(struct clk_core *tclk)
 {
 	orion_clkdev_add(NULL, "orion_spi.0", tclk);
 	orion_clkdev_add(NULL, "orion_spi.1", tclk);
@@ -78,10 +78,10 @@ static void fill_resources(struct platform_device *device,
 /*****************************************************************************
  * UART
  ****************************************************************************/
-static unsigned long __init uart_get_clk_rate(struct clk *clk)
+static unsigned long __init uart_get_clk_rate(struct clk_core *clk)
 {
-	clk_prepare_enable(clk);
-	return clk_get_rate(clk);
+	clk_provider_prepare_enable(clk);
+	return clk_provider_get_rate(clk);
 }
 
 static void __init uart_complete(
@@ -91,7 +91,7 @@ static void __init uart_complete(
 	void __iomem *membase,
 	resource_size_t mapbase,
 	unsigned int irq,
-	struct clk *clk)
+	struct clk_core *clk)
 {
 	data->mapbase = mapbase;
 	data->membase = membase;
@@ -125,7 +125,7 @@ static struct platform_device orion_uart0 = {
 void __init orion_uart0_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk)
+			     struct clk_core *clk)
 {
 	uart_complete(&orion_uart0, orion_uart0_data, orion_uart0_resources,
 		      membase, mapbase, irq, clk);
@@ -153,7 +153,7 @@ static struct platform_device orion_uart1 = {
 void __init orion_uart1_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk)
+			     struct clk_core *clk)
 {
 	uart_complete(&orion_uart1, orion_uart1_data, orion_uart1_resources,
 		      membase, mapbase, irq, clk);
@@ -181,7 +181,7 @@ static struct platform_device orion_uart2 = {
 void __init orion_uart2_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk)
+			     struct clk_core *clk)
 {
 	uart_complete(&orion_uart2, orion_uart2_data, orion_uart2_resources,
 		      membase, mapbase, irq, clk);
@@ -209,7 +209,7 @@ static struct platform_device orion_uart3 = {
 void __init orion_uart3_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk)
+			     struct clk_core *clk)
 {
 	uart_complete(&orion_uart3, orion_uart3_data, orion_uart3_resources,
 		      membase, mapbase, irq, clk);
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index d9a24f6..44f1bbe 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -18,22 +18,22 @@ struct mv_sata_platform_data;
 void __init orion_uart0_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk);
+			     struct clk_core *clk);
 
 void __init orion_uart1_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk);
+			     struct clk_core *clk);
 
 void __init orion_uart2_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk);
+			     struct clk_core *clk);
 
 void __init orion_uart3_init(void __iomem *membase,
 			     resource_size_t mapbase,
 			     unsigned int irq,
-			     struct clk *clk);
+			     struct clk_core *clk);
 
 void __init orion_rtc_init(unsigned long mapbase,
 			   unsigned long irq);
@@ -107,7 +107,7 @@ void __init orion_crypto_init(unsigned long mapbase,
 			      unsigned long irq);
 
 void __init orion_clkdev_add(const char *con_id, const char *dev_id,
-			     struct clk *clk);
+			     struct clk_core *clk);
 
-void __init orion_clkdev_init(struct clk *tclk);
+void __init orion_clkdev_init(struct clk_core *tclk);
 #endif
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 6eb614a..81afe83 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -70,7 +70,7 @@ enum {
 };
 
 /* data required for the OF clock provider registration */
-static struct clk *clks[MPC512x_CLK_LAST_PRIVATE];
+static struct clk_core *clks[MPC512x_CLK_LAST_PRIVATE];
 static struct clk_onecell_data clk_data;
 
 /* CCM register access */
@@ -218,12 +218,12 @@ static bool soc_has_mclk_mux0_canin(void)
 /* common clk API wrappers {{{ */
 
 /* convenience wrappers around the common clk API */
-static inline struct clk *mpc512x_clk_fixed(const char *name, int rate)
+static inline struct clk_core *mpc512x_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
 }
 
-static inline struct clk *mpc512x_clk_factor(
+static inline struct clk_core *mpc512x_clk_factor(
 	const char *name, const char *parent_name,
 	int mul, int div)
 {
@@ -234,7 +234,7 @@ static inline struct clk *mpc512x_clk_factor(
 					 mul, div);
 }
 
-static inline struct clk *mpc512x_clk_divider(
+static inline struct clk_core *mpc512x_clk_divider(
 	const char *name, const char *parent_name, u8 clkflags,
 	u32 __iomem *reg, u8 pos, u8 len, int divflags)
 {
@@ -242,7 +242,7 @@ static inline struct clk *mpc512x_clk_divider(
 				    reg, pos, len, divflags, &clklock);
 }
 
-static inline struct clk *mpc512x_clk_divtable(
+static inline struct clk_core *mpc512x_clk_divtable(
 	const char *name, const char *parent_name,
 	u32 __iomem *reg, u8 pos, u8 len,
 	const struct clk_div_table *divtab)
@@ -255,7 +255,7 @@ static inline struct clk *mpc512x_clk_divtable(
 					  divtab, &clklock);
 }
 
-static inline struct clk *mpc512x_clk_gated(
+static inline struct clk_core *mpc512x_clk_gated(
 	const char *name, const char *parent_name,
 	u32 __iomem *reg, u8 pos)
 {
@@ -266,7 +266,7 @@ static inline struct clk *mpc512x_clk_gated(
 				 reg, pos, 0, &clklock);
 }
 
-static inline struct clk *mpc512x_clk_muxed(const char *name,
+static inline struct clk_core *mpc512x_clk_muxed(const char *name,
 	const char **parent_names, int parent_count,
 	u32 __iomem *reg, u8 pos, u8 len)
 {
@@ -422,7 +422,7 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
 					int *sys_mul, int *sys_div,
 					int *ips_div)
 {
-	struct clk *osc_clk;
+	struct clk_core *osc_clk;
 	int calc_freq;
 
 	/* fetch mul/div factors from the hardware */
@@ -432,7 +432,7 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
 	*ips_div = get_bit_field(&clkregs->scfr1, 23, 3);
 
 	/* lookup the oscillator clock for its rate */
-	osc_clk = of_clk_get_by_name(np, "osc");
+	osc_clk = of_clk_provider_get_by_name(np, "osc");
 
 	/*
 	 * either descend from OSC to REF (and in bypassing verify the
@@ -444,7 +444,7 @@ static void mpc512x_clk_setup_ref_clock(struct device_node *np, int bus_freq,
 	 */
 	if (!IS_ERR(osc_clk)) {
 		clks[MPC512x_CLK_REF] = mpc512x_clk_factor("ref", "osc", 1, 1);
-		calc_freq = clk_get_rate(clks[MPC512x_CLK_REF]);
+		calc_freq = clk_provider_get_rate(clks[MPC512x_CLK_REF]);
 		calc_freq *= *sys_mul;
 		calc_freq /= *sys_div;
 		calc_freq /= 2;
@@ -647,8 +647,8 @@ static void mpc512x_clk_setup_mclk(struct mclk_setup_data *entry, size_t idx)
 	 * - MCLK 0 enabled
 	 * - MCLK 1 from MCLK DIV
 	 */
-	div = clk_get_rate(clks[MPC512x_CLK_SYS]);
-	div /= clk_get_rate(clks[MPC512x_CLK_IPS]);
+	div = clk_provider_get_rate(clks[MPC512x_CLK_SYS]);
+	div /= clk_provider_get_rate(clks[MPC512x_CLK_IPS]);
 	out_be32(mccr_reg, (0 << 16));
 	out_be32(mccr_reg, (0 << 16) | ((div - 1) << 17));
 	out_be32(mccr_reg, (1 << 16) | ((div - 1) << 17));
@@ -925,12 +925,12 @@ static void mpc512x_clk_setup_clock_tree(struct device_node *np, int busfreq)
 	 * claimed by any peripheral driver, to not have the clock
 	 * subsystem disable them late at startup
 	 */
-	clk_prepare_enable(clks[MPC512x_CLK_DUMMY]);
-	clk_prepare_enable(clks[MPC512x_CLK_E300]);	/* PowerPC CPU */
-	clk_prepare_enable(clks[MPC512x_CLK_DDR]);	/* DRAM */
-	clk_prepare_enable(clks[MPC512x_CLK_MEM]);	/* SRAM */
-	clk_prepare_enable(clks[MPC512x_CLK_IPS]);	/* SoC periph */
-	clk_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_DUMMY]);
+	clk_provider_prepare_enable(clks[MPC512x_CLK_E300]);	/* PowerPC CPU */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_DDR]);	/* DRAM */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_MEM]);	/* SRAM */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_IPS]);	/* SoC periph */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_LPC]);	/* boot media */
 }
 
 /*
@@ -969,9 +969,9 @@ static void mpc5121_clk_provide_migration_support(void)
 	 * has attached to bridges, otherwise the PCI clock remains
 	 * unused and so it gets disabled
 	 */
-	clk_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
+	clk_provider_prepare_enable(clks[MPC512x_CLK_PSC3_MCLK]);/* serial console */
 	if (of_find_compatible_node(NULL, "pci", "fsl,mpc5121-pci"))
-		clk_prepare_enable(clks[MPC512x_CLK_PCI]);
+		clk_provider_prepare_enable(clks[MPC512x_CLK_PCI]);
 }
 
 /*
@@ -988,8 +988,8 @@ static void mpc5121_clk_provide_migration_support(void)
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
-	struct clk *clk; \
-	clk = of_clk_get_by_name(np, clkname); \
+	struct clk_core *clk; \
+	clk = of_clk_provider_get_by_name(np, clkname); \
 	if (IS_ERR(clk)) { \
 		clk = clkitem; \
 		clk_register_clkdev(clk, clkname, devname); \
@@ -999,7 +999,7 @@ static void mpc5121_clk_provide_migration_support(void)
 		pr_debug("clock alias name '%s' for dev '%s' pointer %p\n", \
 			 clkname, devname, clk); \
 	} else { \
-		clk_put(clk); \
+		__clk_put(clk); \
 	} \
 } while (0)
 
@@ -1090,7 +1090,7 @@ static void mpc5121_clk_provide_backwards_compat(void)
 	 * workaround obsolete
 	 */
 	if (did_register & DID_REG_I2C)
-		clk_prepare_enable(clks[MPC512x_CLK_I2C]);
+		clk_provider_prepare_enable(clks[MPC512x_CLK_I2C]);
 
 	FOR_NODES("fsl,mpc5121-diu") {
 		NODE_PREP;
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 7333061..939c4b7 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -138,7 +138,7 @@ static const struct clk_ops main_osc_ops = {
 	.is_prepared = clk_main_osc_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_main_osc(struct at91_pmc *pmc,
 			   unsigned int irq,
 			   const char *name,
@@ -147,7 +147,7 @@ at91_clk_register_main_osc(struct at91_pmc *pmc,
 {
 	int ret;
 	struct clk_main_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !irq || !name || !parent_name)
@@ -192,7 +192,7 @@ at91_clk_register_main_osc(struct at91_pmc *pmc,
 void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np,
 					     struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int irq;
 	const char *name = np->name;
 	const char *parent_name;
@@ -291,7 +291,7 @@ static const struct clk_ops main_rc_osc_ops = {
 	.recalc_accuracy = clk_main_rc_osc_recalc_accuracy,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 			      unsigned int irq,
 			      const char *name,
@@ -299,7 +299,7 @@ at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 {
 	int ret;
 	struct clk_main_rc_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !irq || !name || !frequency)
@@ -340,7 +340,7 @@ at91_clk_register_main_rc_osc(struct at91_pmc *pmc,
 void __init of_at91sam9x5_clk_main_rc_osc_setup(struct device_node *np,
 						struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int irq;
 	u32 frequency = 0;
 	u32 accuracy = 0;
@@ -423,13 +423,13 @@ static const struct clk_ops rm9200_main_ops = {
 	.recalc_rate = clk_rm9200_main_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_rm9200_main(struct at91_pmc *pmc,
 			      const char *name,
 			      const char *parent_name)
 {
 	struct clk_rm9200_main *clkmain;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !name)
@@ -461,7 +461,7 @@ at91_clk_register_rm9200_main(struct at91_pmc *pmc,
 void __init of_at91rm9200_clk_main_setup(struct device_node *np,
 					 struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 
@@ -554,7 +554,7 @@ static const struct clk_ops sam9x5_main_ops = {
 	.get_parent = clk_sam9x5_main_get_parent,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 			      unsigned int irq,
 			      const char *name,
@@ -563,7 +563,7 @@ at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 {
 	int ret;
 	struct clk_sam9x5_main *clkmain;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !irq || !name)
@@ -606,7 +606,7 @@ at91_clk_register_sam9x5_main(struct at91_pmc *pmc,
 void __init of_at91sam9x5_clk_main_setup(struct device_node *np,
 					 struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_names[2];
 	int num_parents;
 	unsigned int irq;
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index c1af80b..95ae1b6 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -131,7 +131,7 @@ static const struct clk_ops master_ops = {
 	.get_parent = clk_master_get_parent,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
 		const char *name, int num_parents,
 		const char **parent_names,
@@ -140,7 +140,7 @@ at91_clk_register_master(struct at91_pmc *pmc, unsigned int irq,
 {
 	int ret;
 	struct clk_master *master;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !irq || !name || !num_parents || !parent_names)
@@ -216,7 +216,7 @@ static void __init
 of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
 			 const struct clk_master_layout *layout)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int num_parents;
 	int i;
 	unsigned int irq;
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 597fed4..cdf8e8a 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -100,12 +100,12 @@ static const struct clk_ops peripheral_ops = {
 	.is_enabled = clk_peripheral_is_enabled,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_peripheral(struct at91_pmc *pmc, const char *name,
 			     const char *parent_name, u32 id)
 {
 	struct clk_peripheral *periph;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !name || !parent_name || id > PERIPHERAL_ID_MAX)
@@ -134,7 +134,7 @@ at91_clk_register_peripheral(struct at91_pmc *pmc, const char *name,
 
 static void clk_sam9x5_peripheral_autodiv(struct clk_sam9x5_peripheral *periph)
 {
-	struct clk *parent;
+	struct clk_core *parent;
 	unsigned long parent_rate;
 	int shift = 0;
 
@@ -309,13 +309,13 @@ static const struct clk_ops sam9x5_peripheral_ops = {
 	.set_rate = clk_sam9x5_peripheral_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_sam9x5_peripheral(struct at91_pmc *pmc, const char *name,
 				    const char *parent_name, u32 id,
 				    const struct clk_range *range)
 {
 	struct clk_sam9x5_peripheral *periph;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !name || !parent_name)
@@ -352,7 +352,7 @@ of_at91_clk_periph_setup(struct device_node *np, struct at91_pmc *pmc, u8 type)
 {
 	int num;
 	u32 id;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name;
 	struct device_node *periphclknp;
diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index cf6ed02..0d22f65f 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -297,14 +297,14 @@ static const struct clk_ops pll_ops = {
 	.set_rate = clk_pll_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_pll(struct at91_pmc *pmc, unsigned int irq, const char *name,
 		      const char *parent_name, u8 id,
 		      const struct clk_pll_layout *layout,
 		      const struct clk_pll_characteristics *characteristics)
 {
 	struct clk_pll *pll;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 	int ret;
 	int offset = PLL_REG(id);
@@ -474,7 +474,7 @@ of_at91_clk_pll_setup(struct device_node *np, struct at91_pmc *pmc,
 {
 	u32 id;
 	unsigned int irq;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 	struct clk_pll_characteristics *characteristics;
diff --git a/drivers/clk/at91/clk-plldiv.c b/drivers/clk/at91/clk-plldiv.c
index ea22656..f8204d8 100644
--- a/drivers/clk/at91/clk-plldiv.c
+++ b/drivers/clk/at91/clk-plldiv.c
@@ -79,12 +79,12 @@ static const struct clk_ops plldiv_ops = {
 	.set_rate = clk_plldiv_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_plldiv(struct at91_pmc *pmc, const char *name,
 			 const char *parent_name)
 {
 	struct clk_plldiv *plldiv;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	plldiv = kzalloc(sizeof(*plldiv), GFP_KERNEL);
@@ -111,7 +111,7 @@ at91_clk_register_plldiv(struct at91_pmc *pmc, const char *name,
 static void __init
 of_at91_clk_plldiv_setup(struct device_node *np, struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 62e2509..b72e98c 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -57,9 +57,9 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 static long clk_programmable_determine_rate(struct clk_hw *hw,
 					    unsigned long rate,
 					    unsigned long *best_parent_rate,
-					    struct clk **best_parent_clk)
+					    struct clk_core **best_parent_clk)
 {
-	struct clk *parent = NULL;
+	struct clk_core *parent = NULL;
 	long best_rate = -EINVAL;
 	unsigned long parent_rate;
 	unsigned long tmp_rate;
@@ -169,14 +169,14 @@ static const struct clk_ops programmable_ops = {
 	.set_rate = clk_programmable_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_programmable(struct at91_pmc *pmc,
 			       const char *name, const char **parent_names,
 			       u8 num_parents, u8 id,
 			       const struct clk_programmable_layout *layout)
 {
 	struct clk_programmable *prog;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (id > PROG_ID_MAX)
@@ -229,7 +229,7 @@ of_at91_clk_prog_setup(struct device_node *np, struct at91_pmc *pmc,
 	int num;
 	u32 id;
 	int i;
-	struct clk *clk;
+	struct clk_core *clk;
 	int num_parents;
 	const char *parent_names[PROG_SOURCE_MAX];
 	const char *name;
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 0300c46..d50fe02 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -117,7 +117,7 @@ static const struct clk_ops slow_osc_ops = {
 	.is_prepared = clk_slow_osc_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_slow_osc(void __iomem *sckcr,
 			   const char *name,
 			   const char *parent_name,
@@ -125,7 +125,7 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 			   bool bypass)
 {
 	struct clk_slow_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!sckcr || !name || !parent_name)
@@ -159,7 +159,7 @@ at91_clk_register_slow_osc(void __iomem *sckcr,
 void __init of_at91sam9x5_clk_slow_osc_setup(struct device_node *np,
 					     void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 	u32 startup;
@@ -229,7 +229,7 @@ static const struct clk_ops slow_rc_osc_ops = {
 	.recalc_accuracy = clk_slow_rc_osc_recalc_accuracy,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      const char *name,
 			      unsigned long frequency,
@@ -237,7 +237,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 			      unsigned long startup)
 {
 	struct clk_slow_rc_osc *osc;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!sckcr || !name)
@@ -269,7 +269,7 @@ at91_clk_register_slow_rc_osc(void __iomem *sckcr,
 void __init of_at91sam9x5_clk_slow_rc_osc_setup(struct device_node *np,
 						void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 frequency = 0;
 	u32 accuracy = 0;
 	u32 startup = 0;
@@ -327,14 +327,14 @@ static const struct clk_ops sam9x5_slow_ops = {
 	.get_parent = clk_sam9x5_slow_get_parent,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 			      const char *name,
 			      const char **parent_names,
 			      int num_parents)
 {
 	struct clk_sam9x5_slow *slowck;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!sckcr || !name || !parent_names || !num_parents)
@@ -364,7 +364,7 @@ at91_clk_register_sam9x5_slow(void __iomem *sckcr,
 void __init of_at91sam9x5_clk_slow_setup(struct device_node *np,
 					 void __iomem *sckcr)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_names[2];
 	int num_parents;
 	const char *name = np->name;
@@ -401,14 +401,14 @@ static const struct clk_ops sam9260_slow_ops = {
 	.get_parent = clk_sam9260_slow_get_parent,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 			       const char *name,
 			       const char **parent_names,
 			       int num_parents)
 {
 	struct clk_sam9260_slow *slowck;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	if (!pmc || !name)
@@ -440,7 +440,7 @@ at91_clk_register_sam9260_slow(struct at91_pmc *pmc,
 void __init of_at91sam9260_clk_slow_setup(struct device_node *np,
 					  struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_names[2];
 	int num_parents;
 	const char *name = np->name;
diff --git a/drivers/clk/at91/clk-smd.c b/drivers/clk/at91/clk-smd.c
index 144d47e..8820b84 100644
--- a/drivers/clk/at91/clk-smd.c
+++ b/drivers/clk/at91/clk-smd.c
@@ -113,12 +113,12 @@ static const struct clk_ops at91sam9x5_smd_ops = {
 	.set_rate = at91sam9x5_clk_smd_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91sam9x5_clk_register_smd(struct at91_pmc *pmc, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_smd *smd;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	smd = kzalloc(sizeof(*smd), GFP_KERNEL);
@@ -144,7 +144,7 @@ at91sam9x5_clk_register_smd(struct at91_pmc *pmc, const char *name,
 void __init of_at91sam9x5_clk_smd_setup(struct device_node *np,
 					struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 	int num_parents;
 	const char *parent_names[SMD_SOURCE_MAX];
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 8c96307..770d9bf 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -99,12 +99,12 @@ static const struct clk_ops system_ops = {
 	.is_prepared = clk_system_is_prepared,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_system(struct at91_pmc *pmc, const char *name,
 			 const char *parent_name, u8 id, int irq)
 {
 	struct clk_system *sys;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 	int ret;
 
@@ -153,7 +153,7 @@ of_at91_clk_sys_setup(struct device_node *np, struct at91_pmc *pmc)
 	int num;
 	int irq = 0;
 	u32 id;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *name;
 	struct device_node *sysclknp;
 	const char *parent_name;
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 7d1d26a..246989c 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -162,12 +162,12 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
 			    const char **parent_names, u8 num_parents)
 {
 	struct at91sam9x5_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -190,12 +190,12 @@ at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	return clk;
 }
 
-static struct clk * __init
+static struct clk_core * __init
 at91sam9n12_clk_register_usb(struct at91_pmc *pmc, const char *name,
 			     const char *parent_name)
 {
 	struct at91sam9x5_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -295,12 +295,12 @@ static const struct clk_ops at91rm9200_usb_ops = {
 	.set_rate = at91rm9200_clk_usb_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
 			    const char *parent_name, const u32 *divisors)
 {
 	struct at91rm9200_clk_usb *usb;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
@@ -327,7 +327,7 @@ at91rm9200_clk_register_usb(struct at91_pmc *pmc, const char *name,
 void __init of_at91sam9x5_clk_usb_setup(struct device_node *np,
 					struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 	int num_parents;
 	const char *parent_names[USB_SOURCE_MAX];
@@ -355,7 +355,7 @@ void __init of_at91sam9x5_clk_usb_setup(struct device_node *np,
 void __init of_at91sam9n12_clk_usb_setup(struct device_node *np,
 					 struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 
@@ -375,7 +375,7 @@ void __init of_at91sam9n12_clk_usb_setup(struct device_node *np,
 void __init of_at91rm9200_clk_usb_setup(struct device_node *np,
 					struct at91_pmc *pmc)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 	u32 divisors[4] = {0, 0, 0, 0};
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index ae3263b..0502050 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -92,13 +92,13 @@ static const struct clk_ops utmi_ops = {
 	.recalc_rate = clk_utmi_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 at91_clk_register_utmi(struct at91_pmc *pmc, unsigned int irq,
 		       const char *name, const char *parent_name)
 {
 	int ret;
 	struct clk_utmi *utmi;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 	struct clk_init_data init;
 
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
@@ -132,7 +132,7 @@ static void __init
 of_at91_clk_utmi_setup(struct device_node *np, struct at91_pmc *pmc)
 {
 	unsigned int irq;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	const char *name = np->name;
 
diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index e5aeded..122e7b0 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -697,7 +697,7 @@ static void bcm_clk_teardown(struct kona_clk *bcm_clk)
 	bcm_clk->type = bcm_clk_none;
 }
 
-static void kona_clk_teardown(struct clk *clk)
+static void kona_clk_teardown(struct clk_core *clk)
 {
 	struct clk_hw *hw;
 	struct kona_clk *bcm_clk;
@@ -716,10 +716,10 @@ static void kona_clk_teardown(struct clk *clk)
 	bcm_clk_teardown(bcm_clk);
 }
 
-struct clk *kona_clk_setup(struct kona_clk *bcm_clk)
+struct clk_core *kona_clk_setup(struct kona_clk *bcm_clk)
 {
 	struct clk_init_data *init_data = &bcm_clk->init_data;
-	struct clk *clk = NULL;
+	struct clk_core *clk = NULL;
 
 	switch (bcm_clk->type) {
 	case bcm_clk_peri:
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 95af2e6..a301aa9 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1032,11 +1032,11 @@ static long kona_peri_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *best_parent_rate, struct clk **best_parent)
+		unsigned long *best_parent_rate, struct clk_core **best_parent)
 {
 	struct kona_clk *bcm_clk = to_kona_clk(hw);
-	struct clk *clk = hw->clk;
-	struct clk *current_parent;
+	struct clk_core *clk = hw->clk;
+	struct clk_core *current_parent;
 	unsigned long parent_rate;
 	unsigned long best_delta;
 	unsigned long best_rate;
@@ -1053,14 +1053,14 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 		return kona_peri_clk_round_rate(hw, rate, best_parent_rate);
 
 	/* Unless we can do better, stick with current parent */
-	current_parent = clk_get_parent(clk);
+	current_parent = clk_provider_get_parent(clk);
 	parent_rate = __clk_get_rate(current_parent);
 	best_rate = kona_peri_clk_round_rate(hw, rate, &parent_rate);
 	best_delta = abs(best_rate - rate);
 
 	/* Check whether any other parent clock can produce a better result */
 	for (which = 0; which < parent_count; which++) {
-		struct clk *parent = clk_get_parent_by_index(clk, which);
+		struct clk_core *parent = clk_get_parent_by_index(clk, which);
 		unsigned long delta;
 		unsigned long other_rate;
 
@@ -1260,7 +1260,7 @@ bool __init kona_ccu_init(struct ccu_data *ccu)
 {
 	unsigned long flags;
 	unsigned int which;
-	struct clk **clks = ccu->clk_data.clks;
+	struct clk_core **clks = ccu->clk_data.clks;
 	bool success = true;
 
 	flags = ccu_lock(ccu);
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index 2537b30..c2d0152 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -508,7 +508,7 @@ extern u64 scaled_div_max(struct bcm_clk_div *div);
 extern u64 scaled_div_build(struct bcm_clk_div *div, u32 div_value,
 				u32 billionths);
 
-extern struct clk *kona_clk_setup(struct kona_clk *bcm_clk);
+extern struct clk_core *kona_clk_setup(struct kona_clk *bcm_clk);
 extern void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 				struct device_node *node);
 extern bool __init kona_ccu_init(struct ccu_data *ccu);
diff --git a/drivers/clk/berlin/berlin2-avpll.c b/drivers/clk/berlin/berlin2-avpll.c
index fd0f26c..488d986 100644
--- a/drivers/clk/berlin/berlin2-avpll.c
+++ b/drivers/clk/berlin/berlin2-avpll.c
@@ -188,7 +188,7 @@ static const struct clk_ops berlin2_avpll_vco_ops = {
 	.recalc_rate	= berlin2_avpll_vco_recalc_rate,
 };
 
-struct clk * __init berlin2_avpll_vco_register(void __iomem *base,
+struct clk_core * __init berlin2_avpll_vco_register(void __iomem *base,
 			       const char *name, const char *parent_name,
 			       u8 vco_flags, unsigned long flags)
 {
@@ -364,7 +364,7 @@ static const struct clk_ops berlin2_avpll_channel_ops = {
  */
 static const u8 quirk_index[] __initconst = { 0, 6, 5, 4, 3, 2, 1, 7 };
 
-struct clk * __init berlin2_avpll_channel_register(void __iomem *base,
+struct clk_core * __init berlin2_avpll_channel_register(void __iomem *base,
 			   const char *name, u8 index, const char *parent_name,
 			   u8 ch_flags, unsigned long flags)
 {
diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
index a37f506..216eee7 100644
--- a/drivers/clk/berlin/berlin2-avpll.h
+++ b/drivers/clk/berlin/berlin2-avpll.h
@@ -24,11 +24,11 @@ struct clk;
 #define BERLIN2_AVPLL_BIT_QUIRK		BIT(0)
 #define BERLIN2_AVPLL_SCRAMBLE_QUIRK	BIT(1)
 
-struct clk * __init
+struct clk_core * __init
 berlin2_avpll_vco_register(void __iomem *base, const char *name,
 	   const char *parent_name, u8 vco_flags, unsigned long flags);
 
-struct clk * __init
+struct clk_core * __init
 berlin2_avpll_channel_register(void __iomem *base, const char *name,
 		       u8 index, const char *parent_name, u8 ch_flags,
 		       unsigned long flags);
diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index 81ff97f..c673082 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -234,7 +234,7 @@ static const struct clk_ops berlin2_div_mux_ops = {
 	.get_parent	= berlin2_div_get_parent,
 };
 
-struct clk * __init
+struct clk_core * __init
 berlin2_div_register(const struct berlin2_div_map *map,
 		     void __iomem *base, const char *name, u8 div_flags,
 		     const char **parent_names, int num_parents,
diff --git a/drivers/clk/berlin/berlin2-div.h b/drivers/clk/berlin/berlin2-div.h
index 15e3384..3ddb87a 100644
--- a/drivers/clk/berlin/berlin2-div.h
+++ b/drivers/clk/berlin/berlin2-div.h
@@ -80,7 +80,7 @@ struct berlin2_div_data {
 	u8 div_flags;
 };
 
-struct clk * __init
+struct clk_core * __init
 berlin2_div_register(const struct berlin2_div_map *map,
 	     void __iomem *base,  const char *name, u8 div_flags,
 	     const char **parent_names, int num_parents,
diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
index bdc506b..b7a3016 100644
--- a/drivers/clk/berlin/berlin2-pll.c
+++ b/drivers/clk/berlin/berlin2-pll.c
@@ -91,7 +91,7 @@ static const struct clk_ops berlin2_pll_ops = {
 	.recalc_rate	= berlin2_pll_recalc_rate,
 };
 
-struct clk * __init
+struct clk_core * __init
 berlin2_pll_register(const struct berlin2_pll_map *map,
 		     void __iomem *base, const char *name,
 		     const char *parent_name, unsigned long flags)
diff --git a/drivers/clk/berlin/berlin2-pll.h b/drivers/clk/berlin/berlin2-pll.h
index 8831ce2..6b6a6ed 100644
--- a/drivers/clk/berlin/berlin2-pll.h
+++ b/drivers/clk/berlin/berlin2-pll.h
@@ -29,7 +29,7 @@ struct berlin2_pll_map {
 	u8 divsel_shift;
 };
 
-struct clk * __init
+struct clk_core * __init
 berlin2_pll_register(const struct berlin2_pll_map *map,
 		     void __iomem *base, const char *name,
 		     const char *parent_name, unsigned long flags);
diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 4c81e09..1329721 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -93,7 +93,7 @@
  */
 
 #define	MAX_CLKS 41
-static struct clk *clks[MAX_CLKS];
+static struct clk_core *clks[MAX_CLKS];
 static struct clk_onecell_data clk_data;
 static DEFINE_SPINLOCK(lock);
 static void __iomem *gbase;
@@ -504,7 +504,7 @@ static const struct berlin2_gate_data bg2_gates[] __initconst = {
 static void __init berlin2_clock_setup(struct device_node *np)
 {
 	const char *parent_names[9];
-	struct clk *clk;
+	struct clk_core *clk;
 	u8 avpll_flags = 0;
 	int n;
 
@@ -513,16 +513,16 @@ static void __init berlin2_clock_setup(struct device_node *np)
 		return;
 
 	/* overwrite default clock names with DT provided ones */
-	clk = of_clk_get_by_name(np, clk_names[REFCLK]);
+	clk = of_clk_provider_get_by_name(np, clk_names[REFCLK]);
 	if (!IS_ERR(clk)) {
 		clk_names[REFCLK] = __clk_get_name(clk);
-		clk_put(clk);
+		__clk_put(clk);
 	}
 
-	clk = of_clk_get_by_name(np, clk_names[VIDEO_EXT0]);
+	clk = of_clk_provider_get_by_name(np, clk_names[VIDEO_EXT0]);
 	if (!IS_ERR(clk)) {
 		clk_names[VIDEO_EXT0] = __clk_get_name(clk);
-		clk_put(clk);
+		__clk_put(clk);
 	}
 
 	/* simple register PLLs */
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 748da9b..0b251bd 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -47,7 +47,7 @@
 #define REG_SDIO1XIN_CLKCTL	0x015c
 
 #define	MAX_CLKS 27
-static struct clk *clks[MAX_CLKS];
+static struct clk_core *clks[MAX_CLKS];
 static struct clk_onecell_data clk_data;
 static DEFINE_SPINLOCK(lock);
 static void __iomem *gbase;
@@ -293,7 +293,7 @@ static const struct berlin2_gate_data bg2q_gates[] __initconst = {
 static void __init berlin2q_clock_setup(struct device_node *np)
 {
 	const char *parent_names[9];
-	struct clk *clk;
+	struct clk_core *clk;
 	int n;
 
 	gbase = of_iomap(np, 0);
@@ -311,10 +311,10 @@ static void __init berlin2q_clock_setup(struct device_node *np)
 	}
 
 	/* overwrite default clock names with DT provided ones */
-	clk = of_clk_get_by_name(np, clk_names[REFCLK]);
+	clk = of_clk_provider_get_by_name(np, clk_names[REFCLK]);
 	if (!IS_ERR(clk)) {
 		clk_names[REFCLK] = __clk_get_name(clk);
-		clk_put(clk);
+		__clk_put(clk);
 	}
 
 	/* simple register PLLs */
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 1127ee4..4b64834 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -489,7 +489,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	const char *parent_name;
 	const char *clk_name;
 	struct resource *mem;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index d2f1e11..3dc6e58 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -532,7 +532,7 @@ MODULE_DEVICE_TABLE(of, axmclk_match_table);
 
 struct axmclk_priv {
 	struct clk_onecell_data onecell;
-	struct clk *clks[];
+	struct clk_core *clks[];
 };
 
 static int axmclk_probe(struct platform_device *pdev)
@@ -541,7 +541,7 @@ static int axmclk_probe(struct platform_device *pdev)
 	struct resource *res;
 	int i, ret;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct regmap *regmap;
 	size_t num_clks;
 	struct axmclk_priv *priv;
diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index 6b950ca..f25e85e 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -29,7 +29,7 @@
  */
 void __init bcm2835_init_clocks(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int ret;
 
 	clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 57a078e..e505693 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -57,7 +57,7 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 
 static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_p)
+					struct clk_core **best_parent_p)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
 	const struct clk_ops *rate_ops = composite->rate_ops;
@@ -136,14 +136,14 @@ static void clk_composite_disable(struct clk_hw *hw)
 	gate_ops->disable(gate_hw);
 }
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk_core *clk_register_composite(struct device *dev, const char *name,
 			const char **parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 			unsigned long flags)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	struct clk_composite *composite;
 	struct clk_ops *clk_composite_ops;
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 18a9de2..3c78139 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -366,14 +366,14 @@ const struct clk_ops clk_divider_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 
-static struct clk *_register_divider(struct device *dev, const char *name,
+static struct clk_core *_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
 {
 	struct clk_divider *div;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -429,7 +429,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
  * @clk_divider_flags: divider-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_divider(struct device *dev, const char *name,
+struct clk_core *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock)
@@ -453,7 +453,7 @@ EXPORT_SYMBOL_GPL(clk_register_divider);
  * @table: array of divider/value pairs ending with a div set to 0
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_divider_table(struct device *dev, const char *name,
+struct clk_core *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
diff --git a/drivers/clk/clk-efm32gg.c b/drivers/clk/clk-efm32gg.c
index bac2ddf..26e0485 100644
--- a/drivers/clk/clk-efm32gg.c
+++ b/drivers/clk/clk-efm32gg.c
@@ -16,7 +16,7 @@
 
 #define CMU_HFPERCLKEN0		0x44
 
-static struct clk *clk[37];
+static struct clk_core *clk[37];
 static struct clk_onecell_data clk_data = {
 	.clks = clk,
 	.clk_num = ARRAY_SIZE(clk),
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index d9e3f67..ae1fef0 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -65,13 +65,13 @@ struct clk_ops clk_fixed_factor_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk_core *clk_register_fixed_factor(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	struct clk_fixed_factor *fix;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
 	if (!fix) {
@@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_factor);
  */
 void __init of_fixed_factor_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
 	u32 div, mult;
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 0fc56ab..56c0ced 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -56,12 +56,12 @@ EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
  * @fixed_rate: non-adjustable clock rate
  * @fixed_accuracy: non-adjustable clock rate
  */
-struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
+struct clk_core *clk_register_fixed_rate_with_accuracy(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy)
 {
 	struct clk_fixed_rate *fixed;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/* allocate fixed-rate clock */
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_rate_with_accuracy);
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
-struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
+struct clk_core *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
 {
@@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
  */
 void of_fixed_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	u32 rate;
 	u32 accuracy = 0;
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index ede685c..8104683 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -96,14 +96,14 @@ const struct clk_ops clk_fractional_divider_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 
-struct clk *clk_register_fractional_divider(struct device *dev,
+struct clk_core *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
 		u8 clk_divider_flags, spinlock_t *lock)
 {
 	struct clk_fractional_divider *fd;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
 	if (!fd) {
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4a58c55..429d302 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -118,13 +118,13 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk_core *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_gate *gate;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 2e7e9d9..cad2fba 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -271,10 +271,10 @@ static const struct clk_ops periclk_ops = {
 	.set_rate = clk_periclk_set_rate,
 };
 
-static __init struct clk *hb_clk_init(struct device_node *node, const struct clk_ops *ops)
+static __init struct clk_core *hb_clk_init(struct device_node *node, const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct hb_clk *hb_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
@@ -330,8 +330,8 @@ CLK_OF_DECLARE(hb_a9periph, "calxeda,hb-a9periph-clock", hb_a9periph_init);
 
 static void __init hb_a9bus_init(struct device_node *node)
 {
-	struct clk *clk = hb_clk_init(node, &a9bclk_ops);
-	clk_prepare_enable(clk);
+	struct clk_core *clk = hb_clk_init(node, &a9bclk_ops);
+	clk_provider_prepare_enable(clk);
 }
 CLK_OF_DECLARE(hb_a9bus, "calxeda,hb-a9bus-clock", hb_a9bus_init);
 
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/clk-ls1x.c
index f20b750..796043c 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/clk-ls1x.c
@@ -48,11 +48,11 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static struct clk * __init clk_register_pll(struct device *dev,
+static struct clk_core * __init clk_register_pll(struct device *dev,
 	 const char *name, const char *parent_name, unsigned long flags)
 {
 	struct clk_hw *hw;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/* allocate the divider */
@@ -80,32 +80,32 @@ static struct clk * __init clk_register_pll(struct device *dev,
 
 void __init ls1x_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = clk_register_pll(NULL, "pll_clk", NULL, CLK_IS_ROOT);
-	clk_prepare_enable(clk);
+	clk_provider_prepare_enable(clk);
 
 	clk = clk_register_divider(NULL, "cpu_clk", "pll_clk",
 			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_CPU_SHIFT,
 			DIV_CPU_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
+	clk_provider_prepare_enable(clk);
 	clk_register_clkdev(clk, "cpu", NULL);
 
 	clk = clk_register_divider(NULL, "dc_clk", "pll_clk",
 			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
 			DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
+	clk_provider_prepare_enable(clk);
 	clk_register_clkdev(clk, "dc", NULL);
 
 	clk = clk_register_divider(NULL, "ahb_clk", "pll_clk",
 			CLK_SET_RATE_PARENT, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
 			DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_prepare_enable(clk);
+	clk_provider_prepare_enable(clk);
 	clk_register_clkdev(clk, "ahb", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
 
 	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1, 2);
-	clk_prepare_enable(clk);
+	clk_provider_prepare_enable(clk);
 	clk_register_clkdev(clk, "apb", NULL);
 	clk_register_clkdev(clk, "serial8250", NULL);
 }
diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 3d7e8dd..42fa43a 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -112,10 +112,10 @@ static struct clk_init_data max77686_clks_init[MAX77686_CLKS_NUM] = {
 	},
 };
 
-static struct clk *max77686_clk_register(struct device *dev,
+static struct clk_core *max77686_clk_register(struct device *dev,
 				struct max77686_clk *max77686)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_hw *hw = &max77686->hw;
 
 	clk = clk_register(dev, hw);
@@ -138,10 +138,10 @@ static int max77686_clk_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
 	struct max77686_clk *max77686_clks[MAX77686_CLKS_NUM];
-	struct clk **clocks;
+	struct clk_core **clocks;
 	int i, ret;
 
-	clocks = devm_kzalloc(&pdev->dev, sizeof(struct clk *)
+	clocks = devm_kzalloc(&pdev->dev, sizeof(struct clk_core *)
 					* MAX77686_CLKS_NUM, GFP_KERNEL);
 	if (!clocks)
 		return -ENOMEM;
@@ -203,7 +203,7 @@ err_clocks:
 static int max77686_clk_remove(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
-	struct clk **clocks = platform_get_drvdata(pdev);
+	struct clk_core **clocks = platform_get_drvdata(pdev);
 	int i;
 
 	if (iodev->dev->of_node)
diff --git a/drivers/clk/clk-moxart.c b/drivers/clk/clk-moxart.c
index 30a3b69..c503c09 100644
--- a/drivers/clk/clk-moxart.c
+++ b/drivers/clk/clk-moxart.c
@@ -18,7 +18,7 @@
 void __init moxart_of_pll_clk_init(struct device_node *node)
 {
 	static void __iomem *base;
-	struct clk *clk, *ref_clk;
+	struct clk_core *clk, *ref_clk;
 	unsigned int mul;
 	const char *name = node->name;
 	const char *parent_name;
@@ -35,7 +35,7 @@ void __init moxart_of_pll_clk_init(struct device_node *node)
 	mul = readl(base + 0x30) >> 3 & 0x3f;
 	iounmap(base);
 
-	ref_clk = of_clk_get(node, 0);
+	ref_clk = of_clk_provider_get(node, 0);
 	if (IS_ERR(ref_clk)) {
 		pr_err("%s: of_clk_get failed\n", node->full_name);
 		return;
@@ -56,7 +56,7 @@ CLK_OF_DECLARE(moxart_pll_clock, "moxa,moxart-pll-clock",
 void __init moxart_of_apb_clk_init(struct device_node *node)
 {
 	static void __iomem *base;
-	struct clk *clk, *pll_clk;
+	struct clk_core *clk, *pll_clk;
 	unsigned int div, val;
 	unsigned int div_idx[] = { 2, 3, 4, 6, 8};
 	const char *name = node->name;
@@ -78,7 +78,7 @@ void __init moxart_of_apb_clk_init(struct device_node *node)
 		val = 0;
 	div = div_idx[val] * 2;
 
-	pll_clk = of_clk_get(node, 0);
+	pll_clk = of_clk_provider_get(node, 0);
 	if (IS_ERR(pll_clk)) {
 		pr_err("%s: of_clk_get failed\n", node->full_name);
 		return;
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3..2879053 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -113,13 +113,13 @@ const struct clk_ops clk_mux_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk_core *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	u8 width = 0;
 
@@ -165,7 +165,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk_core *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_mux_flags, spinlock_t *lock)
diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
index 05e04ce..5d87366 100644
--- a/drivers/clk/clk-nomadik.c
+++ b/drivers/clk/clk-nomadik.c
@@ -254,11 +254,11 @@ static const struct clk_ops pll_clk_ops = {
 	.recalc_rate = pll_clk_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 pll_clk_register(struct device *dev, const char *name,
 		 const char *parent_name, u32 id)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_pll *pll;
 	struct clk_init_data init;
 
@@ -346,11 +346,11 @@ static const struct clk_ops src_clk_ops = {
 	.recalc_rate = src_clk_recalc_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 src_clk_register(struct device *dev, const char *name,
 		 const char *parent_name, u8 id)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_src *sclk;
 	struct clk_init_data init;
 
@@ -510,7 +510,7 @@ module_init(nomadik_src_clk_init_debugfs);
 
 static void __init of_nomadik_pll_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 	u32 pll_id;
@@ -533,7 +533,7 @@ CLK_OF_DECLARE(nomadik_pll_clk,
 
 static void __init of_nomadik_hclk_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 
@@ -557,7 +557,7 @@ CLK_OF_DECLARE(nomadik_hclk_clk,
 
 static void __init of_nomadik_src_clk_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 	u32 clk_id;
diff --git a/drivers/clk/clk-nspire.c b/drivers/clk/clk-nspire.c
index a378db7..e9c43f4 100644
--- a/drivers/clk/clk-nspire.c
+++ b/drivers/clk/clk-nspire.c
@@ -69,7 +69,7 @@ static void __init nspire_ahbdiv_setup(struct device_node *node,
 {
 	u32 val;
 	void __iomem *io;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
 	struct nspire_clk_info info;
@@ -111,7 +111,7 @@ static void __init nspire_clk_setup(struct device_node *node,
 {
 	u32 val;
 	void __iomem *io;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	struct nspire_clk_info info;
 
diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corenet.c
index 8b284be..b82e7f0 100644
--- a/drivers/clk/clk-ppc-corenet.c
+++ b/drivers/clk/clk-ppc-corenet.c
@@ -64,7 +64,7 @@ const struct clk_ops cmux_ops = {
 
 static void __init core_mux_init(struct device_node *np)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	struct cmux_clk *cmux_clk;
 	struct device_node *node;
@@ -150,7 +150,7 @@ static void __init core_pll_init(struct device_node *np)
 	int i, rc, count;
 	const char *clk_name, *parent_name;
 	struct clk_onecell_data *onecell_data;
-	struct clk      **subclks;
+	struct clk_core      **subclks;
 	void __iomem *base;
 
 	base = of_iomap(np, 0);
@@ -184,7 +184,7 @@ static void __init core_pll_init(struct device_node *np)
 	/* output clock number per PLL */
 	clocks_per_pll = count;
 
-	subclks = kzalloc(sizeof(struct clk *) * count, GFP_KERNEL);
+	subclks = kzalloc(sizeof(struct clk_core *) * count, GFP_KERNEL);
 	if (!subclks) {
 		pr_err("%s: could not allocate subclks\n", __func__);
 		goto err_map;
@@ -246,7 +246,7 @@ err_map:
 
 static void __init sysclk_init(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	struct device_node *np = of_get_parent(node);
 	u32 rate;
diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 3757e9e..f0da3d9 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -29,7 +29,7 @@
 
 #define s2mps11_name(a) (a->hw.init->name)
 
-static struct clk **clk_table;
+static struct clk_core **clk_table;
 static struct clk_onecell_data clk_data;
 
 enum {
@@ -43,7 +43,7 @@ struct s2mps11_clk {
 	struct sec_pmic_dev *iodev;
 	struct device_node *clk_np;
 	struct clk_hw hw;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_lookup *lookup;
 	u32 mask;
 	bool enabled;
@@ -178,7 +178,7 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 
 	s2mps11_clk = s2mps11_clks;
 
-	clk_table = devm_kzalloc(&pdev->dev, sizeof(struct clk *) *
+	clk_table = devm_kzalloc(&pdev->dev, sizeof(struct clk_core *) *
 				 S2MPS11_CLKS_NUM, GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 3b2a66f..57c9eb5 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -56,10 +56,10 @@ struct si5351_driver_data {
 	struct regmap		*regmap;
 	struct clk_onecell_data onecell;
 
-	struct clk		*pxtal;
+	struct clk_core		*pxtal;
 	const char		*pxtal_name;
 	struct clk_hw		xtal;
-	struct clk		*pclkin;
+	struct clk_core		*pclkin;
 	const char		*pclkin_name;
 	struct clk_hw		clkin;
 
@@ -1128,12 +1128,12 @@ static int si5351_dt_parse(struct i2c_client *client,
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->clk_xtal = of_clk_get(np, 0);
+	pdata->clk_xtal = of_clk_provider_get(np, 0);
 	if (!IS_ERR(pdata->clk_xtal))
-		clk_put(pdata->clk_xtal);
-	pdata->clk_clkin = of_clk_get(np, 1);
+		__clk_put(pdata->clk_xtal);
+	pdata->clk_clkin = of_clk_provider_get(np, 1);
 	if (!IS_ERR(pdata->clk_clkin))
-		clk_put(pdata->clk_clkin);
+		__clk_put(pdata->clk_clkin);
 
 	/*
 	 * property silabs,pll-source : <num src>, [<..>]
@@ -1306,7 +1306,7 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_names[4];
 	u8 num_parents, num_clocks;
 	int ret, n;
@@ -1545,7 +1545,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		/* set initial clkout rate */
 		if (pdata->clkout[n].rate != 0) {
 			int ret;
-			ret = clk_set_rate(clk, pdata->clkout[n].rate);
+			ret = clk_provider_set_rate(clk,
+						    pdata->clkout[n].rate);
 			if (ret != 0) {
 				dev_err(&client->dev, "Cannot set rate : %d\n",
 					ret);
diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index fc167b3..f0eec4e 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -407,7 +407,7 @@ static int si570_probe(struct i2c_client *client,
 {
 	struct clk_si570 *data;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 initial_fout, factory_fout, stability;
 	int err;
 	enum clk_si570_variant variant = id->driver_data;
@@ -476,7 +476,7 @@ static int si570_probe(struct i2c_client *client,
 	/* Read the requested initial output frequency from device tree */
 	if (!of_property_read_u32(client->dev.of_node, "clock-frequency",
 				&initial_fout)) {
-		err = clk_set_rate(clk, initial_fout);
+		err = clk_provider_set_rate(clk, initial_fout);
 		if (err) {
 			of_clk_del_provider(client->dev.of_node);
 			return err;
diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 1ada79a..2422857 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -31,7 +31,7 @@ struct twl6040_clk {
 	struct twl6040 *twl6040;
 	struct device *dev;
 	struct clk_hw mcpdm_fclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	int enabled;
 };
 
diff --git a/drivers/clk/clk-u300.c b/drivers/clk/clk-u300.c
index 406bfc1..7e9ec00 100644
--- a/drivers/clk/clk-u300.c
+++ b/drivers/clk/clk-u300.c
@@ -688,7 +688,7 @@ static const struct clk_ops syscon_clk_ops = {
 	.set_rate = syscon_clk_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 syscon_clk_register(struct device *dev, const char *name,
 		    const char *parent_name, unsigned long flags,
 		    bool hw_ctrld,
@@ -696,7 +696,7 @@ syscon_clk_register(struct device *dev, const char *name,
 		    void __iomem *en_reg, u8 en_bit,
 		    u16 clk_val)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_syscon *sclk;
 	struct clk_init_data init;
 
@@ -867,7 +867,7 @@ static struct u300_clock const u300_clk_lookup[] __initconst = {
 
 static void __init of_u300_syscon_clk_init(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 	void __iomem *res_reg;
@@ -1110,11 +1110,11 @@ static const struct clk_ops mclk_ops = {
 	.set_rate = mclk_clk_set_rate,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 mclk_clk_register(struct device *dev, const char *name,
 		  const char *parent_name, bool is_mspro)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_mclk *mclk;
 	struct clk_init_data init;
 
@@ -1141,7 +1141,7 @@ mclk_clk_register(struct device *dev, const char *name,
 
 static void __init of_u300_syscon_mclk_init(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const char *parent_name;
 
diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 37e9288..e5fb933 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -232,7 +232,7 @@ static const struct clk_ops vt8500_gated_divisor_clk_ops = {
 static __init void vtwm_device_clk_init(struct device_node *node)
 {
 	u32 en_reg, div_reg;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_device *dev_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
@@ -650,7 +650,7 @@ static const struct clk_ops vtwm_pll_ops = {
 static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
diff --git a/drivers/clk/clk-wm831x.c b/drivers/clk/clk-wm831x.c
index b131041..d2d745e 100644
--- a/drivers/clk/clk-wm831x.c
+++ b/drivers/clk/clk-wm831x.c
@@ -25,9 +25,9 @@ struct wm831x_clk {
 	struct clk_hw xtal_hw;
 	struct clk_hw fll_hw;
 	struct clk_hw clkout_hw;
-	struct clk *xtal;
-	struct clk *fll;
-	struct clk *clkout;
+	struct clk_core *xtal;
+	struct clk_core *fll;
+	struct clk_core *clkout;
 	bool xtal_ena;
 };
 
diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index dd8a62d..ce3ed34 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -124,13 +124,13 @@ const struct clk_ops xgene_clk_pll_ops = {
 	.recalc_rate = xgene_clk_pll_recalc_rate,
 };
 
-static struct clk *xgene_register_clk_pll(struct device *dev,
+static struct clk_core *xgene_register_clk_pll(struct device *dev,
 	const char *name, const char *parent_name,
 	unsigned long flags, void __iomem *reg, u32 pll_offset,
 	u32 type, spinlock_t *lock)
 {
 	struct xgene_clk_pll *apmclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/* allocate the APM clock structure */
@@ -166,7 +166,7 @@ static struct clk *xgene_register_clk_pll(struct device *dev,
 static void xgene_pllclk_init(struct device_node *np, enum xgene_pll_type pll_type)
 {
         const char *clk_name = np->full_name;
-        struct clk *clk;
+        struct clk_core *clk;
         void *reg;
 
         reg = of_iomap(np, 0);
@@ -395,12 +395,12 @@ const struct clk_ops xgene_clk_ops = {
 	.round_rate = xgene_clk_round_rate,
 };
 
-static struct clk *xgene_register_clk(struct device *dev,
+static struct clk_core *xgene_register_clk(struct device *dev,
 		const char *name, const char *parent_name,
 		struct xgene_dev_parameters *parameters, spinlock_t *lock)
 {
 	struct xgene_clk *apmclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	int rc;
 
@@ -442,7 +442,7 @@ static struct clk *xgene_register_clk(struct device *dev,
 static void __init xgene_devclk_init(struct device_node *np)
 {
 	const char *clk_name = np->full_name;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct resource res;
 	int rc;
 	struct xgene_dev_parameters parameters;
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index c798138..d278572 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -10,8 +10,8 @@
  */
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-struct clk *of_clk_get_by_clkspec(struct of_phandle_args *clkspec);
-struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
+struct clk_core *of_clk_get_by_clkspec(struct of_phandle_args *clkspec);
+struct clk_core *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
 void of_clk_lock(void);
 void of_clk_unlock(void);
 #endif
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 339945d..d7d3667 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -296,7 +296,7 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
 
 static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *best_parent_rate,
-			      struct clk **best_parent_p)
+			      struct clk_core **best_parent_p)
 {
 	struct clk_mmc *mclk = to_mmc(hw);
 	unsigned long best = 0;
@@ -427,11 +427,11 @@ static struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
+static struct clk_core *hisi_register_clk_mmc(struct hisi_mmc_clock *mmc_clk,
 			void __iomem *base, struct device_node *np)
 {
 	struct clk_mmc *mclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
@@ -487,7 +487,7 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 	if (WARN_ON(!clk_data))
 		return;
 
-	clk_data->clks = kzalloc(sizeof(struct clk *) * num, GFP_KERNEL);
+	clk_data->clks = kzalloc(sizeof(struct clk_core *) * num, GFP_KERNEL);
 	if (!clk_data->clks) {
 		pr_err("%s: fail to allocate mmc clk\n", __func__);
 		return;
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index a078e84..3fcd2ba 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -42,7 +42,7 @@ struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
 					     int nr_clks)
 {
 	struct hisi_clock_data *clk_data;
-	struct clk **clk_table;
+	struct clk_core **clk_table;
 	void __iomem *base;
 
 	if (np) {
@@ -63,7 +63,7 @@ struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
 	}
 	clk_data->base = base;
 
-	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	clk_table = kzalloc(sizeof(struct clk_core *) * nr_clks, GFP_KERNEL);
 	if (!clk_table) {
 		pr_err("%s: could not allocate clock lookup table\n", __func__);
 		goto err_data;
@@ -81,7 +81,7 @@ err:
 void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
@@ -102,7 +102,7 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
 					   int nums,
 					   struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
@@ -122,7 +122,7 @@ void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
 void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
 				  int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *base = data->base;
 	int i;
 
@@ -151,7 +151,7 @@ void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
 void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
 				      int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *base = data->base;
 	int i;
 
@@ -180,7 +180,7 @@ void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
 void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *base = data->base;
 	int i;
 
@@ -208,7 +208,7 @@ void __init hisi_clk_register_gate(struct hisi_gate_clock *clks,
 void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *base = data->base;
 	int i;
 
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 31083ff..f7fc4b9 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -90,7 +90,7 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *, const char *,
+struct clk_core *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
 				u8, spinlock_t *);
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index b03d5a7..61f7236 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -96,14 +96,14 @@ static struct clk_ops clkgate_separated_ops = {
 	.is_enabled	= clkgate_separated_is_enabled,
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
+struct clk_core *hisi_register_clkgate_sep(struct device *dev, const char *name,
 				      const char *parent_name,
 				      unsigned long flags,
 				      void __iomem *reg, u8 bit_idx,
 				      u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clkgate_separated *sclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
index 86f1e36..3f7db44 100644
--- a/drivers/clk/keystone/gate.c
+++ b/drivers/clk/keystone/gate.c
@@ -163,7 +163,7 @@ static const struct clk_ops clk_psc_ops = {
  * @psc_data: platform data to configure this clock
  * @lock: spinlock used by this clock
  */
-static struct clk *clk_register_psc(struct device *dev,
+static struct clk_core *clk_register_psc(struct device *dev,
 			const char *name,
 			const char *parent_name,
 			struct clk_psc_data *psc_data,
@@ -171,7 +171,7 @@ static struct clk *clk_register_psc(struct device *dev,
 {
 	struct clk_init_data init;
 	struct clk_psc *psc;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
 	if (!psc)
@@ -204,7 +204,7 @@ static void __init of_psc_clk_init(struct device_node *node, spinlock_t *lock)
 	const char *clk_name = node->name;
 	const char *parent_name;
 	struct clk_psc_data *data;
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index 0dd8a4b..fc3156e 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -116,14 +116,14 @@ static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pllclk_recalc,
 };
 
-static struct clk *clk_register_pll(struct device *dev,
+static struct clk_core *clk_register_pll(struct device *dev,
 			const char *name,
 			const char *parent_name,
 			struct clk_pll_data *pll_data)
 {
 	struct clk_init_data init;
 	struct clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -158,7 +158,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 {
 	struct clk_pll_data *pll_data;
 	const char *parent_name;
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	pll_data = kzalloc(sizeof(*pll_data), GFP_KERNEL);
@@ -239,7 +239,7 @@ static void __init of_pll_div_clk_init(struct device_node *node)
 	const char *parent_name;
 	void __iomem *reg;
 	u32 shift, mask;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
@@ -282,7 +282,7 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 {
 	void __iomem *reg;
 	u32 shift, mask;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parents[2];
 	const char *clk_name = node->name;
 
diff --git a/drivers/clk/mmp/clk-apbc.c b/drivers/clk/mmp/clk-apbc.c
index d14120e..4ca8713 100644
--- a/drivers/clk/mmp/clk-apbc.c
+++ b/drivers/clk/mmp/clk-apbc.c
@@ -120,12 +120,12 @@ struct clk_ops clk_apbc_ops = {
 	.unprepare = clk_apbc_unprepare,
 };
 
-struct clk *mmp_clk_register_apbc(const char *name, const char *parent_name,
+struct clk_core *mmp_clk_register_apbc(const char *name, const char *parent_name,
 		void __iomem *base, unsigned int delay,
 		unsigned int apbc_flags, spinlock_t *lock)
 {
 	struct clk_apbc *apbc;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	apbc = kzalloc(sizeof(*apbc), GFP_KERNEL);
diff --git a/drivers/clk/mmp/clk-apmu.c b/drivers/clk/mmp/clk-apmu.c
index abe182b..c24e6e7 100644
--- a/drivers/clk/mmp/clk-apmu.c
+++ b/drivers/clk/mmp/clk-apmu.c
@@ -66,11 +66,11 @@ struct clk_ops clk_apmu_ops = {
 	.disable = clk_apmu_disable,
 };
 
-struct clk *mmp_clk_register_apmu(const char *name, const char *parent_name,
+struct clk_core *mmp_clk_register_apmu(const char *name, const char *parent_name,
 		void __iomem *base, u32 enable_mask, spinlock_t *lock)
 {
 	struct clk_apmu *apmu;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	apmu = kzalloc(sizeof(*apmu), GFP_KERNEL);
diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 23a56f5..0386cdd 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -116,14 +116,14 @@ static struct clk_ops clk_factor_ops = {
 	.set_rate = clk_factor_set_rate,
 };
 
-struct clk *mmp_clk_register_factor(const char *name, const char *parent_name,
+struct clk_core *mmp_clk_register_factor(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *base,
 		struct clk_factor_masks *masks, struct clk_factor_tbl *ftbl,
 		unsigned int ftbl_cnt)
 {
 	struct clk_factor *factor;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	if (!masks) {
 		pr_err("%s: must pass a clk_factor_mask\n", __func__);
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index b2721ca..98bd73f 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -77,8 +77,8 @@ static const char *ccic_parent[] = {"pll1_2", "pll1_16", "vctcxo"};
 
 void __init mmp2_clk_init(void)
 {
-	struct clk *clk;
-	struct clk *vctcxo;
+	struct clk_core *clk;
+	struct clk_core *vctcxo;
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
@@ -192,7 +192,7 @@ void __init mmp2_clk_init(void)
 				mpmu_base + MPMU_UART_PLL,
 				&uart_factor_masks, uart_factor_tbl,
 				ARRAY_SIZE(uart_factor_tbl));
-	clk_set_rate(clk, 14745600);
+	clk_provider_set_rate(clk, 14745600);
 	clk_register_clkdev(clk, "uart_pll", NULL);
 
 	clk = mmp_clk_register_apbc("twsi0", "vctcxo",
@@ -251,7 +251,7 @@ void __init mmp2_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, vctcxo);
+	clk_provider_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("uart0", "uart0_mux",
@@ -262,7 +262,7 @@ void __init mmp2_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, vctcxo);
+	clk_provider_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("uart1", "uart1_mux",
@@ -273,7 +273,7 @@ void __init mmp2_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, vctcxo);
+	clk_provider_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("uart2", "uart2_mux",
@@ -284,7 +284,7 @@ void __init mmp2_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART3, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, vctcxo);
+	clk_provider_set_parent(clk, vctcxo);
 	clk_register_clkdev(clk, "uart_mux.3", NULL);
 
 	clk = mmp_clk_register_apbc("uart3", "uart3_mux",
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 014396b..e4f50ab 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -68,8 +68,8 @@ static const char *ccic_phy_parent[] = {"pll1_6", "pll1_12"};
 
 void __init pxa168_clk_init(void)
 {
-	struct clk *clk;
-	struct clk *uart_pll;
+	struct clk_core *clk;
+	struct clk_core *uart_pll;
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbc_base;
@@ -159,7 +159,7 @@ void __init pxa168_clk_init(void)
 				mpmu_base + MPMU_UART_PLL,
 				&uart_factor_masks, uart_factor_tbl,
 				ARRAY_SIZE(uart_factor_tbl));
-	clk_set_rate(uart_pll, 14745600);
+	clk_provider_set_rate(uart_pll, 14745600);
 	clk_register_clkdev(uart_pll, "uart_pll", NULL);
 
 	clk = mmp_clk_register_apbc("twsi0", "pll1_13_1_5",
@@ -202,7 +202,7 @@ void __init pxa168_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("uart0", "uart0_mux",
@@ -213,7 +213,7 @@ void __init pxa168_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("uart1", "uart1_mux",
@@ -224,7 +224,7 @@ void __init pxa168_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART2, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("uart2", "uart2_mux",
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 9efc6a4..b5c215e 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -66,8 +66,8 @@ static const char *ccic_phy_parent[] = {"pll1_6", "pll1_12"};
 
 void __init pxa910_clk_init(void)
 {
-	struct clk *clk;
-	struct clk *uart_pll;
+	struct clk_core *clk;
+	struct clk_core *uart_pll;
 	void __iomem *mpmu_base;
 	void __iomem *apmu_base;
 	void __iomem *apbcp_base;
@@ -164,7 +164,7 @@ void __init pxa910_clk_init(void)
 				mpmu_base + MPMU_UART_PLL,
 				&uart_factor_masks, uart_factor_tbl,
 				ARRAY_SIZE(uart_factor_tbl));
-	clk_set_rate(uart_pll, 14745600);
+	clk_provider_set_rate(uart_pll, 14745600);
 	clk_register_clkdev(uart_pll, "uart_pll", NULL);
 
 	clk = mmp_clk_register_apbc("twsi0", "pll1_13_1_5",
@@ -207,7 +207,7 @@ void __init pxa910_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART0, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.0", NULL);
 
 	clk = mmp_clk_register_apbc("uart0", "uart0_mux",
@@ -218,7 +218,7 @@ void __init pxa910_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbc_base + APBC_UART1, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.1", NULL);
 
 	clk = mmp_clk_register_apbc("uart1", "uart1_mux",
@@ -229,7 +229,7 @@ void __init pxa910_clk_init(void)
 				ARRAY_SIZE(uart_parent),
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
 				apbcp_base + APBCP_UART2, 4, 3, 0, &clk_lock);
-	clk_set_parent(clk, uart_pll);
+	clk_provider_set_parent(clk, uart_pll);
 	clk_register_clkdev(clk, "uart_mux.2", NULL);
 
 	clk = mmp_clk_register_apbc("uart2", "uart2_mux",
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index ab86dd4..1477e61 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -20,15 +20,15 @@ struct clk_factor_tbl {
 	unsigned int den;
 };
 
-extern struct clk *mmp_clk_register_pll2(const char *name,
+extern struct clk_core *mmp_clk_register_pll2(const char *name,
 		const char *parent_name, unsigned long flags);
-extern struct clk *mmp_clk_register_apbc(const char *name,
+extern struct clk_core *mmp_clk_register_apbc(const char *name,
 		const char *parent_name, void __iomem *base,
 		unsigned int delay, unsigned int apbc_flags, spinlock_t *lock);
-extern struct clk *mmp_clk_register_apmu(const char *name,
+extern struct clk_core *mmp_clk_register_apmu(const char *name,
 		const char *parent_name, void __iomem *base, u32 enable_mask,
 		spinlock_t *lock);
-extern struct clk *mmp_clk_register_factor(const char *name,
+extern struct clk_core *mmp_clk_register_factor(const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *base, struct clk_factor_masks *masks,
 		struct clk_factor_tbl *ftbl, unsigned int ftbl_cnt);
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index d1e5863..1be15c4 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -238,7 +238,7 @@ mvebu_corediv_clk_init(struct device_node *node,
 {
 	struct clk_init_data init;
 	struct clk_corediv *corediv;
-	struct clk **clks;
+	struct clk_core **clks;
 	void __iomem *base;
 	const char *parent_name;
 	const char *clk_name;
@@ -253,7 +253,7 @@ mvebu_corediv_clk_init(struct device_node *node,
 	clk_data.clk_num = soc_desc->ndescs;
 
 	/* clks holds the clock array */
-	clks = kcalloc(clk_data.clk_num, sizeof(struct clk *),
+	clks = kcalloc(clk_data.clk_num, sizeof(struct clk_core *),
 				GFP_KERNEL);
 	if (WARN_ON(!clks))
 		goto err_unmap;
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 8ebf757..225124b 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -30,7 +30,7 @@ struct cpu_clk {
 	void __iomem *reg_base;
 };
 
-static struct clk **clks;
+static struct clk_core **clks;
 
 static struct clk_onecell_data clk_data;
 
@@ -127,8 +127,8 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 
 	for_each_node_by_type(dn, "cpu") {
 		struct clk_init_data init;
-		struct clk *clk;
-		struct clk *parent_clk;
+		struct clk_core *clk;
+		struct clk_core *parent_clk;
 		char *clk_name = kzalloc(5, GFP_KERNEL);
 		int cpu, err;
 
@@ -140,7 +140,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 			goto bail_out;
 
 		sprintf(clk_name, "cpu%d", cpu);
-		parent_clk = of_clk_get(node, 0);
+		parent_clk = of_clk_provider_get(node, 0);
 
 		cpuclk[cpu].parent_name = __clk_get_name(parent_clk);
 		cpuclk[cpu].clk_name = clk_name;
diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 25ceccf..7e6c320 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -43,7 +43,7 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 
 	/* Allocate struct for TCLK, cpu clk, and core ratio clocks */
 	clk_data.clk_num = 2 + desc->num_ratios;
-	clk_data.clks = kzalloc(clk_data.clk_num * sizeof(struct clk *),
+	clk_data.clks = kzalloc(clk_data.clk_num * sizeof(struct clk_core *),
 				GFP_KERNEL);
 	if (WARN_ON(!clk_data.clks)) {
 		iounmap(base);
@@ -91,13 +91,13 @@ void __init mvebu_coreclk_setup(struct device_node *np,
 
 struct clk_gating_ctrl {
 	spinlock_t lock;
-	struct clk **gates;
+	struct clk_core **gates;
 	int num_gates;
 };
 
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
-static struct clk *clk_gating_get_src(
+static struct clk_core *clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_gating_ctrl *ctrl = (struct clk_gating_ctrl *)data;
@@ -119,7 +119,7 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 				   const struct clk_gating_soc_desc *desc)
 {
 	struct clk_gating_ctrl *ctrl;
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *base;
 	const char *default_parent = NULL;
 	int n;
@@ -128,10 +128,10 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 	if (WARN_ON(!base))
 		return;
 
-	clk = of_clk_get(np, 0);
+	clk = of_clk_provider_get(np, 0);
 	if (!IS_ERR(clk)) {
 		default_parent = __clk_get_name(clk);
-		clk_put(clk);
+		__clk_put(clk);
 	}
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -145,7 +145,7 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 		n++;
 
 	ctrl->num_gates = n;
-	ctrl->gates = kzalloc(ctrl->num_gates * sizeof(struct clk *),
+	ctrl->gates = kzalloc(ctrl->num_gates * sizeof(struct clk_core *),
 			      GFP_KERNEL);
 	if (WARN_ON(!ctrl->gates))
 		goto gates_out;
diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
index 90e1da9..57f93e5 100644
--- a/drivers/clk/mxs/clk-div.c
+++ b/drivers/clk/mxs/clk-div.c
@@ -74,11 +74,11 @@ static struct clk_ops clk_div_ops = {
 	.set_rate = clk_div_set_rate,
 };
 
-struct clk *mxs_clk_div(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_div(const char *name, const char *parent_name,
 			void __iomem *reg, u8 shift, u8 width, u8 busy)
 {
 	struct clk_div *div;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
diff --git a/drivers/clk/mxs/clk-frac.c b/drivers/clk/mxs/clk-frac.c
index e6aa6b5..87083e4 100644
--- a/drivers/clk/mxs/clk-frac.c
+++ b/drivers/clk/mxs/clk-frac.c
@@ -108,11 +108,11 @@ static struct clk_ops clk_frac_ops = {
 	.set_rate = clk_frac_set_rate,
 };
 
-struct clk *mxs_clk_frac(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_frac(const char *name, const char *parent_name,
 			 void __iomem *reg, u8 shift, u8 width, u8 busy)
 {
 	struct clk_frac *frac;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
diff --git a/drivers/clk/mxs/clk-imx23.c b/drivers/clk/mxs/clk-imx23.c
index 9fc9359..fc7fdf2 100644
--- a/drivers/clk/mxs/clk-imx23.c
+++ b/drivers/clk/mxs/clk-imx23.c
@@ -94,7 +94,7 @@ enum imx23_clk {
 	clk_max
 };
 
-static struct clk *clks[clk_max];
+static struct clk_core *clks[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum imx23_clk clks_init_on[] __initdata = {
@@ -171,7 +171,7 @@ static void __init mx23_clocks_init(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
+		clk_provider_prepare_enable(clks[clks_init_on[i]]);
 
 }
 CLK_OF_DECLARE(imx23_clkctrl, "fsl,imx23-clkctrl", mx23_clocks_init);
diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index a6c3501..083add7 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -148,7 +148,7 @@ enum imx28_clk {
 	clk_max
 };
 
-static struct clk *clks[clk_max];
+static struct clk_core *clks[clk_max];
 static struct clk_onecell_data clk_data;
 
 static enum imx28_clk clks_init_on[] __initdata = {
@@ -250,6 +250,6 @@ static void __init mx28_clocks_init(struct device_node *np)
 	clk_register_clkdev(clks[enet_out], NULL, "enet_out");
 
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
+		clk_provider_prepare_enable(clks[clks_init_on[i]]);
 }
 CLK_OF_DECLARE(imx28_clkctrl, "fsl,imx28-clkctrl", mx28_clocks_init);
diff --git a/drivers/clk/mxs/clk-pll.c b/drivers/clk/mxs/clk-pll.c
index fadae41..8e29d79 100644
--- a/drivers/clk/mxs/clk-pll.c
+++ b/drivers/clk/mxs/clk-pll.c
@@ -86,11 +86,11 @@ static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-struct clk *mxs_clk_pll(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_pll(const char *name, const char *parent_name,
 			void __iomem *base, u8 power, unsigned long rate)
 {
 	struct clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
index 4adeed6..ad1aa00 100644
--- a/drivers/clk/mxs/clk-ref.c
+++ b/drivers/clk/mxs/clk-ref.c
@@ -125,11 +125,11 @@ static const struct clk_ops clk_ref_ops = {
 	.set_rate	= clk_ref_set_rate,
 };
 
-struct clk *mxs_clk_ref(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_ref(const char *name, const char *parent_name,
 			void __iomem *reg, u8 idx)
 {
 	struct clk_ref *ref;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
index ef10ad9..b258ea5 100644
--- a/drivers/clk/mxs/clk.h
+++ b/drivers/clk/mxs/clk.h
@@ -23,24 +23,24 @@ extern spinlock_t mxs_lock;
 
 int mxs_clk_wait(void __iomem *reg, u8 shift);
 
-struct clk *mxs_clk_pll(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_pll(const char *name, const char *parent_name,
 			void __iomem *base, u8 power, unsigned long rate);
 
-struct clk *mxs_clk_ref(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_ref(const char *name, const char *parent_name,
 			void __iomem *reg, u8 idx);
 
-struct clk *mxs_clk_div(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_div(const char *name, const char *parent_name,
 			void __iomem *reg, u8 shift, u8 width, u8 busy);
 
-struct clk *mxs_clk_frac(const char *name, const char *parent_name,
+struct clk_core *mxs_clk_frac(const char *name, const char *parent_name,
 			 void __iomem *reg, u8 shift, u8 width, u8 busy);
 
-static inline struct clk *mxs_clk_fixed(const char *name, int rate)
+static inline struct clk_core *mxs_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
 }
 
-static inline struct clk *mxs_clk_gate(const char *name,
+static inline struct clk_core *mxs_clk_gate(const char *name,
 			const char *parent_name, void __iomem *reg, u8 shift)
 {
 	return clk_register_gate(NULL, name, parent_name, CLK_SET_RATE_PARENT,
@@ -48,7 +48,7 @@ static inline struct clk *mxs_clk_gate(const char *name,
 				 &mxs_lock);
 }
 
-static inline struct clk *mxs_clk_mux(const char *name, void __iomem *reg,
+static inline struct clk_core *mxs_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parent_names, int num_parents)
 {
 	return clk_register_mux(NULL, name, parent_names, num_parents,
@@ -56,7 +56,7 @@ static inline struct clk *mxs_clk_mux(const char *name, void __iomem *reg,
 				reg, shift, width, 0, &mxs_lock);
 }
 
-static inline struct clk *mxs_clk_fixed_factor(const char *name,
+static inline struct clk_core *mxs_clk_fixed_factor(const char *name,
 		const char *parent_name, unsigned int mult, unsigned int div)
 {
 	return clk_register_fixed_factor(NULL, name, parent_name,
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index abfc2b6..e7d0bfb 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -375,7 +375,7 @@ struct freq_tbl *find_freq(const struct freq_tbl *f, unsigned long rate)
 
 static long _freq_tbl_determine_rate(struct clk_hw *hw,
 		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_core **p)
 {
 	unsigned long clk_flags;
 
@@ -402,7 +402,7 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 }
 
 static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 
@@ -410,7 +410,7 @@ static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
 
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index cd185d5..6aac1ec 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -188,7 +188,7 @@ struct freq_tbl *find_freq(const struct freq_tbl *f, unsigned long rate)
 
 static long _freq_tbl_determine_rate(struct clk_hw *hw,
 		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_core **p)
 {
 	unsigned long clk_flags;
 
@@ -219,7 +219,7 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 }
 
 static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
@@ -372,7 +372,7 @@ static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
 }
 
 static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *p_rate, struct clk **p)
+				 unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
@@ -423,7 +423,7 @@ const struct clk_ops clk_edp_pixel_ops = {
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
 
 static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
-			 unsigned long *p_rate, struct clk **p)
+			 unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
@@ -485,14 +485,14 @@ static const struct frac_entry frac_table_pixel[] = {
 };
 
 static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *p_rate, struct clk **p)
+				 unsigned long *p_rate, struct clk_core **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	unsigned long request, src_rate;
 	int delta = 100000;
 	const struct freq_tbl *f = rcg->freq_tbl;
 	const struct frac_entry *frac = frac_table_pixel;
-	struct clk *parent = *p = clk_get_parent_by_index(hw->clk, f->src);
+	struct clk_core *parent = *p = clk_get_parent_by_index(hw->clk, f->src);
 
 	for (; frac->num; frac++) {
 		request = (rate * frac->den) / frac->num;
@@ -519,7 +519,7 @@ static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 	int delta = 100000;
 	u32 mask = BIT(rcg->hid_width) - 1;
 	u32 hid_div;
-	struct clk *parent = clk_get_parent_by_index(hw->clk, f.src);
+	struct clk_core *parent = clk_get_parent_by_index(hw->clk, f.src);
 
 	for (; frac->num; frac++) {
 		request = (rate * frac->den) / frac->num;
diff --git a/drivers/clk/qcom/clk-regmap.c b/drivers/clk/qcom/clk-regmap.c
index a58ba39..2a98040 100644
--- a/drivers/clk/qcom/clk-regmap.c
+++ b/drivers/clk/qcom/clk-regmap.c
@@ -101,7 +101,7 @@ EXPORT_SYMBOL_GPL(clk_disable_regmap);
  * clk_regmap struct via this function so that the regmap is initialized
  * and so that the clock is registered with the common clock framework.
  */
-struct clk *devm_clk_register_regmap(struct device *dev,
+struct clk_core *devm_clk_register_regmap(struct device *dev,
 				     struct clk_regmap *rclk)
 {
 	if (dev && dev_get_regmap(dev, NULL))
diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 491a63d..89258cb 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -39,7 +39,7 @@ struct clk_regmap {
 int clk_is_enabled_regmap(struct clk_hw *hw);
 int clk_enable_regmap(struct clk_hw *hw);
 void clk_disable_regmap(struct clk_hw *hw);
-struct clk *
+struct clk_core *
 devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
 
 #endif
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 9b5a1cf..bfa36bd 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -24,7 +24,7 @@
 struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_onecell_data data;
-	struct clk *clks[];
+	struct clk_core *clks[];
 };
 
 int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
@@ -33,9 +33,9 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 	struct resource *res;
 	int i, ret;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_onecell_data *data;
-	struct clk **clks;
+	struct clk_core **clks;
 	struct regmap *regmap;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index 0c4b727..2d41fdb 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -2718,7 +2718,7 @@ MODULE_DEVICE_TABLE(of, gcc_msm8660_match_table);
 
 static int gcc_msm8660_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct device *dev = &pdev->dev;
 
 	/* Temporary until RPM clocks supported */
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index f4ffd91..f3bf005 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -2911,7 +2911,7 @@ MODULE_DEVICE_TABLE(of, gcc_msm8960_match_table);
 
 static int gcc_msm8960_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
 
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 7af7c18..8326b1f 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -2699,7 +2699,7 @@ static void msm8974_pro_clock_override(void)
 
 static int gcc_msm8974_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct device *dev = &pdev->dev;
 	bool pro;
 	const struct of_device_id *id;
diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index 4c449b3..b3ae958 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -458,7 +458,7 @@ static int pix_rdi_set_parent(struct clk_hw *hw, u8 index)
 	int ret = 0;
 	u32 val;
 	struct clk_pix_rdi *rdi = to_clk_pix_rdi(hw);
-	struct clk *clk = hw->clk;
+	struct clk_core *clk = hw->clk;
 	int num_parents = __clk_get_num_parents(hw->clk);
 
 	/*
@@ -470,7 +470,7 @@ static int pix_rdi_set_parent(struct clk_hw *hw, u8 index)
 	 * needs to be on at what time.
 	 */
 	for (i = 0; i < num_parents; i++) {
-		ret = clk_prepare_enable(clk_get_parent_by_index(clk, i));
+		ret = clk_provider_prepare_enable(clk_get_parent_by_index(clk, i));
 		if (ret)
 			goto err;
 	}
@@ -499,7 +499,7 @@ static int pix_rdi_set_parent(struct clk_hw *hw, u8 index)
 
 err:
 	for (i--; i >= 0; i--)
-		clk_disable_unprepare(clk_get_parent_by_index(clk, i));
+		clk_provider_disable_unprepare(clk_get_parent_by_index(clk, i));
 
 	return ret;
 }
diff --git a/drivers/clk/rockchip/clk-rockchip.c b/drivers/clk/rockchip/clk-rockchip.c
index 4cf838d5..faa8dfa 100644
--- a/drivers/clk/rockchip/clk-rockchip.c
+++ b/drivers/clk/rockchip/clk-rockchip.c
@@ -54,7 +54,7 @@ static void __init rk2928_gate_clk_init(struct device_node *node)
 	if (!clk_data)
 		return;
 
-	clk_data->clks = kzalloc(qty * sizeof(struct clk *), GFP_KERNEL);
+	clk_data->clks = kzalloc(qty * sizeof(struct clk_core *), GFP_KERNEL);
 	if (!clk_data->clks) {
 		kfree(clk_data);
 		return;
diff --git a/drivers/clk/samsung/clk-exynos-audss.c b/drivers/clk/samsung/clk-exynos-audss.c
index 13eae14c..f5639bf 100644
--- a/drivers/clk/samsung/clk-exynos-audss.c
+++ b/drivers/clk/samsung/clk-exynos-audss.c
@@ -26,7 +26,7 @@ enum exynos_audss_clk_type {
 };
 
 static DEFINE_SPINLOCK(lock);
-static struct clk **clk_table;
+static struct clk_core **clk_table;
 static void __iomem *reg_base;
 static struct clk_onecell_data clk_data;
 
@@ -83,7 +83,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	const char *mout_audss_p[] = {"fin_pll", "fout_epll"};
 	const char *mout_i2s_p[] = {"mout_audss", "cdclk0", "sclk_audio0"};
 	const char *sclk_pcm_p = "sclk_pcm0";
-	struct clk *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
+	struct clk_core *pll_ref, *pll_in, *cdclk, *sclk_audio, *sclk_pcm_in;
 	const struct of_device_id *match;
 	enum exynos_audss_clk_type variant;
 
@@ -100,7 +100,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	}
 
 	clk_table = devm_kzalloc(&pdev->dev,
-				sizeof(struct clk *) * EXYNOS_AUDSS_MAX_CLKS,
+				sizeof(struct clk_core *) * EXYNOS_AUDSS_MAX_CLKS,
 				GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
@@ -111,8 +111,8 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 	else
 		clk_data.clk_num = EXYNOS_AUDSS_MAX_CLKS - 1;
 
-	pll_ref = devm_clk_get(&pdev->dev, "pll_ref");
-	pll_in = devm_clk_get(&pdev->dev, "pll_in");
+	pll_ref = devm_clk_provider_get(&pdev->dev, "pll_ref");
+	pll_in = devm_clk_provider_get(&pdev->dev, "pll_in");
 	if (!IS_ERR(pll_ref))
 		mout_audss_p[0] = __clk_get_name(pll_ref);
 	if (!IS_ERR(pll_in))
@@ -122,8 +122,8 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				CLK_SET_RATE_NO_REPARENT,
 				reg_base + ASS_CLK_SRC, 0, 1, 0, &lock);
 
-	cdclk = devm_clk_get(&pdev->dev, "cdclk");
-	sclk_audio = devm_clk_get(&pdev->dev, "sclk_audio");
+	cdclk = devm_clk_provider_get(&pdev->dev, "cdclk");
+	sclk_audio = devm_clk_provider_get(&pdev->dev, "sclk_audio");
 	if (!IS_ERR(cdclk))
 		mout_i2s_p[1] = __clk_get_name(cdclk);
 	if (!IS_ERR(sclk_audio))
@@ -161,7 +161,7 @@ static int exynos_audss_clk_probe(struct platform_device *pdev)
 				 "sclk_pcm", CLK_SET_RATE_PARENT,
 				reg_base + ASS_CLK_GATE, 4, 0, &lock);
 
-	sclk_pcm_in = devm_clk_get(&pdev->dev, "sclk_pcm_in");
+	sclk_pcm_in = devm_clk_provider_get(&pdev->dev, "sclk_pcm_in");
 	if (!IS_ERR(sclk_pcm_in))
 		sclk_pcm_p = __clk_get_name(sclk_pcm_in);
 	clk_table[EXYNOS_SCLK_PCM] = clk_register_gate(NULL, "sclk_pcm",
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7f4a473..9f42648 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1038,19 +1038,19 @@ static unsigned long exynos4_get_xom(void)
 static void __init exynos4_clk_register_finpll(struct samsung_clk_provider *ctx)
 {
 	struct samsung_fixed_rate_clock fclk;
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned long finpll_f = 24000000;
 	char *parent_name;
 	unsigned int xom = exynos4_get_xom();
 
 	parent_name = xom & 1 ? "xusbxti" : "xxti";
-	clk = clk_get(NULL, parent_name);
+	clk = clk_provider_get(NULL, parent_name);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to lookup parent clock %s, assuming "
 			"fin_pll clock frequency is 24MHz\n", __func__,
 			parent_name);
 	} else {
-		finpll_f = clk_get_rate(clk);
+		finpll_f = clk_provider_get_rate(clk);
 	}
 
 	fclk.id = CLK_FIN_PLL;
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b07fad2..aaf234a 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -910,12 +910,12 @@ static const struct clk_ops samsung_pll2550x_clk_ops = {
 	.recalc_rate = samsung_pll2550x_recalc_rate,
 };
 
-struct clk * __init samsung_clk_register_pll2550x(const char *name,
+struct clk_core * __init samsung_clk_register_pll2550x(const char *name,
 			const char *pname, const void __iomem *reg_base,
 			const unsigned long offset)
 {
 	struct samsung_clk_pll2550x *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
@@ -1149,7 +1149,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 				void __iomem *base)
 {
 	struct samsung_clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	int ret, len;
 
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index c0ed4d4..81af344 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -97,7 +97,7 @@ struct samsung_pll_rate_table {
 	unsigned int vsel;
 };
 
-extern struct clk * __init samsung_clk_register_pll2550x(const char *name,
+extern struct clk_core * __init samsung_clk_register_pll2550x(const char *name,
 			const char *pname, const void __iomem *reg_base,
 			const unsigned long offset);
 
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 0449cc0..70baecf 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -87,12 +87,12 @@ const struct clk_ops s3c24xx_clkout_ops = {
 	.determine_rate = __clk_mux_determine_rate,
 };
 
-struct clk *s3c24xx_register_clkout(struct device *dev, const char *name,
+struct clk_core *s3c24xx_register_clkout(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents,
 		u8 shift, u32 mask)
 {
 	struct s3c24xx_clkout *clkout;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/* allocate the clkout */
@@ -237,7 +237,7 @@ static int s3c24xx_dclk_probe(struct platform_device *pdev)
 {
 	struct s3c24xx_dclk *s3c24xx_dclk;
 	struct resource *mem;
-	struct clk **clk_table;
+	struct clk_core **clk_table;
 	struct s3c24xx_dclk_drv_data *dclk_variant;
 	int ret, i;
 
@@ -251,7 +251,7 @@ static int s3c24xx_dclk_probe(struct platform_device *pdev)
 	spin_lock_init(&s3c24xx_dclk->dclk_lock);
 
 	clk_table = devm_kzalloc(&pdev->dev,
-				 sizeof(struct clk *) * DCLK_MAX_CLKS,
+				 sizeof(struct clk_core *) * DCLK_MAX_CLKS,
 				 GFP_KERNEL);
 	if (!clk_table)
 		return -ENOMEM;
@@ -355,7 +355,7 @@ err_clk_register:
 static int s3c24xx_dclk_remove(struct platform_device *pdev)
 {
 	struct s3c24xx_dclk *s3c24xx_dclk = platform_get_drvdata(pdev);
-	struct clk **clk_table = s3c24xx_dclk->clk_data.clks;
+	struct clk_core **clk_table = s3c24xx_dclk->clk_data.clks;
 	int i;
 
 	clk_notifier_unregister(clk_table[DIV_DCLK1],
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 49629c7..59bf393 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -52,7 +52,7 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 			void __iomem *base, unsigned long nr_clks)
 {
 	struct samsung_clk_provider *ctx;
-	struct clk **clk_table;
+	struct clk_core **clk_table;
 	int ret;
 	int i;
 
@@ -60,7 +60,7 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
-	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
+	clk_table = kcalloc(nr_clks, sizeof(struct clk_core *), GFP_KERNEL);
 	if (!clk_table)
 		panic("could not allocate clock lookup table\n");
 
@@ -84,7 +84,7 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 }
 
 /* add a clock instance to the clock lookup table used for dt based lookup */
-void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk *clk,
+void samsung_clk_add_lookup(struct samsung_clk_provider *ctx, struct clk_core *clk,
 				unsigned int id)
 {
 	if (ctx->clk_data.clks && id)
@@ -96,7 +96,7 @@ void __init samsung_clk_register_alias(struct samsung_clk_provider *ctx,
 				struct samsung_clock_alias *list,
 				unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx, ret;
 
 	if (!ctx->clk_data.clks) {
@@ -129,7 +129,7 @@ void __init samsung_clk_register_alias(struct samsung_clk_provider *ctx,
 void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
@@ -158,7 +158,7 @@ void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 		struct samsung_fixed_factor_clock *list, unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
@@ -179,7 +179,7 @@ void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
 				struct samsung_mux_clock *list,
 				unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
@@ -211,7 +211,7 @@ void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
 				struct samsung_div_clock *list,
 				unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
@@ -250,7 +250,7 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 				struct samsung_gate_clock *list,
 				unsigned int nr_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
@@ -302,7 +302,7 @@ void __init samsung_clk_of_register_fixed_ext(struct samsung_clk_provider *ctx,
 /* utility function to get the rate of a specified clock */
 unsigned long _get_rate(const char *clk_name)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = __clk_lookup(clk_name);
 	if (!clk) {
@@ -310,5 +310,5 @@ unsigned long _get_rate(const char *clk_name)
 		return 0;
 	}
 
-	return clk_get_rate(clk);
+	return clk_provider_get_rate(clk);
 }
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 9693b80..33f14bb 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -334,7 +334,7 @@ extern void __init samsung_clk_of_register_fixed_ext(
 			struct of_device_id *clk_matches);
 
 extern void samsung_clk_add_lookup(struct samsung_clk_provider *ctx,
-			struct clk *clk, unsigned int id);
+			struct clk_core *clk, unsigned int id);
 
 extern void samsung_clk_register_alias(struct samsung_clk_provider *ctx,
 			struct samsung_clock_alias *list,
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index f065f69..c6712fb 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -119,7 +119,7 @@ static void __init cpg_div6_clock_init(struct device_node *np)
 	struct div6_clock *clock;
 	const char *parent_name;
 	const char *name;
-	struct clk *clk;
+	struct clk_core *clk;
 	int ret;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
diff --git a/drivers/clk/shmobile/clk-emev2.c b/drivers/clk/shmobile/clk-emev2.c
index 6c7c929..2e3a45b 100644
--- a/drivers/clk/shmobile/clk-emev2.c
+++ b/drivers/clk/shmobile/clk-emev2.c
@@ -71,7 +71,7 @@ static void __init emev2_smu_init(void)
 static void __init emev2_smu_clkdiv_init(struct device_node *np)
 {
 	u32 reg[2];
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name = of_clk_get_parent_name(np, 0);
 	if (WARN_ON(of_property_read_u32_array(np, "reg", reg, 2)))
 		return;
@@ -89,7 +89,7 @@ CLK_OF_DECLARE(emev2_smu_clkdiv, "renesas,emev2-smu-clkdiv",
 static void __init emev2_smu_gclk_init(struct device_node *np)
 {
 	u32 reg[2];
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name = of_clk_get_parent_name(np, 0);
 	if (WARN_ON(of_property_read_u32_array(np, "reg", reg, 2)))
 		return;
diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2d2fe77..2659676 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -121,13 +121,13 @@ static const struct clk_ops cpg_mstp_clock_ops = {
 	.is_enabled = cpg_mstp_clock_is_enabled,
 };
 
-static struct clk * __init
+static struct clk_core * __init
 cpg_mstp_clock_register(const char *name, const char *parent_name,
 			unsigned int index, struct mstp_clock_group *group)
 {
 	struct clk_init_data init;
 	struct mstp_clock *clock;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock) {
@@ -157,7 +157,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 {
 	struct mstp_clock_group *group;
 	const char *idxname;
-	struct clk **clks;
+	struct clk_core **clks;
 	unsigned int i;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
diff --git a/drivers/clk/shmobile/clk-r8a7740.c b/drivers/clk/shmobile/clk-r8a7740.c
index 1e2eaae..8889e6a 100644
--- a/drivers/clk/shmobile/clk-r8a7740.c
+++ b/drivers/clk/shmobile/clk-r8a7740.c
@@ -61,7 +61,7 @@ static const struct clk_div_table div4_div_table[] = {
 
 static u32 cpg_mode __initdata;
 
-static struct clk * __init
+static struct clk_core * __init
 r8a7740_cpg_register_clock(struct device_node *np, struct r8a7740_cpg *cpg,
 			     const char *name)
 {
@@ -147,7 +147,7 @@ r8a7740_cpg_register_clock(struct device_node *np, struct r8a7740_cpg *cpg,
 static void __init r8a7740_cpg_clocks_init(struct device_node *np)
 {
 	struct r8a7740_cpg *cpg;
-	struct clk **clks;
+	struct clk_core **clks;
 	unsigned int i;
 	int num_clks;
 
@@ -180,7 +180,7 @@ static void __init r8a7740_cpg_clocks_init(struct device_node *np)
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
-		struct clk *clk;
+		struct clk_core *clk;
 
 		of_property_read_string_index(np, "clock-output-names", i,
 					      &name);
diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
index 652ecac..96b51b1 100644
--- a/drivers/clk/shmobile/clk-r8a7779.c
+++ b/drivers/clk/shmobile/clk-r8a7779.c
@@ -90,7 +90,7 @@ static const unsigned int cpg_plla_mult[4] __initconst = { 42, 48, 56, 64 };
 
 static u32 cpg_mode __initdata;
 
-static struct clk * __init
+static struct clk_core * __init
 r8a7779_cpg_register_clock(struct device_node *np, struct r8a7779_cpg *cpg,
 			   const struct cpg_clk_config *config,
 			   unsigned int plla_mult, const char *name)
@@ -124,7 +124,7 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 {
 	const struct cpg_clk_config *config;
 	struct r8a7779_cpg *cpg;
-	struct clk **clks;
+	struct clk_core **clks;
 	unsigned int i, plla_mult;
 	int num_clks;
 
@@ -153,7 +153,7 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
-		struct clk *clk;
+		struct clk_core *clk;
 
 		of_property_read_string_index(np, "clock-output-names", i,
 					      &name);
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index dff7f79..d8bdeb8 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -133,12 +133,12 @@ static const struct clk_ops cpg_z_clk_ops = {
 	.set_rate = cpg_z_clk_set_rate,
 };
 
-static struct clk * __init cpg_z_clk_register(struct rcar_gen2_cpg *cpg)
+static struct clk_core * __init cpg_z_clk_register(struct rcar_gen2_cpg *cpg)
 {
 	static const char *parent_name = "pll0";
 	struct clk_init_data init;
 	struct cpg_z_clk *zclk;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	zclk = kzalloc(sizeof(*zclk), GFP_KERNEL);
 	if (!zclk)
@@ -212,7 +212,7 @@ static const struct clk_div_table cpg_sd01_div_table[] = {
 
 static u32 cpg_mode __initdata;
 
-static struct clk * __init
+static struct clk_core * __init
 rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 			     const struct cpg_pll_config *config,
 			     const char *name)
@@ -279,7 +279,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 {
 	const struct cpg_pll_config *config;
 	struct rcar_gen2_cpg *cpg;
-	struct clk **clks;
+	struct clk_core **clks;
 	unsigned int i;
 	int num_clks;
 
@@ -312,7 +312,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
-		struct clk *clk;
+		struct clk_core *clk;
 
 		of_property_read_string_index(np, "clock-output-names", i,
 					      &name);
diff --git a/drivers/clk/shmobile/clk-rz.c b/drivers/clk/shmobile/clk-rz.c
index 7e68e86..414e20e 100644
--- a/drivers/clk/shmobile/clk-rz.c
+++ b/drivers/clk/shmobile/clk-rz.c
@@ -28,7 +28,7 @@ struct rz_cpg {
  * Initialization
  */
 
-static struct clk * __init
+static struct clk_core * __init
 rz_cpg_register_clock(struct device_node *np, struct rz_cpg *cpg, const char *name)
 {
 	u32 val;
@@ -67,7 +67,7 @@ rz_cpg_register_clock(struct device_node *np, struct rz_cpg *cpg, const char *na
 static void __init rz_cpg_clocks_init(struct device_node *np)
 {
 	struct rz_cpg *cpg;
-	struct clk **clks;
+	struct clk_core **clks;
 	unsigned i;
 	int num_clks;
 
@@ -86,7 +86,7 @@ static void __init rz_cpg_clocks_init(struct device_node *np)
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
-		struct clk *clk;
+		struct clk_core *clk;
 
 		of_property_read_string_index(np, "clock-output-names", i, &name);
 
diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
index d63b76c..9cce269 100644
--- a/drivers/clk/sirf/clk-atlas6.c
+++ b/drivers/clk/sirf/clk-atlas6.c
@@ -113,7 +113,7 @@ static __initdata struct clk_hw *atlas6_clk_hw_array[maxclk] = {
 	&clk_cphif.hw,
 };
 
-static struct clk *atlas6_clks[maxclk];
+static struct clk_core *atlas6_clks[maxclk];
 
 static void __init atlas6_clk_init(struct device_node *np)
 {
diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 37af51c..05f5040 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -165,9 +165,9 @@ static long cpu_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * SiRF SoC has not cpu clock control,
 	 * So bypass to it's parent pll.
 	 */
-	struct clk *parent_clk = clk_get_parent(hw->clk);
-	struct clk *pll_parent_clk = clk_get_parent(parent_clk);
-	unsigned long pll_parent_rate = clk_get_rate(pll_parent_clk);
+	struct clk_core *parent_clk = clk_provider_get_parent(hw->clk);
+	struct clk_core *pll_parent_clk = clk_provider_get_parent(parent_clk);
+	unsigned long pll_parent_rate = clk_provider_get_rate(pll_parent_clk);
 	return pll_clk_round_rate(__clk_get_hw(parent_clk), rate, &pll_parent_rate);
 }
 
@@ -178,7 +178,7 @@ static unsigned long cpu_clk_recalc_rate(struct clk_hw *hw,
 	 * SiRF SoC has not cpu clock control,
 	 * So return the parent pll rate.
 	 */
-	struct clk *parent_clk = clk_get_parent(hw->clk);
+	struct clk_core *parent_clk = clk_provider_get_parent(hw->clk);
 	return __clk_get_rate(parent_clk);
 }
 
@@ -403,34 +403,34 @@ static int cpu_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
 	int ret1, ret2;
-	struct clk *cur_parent;
+	struct clk_core *cur_parent;
 
-	if (rate == clk_get_rate(clk_pll1.hw.clk)) {
-		ret1 = clk_set_parent(hw->clk, clk_pll1.hw.clk);
+	if (rate == clk_provider_get_rate(clk_pll1.hw.clk)) {
+		ret1 = clk_provider_set_parent(hw->clk, clk_pll1.hw.clk);
 		return ret1;
 	}
 
-	if (rate == clk_get_rate(clk_pll2.hw.clk)) {
-		ret1 = clk_set_parent(hw->clk, clk_pll2.hw.clk);
+	if (rate == clk_provider_get_rate(clk_pll2.hw.clk)) {
+		ret1 = clk_provider_set_parent(hw->clk, clk_pll2.hw.clk);
 		return ret1;
 	}
 
-	if (rate == clk_get_rate(clk_pll3.hw.clk)) {
-		ret1 = clk_set_parent(hw->clk, clk_pll3.hw.clk);
+	if (rate == clk_provider_get_rate(clk_pll3.hw.clk)) {
+		ret1 = clk_provider_set_parent(hw->clk, clk_pll3.hw.clk);
 		return ret1;
 	}
 
-	cur_parent = clk_get_parent(hw->clk);
+	cur_parent = clk_provider_get_parent(hw->clk);
 
 	/* switch to tmp pll before setting parent clock's rate */
 	if (cur_parent ==  clk_pll1.hw.clk) {
-		ret1 = clk_set_parent(hw->clk, clk_pll2.hw.clk);
+		ret1 = clk_provider_set_parent(hw->clk, clk_pll2.hw.clk);
 		BUG_ON(ret1);
 	}
 
-	ret2 = clk_set_rate(clk_pll1.hw.clk, rate);
+	ret2 = clk_provider_set_rate(clk_pll1.hw.clk, rate);
 
-	ret1 = clk_set_parent(hw->clk, clk_pll1.hw.clk);
+	ret1 = clk_provider_set_parent(hw->clk, clk_pll1.hw.clk);
 
 	return ret2 ? ret2 : ret1;
 }
diff --git a/drivers/clk/sirf/clk-prima2.c b/drivers/clk/sirf/clk-prima2.c
index 6968e2e..751187b 100644
--- a/drivers/clk/sirf/clk-prima2.c
+++ b/drivers/clk/sirf/clk-prima2.c
@@ -112,7 +112,7 @@ static __initdata struct clk_hw *prima2_clk_hw_array[maxclk] = {
 	&clk_cphif.hw,
 };
 
-static struct clk *prima2_clks[maxclk];
+static struct clk_core *prima2_clks[maxclk];
 
 static void __init prima2_clk_init(struct device_node *np)
 {
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index dd3a78c..e3a6fe6 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -188,7 +188,7 @@ static void __init __socfpga_gate_init(struct device_node *node,
 	u32 div_reg[3];
 	u32 clk_phase[2];
 	u32 fixed_div;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct socfpga_gate_clk *socfpga_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
index 46531c3..a63be19 100644
--- a/drivers/clk/socfpga/clk-periph.c
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -53,7 +53,7 @@ static __init void __socfpga_periph_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index de6da95..4ed91a4 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -81,11 +81,11 @@ static struct clk_ops clk_pll_ops = {
 	.get_parent = clk_pll_get_parent,
 };
 
-static __init struct clk *__socfpga_pll_init(struct device_node *node,
+static __init struct clk_core *__socfpga_pll_init(struct device_node *node,
 	const struct clk_ops *ops)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
index bdfb442..18334c3 100644
--- a/drivers/clk/spear/clk-aux-synth.c
+++ b/drivers/clk/spear/clk-aux-synth.c
@@ -134,14 +134,14 @@ static struct clk_ops clk_aux_ops = {
 	.set_rate = clk_aux_set_rate,
 };
 
-struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
+struct clk_core *clk_register_aux(const char *aux_name, const char *gate_name,
 		const char *parent_name, unsigned long flags, void __iomem *reg,
 		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
-		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk)
+		u8 rtbl_cnt, spinlock_t *lock, struct clk_core **gate_clk)
 {
 	struct clk_aux *aux;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	if (!aux_name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
 		pr_err("Invalid arguments passed");
@@ -177,7 +177,7 @@ struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
 		goto free_aux;
 
 	if (gate_name) {
-		struct clk *tgate_clk;
+		struct clk_core *tgate_clk;
 
 		tgate_clk = clk_register_gate(NULL, gate_name, aux_name,
 				CLK_SET_RATE_PARENT, reg,
diff --git a/drivers/clk/spear/clk-frac-synth.c b/drivers/clk/spear/clk-frac-synth.c
index dffd4ce..bce2c0e 100644
--- a/drivers/clk/spear/clk-frac-synth.c
+++ b/drivers/clk/spear/clk-frac-synth.c
@@ -122,13 +122,13 @@ static struct clk_ops clk_frac_ops = {
 	.set_rate = clk_frac_set_rate,
 };
 
-struct clk *clk_register_frac(const char *name, const char *parent_name,
+struct clk_core *clk_register_frac(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg,
 		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock)
 {
 	struct clk_init_data init;
 	struct clk_frac *frac;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
 		pr_err("Invalid arguments passed");
diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index 1afc18c..f8e13f3 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -111,13 +111,13 @@ static struct clk_ops clk_gpt_ops = {
 	.set_rate = clk_gpt_set_rate,
 };
 
-struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
+struct clk_core *clk_register_gpt(const char *name, const char *parent_name, unsigned
 		long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
 		rtbl_cnt, spinlock_t *lock)
 {
 	struct clk_init_data init;
 	struct clk_gpt *gpt;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	if (!name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
 		pr_err("Invalid arguments passed");
diff --git a/drivers/clk/spear/clk-vco-pll.c b/drivers/clk/spear/clk-vco-pll.c
index 1b9b65b..226f2ec 100644
--- a/drivers/clk/spear/clk-vco-pll.c
+++ b/drivers/clk/spear/clk-vco-pll.c
@@ -272,16 +272,16 @@ static struct clk_ops clk_vco_ops = {
 	.set_rate = clk_vco_set_rate,
 };
 
-struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
+struct clk_core *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 		const char *vco_gate_name, const char *parent_name,
 		unsigned long flags, void __iomem *mode_reg, void __iomem
 		*cfg_reg, struct pll_rate_tbl *rtbl, u8 rtbl_cnt,
-		spinlock_t *lock, struct clk **pll_clk,
-		struct clk **vco_gate_clk)
+		spinlock_t *lock, struct clk_core **pll_clk,
+		struct clk_core **vco_gate_clk)
 {
 	struct clk_vco *vco;
 	struct clk_pll *pll;
-	struct clk *vco_clk, *tpll_clk, *tvco_gate_clk;
+	struct clk_core *vco_clk, *tpll_clk, *tvco_gate_clk;
 	struct clk_init_data vco_init, pll_init;
 	const char **vco_parent_name;
 
diff --git a/drivers/clk/spear/clk.h b/drivers/clk/spear/clk.h
index 9317376..777322e 100644
--- a/drivers/clk/spear/clk.h
+++ b/drivers/clk/spear/clk.h
@@ -110,22 +110,22 @@ typedef unsigned long (*clk_calc_rate)(struct clk_hw *hw, unsigned long prate,
 		int index);
 
 /* clk register routines */
-struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
+struct clk_core *clk_register_aux(const char *aux_name, const char *gate_name,
 		const char *parent_name, unsigned long flags, void __iomem *reg,
 		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
-		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk);
-struct clk *clk_register_frac(const char *name, const char *parent_name,
+		u8 rtbl_cnt, spinlock_t *lock, struct clk_core **gate_clk);
+struct clk_core *clk_register_frac(const char *name, const char *parent_name,
 		unsigned long flags, void __iomem *reg,
 		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock);
-struct clk *clk_register_gpt(const char *name, const char *parent_name, unsigned
+struct clk_core *clk_register_gpt(const char *name, const char *parent_name, unsigned
 		long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
 		rtbl_cnt, spinlock_t *lock);
-struct clk *clk_register_vco_pll(const char *vco_name, const char *pll_name,
+struct clk_core *clk_register_vco_pll(const char *vco_name, const char *pll_name,
 		const char *vco_gate_name, const char *parent_name,
 		unsigned long flags, void __iomem *mode_reg, void __iomem
 		*cfg_reg, struct pll_rate_tbl *rtbl, u8 rtbl_cnt,
-		spinlock_t *lock, struct clk **pll_clk,
-		struct clk **vco_gate_clk);
+		spinlock_t *lock, struct clk_core **pll_clk,
+		struct clk_core **vco_gate_clk);
 
 long clk_round_rate_index(struct clk_hw *hw, unsigned long drate,
 		unsigned long parent_rate, clk_calc_rate calc_rate, u8 rtbl_cnt,
diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 65894f7..31c5ccb 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -385,7 +385,7 @@ static const char *tdm_parents[] = { "ras_pll3_clk", "gen_syn1_clk", };
 
 void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 {
-	struct clk *clk, *clk1;
+	struct clk_core *clk, *clk1;
 
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index fe835c1..843ced4 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -442,7 +442,7 @@ static const char *gen_synth2_3_parents[] = { "vco1div4_clk", "vco2div2_clk",
 
 void __init spear1340_clk_init(void __iomem *misc_base)
 {
-	struct clk *clk, *clk1;
+	struct clk_core *clk, *clk1;
 
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index bb5f387..5b8d659 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -140,7 +140,7 @@ static const char *ddr_parents[] = { "ahb_clk", "ahbmult2_clk", "none",
 #ifdef CONFIG_MACH_SPEAR300
 static void __init spear300_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = clk_register_fixed_factor(NULL, "clcd_clk", "ras_pll3_clk", 0,
 			1, 1);
@@ -170,7 +170,7 @@ static inline void spear300_clk_init(void) { }
 #ifdef CONFIG_MACH_SPEAR310
 static void __init spear310_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = clk_register_fixed_factor(NULL, "emi_clk", "ras_ahb_clk", 0, 1,
 			1);
@@ -246,9 +246,9 @@ static const char *smii0_parents[] = { "smii_125m_pad", "ras_pll2_clk",
 static const char *uartx_parents[] = { "ras_syn1_gclk", "ras_apb_clk", };
 
 static void __init spear320_clk_init(void __iomem *soc_config_base,
-				     struct clk *ras_apb_clk)
+				     struct clk_core *ras_apb_clk)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = clk_register_fixed_rate(NULL, "smii_125m_pad_clk", NULL,
 			CLK_IS_ROOT, 125000000);
@@ -344,7 +344,7 @@ static void __init spear320_clk_init(void __iomem *soc_config_base,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "a3000000.serial");
 	/* Enforce ras_apb_clk */
-	clk_set_parent(clk, ras_apb_clk);
+	clk_provider_set_parent(clk, ras_apb_clk);
 
 	clk = clk_register_mux(NULL, "uart2_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
@@ -353,7 +353,7 @@ static void __init spear320_clk_init(void __iomem *soc_config_base,
 			SPEAR320_UARTX_PCLK_MASK, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "a4000000.serial");
 	/* Enforce ras_apb_clk */
-	clk_set_parent(clk, ras_apb_clk);
+	clk_provider_set_parent(clk, ras_apb_clk);
 
 	clk = clk_register_mux(NULL, "uart3_clk", uartx_parents,
 			ARRAY_SIZE(uartx_parents),
@@ -384,12 +384,12 @@ static void __init spear320_clk_init(void __iomem *soc_config_base,
 	clk_register_clkdev(clk, NULL, "60100000.serial");
 }
 #else
-static inline void spear320_clk_init(void __iomem *sb, struct clk *rc) { }
+static inline void spear320_clk_init(void __iomem *sb, struct clk_core *rc) { }
 #endif
 
 void __init spear3xx_clk_init(void __iomem *misc_base, void __iomem *soc_config_base)
 {
-	struct clk *clk, *clk1, *ras_apb_clk;
+	struct clk_core *clk, *clk1, *ras_apb_clk;
 
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 4f649c9..db946f7 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -116,7 +116,7 @@ static struct gpt_rate_tbl gpt_rtbl[] = {
 
 void __init spear6xx_clk_init(void __iomem *misc_base)
 {
-	struct clk *clk, *clk1;
+	struct clk_core *clk, *clk1;
 
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 4f53ee0..a27a876 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -474,13 +474,13 @@ static const struct clk_ops st_quadfs_pll_c32_ops = {
 	.set_rate	= quadfs_pll_fs660c32_set_rate,
 };
 
-static struct clk * __init st_clk_register_quadfs_pll(
+static struct clk_core * __init st_clk_register_quadfs_pll(
 		const char *name, const char *parent_name,
 		struct clkgen_quadfs_data *quadfs, void __iomem *reg,
 		spinlock_t *lock)
 {
 	struct st_clk_quadfs_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/*
@@ -875,13 +875,13 @@ static const struct clk_ops st_quadfs_ops = {
 	.recalc_rate	= quadfs_recalc_rate,
 };
 
-static struct clk * __init st_clk_register_quadfs_fsynth(
+static struct clk_core * __init st_clk_register_quadfs_fsynth(
 		const char *name, const char *parent_name,
 		struct clkgen_quadfs_data *quadfs, void __iomem *reg, u32 chan,
 		spinlock_t *lock)
 {
 	struct st_clk_quadfs_fsynth *fs;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/*
@@ -947,7 +947,7 @@ static void __init st_of_create_quadfs_fsynths(
 		return;
 
 	clk_data->clk_num = QUADFS_MAX_CHAN;
-	clk_data->clks = kzalloc(QUADFS_MAX_CHAN * sizeof(struct clk *),
+	clk_data->clks = kzalloc(QUADFS_MAX_CHAN * sizeof(struct clk_core *),
 				 GFP_KERNEL);
 
 	if (!clk_data->clks) {
@@ -956,7 +956,7 @@ static void __init st_of_create_quadfs_fsynths(
 	}
 
 	for (fschan = 0; fschan < QUADFS_MAX_CHAN; fschan++) {
-		struct clk *clk;
+		struct clk_core *clk;
 		const char *clk_name;
 
 		if (of_property_read_string_index(np, "clock-output-names",
@@ -981,8 +981,8 @@ static void __init st_of_create_quadfs_fsynths(
 			clk_data->clks[fschan] = clk;
 			pr_debug("%s: parent %s rate %u\n",
 				__clk_get_name(clk),
-				__clk_get_name(clk_get_parent(clk)),
-				(unsigned int)clk_get_rate(clk));
+				__clk_get_name(clk_provider_get_parent(clk)),
+				(unsigned int)clk_provider_get_rate(clk));
 		}
 	}
 
@@ -992,7 +992,7 @@ static void __init st_of_create_quadfs_fsynths(
 static void __init st_of_quadfs_setup(struct device_node *np)
 {
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *pll_name, *clk_parent_name;
 	void __iomem *reg;
 	spinlock_t *lock;
@@ -1026,8 +1026,8 @@ static void __init st_of_quadfs_setup(struct device_node *np)
 	else
 		pr_debug("%s: parent %s rate %u\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			(unsigned int)clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			(unsigned int)clk_provider_get_rate(clk));
 
 	st_of_create_quadfs_fsynths(np, pll_name,
 				    (struct clkgen_quadfs_data *)match->data,
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index a329906..b144315 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -215,7 +215,7 @@ static const struct clk_ops clkgena_divmux_ops = {
 /**
  * clk_register_genamux - register a genamux clock with the clock framework
  */
-struct clk *clk_register_genamux(const char *name,
+struct clk_core *clk_register_genamux(const char *name,
 				const char **parent_names, u8 num_parents,
 				void __iomem *reg,
 				const struct clkgena_divmux_data *muxdata,
@@ -227,7 +227,7 @@ struct clk *clk_register_genamux(const char *name,
 	const int mux_width = 2;
 	const int divider_width = 5;
 	struct clkgena_divmux *genamux;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	int i;
 
@@ -280,8 +280,8 @@ struct clk *clk_register_genamux(const char *name,
 
 	pr_debug("%s: parent %s rate %lu\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			clk_provider_get_rate(clk));
 err:
 	return clk;
 }
@@ -413,14 +413,14 @@ void __init st_of_clkgena_divmux_setup(struct device_node *np)
 		goto err;
 
 	clk_data->clk_num = data->num_outputs;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
+	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk_core *),
 				 GFP_KERNEL);
 
 	if (!clk_data->clks)
 		goto err;
 
 	for (i = 0; i < clk_data->clk_num; i++) {
-		struct clk *clk;
+		struct clk_core *clk;
 		const char *clk_name;
 
 		if (of_property_read_string_index(np, "clock-output-names",
@@ -490,7 +490,7 @@ void __init st_of_clkgena_prediv_setup(struct device_node *np)
 	const struct of_device_id *match;
 	void __iomem *reg;
 	const char *parent_name, *clk_name;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clkgena_prediv_data *data;
 
 	match = of_match_node(clkgena_prediv_of_match, np);
@@ -522,8 +522,8 @@ void __init st_of_clkgena_prediv_setup(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 	pr_debug("%s: parent %s rate %u\n",
 		__clk_get_name(clk),
-		__clk_get_name(clk_get_parent(clk)),
-		(unsigned int)clk_get_rate(clk));
+		__clk_get_name(clk_provider_get_parent(clk)),
+		(unsigned int)clk_provider_get_rate(clk));
 
 	return;
 }
@@ -616,7 +616,7 @@ static struct of_device_id mux_of_match[] = {
 void __init st_of_clkgen_mux_setup(struct device_node *np)
 {
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *reg;
 	const char **parents;
 	int num_parents;
@@ -653,8 +653,8 @@ void __init st_of_clkgen_mux_setup(struct device_node *np)
 
 	pr_debug("%s: parent %s rate %u\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			(unsigned int)clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			(unsigned int)clk_provider_get_rate(clk));
 
 	of_clk_add_provider(np, of_clk_src_simple_get, clk);
 
@@ -717,14 +717,14 @@ void __init st_of_clkgen_vcc_setup(struct device_node *np)
 		goto err;
 
 	clk_data->clk_num = VCC_MAX_CHANNELS;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
+	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk_core *),
 				 GFP_KERNEL);
 
 	if (!clk_data->clks)
 		goto err;
 
 	for (i = 0; i < clk_data->clk_num; i++) {
-		struct clk *clk;
+		struct clk_core *clk;
 		const char *clk_name;
 		struct clk_gate *gate;
 		struct clk_divider *div;
@@ -786,8 +786,8 @@ void __init st_of_clkgen_vcc_setup(struct device_node *np)
 
 		pr_debug("%s: parent %s rate %u\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			(unsigned int)clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			(unsigned int)clk_provider_get_rate(clk));
 
 		clk_data->clks[i] = clk;
 	}
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index d8b9b1a..26cec54 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -342,13 +342,13 @@ static const struct clk_ops st_pll1200c32_ops = {
 	.recalc_rate	= recalc_stm_pll1200c32,
 };
 
-static struct clk * __init clkgen_pll_register(const char *parent_name,
+static struct clk_core * __init clkgen_pll_register(const char *parent_name,
 				struct clkgen_pll_data	*pll_data,
 				void __iomem *reg,
 				const char *clk_name)
 {
 	struct clkgen_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
@@ -374,16 +374,16 @@ static struct clk * __init clkgen_pll_register(const char *parent_name,
 
 	pr_debug("%s: parent %s rate %lu\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			clk_provider_get_rate(clk));
 
 	return clk;
 }
 
-static struct clk * __init clkgen_c65_lsdiv_register(const char *parent_name,
+static struct clk_core * __init clkgen_c65_lsdiv_register(const char *parent_name,
 						     const char *clk_name)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0, 1, 2);
 	if (IS_ERR(clk))
@@ -391,8 +391,8 @@ static struct clk * __init clkgen_c65_lsdiv_register(const char *parent_name,
 
 	pr_debug("%s: parent %s rate %lu\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			clk_provider_get_rate(clk));
 	return clk;
 }
 
@@ -436,7 +436,7 @@ static void __init clkgena_c65_pll_setup(struct device_node *np)
 		return;
 
 	clk_data->clk_num = num_pll_outputs;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
+	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk_core *),
 				 GFP_KERNEL);
 
 	if (!clk_data->clks)
@@ -497,14 +497,14 @@ err:
 CLK_OF_DECLARE(clkgena_c65_plls,
 	       "st,clkgena-plls-c65", clkgena_c65_pll_setup);
 
-static struct clk * __init clkgen_odf_register(const char *parent_name,
+static struct clk_core * __init clkgen_odf_register(const char *parent_name,
 					       void * __iomem reg,
 					       struct clkgen_pll_data *pll_data,
 					       int odf,
 					       spinlock_t *odf_lock,
 					       const char *odf_name)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned long flags;
 	struct clk_gate *gate;
 	struct clk_divider *div;
@@ -542,8 +542,8 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
 
 	pr_debug("%s: parent %s rate %lu\n",
 			__clk_get_name(clk),
-			__clk_get_name(clk_get_parent(clk)),
-			clk_get_rate(clk));
+			__clk_get_name(clk_provider_get_parent(clk)),
+			clk_provider_get_rate(clk));
 	return clk;
 }
 
@@ -578,7 +578,7 @@ static struct of_device_id c32_pll_of_match[] = {
 static void __init clkgen_c32_pll_setup(struct device_node *np)
 {
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name, *pll_name;
 	void __iomem *pll_base;
 	int num_odfs, odf;
@@ -614,14 +614,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np)
 		return;
 
 	clk_data->clk_num = num_odfs;
-	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk *),
+	clk_data->clks = kzalloc(clk_data->clk_num * sizeof(struct clk_core *),
 				 GFP_KERNEL);
 
 	if (!clk_data->clks)
 		goto err;
 
 	for (odf = 0; odf < num_odfs; odf++) {
-		struct clk *clk;
+		struct clk_core *clk;
 		const char *clk_name;
 
 		if (of_property_read_string_index(np, "clock-output-names",
@@ -661,7 +661,7 @@ static struct of_device_id c32_gpu_pll_of_match[] = {
 static void __init clkgengpu_c32_pll_setup(struct device_node *np)
 {
 	const struct of_device_id *match;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	void __iomem *reg;
 	const char *clk_name;
diff --git a/drivers/clk/sunxi/clk-a10-hosc.c b/drivers/clk/sunxi/clk-a10-hosc.c
index 0481d5d..c5e4c41 100644
--- a/drivers/clk/sunxi/clk-a10-hosc.c
+++ b/drivers/clk/sunxi/clk-a10-hosc.c
@@ -25,7 +25,7 @@ static DEFINE_SPINLOCK(hosc_lock);
 
 static void __init sun4i_osc_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_fixed_rate *fixed;
 	struct clk_gate *gate;
 	const char *clk_name = node->name;
diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
index 633ddc4..3e58734 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -55,7 +55,7 @@ static DEFINE_SPINLOCK(gmac_lock);
 
 static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_mux *mux;
 	struct clk_gate *gate;
 	const char *clk_name = node->name;
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 3806d97..3acdda6 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -79,9 +79,9 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 
 static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_p)
+				       struct clk_core **best_parent_p)
 {
-	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
+	struct clk_core *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
 	unsigned long parent_rate, best = 0, child_rate, best_child_rate = 0;
 
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 670f90d..727a6a2 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -50,7 +50,7 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 
 	clk_data->clks = devm_kzalloc(&pdev->dev,
 				      SUN6I_APB0_GATES_MAX_SIZE *
-				      sizeof(struct clk *),
+				      sizeof(struct clk_core *),
 				      GFP_KERNEL);
 	if (!clk_data->clks)
 		return -ENOMEM;
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0.c b/drivers/clk/sunxi/clk-sun6i-apb0.c
index 11f17c3..241d274 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0.c
@@ -35,7 +35,7 @@ static int sun6i_a31_apb0_clk_probe(struct platform_device *pdev)
 	const char *clk_parent;
 	struct resource *r;
 	void __iomem *reg;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(&pdev->dev, r);
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index f73cc05..1e95eb4 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -46,7 +46,7 @@ static unsigned long ar100_recalc_rate(struct clk_hw *hw,
 
 static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *best_parent_rate,
-				 struct clk **best_parent_clk)
+				 struct clk_core **best_parent_clk)
 {
 	int nparents = __clk_get_num_parents(hw->clk);
 	long best_rate = -EINVAL;
@@ -57,7 +57,7 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 	for (i = 0; i < nparents; i++) {
 		unsigned long parent_rate;
 		unsigned long tmp_rate;
-		struct clk *parent;
+		struct clk_core *parent;
 		unsigned long div;
 		int shift;
 
@@ -176,7 +176,7 @@ static int sun6i_a31_ar100_clk_probe(struct platform_device *pdev)
 	struct clk_init_data init;
 	struct ar100_clk *ar100;
 	struct resource *r;
-	struct clk *clk;
+	struct clk_core *clk;
 	int nparents;
 	int i;
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index fb2ce84..ab4c3d0 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -355,7 +355,7 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
  * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
  */
 
-void clk_sunxi_mmc_phase_control(struct clk *clk, u8 sample, u8 output)
+void clk_sunxi_mmc_phase_control(struct clk_core *clk, u8 sample, u8 output)
 {
 	#define to_clk_composite(_hw) container_of(_hw, struct clk_composite, hw)
 	#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
@@ -516,10 +516,10 @@ static const struct factors_data sun7i_a20_out_data __initconst = {
 	.getter = sun7i_a20_get_out_factors,
 };
 
-static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
+static struct clk_core * __init sunxi_factors_clk_setup(struct device_node *node,
 						const struct factors_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_factors *factors;
 	struct clk_gate *gate = NULL;
 	struct clk_mux *mux = NULL;
@@ -629,7 +629,7 @@ static const struct mux_data sun4i_apb1_mux_data __initconst = {
 static void __init sunxi_mux_clk_setup(struct device_node *node,
 				       struct mux_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	const char *parents[SUNXI_MAX_PARENTS];
 	void *reg;
@@ -693,7 +693,7 @@ static const struct div_data sun6i_a31_apb2_div_data __initconst = {
 static void __init sunxi_divider_clk_setup(struct device_node *node,
 					   struct div_data *data)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	const char *clk_parent;
 	void *reg;
@@ -881,7 +881,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
 	if (!clk_data)
 		return;
-	clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
+	clk_data->clks = kzalloc((qty+1) * sizeof(struct clk_core *), GFP_KERNEL);
 	if (!clk_data->clks) {
 		kfree(clk_data);
 		return;
@@ -985,7 +985,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 	struct clk_onecell_data *clk_data;
 	const char *parent;
 	const char *clk_name;
-	struct clk **clks, *pclk;
+	struct clk_core **clks, *pclk;
 	struct clk_hw *gate_hw, *rate_hw;
 	const struct clk_ops *rate_ops;
 	struct clk_gate *gate = NULL;
@@ -1193,10 +1193,10 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 
 	/* Protect the clocks that needs to stay on */
 	for (i = 0; i < nclocks; i++) {
-		struct clk *clk = clk_get(NULL, clocks[i]);
+		struct clk_core *clk = clk_provider_get(NULL, clocks[i]);
 
 		if (!IS_ERR(clk))
-			clk_prepare_enable(clk);
+			clk_provider_prepare_enable(clk);
 	}
 }
 
diff --git a/drivers/clk/tegra/clk-audio-sync.c b/drivers/clk/tegra/clk-audio-sync.c
index c0f7843..53c3488 100644
--- a/drivers/clk/tegra/clk-audio-sync.c
+++ b/drivers/clk/tegra/clk-audio-sync.c
@@ -54,12 +54,12 @@ const struct clk_ops tegra_clk_sync_source_ops = {
 	.recalc_rate = clk_sync_source_recalc_rate,
 };
 
-struct clk *tegra_clk_register_sync_source(const char *name,
+struct clk_core *tegra_clk_register_sync_source(const char *name,
 		unsigned long rate, unsigned long max_rate)
 {
 	struct tegra_clk_sync_source *sync;
 	struct clk_init_data init;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	sync = kzalloc(sizeof(*sync), GFP_KERNEL);
 	if (!sync) {
diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 290f9c1..7a1212b7 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -147,13 +147,13 @@ const struct clk_ops tegra_clk_frac_div_ops = {
 	.round_rate = clk_frac_div_round_rate,
 };
 
-struct clk *tegra_clk_register_divider(const char *name,
+struct clk_core *tegra_clk_register_divider(const char *name,
 		const char *parent_name, void __iomem *reg,
 		unsigned long flags, u8 clk_divider_flags, u8 shift, u8 width,
 		u8 frac_width, spinlock_t *lock)
 {
 	struct tegra_clk_frac_div *divider;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
diff --git a/drivers/clk/tegra/clk-periph-gate.c b/drivers/clk/tegra/clk-periph-gate.c
index 5070153..5aaedd3 100644
--- a/drivers/clk/tegra/clk-periph-gate.c
+++ b/drivers/clk/tegra/clk-periph-gate.c
@@ -127,12 +127,12 @@ const struct clk_ops tegra_clk_periph_gate_ops = {
 	.disable = clk_periph_disable,
 };
 
-struct clk *tegra_clk_register_periph_gate(const char *name,
+struct clk_core *tegra_clk_register_periph_gate(const char *name,
 		const char *parent_name, u8 gate_flags, void __iomem *clk_base,
 		unsigned long flags, int clk_num, int *enable_refcnt)
 {
 	struct tegra_clk_periph_gate *gate;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	struct tegra_clk_periph_regs *pregs;
 
diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 9e899c18..ea26de3 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -138,13 +138,13 @@ static const struct clk_ops tegra_clk_periph_no_gate_ops = {
 	.set_rate = clk_periph_set_rate,
 };
 
-static struct clk *_tegra_clk_register_periph(const char *name,
+static struct clk_core *_tegra_clk_register_periph(const char *name,
 			const char **parent_names, int num_parents,
 			struct tegra_clk_periph *periph,
 			void __iomem *clk_base, u32 offset,
 			unsigned long flags)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 	struct tegra_clk_periph_regs *bank;
 	bool div = !(periph->gate.flags & TEGRA_PERIPH_NO_DIV);
@@ -186,7 +186,7 @@ static struct clk *_tegra_clk_register_periph(const char *name,
 	return clk;
 }
 
-struct clk *tegra_clk_register_periph(const char *name,
+struct clk_core *tegra_clk_register_periph(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
 		u32 offset, unsigned long flags)
@@ -195,7 +195,7 @@ struct clk *tegra_clk_register_periph(const char *name,
 			periph, clk_base, offset, flags);
 }
 
-struct clk *tegra_clk_register_periph_nodiv(const char *name,
+struct clk_core *tegra_clk_register_periph_nodiv(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
 		u32 offset)
diff --git a/drivers/clk/tegra/clk-pll-out.c b/drivers/clk/tegra/clk-pll-out.c
index 3598987..49ae7b1 100644
--- a/drivers/clk/tegra/clk-pll-out.c
+++ b/drivers/clk/tegra/clk-pll-out.c
@@ -87,13 +87,13 @@ const struct clk_ops tegra_clk_pll_out_ops = {
 	.disable = clk_pll_out_disable,
 };
 
-struct clk *tegra_clk_register_pll_out(const char *name,
+struct clk_core *tegra_clk_register_pll_out(const char *name,
 		const char *parent_name, void __iomem *reg, u8 enb_bit_idx,
 		u8 rst_bit_idx, unsigned long flags, u8 pll_out_flags,
 		spinlock_t *lock)
 {
 	struct tegra_clk_pll_out *pll_out;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	pll_out = kzalloc(sizeof(*pll_out), GFP_KERNEL);
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 637b62c..34063ed 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -723,7 +723,7 @@ static int clk_plle_training(struct tegra_clk_pll *pll)
 static int clk_plle_enable(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
-	unsigned long input_rate = clk_get_rate(clk_get_parent(hw->clk));
+	unsigned long input_rate = clk_provider_get_rate(clk_provider_get_parent(hw->clk));
 	struct tegra_clk_pll_freq_table sel;
 	u32 val;
 	int err;
@@ -1027,7 +1027,7 @@ static int clk_pllm_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	state = clk_pll_is_enabled(hw);
 	if (state) {
-		if (rate != clk_get_rate(hw->clk)) {
+		if (rate != clk_provider_get_rate(hw->clk)) {
 			pr_err("%s: Cannot change active PLLM\n", __func__);
 			ret = -EINVAL;
 			goto out;
@@ -1279,7 +1279,7 @@ static int clk_plle_tegra114_enable(struct clk_hw *hw)
 	u32 val;
 	int ret;
 	unsigned long flags = 0;
-	unsigned long input_rate = clk_get_rate(clk_get_parent(hw->clk));
+	unsigned long input_rate = clk_provider_get_rate(clk_provider_get_parent(hw->clk));
 
 	if (_get_table_rate(hw, &sel, pll->params->fixed_rate, input_rate))
 		return -EINVAL;
@@ -1411,7 +1411,7 @@ static struct tegra_clk_pll *_tegra_init_pll(void __iomem *clk_base,
 	return pll;
 }
 
-static struct clk *_tegra_clk_register_pll(struct tegra_clk_pll *pll,
+static struct clk_core *_tegra_clk_register_pll(struct tegra_clk_pll *pll,
 		const char *name, const char *parent_name, unsigned long flags,
 		const struct clk_ops *ops)
 {
@@ -1429,13 +1429,13 @@ static struct clk *_tegra_clk_register_pll(struct tegra_clk_pll *pll,
 	return clk_register(NULL, &pll->hw);
 }
 
-struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pll(const char *name, const char *parent_name,
 		void __iomem *clk_base, void __iomem *pmc,
 		unsigned long flags, struct tegra_clk_pll_params *pll_params,
 		spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	pll_params->flags |= TEGRA_PLL_BYPASS;
 	pll_params->flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
@@ -1460,13 +1460,13 @@ static struct div_nmp pll_e_nmp = {
 	.divp_width = PLLE_BASE_DIVP_WIDTH,
 };
 
-struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_plle(const char *name, const char *parent_name,
 		void __iomem *clk_base, void __iomem *pmc,
 		unsigned long flags, struct tegra_clk_pll_params *pll_params,
 		spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	pll_params->flags |= TEGRA_PLL_LOCK_MISC | TEGRA_PLL_BYPASS;
 	pll_params->flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
@@ -1531,14 +1531,14 @@ static const struct clk_ops tegra_clk_plle_tegra114_ops = {
 };
 
 
-struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllxc(const char *name, const char *parent_name,
 			  void __iomem *clk_base, void __iomem *pmc,
 			  unsigned long flags,
 			  struct tegra_clk_pll_params *pll_params,
 			  spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk, *parent;
+	struct clk_core *clk, *parent;
 	unsigned long parent_rate;
 	int err;
 	u32 val, val_iddq;
@@ -1584,7 +1584,7 @@ struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
 	return clk;
 }
 
-struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllre(const char *name, const char *parent_name,
 			  void __iomem *clk_base, void __iomem *pmc,
 			  unsigned long flags,
 			  struct tegra_clk_pll_params *pll_params,
@@ -1592,7 +1592,7 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
 {
 	u32 val;
 	struct tegra_clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	pll_params->flags |= TEGRA_PLL_HAS_LOCK_ENABLE | TEGRA_PLL_LOCK_MISC;
 
@@ -1630,14 +1630,14 @@ struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
 	return clk;
 }
 
-struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllm(const char *name, const char *parent_name,
 			  void __iomem *clk_base, void __iomem *pmc,
 			  unsigned long flags,
 			  struct tegra_clk_pll_params *pll_params,
 			  spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk, *parent;
+	struct clk_core *clk, *parent;
 	unsigned long parent_rate;
 
 	if (!pll_params->pdiv_tohw)
@@ -1669,13 +1669,13 @@ struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
 	return clk;
 }
 
-struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllc(const char *name, const char *parent_name,
 			  void __iomem *clk_base, void __iomem *pmc,
 			  unsigned long flags,
 			  struct tegra_clk_pll_params *pll_params,
 			  spinlock_t *lock)
 {
-	struct clk *parent, *clk;
+	struct clk_core *parent, *clk;
 	struct pdiv_map *p_tohw = pll_params->pdiv_tohw;
 	struct tegra_clk_pll *pll;
 	struct tegra_clk_pll_freq_table cfg;
@@ -1743,14 +1743,14 @@ struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
 	return clk;
 }
 
-struct clk *tegra_clk_register_plle_tegra114(const char *name,
+struct clk_core *tegra_clk_register_plle_tegra114(const char *name,
 				const char *parent_name,
 				void __iomem *clk_base, unsigned long flags,
 				struct tegra_clk_pll_params *pll_params,
 				spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 val, val_aux;
 
 	pll_params->flags |= TEGRA_PLL_HAS_LOCK_ENABLE;
@@ -1793,13 +1793,13 @@ static const struct clk_ops tegra_clk_pllss_ops = {
 	.set_rate = clk_pllxc_set_rate,
 };
 
-struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllss(const char *name, const char *parent_name,
 				void __iomem *clk_base, unsigned long flags,
 				struct tegra_clk_pll_params *pll_params,
 				spinlock_t *lock)
 {
 	struct tegra_clk_pll *pll;
-	struct clk *clk, *parent;
+	struct clk_core *clk, *parent;
 	struct tegra_clk_pll_freq_table cfg;
 	unsigned long parent_rate;
 	u32 val;
diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 2fd924d..e843d20 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -127,13 +127,13 @@ const struct clk_ops tegra_clk_super_ops = {
 	.set_parent = clk_super_set_parent,
 };
 
-struct clk *tegra_clk_register_super_mux(const char *name,
+struct clk_core *tegra_clk_register_super_mux(const char *name,
 		const char **parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		u8 width, u8 pllx_index, u8 div2_index, spinlock_t *lock)
 {
 	struct tegra_clk_super_mux *super;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	super = kzalloc(sizeof(*super), GFP_KERNEL);
diff --git a/drivers/clk/tegra/clk-tegra-audio.c b/drivers/clk/tegra/clk-tegra-audio.c
index 5c38aab..484a900 100644
--- a/drivers/clk/tegra/clk-tegra-audio.c
+++ b/drivers/clk/tegra/clk-tegra-audio.c
@@ -128,8 +128,8 @@ void __init tegra_audio_clk_init(void __iomem *clk_base,
 			void __iomem *pmc_base, struct tegra_clk *tegra_clks,
 			struct tegra_clk_pll_params *pll_a_params)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 	int i;
 
 	/* PLLA */
diff --git a/drivers/clk/tegra/clk-tegra-fixed.c b/drivers/clk/tegra/clk-tegra-fixed.c
index f3b7738..503e261 100644
--- a/drivers/clk/tegra/clk-tegra-fixed.c
+++ b/drivers/clk/tegra/clk-tegra-fixed.c
@@ -36,8 +36,8 @@ int __init tegra_osc_clk_init(void __iomem *clk_base,
 				unsigned long *osc_freq,
 				unsigned long *pll_ref_freq)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 	u32 val, pll_ref_div;
 	unsigned osc_idx;
 
@@ -81,8 +81,8 @@ int __init tegra_osc_clk_init(void __iomem *clk_base,
 
 void __init tegra_fixed_clk_init(struct tegra_clk *tegra_clks)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 
 	/* clk_32k */
 	dt_clk = tegra_lookup_dt_id(tegra_clk_clk_32k, tegra_clks);
diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index adf6b81..dd06579 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -585,8 +585,8 @@ static void __init periph_clk_init(void __iomem *clk_base,
 				struct tegra_clk *tegra_clks)
 {
 	int i;
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 
 	for (i = 0; i < ARRAY_SIZE(periph_clks); i++) {
 		struct tegra_clk_periph_regs *bank;
@@ -615,8 +615,8 @@ static void __init gate_clk_init(void __iomem *clk_base,
 				struct tegra_clk *tegra_clks)
 {
 	int i;
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 
 	for (i = 0; i < ARRAY_SIZE(gate_clks); i++) {
 		struct tegra_periph_init_data *data;
@@ -640,8 +640,8 @@ static void __init init_pllp(void __iomem *clk_base, void __iomem *pmc_base,
 				struct tegra_clk *tegra_clks,
 				struct tegra_clk_pll_params *pll_params)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 	int i;
 
 	dt_clk = tegra_lookup_dt_id(tegra_clk_pll_p, tegra_clks);
diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
index 08b21c1..2ff427a 100644
--- a/drivers/clk/tegra/clk-tegra-pmc.c
+++ b/drivers/clk/tegra/clk-tegra-pmc.c
@@ -82,8 +82,8 @@ static struct pmc_clk_init_data pmc_clks[] = {
 void __init tegra_pmc_clk_init(void __iomem *pmc_base,
 				struct tegra_clk *tegra_clks)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pmc_clks); i++) {
diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index feb3201..e6224c4 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -53,8 +53,8 @@ static const char *cclk_lp_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 static void __init tegra_sclk_init(void __iomem *clk_base,
 				struct tegra_clk *tegra_clks)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 
 	/* SCLK */
 	dt_clk = tegra_lookup_dt_id(tegra_clk_sclk, tegra_clks);
@@ -99,8 +99,8 @@ void __init tegra_super_clk_gen4_init(void __iomem *clk_base,
 				struct tegra_clk *tegra_clks,
 				struct tegra_clk_pll_params *params)
 {
-	struct clk *clk;
-	struct clk **dt_clk;
+	struct clk_core *clk;
+	struct clk_core **dt_clk;
 
 	/* CCLKG */
 	dt_clk = tegra_lookup_dt_id(tegra_clk_cclk_g, tegra_clks);
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index b9c8ba2..a16e064 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -923,14 +923,14 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .dev_id = "timer", .dt_id = TEGRA114_CLK_TIMER },
 };
 
-static struct clk **clks;
+static struct clk_core **clks;
 
 static unsigned long osc_freq;
 static unsigned long pll_ref_freq;
 
 static int __init tegra114_osc_clk_init(void __iomem *clk_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 val, pll_ref_div;
 
 	val = readl_relaxed(clk_base + OSC_CTRL);
@@ -960,7 +960,7 @@ static int __init tegra114_osc_clk_init(void __iomem *clk_base)
 
 static void __init tegra114_fixed_clk_init(void __iomem *clk_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* clk_32k */
 	clk = clk_register_fixed_rate(NULL, "clk_32k", NULL, CLK_IS_ROOT,
@@ -1065,7 +1065,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
 				     void __iomem *pmc)
 {
 	u32 val;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* PLLC */
 	clk = tegra_clk_register_pllxc("pll_c", "pll_ref", clk_base,
@@ -1181,7 +1181,7 @@ static void __init tegra114_pll_init(void __iomem *clk_base,
 static __init void tegra114_periph_clk_init(void __iomem *clk_base,
 					    void __iomem *pmc_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* xusb_ss_div2 */
 	clk = clk_register_fixed_factor(NULL, "xusb_ss_div2", "xusb_ss_src", 0,
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 80efe51..b77cb64 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1017,7 +1017,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .dev_id = "timer", .dt_id = TEGRA124_CLK_TIMER },
 };
 
-static struct clk **clks;
+static struct clk_core **clks;
 
 static void tegra124_utmi_param_configure(void __iomem *clk_base)
 {
@@ -1104,7 +1104,7 @@ static void tegra124_utmi_param_configure(void __iomem *clk_base)
 static __init void tegra124_periph_clk_init(void __iomem *clk_base,
 					    void __iomem *pmc_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* xusb_ss_div2 */
 	clk = clk_register_fixed_factor(NULL, "xusb_ss_div2", "xusb_ss_src", 0,
@@ -1148,7 +1148,7 @@ static void __init tegra124_pll_init(void __iomem *clk_base,
 				     void __iomem *pmc)
 {
 	u32 val;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* PLLC */
 	clk = tegra_clk_register_pllxc("pll_c", "pll_ref", clk_base,
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index dace2b1..6783355 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -162,7 +162,7 @@ static void __iomem *pmc_base;
 			_clk_num, _gate_flags,	\
 			_clk_id)
 
-static struct clk **clks;
+static struct clk_core **clks;
 
 static struct tegra_clk_pll_freq_table pll_c_freq_table[] = {
 	{ 12000000, 600000000, 600, 12, 0, 8 },
@@ -633,7 +633,7 @@ static unsigned int tegra20_get_pll_ref_div(void)
 
 static void tegra20_pll_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* PLLC */
 	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, NULL, 0,
@@ -713,7 +713,7 @@ static const char *sclk_parents[] = { "clk_m", "pll_c_out1", "pll_p_out4",
 
 static void tegra20_super_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* CCLK */
 	clk = tegra_clk_register_super_mux("cclk", cclk_parents,
@@ -738,7 +738,7 @@ static const char *audio_parents[] = {"spdif_in", "i2s1", "i2s2", "unused",
 
 static void __init tegra20_audio_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* audio */
 	clk = clk_register_mux(NULL, "audio_mux", audio_parents,
@@ -800,7 +800,7 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 static void __init tegra20_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	/* ac97 */
@@ -871,7 +871,7 @@ static void __init tegra20_periph_clk_init(void)
 
 static void __init tegra20_osc_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	unsigned long input_freq;
 	unsigned int pll_ref_div;
 
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 8b10c38..801bb61 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -202,7 +202,7 @@ static DEFINE_SPINLOCK(pll_d_lock);
 			_clk_num, _gate_flags,	\
 			_clk_id)
 
-static struct clk **clks;
+static struct clk_core **clks;
 
 /*
  * Structure defining the fields for USB UTMI clocks Parameters.
@@ -918,7 +918,7 @@ static const char *pll_e_parents[] = {"pll_ref", "pll_p"};
 
 static void __init tegra30_pll_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* PLLC */
 	clk = tegra_clk_register_pll("pll_c", "pll_ref", clk_base, pmc_base, 0,
@@ -1009,7 +1009,7 @@ static const char *sclk_parents[] = { "clk_m", "pll_c_out1", "pll_p_out4",
 
 static void __init tegra30_super_clk_init(void)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/*
 	 * Clock input to cclk_g divided from pll_p using
@@ -1131,7 +1131,7 @@ static struct tegra_periph_init_data tegra_periph_nodiv_clk_list[] = {
 static void __init tegra30_periph_clk_init(void)
 {
 	struct tegra_periph_init_data *data;
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	/* dsia */
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index c0a7d77..229ac1e 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -68,7 +68,7 @@ struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
 
 int *periph_clk_enb_refcnt;
 static int periph_banks;
-static struct clk **clks;
+static struct clk_core **clks;
 static int clk_num;
 static struct clk_onecell_data clk_data;
 
@@ -164,7 +164,7 @@ struct tegra_clk_periph_regs *get_reg_bank(int clkid)
 	}
 }
 
-struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
+struct clk_core ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 {
 	clk_base = regs;
 
@@ -178,7 +178,7 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 
 	periph_banks = banks;
 
-	clks = kzalloc(num * sizeof(struct clk *), GFP_KERNEL);
+	clks = kzalloc(num * sizeof(struct clk_core *), GFP_KERNEL);
 	if (!clks)
 		kfree(periph_clk_enb_refcnt);
 
@@ -188,9 +188,9 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 }
 
 void __init tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
-				struct clk *clks[], int clk_max)
+				struct clk_core *clks[], int clk_max)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	for (; dup_list->clk_id < clk_max; dup_list++) {
 		clk = clks[dup_list->clk_id];
@@ -200,9 +200,9 @@ void __init tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
 }
 
 void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
-				  struct clk *clks[], int clk_max)
+				  struct clk_core *clks[], int clk_max)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	for (; tbl->clk_id < clk_max; tbl++) {
 		clk = clks[tbl->clk_id];
@@ -210,8 +210,8 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 			return;
 
 		if (tbl->parent_id < clk_max) {
-			struct clk *parent = clks[tbl->parent_id];
-			if (clk_set_parent(clk, parent)) {
+			struct clk_core *parent = clks[tbl->parent_id];
+			if (clk_provider_set_parent(clk, parent)) {
 				pr_err("%s: Failed to set parent %s of %s\n",
 				       __func__, __clk_get_name(parent),
 				       __clk_get_name(clk));
@@ -220,7 +220,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 		}
 
 		if (tbl->rate)
-			if (clk_set_rate(clk, tbl->rate)) {
+			if (clk_provider_set_rate(clk, tbl->rate)) {
 				pr_err("%s: Failed to set rate %lu of %s\n",
 				       __func__, tbl->rate,
 				       __clk_get_name(clk));
@@ -228,7 +228,7 @@ void __init tegra_init_from_table(struct tegra_clk_init_table *tbl,
 			}
 
 		if (tbl->state)
-			if (clk_prepare_enable(clk)) {
+			if (clk_provider_prepare_enable(clk)) {
 				pr_err("%s: Failed to enable %s\n", __func__,
 				       __clk_get_name(clk));
 				WARN_ON(1);
@@ -279,7 +279,7 @@ void __init tegra_register_devclks(struct tegra_devclk *dev_clks, int num)
 				dev_clks->dev_id);
 }
 
-struct clk ** __init tegra_lookup_dt_id(int clk_id,
+struct clk_core ** __init tegra_lookup_dt_id(int clk_id,
 					struct tegra_clk *tegra_clk)
 {
 	if (tegra_clk[clk_id].present)
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 16ec8d6..3093aa4 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -39,7 +39,7 @@ struct tegra_clk_sync_source {
 extern const struct clk_ops tegra_clk_sync_source_ops;
 extern int *periph_clk_enb_refcnt;
 
-struct clk *tegra_clk_register_sync_source(const char *name,
+struct clk_core *tegra_clk_register_sync_source(const char *name,
 		unsigned long fixed_rate, unsigned long max_rate);
 
 /**
@@ -82,7 +82,7 @@ struct tegra_clk_frac_div {
 #define TEGRA_DIVIDER_UART BIT(3)
 
 extern const struct clk_ops tegra_clk_frac_div_ops;
-struct clk *tegra_clk_register_divider(const char *name,
+struct clk_core *tegra_clk_register_divider(const char *name,
 		const char *parent_name, void __iomem *reg,
 		unsigned long flags, u8 clk_divider_flags, u8 shift, u8 width,
 		u8 frac_width, spinlock_t *lock);
@@ -258,47 +258,47 @@ struct tegra_clk_pll {
 
 extern const struct clk_ops tegra_clk_pll_ops;
 extern const struct clk_ops tegra_clk_plle_ops;
-struct clk *tegra_clk_register_pll(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pll(const char *name, const char *parent_name,
 		void __iomem *clk_base, void __iomem *pmc,
 		unsigned long flags, struct tegra_clk_pll_params *pll_params,
 		spinlock_t *lock);
 
-struct clk *tegra_clk_register_plle(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_plle(const char *name, const char *parent_name,
 		void __iomem *clk_base, void __iomem *pmc,
 		unsigned long flags, struct tegra_clk_pll_params *pll_params,
 		spinlock_t *lock);
 
-struct clk *tegra_clk_register_pllxc(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllxc(const char *name, const char *parent_name,
 			    void __iomem *clk_base, void __iomem *pmc,
 			    unsigned long flags,
 			    struct tegra_clk_pll_params *pll_params,
 			    spinlock_t *lock);
 
-struct clk *tegra_clk_register_pllm(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllm(const char *name, const char *parent_name,
 			   void __iomem *clk_base, void __iomem *pmc,
 			   unsigned long flags,
 			   struct tegra_clk_pll_params *pll_params,
 			   spinlock_t *lock);
 
-struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllc(const char *name, const char *parent_name,
 			   void __iomem *clk_base, void __iomem *pmc,
 			   unsigned long flags,
 			   struct tegra_clk_pll_params *pll_params,
 			   spinlock_t *lock);
 
-struct clk *tegra_clk_register_pllre(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllre(const char *name, const char *parent_name,
 			   void __iomem *clk_base, void __iomem *pmc,
 			   unsigned long flags,
 			   struct tegra_clk_pll_params *pll_params,
 			   spinlock_t *lock, unsigned long parent_rate);
 
-struct clk *tegra_clk_register_plle_tegra114(const char *name,
+struct clk_core *tegra_clk_register_plle_tegra114(const char *name,
 				const char *parent_name,
 				void __iomem *clk_base, unsigned long flags,
 				struct tegra_clk_pll_params *pll_params,
 				spinlock_t *lock);
 
-struct clk *tegra_clk_register_pllss(const char *name, const char *parent_name,
+struct clk_core *tegra_clk_register_pllss(const char *name, const char *parent_name,
 			   void __iomem *clk_base, unsigned long flags,
 			   struct tegra_clk_pll_params *pll_params,
 			   spinlock_t *lock);
@@ -325,7 +325,7 @@ struct tegra_clk_pll_out {
 #define to_clk_pll_out(_hw) container_of(_hw, struct tegra_clk_pll_out, hw)
 
 extern const struct clk_ops tegra_clk_pll_out_ops;
-struct clk *tegra_clk_register_pll_out(const char *name,
+struct clk_core *tegra_clk_register_pll_out(const char *name,
 		const char *parent_name, void __iomem *reg, u8 enb_bit_idx,
 		u8 rst_bit_idx, unsigned long flags, u8 pll_div_flags,
 		spinlock_t *lock);
@@ -394,7 +394,7 @@ struct tegra_clk_periph_gate {
 #define TEGRA_PERIPH_NO_GATE BIT(5)
 
 extern const struct clk_ops tegra_clk_periph_gate_ops;
-struct clk *tegra_clk_register_periph_gate(const char *name,
+struct clk_core *tegra_clk_register_periph_gate(const char *name,
 		const char *parent_name, u8 gate_flags, void __iomem *clk_base,
 		unsigned long flags, int clk_num, int *enable_refcnt);
 
@@ -427,11 +427,11 @@ struct tegra_clk_periph {
 #define TEGRA_CLK_PERIPH_MAGIC 0x18221223
 
 extern const struct clk_ops tegra_clk_periph_ops;
-struct clk *tegra_clk_register_periph(const char *name,
+struct clk_core *tegra_clk_register_periph(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
 		u32 offset, unsigned long flags);
-struct clk *tegra_clk_register_periph_nodiv(const char *name,
+struct clk_core *tegra_clk_register_periph_nodiv(const char *name,
 		const char **parent_names, int num_parents,
 		struct tegra_clk_periph *periph, void __iomem *clk_base,
 		u32 offset);
@@ -540,7 +540,7 @@ struct tegra_clk_super_mux {
 #define TEGRA_DIVIDER_2 BIT(0)
 
 extern const struct clk_ops tegra_clk_super_ops;
-struct clk *tegra_clk_register_super_mux(const char *name,
+struct clk_core *tegra_clk_register_super_mux(const char *name,
 		const char **parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		u8 width, u8 pllx_index, u8 div2_index, spinlock_t *lock);
@@ -590,15 +590,15 @@ struct tegra_devclk {
 };
 
 void tegra_init_from_table(struct tegra_clk_init_table *tbl,
-		struct clk *clks[], int clk_max);
+		struct clk_core *clks[], int clk_max);
 
 void tegra_init_dup_clks(struct tegra_clk_duplicate *dup_list,
-		struct clk *clks[], int clk_max);
+		struct clk_core *clks[], int clk_max);
 
 struct tegra_clk_periph_regs *get_reg_bank(int clkid);
-struct clk **tegra_clk_init(void __iomem *clk_base, int num, int periph_banks);
+struct clk_core **tegra_clk_init(void __iomem *clk_base, int num, int periph_banks);
 
-struct clk **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
+struct clk_core **tegra_lookup_dt_id(int clk_id, struct tegra_clk *tegra_clk);
 
 void tegra_add_of_provider(struct device_node *np);
 void tegra_register_devclks(struct tegra_devclk *dev_clks, int num);
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 72d9727..a162c21 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -135,10 +135,10 @@ static void __init omap_clk_register_apll(struct clk_hw *hw,
 {
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *ad = clk_hw->dpll_data;
-	struct clk *clk;
+	struct clk_core *clk;
 
-	ad->clk_ref = of_clk_get(node, 0);
-	ad->clk_bypass = of_clk_get(node, 1);
+	ad->clk_ref = of_clk_provider_get(node, 0);
+	ad->clk_bypass = of_clk_provider_get(node, 1);
 
 	if (IS_ERR(ad->clk_ref) || IS_ERR(ad->clk_bypass)) {
 		pr_debug("clk-ref or clk-bypass for %s not ready, retry\n",
@@ -332,7 +332,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	struct dpll_data *ad = NULL;
 	struct clk_hw_omap *clk_hw = NULL;
 	struct clk_init_data *init = NULL;
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	u32 val;
 
diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index c808ab3..a48fe6f 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -237,10 +237,10 @@ static int __init omap2xxx_dt_clk_init(int soc_type)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/DPLL/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "sys_ck")) / 100000) % 10,
-		(clk_get_rate(clk_get_sys(NULL, "dpll_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "mpu_ck")) / 1000000));
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "sys_ck")) / 1000000),
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "sys_ck")) / 100000) % 10,
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "dpll_ck")) / 1000000),
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "mpu_ck")) / 1000000));
 
 	return 0;
 }
diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 028b337..0988f1e 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -121,7 +121,7 @@ static const char *enable_init_clks[] = {
 
 int __init am33xx_dt_clk_init(void)
 {
-	struct clk *clk1, *clk2;
+	struct clk_core *clk1, *clk2;
 
 	ti_dt_clocks_register(am33xx_clks);
 
@@ -139,12 +139,12 @@ int __init am33xx_dt_clk_init(void)
 	 *    oscillator clock.
 	 */
 
-	clk1 = clk_get_sys(NULL, "sys_clkin_ck");
-	clk2 = clk_get_sys(NULL, "timer3_fck");
-	clk_set_parent(clk2, clk1);
+	clk1 = clk_provider_get_sys(NULL, "sys_clkin_ck");
+	clk2 = clk_provider_get_sys(NULL, "timer3_fck");
+	clk_provider_set_parent(clk2, clk1);
 
-	clk2 = clk_get_sys(NULL, "timer6_fck");
-	clk_set_parent(clk2, clk1);
+	clk2 = clk_provider_get_sys(NULL, "timer6_fck");
+	clk_provider_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
 	 * the design/spec, so as a result, for example, timer which supposed
@@ -152,9 +152,9 @@ int __init am33xx_dt_clk_init(void)
 	 * not expected by any use-case, so change WDT1 clock source to PRCM
 	 * 32KHz clock.
 	 */
-	clk1 = clk_get_sys(NULL, "wdt1_fck");
-	clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
-	clk_set_parent(clk1, clk2);
+	clk1 = clk_provider_get_sys(NULL, "wdt1_fck");
+	clk2 = clk_provider_get_sys(NULL, "clkdiv32k_ick");
+	clk_provider_set_parent(clk1, clk2);
 
 	return 0;
 }
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 0d1750a..58ef20e 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -365,10 +365,10 @@ static int __init omap3xxx_dt_clk_init(int soc_type)
 				     ARRAY_SIZE(enable_init_clks));
 
 	pr_info("Clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(clk_get_rate(clk_get_sys(NULL, "osc_sys_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "osc_sys_ck")) / 100000) % 10,
-		(clk_get_rate(clk_get_sys(NULL, "core_ck")) / 1000000),
-		(clk_get_rate(clk_get_sys(NULL, "arm_fck")) / 1000000));
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "osc_sys_ck")) / 1000000),
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "osc_sys_ck")) / 100000) % 10,
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "core_ck")) / 1000000),
+		(clk_provider_get_rate(clk_provider_get_sys(NULL, "arm_fck")) / 1000000));
 
 	if (soc_type != OMAP3_SOC_TI81XX && soc_type != OMAP3_SOC_OMAP3430_ES1)
 		omap3_clk_lock_dpll5();
diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce..1277452 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -116,7 +116,7 @@ static struct ti_dt_clk am43xx_clks[] = {
 
 int __init am43xx_dt_clk_init(void)
 {
-	struct clk *clk1, *clk2;
+	struct clk_core *clk1, *clk2;
 
 	ti_dt_clocks_register(am43xx_clks);
 
@@ -132,9 +132,9 @@ int __init am43xx_dt_clk_init(void)
 	 * By selecting dpll_core_m5_ck as the clocksource fixes this issue.
 	 * In AM335x dpll_core_m5_ck is the default clocksource.
 	 */
-	clk1 = clk_get_sys(NULL, "cpsw_cpts_rft_clk");
-	clk2 = clk_get_sys(NULL, "dpll_core_m5_ck");
-	clk_set_parent(clk1, clk2);
+	clk1 = clk_provider_get_sys(NULL, "cpsw_cpts_rft_clk");
+	clk2 = clk_provider_get_sys(NULL, "dpll_core_m5_ck");
+	clk_provider_set_parent(clk1, clk2);
 
 	return 0;
 }
diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 02517a8..1adc399 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -281,7 +281,7 @@ static struct ti_dt_clk omap44xx_clks[] = {
 int __init omap4xxx_dt_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
+	struct clk_core *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
 
 	ti_dt_clocks_register(omap44xx_clks);
 
@@ -291,8 +291,8 @@ int __init omap4xxx_dt_clk_init(void)
 	 * Lock USB DPLL on OMAP4 devices so that the L3INIT power
 	 * domain can transition to retention state when not in use.
 	 */
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
+	usb_dpll = clk_provider_get_sys(NULL, "dpll_usb_ck");
+	rc = clk_provider_set_rate(usb_dpll, OMAP4_DPLL_USB_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure USB DPLL!\n", __func__);
 
@@ -302,12 +302,12 @@ int __init omap4xxx_dt_clk_init(void)
 	 * locking the ABE DPLL on boot.
 	 * Lock the ABE DPLL in any case to avoid issues with audio.
 	 */
-	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_refclk_mux_ck");
-	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
-	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
-	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
+	abe_dpll_ref = clk_provider_get_sys(NULL, "abe_dpll_refclk_mux_ck");
+	sys_32k_ck = clk_provider_get_sys(NULL, "sys_32k_ck");
+	rc = clk_provider_set_parent(abe_dpll_ref, sys_32k_ck);
+	abe_dpll = clk_provider_get_sys(NULL, "dpll_abe_ck");
 	if (!rc)
-		rc = clk_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
+		rc = clk_provider_set_rate(abe_dpll, OMAP4_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 5e18399..5b603b5 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -225,34 +225,35 @@ static struct ti_dt_clk omap54xx_clks[] = {
 int __init omap5xxx_dt_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
+	struct clk_core *abe_dpll_ref, *abe_dpll, *sys_32k_ck, *usb_dpll;
 
 	ti_dt_clocks_register(omap54xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
-	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_clk_mux");
-	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
-	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
-	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
+	abe_dpll_ref = clk_provider_get_sys(NULL, "abe_dpll_clk_mux");
+	sys_32k_ck = clk_provider_get_sys(NULL, "sys_32k_ck");
+	rc = clk_provider_set_parent(abe_dpll_ref, sys_32k_ck);
+	abe_dpll = clk_provider_get_sys(NULL, "dpll_abe_ck");
 	if (!rc)
-		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
+		rc = clk_provider_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
-	abe_dpll = clk_get_sys(NULL, "dpll_abe_m2x2_ck");
+	abe_dpll = clk_provider_get_sys(NULL, "dpll_abe_m2x2_ck");
 	if (!rc)
-		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ * 2);
+		rc = clk_provider_set_rate(abe_dpll,
+					   OMAP5_DPLL_ABE_DEFFREQ * 2);
 	if (rc)
 		pr_err("%s: failed to configure ABE m2x2 DPLL!\n", __func__);
 
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_ck");
-	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
+	usb_dpll = clk_provider_get_sys(NULL, "dpll_usb_ck");
+	rc = clk_provider_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure USB DPLL!\n", __func__);
 
-	usb_dpll = clk_get_sys(NULL, "dpll_usb_m2_ck");
-	rc = clk_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ/2);
+	usb_dpll = clk_provider_get_sys(NULL, "dpll_usb_m2_ck");
+	rc = clk_provider_set_rate(usb_dpll, OMAP5_DPLL_USB_DEFFREQ / 2);
 	if (rc)
 		pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
 
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index e158133..02e5598 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -306,24 +306,24 @@ static struct ti_dt_clk dra7xx_clks[] = {
 int __init dra7xx_dt_clk_init(void)
 {
 	int rc;
-	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
+	struct clk_core *abe_dpll_mux, *sys_clkin2, *dpll_ck;
 
 	ti_dt_clocks_register(dra7xx_clks);
 
 	omap2_clk_disable_autoidle_all();
 
-	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
-	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
-	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
+	abe_dpll_mux = clk_provider_get_sys(NULL, "abe_dpll_sys_clk_mux");
+	sys_clkin2 = clk_provider_get_sys(NULL, "sys_clkin2");
+	dpll_ck = clk_provider_get_sys(NULL, "dpll_abe_ck");
 
-	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
+	rc = clk_provider_set_parent(abe_dpll_mux, sys_clkin2);
 	if (!rc)
-		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
+		rc = clk_provider_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
-	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
-	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
+	dpll_ck = clk_provider_get_sys(NULL, "dpll_gmac_ck");
+	rc = clk_provider_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
 
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index 4a65b41..029a0d3 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -40,7 +40,7 @@
 struct dra7_atl_clock_info;
 
 struct dra7_atl_desc {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_hw hw;
 	struct dra7_atl_clock_info *cinfo;
 	int id;
@@ -165,7 +165,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	struct dra7_atl_desc *clk_hw = NULL;
 	struct clk_init_data init = { 0 };
 	const char **parent_names = NULL;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	if (!clk_hw) {
@@ -233,7 +233,7 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		char prop[5];
 		struct dra7_atl_desc *cdesc;
 		struct of_phandle_args clkspec;
-		struct clk *clk;
+		struct clk_core *clk;
 		int rc;
 
 		rc = of_parse_phandle_with_args(node, "ti,provided-clocks",
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b1a6f71..d88a70d0 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -41,7 +41,7 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
 	struct device_node *node;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct of_phandle_args clkspec;
 
 	for (c = oclks; c->node_name != NULL; c++) {
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index f1e0038..6bc75d8 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -26,7 +26,7 @@
 
 static void __init of_ti_clockdomain_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_hw *clk_hw;
 	const char *clkdm_name = node->name;
 	int i;
@@ -35,7 +35,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
 
 	for (i = 0; i < num_clks; i++) {
-		clk = of_clk_get(node, i);
+		clk = of_clk_provider_get(node, i);
 		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
 			pr_warn("can't setup clkdm for basic clk %s\n",
 				__clk_get_name(clk));
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 19d8980..2cbee34 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -119,7 +119,7 @@ static inline struct clk_hw *_get_hw(struct clk_hw_omap_comp *clk, int idx)
 static void __init ti_clk_register_composite(struct clk_hw *hw,
 					     struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_hw_omap_comp *cclk = to_clk_hw_comp(hw);
 	struct component_clk *comp;
 	int num_parents = 0;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index e6aa10d..1c41515 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -246,7 +246,7 @@ const struct clk_ops ti_clk_divider_ops = {
 	.set_rate = ti_clk_divider_set_rate,
 };
 
-static struct clk *_register_divider(struct device *dev, const char *name,
+static struct clk_core *_register_divider(struct device *dev, const char *name,
 				     const char *parent_name,
 				     unsigned long flags, void __iomem *reg,
 				     u8 shift, u8 width, u8 clk_divider_flags,
@@ -254,7 +254,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 				     spinlock_t *lock)
 {
 	struct clk_divider *div;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
@@ -434,7 +434,7 @@ static int __init ti_clk_divider_populate(struct device_node *node,
  */
 static void __init of_ti_divider_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *parent_name;
 	void __iomem *reg;
 	u8 clk_divider_flags = 0;
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 79791e1..e1f74cc 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -128,10 +128,10 @@ static void __init ti_clk_register_dpll(struct clk_hw *hw,
 {
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
-	struct clk *clk;
+	struct clk_core *clk;
 
-	dd->clk_ref = of_clk_get(node, 0);
-	dd->clk_bypass = of_clk_get(node, 1);
+	dd->clk_ref = of_clk_provider_get(node, 0);
+	dd->clk_bypass = of_clk_provider_get(node, 1);
 
 	if (IS_ERR(dd->clk_ref) || IS_ERR(dd->clk_bypass)) {
 		pr_debug("clk-ref or clk-bypass missing for %s, retry later\n",
@@ -175,7 +175,7 @@ static void ti_clk_register_dpll_x2(struct device_node *node,
 				    const struct clk_ops *ops,
 				    const struct clk_hw_omap_ops *hw_ops)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
 	const char *name = node->name;
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index c2c8a28..2aa2701 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -33,7 +33,7 @@
  */
 static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
 	u32 div, mult;
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index b326d27..dd1b813 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -94,7 +94,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 					 const struct clk_ops *ops,
 					 const struct clk_hw_omap_ops *hw_ops)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
 	const char *clk_name = node->name;
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 9c3e8c4..e2f2bc0 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -34,7 +34,7 @@ static const struct clk_ops ti_interface_clk_ops = {
 static void __init _of_ti_interface_clk_setup(struct device_node *node,
 					      const struct clk_hw_omap_ops *ops)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
 	const char *parent_name;
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index e9d650e..7456198 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -104,14 +104,14 @@ const struct clk_ops ti_clk_mux_ops = {
 	.determine_rate = __clk_mux_determine_rate,
 };
 
-static struct clk *_register_mux(struct device *dev, const char *name,
+static struct clk_core *_register_mux(struct device *dev, const char *name,
 				 const char **parent_names, u8 num_parents,
 				 unsigned long flags, void __iomem *reg,
 				 u8 shift, u32 mask, u8 clk_mux_flags,
 				 u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_init_data init;
 
 	/* allocate the mux */
@@ -152,7 +152,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
  */
 static void of_mux_clk_setup(struct device_node *node)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	void __iomem *reg;
 	int num_parents;
 	const char **parent_names;
diff --git a/drivers/clk/ux500/abx500-clk.c b/drivers/clk/ux500/abx500-clk.c
index e7bd62c..dabb8e6 100644
--- a/drivers/clk/ux500/abx500-clk.c
+++ b/drivers/clk/ux500/abx500-clk.c
@@ -23,7 +23,7 @@
 static int ab8500_reg_clks(struct device *dev)
 {
 	int ret;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	const char *intclk_parents[] = {"ab8500_sysclk", "ulpclk"};
 	u16 intclk_reg_sel[] = {0 , AB8500_SYSULPCLKCTRL1};
diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index bd4769a..7eb055f 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -92,7 +92,7 @@ static struct clk_ops clk_prcc_kclk_ops = {
 	.is_enabled = clk_prcc_is_enabled,
 };
 
-static struct clk *clk_reg_prcc(const char *name,
+static struct clk_core *clk_reg_prcc(const char *name,
 				const char *parent_name,
 				resource_size_t phy_base,
 				u32 cg_sel,
@@ -101,7 +101,7 @@ static struct clk *clk_reg_prcc(const char *name,
 {
 	struct clk_prcc *clk;
 	struct clk_init_data clk_prcc_init;
-	struct clk *clk_reg;
+	struct clk_core *clk_reg;
 
 	if (!name) {
 		pr_err("clk_prcc: %s invalid arguments passed\n", __func__);
@@ -142,7 +142,7 @@ free_clk:
 	return ERR_PTR(-ENOMEM);
 }
 
-struct clk *clk_reg_prcc_pclk(const char *name,
+struct clk_core *clk_reg_prcc_pclk(const char *name,
 			      const char *parent_name,
 			      resource_size_t phy_base,
 			      u32 cg_sel,
@@ -152,7 +152,7 @@ struct clk *clk_reg_prcc_pclk(const char *name,
 			&clk_prcc_pclk_ops);
 }
 
-struct clk *clk_reg_prcc_kclk(const char *name,
+struct clk_core *clk_reg_prcc_kclk(const char *name,
 			      const char *parent_name,
 			      resource_size_t phy_base,
 			      u32 cg_sel,
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index e2d63bc..bac54c9 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -243,7 +243,7 @@ static struct clk_ops clk_prcmu_opp_volt_scalable_ops = {
 	.set_rate = clk_prcmu_set_rate,
 };
 
-static struct clk *clk_reg_prcmu(const char *name,
+static struct clk_core *clk_reg_prcmu(const char *name,
 				 const char *parent_name,
 				 u8 cg_sel,
 				 unsigned long rate,
@@ -252,7 +252,7 @@ static struct clk *clk_reg_prcmu(const char *name,
 {
 	struct clk_prcmu *clk;
 	struct clk_init_data clk_prcmu_init;
-	struct clk *clk_reg;
+	struct clk_core *clk_reg;
 
 	if (!name) {
 		pr_err("clk_prcmu: %s invalid arguments passed\n", __func__);
@@ -292,7 +292,7 @@ free_clk:
 	return ERR_PTR(-ENOMEM);
 }
 
-struct clk *clk_reg_prcmu_scalable(const char *name,
+struct clk_core *clk_reg_prcmu_scalable(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
 				   unsigned long rate,
@@ -302,7 +302,7 @@ struct clk *clk_reg_prcmu_scalable(const char *name,
 			&clk_prcmu_scalable_ops);
 }
 
-struct clk *clk_reg_prcmu_gate(const char *name,
+struct clk_core *clk_reg_prcmu_gate(const char *name,
 			       const char *parent_name,
 			       u8 cg_sel,
 			       unsigned long flags)
@@ -311,7 +311,7 @@ struct clk *clk_reg_prcmu_gate(const char *name,
 			&clk_prcmu_gate_ops);
 }
 
-struct clk *clk_reg_prcmu_scalable_rate(const char *name,
+struct clk_core *clk_reg_prcmu_scalable_rate(const char *name,
 					const char *parent_name,
 					u8 cg_sel,
 					unsigned long rate,
@@ -321,7 +321,7 @@ struct clk *clk_reg_prcmu_scalable_rate(const char *name,
 			&clk_prcmu_scalable_rate_ops);
 }
 
-struct clk *clk_reg_prcmu_rate(const char *name,
+struct clk_core *clk_reg_prcmu_rate(const char *name,
 			       const char *parent_name,
 			       u8 cg_sel,
 			       unsigned long flags)
@@ -330,7 +330,7 @@ struct clk *clk_reg_prcmu_rate(const char *name,
 			&clk_prcmu_rate_ops);
 }
 
-struct clk *clk_reg_prcmu_opp_gate(const char *name,
+struct clk_core *clk_reg_prcmu_opp_gate(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
 				   unsigned long flags)
@@ -339,7 +339,7 @@ struct clk *clk_reg_prcmu_opp_gate(const char *name,
 			&clk_prcmu_opp_gate_ops);
 }
 
-struct clk *clk_reg_prcmu_opp_volt_scalable(const char *name,
+struct clk_core *clk_reg_prcmu_opp_volt_scalable(const char *name,
 					    const char *parent_name,
 					    u8 cg_sel,
 					    unsigned long rate,
diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index e364c9d..dc6608a 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -114,7 +114,7 @@ static struct clk_ops clk_sysctrl_set_parent_ops = {
 	.get_parent = clk_sysctrl_get_parent,
 };
 
-static struct clk *clk_reg_sysctrl(struct device *dev,
+static struct clk_core *clk_reg_sysctrl(struct device *dev,
 				const char *name,
 				const char **parent_names,
 				u8 num_parents,
@@ -128,7 +128,7 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
 {
 	struct clk_sysctrl *clk;
 	struct clk_init_data clk_sysctrl_init;
-	struct clk *clk_reg;
+	struct clk_core *clk_reg;
 	int i;
 
 	if (!dev)
@@ -176,7 +176,7 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
 	return clk_reg;
 }
 
-struct clk *clk_reg_sysctrl_gate(struct device *dev,
+struct clk_core *clk_reg_sysctrl_gate(struct device *dev,
 				const char *name,
 				const char *parent_name,
 				u16 reg_sel,
@@ -193,7 +193,7 @@ struct clk *clk_reg_sysctrl_gate(struct device *dev,
 			flags, &clk_sysctrl_gate_ops);
 }
 
-struct clk *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
+struct clk_core *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
 					const char *name,
 					const char *parent_name,
 					u16 reg_sel,
@@ -212,7 +212,7 @@ struct clk *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
 			&clk_sysctrl_gate_fixed_rate_ops);
 }
 
-struct clk *clk_reg_sysctrl_set_parent(struct device *dev,
+struct clk_core *clk_reg_sysctrl_set_parent(struct device *dev,
 				const char *name,
 				const char **parent_names,
 				u8 num_parents,
diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
index a2bb92d..da40a2d 100644
--- a/drivers/clk/ux500/clk.h
+++ b/drivers/clk/ux500/clk.h
@@ -14,52 +14,52 @@
 #include <linux/device.h>
 #include <linux/types.h>
 
-struct clk *clk_reg_prcc_pclk(const char *name,
+struct clk_core *clk_reg_prcc_pclk(const char *name,
 			      const char *parent_name,
 			      resource_size_t phy_base,
 			      u32 cg_sel,
 			      unsigned long flags);
 
-struct clk *clk_reg_prcc_kclk(const char *name,
+struct clk_core *clk_reg_prcc_kclk(const char *name,
 			      const char *parent_name,
 			      resource_size_t phy_base,
 			      u32 cg_sel,
 			      unsigned long flags);
 
-struct clk *clk_reg_prcmu_scalable(const char *name,
+struct clk_core *clk_reg_prcmu_scalable(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
 				   unsigned long rate,
 				   unsigned long flags);
 
-struct clk *clk_reg_prcmu_gate(const char *name,
+struct clk_core *clk_reg_prcmu_gate(const char *name,
 			       const char *parent_name,
 			       u8 cg_sel,
 			       unsigned long flags);
 
-struct clk *clk_reg_prcmu_scalable_rate(const char *name,
+struct clk_core *clk_reg_prcmu_scalable_rate(const char *name,
 					const char *parent_name,
 					u8 cg_sel,
 					unsigned long rate,
 					unsigned long flags);
 
-struct clk *clk_reg_prcmu_rate(const char *name,
+struct clk_core *clk_reg_prcmu_rate(const char *name,
 			       const char *parent_name,
 			       u8 cg_sel,
 			       unsigned long flags);
 
-struct clk *clk_reg_prcmu_opp_gate(const char *name,
+struct clk_core *clk_reg_prcmu_opp_gate(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
 				   unsigned long flags);
 
-struct clk *clk_reg_prcmu_opp_volt_scalable(const char *name,
+struct clk_core *clk_reg_prcmu_opp_volt_scalable(const char *name,
 					    const char *parent_name,
 					    u8 cg_sel,
 					    unsigned long rate,
 					    unsigned long flags);
 
-struct clk *clk_reg_sysctrl_gate(struct device *dev,
+struct clk_core *clk_reg_sysctrl_gate(struct device *dev,
 				 const char *name,
 				 const char *parent_name,
 				 u16 reg_sel,
@@ -68,7 +68,7 @@ struct clk *clk_reg_sysctrl_gate(struct device *dev,
 				 unsigned long enable_delay_us,
 				 unsigned long flags);
 
-struct clk *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
+struct clk_core *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
 					    const char *name,
 					    const char *parent_name,
 					    u16 reg_sel,
@@ -78,7 +78,7 @@ struct clk *clk_reg_sysctrl_gate_fixed_rate(struct device *dev,
 					    unsigned long enable_delay_us,
 					    unsigned long flags);
 
-struct clk *clk_reg_sysctrl_set_parent(struct device *dev,
+struct clk_core *clk_reg_sysctrl_set_parent(struct device *dev,
 				       const char *name,
 				       const char **parent_names,
 				       u8 num_parents,
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 80069c3..8a2b4bc 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -19,7 +19,7 @@ void u8500_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 {
 	struct prcmu_fw_version *fw_version;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* Clock sources */
 	clk = clk_reg_prcmu_gate("soc0_pll", NULL, PRCMU_PLLSOC0,
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index 7b55ef8..afda303 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -18,9 +18,9 @@
 #define PRCC_NUM_PERIPH_CLUSTERS 6
 #define PRCC_PERIPHS_PER_CLUSTER 32
 
-static struct clk *prcmu_clk[PRCMU_NUM_CLKS];
-static struct clk *prcc_pclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_CLUSTER];
-static struct clk *prcc_kclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_CLUSTER];
+static struct clk_core *prcmu_clk[PRCMU_NUM_CLKS];
+static struct clk_core *prcc_pclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_CLUSTER];
+static struct clk_core *prcc_kclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_CLUSTER];
 
 #define PRCC_SHOW(clk, base, bit) \
 	clk[(base * PRCC_PERIPHS_PER_CLUSTER) + bit]
@@ -29,10 +29,10 @@ static struct clk *prcc_kclk[(PRCC_NUM_PERIPH_CLUSTERS + 1) * PRCC_PERIPHS_PER_C
 #define PRCC_KCLK_STORE(clk, base, bit)        \
 	prcc_kclk[(base * PRCC_PERIPHS_PER_CLUSTER) + bit] = clk
 
-static struct clk *ux500_twocell_get(struct of_phandle_args *clkspec,
+static struct clk_core *ux500_twocell_get(struct of_phandle_args *clkspec,
 				     void *data)
 {
-	struct clk **clk_data = data;
+	struct clk_core **clk_data = data;
 	unsigned int base, bit;
 
 	if (clkspec->args_count != 2)
@@ -61,7 +61,7 @@ void u8500_of_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 	struct device_node *np = NULL;
 	struct device_node *child = NULL;
 	const char *sgaclk_parent = NULL;
-	struct clk *clk, *rtc_clk, *twd_clk;
+	struct clk_core *clk, *rtc_clk, *twd_clk;
 
 	if (of_have_populated_dt())
 		np = of_find_matching_node(NULL, u8500_clk_of_match);
diff --git a/drivers/clk/ux500/u8540_clk.c b/drivers/clk/ux500/u8540_clk.c
index 20c8add..897daf6 100644
--- a/drivers/clk/ux500/u8540_clk.c
+++ b/drivers/clk/ux500/u8540_clk.c
@@ -17,7 +17,7 @@
 void u8540_clk_init(u32 clkrst1_base, u32 clkrst2_base, u32 clkrst3_base,
 		    u32 clkrst5_base, u32 clkrst6_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* Clock sources. */
 	/* Fixed ClockGen */
diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
index bc96f10..8df4acc 100644
--- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -121,13 +121,13 @@ static const struct clk_ops icst_ops = {
 	.set_rate = icst_set_rate,
 };
 
-struct clk *icst_clk_register(struct device *dev,
+struct clk_core *icst_clk_register(struct device *dev,
 			const struct clk_icst_desc *desc,
 			const char *name,
 			const char *parent_name,
 			void __iomem *base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_icst *icst;
 	struct clk_init_data init;
 	struct icst_params *pclone;
diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
index 04e6f0a..ede867b 100644
--- a/drivers/clk/versatile/clk-icst.h
+++ b/drivers/clk/versatile/clk-icst.h
@@ -13,7 +13,7 @@ struct clk_icst_desc {
 	u32 lock_offset;
 };
 
-struct clk *icst_clk_register(struct device *dev,
+struct clk_core *icst_clk_register(struct device *dev,
 			      const struct clk_icst_desc *desc,
 			      const char *name,
 			      const char *parent_name,
diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 1cc1330..6b35629 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -21,18 +21,18 @@
 
 struct impd1_clk {
 	char *pclkname;
-	struct clk *pclk;
+	struct clk_core *pclk;
 	char *vco1name;
-	struct clk *vco1clk;
+	struct clk_core *vco1clk;
 	char *vco2name;
-	struct clk *vco2clk;
-	struct clk *mmciclk;
+	struct clk_core *vco2clk;
+	struct clk_core *mmciclk;
 	char *uartname;
-	struct clk *uartclk;
+	struct clk_core *uartclk;
 	char *spiname;
-	struct clk *spiclk;
+	struct clk_core *spiclk;
 	char *scname;
-	struct clk *scclk;
+	struct clk_core *scclk;
 	struct clk_lookup *clks[15];
 };
 
@@ -87,8 +87,8 @@ static const struct clk_icst_desc impd1_icst2_desc = {
 void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 {
 	struct impd1_clk *imc;
-	struct clk *clk;
-	struct clk *pclk;
+	struct clk_core *clk;
+	struct clk_core *pclk;
 	int i;
 
 	if (id > 3) {
diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
index 734c4b8..dbcaa7b 100644
--- a/drivers/clk/versatile/clk-integrator.c
+++ b/drivers/clk/versatile/clk-integrator.c
@@ -39,7 +39,7 @@ static const struct clk_icst_desc __initdata cm_auxosc_desc = {
 
 static void __init of_integrator_cm_osc_setup(struct device_node *np)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk_core *clk = ERR_PTR(-EINVAL);
 	const char *clk_name = np->name;
 	const struct clk_icst_desc *desc = &cm_auxosc_desc;
 	const char *parent_name;
diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
index c8b5231..4fa61b3 100644
--- a/drivers/clk/versatile/clk-realview.c
+++ b/drivers/clk/versatile/clk-realview.c
@@ -50,7 +50,7 @@ static const struct clk_icst_desc __initdata realview_osc4_desc = {
  */
 void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 
 	/* APB clock dummy */
 	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
index c6e86a9..9256d25 100644
--- a/drivers/clk/versatile/clk-sp810.c
+++ b/drivers/clk/versatile/clk-sp810.c
@@ -25,7 +25,7 @@ struct clk_sp810;
 
 struct clk_sp810_timerclken {
 	struct clk_hw hw;
-	struct clk *clk;
+	struct clk_core *clk;
 	struct clk_sp810 *sp810;
 	int channel;
 };
@@ -36,8 +36,8 @@ struct clk_sp810 {
 	void __iomem *base;
 	spinlock_t lock;
 	struct clk_sp810_timerclken timerclken[4];
-	struct clk *refclk;
-	struct clk *timclk;
+	struct clk_core *refclk;
+	struct clk_core *timclk;
 };
 
 static u8 clk_sp810_timerclken_get_parent(struct clk_hw *hw)
@@ -79,29 +79,31 @@ static int clk_sp810_timerclken_prepare(struct clk_hw *hw)
 {
 	struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
 	struct clk_sp810 *sp810 = timerclken->sp810;
-	struct clk *old_parent = __clk_get_parent(hw->clk);
-	struct clk *new_parent;
+	struct clk_core *old_parent = __clk_get_parent(hw->clk);
+	struct clk_core *new_parent;
 
 	if (!sp810->refclk)
-		sp810->refclk = of_clk_get(sp810->node, sp810->refclk_index);
+		sp810->refclk = of_clk_provider_get(sp810->node,
+						    sp810->refclk_index);
 
 	if (!sp810->timclk)
-		sp810->timclk = of_clk_get(sp810->node, sp810->timclk_index);
+		sp810->timclk = of_clk_provider_get(sp810->node,
+						    sp810->timclk_index);
 
 	if (WARN_ON(IS_ERR(sp810->refclk) || IS_ERR(sp810->timclk)))
 		return -ENOENT;
 
 	/* Select fastest parent */
-	if (clk_get_rate(sp810->refclk) > clk_get_rate(sp810->timclk))
+	if (clk_provider_get_rate(sp810->refclk) > clk_provider_get_rate(sp810->timclk))
 		new_parent = sp810->refclk;
 	else
 		new_parent = sp810->timclk;
 
 	/* Switch the parent if necessary */
 	if (old_parent != new_parent) {
-		clk_prepare(new_parent);
-		clk_set_parent(hw->clk, new_parent);
-		clk_unprepare(old_parent);
+		clk_provider_prepare(new_parent);
+		clk_provider_set_parent(hw->clk, new_parent);
+		clk_provider_unprepare(old_parent);
 	}
 
 	return 0;
@@ -112,8 +114,8 @@ static void clk_sp810_timerclken_unprepare(struct clk_hw *hw)
 	struct clk_sp810_timerclken *timerclken = to_clk_sp810_timerclken(hw);
 	struct clk_sp810 *sp810 = timerclken->sp810;
 
-	clk_put(sp810->timclk);
-	clk_put(sp810->refclk);
+	__clk_put(sp810->timclk);
+	__clk_put(sp810->refclk);
 }
 
 static const struct clk_ops clk_sp810_timerclken_ops = {
@@ -123,7 +125,7 @@ static const struct clk_ops clk_sp810_timerclken_ops = {
 	.set_parent = clk_sp810_timerclken_set_parent,
 };
 
-static struct clk *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
+static struct clk_core *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
 		void *data)
 {
 	struct clk_sp810 *sp810 = data;
diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 529a59c..c9e175f 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -73,7 +73,7 @@ static int vexpress_osc_probe(struct platform_device *pdev)
 	struct clk_lookup *cl = pdev->dev.platform_data; /* Non-DT lookup */
 	struct clk_init_data init;
 	struct vexpress_osc *osc;
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 range[2];
 
 	osc = devm_kzalloc(&pdev->dev, sizeof(*osc), GFP_KERNEL);
diff --git a/drivers/clk/versatile/clk-vexpress.c b/drivers/clk/versatile/clk-vexpress.c
index 2d5e1b4..e77f3d5 100644
--- a/drivers/clk/versatile/clk-vexpress.c
+++ b/drivers/clk/versatile/clk-vexpress.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/vexpress.h>
 
-static struct clk *vexpress_sp810_timerclken[4];
+static struct clk_core *vexpress_sp810_timerclken[4];
 static DEFINE_SPINLOCK(vexpress_sp810_lock);
 
 static void __init vexpress_sp810_init(void __iomem *base)
@@ -54,7 +54,7 @@ static const char * const vexpress_clk_24mhz_periphs[] __initconst = {
 
 void __init vexpress_clk_init(void __iomem *sp810_base)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	int i;
 
 	clk = clk_register_fixed_rate(NULL, "dummy_apb_pclk", NULL,
@@ -77,7 +77,7 @@ void __init vexpress_clk_init(void __iomem *sp810_base)
 	vexpress_sp810_init(sp810_base);
 
 	for (i = 0; i < ARRAY_SIZE(vexpress_sp810_timerclken); i++)
-		WARN_ON(clk_set_parent(vexpress_sp810_timerclken[i], clk));
+		WARN_ON(clk_provider_set_parent(vexpress_sp810_timerclken[i], clk));
 
 	WARN_ON(clk_register_clkdev(vexpress_sp810_timerclken[0],
 				"v2m-timer0", "sp804"));
diff --git a/drivers/clk/x86/clk-lpt.c b/drivers/clk/x86/clk-lpt.c
index 812f83f..1b4a5e1 100644
--- a/drivers/clk/x86/clk-lpt.c
+++ b/drivers/clk/x86/clk-lpt.c
@@ -21,7 +21,7 @@
 static int lpt_clk_probe(struct platform_device *pdev)
 {
 	struct lpss_clk_data *drvdata;
-	struct clk *clk;
+	struct clk_core *clk;
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 246cf12..0efdd9a 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -67,8 +67,8 @@ enum zynq_clk {
 	i2c0_aper, i2c1_aper, uart0_aper, uart1_aper, gpio_aper, lqspi_aper,
 	smc_aper, swdt, dbg_trc, dbg_apb, clk_max};
 
-static struct clk *ps_clk;
-static struct clk *clks[clk_max];
+static struct clk_core *ps_clk;
+static struct clk_core *clks[clk_max];
 static struct clk_onecell_data clk_data;
 
 static DEFINE_SPINLOCK(armpll_lock);
@@ -108,7 +108,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 		const char *clk_name, void __iomem *fclk_ctrl_reg,
 		const char **parents, int enable)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 enable_reg;
 	char *mux_name;
 	char *div0_name;
@@ -154,7 +154,7 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
 			0, CLK_GATE_SET_TO_DISABLE, fclk_gate_lock);
 	enable_reg = clk_readl(fclk_gate_reg) & 1;
 	if (enable && !enable_reg) {
-		if (clk_prepare_enable(clks[fclk]))
+		if (clk_provider_prepare_enable(clks[fclk]))
 			pr_warn("%s: FCLK%u enable failed\n", __func__,
 					fclk - fclk0);
 	}
@@ -181,7 +181,7 @@ static void __init zynq_clk_register_periph_clk(enum zynq_clk clk0,
 		const char *clk_name1, void __iomem *clk_ctrl,
 		const char **parents, unsigned int two_gates)
 {
-	struct clk *clk;
+	struct clk_core *clk;
 	char *mux_name;
 	char *div_name;
 	spinlock_t *lock;
@@ -222,7 +222,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	int i;
 	u32 tmp;
 	int ret;
-	struct clk *clk;
+	struct clk_core *clk;
 	char *clk_name;
 	unsigned int fclk_enable = 0;
 	const char *clk_output_name[clk_max];
@@ -333,13 +333,13 @@ static void __init zynq_clk_setup(struct device_node *np)
 			CLK_DIVIDER_ALLOW_ZERO, &ddrclk_lock);
 	clks[ddr2x] = clk_register_gate(NULL, clk_output_name[ddr2x],
 			"ddr2x_div", 0, SLCR_DDR_CLK_CTRL, 1, 0, &ddrclk_lock);
-	clk_prepare_enable(clks[ddr2x]);
+	clk_provider_prepare_enable(clks[ddr2x]);
 	clk = clk_register_divider(NULL, "ddr3x_div", "ddrpll", 0,
 			SLCR_DDR_CLK_CTRL, 20, 6, CLK_DIVIDER_ONE_BASED |
 			CLK_DIVIDER_ALLOW_ZERO, &ddrclk_lock);
 	clks[ddr3x] = clk_register_gate(NULL, clk_output_name[ddr3x],
 			"ddr3x_div", 0, SLCR_DDR_CLK_CTRL, 0, 0, &ddrclk_lock);
-	clk_prepare_enable(clks[ddr3x]);
+	clk_provider_prepare_enable(clks[ddr3x]);
 
 	clk = clk_register_divider(NULL, "dci_div0", "ddrpll", 0,
 			SLCR_DCI_CLK_CTRL, 8, 6, CLK_DIVIDER_ONE_BASED |
@@ -351,7 +351,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	clks[dci] = clk_register_gate(NULL, clk_output_name[dci], "dci_div1",
 			CLK_SET_RATE_PARENT, SLCR_DCI_CLK_CTRL, 0, 0,
 			&dciclk_lock);
-	clk_prepare_enable(clks[dci]);
+	clk_provider_prepare_enable(clks[dci]);
 
 	/* Peripheral clocks */
 	for (i = fclk0; i <= fclk3; i++) {
@@ -505,10 +505,10 @@ static void __init zynq_clk_setup(struct device_node *np)
 	/* leave debug clocks in the state the bootloader set them up to */
 	tmp = clk_readl(SLCR_DBG_CLK_CTRL);
 	if (tmp & DBG_CLK_CTRL_CLKACT_TRC)
-		if (clk_prepare_enable(clks[dbg_trc]))
+		if (clk_provider_prepare_enable(clks[dbg_trc]))
 			pr_warn("%s: trace clk enable failed\n", __func__);
 	if (tmp & DBG_CLK_CTRL_CPU_1XCLKACT)
-		if (clk_prepare_enable(clks[dbg_apb]))
+		if (clk_provider_prepare_enable(clks[dbg_apb]))
 			pr_warn("%s: debug APB clk enable failed\n", __func__);
 
 	/* One gated clock for all APER clocks. */
diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index cec9759..5176f65 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -193,12 +193,12 @@ static const struct clk_ops zynq_pll_ops = {
  * @lock	Register lock
  * Returns handle to the registered clock.
  */
-struct clk *clk_register_zynq_pll(const char *name, const char *parent,
+struct clk_core *clk_register_zynq_pll(const char *name, const char *parent,
 		void __iomem *pll_ctrl, void __iomem *pll_status, u8 lock_index,
 		spinlock_t *lock)
 {
 	struct zynq_pll *pll;
-	struct clk *clk;
+	struct clk_core *clk;
 	u32 reg;
 	const char *parent_arr[1] = {parent};
 	unsigned long flags = 0;
diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 2620c48..c2461af 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -215,7 +215,7 @@ static int __fimc_pipeline_open(struct exynos_media_pipeline *ep,
 
 	/* Disable PXLASYNC clock if this pipeline includes FIMC-IS */
 	if (!IS_ERR(fmd->wbclk[CLK_IDX_WB_B]) && p->subdevs[IDX_IS_ISP]) {
-		ret = clk_prepare_enable(fmd->wbclk[CLK_IDX_WB_B]);
+		ret = clk_provider_prepare_enable(fmd->wbclk[CLK_IDX_WB_B]);
 		if (ret < 0)
 			return ret;
 	}
@@ -225,7 +225,7 @@ static int __fimc_pipeline_open(struct exynos_media_pipeline *ep,
 		return 0;
 
 	if (!IS_ERR(fmd->wbclk[CLK_IDX_WB_B]) && p->subdevs[IDX_IS_ISP])
-		clk_disable_unprepare(fmd->wbclk[CLK_IDX_WB_B]);
+		clk_provider_disable_unprepare(fmd->wbclk[CLK_IDX_WB_B]);
 
 	return ret;
 }
@@ -254,7 +254,7 @@ static int __fimc_pipeline_close(struct exynos_media_pipeline *ep)
 
 	/* Disable PXLASYNC clock if this pipeline includes FIMC-IS */
 	if (!IS_ERR(fmd->wbclk[CLK_IDX_WB_B]) && p->subdevs[IDX_IS_ISP])
-		clk_disable_unprepare(fmd->wbclk[CLK_IDX_WB_B]);
+		clk_provider_disable_unprepare(fmd->wbclk[CLK_IDX_WB_B]);
 
 	return ret == -ENXIO ? 0 : ret;
 }
@@ -954,7 +954,7 @@ static void fimc_md_put_clocks(struct fimc_md *fmd)
 	while (--i >= 0) {
 		if (IS_ERR(fmd->camclk[i].clock))
 			continue;
-		clk_put(fmd->camclk[i].clock);
+		__clk_put(fmd->camclk[i].clock);
 		fmd->camclk[i].clock = ERR_PTR(-EINVAL);
 	}
 
@@ -962,7 +962,7 @@ static void fimc_md_put_clocks(struct fimc_md *fmd)
 	for (i = 0; i < FIMC_MAX_WBCLKS; i++) {
 		if (IS_ERR(fmd->wbclk[i]))
 			continue;
-		clk_put(fmd->wbclk[i]);
+		__clk_put(fmd->wbclk[i]);
 		fmd->wbclk[i] = ERR_PTR(-EINVAL);
 	}
 }
@@ -971,7 +971,7 @@ static int fimc_md_get_clocks(struct fimc_md *fmd)
 {
 	struct device *dev = &fmd->pdev->dev;
 	char clk_name[32];
-	struct clk *clock;
+	struct clk_core *clock;
 	int i, ret = 0;
 
 	for (i = 0; i < FIMC_MAX_CAMCLKS; i++)
@@ -979,7 +979,7 @@ static int fimc_md_get_clocks(struct fimc_md *fmd)
 
 	for (i = 0; i < FIMC_MAX_CAMCLKS; i++) {
 		snprintf(clk_name, sizeof(clk_name), "sclk_cam%u", i);
-		clock = clk_get(dev, clk_name);
+		clock = clk_provider_get(dev, clk_name);
 
 		if (IS_ERR(clock)) {
 			dev_err(dev, "Failed to get clock: %s\n", clk_name);
@@ -1001,7 +1001,7 @@ static int fimc_md_get_clocks(struct fimc_md *fmd)
 
 	for (i = CLK_IDX_WB_B; i < FIMC_MAX_WBCLKS; i++) {
 		snprintf(clk_name, sizeof(clk_name), "pxl_async%u", i);
-		clock = clk_get(dev, clk_name);
+		clock = clk_provider_get(dev, clk_name);
 		if (IS_ERR(clock)) {
 			v4l2_err(&fmd->v4l2_dev, "Failed to get clock: %s\n",
 				  clk_name);
diff --git a/drivers/media/platform/exynos4-is/media-dev.h b/drivers/media/platform/exynos4-is/media-dev.h
index 0321454..79e4b42 100644
--- a/drivers/media/platform/exynos4-is/media-dev.h
+++ b/drivers/media/platform/exynos4-is/media-dev.h
@@ -72,7 +72,7 @@ struct fimc_csis_info {
 };
 
 struct fimc_camclk_info {
-	struct clk *clock;
+	struct clk_core *clock;
 	int use_count;
 	unsigned long frequency;
 };
@@ -124,7 +124,7 @@ struct fimc_md {
 	struct fimc_sensor_info sensor[FIMC_MAX_SENSORS];
 	int num_sensors;
 	struct fimc_camclk_info camclk[FIMC_MAX_CAMCLKS];
-	struct clk *wbclk[FIMC_MAX_WBCLKS];
+	struct clk_core *wbclk[FIMC_MAX_WBCLKS];
 	struct fimc_lite *fimc_lite[FIMC_LITE_MAX_DEVS];
 	struct fimc_dev *fimc[FIMC_MAX_DEVS];
 	struct fimc_is *fimc_is;
@@ -141,7 +141,7 @@ struct fimc_md {
 	} pinctl;
 
 	struct cam_clk_provider {
-		struct clk *clks[FIMC_MAX_CAMCLKS];
+		struct clk_core *clks[FIMC_MAX_CAMCLKS];
 		struct clk_onecell_data clk_data;
 		struct device_node *of_node;
 		struct cam_clk camclk[FIMC_MAX_CAMCLKS];
diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
index 90a32a6..16d43d9 100644
--- a/include/asm-generic/clkdev.h
+++ b/include/asm-generic/clkdev.h
@@ -17,8 +17,8 @@
 
 struct clk;
 
-static inline int __clk_get(struct clk *clk) { return 1; }
-static inline void __clk_put(struct clk *clk) { }
+static inline int __clk_get(struct clk_core *clk) { return 1; }
+static inline void __clk_put(struct clk_core *clk) { }
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e8d8a35..6b9e6b4 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -22,8 +22,8 @@
  * @mult_div1_reg: register containing the DPLL M and N bitfields
  * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
  * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
- * @clk_bypass: struct clk pointer to the clock's bypass clock input
- * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @clk_bypass: struct clk_core pointer to the clock's bypass clock input
+ * @clk_ref: struct clk_core pointer to the clock's reference clock input
  * @control_reg: register containing the DPLL mode bitfield
  * @enable_mask: mask of the DPLL mode bitfield in @control_reg
  * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
@@ -68,8 +68,8 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
-	struct clk		*clk_bypass;
-	struct clk		*clk_ref;
+	struct clk_core		*clk_bypass;
+	struct clk_core		*clk_ref;
 	void __iomem		*control_reg;
 	u32			enable_mask;
 	unsigned long		last_rounded_rate;
@@ -251,7 +251,7 @@ extern const struct clk_ops ti_clk_mux_ops;
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
-void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+void omap2_init_clk_hw_omap_clocks(struct clk_core *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
 int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk/zynq.h b/include/linux/clk/zynq.h
index a990a59..6c35291 100644
--- a/include/linux/clk/zynq.h
+++ b/include/linux/clk/zynq.h
@@ -25,7 +25,7 @@
 
 void zynq_clock_init(void);
 
-struct clk *clk_register_zynq_pll(const char *name, const char *parent,
+struct clk_core *clk_register_zynq_pll(const char *name, const char *parent,
 		void __iomem *pll_ctrl, void __iomem *pll_status, u8 lock_index,
 		spinlock_t *lock);
 #endif
diff --git a/include/linux/platform_data/si5351.h b/include/linux/platform_data/si5351.h
index a947ab8..4b34c69 100644
--- a/include/linux/platform_data/si5351.h
+++ b/include/linux/platform_data/si5351.h
@@ -107,8 +107,8 @@ struct si5351_clkout_config {
  * @clkout: array of clkout configuration
  */
 struct si5351_platform_data {
-	struct clk *clk_xtal;
-	struct clk *clk_clkin;
+	struct clk_core *clk_xtal;
+	struct clk_core *clk_clkin;
 	enum si5351_pll_src pll_src[2];
 	struct si5351_clkout_config clkout[8];
 };
-- 
1.9.3
