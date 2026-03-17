Return-Path: <linuxppc-dev+bounces-18313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F5FD8763
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:10:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZskZ5N5tz2ynC;
	Wed, 18 Mar 2026 00:09:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773739102;
	cv=none; b=NQBrEj+3H/CF4qCWG1a2h+0l/nnGP/87SkwroAy6jMtcl5maXiaWi5c9FWDuKF7csO7RJBWH+ge/10Zls4s5r6y1vBAeqsIsREUBQk9spxEBaGvyBDV9gG/rVJ1IkcsIdzvngS3RppG+z6risI6j7LdNUT34kX84hj5USa+2+ctmJeiYBceIMaSu+xP5DW8npzkMODsuqlT7SyAvuOSNGJdpHQ/bTBahJZ9yRdKCsB++YbKRMR1+N6pCtKWXVEX5CHvR4Vt3imSdP2QJREgZUPC7mR2ZV8IDHbkyKAdUdxDGdsHO0VfTgKIELwugJoAkcYo+BgGLgEJHIYEuUhjAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773739102; c=relaxed/relaxed;
	bh=IXE5SBz0g4tQ/1jb/SMl3ANNl/v4ZpdRMRpfzUMz2v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iX0WOPfVO0jsGsHi8ka8MeBAQ2YzqQWt96MpCqT7yvdIkhPamdt26l5vJP7WVQJNFRdJ8hOL0U6EcYQWnb5C2+zqtSKVHaHauXN3eNCipgZYKYX7WgDL7tQNrEnZPY/CGqyujM0AmvQOvWskFLFH0ZBh3wrCABdXij0oHqg0TDHs9nkGKqYktb2IfhwnJn9A0w66wYOD1dNQrq8DUFHViA2Cx9kzWJPzBnwdQf5Q4Tqq/88lxcxEMpd7MiaUJWz4WWKu5zkg2gFywYcojs4IDxkgrTptTmAGNaeythX43qfSuv7st1q9FXvya5Nxbeh5YcCRAVsVS0EpGFCHc3UjXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ReNXgdl8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ReNXgdl8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mailhol@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZmbL0pvmz2xQB;
	Tue, 17 Mar 2026 20:18:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E2AF861334;
	Tue, 17 Mar 2026 09:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B28DC19425;
	Tue, 17 Mar 2026 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739099;
	bh=aDNsd04I+L/FbjpEUbNbTUbkn5QKAI4xvdupFjUj+7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ReNXgdl8wrMR0j9myTw0vxEUXdUH3VmbBFakEpeGWMQyqMywjtPl5Xtqb7CK3MSmU
	 qEqNhLfqwOJ19vhybs59iW13+uwkx3KQPD1k0k49R2AF01pvm7oM/8bhpwu6TqSVHj
	 U3AZOviPY7TMOtnC9489kfNRt6LCPMAYNZMv9zltaD4QIxRnuzLjQFi9j3bHLWFv0J
	 79xnWFh2qUeQUt8ASeRZuMi2RryimNsz37FHt/1I8V/TuTHEJAKzClw6hbiX+LbLFP
	 6qKpGFIeXpFt2tjpIv6KSmSCUuge4UXMpHfNph3juVSSLwwmFhtiqS83E7BmpwGge3
	 YHW1tZ2nsZxbg==
From: "Vincent Mailhol (Arm)" <mailhol@kernel.org>
Date: Tue, 17 Mar 2026 10:13:45 +0100
Subject: [PATCH 9/9] arm64: defconfig: remove obsolete assignment to
 SLIM_QCOM_CTRL
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
Message-Id: <20260317-arm_defconf_cleanup-v1-9-8eecb7fdd24d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=aDNsd04I+L/FbjpEUbNbTUbkn5QKAI4xvdupFjUj+7s=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJk7pft4ZO8tTex4wfvw9YIiq6jtBybw7z0uX/S3IE/wW
 /Gtf8Y5HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACbS4MLwP4DxBcvGZZMnmd8M
 9V0kJLhc+/yjhz7H/3y47t6w4o3BuxmMDHdCHOdwaR1uVt49bc6ST6s71+S/Mphb8ebstGlNC1b
 b2fEAAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The Qcom Slimbus controller driver is not in the kernel tree
anymore. Clean-up the leftover reference to CONFIG_SLIM_QCOM_CTRL
which was left in the defconfig.

Fixes: 7cbba32a2d62 ("slimbus: qcom: remove unused qcom controller driver")
Signed-off-by: Vincent Mailhol (Arm) <mailhol@kernel.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c5e23beeaebf..88951844c203 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1822,7 +1822,6 @@ CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
 CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m
-CONFIG_SLIM_QCOM_CTRL=m
 CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_IMX=y

-- 
2.43.0


