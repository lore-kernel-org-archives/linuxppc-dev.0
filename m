Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7D6083611
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYxYkWJI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkPl6wk0z2yVB;
	Tue, 03 Nov 2026 20:52:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793699531;
	cv=pass; b=AsnoCUNSpvyZpprBREmyZzo0Dlxp+4eEuxbUtqsKUyGM2JfsXd3AW/8Nh80YsplDSxpuAjwkalfvX94ZEWdMhs+f4ww1a+UY3aKShuRfdGFRa4hF46XDHRewgMd+L+WiATVNkK+nNeRQgKMdeK7HdnnuriceqhaUsKmUImZc8wYkZhOr610VPllg+I5gJDWqhCNQbRNceZFXPnbVz2bnIwYaIXqJOI1OzLnJQu0GYsy4+G6zdjI/gK0FOrT1/GD3CqkvC8PgkiSddM0MWENvtJjLZ9faiajiyJ2o9eQy+YlpYaQ5sB8Z+C9s9Hs6EEcZqzP0jjH4zvy/UVvyuqjtMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793699531; c=relaxed/relaxed;
	bh=Cq+d0zPbekVbfPXnyR10Si7Wi/Qh6wqlZK0pSrczvHE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k1IeKY6QcVaLgBhp+sbfYJY3YMHA8Yer5V7enziCrxgZZba9MUA7aoR3zeFHfK2KXy206Huwfud2zD773rj8klN+hsHYeYEwXkcph5+NtsUw+DerRvWlNkdRS5o7K/fIWoev7GqBZ5L34T8XLopyDXMN/bATrh2Fq/kiCDMReUTYbHj/49nObI+s2w6f2fePZ7gbNiApkLGZ4bbJoolf/Tu+lYsVnaHq4M4m8CKS6aG2CypBlM7jEiFqnB/GmmO7wnn4FGXxJdrAb+tX1YO/ZUDjWvH+DKsEzO5lrKQdzsP3oADw2ZtY0IqQrxwIbkJxPpG4uLyf31DHpdjeC1Zg7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYxYkWJI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYxYkWJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkPj1LTQz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:52:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6EF4D4369B;
	Tue,  3 Nov 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793699526;
	b=ryQNYyaKgmrdMJbQd0+6PPSfBKEJSpPl/yZQNcPYM4fzQwvW8NDCbKeUcHTm/t2vYKfd
	 RrlpUfq2/WCXrhiMKkf+LLa2egeFR2Cb88caHuNl+YrTgR7aCmCpMudvjiUirclE4dVCn
	 i6kedmF/q8toOpp2GePbDlaXRbz72RmUDvjpdq9OvidyLlTrBSdoHjgxGgJuFZlp7sjWv
	 8XYlAS2IHV+66eabMsYA61i3kKmbSD53HVL/Kj56i9lrs9y+NBdcIRgOhIbf3tkuwZld2
	 ek9T2aXAWd+hl3o/wsHKX2EuWeoJlAclHyip4Xiv9qWkAB4Ctqf+7mU18pyIEBmscEA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699526;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Cq+d0zPbekVbfPXnyR10Si7Wi/Qh6wqlZK0pSrczvHE=;
	b=PLK3JW/REZ5YRD5UEr2cAVk8rzkt5lYeNzJwGQVjcfQ+IgpNFTgO0R+MhjSy/px5mWqI
	 mysVNaPWQEKS5/OZ6a/WNPH0fO0fyw9TxQ1oglLxG51Mo3KyM0RTflQIvJR9fZwnIObUN
	 GGWupiIB9UTprxNMHusDU3favx761OBEkqyJrR1MwdSqSLx+n5UMSsOlw71KzlO5gQjGF
	 W/4sxQRo4IH03q556dZhO1McHVR3dUdTVquIBP/TbkSMD0odDPiD8DuxWkgd1jciRi4Kx
	 B/wF/zp8gdXLAg/I61JEMMYjrY+sx1mVRmEh6bwmEoWr2lnOSkId9cudKPPH+1bJkFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AC3B11F000C1;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793699526;
	bh=Cq+d0zPbekVbfPXnyR10Si7Wi/Qh6wqlZK0pSrczvHE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=AYxYkWJIdFHwHZJjVVXs4RAEFsAskt3cCoHMGmtR9ubhCEOSTzC17Wbv5VZQiImhp
	 3ENQPBkHFPkXzOOjg3U9lboLrdwHg8Qf6twJyTOmwK45KcgPziwp3Rih8WzIWtN55q
	 s2OHsZ2g4j3VxES+V5GnVhevK2i16wwMairGMsHS2UhFiBD+ZTDlO94iPQY/69zGux
	 8MCMk9b+Fnl7UjGZq0JSgzgs8lF624WYRBpcmmNb3OGuce/uf1KwKPO0hpSV0Lb2sj
	 NdhM6aYwYW/eZ1WQ9A6Af/lDojw/Rnty+RF0I1rCbBpVvF2HIlzvZ9BxgM9KJgBJ5f
	 +2CqMT9c0MI8Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3A23E46876;
	Tue,  3 Nov 2026 09:52:05 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH 0/5] lx2160a: change the pad muxes through the RCW override
Date: Tue, 03 Nov 2026 10:51:53 +0100
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr>
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
X-B4-Tracking: v=1; b=H4sIALmu6WoC/x3NQQrDIBBA0auEWXfAMWCbXqV0ITq2A42RsUmEk
 LtXunyb/w+orMIV7sMByptUWXIHXQYIb59fjBK7wRrriMyIaVFcS/0q+xk/zZIzHjXsWCTPa8O
 NcKQ0+ThdY7g56KGinKT9J4/nef4AZ720WHQAAAA=
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
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699524; l=3357;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=H/F/71DKZELYrsCeArdeH29vFI4h+DiOsPHSFldq9hc=;
 b=HxbL5KezPJiJpYUCq6Y1ipgDHVAmH5FonZYrAkEpjXi56eVEz2l6plAPEXArY4C5zpW5FbAMp
 GPpKkEWmxMWCznkGZ59K/fOo2NEIQw55gnnzqhxdD6sTHdBVkl7xjg3
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

- patches 1 and 2 describe the pad mux as a child of the DCFG node,
  which gains its DCSR view
- patch 3 exports the RCW override of fsl-guts for any RCWSR
- patch 4 adds the pinctrl driver: one group per RCW field, one
  function per encoding
- patch 5 moves the pad muxes of fsl-lx216x.dtsi under DCFG. Labels
  and pin node names stay, so no board file changes, and the
  pinctrl-single node goes

Patch 4 uses the exports of patch 3, and patch 5 needs the driver of
patch 4, since the I2C pin states of fsl-lx216x.dtsi then belong to it.
DTBs built before patch 5 keep their pinctrl-single node and behave as
before. There is no Fixes: tag, since patch 5 depends on a new driver.
I did not believe it should be backported then.

Tested on a Nodebox v3 (LX2160A) whose RCW muxes XSPI1_A_DATA[7:4],
SDHC1 and IIC5 are not set with the defaults, so I could confirm:
 - pinctrl-single the first I2C probe cleared those fields
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
Vincent Jardin (5):
      dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
      dt-bindings: soc: fsl: layerscape-dcfg: add the LX2160A pad-mux child
      soc: fsl: guts: add the RCW override of any RCWSR
      pinctrl: freescale: add the LX2160A RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   |  71 ++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 373 +++++++++++----------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-lx2160a.c        | 355 ++++++++++++++++++++
 drivers/soc/fsl/guts.c                             |  73 ++++
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 741 insertions(+), 175 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



