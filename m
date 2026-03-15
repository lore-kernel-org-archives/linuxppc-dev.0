Return-Path: <linuxppc-dev+bounces-18206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43210F3027F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 21:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYsGJ471gz2xlm;
	Mon, 16 Mar 2026 08:45:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773611128;
	cv=none; b=YlCTsYGfeeqQ+yG0h0HU/PyGbqGHvA2ojgXU74WX/UeTmrfJcFZDYoJ/jQ2h6foOpwxUDp2qVqmAPcuV3ubO6PmbozNq/AjPfSs9VwqGnVJgldbkU+ZedUSEThOwljsEUhFP4tH7z35O6Q2yy5ONKPj/h6sjiyQjMUoO5CNhHRdZyOPKx26HAdfis9+1WAljKrZtbQNKfEQeAjdFlJaPd9cS0wzjN9HoCd/IEqvlagxHgXCtqJ+IjCc9wXKA0ig/fQpJ0YD5NJTA+UqgkmtK+DzYqrpVX0qexsRdMIyPjasS5u7pzWM/REvezn+OvvOE7I0wfg5SJIxhXymEzksM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773611128; c=relaxed/relaxed;
	bh=wRl9OPEvPg537AJLlGueGADngqSOtFq9uYoCvo8Q0HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIqwiHlIOKxtz7OY0QvGvXH1D+tzHQyu5133o3bVAuPNbq8OxrDQvgE0N7fUeHjBvjCdBSGjC2QlkUe5O0JmemkzQScMYVfevw1idL7u6jOgQtaXg+h9dA//pAjrEqAvqOHJscLW5GbqKI/3H5CP/BsRh1E7tm+ZKRihQhCmOJWJH0/HjZTE0xuAJNRGHBrzwgNDBRpW5wcoo25l8pNbutVWyn6mgwvDWqW1HSLTpjL/VGKChFYS1AlK882AaAu+F5lqhhDX02w3hjsmPcICxKyv8yjw7I7q7S4BWT+sCn5HiMgi3laeLNpwi65sve716O6KYSe3szPbNuP6XG1aFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=haH7+8Df; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=haH7+8Df;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYsGG6yx0z2xld
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 08:45:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0EB64398B;
	Sun, 15 Mar 2026 21:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94299C4CEF7;
	Sun, 15 Mar 2026 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773611123;
	bh=c1wKqfh+jcbPWKCBgQ7T1I8pmOpQA2n9dE3yAxPAIUY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=haH7+8DfIQKOvuZiq7y4d3Xh17mLZjfxayXlv6I9F0euGXTkNVywR9DmzZ0zBoPSg
	 AZPP+WC4gQdaA3wBULmw0esSoVufFILI3Sa0Olgzb58To1TDKrMVkCQM0d74qkhqXN
	 XDDY9vyXrCkocekjNep5S+dImvBF39tBBtJJAWwVpmihON3l9f/VyWvL2shvAW5NcE
	 L5wT5U0UobpMVZn4kX2kJnlvW+/0cn1rLGbqXMYKm40EBTxOfO2qLhqHO1ZJ0S/+B7
	 rfzJYnxighyJQfW3UhkMju2fgoLSgk10bZwek2Tt7rzdG/uZ37hqjtORfvP+/UxbZK
	 VrgbsKBiiOIew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8970FF3027F;
	Sun, 15 Mar 2026 21:45:23 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sun, 15 Mar 2026 22:45:13 +0100
Subject: [PATCH v4] powerpc: dts: Build devicetrees of enabled platforms
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260315-mpc83xx-dtb-v4-1-243849be4280@posteo.net>
X-B4-Tracking: v=1; b=H4sIAGgot2kC/2XP0QrCIBTG8VcZXmd4jlqzq94jutCpzYu2MYcsx
 t49N4KSLr8Dvz+chUQ3BhfJpVrI6FKIoe/yEIeKNK3uHo4GmzdBhicGDOhzaGo+z9ROhiK3qta
 gmENOshhG58O81273vNsQp3587fEE2/XTAVV0ElCgEtHXAlAx469DHyfXHzs3kS2U8Is5kyXGj
 BtrzhKErIWQf5j/YCg/SDxjobXgxijvNSvwuq5vf0DM1CEBAAA=
