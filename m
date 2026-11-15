Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBB606A337
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zom/TGJl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS7TD5pw9z2xL3;
	Sun, 15 Nov 2026 22:05:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794740752;
	cv=pass; b=FSw2hU8xvRp5mvBIi79nU9eSd/eRN76aVIAQEeIYKQrIeNeP7wp/TTdwNtevyixOzDDqNQlHVOBijLw9pcsujUd0Nla6uLdZwbVFRUy0QJX6+6vQEQQHX0CB4vmZTkJdOzkCHWNu4dh8a7Y6uIF0vRYBGKHONq4QVxidJV5Efrm8ELGRif6MsVwgSZmiVqAjaBKj6b1NG1CawCHC0dNVJVYtioTYfpet0GvIGqzOJqcCw3RmRornBn5vsaw15O5RFM7KjTeGm8H5sKl7FM/51TOhWlD8ELbZlWT4e2I/81QMFwRctW82N6Gpkxn1zKdL+q/H/2dvIEmgoHYLmr3i4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794740752; c=relaxed/relaxed;
	bh=hK+5XJC+lJT4Jur6NS/UQqYwsuEPNviAHyqonVulBXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPb8WGVGwAzeVuYfOCazeVrMQpMuA9pYPpimCzRFchDzYqjt79UJSrFIA3C+fu1lcTEx6YrIIdw5/oeVNY7kHLStNzafCV0mnCgCjMSsjcEsBbTmHj5PTOdFWwZEMvjPcm2kwfa0QBCTBClzDEOHj+SguUMheBuG5+X9Mv1mj15AgsHOzqE3+8BqbqueqFwqP2oSzfrNbelizGo2kfQyB1zcsyP+yQn39oE9oT4Q6NEtMwHkhEwKHOI+5evC6tt4LMftzsJWTDx72/6GWVtsmZovM80Z0DND5AYyWKecR4qmj4LMHmBztflmTPT+oVgp21qvu1oC7iRjg93+mjukeA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zom/TGJl; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zom/TGJl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS7TC31t4z2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 22:05:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8DDDB61EE0;
	Sun, 15 Nov 2026 11:05:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794740748;
	b=KTx01X199Tg9dUC3Svn7u7nL6y/XRPdznm8VqEpnIDt17T6ygsgBlMW2ANlcnZbZ0nDK
	 KTZmn1gPcYTxSjigx7+XBVDs8PxZya3iZyPL7SFak7Vg8zbmKEy69spZyJ2aawXGEOnjZ
	 G5+ycqHVXrRHzHI/O5IRNR2IewClktR/OgVGBGWMIxPCqyLJgVGGoORD/4RGkv3x5720G
	 ztRSL9rIMTvnhw1MlfoTcXzbCS4xVRpkDJMTqnSJOTTvkxkHhdiBcyvaHVJycci5qb25Y
	 B6KnsLYN81QyRAcBiA7n8UvOK6Bo6V1Ax7P1kZ7rCKUQXpI1NoCkNcNQBk/CF6DIuLw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740748;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hK+5XJC+lJT4Jur6NS/UQqYwsuEPNviAHyqonVulBXs=;
	b=aizfoc7rLzEp6ta5u25fCGe+odkReifAXMYn41Jw8oJdxJyyAb0ZZRzx9dq/Qrb8lMw6
	 OoUsNqkWkppSF5yw4f7nLv8QRH/jxYZ2h2hcPWfKzh5cYXfbPyuSmnImDj/49GqGKTI3+
	 NQnM3P7l4AWi7U+sNKLRUlnoofYLv7w039Bs3oQXBIF8qrJ4KLFhWyN10S5qmdAjKs1bN
	 5iOkNNj3KA//650G/bVh3N9pCqaTIlHhkM4++Db7zaRu+SmpwatBiuKZcpNB0d3YX8cW/
	 KRhY//TgHYtrt+qQ0XgU25ZDGatbtaVJNtfuW60xvPI3QkKFD1NxqGc/xFtduuXLeDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8BAAF1F000C9;
	Sun, 15 Nov 2026 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794740748;
	bh=hK+5XJC+lJT4Jur6NS/UQqYwsuEPNviAHyqonVulBXs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Zom/TGJl2jglCmDeusfRnuGd4oiUCCVG1lpBRkERosDaygzvKbyIjbGQk+dihpAV1
	 BFiNXLyxKIXtx7tlGd4bGN8B/mGsOT7efbkbYsEgccKyNSAhikntNqXOr37PyyGw6v
	 xw7MQLZ0WdyF+bUQOGvaV5CgUZMjlwWS6jpy6On+ndr7Fpt1ys315HmWprCta51ba3
	 Jmf1lMCE1OpGkhuHGXqlWuywCAPKKzd6AsYlnAaveS0dcqKLEGyAnDJLgwEDOlWHI3
	 nmoPUZc1BzyJP/1922Q8A4IpC+UGwAhVVRaX1ySB0fasWlvPpX2AQa6xcpxDku9ozk
	 5lhRdhXFaT80A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFC874A05B;
	Sun, 15 Nov 2026 11:05:46 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v5 0/5] lx2160a: change the pad muxes through the RCW
 override
Date: Sun, 15 Nov 2026 12:05:36 +0100
Message-Id: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v5-0-d246166ea469@free.fr>
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
X-B4-Tracking: v=1; b=H4sIAACS+WoC/5XNsW7CMBDG8VdBnmt0ZzuOzdT3qBiu8blYKklkQ
 0iF8u4YFqATSLf8b/h9Z1E4Jy5iszqLzFMqaehrNB8r0e2o/2GZQm2hQFlE0DIOWR7HcshMe/k
 7K7RAMncnOaZ+f5zlhFJj9BR8GzpnRYXGzDHNt5Gvbe1dKoch/902J7x+3+LrgQSySN7ptjXmM
 2bmdcziik/qfVBVUBMFcBa+vfsH6kfQvQTqCjYEYHXEQJ6fQfMAonkJNBVkjh0TWEtNcweXZbk
 AFtQmkcUBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740742; l=5609;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=v9zbbzSmM/69ewSbqBsLJz3u1dtfiSOwvumEGtAxm40=;
 b=GqByQYVV98x6n4nGkn0NfyLAeNioHLP8BT3zIxMzjmxdxn25CXDCJ/e8JYMpNjWAebS3xsOrJ
 zf4cC9UANfcAHuWvpY3BziHEdejlm32rxxQSgD0oZGrvfXi6qIJ253x
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
	autolearn=ham autolearn_force=no version=4.0.1
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

- patches 1 and 2 describe the pad mux as a child of the DCFG node,
  which gains its DCSR view
- patch 3 exports the RCW override of fsl-guts for the pad-mux fields
  only
- patch 4 adds the pinctrl driver: one group per RCW field, one
  function per encoding
- patch 5 moves the pad muxes of fsl-lx216x.dtsi under DCFG. Labels
  and pin node names stay, so no board file changes, and the
  pinctrl-single node goes

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

Thanks to Vladimir Oltean for pointing at fsl_guts_rcw_rmw() when I
tried to prime the override registers from the RCW instead:
https://github.com/nxp-qoriq/rcw/pull/8

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
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
      pinctrl: freescale: add the LX2160A RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 309 ++++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 377 ++++++++++---------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-lx2160a.c        | 401 +++++++++++++++++++++
 drivers/soc/fsl/guts.c                             | 122 ++++++-
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 1078 insertions(+), 176 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



