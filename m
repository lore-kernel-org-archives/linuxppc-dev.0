Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CA606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzvZtGEZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSBd04gZmz2yTQ;
	Mon, 16 Nov 2026 00:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794749268;
	cv=pass; b=mT3rRRy80C5KhQ1CPWaoH+SNJvlHM0HqKBarO7lIXPqRvzPpttV0LBiHlfil5HVUB7dzAIT7tRqT4kZefDolYiUGziCtNUaPGoBqKGgpMVhyRgGHUUsSs9XgNxvYTShLy3Z2PPVqmInpE2UVXLiOlXNLOugUk/qdgT0ALefTXfGBOkUKeABGCN0owo4ONEJ7WzWRQdSO9Y4ykyKxF85wfmBFv9LH4Dy+AwY7ORJvvl2honK4crDpATc8rDdVBTuRYyE7xwBy2Rlljo9qL92ggHJO+MmUiJLsg7ZDPhFigb69+kHjoI0CxOxe9AMVWKahGjlca0GJ9HZurcqmVFnhNg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794749268; c=relaxed/relaxed;
	bh=kpsr/ekNdbiKrqn74inRxZH25NSTrsbrkMql9hcN9HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXJeObwxHXVWKlARCoxP0wL8wIz1APvo2GfURmheOhaP9NVwWE/yCJOQvvH/DXhm5nA8RFw/1HVlM7jYAevkCZbbX3rUAKdI/Q1jMYKg0IOGo75zPbucb8ftKQX/KOPAVgS3oTZENTY2dO0SpPZj+sTaWl40fKIcISzUdFCsC6HBRlJkREB50nuUrhjVRjiJ81XH37MOZ74setVwOUAUopwyA+g+HxyPfPe5+zG5MTaUFjlwAnALWNUFiKJJbTfUXrDMtvul5pMMHAy0OFL7t1eK48D34o5/wmnJdkszS0osqjOO4HfEGfuBpVCinlvKqpa6ue0YRzI26jec10izTQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzvZtGEZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzvZtGEZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSBcr6gkxz2xL3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 00:27:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0913445B17;
	Sun, 15 Nov 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794749258;
	b=elwnUvd7eAAxW6WOzXuJcKDk3Mhb/WNQH9AKRQHgyVckZfbTuIX42qUQUlJfvd1pPlUx
	 FR1isbiI5JzvN0Ip9dLwM/RXktubXz4p7V3hMqJZNP1rhbPWDK4AVZ29IRxpiO/pMtD1I
	 yKnsDuhlwH41FWeLRQ2sknjwl+07WFhal2QF05b+tgEQJZG3zpNw+/krhyUlixAw0SZP2
	 MW+aJM6E9GKrCcndzbir7JTbIU1iXQVFGT3VDPJmCM0dRkRZjvypWeLYc9lGP39AfH9NO
	 gBq5QoeRhIMP9SXpRHea75w5rCQ2V16ZfyjqQcRzynR2JxeYUInzwnrmLmYn4dW0cPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794749258;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kpsr/ekNdbiKrqn74inRxZH25NSTrsbrkMql9hcN9HI=;
	b=FHlF0K1R7BSh4rpnIJpyzT4PqgEw6XTEAJOMSz4HaC7EE2WIdN3U+vF6+mthSIY8nZx0
	 3D9n8bsz8RxMDx7HeAJONEqi8xljdS8VToAQv8Kl4RbrX270ezAifadMPOk4C225sjwdI
	 BbDrsSO7T03J9YL5OB+lbK6KvZtPO4tumix7LQXevyEUXGcjVzOwUdDZ79Im3Vf5h0E4p
	 CYUZtRV5GjqBRNqQq65Yx6rxyhlPZ6u4Pot4wDz9QOuJIYH+IuDDEcYhWhKq2w1wXL9pQ
	 nonKTyRoAXgNXZ7C+mVuOoYM8xkrXGaVpB4YCaFFCsZrC0x65Dsxkx6uodoAGiv0+ew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9B0EC1F000CB;
	Sun, 15 Nov 2026 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794749258;
	bh=kpsr/ekNdbiKrqn74inRxZH25NSTrsbrkMql9hcN9HI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XzvZtGEZiUxG66xXkM3emLwcEcEQEdvJwuwKBbGK7hwAqSOm6jT1WSFB3c94HMlv7
	 45UA9tAS6nRELUnkkshRDJ+YcIWiD3AGrBOV5N/N2LD6q4Om3fcRnKHQQ0XW6BeqwS
	 rnxHqT7L8iDe2YgGtP2ogUJzxQHbvNNe5N1SAnuMYW+P+sgpQy/2eISslExCsNIxHJ
	 p3BWUyxxQJYNF4WQHAMtoboCEo1M/gSuZcUHenbwLJM5MfaXtbxnBKnJ72bocd7DxX
	 k7OWhPydLmBBA+eqmC3dcV6VPoeNPHJDxaVOVqmNRYqetthmlW+MH+bhVz0f29wCC6
	 72yQYr/e9fG4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 246914A0BF;
	Sun, 15 Nov 2026 13:27:36 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Sun, 15 Nov 2026 14:27:34 +0100