X-Change-ID: 20260101-mpc83xx-dtb-23d98a190e23
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773611122; l=7655;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=tOg76kwFnfAMdsOrfytYNNBMYvqrE5CInLny6ci6P8A=;
 b=NzezU5KvWQfGRrQUKE2dyqNsHIeSvAcWIJcymF5XosjLKnBuFipX8XPYE505TURVq6XeZfjly
 vIXtgeiIVmSA48hVV0xfWepdBBcRV2OnNU708VeW8A78pzzCT4nmZZW
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Follow the same approach as other architectures such as Arm or RISC-V,
and build devicetrees based on platforms selected in Kconfig. This makes
it unnecessary to use CONFIG_OF_ALL_DTBS on PowerPC in order to build
DTB files.

This makes it easier to use other build and test infrastructure such as
`make dtbs_check`, and is a first step towards generating FIT images
that include all the relevant DTBs with `make image.fit`.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v4:
- Correctly list turris1x.dtb in boot/dts, not boot/dts/fsl.
- Link to v3: https://lore.kernel.org/r/20260311-mpc83xx-dtb-v3-1-4aa43bb9ffa0@posteo.net

Changes in v3:
- Group multiple files per line, while still avoiding backslashes
  (suggested by Christophe Leroy)
- Link to v2: https://lore.kernel.org/r/20260305-mpc83xx-dtb-v2-1-cdb751458445@posteo.net

Changes in v2:
- Use "dtb-$(FOO) += foo.dtb" format on every line, avoid backslashes
  (suggested by Geert Uytterhoeven)
