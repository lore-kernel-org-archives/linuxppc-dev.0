Return-Path: <linuxppc-dev+bounces-18125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882DD106ACD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 17:34:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWvrN3B6Wz3cGf;
	Fri, 13 Mar 2026 04:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773336884;
	cv=none; b=GFWrxTzQ+lHqC9HTulgBt/6vMcRpa50JuQWH7VYANCgcYqH/x3aRppAZBEKy6LC0QYKQMLhccEsPHYrSb6lOrwotrwPLkqPetxbzdwpQXKDe6MCqD6vzqlB2bNLLwnlVUhnmOMs036Ip+rmpEa56TfB0U9iJeHhrSzTZfum7JqLnyZhC63k/nrZaWau2RhdHv/OFTFD/3B3TWNXeedvI/4yobMzhOIgUqfbnWjfTFK58oV+7GVMJybyIr29LfImK+fsQD2rpxdfZa1YzMyQSEjenngQ7N9/nWjLUkcpRHFjZxvRgiXNWZsg6VTKNuDeqfp3Pr9HgKrC4YhKHka90FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773336884; c=relaxed/relaxed;
	bh=6VUvKEuMH6XgmgIwpYMuS7ts2U+KIWWOz4DEP6SLJsk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M7JVZG8L4+CQ9fXChMY78gOY7b8fz2TLddeq49zikVpfJzOdiaQdkQZbjKT+Kxmp1FBI2+eXBuL9WOlvjLpMFzbJFM3A0joJdmJJZHo204wVFPdGDnBMdGdKj2jtpdxz1Clccz7aaEsBDIqaWAS5paOgNtHQnHlP8wP1oKDp2ta4PVyswrPvk7PH219Yvhum9NoKwHFlM+vtoEHClZWMZfjxcQ4UfHYL19KwHPQAclyjzANtc9ueEAvv1kJebxlmv05AUSMT4/UlIOIEjjxHgnSiHco4kEKvwL7iiiaDlS7lbwGgLeE4C4erUPRU7akSUXVQQ4c+6U5g63xQlNGNzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNVL1ATb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oNVL1ATb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWvrM17zQz3cGc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 04:34:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1F91060054;
	Thu, 12 Mar 2026 17:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A52C116C6;
	Thu, 12 Mar 2026 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336879;
	bh=z6Fq0etMM8i2YpRnzMdU0704l0z3mVS1tUc4Te05Uug=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=oNVL1ATbmTIdlOOGC0UgD1s6/IC+H09jQHpw/gsAInCpnp/fVVlo2LFrxAEKaIGha
	 cjPO58Vcqe3ke5xaarbpsvlKQsto3MS3Xilbnr7+jd8/x2PCAlmfe+P/FwQFFRstLJ
	 cEw22itZRzTJyXSXA76N/CYYvT/zJWO17f13nRqJj2gfHW0LTTdOObdG1fjqMzc15T
	 qvq8lAeH8Vzp1oGGgtoyJvJVmvDegcS4bR/bRsUP7tARNvptOTRYNvPCTRv+0zAZ5C
	 csJK5q2YTNlqRtYY7XAIB+IZfk7P5iWRVKDFoJV/KQaCpoQJxqJzX+9DYCouNsBtmd
	 V/VHjFBdJvS6Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260212072229.3247604-1-shengjiu.wang@nxp.com>
References: <20260212072229.3247604-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] ASoC: fsl: add bitcount and timestamp controls
Message-Id: <177333687761.302961.14700206340087655757.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 17:34:37 +0000
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
X-Mailer: b4 0.15-dev-68380

On Thu, 12 Feb 2026 15:22:27 +0800, Shengjiu Wang wrote:
> The SAI and XCVR have the timestamp counters and bit counters, which can
> be used by software to track the progress of the transmitter and receiver.
> They can also be used to calculate the relative frequency of the bit clock
> against the bus interface clock.
> 
> Changes in v2:
> - remove arrays of enums, define transmit_tstmp_enum and receive_tstmp_enum
>   separately.
> - remove __bf_shf(), define the XXX_SHIFT macros.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_sai: add bitcount and timestamp controls
      commit: 8e27987a208029c39da7a787bd9f1217d42011a5
[2/2] ASoC: fsl_xcvr: add bitcount and timestamp controls
      commit: 7b3f8db159f710d432c4edc024fcefa9e62e8b4b

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


