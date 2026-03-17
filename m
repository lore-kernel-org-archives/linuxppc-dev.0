Return-Path: <linuxppc-dev+bounces-18309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F45FD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZsjn20Qwz2ypY;
	Wed, 18 Mar 2026 00:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773739022;
	cv=none; b=hANQ4XFF0JdScJ8MLxNfTfKMxmCVSfCl3HxfMGERcHqwKo66yelsHnO92AuDL+oSPGlB4PJ5FcK6sSrLpSwjJm+daSnceWYDfelUgXEjFpAopaOllad/U0uDT07wiquxB3u4x+4v0GpFIgdhirINU6TcfqK7B87kQYnpaZ3xbpt4DO1Lna+/1tyBIWHtQibIBUesyZlrPSYf4aqpV4+rqFlDYwMbGy7L3Y5NnDG7Fzr050rRUDuWVKg6xauY+OabJGqd8wuXr+aWmiLmLnMtO4Q6JgUen0I0IAsqCl85TsNeS2Dg8yDPGrz4BGUXWKt+WEkMjHAE8n9rwq+xRONZng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773739022; c=relaxed/relaxed;
	bh=V27gIRVRx5KuFzAchtms7mRgL0MBJ3ywci9UIgbbhRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYSbIbADAWLrKCfxnsy6a9deeUgf2ZPeMScA2YRj3r8COLfMBlcBt2R7gbWIfwOkweaLrklAoTylEyz4DWpDWuCtxyVwRJ1k3FYAXK6YNvpS54lcZzqW9BjYQEdamfMGIcv/W+JwNjrFNlerPfmHqLcD7aPNP5vQDnCTlA2kkJOyRbCi7Ap++xPUzFSlwFZtPpg597x8UvSEjeg+BByZK8iYuJMLW8Vdig1C8RQbC5B27mehyUMFQTw7ETFvS0t0DuxyPKmUZ0BpM8Bq4DIzYJFMKEQ4Rj8EB79HnzeXZCDRw9IzH/zytugvil1kuWGeRVW0f+7saFy6Bf6yG0EieQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XX7M7zEC; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XX7M7zEC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZmYn22kJz2yfP;
	Tue, 17 Mar 2026 20:17:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 100E46132E;
	Tue, 17 Mar 2026 09:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA256C4CEF7;
	Tue, 17 Mar 2026 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739018;
	bh=BznAsGmiCeBt3HfillpWJCB2/zJ7nKDTHjSQK2m08KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XX7M7zECNwKjK5OS+FeyBaOmMGOyngmufddo0EkGyv+uwFy4SUPrN43+m5BxPCC/J
	 AtY6vBCtM75tLbOaimM0mq5BNahVBzf3ZdUFVG/0qr0bUJ1EFjlFpWketC9SLf+UiW
	 /1ThQVxStc01xyZs7XwnrXMBIzigJROfdez3IXj8LyEWgwyUEsurLhdKoP8UmbCdov
	 uTOsSNgSHRBEcmj9OQ5ee5TFgXCxHCQNmg47OTy7MYreKutl7ijjjsx4VHdmo29uE7
	 zFtco1D5MfjELO7PpN6LQdLakf1erUIRe8Ko5bCj42aoPhDR9DX7jOAmsYoRVfYxfv
	 UP/sVsuffC8zw==
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Date: Tue, 17 Mar 2026 10:13:41 +0100
Subject: [PATCH 5/9] arm: configs: remove obsolete assignments to
 SND_SOC_ROCKCHIP
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-arm_defconf_cleanup-v1-5-8eecb7fdd24d@kernel.org>
References: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
In-Reply-To: <20260317-arm_defconf_cleanup-v1-0-8eecb7fdd24d@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Mikko Rapeli <mikko.rapeli@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Mark Brown <broonie@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>
Cc: Alexandre Gonzalo <alexandre.gonzalo@arm.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-omap@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-renesas-soc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 openbmc@lists.ozlabs.org, "Vincent Mailhol (Arm)" <mailhol@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=BznAsGmiCeBt3HfillpWJCB2/zJ7nKDTHjSQK2m08KQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJk7pfv2X1zzc02wu+AB9wRVzxmZoUwhQq/7dX4HLinKl
 dp6fntbRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIn0BzIyXPxQ/PNgWqLjqoTX
 F6Mqypbdvrsmo+jK18rAynstrp//H2L47x5/7Mrb/I26Ias/a50Reum3t/hzyZ6rWx2DUma0R+W
 lsgAA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

CONFIG_SND_SOC_ROCKCHIP was removed in commit cae3cc435db5 ("ASoC:
rockchip: Standardize ASoC menu"). However it is still referenced in
some defconfigs.

Remove any references to CONFIG_SND_SOC_ROCKCHIP.

FYI, the suppressions were done using:

  git ls-files -z 'arch/*/configs/*defconfig' |\
    xargs -0 sed -i -E '/^CONFIG_SND_SOC_ROCKCHIP/d'

Fixes: cae3cc435db5 ("ASoC: rockchip: Standardize ASoC menu")
Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm64/configs/defconfig        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a9bb85873c0a..e7028dc2f9d5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -814,7 +814,6 @@ CONFIG_SND_MMP_SOC_SSPA=m
 CONFIG_SND_PXA910_SOC=m
 CONFIG_SND_SOC_QCOM=m
 CONFIG_SND_SOC_APQ8016_SBC=m
-CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_SH4_FSI=m
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index baff2cd34721..7f6334d1d040 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1085,7 +1085,6 @@ CONFIG_SND_SOC_SC8280XP=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_X1E80100=m
-CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
 CONFIG_SND_SOC_ROCKCHIP_SAI=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m

-- 
2.43.0