Subject: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW pad-mux
 driver
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
In-Reply-To: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749254; l=17227;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=NHFNMED9WRB1iX7i7OnNM8/2pzjMadES8dKBmZ4qB/Q=;
 b=Vnd9zq7mvvjRQSktIxQLPovAIL/cJ2cutAApY+5q9j8DoH+VGq+MgoywaNCJTHNTAUjUvhNI8
 Vi2H6UuLb9EB2hUMU0YNDAgaH/+s9U5ViQCkA2EovCLtns8l14r+x0W
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vincent Jardin <vjardin@free.fr>

The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
fields of the RCW, read-only in RCWSR12..14 of DCFG and changed at
runtime through the same fields of the override registers in its DCSR
view, which read 0 until written.

Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
gpio to support bus recovery") Linux drives them with pinctrl-single on
the override registers, so its first pin state clears every other field
of the word: a board whose RCW programs a non-zero pad mux loses those
pads at the first I2C probe.

Add a generic Layerscape driver for the pad mux as a child of the DCFG
node. The fields and their encoding are per-SoC tables selected by
the compatible, so that other Layerscape SoCs can be added to it.

Only the LX2160A is done: the fields of RCWSR12..14 and the EC1, EC2,
USB_EXT, GTX_CLK and SDHC1_DS ones of RCWSR27.

Then pin states select them with the generic function and groups
properties, and every change goes through the RCW override
of fsl-guts, which reads the status register, writes the override and
waits for the status register to follow.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 MAINTAINERS                                        |   8 +
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c | 427 +++++++++++++++++++++
 4 files changed, 451 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..2df4866d37bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20207,6 +20207,14 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
+NXP LAYERSCAPE RCW PAD-MUX DRIVER
+M:	Vincent Jardin <vjardin@free.fr>
+L:	linux-gpio@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml
+F:	drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
+
 NXP NETC ETHERNET SWITCH DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
 R:	Clark Wang <xiaoning.wang@nxp.com>
diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index fd53cf5bb843..8e964cf620b0 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -283,3 +283,18 @@ config PINCTRL_IMXRT1170
 	select PINCTRL_IMX
 	help
 	  Say Y here to enable the imxrt1170 pinctrl driver
+
+config PINCTRL_LAYERSCAPE_RCW
+	bool "NXP Layerscape RCW pad-mux driver"
+	depends on OF
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+	default ARCH_LAYERSCAPE
+	select FSL_GUTS
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+	help
+	  Say Y here to mux the pads of the Layerscape SoCs at runtime. The
+	  pads are muxed by fields of the RCW: the driver changes it in the
+	  DCSR view of the DCFG that fsl-guts drives.
+	  The I2C bus recovery needs it to switch the pads of a bus to GPIO.
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index d27085c2b4c4..34309ac7411d 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_PINCTRL_IMX25)	+= pinctrl-imx25.o
 obj-$(CONFIG_PINCTRL_IMX28)	+= pinctrl-imx28.o
 obj-$(CONFIG_PINCTRL_IMXRT1050)	+= pinctrl-imxrt1050.o
 obj-$(CONFIG_PINCTRL_IMXRT1170)	+= pinctrl-imxrt1170.o
