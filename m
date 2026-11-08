Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061C0606A33E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjjFArJf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMpVV6mqkz2yDs;
	Sun, 08 Nov 2026 21:06:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25" arc.chain=kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794132418;
	cv=pass; b=otc9ymWBofbRgIbcqv+fvpOCk3qykfgpSx9rFXwm+Q8Ocv7SmTIQpEf+oAWGdxbz2cOx378J1BXgZm0+gzO0eHJ0nmv+xYlg7Ghm13rEC4LA6HKKckNvLoFCuCzAVjzfE0YjtvmR9ulGhYBHwsmObM61DIB/Ageav8botWpqESEDvGqrjRKPGm1CBYO0s0N375kJBqDVgUoU2LHF0R+J0eAkfcSEgEbbV00qFsl2v1vOA8H7cADjHm+7UP0tYljCEM5pQI4nI/B/E8Q8GDWWp+i4MeU6zSt1zlVA/5d/yLa2LYY0KZv4QFCkl1nmdk3BWidlqyeZQ053TlBJO7gs4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794132418; c=relaxed/relaxed;
	bh=B79sLRlTLVfMTb4Uz9uXGrVdkkZX4oeV2WvlkP8+u3s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gvEyOuib7rzyMZ/rD+MAn8FSaRgJitRbVMNS8gbPWFw8rUD91x73vQrRufFCoqg+AS4YPVM8PV015XK5nJskrFGfM9iJT4Ujew9dVxBwoBATBkBHwhVkj6ihq6G+JwalZhJMtQHponIJis/84UcxQJKl2kUVWQbWOzpzuMqAjkq4fH027NnUp2Vz7wqLSyVMaRllARwdjHxYa6EGkkkfC25TiyC/4KA7P+kcKEu6OwY4o9yH5Uv1Ovk8JftLNWsCZkJJCIjAzNANk7l4irJ0bbdE2PwmuQoP5i6u5DmztJ/YbBhL2HDTizRgaN6P0VvlhBufyyBYtD0afKfbKYbJvA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjjFArJf; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjjFArJf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+vjardin.free.fr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMpVT0sKzz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 21:06:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA89943FDF;
	Sun,  8 Nov 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794132414;
	b=V6x9cMzKdds0+MQ62hJSbG4EYBkZY90AkiEawxjr2uyKBdnwAOkx3yVh0E4q1msrUyMC
	 MutAgee6biEITP0lV6u724YKZMwpnz1QktPgsjCcrUmjrI2jWacmlthgjEIAEstOjO98q
	 TfpK75kcnX8t7xEw4Iv4ljuixaYO/sGdAQC/9bs95aZ/75EHy3YAXdpOjdxtMhHM/N6Uc
	 KxaHq/wSlslrdSl+Ix/03TDqpgZbcTOwyOkY7q+9ke+jirOOVQeGfDkUPQH89apVIfqB5
	 zfGczJrGHJlnDt8D2h8PTOow9lZpzE8PdSOLosRRO0Ve13wZMezQj/VOL9+l8Yrh+Jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794132414;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=B79sLRlTLVfMTb4Uz9uXGrVdkkZX4oeV2WvlkP8+u3s=;
	b=NqXzTZpDNw9xhgrXn6HjJ8xoMe1mDxDWFRpvLq9+19sqUDMQhJhsFvlHESEkZ3yzf8GW
	 DpBUjZaq1HzV4eL7F3lLMjCxTTabUWuHgGj/qvQXIBU/FKd/IKai4ESI++UH8aS3ieFqE
	 Zu8yoUOc2BZoVyRCiEco1UxjcQ589JlQqSrHEc0NJMmzQjtFCxP6hzbzGujsdrLsEKhNh
	 rsu4LhCZn6XMTioAPKSowtq/Qq5vE6Mv462d46Mv1Igm5Kq47b7xzOnveR5iIguPIXEYo
	 hWSE5SD9g4RAfjClp/A5kJmecuZlRBq/YWLa+obHqe/9uMjaZExBCbQ+7zVqTXqLPMA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 871171F008A1;
	Sun,  8 Nov 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794132414;
	bh=B79sLRlTLVfMTb4Uz9uXGrVdkkZX4oeV2WvlkP8+u3s=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=MjjFArJfr4vvpcpYlg0LY8gat3cvLNY7yY2oxiubSpJl5NhhDDUcR8FQJu6MWIG4y
	 gBiyaW8e8VYyagD08fpqwKu4E9AHnk9CB8h2+B/FPvG0dP95suZBcyigPjOXHA5XFN
	 d554DiiYXTiomWn9L0ohBA6GQOH1MH1/DrN76whmG4HGQok4uSlpIiARVk552gKOQc
	 SsFprY1LhyvWqSOq03dfyql+yHQYNZutEJVfNv7hj3Y2/mSYAXo9JuyhO4cH+kI7BG
	 5O3gJwHcBzdQ3cwRw8a1zq/F4tdFCl/Vi0jizp7us1qn2vMNowP8h2NiMyeKzI1h4g
	 iCCKgPhACYLZw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DC5C747ECB;
	Sun,  8 Nov 2026 10:06:52 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v3 0/5] lx2160a: change the pad muxes through the RCW
 override
Date: Sun, 08 Nov 2026 11:06:48 +0100
Message-Id: <20261108-for-upstream-lx2160a-rcw-pinmux-v1-v3-0-5a0063f1da9e@free.fr>
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
X-B4-Tracking: v=1; b=H4sIALhJ8GoC/5XNyw6CMBCF4VcxXTumF1JaV76HcTHSVprIJVNAD
 OHdLazckszmn8V3FpY8RZ/Y9bQw8lNMsWtzqPOJVTW2Lw/R5WaSSy0EVxA6grFPA3ls4D1LoTk
 CVR/oY9uMM0wClAgWnS1dZTTLUE8+xHkfuT9y1zENHX33zUls30N8Pg4ctUBrVFkWxS2Q95dAb
 MMneRyUGVSIjhvNn9b8geu6/gDLm28EIwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794132412; l=4355;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=8qOvvLzHr2YInpyd/1vxj2b1Dv0S6oVIXe4mSCnnlG0=;
 b=Z6eeEU/IRNtio9zH+RBAjzG+uELIzoQb4b3cn+EU2qY7cBXUySKMbL04CTZMTdU8CZbQ2rQT9
 52Z7tVqd7h6Ay5NUrLoj719O3Zj/jE60Yt1RhzHPmfCq2yG1lQKb50d
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,T_SPF_TEMPERROR,USER_AGENT_GIT
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
      soc: fsl: guts: add the RCW override of any RCWSR
      pinctrl: freescale: add the LX2160A RCW pad-mux driver
      arm64: dts: lx2160a: describe the pad muxes as the DCFG RCW override

 .../bindings/pinctrl/fsl,lx2160a-rcw-pinmux.yaml   | 264 +++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-dcfg.yaml      |  18 +
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/freescale/fsl-lx216x.dtsi      | 377 +++++++++++----------
 drivers/pinctrl/freescale/Kconfig                  |  15 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-lx2160a.c        | 355 +++++++++++++++++++
 drivers/soc/fsl/guts.c                             |  73 ++++
 include/linux/fsl/guts.h                           |   3 +
 9 files changed, 938 insertions(+), 175 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-for-upstream-lx2160a-rcw-pinmux-v1-31f9ad97dc86

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>



