Return-Path: <linuxppc-dev+bounces-20434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FADFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 01:08:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8gPc0RFnz2xnZ;
	Tue, 05 May 2026 11:08:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777943315;
	cv=none; b=L9h1Laqi0Sy6vomAnWr9F5Ni147i+xv6ZA9M5AcwEj1/DIAJvj7XvLgP1A6YPHac950HKPRriuDFrbvuSbKpHZX+qrrN/ogAdDa9iQvP+BmMe6SWZNoy7LYNvzyNwyI+Eds9GcRwN1iFyyeUtTljzfPl/KfeKaIbI+WIWutYrHfWEM3o8lT2V4rp0wqDqLYx0eNm4bzGjlML/qcCIwwtQ0ru/+gAtyLzyxtv3lYsLvdrvZOUfBiU8yxxw+7of+m23C9EK3kuteV+bpQi8Og4yKMek99OLFaVSjiLBEq9tCnpmf/ca2/djwxlyCfao+QXce5AD528IsofUTV2wWSDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777943315; c=relaxed/relaxed;
	bh=7MN/MAPbiTUUiOm+7Hx0WGyluuHvod0WjAZDcU/7rxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N2im/cXsOqjovsbLvlQeAw2CX6xZSkgpKFqGsRAlmNfy056ZkNWFAjrDj26Ae8yw2LUOkI0O1I2dXQCFD39F4nhIwJ4h5AmY9Iz3GRqxYff1H0IsaA6L9bCQFsT9AX1Mc3Vm5zLEGG8Emtnrz7JD9KiXLM3UjDSXYZFliSB3jr7DLJT5FOwL8xCM+COgTxf1a6jWxCAID+86pE86M78H0akkpj621Iu2mYm63zJivEIQgcTwJ3opyHaencDM3xbi525wMUVo5FgwxPjFR6ign8FlrPW14k1jKnLHGhMXvAxhh0RRWCBTivhSaYUEEHZwD9t9W+qkmc8rugWjeSIL+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsBWl9IR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JsBWl9IR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8gPZ6wPTz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 11:08:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E957F60055;
	Tue,  5 May 2026 01:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B39BC2BCB9;
	Tue,  5 May 2026 01:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943311;
	bh=sExGztjbNjK53NIWW7HhbL2VQMKB7jHq+Mz4VXC6PkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JsBWl9IRX6wu54VWJu+VVWHSnPlJ+63UqA99BB47VRXwaBZOhyJb5l87NrIcE3ZX+
	 C/IsSEpd4bL305xpYWDxnWQ/z9+tn3LGPlQv9bGuVKjX5exOTQclCxnURc08Y+aSLz
	 V7MosTs5WfYQt602Ggc/a3Hj240w3g85vkes5kVlQfHhgJll4U1c8NCsa1JqKq4MH3
	 lFbQyn/VF6PbasvlEYbxKV6YC1vzcFd4WPav4Th4i4U+Hxl+6EOdYgiHaTQCJZZPUv
	 SrVTp8Kp9yxe+wn4CzS53NzkgcBL5E7k5No3iBEnZ113XgijD3ZcZ2mbihaXD1T3qc
	 p79VVkD6xCV+w==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Viorel Suman <viorel.suman@nxp.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428-asoc-fsl-xcvr-event-generation-v1-1-f21cf0812c4f@gmail.com>
References: <20260428-asoc-fsl-xcvr-event-generation-v1-1-f21cf0812c4f@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Fix event generation for cached
 controls
Message-Id: <177790088876.458539.12321460496657732500.b4-ty@b4>
Date: Mon, 04 May 2026 22:21:28 +0900
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sExGztjbNjK53NIWW7HhbL2VQMKB7jHq+Mz4VXC6PkY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+UMMvTt3S99ftFabi4GLdy4UvAT0nQ4UKgBvn
 JxAe8Ni9USJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaflDDAAKCRAk1otyXVSH
 0FUHB/49evf8kQJKEqAWNgacwWUapt3tQu91CD601pBBjvaqilub/Ub72fuk+gwgnGLGe6Z8tjT
 2N7Q4kLLisrsPoBy9ULO20mhCtdwhTEK/OnaUFcc0GkNHbjzNCl8F6evKYkdatVVe0UFsayAdUV
 eWfXWlck4vXPzGo6f/R8Nlrnzn4IDKekzMotXrLrAN7O2sHWC6goOG+wJ02aRw8CjwWpYnJzE05
 O6vNLez2PRFTsLYNEX+qnRt2E0sUdqVAajml+rciu+GUciOkoOrUuVw6cbNK9x+7qVWlNSkY7Wo
 uM5ABcRc9CVByaVD+EMvoqTdq/B3yF1RS4p6va6K2iZO8p0+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 28 Apr 2026 00:07:08 -0300, Cássio Gabriel wrote:
> ASoC: fsl_xcvr: Fix event generation for cached controls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_xcvr: Fix event generation for cached controls
      https://git.kernel.org/broonie/sound/c/e8446a4a574d

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


