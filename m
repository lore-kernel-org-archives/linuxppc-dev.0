Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4079606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCLJnRvR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSBcz1H7xz2x99;
	Mon, 16 Nov 2026 00:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794749267;
	cv=pass; b=jT1c/tK4tf1gj6JR3jxYebIPZoroKoMvTy0QYPS7CGhr4OK4Aor2qlQF746umt+a8vgNb3AA+JHPpVuw8Siu0xjX3eCFRUH+ZpnKyyGf26UYBfNJrulwo957BpsbVzYie0nGJE1sAGYTlrHDCthRWtp+Mm/I05z6JlhfiINlXtaxlVB5vRJrGIdLpYLIrQM2XmtMTcFXdMPbDrHIIpbiDQtwY1//7SFfCA2a3W7o5yB2mEAYSAyHzbAHmxdE90ozx+5I0dQzWBgp2/N3GcRC/nxK13xV4GIDXSZjfTvTgFpsh9AFb1AdVOUzpPygqGohUFkYKg45CS8k4nM+clYpeg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794749267; c=relaxed/relaxed;
	bh=BIA0whIJAlzJQQUtd6LKoIk4to1LVuVgtSrojehsRRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yag2BzBxYMIjogMLjadkSe/9AQQQlyjVCWCDsFyAT7hlMgaz2N7AYQmrzKzLs9CuBGwtbenFbSOkSTH591aOAvjIGi9HgYJwQEP+3IJ5mInMWSnqabN+V1WSiq7HHrlJPkRt8dAbJGOYO0I09WZ+/k9cGaeUpI4g/7xwklSGmoxih6VNaRJqgCx0G6oix5CySOIpMb3TXCGNUjw4ecsBr/mdVJaQV5qUzwW9rUOcMJm0WP0NKNMkTKUQUVGRopm+JiUtdTlp0MnP4iRp9Ou94R6HeT95Ib/jatMAsKf+tOn6uvx2PF9AwybPWmtUz/gRjZ87SNWZkU6fiY2Fy2nA8A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCLJnRvR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCLJnRvR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSBcr5Qpxz2xKv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 00:27:40 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F318641754;
	Sun, 15 Nov 2026 13:27:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794749257;
	b=dgbx2bU3pnIf9TpPOJAJ5pHVtZCwXiomLpY3zZkiUDgubvxUQnLH0rmsXT7FmNLQ9P7P
	 XP6uFFiuQZBLC24M3jg19Yc9FpC2MZPh1tyguEi3KyLl2f7Q9hhM7cMERN6BnyS9Wj5rX
	 +RLypIXbV01/wh8DjOwcRhkh90er4e/22wD3J9AyMm8FQ20VZ8OZMiYB4h0HpvO/xfIog
	 pawGG+zqXBe8OYcCxEmbCahUQv9oKV7TTsKEcSuL7RT7vGMZr+pFC/94WHCoKTx7cFgcE
	 e3WJZXW63TDFmpiG5DUS+ZM2NhsSe0w8ZIyV18hoqByb74PQwgKBYR2zaM5XcYI2vTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794749257;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BIA0whIJAlzJQQUtd6LKoIk4to1LVuVgtSrojehsRRk=;
	b=2gTCtOymeKWgTKi80waV3W6wVYTBHsUJEKRn5qfkN8PkBYUwE5mV1u3auVm8IKeYO/p1
	 uimzKSNWTSWeQRxFWf33LFmR825Ytvb8W5mwhAE/mEks3qGJTJ5ii8NNX3qpV4x3+GCUN
	 lteD6p22FFiDeu7TwxtPyKVKYBqO8W/C9Q3oWnPNCPROH2cn5V5JG4SA+VxbSJ2XBU3ar
	 pzA+9yaBqqpsVeLfODGPwOMGIUpQ2IIRHtxzLYQaeTOiFSqBl2OBSm2bSSQK3Uhv0CPK/
	 s5iKeOguwDc/ngty6xO2J01LPzOu+kFDWO6tiEGmTZaPGRA3dW48Tf0iIzXD/vUNxIA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DD591F000C7;
	Sun, 15 Nov 2026 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794749257;
	bh=BIA0whIJAlzJQQUtd6LKoIk4to1LVuVgtSrojehsRRk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CCLJnRvRG6OZKYVK1DGOobVlH0iJB5r5Np3LLV2K7B+gESO+RsszeOY0j+iH9gO0m
	 ndt3E90mV8nj6KFizHR+HPxE9wA28g05h8ksXANS6tzRkQ92QCKGPBMWDEfq3MC82A
	 KJceK6f/EaQbKYVN0hhj/pDKsNbgpOOJgwZDOV0/eXBz6Cm4Jvh9Sp52BAYBblh0lz
	 5zVKywsVoiXazMu3KSWn3ZnN/OjIAchvLfI8zXO1V9KAuWV5QCmrlwQ2E++qVVxeLd
	 oT73MJfQyPn6CJbMZoOrb05+zcpfSF3j0W78MfMXOWgAu7q53GEakvFePThEcMwXU0
	 /DwnTt0ov9N0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE94C4A0B3;
	Sun, 15 Nov 2026 13:27:35 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v6 0/5] lx2160a: change the pad muxes through the RCW
 override
