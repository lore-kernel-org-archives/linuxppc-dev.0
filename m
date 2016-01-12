Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56F121A1836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 04:48:28 +1100 (AEDT)
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Anson Huang <b20788@freescale.com>, Arnd Bergmann <arnd@arndb.de>,
 Bai Ping <b51503@freescale.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Frank Li <Frank.Li@freescale.com>, Fugang Duan <B38611@freescale.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Jaroslav Kysela <perex@perex.cz>, Kumar Gala <galak@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 2/2] clk: imx: add kpp clock for i.MX6UL
Date: Tue, 12 Jan 2016 18:29:19 +0100
Message-Id: <1452619759-14474-3-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1452619759-14474-2-git-send-email-LW@KARO-electronics.de>
References: <1452619759-14474-1-git-send-email-LW@KARO-electronics.de>
 <1452619759-14474-2-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the necessary clock to use the KPP interface on i.MX6UL.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 drivers/clk/imx/clk-imx6ul.c             | 1 +
 include/dt-bindings/clock/imx6ul-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 3e31ec0..1ee28d3 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -365,6 +365,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	/* CCGR5 */
 	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2("rom",		"ahb",		base + 0x7c,	0);
 	clks[IMX6UL_CLK_SDMA]		= imx_clk_gate2("sdma",		"ahb",		base + 0x7c,	6);
+	clks[IMX6UL_CLK_KPP]		= imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	8);
 	clks[IMX6UL_CLK_WDOG2]		= imx_clk_gate2("wdog2",	"ipg",		base + 0x7c,	10);
 	clks[IMX6UL_CLK_SPBA]		= imx_clk_gate2("spba",		"ipg",		base + 0x7c,	12);
 	clks[IMX6UL_CLK_SPDIF]		= imx_clk_gate2_shared("spdif",		"spdif_podf",	base + 0x7c,	14, &share_count_audio);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index 08ce4a7..fd8aee8 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -234,7 +234,8 @@
 #define IMX6UL_CLK_CSI_SEL		221
 #define IMX6UL_CLK_CSI_PODF		222
 #define IMX6UL_CLK_PLL3_120M		223
+#define IMX6UL_CLK_KPP			224
 
-#define IMX6UL_CLK_END			224
+#define IMX6UL_CLK_END			225
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.1.4
