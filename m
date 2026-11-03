Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC7606D806
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2kRnXQw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJxWb1NgKz2xlw;
	Wed, 04 Nov 2026 05:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=172.234.252.31 arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793729579;
	cv=pass; b=ZOKXTm6RnBHk9kH1Km36A1XJ4a2Kw+k46pAXUX8AIG5ezYzWJjqdZS9DwD9a7POgaX25yIjazRQeBKvgD5MephWcbFbHCD32XRJBNR2tBeQuNZDchGef+OpfLdQ0fV0R8XQWshdPTap0MzQxqyTFUfvv5PUprIFmtM/VOSFyhb0uS5fz2/Qa+bPTWXW4mch7QYy245PzNWvGpC4kk1rbdrcVUNoeirjLDfP1xZM3rM5oY6+3xgTqcbQlqTizmHnxZfEnHXjGft06r7qYtNYD/HCNwtVmaEa7lCXYtgR3MqUMtxL7aSCtZP9Yi/G0RKG4QpMjP4vqOZovMbFaiawveQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793729579; c=relaxed/relaxed;
	bh=8ZmFtc8U9FV0AiYvmqGuNwKTKAhvpZNUyvvbwtA3sfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kk2VhYfdhYhzzUfyZmKhjnyjKTWZ/fqwon/7mYOT315rFlI0jpT1irMJMreKkX5uEnVobhR66rr/olPXnOr+k7pQWmQ++jcwKeFx4+koIPEU9P5sQA9ZY1sGiZd8RTzYwk5U5yuqkbbMkfVh7AHbadXtY37Qu8UPEHsMvvUy2VVkrN6nGQfqg28p+akGSki7UZdzFIdN9x4u18lUVliJ0TWNC3mN/z31gTkN26iiZ5YHaLYDCtCoUiGBLAde8YHRpE5kg2J5rDT8XqZu1NnkOrnQI7AXvE4YF7QBYxQ0I7ycUhaT+TUyy4MdkZ4Kxf2UuDeF9YWCRpr7iI6UT6wqMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2kRnXQw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2kRnXQw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJxWY5v9Vz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 05:12:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 33F3B43E7A;
	Tue,  3 Nov 2026 18:12:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793729575;
	b=I7qG0OsBnsTJtIZg81+bcKocV6Ph5TiHEufVUgM/3Fu55A7LK2RlUx7ezG6NWsSKw74v
	 MotN02J/D+Fu71HgeCADzzY0sZoirTkLlpox47/RriNNyt8gH35K4GAuQ9maaoOKAOcGN
	 fpWgUrFHCCd3gmi0k2hT28M+z4VmTvpvzkuYqV5ii9q/75xoUOQ2Rdrj9HKmyoppXTC5e
	 XpU6p3WXP6BCja4wPfHFv4flfbRTe9SRp7d+LsnJ1F6gDOXsmX+utnj9a5jCiNKRYw8D3
	 RtpIHHgM28EI3D2ruTEdp3o90WZb01I3O43xTYNWUa3Kq6Kcoi+O/jFp0xxTgCrv7RA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729575;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8ZmFtc8U9FV0AiYvmqGuNwKTKAhvpZNUyvvbwtA3sfw=;
	b=wc8u75D1LhXx7osvUc5Cr1OAFoRV0ED/vior9ZnCkpnrK1eNu7iGsgNPmw02w7fAhNED
	 YVVRIP99d8Kb/0wn0goOyf1ylOoYhTHAVYNrIemEACpYS6pOCsaXtlIYbMwPjU+e45Vbi
	 aJSYVgKxvJVlV7HUrgX6xhm1PIMLwEeBNAmeqJUXIomj3ZyLc7uRbwkxB7SBrBpvuAv9n
	 cMZTadSqqWYSty3u2il6mX+oacUgBVOvFTLF6trE6mJLedy3+5RKr1hU63DuiK62YoGSh
	 3loTwFcs2SjP2WW2CYtRt1QWoZTJIse6RmgffWbJUZevlpj51c576bfEMX8ydslCCcA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6DF6D1F000C1;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729575;
	bh=8ZmFtc8U9FV0AiYvmqGuNwKTKAhvpZNUyvvbwtA3sfw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=D2kRnXQwUD4y4WcPsq1uzCrH1rsdRS5BnqS1c57f0Ivx0ZyNjScy/GnSjmVkQId4g
	 YWDhNXcguPbZo3yjsDFx1zK/GD6+N7Vxvs5uc6QjqrlMKvkHPdBzZjB/VdFidjOfgU
	 tZMFALvBK37dFTHUNFVxd52XAkfjB/w1wJ/P5HY8yp3EfjWJEdW8fmbC8T+FvJrWvH
	 MeOADhLo6fJYveiDLrFe5pTLjWLuzQGKEz5ryRQ09NtNhPWBB3rS4Ki5Lo0xX0hmCB
	 YuLl9P9iATUYggv1pQV+2/r04a+PkoVZ525VnMS9kYe4sfti/UWjRlwjcbhrK5u+Cf
	 Kyl4tWVKUx7yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0266446A71;
	Tue,  3 Nov 2026 18:12:54 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v2 0/5] lx2160a: change the pad muxes through the RCW
 override
Date: Tue, 03 Nov 2026 19:12:08 +0100
Message-Id: <20261103-for-upstream-lx2160a-rcw-pinmux-v1-v2-0-3aad0860b984@free.fr>
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
X-B4-Tracking: v=1; b=H4sIAPgj6moC/5WNTQ6CMBBGr0Jm7ZhOIQVceQ/DooGpNJGfTKFiC
 He3cgOTb/O+xXs7BBbPAW7ZDsLRBz+NCfQlg7a345PRd4lBK22IVI5uElznsAjbAV+bJqMsSvv
 G2Y/DumEkzMnVtqvLrq0MJNEs7Px2Rh5N4t6HZZLP2Yz0e//SpylU1pCtq7wsi+LuhPnqBJrjO
 L7vkbbv0gAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793729572; l=3659;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=0LjsWnaiiLIaWzA8f1eKCexyJ3xjv0VT78KoZgdG1qA=;
 b=phgZRnMAvFRQMKKkay1sieT/ZvbPQm9gx4vCgob9X8ymrn7HG33n9PRARygDPqI4AdSYCD3GS
 CzJM/2cPj31BGAbNHKTVk2GKgDFoxkHlKPZ6yLiILgyRPUz2dcEJ55A
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
Changes in v2:
- dt-bindings: list, for each function, the groups, so the
  schema refuses the associations the driver refuses (Frank Li)
- Patches 2 to 5 are unchanged
- Link to v1: https://lore.kernel.org/r/20261103-for-upstream-lx2160a-rcw-pinmux-v1-v1-0-0a61a9837744@free.fr

---
Vincent Jardin (5):
      dt-bindings: pinctrl: add the NXP LX2160A RCW pad mux
      dt-bindings: soc: fsl: layerscape-dcfg: add the LX2160A pad-mux child
      soc: fsl: guts: add the RCW override of any RCWSR
      pinctrl: freescale: add the LX2160A RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 262 +++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 373 +++++++++++----------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-lx2160a.c        | 355 ++++++++++++++++++++
 drivers/soc/fsl/guts.c                             |  73 ++++
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 932 insertions(+), 175 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



