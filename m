Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B213606A338
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBoE/SlT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTzCf2nrcz30C9;
	Wed, 18 Nov 2026 22:00:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999630;
	cv=pass; b=aNBJtk+2xVnzmnY3SJcgOuSBnORbz4WcAThihNnyOxDXS4qevs2RtmUZt78XbgnG0BpLjAtk3mvBmxgZz+N0ff6IKmqJIPm9qb7VGla1MrFzuKuKVhB8YrkpSC8THhv0xJPCZhzRvm4i4NurxwvFm3w2aHkiNTn2YR6fcCawHZt5KJmN/2KyQJwS+CFfwSeuKBrcx2n6nzmkH266ARaotBdlAJ5pan3Vba6dZIKfZ1aJPWOhbMKbt0TM75GUzesbi/bXPrQkdJC3W96bLoBoHxJMGydPiSlYj1G6cFkxK0x2v7dboOY6SzWv6iWZJDEwDa8W9AOeUfeApFaoROLTmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999630; c=relaxed/relaxed;
	bh=JRiHNiSUNxuJIAFMjhbN0OWtJcGDEwIsLK2XPl70Gf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WupJE5FWqD42bqm2Ez68Lzki1sNZP/4FmTw84qeAH9HDeZFKBGy1HoAptTmrVSaK9Zv4WTr2G64vRlIyuJRQDPb/c9XHw2QjScRZaGQ7lt3MCkPIXw0G0SsLg9UtxKURePs/MqXokViGnrGuOJEKIZGN2HVDpZmP/gSUpOR087VZHZLubelF50jfvgV/8lESwLg1ujV3xqrJwaeE+fQNo7jkgdw+yO6xHj2O805OjFGSbPD5wkvbY6zud01j8X04wo+2ylcU7sUY7IGijpIIgzrzDpghfdsVLT5J52Nltf4HyndULUgVA3lpfUTF7SAYYOl+CROLKDtS9U61l+jw6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBoE/SlT; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBoE/SlT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTzCV74x5z2yfl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:00:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 92C4545D65;
	Wed, 18 Nov 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999619;
	b=AYkbTDRah1oyQP4U6T2Dhq4fJpVJ10VCIbZzrhmXPUbdhmvN90UsZIuPeLAQqPjEWhlX
	 iLif4Fhe+2M+LZj0dmUUn/+/fVelMdkDyeBpCOe2QfHq7gLv+r/zRPwqzC6syNCv47BVF
	 J/Pbp0ApLZuh3j9WGDuo9+2l4KX/4r4G33cDF7UVlXDzkszOthCnksb3CQLoFHxTGs9mB
	 D3a0VKK+GT1/jW9MWkw37uEI3r+wODq6GNEHhUJwRYhLxw6CGBVDkzdhgMiVaDOFRM0X4
	 9HJUE/QGMuTQZz8hjkZSnJFE7cpB1aewFDBZPHT4ROTtEz7E7ydKnYn5Y4ESbg87CQg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999619;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JRiHNiSUNxuJIAFMjhbN0OWtJcGDEwIsLK2XPl70Gf0=;
	b=k/G7uV+5CwHafRhGL+m3+kEPapgQTiwoeqg3wQd1kDXfjounYj/UQ/iYfVDHFprhu8gC
	 A3XlRry2I+VDE2MX+aDPbBD41fHCaEh+XEyaeEzUiGZTCGLz1A2Z10utY8h9ncOoSfjpZ
	 AMyOaKffItINmR42GnR517qcren7zwjocsA0Tkc0wE4TBloT6QXq39/CkLYTKuMHH6YCT
	 ZhIENGFrSxJIY4i/XNS0HQHWaNScxZRmI1QOXdu4fqYRARp7ycrVOhc/PO3SnMQvCvtYV
	 NYTDaoYEjBPnxcqqpVslL1qc/YMazH7UchkkZ2HoWCfuJDEMx2sIb23WDw+DOrXteFQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 493781F000C5;
	Wed, 18 Nov 2026 11:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999619;
	bh=JRiHNiSUNxuJIAFMjhbN0OWtJcGDEwIsLK2XPl70Gf0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=JBoE/SlT0BxZr7uLHh3CnomxEfQkO/CAbcL/6zrGvXZZARP6OkZloKnHzay0FiQw8
	 qiuGd7Xfew+WOvvD9FKlZVMH1z76wx8VGmGy3wkjQbg2UtL9Y7bnTMHdSMheEHH70I
	 7fMPvfPimNP6+GYIee8J0Ss1URmn0zXZcrqrZqjIGOVNyWAgR5NEKOrKj7msex2CTq
	 PWqU0flUBaHwKthWxDbKWM+E/VpyAeQ9eiS8KNitrimQN/I75tkKtowUAqrWBOgS6t
	 IcatvuSehW6el4D3dwCSIvKJwYFXStmO26yVA+zcCtv2BKyuanFFLb11jxMQmbWN+7
	 N6kuNlxBgryIg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 98A204AD10;
	Wed, 18 Nov 2026 11:00:16 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v8 0/6] lx2160a: change the pad muxes through the RCW
 override
