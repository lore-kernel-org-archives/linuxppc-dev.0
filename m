Return-Path: <linuxppc-dev+bounces-18786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA1109C04D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:31:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgwTh0g00z2yVB;
	Thu, 26 Mar 2026 05:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774463480;
	cv=none; b=JkpuWzfcS9IqfQlLugCChs7k+0R96NJmj9wDbifsgqHG9g+Kn6kdBjmnlYz0IC4/KrH/DVkzffb6e1ol8hcKX5Eowr6xOh06KC9Yc144QnwYESoCQ/Z7IcFMeLUjo2Ad1Oq8T4XjNDOEoOFgvv5gqO0DIfqRHBshB17+vg3y9xUgs1JmAyZkQo1KSyAphCLgB93zYN3WJABmM7tdYnz/XyiEAMB7bCS8acCofqoS6hNAwVuxYpAqsmjtjbsgX7hLkLtuLI+1atjEMFK5yze5xqAQ0vUmlGIjJWSc4xZ/ExBvvc5QqpY/3Kbe2Dhf6KiJ/vNgY+SB+IjXrunkppApKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774463480; c=relaxed/relaxed;
	bh=vckWgAVOJ9cevkNwFKFHg8pjt0sK7p1nAj9aVpFgYKE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g18dluymmBjq8oy9cH0KMMrCIA4gOF7k3qH4HNO0snsoOjPnx8It7j1/sTlyUvu6277ME7DA2xIPHU5nMiSLcWiyAanBniUiK2ArrxCpJWh7iqrukn3vGT0dujCvh32a58zKyBpD1EpmbQwsYkOBl41gPks9RUdvQg7VryalpaHEZZGMcxHXPPKZEJUJFQ16sl17LsskpgARkSBweDqpTko9NvuKE2HAy1kMtEsn+l6CKTaikkdb0sMphtVE8mosmqN45yWECxHa+ta2/oyoqMV/eg6wt4dzvYirNZ+hFXcuhdNf3CjItItp9rwvk01bIXMLlG1RxlXl41kN7p60PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UeEBTn07; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UeEBTn07;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgwTg0jcQz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 05:31:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DD30260053;
	Wed, 25 Mar 2026 18:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7560C4CEF7;
	Wed, 25 Mar 2026 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774463476;
	bh=zhL9JB+DuwQd/luUpJG23uHoZ0unzfZ6/vWh/SK4hMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UeEBTn07QXI0wYZsn7sDnlX2vXOgFtcePh74PIwFP4IU5vuLmZgOWtM0TblBik8Kj
	 jEgDrcV0urj5br8rfs5wgFF499xJPQ0vxFGK/olStGJdZUcoOa52CpCthaHItb/pUD
	 Ooa/yorz48uRbvU/ikfnuMhguSpMuhO0D4/tBcdCxSvWmeBooVVnExJvG8UEG1ErFK
	 P0xeINjqCt7mtavXhPNY7d+X+17TTXqKAyKJ3qdw+6+ZhE2kVbYOoDzMjvgd2mTavN
	 W89pCc0xEO0zQOVkMqPvccjzGHVBrni9taOuC6wcrLqGH0mOljT2dqP7Lc3wU2bn7w
	 FLc2rwCtGdnVQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, kuninori.morimoto.gx@renesas.com, perex@perex.cz, 
 tiwai@suse.com, linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr, 
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
In-Reply-To: <20260324041400.16217-1-kexinsun@smail.nju.edu.cn>
References: <20260324041400.16217-1-kexinsun@smail.nju.edu.cn>
Subject: Re: [PATCH v3] ASoC: update outdated comments for removed
 snd_soc_new_pcms()
Message-Id: <177438195717.322033.1830244473384841196.b4-ty@b4>
Date: Tue, 24 Mar 2026 19:52:37 +0000
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
X-Mailer: b4 0.16-dev-6cc06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zhL9JB+DuwQd/luUpJG23uHoZ0unzfZ6/vWh/SK4hMY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxCnw8PM6nPSUVkOAUhwfwGoTGQ59Jkaht0WmE
 iBGT9u4w/WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacQp8AAKCRAk1otyXVSH
 0KJ9B/93qorpJGpvqwMkSEHjrcv+u21HEzvIbGwFEWm8F54qP5+pON/dD8hw+Krumgzxi5RWU2e
 DM0fJT0zeW2Bq9GRfkHglUIc5wy4dafPrMpSnM67TXU33e7JU95GU67qI8jEpRPDtEsQ3dQT+QE
 Di8Mck1lLxSYKpHCo2JAaAcV8lG0m7tfI1S0xkC8CBIM73yv19VPdyo+p78N181ygz24g6pKLfJ
 aI0mrBrPwUdooruJHDJE3Ke9BlU9sh7CwlnrrE28jdizhffpOFsf9GulUY1McL6+bUuccR2f8Ai
 ohTCrIMeB3Xj5EEmHP5YwBRUm+07a8y76zj2HAVA/edGfTV4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 24 Mar 2026 12:14:00 +0800, Kexin Sun wrote:
> ASoC: update outdated comments for removed snd_soc_new_pcms()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: update outdated comments for removed snd_soc_new_pcms()
      https://git.kernel.org/broonie/sound/c/3e839947b842

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


