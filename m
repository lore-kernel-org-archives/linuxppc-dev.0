Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5E6075744
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlnlOoUU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHq2J0fb7z30WT;
	Mon, 02 Nov 2026 09:17:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793571432;
	cv=none; b=RhxSptyJYXnGmyz+1SNcx6DjrIWeIm8XSWbAFn31RXA67ZziqO23bd8b2qjbuir3OrfSdiFgOkOsgeBRIWsNVxMqhFHzEdOeDm3cmOUWmMkXnIgXPAjl5LLf0HQJcFjiRvV8aTgK8K+U7Z1yvPJUlzQSJ/4+TgP87XajfjlbK9+2qIqf86wg/e12nGJ8dj2V55IllbrVxy3k2sLsYNre5ri5jzgy8wJlpFuwtCoDdOK6D8+g4uSCiukVjsulK/m9QWUl//MaEfGW2acbLgayig8oRaDYXJ1rd4cgMx3hlA6iP+EffEN2YiXMKPsMtocJfba0CrGwB3TgsSDgCtaJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793571432; c=relaxed/relaxed;
	bh=Fv8sMlP8O3GHUSoY8MBfh8MY+kr37FDNK89rZQzSXdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPHDCCLV8eh0og7/t6wEV3LumR3xvxfqJ7egZ/Cz4527xettxCmmV/oWToZg2TENeu9dGpAWK+KEAd4yxFkDdHLe7soDZ8gfUrkEi81OInOwshbA1oDgwxPm7DEbr+pm1LPL4l56TNUvBY5GNGuex0zj9BuFV96SlK4u3akA4d7jJ2LhtOw58yWc+R91d9WMOPwJgkmtcuGAhqAgb+gsJA3XoL9uvDegZeecYuGuBrBeWLpWnw6KA71rf10y7mTyAR4MBkwzvESClcf/dtts7Bq153fOrr2JVZ2aLu0+FCUQ07f+N2WleFFBtGvtOoVyaGmr76YEbpQu/ojVasWNBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlnlOoUU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlnlOoUU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHq2H3vBSz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 09:17:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3C8F400B8;
	Sun,  1 Nov 2026 22:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A0F1F00A15;
	Sun,  1 Nov 2026 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571429;
	bh=Fv8sMlP8O3GHUSoY8MBfh8MY+kr37FDNK89rZQzSXdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VlnlOoUUEu9V0plLi4Kke52P9Sf7LmnCXI3/r9nD/EkLF8dgcbn/b70x7s8xOpjzM
	 vBDpICruAngiVNvxs7IVSzf2GH3D+B5AcFg6C/1RMLmTfGWgGqs0LmJd92jQOeIJaF
	 wsK9MssC5+2tsvQklkL07S8F2Zzqk3PTJHN1zfusMqgsbvhB+jUERHRUHHZskloFPo
	 yl/WabE6HiCKHMwoMCYwf1B+T0vXDZWAeuYQt311a5PVRX3ugUcvRN0wyZzbvYibPV
	 2TlmBTOm6MSHm2nJI9gJKa3Redvt//yKNi/XBo/uFCvCdVwIZi6hXO14jaV0sdhUS0
	 kunSJJwhwyeCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA5B438003B8;
	Sun,  1 Nov 2026 22:17:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] lib/crypto: Use size_t lengths for Poly1305 and
 ChaCha
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357142829.2624073.2124484665042168888.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:17:08 +0000
References: <20261014152604.323310-1-ebiggers@kernel.org>
In-Reply-To: <20261014152604.323310-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-crypto@vger.kernel.org,
 ardb@kernel.org, Jason@zx2c4.com, herbert@gondor.apana.org.au,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 vladimir@genproof.com
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to riscv/linux.git (fixes)
by Eric Biggers <ebiggers@kernel.org>:

On Wed, 14 Oct 2026 17:26:02 +0200 you wrote:
> This series upgrades the Poly1305 and ChaCha functions to use size_t
> lengths, matching the rest of the crypto library.
> 
> It also fixes the (not currently reached) handling of lengths above
> S32_MAX bytes, and (not currently known to matter in practice) the
> assembly functions depending on unspecified high register bits.
> 
> [...]

Here is the summary with links:
  - [1/2] lib/crypto: poly1305: Use size_t length
    https://git.kernel.org/riscv/c/0b58c136c2f9
  - [2/2] lib/crypto: chacha: Use size_t length
    https://git.kernel.org/riscv/c/e42003dba6dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