Date: Wed, 18 Nov 2026 12:00:14 +0100
Message-Id: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
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
X-B4-Tracking: v=1; b=H4sIAD6F/WoC/5XQPW7DMAwF4KsEmqtCv5TVqfcoOjAS1QhobENOX
 BeB7145k93JBrg8Dt8j+GADlUwDezs9WKExD7lra2heTixcsP0inmPNTAkFUgrNU1f4vR9uhfD
 KvyclQSAv4Yf3ub3eJz5KrmXyGL2LoQFWob5QytOz5OOz5ksebl35fXaOctke4usILhAk+kY7Z
 8x7KkSvqbAFH9VxUFVQI0bRgDj75h+o12CzC9QVtCgE6CQjetqCZgVKsws0FSRKgVAAoLVb0K5
 Buwu0FYzKgAQgNOC3IBwHoYLpHAMZCxZt2IJuDbpdoFt+GJ0S0jsBanXhPM9/k/EH87gCAAA=
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
 Ioana Ciornei <ioana.ciornei@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Frank Li <Frank.li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999615; l=8519;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=ZivJdIHrAngUnsY02FFczoWyWLoShHDz/qgiwgS0cOI=;
 b=qizF9/i6kJlam15T4478/bn+4Rlc/T4+eWcAtnQptt7+6wM+Wpy1xzwaQhXTWzHzwKqQkQgq2
 fpJCWs/j86aCYJ/+NC6Ob0Ho3jOqUgBQKL7jOOQKumRbKet/208WKNb
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
- patch 6 notes above i2c6 and i2c7 that their pin states, and so
  the bus recovery, work only while the other bus is disabled: IIC7
  and IIC8 share one field

Patch 4 uses the exports of patch 3, so it cannot be applied alone.
As confirmed with Linus Walleij[1], patches 1 to 4 should go through
the pinctrl tree now that patch 3 is Ack'd by the soc/fsl maintainer, and
then patches 5 and 6 through the i.MX tree once the driver is in,
since the I2C pin states of fsl-lx216x.dtsi should follow this path.

[1] https://lore.kernel.org/all/CAD++jLnWcVDbh-vf20w4nfvOSZik619XqoEjXTBZ29sJkX-bCQ@mail.gmail.com/

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

Thanks to Vladimir Oltean for many comments and for pointing at
fsl_guts_rcw_rmw() when I tried to prime the override registers
from the RCW instead:
https://github.com/nxp-qoriq/rcw/pull/8

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v8:
- Patch 6 keeps the pin states of i2c6 and i2c7 in fsl-lx216x.dtsi
  and comments each node that they, and so the bus recovery, work
  only while the other bus is disabled, instead of deleting them: a
  board that uses one of the two buses keeps its bus recovery
  (Vladimir Oltean)
- dt-bindings: the function/group constraints are listed per group, in
  the order of the RM and of the driver tables, instead of per
  function: one rule per RCW field. (Vladimir Oltean)
- pinctrl: set .suppress_bind_attrs, as the other drivers of
  drivers/pinctrl/freescale do: unbinding with a hog on the node read
  freed group descriptors (Vincent J, code reviews)
- Patches 2, 3 and 5 are not changed, apart from the tags: Reviewed-by of
  Vladimir Oltean on patches 2 to 5, Acked-by of Christophe Leroy on
  patch 3
- Link to v7: https://lore.kernel.org/r/20261117-for-upstream-lx2160a-rcw-pinmux-v1-v7-0-5d7201970629@free.fr

Changes in v7:
- dt-bindings, pinctrl: add the clk-out function, encoding 0 of
  CLK_OUT_PMUX, so debugfs shows clk-out instead of 0x0. Rev. 1 of
  the Reference Manual marks 0b000 as reserved in the field: its
  revision history says "Updated 0b000 as reserved" and removes the
  CLK_OUT configuration section, while table 19 still lists
  000 (CLK_OUT) (Vladimir Oltean)
- dt-bindings: the description says that a group is one RCW field and
  that some functions carry two controllers at once, such as i2c on
  sdhc2-data74 for IIC7 and IIC8 (Vladimir Oltean)
- New patch 6: drop the I2C bus recovery of i2c6 and i2c7, which share
  the SDHC2_DAT74 field (Vladimir Oltean)
- Tested on the Nodebox v3: debugfs shows clk-out, i2c6 and i2c7 have
  no recovery state while the other I2C buses keep theirs, and the
  eMMC on the SDHC2_DAT[7:4] pads still runs 8-bit HS400
- Link to v6: https://lore.kernel.org/r/20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr

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
Vincent Jardin (6):
      dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
      dt-bindings: soc: fsl: layerscape-dcfg: add the LX2160A pad-mux child
      soc: fsl: guts: add the RCW override of the pad muxes
      pinctrl: freescale: add the Layerscape RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override
      arm64: dts: lx2160a: note that i2c6 and i2c7 share their pad mux

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 417 ++++++++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 387 ++++++++++---------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-layerscape-rcw.c | 429 +++++++++++++++++++++
 drivers/soc/fsl/guts.c                             | 125 +++++-
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 1227 insertions(+), 176 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



