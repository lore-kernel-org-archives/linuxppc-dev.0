Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75B91A000E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 05:57:11 +1000 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: make of_device_ids const
Date: Wed, 10 Sep 2014 21:56:38 +0200
Message-Id: <1410378998-8823-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. This allows to
mark all struct of_device_id const, too.

While touching these line also put the __init annotation at the right
position where necessary.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I don't know how arch/powerpc is maintained. So please tell me if I
should split this patch further.

I manually checked that all const annotations are OK, and the 0day build
bot didn't find a regression.

Best regards
Uwe

 arch/powerpc/kernel/ibmebus.c                    |  2 +-
 arch/powerpc/kernel/legacy_serial.c              |  2 +-
 arch/powerpc/kernel/of_platform.c                |  2 +-
 arch/powerpc/platforms/40x/ep405.c               |  2 +-
 arch/powerpc/platforms/40x/ppc40x_simple.c       |  2 +-
 arch/powerpc/platforms/40x/virtex.c              |  2 +-
 arch/powerpc/platforms/40x/walnut.c              |  2 +-
 arch/powerpc/platforms/44x/canyonlands.c         |  2 +-
 arch/powerpc/platforms/44x/ebony.c               |  2 +-
 arch/powerpc/platforms/44x/iss4xx.c              |  2 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c       |  2 +-
 arch/powerpc/platforms/44x/ppc476.c              |  2 +-
 arch/powerpc/platforms/44x/sam440ep.c            |  2 +-
 arch/powerpc/platforms/44x/virtex.c              |  2 +-
 arch/powerpc/platforms/44x/warp.c                |  2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c     |  2 +-
 arch/powerpc/platforms/52xx/lite5200.c           |  4 ++--
 arch/powerpc/platforms/52xx/media5200.c          |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c     | 12 ++++++------
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c    |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |  4 ++--
 arch/powerpc/platforms/82xx/ep8248e.c            |  2 +-
 arch/powerpc/platforms/82xx/km82xx.c             |  2 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c        |  2 +-
 arch/powerpc/platforms/82xx/pq2fads.c            |  2 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c   |  2 +-
 arch/powerpc/platforms/83xx/misc.c               |  2 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c        |  2 +-
 arch/powerpc/platforms/83xx/suspend.c            |  4 ++--
 arch/powerpc/platforms/85xx/common.c             |  2 +-
 arch/powerpc/platforms/85xx/ppa8548.c            |  2 +-
 arch/powerpc/platforms/85xx/sgy_cts1000.c        |  4 ++--
 arch/powerpc/platforms/86xx/gef_ppc9a.c          |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c         |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c         |  2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c       |  2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c       |  2 +-
 arch/powerpc/platforms/86xx/sbc8641d.c           |  2 +-
 arch/powerpc/platforms/8xx/adder875.c            |  2 +-
 arch/powerpc/platforms/8xx/ep88xc.c              |  2 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c     |  2 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c     |  2 +-
 arch/powerpc/platforms/8xx/tqm8xx_setup.c        |  2 +-
 arch/powerpc/platforms/cell/celleb_pci.c         |  2 +-
 arch/powerpc/platforms/cell/celleb_setup.c       |  2 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c    |  2 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c |  2 +-
 arch/powerpc/platforms/embedded6xx/mvme5100.c    |  2 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c  |  2 +-
 arch/powerpc/platforms/embedded6xx/wii.c         |  2 +-
 arch/powerpc/platforms/pasemi/gpio_mdio.c        |  2 +-
 arch/powerpc/platforms/pasemi/setup.c            |  2 +-
 arch/powerpc/sysdev/axonram.c                    |  2 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c            |  2 +-
 arch/powerpc/sysdev/mv64x60_dev.c                |  2 +-
 arch/powerpc/sysdev/pmi.c                        |  2 +-
 arch/powerpc/sysdev/xilinx_intc.c                |  2 +-
 arch/powerpc/sysdev/xilinx_pci.c                 |  2 +-
 58 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index 1114d13ac19f..ac86c53e2542 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -55,7 +55,7 @@ static struct device ibmebus_bus_device = { /* fake "parent" device */
 struct bus_type ibmebus_bus_type;
 
 /* These devices will automatically be added to the bus during init */
-static struct of_device_id __initdata ibmebus_matches[] = {
+static const struct of_device_id ibmebus_matches[] __initconst = {
 	{ .compatible = "IBM,lhca" },
 	{ .compatible = "IBM,lhea" },
 	{},
diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 936258881c98..7b750c4ed5c7 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -35,7 +35,7 @@ static struct legacy_serial_info {
 	phys_addr_t			taddr;
 } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
 
-static struct of_device_id legacy_serial_parents[] __initdata = {
+static const struct of_device_id legacy_serial_parents[] __initconst = {
 	{.type = "soc",},
 	{.type = "tsi-bridge",},
 	{.type = "opb", },
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index a7b743076720..f87bc1b4bdda 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -97,7 +97,7 @@ static int of_pci_phb_probe(struct platform_device *dev)
 	return 0;
 }
 
-static struct of_device_id of_pci_phb_ids[] = {
+static const struct of_device_id of_pci_phb_ids[] = {
 	{ .type = "pci", },
 	{ .type = "pcix", },
 	{ .type = "pcie", },
diff --git a/arch/powerpc/platforms/40x/ep405.c b/arch/powerpc/platforms/40x/ep405.c
index b0389bbe4f94..ddc12a1926ef 100644
--- a/arch/powerpc/platforms/40x/ep405.c
+++ b/arch/powerpc/platforms/40x/ep405.c
@@ -49,7 +49,7 @@ static void __iomem *bcsr_regs;
 /* there's more, can't be bothered typing them tho */
 
 
-static __initdata struct of_device_id ep405_of_bus[] = {
+static const struct of_device_id ep405_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb3", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 8f3920e5a046..b0c46375dd95 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 
-static __initdata struct of_device_id ppc40x_of_bus[] = {
+static const struct of_device_id ppc40x_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb3", },
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
index d0fc6866b00c..9aa7ae2f4164 100644
--- a/arch/powerpc/platforms/40x/virtex.c
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -17,7 +17,7 @@
 #include <asm/xilinx_pci.h>
 #include <asm/ppc4xx.h>
 
-static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+static const struct of_device_id xilinx_of_bus_ids[] __initconst = {
 	{ .compatible = "xlnx,plb-v46-1.00.a", },
 	{ .compatible = "xlnx,plb-v34-1.01.a", },
 	{ .compatible = "xlnx,plb-v34-1.02.a", },
diff --git a/arch/powerpc/platforms/40x/walnut.c b/arch/powerpc/platforms/40x/walnut.c
index 8b691df72f74..f7ac2d0fcb44 100644
--- a/arch/powerpc/platforms/40x/walnut.c
+++ b/arch/powerpc/platforms/40x/walnut.c
@@ -28,7 +28,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc4xx.h>
 
-static __initdata struct of_device_id walnut_of_bus[] = {
+static const struct of_device_id walnut_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb3", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
index e300dd4c89bf..22ca5430c9cb 100644
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -33,7 +33,7 @@
 
 #define BCSR_USB_EN	0x11
 
-static __initdata struct of_device_id ppc460ex_of_bus[] = {
+static const struct of_device_id ppc460ex_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index 6a4232bbdf88..ae893226392d 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -28,7 +28,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc4xx.h>
 
-static __initdata struct of_device_id ebony_of_bus[] = {
+static const struct of_device_id ebony_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index 4241bc825800..c7c6758b3cfe 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -32,7 +32,7 @@
 #include <asm/mpic.h>
 #include <asm/mmu.h>
 
-static __initdata struct of_device_id iss4xx_of_bus[] = {
+static const struct of_device_id iss4xx_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,plb6", },
 	{ .compatible = "ibm,opb", },
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 3ffb915446e3..573c3d2689c6 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 
-static __initdata struct of_device_id ppc44x_of_bus[] = {
+static const struct of_device_id ppc44x_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index 33986c1a05da..58db9d083969 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -38,7 +38,7 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 
-static struct of_device_id ppc47x_of_bus[] __initdata = {
+static const struct of_device_id ppc47x_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,plb6", },
 	{ .compatible = "ibm,opb", },
diff --git a/arch/powerpc/platforms/44x/sam440ep.c b/arch/powerpc/platforms/44x/sam440ep.c
index 9e09b835758b..3ee4a03c1496 100644
--- a/arch/powerpc/platforms/44x/sam440ep.c
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -29,7 +29,7 @@
 #include <asm/ppc4xx.h>
 #include <linux/i2c.h>
 
-static __initdata struct of_device_id sam440ep_of_bus[] = {
+static const struct of_device_id sam440ep_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
index cf96ccaa760c..ad272c17c640 100644
--- a/arch/powerpc/platforms/44x/virtex.c
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -21,7 +21,7 @@
 #include <asm/ppc4xx.h>
 #include "44x.h"
 
-static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+static const struct of_device_id xilinx_of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "xlnx,plb-v46-1.00.a", },
 	{ .compatible = "xlnx,plb-v46-1.02.a", },
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index 3a104284b338..501333cf42cf 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -28,7 +28,7 @@
 #include <asm/dma.h>
 
 
-static __initdata struct of_device_id warp_of_bus[] = {
+static const struct of_device_id warp_of_bus[] __initconst = {
 	{ .compatible = "ibm,plb4", },
 	{ .compatible = "ibm,opb", },
 	{ .compatible = "ibm,ebc", },
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index adb95f03d4d4..e996e007bc44 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -337,7 +337,7 @@ void __init mpc512x_init_IRQ(void)
 /*
  * Nodes to do bus probe on, soc and localbus
  */
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5121-immr", },
 	{ .compatible = "fsl,mpc5121-localbus", },
 	{ .compatible = "fsl,mpc5121-mbx", },
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 1843bc932011..7492de3cf6d0 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -34,13 +34,13 @@
  */
 
 /* mpc5200 device tree match tables */
-static struct of_device_id mpc5200_cdm_ids[] __initdata = {
+static const struct of_device_id mpc5200_cdm_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-cdm", },
 	{ .compatible = "mpc5200-cdm", },
 	{}
 };
 
-static struct of_device_id mpc5200_gpio_ids[] __initdata = {
+static const struct of_device_id mpc5200_gpio_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-gpio", },
 	{ .compatible = "mpc5200-gpio", },
 	{}
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 070d315dd6cd..32cae33c4266 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -30,7 +30,7 @@
 #include <asm/machdep.h>
 #include <asm/mpc52xx.h>
 
-static struct of_device_id mpc5200_gpio_ids[] __initdata = {
+static const struct of_device_id mpc5200_gpio_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-gpio", },
 	{ .compatible = "mpc5200-gpio", },
 	{}
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index d7e94f49532a..26993826a797 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -23,12 +23,12 @@
 #include <asm/mpc52xx.h>
 
 /* MPC5200 device tree match tables */
-static struct of_device_id mpc52xx_xlb_ids[] __initdata = {
+static const struct of_device_id mpc52xx_xlb_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-xlb", },
 	{ .compatible = "mpc5200-xlb", },
 	{}
 };
-static struct of_device_id mpc52xx_bus_ids[] __initdata = {
+static const struct of_device_id mpc52xx_bus_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-immr", },
 	{ .compatible = "fsl,mpc5200b-immr", },
 	{ .compatible = "simple-bus", },
@@ -108,21 +108,21 @@ void __init mpc52xx_declare_of_platform_devices(void)
 /*
  * match tables used by mpc52xx_map_common_devices()
  */
-static struct of_device_id mpc52xx_gpt_ids[] __initdata = {
+static const struct of_device_id mpc52xx_gpt_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-gpt", },
 	{ .compatible = "mpc5200-gpt", }, /* old */
 	{}
 };
-static struct of_device_id mpc52xx_cdm_ids[] __initdata = {
+static const struct of_device_id mpc52xx_cdm_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-cdm", },
 	{ .compatible = "mpc5200-cdm", }, /* old */
 	{}
 };
-static const struct of_device_id mpc52xx_gpio_simple[] = {
+static const struct of_device_id mpc52xx_gpio_simple[] __initconst = {
 	{ .compatible = "fsl,mpc5200-gpio", },
 	{}
 };
-static const struct of_device_id mpc52xx_gpio_wkup[] = {
+static const struct of_device_id mpc52xx_gpio_wkup[] __initconst = {
 	{ .compatible = "fsl,mpc5200-gpio-wkup", },
 	{}
 };
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 37f7a89c10f2..f8f0081759fb 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -564,7 +564,7 @@ static int mpc52xx_lpbfifo_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc52xx_lpbfifo_match[] = {
+static const struct of_device_id mpc52xx_lpbfifo_match[] = {
 	{ .compatible = "fsl,mpc5200-lpbfifo", },
 	{},
 };
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 2898b737deb7..2944bc84b9d6 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -119,12 +119,12 @@
 
 
 /* MPC5200 device tree match tables */
-static struct of_device_id mpc52xx_pic_ids[] __initdata = {
+static const struct of_device_id mpc52xx_pic_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-pic", },
 	{ .compatible = "mpc5200-pic", },
 	{}
 };
-static struct of_device_id mpc52xx_sdma_ids[] __initdata = {
+static const struct of_device_id mpc52xx_sdma_ids[] __initconst = {
 	{ .compatible = "fsl,mpc5200-bestcomm", },
 	{ .compatible = "mpc5200-bestcomm", },
 	{}
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 79799b29ffe2..3d0c3a01143d 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -298,7 +298,7 @@ static void __init ep8248e_setup_arch(void)
 		ppc_md.progress("ep8248e_setup_arch(), finish", 0);
 }
 
-static  __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "fsl,ep8248e-bcsr", },
 	{},
diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 058cc1895c88..89eb12065018 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -180,7 +180,7 @@ static void __init km82xx_setup_arch(void)
 		ppc_md.progress("km82xx_setup_arch(), finish", 0);
 }
 
-static  __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __init_const = {
 	{ .compatible = "simple-bus", },
 	{},
 };
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 6a14cf50f4a2..d24deacf07d0 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -181,7 +181,7 @@ static void __init mpc8272_ads_setup_arch(void)
 		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index e5f82ec8df17..3a5164ad10ad 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -168,7 +168,7 @@ static int __init pq2fads_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,pq2fads");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index e238b6a55b15..31053eec5cd0 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -213,7 +213,7 @@ static const struct i2c_device_id mcu_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcu_ids);
 
-static struct of_device_id mcu_of_match_table[] = {
+static const struct of_device_id mcu_of_match_table[] = {
 	{ .compatible = "fsl,mcu-mpc8349emitx", },
 	{ },
 };
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 125336f750c6..ef9d01a049c1 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -114,7 +114,7 @@ void __init mpc83xx_ipic_and_qe_init_IRQ(void)
 }
 #endif /* CONFIG_QUICC_ENGINE */
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus" },
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index a494fa57bdf9..80aea8c4b5a3 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -38,7 +38,7 @@
 
 #include "mpc83xx.h"
 
-static struct of_device_id __initdata mpc834x_itx_ids[] = {
+static const struct of_device_id mpc834x_itx_ids[] __initconst = {
 	{ .compatible = "fsl,pq2pro-localbus", },
 	{},
 };
diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index 4b4c081df94d..eeb80e25214d 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -321,7 +321,7 @@ static const struct platform_suspend_ops mpc83xx_suspend_ops = {
 	.end = mpc83xx_suspend_end,
 };
 
-static struct of_device_id pmc_match[];
+static const struct of_device_id pmc_match[];
 static int pmc_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
@@ -420,7 +420,7 @@ static struct pmc_type pmc_types[] = {
 	}
 };
 
-static struct of_device_id pmc_match[] = {
+static const struct of_device_id pmc_match[] = {
 	{
 		.compatible = "fsl,mpc8313-pmc",
 		.data = &pmc_types[0],
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index b564b5e23f7c..4a9ad871a168 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -14,7 +14,7 @@
 
 #include "mpc85xx.h"
 
-static struct of_device_id __initdata mpc85xx_common_ids[] = {
+static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
index 3daff7c63569..12019f17f297 100644
--- a/arch/powerpc/platforms/85xx/ppa8548.c
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -59,7 +59,7 @@ static void ppa8548_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .type = "soc", },
 	{ .compatible = "simple-bus", },
diff --git a/arch/powerpc/platforms/85xx/sgy_cts1000.c b/arch/powerpc/platforms/85xx/sgy_cts1000.c
index bb75add67084..8162b0412117 100644
--- a/arch/powerpc/platforms/85xx/sgy_cts1000.c
+++ b/arch/powerpc/platforms/85xx/sgy_cts1000.c
@@ -24,7 +24,7 @@
 
 static struct device_node *halt_node;
 
-static struct of_device_id child_match[] = {
+static const struct of_device_id child_match[] = {
 	{
 		.compatible = "sgy,gpio-halt",
 	},
@@ -147,7 +147,7 @@ static int gpio_halt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id gpio_halt_match[] = {
+static const struct of_device_id gpio_halt_match[] = {
 	/* We match on the gpio bus itself and scan the children since they
 	 * wont be matched against us. We know the bus wont match until it
 	 * has been registered too. */
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index c23f3443880a..bf17933b20f3 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -213,7 +213,7 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,mpc8641-pcie", },
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 8a6ac20686ea..8facf5873866 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -200,7 +200,7 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,mpc8641-pcie", },
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 06c72636f299..8c9058df5642 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -190,7 +190,7 @@ static long __init mpc86xx_time_init(void)
 	return 0;
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,mpc8641-pcie", },
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index d479d68fbb2b..55413a547ea8 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -85,7 +85,7 @@ static void __init mpc8610_suspend_init(void)
 static inline void mpc8610_suspend_init(void) { }
 #endif /* CONFIG_SUSPEND */
 
-static struct of_device_id __initdata mpc8610_ids[] = {
+static const struct of_device_id mpc8610_ids[] __initconst = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "fsl,mpc8610-guts", },
 	{ .compatible = "simple-bus", },
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e8bf3fae5606..07ccb1b0cc7d 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -127,7 +127,7 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "fsl,srio", },
 	{ .compatible = "gianfar", },
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index b47a8fd0f3d3..6810b71d54a7 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -92,7 +92,7 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,mpc8641-pcie", },
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
index 82363e98f50e..61cae4c1edb8 100644
--- a/arch/powerpc/platforms/8xx/adder875.c
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -92,7 +92,7 @@ static int __init adder875_probe(void)
 	return of_flat_dt_is_compatible(root, "analogue-and-micro,adder875");
 }
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .compatible = "simple-bus", },
 	{},
 };
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index e62166681d08..2bedeb7d5f8f 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -147,7 +147,7 @@ static int __init ep88xc_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,ep88xc");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 63084640c5c5..78180c5e73ff 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -122,7 +122,7 @@ static int __init mpc86xads_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,mpc866ads");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 5921dcb498fd..4d62bf9dc789 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -197,7 +197,7 @@ static int __init mpc885ads_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,mpc885ads");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/8xx/tqm8xx_setup.c b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
index dda607807def..bee47a2b23e6 100644
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@ -124,7 +124,7 @@ static int __init tqm8xx_probe(void)
 	return of_flat_dt_is_compatible(node, "tqc,tqm8xx");
 }
 
-static struct of_device_id __initdata of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .name = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 173568140a32..2b98a36ef8fb 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -454,7 +454,7 @@ static struct celleb_phb_spec celleb_fake_pci_spec __initdata = {
 	.setup = celleb_setup_fake_pci,
 };
 
-static struct of_device_id celleb_phb_match[] __initdata = {
+static const struct of_device_id celleb_phb_match[] __initconst = {
 	{
 		.name = "pci-pseudo",
 		.data = &celleb_fake_pci_spec,
diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 1d5a4d8ddad9..34e8ce2976aa 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -102,7 +102,7 @@ static void __init celleb_setup_arch_common(void)
 #endif
 }
 
-static struct of_device_id celleb_bus_ids[] __initdata = {
+static const struct of_device_id celleb_bus_ids[] __initconst = {
 	{ .type = "scc", },
 	{ .type = "ioif", },	/* old style */
 	{},
diff --git a/arch/powerpc/platforms/embedded6xx/gamecube.c b/arch/powerpc/platforms/embedded6xx/gamecube.c
index a138e14bad2e..bd4ba5d7d568 100644
--- a/arch/powerpc/platforms/embedded6xx/gamecube.c
+++ b/arch/powerpc/platforms/embedded6xx/gamecube.c
@@ -90,7 +90,7 @@ define_machine(gamecube) {
 };
 
 
-static struct of_device_id gamecube_of_bus[] = {
+static const struct of_device_id gamecube_of_bus[] = {
 	{ .compatible = "nintendo,flipper", },
 	{ },
 };
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 455e7c087422..168e1d80b2e5 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -21,7 +21,7 @@
 
 #include "mpc10x.h"
 
-static __initdata struct of_device_id of_bus_ids[] = {
+static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "simple-bus", },
 	{},
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 25e3bfb64efb..1613303177e6 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -149,7 +149,7 @@ static int __init mvme5100_add_bridge(struct device_node *dev)
 	return 0;
 }
 
-static struct of_device_id mvme5100_of_bus_ids[] __initdata = {
+static const struct of_device_id mvme5100_of_bus_ids[] __initconst = {
 	{ .compatible = "hawk-bridge", },
 	{},
 };
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
index c458b60d14c4..d572833ebd00 100644
--- a/arch/powerpc/platforms/embedded6xx/storcenter.c
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -24,7 +24,7 @@
 #include "mpc10x.h"
 
 
-static __initdata struct of_device_id storcenter_of_bus[] = {
+static const struct of_device_id storcenter_of_bus[] __initconst = {
 	{ .name = "soc", },
 	{},
 };
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index 6d8dadf19f0b..388e29bab8f6 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -235,7 +235,7 @@ define_machine(wii) {
 	.machine_shutdown	= wii_shutdown,
 };
 
-static struct of_device_id wii_of_bus[] = {
+static const struct of_device_id wii_of_bus[] = {
 	{ .compatible = "nintendo,hollywood", },
 	{ },
 };
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index 15adee544638..ada33358950d 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -290,7 +290,7 @@ static int gpio_mdio_remove(struct platform_device *dev)
 	return 0;
 }
 
-static struct of_device_id gpio_mdio_match[] =
+static const struct of_device_id gpio_mdio_match[] =
 {
 	{
 		.compatible      = "gpio-mdio",
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 8c54de6d8ec4..d71b2c7e8403 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -393,7 +393,7 @@ static inline void pasemi_pcmcia_init(void)
 #endif
 
 
-static struct of_device_id pasemi_bus_ids[] = {
+static const struct of_device_id pasemi_bus_ids[] = {
 	/* Unfortunately needed for legacy firmwares */
 	{ .type = "localbus", },
 	{ .type = "sdc", },
diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 47b6b9f81d43..ad56edc39919 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -314,7 +314,7 @@ axon_ram_remove(struct platform_device *device)
 	return 0;
 }
 
-static struct of_device_id axon_ram_device_id[] = {
+static const struct of_device_id axon_ram_device_id[] = {
 	{
 		.type	= "dma-memory"
 	},
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index afc2dbf37011..90545ad1626e 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -171,7 +171,7 @@ static int mpc85xx_l2ctlr_of_remove(struct platform_device *dev)
 	return 0;
 }
 
-static struct of_device_id mpc85xx_l2ctlr_of_match[] = {
+static const struct of_device_id mpc85xx_l2ctlr_of_match[] = {
 	{
 		.compatible = "fsl,p2020-l2-cache-controller",
 	},
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index c2dba7db71ad..026bbc3b2c47 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -23,7 +23,7 @@
 
 /* These functions provide the necessary setup for the mv64x60 drivers. */
 
-static struct of_device_id __initdata of_mv64x60_devices[] = {
+static const struct of_device_id of_mv64x60_devices[] __initconst = {
 	{ .compatible = "marvell,mv64306-devctrl", },
 	{}
 };
diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c
index 5aaf86c03893..13e67d93a7c1 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -101,7 +101,7 @@ out:
 }
 
 
-static struct of_device_id pmi_match[] = {
+static const struct of_device_id pmi_match[] = {
 	{ .type = "ibm,pmi", .name = "ibm,pmi" },
 	{ .type = "ibm,pmi" },
 	{},
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 83f943a8e0db..56f0524e47a6 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -265,7 +265,7 @@ static void __init xilinx_i8259_setup_cascade(void)
 static inline void xilinx_i8259_setup_cascade(void) { return; }
 #endif /* defined(CONFIG_PPC_I8259) */
 
-static struct of_device_id xilinx_intc_match[] __initconst = {
+static const struct of_device_id xilinx_intc_match[] __initconst = {
 	{ .compatible = "xlnx,opb-intc-1.00.c", },
 	{ .compatible = "xlnx,xps-intc-1.00.a", },
 	{}
diff --git a/arch/powerpc/sysdev/xilinx_pci.c b/arch/powerpc/sysdev/xilinx_pci.c
index 1453b0eed220..fea5667699ed 100644
--- a/arch/powerpc/sysdev/xilinx_pci.c
+++ b/arch/powerpc/sysdev/xilinx_pci.c
@@ -27,7 +27,7 @@
 
 #define PCI_HOST_ENABLE_CMD PCI_COMMAND_SERR | PCI_COMMAND_PARITY | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY
 
-static struct of_device_id xilinx_pci_match[] = {
+static const struct of_device_id xilinx_pci_match[] = {
 	{ .compatible = "xlnx,plbv46-pci-1.03.a", },
 	{}
 };
-- 
2.1.0