- Link to v1: https://lore.kernel.org/r/20260119-mpc83xx-dtb-v1-1-522f841290bf@posteo.net
---
 arch/powerpc/boot/dts/Makefile     | 73 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/Makefile | 43 ++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index 0cd0d8558b475c..1e61a951cebe84 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -3,3 +3,76 @@
 subdir-y += fsl
 
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
+
+# PPC44x platforms
+dtb-$(CONFIG_PPC44x_SIMPLE) += arches.dtb bamboo.dtb bluestone.dtb glacier.dtb
+dtb-$(CONFIG_PPC44x_SIMPLE) += eiger.dtb katmai.dtb rainier.dtb redwood.dtb
+dtb-$(CONFIG_PPC44x_SIMPLE) += sequoia.dtb taishan.dtb yosemite.dtb icon.dtb
+dtb-$(CONFIG_EBONY) += ebony.dtb
+dtb-$(CONFIG_SAM440EP) += sam440ep.dtb
+dtb-$(CONFIG_WARP) += warp.dtb
+dtb-$(CONFIG_ISS4xx) += iss4xx.dtb iss4xx-mpic.dtb
+dtb-$(CONFIG_CANYONLANDS) += canyonlands.dtb
+dtb-$(CONFIG_CURRITUCK) += currituck.dtb
+dtb-$(CONFIG_AKEBONO) += akebono.dtb
+dtb-$(CONFIG_FSP2) += fsp2.dtb
+
+# Embedded 6xx platforms
+dtb-$(CONFIG_LINKSTATION) += kuroboxHG.dtb kuroboxHD.dtb
+dtb-$(CONFIG_STORCENTER) += storcenter.dtb
+dtb-$(CONFIG_PPC_HOLLY) += holly.dtb
+dtb-$(CONFIG_GAMECUBE) += gamecube.dtb
+dtb-$(CONFIG_WII) += wii.dtb
+dtb-$(CONFIG_MVME5100) += mvme5100.dtb
+
+# MPC8xx platforms
+dtb-$(CONFIG_MPC885ADS) += mpc885ads.dtb
+dtb-$(CONFIG_MPC86XADS) += mpc866ads.dtb
+dtb-$(CONFIG_PPC_EP88XC) += ep88xc.dtb
+dtb-$(CONFIG_PPC_ADDER875) += adder875-redboot.dtb adder875-uboot.dtb
+dtb-$(CONFIG_TQM8XX) += tqm8xx.dtb
+
+# MPC512x platforms
+dtb-$(CONFIG_MPC5121_ADS) += mpc5121ads.dtb
+dtb-$(CONFIG_MPC512x_GENERIC) += mpc5125twr.dtb ac14xx.dts
+dtb-$(CONFIG_PDM360NG) += pdm360ng.dtb
+
+# MPC5200 platforms
+dtb-$(CONFIG_PPC_MPC5200_SIMPLE) += a3m071.dtb a4m072.dtb charon.dtb cm5200.dtb
+dtb-$(CONFIG_PPC_MPC5200_SIMPLE) += digsy_mtc.dtb motionpro.dtb mucmc52.dtb
+dtb-$(CONFIG_PPC_MPC5200_SIMPLE) += o2d.dtb o2d300.dtb o2dnt2.dtb o2i.dtb
+dtb-$(CONFIG_PPC_MPC5200_SIMPLE) += o2mnt.dtb o3dnt.dtb pcm030.dtb pcm032.dtb
+dtb-$(CONFIG_PPC_MPC5200_SIMPLE) += tqm5200.dtb uc101.dtb
+dtb-$(CONFIG_PPC_LITE5200) += lite5200.dtb lite5200b.dtb
+dtb-$(CONFIG_PPC_MEDIA5200) += media5200.dtb
+
+# MPC82xx platforms
+dtb-$(CONFIG_EP8248E) += ep8248e.dtb
+dtb-$(CONFIG_MGCOGE) += mgcoge.dtb
+
+# MPC83xx platforms
+dtb-$(CONFIG_MPC830x_RDB) += mpc8308rdb.dtb mpc8308_p1m.dtb
+dtb-$(CONFIG_MPC831x_RDB) += mpc8313erdb.dtb mpc8315erdb.dtb
+dtb-$(CONFIG_MPC832x_RDB) += mpc832x_rdb.dtb
+dtb-$(CONFIG_MPC834x_ITX) += mpc8349emitx.dtb mpc8349emitxgp.dtb
+dtb-$(CONFIG_ASP834x) += asp834x-redboot.dtb
+dtb-$(CONFIG_MPC836x_RDK) += mpc836x_rdk.dtb
+dtb-$(CONFIG_KMETER1) += kmeter1.dtb
+dtb-$(CONFIG_MPC837x_RDB) += mpc8377_rdb.dtb mpc8378_rdb.dtb mpc8379_rdb.dtb
+dtb-$(CONFIG_MPC837x_RDB) += mpc8377_wlan.dtb
+
+# MPC85xx platforms
+dtb-$(CONFIG_STX_GP3) += stx_gp3_8560.dtb stxssa8555.dtb
+dtb-$(CONFIG_TQM85xx) += tqm8540.dtb tqm8541.dtb tqm8548.dtb
+dtb-$(CONFIG_TQM85xx) += tqm8548-bigflash.dtb tqm8555.dtb tqm8560.dtb
+dtb-$(CONFIG_SOCRATES) += socrates.dtb
+dtb-$(CONFIG_KSI8560) += ksi8560.dtb
+dtb-$(CONFIG_XES_MPC85xx) += xcalibur1501.dtb xpedite5200.dtb
+dtb-$(CONFIG_XES_MPC85xx) += xpedite5200_xmon.dtb xpedite5301.dtb
+dtb-$(CONFIG_XES_MPC85xx) += xpedite5330.dtb xpedite5370.dtb
+dtb-$(CONFIG_PPC_P2020) += turris1x.dtb
+
+# Misc. platforms
+dtb-$(CONFIG_PPC_MICROWATT) += microwatt.dtb
+dtb-$(CONFIG_AMIGAONE) += amigaone.dtb
+dtb-$(CONFIG_PPC_PS3) += ps3.dtb
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index d3ecdf14bc42e7..d2cc8e1f007ea5 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -1,3 +1,46 @@
 # SPDX-License-Identifier: GPL-2.0
 
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
+
+# MPC85xx platforms
+dtb-$(CONFIG_BSC9131_RDB) += bsc9131rdb.dtb
+dtb-$(CONFIG_BSC9132_QDS) += bsc9132qds.dtb
+dtb-$(CONFIG_C293_PCIE) += c293pcie.dtb
+dtb-$(CONFIG_MPC8536_DS) += mpc8536ds.dtb mpc8536ds_36b.dtb
+dtb-$(CONFIG_MPC85xx_DS) += mpc8544ds.dtb mpc8572ds_camp_core0.dtb
+dtb-$(CONFIG_MPC85xx_DS) += mpc8572ds_camp_core1.dtb mpc8572ds_36b.dtb
+dtb-$(CONFIG_MPC85xx_DS) += mpc8572ds.dtb
+dtb-$(CONFIG_MPC85xx_MDS) += mpc8568mds.dtb mpc8569mds.dtb p1021mds.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1020mbg-pc_32b.dtb p1020mbg-pc_36b.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1020rdb_36b.dtb p1020rdb.dtb p1020rdb-pc_32b.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1020rdb-pc_36b.dtb p1020rdb-pc_camp_core0.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1020rdb-pc_camp_core1.dtb p1020rdb-pd.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1020utm-pc_32b.dtb p1020utm-pc_36b.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1021rdb-pc_32b.dtb p1021rdb-pc_36b.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1024rdb_32b.dtb p1024rdb_36b.dtb p1025rdb_32b.dtb
+dtb-$(CONFIG_MPC85xx_RDB) += p1025rdb_36b.dtb
+dtb-$(CONFIG_P1010_RDB) += p1010rdb-pa_36b.dtb p1010rdb-pa.dtb
+dtb-$(CONFIG_P1010_RDB) += p1010rdb-pb_36b.dtb p1010rdb-pb.dtb
+dtb-$(CONFIG_P1022_DS) += p1022ds_32b.dtb p1022ds_36b.dtb
+dtb-$(CONFIG_P1022_RDK) += p1022rdk.dtb
+dtb-$(CONFIG_P1023_RDB) += p1023rdb.dtb
+dtb-$(CONFIG_PPC_P2020) += p2020ds.dtb
+dtb-$(CONFIG_TWR_P102x) += p1025twr.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += b4420qds.dtb b4860qds.dtb cyrus_p5020.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += kmcent2.dtb kmcoge4.dtb oca4080.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += p2041rdb.dtb p3041ds.dtb p4080ds.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += p5020ds.dtb p5040ds.dtb t1023rdb.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += t1024qds.dtb t1024rdb.dtb t1040d4rdb.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += t1040qds.dtb t1040rdb.dtb t1040rdb-rev-a.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += t1042d4rdb.dtb t1042qds.dtb t1042rdb.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += t1042rdb_pi.dtb t2080qds.dtb t2080rdb.dtb
+dtb-$(CONFIG_CORENET_GENERIC) += t2081qds.dtb t4240qds.dtb t4240rdb.dtb
+dtb-$(CONFIG_PPA8548) += ppa8548.dtb
+dtb-$(CONFIG_GE_IMP3A) += ge_imp3a.dtb
+dtb-$(CONFIG_MVME2500) += mvme2500.dtb
+
+# MPC86xx platforms
+dtb-$(CONFIG_GEF_SBC310) += gef_sbc310.dtb
+dtb-$(CONFIG_GEF_SBC610) += gef_sbc610.dtb
+dtb-$(CONFIG_GEF_PPC9A) += gef_ppc9a.dtb
+dtb-$(CONFIG_MVME7100) += mvme7100.dtb

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260101-mpc83xx-dtb-23d98a190e23

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