Date: Sun, 15 Nov 2026 14:27:30 +0100
Message-Id: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKz+WoC/5XNPW7DMAyG4asEmqtC1A9tdeo9igysRTUCGtuQE
 tdB4LtXyVKnkwNweTk831UUzomLeNtdReYplTT0NfBlJ7oD9V8sU6gttNIIoIyMQ5bnsZwy01F
 +zxpQkczdjxxTfzzPcgJpIHoKvgldi6JCY+aY5vvIx772IZXTkC/3zQlu36f4ekoqQiDfmqax9
 j1m5teYxQ2f9POgrqAhCqpF9enbf6BZg+0m0FTQkVJoIgTy/AjaFQh2E2gryBw7JoVIzj2Cbg2
 6TaCrYNAWAZHJov8Dl2X5BTl3JssWAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749254; l=6145;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=mzN2xb3WlzXIy4G5fZofLhzJhCSSEFwAHiDN49pOoxs=;
 b=mYvDvR3jK9uqwPDTAjsaWd3vmeQlBoiPubhfqT6ucGl8IJQGER12o+jxSMgBNbCrMvUQiQc9P
 P4+WWLnGa4CDdZh2oocAcdRrPY3jiSASegZtaXVNA73es4XBlGuXijT
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LX2160A muxes its IIC, XSPI, SDHC, UART, IRQ and EVT pads from
fields of the RCW. They are read-only in RCWSR12..14 of DCFG, and are
changed at runtime through the override registers in the DCSR view of
DCFG, which read 0 until written.

Since commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c
gpio to support bus recovery"), fsl-lx216x.dtsi drives the override
registers with pinctrl-single for the I2C bus recovery. Its first pin
state clears every other field of the word: a board whose RCW programs
a non-zero pad mux loses those pads at the first I2C probe.

This series reads the fields in effect from RCWSR and writes RCWCR, as
fsl_guts_rcw_rmw() already does for the SerDes protocols:

- patches 1 and 2 describe the pad mux as a child of the DCFG node
- patch 3 exports the RCW override of fsl-guts for the pad-mux fields
  only
- patch 4 adds the pinctrl driver: one group per RCW field, one
  function per encoding
- patch 5 moves the pad muxes of fsl-lx216x.dtsi under DCFG, which
  gains its DCSR view. Labels and pin node names stay, so no board
  file changes, and the pinctrl-single node is removed

Patch 4 uses the exports of patch 3, so it cannot be applied alone:
patches 1 to 4 could be for the the pinctrl tree with an Ack of
the soc/fsl maintainer on patch 3,
and patch 5 through the i.MX tree once the driver is in,
since the I2C pin states of fsl-lx216x.dtsi then belong to it.

