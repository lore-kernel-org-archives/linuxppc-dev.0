Return-Path: <linuxppc-dev+bounces-29669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD57CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:46:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j75hv4hPrz2xgv;
	Mon, 19 Oct 2026 04:46:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792345615;
	cv=none; b=MA3J/IQtGF5RvClk7TUeIUD/KJYeC7S5Bg6yhjcDEnWKgot+84zfpQG871WtR0mPhJ7Jyb/uChXYNnZ0Oxozi453uGT+zO/peGLAfKp5cVkKsW1xOlTpFE2BF64Eev2m1d8ztgQOqsLeiPCghopmY1eosHsCgcXAFzHtACDGo/DR4Xm687YNm3fe6gS+00ejXbwMrVBhNak4lKuS5OlgW36fP62sQuPeFaZVzYKrwOs+E7/U0gbpAkAsmNONbvNYUnfNkuO6J+yQQuzxa8cKglOsTzi0+Mcqoz/4oszWbPNHKUfir6lyE7D6Jg10PMYRhScdqa9rtgk/QkSdR1zkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792345615; c=relaxed/relaxed;
	bh=qm0bUZ3rcefAzU93QB8wx2LCgCq+YoUpSKzCmzw8aJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fwuYeZDDctmhaSKqzhFwvjM6lzBtummAR/Q7evGtnkmC5slPJsMhPPjtZBnYLSEjX8qdY0BCa2lAg0aek216vHZ3cx9UdX0QNK+c96oDEmGJC22D06Rqg4F9ms5GpMJoQGDcnO1vHPkbAbdnOFOeLdVmxqCiXODX2iO6ZVuJyeXQCR/CLWZvW1/FBWOkEjUFpGPy20bldvX841hSn0/gX8mN1Eigfl2/O00gogkzA+Plqsp6vdaRuD7HOniVyAoNlfPHgKMmFimQFOlYF7gZLtuhv8dPthEMjgmeZweZecZQZin7FueS1IZKsdzOHGEQWpwZuMvaNonQyUAz/Jylaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgnkizFN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgnkizFN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j75ht1gMCz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:46:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 11058600D1;
	Sun, 18 Oct 2026 17:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A623A1F000C4;
	Sun, 18 Oct 2026 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792345609;
	bh=qm0bUZ3rcefAzU93QB8wx2LCgCq+YoUpSKzCmzw8aJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MgnkizFNOowWE0evXr5Uh7vD+jPSO/gov/FeEK/pjNv61+X6+VimnKiL+gqgPhcTs
	 /CMiac64dU9bA9cVg+BtlqJVWkEqvDLka/3h4Nm290GCXsZ/q/+R78ZTxGq5JcaRqC
	 65QcxFTZ7f1Msa1P1CPR7L3Sg7c+AMXBDaQoDpuCYzDuE0w+sR5tWuFMPuHzyJBx3t
	 Pf6JUV719A+lnO1EXjyeqCIr5hTwxP275HOPCfkVWguVthrbUVj4EhQE4R7UjmGg7g
	 B7BHLbKEtecZPWwidrdGQiLbtk6ICAo/FHXjg4O8qImalzZJiNj+KBVK8fn7rZp3Ze
	 pJocK/ZjMhiTw==
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
 Sang-Heon Jeon <ekffu200098@gmail.com>, Bo Shen <voice.shen@atmel.com>, 
 Vinod Koul <vkoul@kernel.org>, linux-sound@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 patches@opensource.cirrus.com, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 00/11] ASoC: Address remaining PCM constraint issues
Message-Id: <179218517604.3162228.12724790769290148003.b4-ty@b4>
Date: Fri, 16 Oct 2026 22:12:56 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IbT8SVwvSYBBCTFESIc2KDm/QvSO2/KtgP4EGXiEp2k=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLKusq6VV7j4Q+fT+tV8Vk/qHp+cEyB9TcR7+6xfMrncC
 cd6DjL87ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBERF8w/I/7XJ85O8xAc/Hn
 nbNu/1105pQVi4Gyd/41ga2VX2ew9MYzMjQYSM+fFbll6zJbMxubowlLrefOfC8z43y7r+I/4eA
 5/7kA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 11:09:35 +0700, phucduc.bui@gmail.com wrote:
> ASoC: Address remaining PCM constraint issues
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> Since v1 has already been applied, this series provides incremental
> changes to address the remaining items from v2:
>  - Add comments explaining why .open() and .startup() must return 0
>    on success to prevent the issue from being reintroduced.
>  - Add Reviewed-by tags from Vijendar Mukunda and Chancel Liu,
>    and Acked-by tags from Morimoto-san and Cezary.
>  - Remove redundant integer constraints already applied
>    by snd_dmaengine_pcm_open().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[01/11] ASoC: amd: Explain component open return value handling
        https://git.kernel.org/broonie/sound/c/1ba2cb30eeab
[02/11] ASoC: apple: Explain DAI startup return value handling
        https://git.kernel.org/broonie/sound/c/ec2e1434c7f7
[03/11] ASoC: atmel: Explain component open return value handling
        https://git.kernel.org/broonie/sound/c/1554ce7a5d99
[04/11] ASoC: codecs: Explain DAI startup return value handling
        https://git.kernel.org/broonie/sound/c/a6b1f3ccca48
[05/11] ASoC: imx-pcm-rpmsg: Explain component open return value handling
        https://git.kernel.org/broonie/sound/c/f3e3dbbbbfd6
[06/11] ASoC: intel: atom: Explain DAI startup return value handling
        https://git.kernel.org/broonie/sound/c/2f8d93394b7f
[07/11] ASoC: renesas: msiof: Explain component open return value handling
        https://git.kernel.org/broonie/sound/c/394f91bd0f7a
[08/11] ASoC: renesas: msiof: Remove redundant period constraint
        https://git.kernel.org/broonie/sound/c/d2f4c848d010
[09/11] ASoC: renesas: rz-ssi: Explain component open return value handling
        https://git.kernel.org/broonie/sound/c/65850cb2f9ce
[10/11] ASoC: renesas: rz-ssi: Remove redundant component open callback
        https://git.kernel.org/broonie/sound/c/a0b64de6ea7e
[11/11] ASoC: rockchip: Explain DAI link startup return value handling
        https://git.kernel.org/broonie/sound/c/48ed45aa30ce

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