+obj-$(CONFIG_PINCTRL_LAYERSCAPE_RCW)	+= pinctrl-layerscape-rcw.o
diff --git a/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c b/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
new file mode 100644
index 000000000000..46686c6923c3
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Layerscape pad muxes: fields of the RCW, changed at runtime.
+ *
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/fsl/guts.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/seq_file.h>
+
+#include "../core.h"
+#include "../pinmux.h"
+
+struct rcw_pmux_func {
+	const char *name;
+	u8 val;
+};
+
+struct rcw_pmux_group {
+	const char *name;
+	u8 rcwsr; /* one-based, as in RCWSR12 */
+	u8 shift;
+	u8 width;
+	const struct rcw_pmux_func *funcs;
+	u8 nfuncs;
+};
+
+/* The pad-mux groups of a SoC, one per field of its RCW */
+struct rcw_pmux_soc {
+	const struct rcw_pmux_group *groups;
+	unsigned int ngroups;
+};
+
+#define RCW_PMUX_FUNC(_name, _val)	{ .name = _name, .val = _val }
+#define RCW_PMUX_GROUP(_name, _rcwsr, _shift, _width, _funcs)		\
+	{								\
+		.name = _name, .rcwsr = _rcwsr,				\
+		.shift = _shift, .width = _width,			\
+		.funcs = _funcs, .nfuncs = ARRAY_SIZE(_funcs),		\
+	}
+
+/* LX2160A: RCWSR12..14 and RCWSR27 */
+static const struct rcw_pmux_func lx2160a_iic2_funcs[] = {
+	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("flextimer", 2), RCW_PMUX_FUNC("sdhc", 6),
+};
+
+static const struct rcw_pmux_func lx2160a_iic3_funcs[] = {
+	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("can", 2), RCW_PMUX_FUNC("evt", 6),
+};
+
+static const struct rcw_pmux_func lx2160a_iic5_funcs[] = {
+	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("sdhc-clk", 2), RCW_PMUX_FUNC("spi", 3),
+};
+
+static const struct rcw_pmux_func lx2160a_iic6_funcs[] = {
+	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("sdhc-clk", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_xspi1_funcs[] = {
+	RCW_PMUX_FUNC("flexspi", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_sdhc1_base_funcs[] = {
+	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("spi", 2), RCW_PMUX_FUNC("sdhc-spi", 3),
+	RCW_PMUX_FUNC("sdhc-data4", 4),
+};
+
+static const struct rcw_pmux_func lx2160a_sdhc1_dir_funcs[] = {
+	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("spi", 3), RCW_PMUX_FUNC("sdhc-data", 4),
+};
+
+static const struct rcw_pmux_func lx2160a_sdhc2_data74_funcs[] = {
+	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("i2c", 2), RCW_PMUX_FUNC("flexspi", 6),
+};
+
+static const struct rcw_pmux_func lx2160a_sdhc2_base_funcs[] = {
+	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("spi", 2), RCW_PMUX_FUNC("flexspi", 6),
+};
+
+static const struct rcw_pmux_func lx2160a_uart_funcs[] = {
+	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_uart1_rtscts_funcs[] = {
+	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("uart3", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_uart2_rtscts_funcs[] = {
+	RCW_PMUX_FUNC("uart", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("uart4", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_irq_funcs[] = {
+	RCW_PMUX_FUNC("irq", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_irq_flextimer_funcs[] = {
+	RCW_PMUX_FUNC("irq", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("flextimer", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_evt_funcs[] = {
+	RCW_PMUX_FUNC("evt", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("flextimer", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_clk_out_funcs[] = {
+	RCW_PMUX_FUNC("gpio", 1), RCW_PMUX_FUNC("flextimer", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_asleep_funcs[] = {
+	RCW_PMUX_FUNC("asleep", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("evt", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_reset_req_funcs[] = {
+	RCW_PMUX_FUNC("reset-req", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_iic1_funcs[] = {
+	RCW_PMUX_FUNC("i2c", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_ec1_funcs[] = {
+	RCW_PMUX_FUNC("rgmii", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_ec2_funcs[] = {
+	RCW_PMUX_FUNC("rgmii", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("tsec-1588", 2),
+};
+
+static const struct rcw_pmux_func lx2160a_usb_ext_funcs[] = {
+	RCW_PMUX_FUNC("usb", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_gtx_clk_funcs[] = {
+	RCW_PMUX_FUNC("gtx-clk", 0), RCW_PMUX_FUNC("gpio", 1),
+};
+
+static const struct rcw_pmux_func lx2160a_sdhc1_ds_funcs[] = {
+	RCW_PMUX_FUNC("sdhc", 0), RCW_PMUX_FUNC("gpio", 1),
+	RCW_PMUX_FUNC("spi", 2),
+};
+
+static const struct rcw_pmux_group lx2160a_groups[] = {
+	/* RCWSR12 */
+	RCW_PMUX_GROUP("iic2", 12, 0, 3, lx2160a_iic2_funcs),
+	RCW_PMUX_GROUP("iic3", 12, 3, 3, lx2160a_iic3_funcs),
+	RCW_PMUX_GROUP("iic4", 12, 6, 3, lx2160a_iic3_funcs),
+	RCW_PMUX_GROUP("iic5", 12, 9, 3, lx2160a_iic5_funcs),
+	RCW_PMUX_GROUP("iic6", 12, 12, 3, lx2160a_iic6_funcs),
+	RCW_PMUX_GROUP("xspi1-data74", 12, 15, 3, lx2160a_xspi1_funcs),
+	RCW_PMUX_GROUP("xspi1-data30", 12, 18, 3, lx2160a_xspi1_funcs),
+	RCW_PMUX_GROUP("xspi1-base", 12, 21, 3, lx2160a_xspi1_funcs),
+	RCW_PMUX_GROUP("sdhc1-base", 12, 24, 3, lx2160a_sdhc1_base_funcs),
+	RCW_PMUX_GROUP("sdhc1-dir", 12, 27, 3, lx2160a_sdhc1_dir_funcs),
+	/* RCWSR13 */
+	RCW_PMUX_GROUP("sdhc2-data74", 13, 0, 3, lx2160a_sdhc2_data74_funcs),
+	RCW_PMUX_GROUP("sdhc2-base", 13, 3, 3, lx2160a_sdhc2_base_funcs),
+	RCW_PMUX_GROUP("uart1-soutsin", 13, 6, 3, lx2160a_uart_funcs),
+	RCW_PMUX_GROUP("uart1-rtscts", 13, 9, 3, lx2160a_uart1_rtscts_funcs),
+	RCW_PMUX_GROUP("uart2-soutsin", 13, 12, 3, lx2160a_uart_funcs),
+	RCW_PMUX_GROUP("uart2-rtscts", 13, 15, 3, lx2160a_uart2_rtscts_funcs),
+	RCW_PMUX_GROUP("irq11-8", 13, 18, 3, lx2160a_irq_funcs),
+	RCW_PMUX_GROUP("irq7-4", 13, 21, 3, lx2160a_irq_flextimer_funcs),
+	RCW_PMUX_GROUP("irq3-0", 13, 24, 3, lx2160a_irq_flextimer_funcs),
+	RCW_PMUX_GROUP("evt4-3", 13, 27, 3, lx2160a_evt_funcs),
+	/* RCWSR14 */
+	RCW_PMUX_GROUP("evt2-0", 14, 0, 3, lx2160a_evt_funcs),
+	RCW_PMUX_GROUP("clk-out", 14, 3, 3, lx2160a_clk_out_funcs),
+	RCW_PMUX_GROUP("asleep", 14, 6, 3, lx2160a_asleep_funcs),
+	RCW_PMUX_GROUP("reset-req", 14, 9, 1, lx2160a_reset_req_funcs),
+	RCW_PMUX_GROUP("iic1", 14, 10, 1, lx2160a_iic1_funcs),
+	/* RCWSR27 */
+	RCW_PMUX_GROUP("ec1", 27, 0, 2, lx2160a_ec1_funcs),
+	RCW_PMUX_GROUP("ec2", 27, 2, 2, lx2160a_ec2_funcs),
+	RCW_PMUX_GROUP("usb-ext", 27, 4, 1, lx2160a_usb_ext_funcs),
+	RCW_PMUX_GROUP("gtx-clk", 27, 5, 1, lx2160a_gtx_clk_funcs),
+	RCW_PMUX_GROUP("sdhc1-ds", 27, 6, 2, lx2160a_sdhc1_ds_funcs),
+};
+
+static const struct rcw_pmux_soc lx2160a_soc = {
+	.groups = lx2160a_groups,
+	.ngroups = ARRAY_SIZE(lx2160a_groups),
+};
+
+struct rcw_pmux {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_desc desc;
+	const struct rcw_pmux_soc *soc;
+	struct pinctrl_pin_desc *pins;
+};
+
+static u32 rcw_pmux_group_mask(const struct rcw_pmux_group *group)
+{
+	return GENMASK(group->shift + group->width - 1, group->shift);
+}
+
+static const struct rcw_pmux_func *
+rcw_pmux_find_func(const struct rcw_pmux_group *group, const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < group->nfuncs; i++) {
+		if (!strcmp(group->funcs[i].name, name))
+			return &group->funcs[i];
+	}
+
+	return NULL;
+}
+
+static void rcw_pmux_pin_dbg_show(struct pinctrl_dev *pctldev,
+				  struct seq_file *s, unsigned int pin)
+{
+	struct rcw_pmux *pmux = pinctrl_dev_get_drvdata(pctldev);
+	const struct rcw_pmux_group *group = &pmux->soc->groups[pin];
+	unsigned int i;
+	u32 val;
+
+	if (fsl_guts_pmux_read(group->rcwsr, &val))
+		return;
+
+	val = field_get(rcw_pmux_group_mask(group), val);
+	for (i = 0; i < group->nfuncs; i++) {
+		if (group->funcs[i].val == val) {
+			seq_puts(s, group->funcs[i].name);
+			return;
+		}
+	}
+	seq_printf(s, "0x%x", val);
+}
+
+static const struct pinctrl_ops rcw_pmux_pctlops = {
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name = pinctrl_generic_get_group_name,
+	.get_group_pins = pinctrl_generic_get_group_pins,
+	.pin_dbg_show = rcw_pmux_pin_dbg_show,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+static int rcw_pmux_set_mux(struct pinctrl_dev *pctldev,
+			    unsigned int fsel, unsigned int gsel)
+{
+	struct rcw_pmux *pmux = pinctrl_dev_get_drvdata(pctldev);
+	const struct function_desc *func;
+	const struct rcw_pmux_group *group;
+	const struct rcw_pmux_func *mux;
+	const struct group_desc *grp;
+	u32 mask;
+
+	func = pinmux_generic_get_function(pctldev, fsel);
+	grp = pinctrl_generic_get_group(pctldev, gsel);
+	if (!func || !grp)
+		return -EINVAL;
+	group = grp->data;
+
+	mux = rcw_pmux_find_func(group, func->func->name);
+	if (!mux) {
+		dev_err(pmux->dev, "%s has no %s function\n",
+			group->name, func->func->name);
+		return -EINVAL;
+	}
+
+	mask = rcw_pmux_group_mask(group);
+
+	return fsl_guts_pmux_override(group->rcwsr, field_prep(mask, mux->val),
+				      mask);
+}
+
+static const struct pinmux_ops rcw_pmux_pmxops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux = rcw_pmux_set_mux,
+	.strict = true,
+};
+
+static int rcw_pmux_add_functions(struct rcw_pmux *pmux)
+{
+	const struct rcw_pmux_soc *soc = pmux->soc;
+	const struct rcw_pmux_group *group;
+	const char **groups;
+	unsigned int i, j, k, n;
+	int ret;
+
+	for (i = 0; i < soc->ngroups; i++) {
+		group = &soc->groups[i];
+		for (j = 0; j < group->nfuncs; j++) {
+			const char *name = group->funcs[j].name;
+
+			/* already added from an earlier group? */
+			for (k = 0; k < i; k++) {
+				if (rcw_pmux_find_func(&soc->groups[k], name))
+					break;
+			}
+			if (k < i)
+				continue;
+
+			groups = devm_kcalloc(pmux->dev, soc->ngroups,
+					      sizeof(*groups), GFP_KERNEL);
+			if (!groups)
+				return -ENOMEM;
+			n = 0;
+			for (k = i; k < soc->ngroups; k++) {
+				if (rcw_pmux_find_func(&soc->groups[k], name))
+					groups[n++] = soc->groups[k].name;
+			}
+			ret = pinmux_generic_add_function(pmux->pctl, name,
+							  groups, n, NULL);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int rcw_pmux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct rcw_pmux_soc *soc;
+	struct rcw_pmux *pmux;
+	unsigned int i;
+	u32 val;
+	int ret;
+
+	/* The override needs the DCSR view of DCFG, mapped by fsl-guts */
+	if (!fsl_guts_pmux_override_supported())
+		return dev_err_probe(dev, -ENODEV,
+				     "no RCW override through fsl-guts: the dcfg node needs its DCSR reg\n");
+
+	soc = device_get_match_data(dev);
+	if (!soc)
+		return -ENODEV;
+
+	pmux = devm_kzalloc(dev, sizeof(*pmux), GFP_KERNEL);
+	if (!pmux)
+		return -ENOMEM;
+	pmux->dev = dev;
+	pmux->soc = soc;
+
+	pmux->pins = devm_kcalloc(dev, soc->ngroups, sizeof(*pmux->pins),
+				  GFP_KERNEL);
+	if (!pmux->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < soc->ngroups; i++) {
+		pmux->pins[i].number = i;
+		pmux->pins[i].name = soc->groups[i].name;
+	}
+	pmux->desc.name = dev_name(dev);
+	pmux->desc.pins = pmux->pins;
+	pmux->desc.npins = soc->ngroups;
+	pmux->desc.pctlops = &rcw_pmux_pctlops;
+	pmux->desc.pmxops = &rcw_pmux_pmxops;
+	pmux->desc.owner = THIS_MODULE;
+
+	ret = devm_pinctrl_register_and_init(dev, &pmux->desc, pmux,
+					     &pmux->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "pinctrl registration failed\n");
+
+	for (i = 0; i < soc->ngroups; i++) {
+		ret = pinctrl_generic_add_group(pmux->pctl, soc->groups[i].name,
+						&pmux->pins[i].number, 1,
+						(void *)&soc->groups[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = rcw_pmux_add_functions(pmux);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < soc->ngroups; i++) {
+		u8 rcwsr = soc->groups[i].rcwsr;
+
+		if (i && rcwsr == soc->groups[i - 1].rcwsr)
+			continue;
+		if (!fsl_guts_pmux_read(rcwsr, &val))
+			dev_dbg(dev, "pad muxes of RCWSR%u = 0x%08x\n", rcwsr,
+				val);
+	}
+
+	return pinctrl_enable(pmux->pctl);
+}
+
+static const struct of_device_id rcw_pmux_of_match[] = {
+	{ .compatible = "fsl,lx2160a-rcw-pinmux", .data = &lx2160a_soc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rcw_pmux_of_match);
+
+static struct platform_driver rcw_pmux_driver = {
+	.driver = {
+		.name = "layerscape-rcw-pinmux",
+		.of_match_table = rcw_pmux_of_match,
+	},
+	.probe = rcw_pmux_probe,
+};
+module_platform_driver(rcw_pmux_driver);
+
+MODULE_AUTHOR("Vincent Jardin <vjardin@free.fr>");
+MODULE_DESCRIPTION("NXP Layerscape RCW pad-mux driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("FSL_GUTS");

-- 
2.43.0



