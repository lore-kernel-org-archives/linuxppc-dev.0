Return-Path: <linuxppc-dev+bounces-18278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B343F53D6C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 21:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZTWs6VQzz2xb3;
	Tue, 17 Mar 2026 08:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773698361;
	cv=none; b=I88R03pC1P42FG/1gCUrz/2hvuq3K5TIOcQzcvAEHxQlLaCwT8+YGx4s845R2B3zi8si+Be1EJifweaQwoLnt+PW5tB8ruYi3iQDKwUi9RuTBH/ciosYEEh8l5Oank0wzG6MIZRgG6baHcYfxvGYk3PHOrnipmNwDBLkTFf9lRImwU/SG/e7hQh6HLz4WHXhCz+BlwitOXJKiVx/IgyPZN+C6ou1JD+hY8T0aewcImmrstM0goKtsk6X4p4BU8qQ2OuahlyFDKrXU72sVcOedyarHuxkHkV07H8hJ21d7eZEqgOV8uAq5SwLomKWGodKjn73S/4oT75pD5C6LzmLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773698361; c=relaxed/relaxed;
	bh=j2c/dX7PIEnvzK/rowTInJ2SjEqCSatr8Yk1h/ME8bY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ctd4mZGajaVFLnpCWJFXjWL7ovNMhJ5upIO6kC790+hVz9CIZkSx/j1LBCPWCPx327TaKCvFe0kHosjiD6haR1lUSLex2GPkua5R6KY2Gm1LRmCbk5u3MiBuFlwyBqGnFZbI0jVJ9edc5ze7OnfJ90EcOWZPxQsEKzHcJX2ZBMp3nyG3cUEVJUacnjjJvomCQ43EEoaCylbn+d60mkPzJKs0gHcoT5k7qVvPoD6cFIBF5LDJv/GpE63QZekR1tz+rUxI6z44eyKKWYYYnuY6lL5kL7xw1J0EU+pmoa9YgT87Al9nicFDeYJwhahtpg7T6UZX6ZrrTidGt9IZBuFCTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Iq/Dd529; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Iq/Dd529;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZTWs1rF3z2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 08:59:21 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C1F4C40A52;
	Mon, 16 Mar 2026 21:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B03C19421;
	Mon, 16 Mar 2026 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773698358;
	bh=vrGXwD9VlecmbNLvADGSQ8uQl6EMPYpezK4IXtmHLKk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Iq/Dd529dztjm3Q1B9CUOX39Vu88FW0SraB1cmznm2GVmfV1C76dBPSt0B6/3OaX7
	 RmpzmoEX82lBgBJ0GDjCbKWPIxNEwYC2GxDbDdSsTJwV7+KyeGrCVCaEUonZLuaJOL
	 PYiyvSyQC63mCKqiCW6rRPZjdBO1+J7ilFf9emRiLEHqKP268PWPbnH3Hz2NwuJGdH
	 on3IWIpfQVHdfJksdQhwjrOfU482X+ubOODklXazDywORpW95lM7VSZEpMYfILsGws
	 ciRHD/YnXp5EqKa/0lRCidsu0X31bwzELNrMTJdl8qRdo2mV3cHxY6xDxxigZdPw/h
	 RAQFLKhjXWgOw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316180545.144032-1-joseph.salisbury@oracle.com>
References: <20260316180545.144032-1-joseph.salisbury@oracle.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: fix comment typo
Message-Id: <177369833562.303905.16450340257083825887.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 21:58:55 +0000
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
X-Mailer: b4 0.15-dev-f420f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vrGXwD9VlecmbNLvADGSQ8uQl6EMPYpezK4IXtmHLKk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpuH0zuO2xzmK0XXvCoGrRTsTY7kqNy2HySZXd5
 J0pYXnijlKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabh9MwAKCRAk1otyXVSH
 0KcZB/46E5feDUjG5Cgj6DMU4Zz+svPe5FGgJINy7Rd7fxaPq+4NQYDL9ec4/MQiFpw1JrgXx5e
 Dx06OFF8dkGEiEJ4vqRILo/c6pVj+PMeh2D+/s+9zKDDhpHbxw7xiVQPt07jQ/3QO0vr4qntLkE
 piXNN3NC8tH1KnmXDoKGMuaTKGFSVSqUxR9LvhC7cvY6BpEyoGtXsFXPOLci+KhRlzqDzJJWQ55
 Yhr6/DrcG3k+8Yth0pFqHAJTBSt1mwLxbiYbzUGlzQc8l/TaoyIz0JYQ6TKQKrDJ712jfUYMt07
 S1BLxtwJY9ULX/M8ojhZ9KUcC8rD++drNdgxqplMMu3+bE7a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 16 Mar 2026 14:05:45 -0400, Joseph Salisbury wrote:
> ASoC: fsl_easrc: fix comment typo

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_easrc: fix comment typo
      https://git.kernel.org/broonie/sound/c/804dce6c73fd

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


