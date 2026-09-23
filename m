Return-Path: <linuxppc-dev+bounces-28070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A569C9830D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 21:38:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqr145KkVz2yqw;
	Thu, 24 Sep 2026 07:38:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790199480;
	cv=none; b=aU1Mb3tJdauxw58n74TPV7i/TTvfP99qKFOZmJhK0pq1AkiP6e3bKGJFMpPDG9zPwRozZNYPGyUP3frHz7MnZ8hXMHXMWD6CcIe5wD7L6QrctDZ12l5H5K7KLSCPOM3n5jAbjQDwzWSAgOvToz0mKSYAhZDBrWqmHrwuOWpl4yRx2twXvjtBlKIcQHV8Jh7b90HH+FOGzkrsCDmTMKR0z6EuUSseczuvZGrlGQiQktIlUQezn8Qe2UBXjNG6iJAurQ+5o9pCLluKzbMpxkBa+dORQUutmmutldX8dPgooxeuUJQ/QcEWICI3MtlsVLfZkVw1zWtYI0OgdfUvOfxp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790199480; c=relaxed/relaxed;
	bh=uyAu47zUkyhI8o35FJeqCaCcq+21VWJUWLgzrg/IF7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A87TIKtIzxMPGbjlb7W5oDFV47y3NtNti5w4N/+pVERaDFSdI5gzJsv8DShX2sfj9jq0b4j74HSUecbz70isBNyZUBbGoLSLAXwnXYGphTuBebo88OjlHid9oSfJm3F6oANKA73jteFNRLwc2KhEjfp5pLn6LF+Jf6s7vBRmcITNlmWMXJZIJZ26EL3+NlfgF7d+CNrWs76AzoRFYNeTyEwg6nU0QUzF0VWTwVF78soThAHj3m5Kq9JLPXXQM+Q8aLqZXpCsiB5t9oN9HaKph/4G6UC0GR9474loeuJf5pdhcG5ONrgDehWCGd3+yo1HbSUPXCMbB/0Z8HcwEfO5qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1kGOVmJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1kGOVmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqr1375nDz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 07:37:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9870B413E8;
	Wed, 23 Sep 2026 21:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD61F000FF;
	Wed, 23 Sep 2026 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199477;
	bh=uyAu47zUkyhI8o35FJeqCaCcq+21VWJUWLgzrg/IF7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=S1kGOVmJNNgPizjRJLM3mmEWJYg8KdivmYTSCPIBkts7DxIUr+Bq/hTw9V8xdE808
	 Myk/SHw2DR7mcg6YkLD/br1rnRuQbfoGS/t3UdcZZsu82oD1CcvDDiaKc3SEcWsogm
	 EqydJ7JmTSVD9jcTK26iHxhLvCybTpT0eLoKCjxRyLdJM6vKCymajc0+xqim/wpqhf
	 lx7WG5D4f+RP46LtUzjUFCqbOvfAtFrlft0Pk+D3CRH8xlg/uKcldGhVw8H6HNG8oZ
	 etDadVI5pffGUrdyakJPGbZYAYheQopwKXIfKyyYIAemOPmrYmM/Xm9+qZgJxp7UcP
	 XoNHqy6OmQ/lg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260923054017.93553-1-mhun512@gmail.com>
References: <20260923054017.93553-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: free IRQ before canceling reset work
Message-Id: <179016750164.322763.13341325503493899165.b4-ty@b4>
Date: Wed, 23 Sep 2026 14:45:01 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uWseL9MtokTbmidoCbOrLXBq7nOll6YvZXZUrPR09Q4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtEauhW23oxSzoxIL+Irgp0A2CD8P0X6VM18j5
 XBhD/rhiciJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarRGrgAKCRAk1otyXVSH
 0N9BB/0YtHLEHoIMhJt84cgR3UffJD8L6WYiGnhahHrfFIPZxb/ENeT8SV4UFo3xyQTt/p0fRed
 9LjybeVUl+UTGIcGLOpFCyKGdyKTNW6OVcAwjWJfESNx75A2E/69+j9oHCUQsUboHgH3mnbN949
 zePy80PJtmqr2BWDa9D/1BxUVKHTsVLRJiJ5chf7I4Q9Totcb0YL+BoPqEwc1qN5TiTUF76NNu6
 cnsXhyLtwiqKbkpdGvSJm0OefU/hXndQzgt5aMcwdYhC4X97jfFsmtYffLe/fPyu3OT/vpU4ImR
 c6d2fHwgAO2SrhkMmVbbLV4MqmkH/06AwAmRXxIGPsp3Oyxt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 23 Sep 2026 01:40:17 -0400, Myeonghun Pak wrote:
> ASoC: fsl_xcvr: free IRQ before canceling reset work

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_xcvr: free IRQ before canceling reset work
      https://git.kernel.org/broonie/sound/c/83701fdb2d8d

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


