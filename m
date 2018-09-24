Return-Path: <vabhav.sharma@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40054.outbound.protection.outlook.com [40.107.4.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jjn80wkGzF3Dr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 22:14:35 +1000 (AEST)
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org,
 arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc: linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
 Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for lx2160a
Date: Mon, 24 Sep 2018 05:38:59 +0530
Message-Id: <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e152bfb..99675de 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat = "fsl,lx2160a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group = {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask = 0x37,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,p2041-clockgen",
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p2041_init_periph,
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
 	{ .compatible = "fsl,ls1046a-clockgen", },
 	{ .compatible = "fsl,ls1088a-clockgen", },
 	{ .compatible = "fsl,ls2080a-clockgen", },
+	{ .compatible = "fsl,lx2160a-clockgen", },
 	{ .compatible = "fsl,p4080-clockgen", },
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-- 
2.7.4