DTBs built before patch 5 keep their pinctrl-single node and behave as
before. There is no Fixes: tag, since patch 5 depends on a new driver.
I did not believe it should be backported then.

Tested on a Nodebox v3 (LX2160A) whose RCW muxes XSPI1_A_DATA[7:4],
SDHC1 and IIC5 are not set with the defaults, so I could confirm:
 - with pinctrl-single the first I2C probe cleared those fields
 - with this series RCWSR12..14 read after boot exactly what the RCW and
   the board's pin states select
 - all I2C controllers come up with their recovery states and a
   forced bus recovery on IIC1 (multi-master enabled for the test)
   changes only that field
 - RCWSR27 reads what the RCW selects for EC1, EC2, USB_EXT, GTX_CLK
   and SDHC1_DS. Selecting SDHC1_DS again from debugfs is the first
   override of that word, and keeps its other fields

Thanks to Vladimir Oltean for pointing at fsl_guts_rcw_rmw() when I
tried to prime the override registers from the RCW instead:
https://github.com/nxp-qoriq/rcw/pull/8

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v6:
- pinctrl: the driver is no longer specific to the LX2160A, so that
  other Layerscape SoCs can be added to it: pinctrl-layerscape-rcw.c
  (suggested by Vladimir Oltean)
- Patches 1, 2 and 5 are not changed
- Link to v5: https://lore.kernel.org/r/20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-0-d246166ea469@free.fr

Changes in v5:
- soc: fsl: guts: the exports become fsl_guts_pmux_read(),
  fsl_guts_pmux_override() and fsl_guts_pmux_override_supported(). guts
  lists the pad-mux fields of the LX2160A and refuses any other field
  or register, so the serdes fields cannot be changed (Vladimir Oltean)
- dt-bindings, pinctrl, dts: add the EC1, EC2, USB_EXT, GTX_CLK and
  SDHC1_DS pad muxes of RCWSR27, the second reg of the node (Vladimir Oltean)
- Patch 3 is reworked: drop the review tags, new round of review is
  needed (TBC, from Christophe Leroy and Frank Li)
- Patch 1 gets a reg, 5 groups and 4 functions:
  same drop the the Reviewed-by of Rob Herring and Frank Li
- Patch 2: its description names RCWSR27 too, I assume the
  Reviewed-by of Rob Herring can remain
- Link to v4: https://lore.kernel.org/r/20261114-for-upstream-lx2160a-rcw-pinmux-v1-v4-0-eefcea066a55@free.fr

Changes in v4:
- pinctrl: MAINTAINERS with imx@lists.linux.dev
  FUNC and GROUP macros with LX2160A_PMUX_ prefix (Frank Li)
- Add the Reviewed and Ack tags of Rob Herring and Frank Li
- Patches 1, 2, 3 and 5 are not changed
- Link to v3: https://lore.kernel.org/r/20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr

Changes in v3:
- dt-bindings, dts: the pad-mux child is bus-addressed like the
  clock-controller child of the LS1028A dcfg: its reg is the RCWSR12
  to RCWSR14 window, under #address-cells, #size-cells and ranges on
  the dcfg node, the override registers stay the DCSR view of the
  parent (Krzysztof Kozlowski)
- cover letter: patch 4 cannot be applied without patch 3 (Linus Walleij)
- Patches 3 and 4 are unchanged
- Link to v2: https://lore.kernel.org/r/20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr

Changes in v2:
- dt-bindings: list, for each function, the groups, so the
  schema refuses the associations the driver refuses (Frank Li)
- Patches 2 to 5 are unchanged
- Link to v1: https://lore.kernel.org/r/20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr

---
Vincent Jardin (5):
      dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
      dt-bindings: soc: fsl: layerscape-dcfg: add the LX2160A pad-mux child
      soc: fsl: guts: add the RCW override of the pad muxes
      pinctrl: freescale: add the Layerscape RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 309 +++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 377 +++++++++---------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c | 427 +++++++++++++++++++++
 drivers/soc/fsl/guts.c                             | 125 +++++-
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 1107 insertions(+), 176 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



