Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D22606ECC2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHq1b2F8pz2yMP;
	Mon, 02 Nov 2026 09:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793571395;
	cv=none; b=lek7QfAb7MXyU86IlsRRGfbD1d+ucoUJjOZSYOrtG6VgroUW4xF7/MjYrwh4+rGSTnKHGkpxkamFgXG77x3c1bCO/bjJm9LzdnvWEtlLtGDzwH4dJXDKWddES8+h7OumrZMERfRbC0wz4XFpuH2GlMlI0uv1HCdRSy1bc+zIfahTKprMWdg8ALCCjNAmBUFL73UrQRODfJDP8cWc8q0mYH0VPF71KFZ68uefUOR1+pPhKO3So9VNWjjS2la82K2v1iGMq3QLnjNrx/ss1tKfbfqEvHZoxch26OIzwK8QM6l8ipe8uQHag09I7BVodYl/87N5Tdkc+BPg3tjE5jpD6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793571395; c=relaxed/relaxed;
	bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nES6ideRe5zHzxF6tTmrA1j+yw40RdXRO5mgEQEYg5Sq85KogwhFzK4UsWo0JeoZIt/srRzgl6AH2n5ThYVhpWmS5tpv01oNctIy5cCWNqeVuiI+uakhDSa/vzuQMSlkQ/d0NVmxK8LAhyOeiXCfl+68HHM7kjgr7AbjcVUqd3dgl2WuhX9L8sqB2zsTmAxow7kY3UD+ZRJsnadCodwrVsDJKJTlmjnIMIdRK1PaKvKCbcY9FS/Kfm3Sfa3u+9hzDTalBNRUIZJKDyojcQ4VyOCNzTgjZa1Tulu6X0R0tO9GFRyk2rwyNWuJYNA9Dbn9ZaylfL1Eiba/wRT2JdXV6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RI6vqfud;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHq1Z4qnCz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 09:16:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7FC2441815;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4D81F000C1;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571392;
	bh=7jMaG7E0faIciRuA0j8698KDnNXPdfgqG5SZCjrpwFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RI6vqfudUDAPQJyogDLl2CpARmQSYi02Z/r+Di8qbeK3KcSdM0cWSldHGeHFd7Wmg
	 oZkcWTzbyfmhEOg5tcfCHfhpf6iaGm+isSH86qaujprBW88A0OM503IaD8+WPv9717
	 bpcrsoSfdrv6EFgcaHxAfgeqBVd+9Lh2jlei+lTKhKmrMmF1DDRxKwuNJ2YAzniH64
	 bTK3lBMxJ6uc9UCiWTe96qjtjhpAxsSnnRxROmumhMt3+M7z/8Bl4vxi21IO/fXVoH
	 wUHNq2epY1lAcTmYzulW8paMq9f4RX7rYBp2SAoAq4o7yj3fGB1UzuSY/Wrq1aK7S0
	 zpB9EvUeVfZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5347838003B8;
	Sun,  1 Nov 2026 22:16:32 +0000 (UTC)
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
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357139104.2624073.10186400247460209292.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:31 +0000
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 samuel.holland@sifive.com, david@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, ljs@kernel.org, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de,
 James.Bottomley@HansenPartnership.com, deller@gmx.de, chenhuacai@kernel.org,
 kernel@xen0n.name, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 31 Aug 2026 11:13:22 +0530 you wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Here is the summary with links:
  - [1/8] mm: Make ptval_to_str() generally available
    (no matching commit)
  - [2/8] mm: Stop using pxd_ERROR()
    https://git.kernel.org/riscv/c/0666fc9d4432
  - [3/8] loongarch/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/ea8763ac3af7
  - [4/8] parisc/mm: Directly use generic [pmd|pgd]_clear_bad()
    https://git.kernel.org/riscv/c/94d6c5466d1a
  - [5/8] sh/mm: Stop using pte_ERROR()
    https://git.kernel.org/riscv/c/6858e42cc2bc
  - [6/8] sh/mm: Stop using [p4d|pud|pmd]_ERROR()
    https://git.kernel.org/riscv/c/3b225ce37f62
  - [7/8] sh/mm: Stop using pgd_ERROR()
    https://git.kernel.org/riscv/c/66a0441a1791
  - [8/8] mm: Drop pxd_ERROR()
    https://git.kernel.org/riscv/c/c970236c300f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



