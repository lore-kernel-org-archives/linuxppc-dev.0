Return-Path: <linuxppc-dev+bounces-29549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602D0CC6B34
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:32:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j54C53fC5z2xPb;
	Thu, 15 Oct 2026 21:32:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792060353;
	cv=none; b=Y0x2bCEXxPy/6WPfCuMvAeIRWjGAQh4IsXdzl4VQ8Wu2qXMIz9b3wFuWpbwK1DUCCuQT0bvQBTwiJ2TkrZzW97p93X2QgPOaEXG5nLX0uxA4Ydu1+qSHzSDSA3oDE6TbZJjQnZ/oce9lrTsGUUOspYrLW+V0I/tRsQL/zyeZN8LpEvA6hT9kYJaJ6lLujdZm3STNfDxERoWZXhbytpDRptCCMdkoBoQO2c1tXS3w8/EWxCM98AchIJnNzhZ7rmboVI21UGQp6vWt6WG8K1vNreLpPyIUvohtekLgB59SaycOcFBPjbMkMTRWZx6ylYsXNAwOKeMA5fk7ZVa9CBOoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792060353; c=relaxed/relaxed;
	bh=LsdCD24KD2Tp7y3HBX5d5H3zRxOHnSIBh2ksy9wg8Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oInPGDWnaqFOWiN+/h51gSPRRoFsNDTlZnEeEAVkTYLBBPfgZDtxNR8Cxl6I0scGLTCpYXMHu4QJ+JMqN441BHPxdnW9hoJowrDfYwQyu6UiWChou9cg6vaYC6fGnt3NyJRWGzHtAjaG3njnpzEND62BoUNkn8+c3Sltnd4pPVKGNDv2pWPdWgbGh8nxZQMONTc93UF4rAiOl2OKRX7obKUxAz5Q+hFQqP03sr6034hIQ9gPHax3pZWvOfvNNJLN4J9d4isZRcxOqvyHGJSaxH/d4zvfndTe83VTUiAvUse3BdVp2aG1a137GtZHOYL1uVmYkhwabUB5jwg7QvTFGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PI5GrVnW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PI5GrVnW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j54C34cwWz2xNg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:32:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E29F340E15;
	Thu, 15 Oct 2026 10:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E431F000C6;
	Thu, 15 Oct 2026 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060347;
	bh=LsdCD24KD2Tp7y3HBX5d5H3zRxOHnSIBh2ksy9wg8Ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PI5GrVnWNLXPUfA56WspsR/Sfk0JXapnfU2XLZpZyaYhVj7WNauNiYX8WZHeKvjuX
	 5SPyA829h6ChMVvtyYpWgC9r5KhwBmWi0V9iMUVWBSOABvvFFoQ7pIFY42kEWmFQDW
	 eH/hAvT8mHUsib5HpTG1kCLTIREHI5WbXfXRuxWoLuvwfn0jI4Kmv3qzJqMtz1kniP
	 2mY6REC4hDxFvstBjKKrjG0lY9PS7KCcSPrnW2it1S5hUOa0yuDC9X/40L4T6+HGb3
	 ynwiYKfpWJ3TlxbrBUA9buCkJjSpmDaMyM6UnyC3rTAvgSUUUH05G4s3qMUaPr+7SB
	 I2d/0P6cLtriw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, povik+lin@cutebit.org, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrei Simion <andrei.simion@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, phucduc.bui@gmail.com
Cc: Kees Cook <kees@kernel.org>, Syed Saba Kareem <syed.sabakareem@amd.com>, 
 wangdicheng <wangdicheng@kylinos.cn>, 
 Chris Bainbridge <chris.bainbridge@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Neo Chang <YLCHANG2@nuvoton.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Hemanth Selam <hemanth.selam@gmail.com>, 
 Md Shofiqul Islam <shofiqtest@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Zain Aboobacker <zainaboobacker33@gmail.com>, 
 Sang-Heon Jeon <ekffu200098@gmail.com>, 
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>, 
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, 
 Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>, 
 linux-sound@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261008103831.542533-1-phucduc.bui@gmail.com>
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 00/24] ASoC: Fix constraint return value handling
Message-Id: <179190764565.42298.7608820451808443258.b4-ty@b4>
Date: Tue, 13 Oct 2026 17:07:25 +0100
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4621; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XUYOScsxtpoMvmTZT4+4w0G08Qy83jX28yQHeYVl7kI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIurF436QbXa43IwJtVz+a9/WP+dErigiRWRdWnu6RO7
 AjMf7hrdUcpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAmIiLKyHDq2uODof8nCxuF
 ZpfxcTPWcS7d8W7zzOu3Jb2WdVWxqZ9n+J+wZiZ7iINepZ/T5W/rbJe6Pjpf3LOofnnrcZW5jw+
 FszMBAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 08 Oct 2026 17:38:07 +0700, phucduc.bui@gmail.com wrote:
> ASoC: Fix constraint return value handling
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> snd_pcm_hw_constraint_minmax() and snd_pcm_hw_constraint_integer()
> may return positive values on success. However, ASoC only marks the
> DAI, link, or component as started or opened when the corresponding
> callback returns 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[01/24] ASoC: amd: acp: Fix .close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/2c3400aa9f39
[02/24] ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/172888114dda
[03/24] ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/45dd2b22ea89
[04/24] ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/37ceef26df57
[05/24] ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/a92571113ef2
[06/24] ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/38559fcd1c51
[07/24] ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/06654a3ef513
[08/24] ASoC: apple: mca: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/4d23ef7515dd
[09/24] ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/50aaca643038
[10/24] ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/c2a3d0b2be0c
[11/24] ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/0634e7b24727
[12/24] ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/1de1fd7c69a3
[13/24] ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/fc5da89a0a8a
[14/24] ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/e66285731262
[15/24] ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/552944e3b027
[16/24] ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/b2c81f056c53
[17/24] ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
        https://git.kernel.org/broonie/misc/c/29f52545ada7
[18/24] ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/85e56c3bbb7e
[19/24] ASoC: intel: atom: Fix .shutdown() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/e3bb57581104
[20/24] ASoC: renesas: fsi: Ensure the component is marked as opened on success
        https://git.kernel.org/broonie/misc/c/6bba4e5a171c
[21/24] ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
        https://git.kernel.org/broonie/misc/c/b7c58a55fd9b
[22/24] ASoC: renesas: rz-ssi: Ensure the component is marked as opened on success
        https://git.kernel.org/broonie/misc/c/fd5c45166d65
[23/24] ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
        https://git.kernel.org/broonie/misc/c/8a43611c834f
[24/24] ASoC: rockchip: rockchip_max98090: Mark the link as started on success
        https://git.kernel.org/broonie/misc/c/303961c7daf1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


