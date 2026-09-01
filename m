Return-Path: <linuxppc-dev+bounces-26416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D18EC61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 18:19:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZDf41S70z2xmh;
	Wed, 02 Sep 2026 04:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788286764;
	cv=none; b=SZ9U5xq12PIi/EtcUlRfMwxPkPqqb6Jc3P53CxYQmzlHtTZE68e2K37aeTVsLRSqE/Tz4VLQ3mt9GpLPGewDRLM7xuQhxdlt3S5WKyDDKtCqgpfWnWNplQhj/7seSWJ0VdXxbNaBn0M2cgi1iR7GPeW1HlUwL+E47WYMKxRgxpt8zs7reJXUiEcJq3vynCtdWbduFTFuXvOFInwCg1FimGb+amc/dSMp+TpyPQuc3EYaq2EdfsYv5hGh389yY4R7n6F3XDU0TP1/egrRq+RxGyYFw0JntU6oWxf9/RtkEsyqG4vg7JzgOckPzu+YVEGzy2V5t5lFo+H40D9WYM7PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788286764; c=relaxed/relaxed;
	bh=Zk2XlnxUEDpzK+TW/lBde7Hv4God9MNhlah+ZbRNPPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RSe97ZjGfa193EdJAoD0LSV9oCqSOzTHksqGH3BbV6ALbXk1Rx1kBT+EXMpUQJ8yeKv79WiH4argNshvQ/Wv2G+n/t9E/+Kcznv11enVzGqKPsUlsVLMB+mKDsPBi8HadUjDya0jjnnDjyHiO/pd/S4iHfNTu///ZeqTOpTVQthF2sUs8eQiqBt9c45dx78xFz2JOs3yTXvdcUxqMPcOpgBD8FMzNMfIxmDdyA8FkhvfuqBVB3Xo0ZAB6phNt7gdTuUnGb5x0Z0NUo6nw6rv+K+MW1kpc7b0GQLOY/a7FBE9mPXu7u1j9sErEYWLsVnBiH4aK8lMqeR0FsX60106Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NB+d6PUj; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NB+d6PUj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZDf30RZZz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:19:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 981E9600D2;
	Tue,  1 Sep 2026 18:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE1F1F000E9;
	Tue,  1 Sep 2026 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788286759;
	bh=Zk2XlnxUEDpzK+TW/lBde7Hv4God9MNhlah+ZbRNPPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=NB+d6PUjXroT2O4rq1NsKy/WnWNdlETPm3+6+6Dhx7nGg3+xhr5W6pqc/Ta01TBfg
	 5jTAG/HvtaiE/Nr9WMC3a//f2NlDy8roYAle+Mh3Mbvkh0tP/6xHyH6oRzQrvighSK
	 Cd0FM+Lwv661BPWxBBnxg9mQTulPEgeGCWUqaeuVUocDZGi+YWQfz47Wy3Ny6KX6Xp
	 HOJFK3IrZZ2hXFtsgaIsvV/7z6QCm0ZsHm+jM+c/yOReJFUXf5p+uiSJJcFzA6t2Tv
	 pR23rdLYSCrPfMXHiKIQNEV4Atsez1eZf1KbW4lbSFk+WllVMgr1YE5lbxkrqa8Nz0
	 y7O7eF6yOGswg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 =?utf-8?q?=C8=98tefan_Ghe=C8=9Bu?= <stefanghetu9@gmail.com>
Cc: Chancel Liu <chancel.liu@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260830205106.11267-1-stefanghetu9@gmail.com>
References: <20260830205106.11267-1-stefanghetu9@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_micfil: balance mclk enable/disable
Message-Id: <178826699502.33904.1590861277346269268.b4-ty@b4>
Date: Tue, 01 Sep 2026 13:49:55 +0100
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uSY59J9XqC32SHJcQ/CLHAGTtMIhMACTIWP7Zs9//l0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlxcijPDzxgYyIBQ1NhVfyOSU7iVYdFZaZ6S5j
 MkxiHNcXsKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapcXIgAKCRAk1otyXVSH
 0LfmB/sElU7Xxe0MtGpoINOgg+3hv1pemh25YoTNh99fHsMM7obEyKoOAXLsXp/RTpJvFdQFIKo
 BAfFkJ1ZvvT9Iibia0vKKfwGT0yebsK8ame85SY8q2gQPKwVwkUyPi92d8qcrdPbTTeEkd+IcNY
 sJ2hZdBHzJHnmKxJ0cmlFMAjxGCMBtIudtNrWc1nuCwZk5Or0AFU6ajvMOsmGYJfRU8z9lNNMs9
 zhLQV88Od0z3ObN1F0WbC0ThmyvxbwFDJ93MyKxNU2PmNxeXbBDPnlv6gbOD7LEXJ+DYYY4KHPo
 ydV3hhMXUhLur7bxH4FN0XTaJOXWhcDkPCEpEd5kaRzoj/Qt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 30 Aug 2026 23:51:06 +0300, Ștefan Ghețu wrote:
> ASoC: fsl_micfil: balance mclk enable/disable

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl_micfil: balance mclk enable/disable
      https://git.kernel.org/broonie/sound/c/d3dbccfe6afa

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


