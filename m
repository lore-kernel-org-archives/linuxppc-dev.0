Return-Path: <linuxppc-dev+bounces-21386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6005CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 10:21:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLt93QBVz2xc2;
	Fri, 22 May 2026 20:21:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779445313;
	cv=none; b=ebpcZV4f1LU7OzjcCNbzHU+zNYHQ5ta0RfQzGItws57ijNbeUL0rePx/BTKnb0ZY3ilp6aULkaYzcrxCzbZUCEf5b2CggEnnwiCcxmPzdTAZqA+fCaNS+hMF9MjMnE1Ce1uKp2HEM7q7meGghzg3hOeBkkd49ZdYkHunq7gZKykaGFCNPDkcqUAOQNxaYnOz3PCR+V2lVcV5et467UaCyJnFwkvDQ/dFcuGS0QxRNS0mJOrHuEXh+cSeTRQg8yaLDikDh7RybCU1/1t900zLA9vgUoZMHdoYKAK+mFew2EoCRCDpoxt26NwehmkPCWWA0+TNCxGE2gxbL2GKoiaL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779445313; c=relaxed/relaxed;
	bh=v5hG5ljo2yEbas7N/t9jsu08GA8nFBFOwWsnzFp/4F0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QTDFqgGQfsFsO1mECEkFGe5JGQ0TfV1JomyY1gzNJdbgI419iSG+F9U8sbfoP6lKr0BfcGl7rUR2z4OTDWxu32ixDkRY/cbZ5XuXg05PbThmlAdqz5HtyvU8Ufg2t6k2m8SOr9tCM3syp/1c+coUvZ3oKXNTsoz2AokeAwJ99uzM4PBZb031Mod32muEj+1sw/vxyXFZ2q8DhQEc36pgogq+Ln1MV0wxqbUyfIH6DEom87daWX18D/b8AFdDIhbOMR1P0vXutM5AqGQCEhnowctPkgNn3P/Zl3+DCUBZEFzHCGwzUa0gj8Sr0RJNDFxuvy8hho7YEufoz7mVjG5zHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJCAQjSj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJCAQjSj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLt25919z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 20:21:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2288F601F3;
	Fri, 22 May 2026 10:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90C21F000E9;
	Fri, 22 May 2026 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445303;
	bh=v5hG5ljo2yEbas7N/t9jsu08GA8nFBFOwWsnzFp/4F0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=OJCAQjSjVDyBLcKibt6kKzsl5FcdJH4CU24VcEGayWXiZn38GoqWQ5shUb36om2et
	 23jvjnBn3A++Far23IJrsugZfZfesUnRrKW4UrrgkdZXBbgd3mYW403sfor+SQuH0b
	 KmKI3960FzW0z4eu4o9s+2D0hh+RdmSqJn5zy+6HK09yA2e9qkiPLAZ8mAfcOddBON
	 yz94YRigmmm29ROsTd5hnKHXkNWX0+yYWUeE8P+AhcK9x6qp/C2KFPgVNc7sAxmoUy
	 LTyEVSz43hi6E+q8mdQGknAo0fJVYrmXaPOc5EKkxTjoj5ixebLWCsLL6v67xEE8Qs
	 KMjXPmJWzkGfQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260512065252.75859-1-shengjiu.wang@nxp.com>
References: <20260512065252.75859-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Eliminate possible interrupt storm
 during probe
Message-Id: <177918448823.6167.7164201834938027833.b4-ty@b4>
Date: Tue, 19 May 2026 10:54:48 +0100
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5ZVaWSjfDYV8xFEG2qHRcRpnpfYwZGaYOU2WyjAd3VA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC40SrnHckZVbEky/P7ocAxP+K2BJW/i9tLmd
 FCQ7nEsg4iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAuNAAKCRAk1otyXVSH
 0Ep8CACFYtYjQfnZ/W701ctqn2f/S7gjAAUoclcQFx8vbu9CwZr+9XEFiAKl0CsoZYKCrY7eQUH
 DwJnc3xGcchM4/Rpy2xRyT5dnfsZzU05F0hYj+Oy/KMYyMuS2v7k1/fuFgmVuVpQ6WfKmwkW2jq
 J71bPc+9SqR9rnAHJuxlTSYaUC3aCe6rz68xxMek7bBtRJnoG6PyiL6JSXoEADpBAeoFJZSQBQq
 2Xzg7I58gExyEDm/ofVQkqITMqC6F98ToppFahOoI8fvAH+fmlANMUO9e5FlBCVjxuKF8Il/MO1
 jza7u/eFEiKvaiMA4lSu/bqAD1GqwKC8nie7Zqn2lQlh8S5F
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 12 May 2026 14:52:52 +0800, Shengjiu Wang wrote:
> ASoC: fsl_sai: Eliminate possible interrupt storm during probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: fsl_sai: Eliminate possible interrupt storm during probe
      https://git.kernel.org/broonie/sound/c/fd3b95866d86

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


