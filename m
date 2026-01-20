Return-Path: <linuxppc-dev+bounces-16070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6456ED2ECE9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jan 2026 12:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwRzx0rQKz3bmR;
	Tue, 20 Jan 2026 23:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768913533;
	cv=none; b=DEEoCCqHsiR3q60mZnDBJyXXxDmT6mlys70HNrW9QD/SI9wzxoZ6pgKRps2TwqK7bptYWpANoDp+0cTYFeHXbF1WAji8luOjSAiqaTRjpghWe4G7qyYDGCP8118oI98rlhuJg2ijnye1yYmEHz880Qu/GdL1ZHIgIWkgZOnkHnqZoKTIDE9eNXaw4mxC2dZbiFUJXovYrknr6x00ZIYG9IvIeBcdKHEEL/U9d4o70b1Sn2fmZQkq0mzq98N8sCJ3uQ5Mdoh3abMj8uG9PESZfVukNJz5JdA126wepuhoEs59bUmb7sOrmJI3JXSqreOMkOuA9lVR5gS+jAW2azhI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768913533; c=relaxed/relaxed;
	bh=BltawuzbsKcWyyUaJNr62FbHUHiJ9m7IQ2ucaRQoWyY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=isSdl+qpAZPQuc0LyeSHVrfhg2cwX88CfqaeHAjuE0mly2JOQpKrmi/6GiR8Cd/K8qe8Cimhyz6OZSa5563rh4fGXvTqVVns8VJppVC8ED54HmK98AeXoFtnzmMRS5QjWVCEx/PUcmCsWwSllEsQzQSaBjUz5WxcpLqnuZsFta0g6Nv1yWigpPO2F+uLcnzjipjUSSxJJdvdYWMyLPQFAwmVbMhZXC+OHj7eGEy6YQAgH560h3HWil4Ly3/8AebOBCGgUu93ej1U0zOLKKQafX/hl/nAT+EF144zsvRnURua/kjKTaP8++5ZTGcOb3q0QoVYUCLX2POz75DeoENhOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RGb5hCrm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RGb5hCrm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwRzw3wN5z3blr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2026 23:52:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EDBA5442BB;
	Tue, 20 Jan 2026 12:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40520C2BC9E;
	Tue, 20 Jan 2026 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768913530;
	bh=bc28KWZ4Nes1dVdT5o72sgDVqx84W02iDqzED50KaTA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=RGb5hCrmbwFcK2OkCJYJo2brNvk5x9DZplXTFTf57NLeH4f+Kl1GAnC3hEGU4lUgC
	 AD/72LTXbNet5aL6/lpknEYOjrbMCgyB7Nv467G3pUsPFkl1OWCzCR8EAW5nszRari
	 yWXSKQ5qtS8Yq0Vr60xU1K9HKh3K0eAzs/5v70ZEyVZPRVX16C0Ghx7SJorfqWtglX
	 pnrDkaoNxknAfVWCuc9+ITPycHLTB09VXke+aeiABgFJ3xluVr3WUzFEbpbHw1ByoW
	 R1XpRdh6Oc/1RJdmU2xbYCuAHDIRwL16lW/wqAFHC7RUuPzXVbwg5uPVWygvcWvtZt
	 hSCM7GQXKNj4g==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260115061418.4131432-1-shengjiu.wang@nxp.com>
References: <20260115061418.4131432-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: fsl,sai: Add support for i.MX952
 platform
Message-Id: <176891352801.86219.3828176720307654580.b4-ty@kernel.org>
Date: Tue, 20 Jan 2026 12:52:08 +0000
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
X-Mailer: b4 0.15-dev-47773

On Thu, 15 Jan 2026 14:14:18 +0800, Shengjiu Wang wrote:
> Add a new compatible string 'fsl,imx952-sai' for i.MX952 platform, which
> is fallback compatible with 'fsl,imx95-sai'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,sai: Add support for i.MX952 platform
      commit: 2e48020fd7ced9e9953c55b57a5cb608e64deee0

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


