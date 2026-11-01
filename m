Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE36072158
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCRw8XNL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHq1v0mhMz2yTH;
	Mon, 02 Nov 2026 09:16:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793571411;
	cv=none; b=TrSNyWtqeOrNzYYjplMpjZeWy9UBrrk6Y3UIqeyC42MwmHIgdYs7ZXj0KVxIjdTOiy4fCZcDfA/kJZ4P/TvrHmN4P48WpRgL7LQhj4G71Y0gSzEBraPK7luxskReJPgftWI/z3PSSufoPjTmKHAx8ocb0yW82UbNNjHY1uk/zuNRWpkZ0PZiT22926qOqij114gc5JW0t8lZBQw5h+6//OSPqNuVE2rcK1dhJPZ6mJlT9OknBc667y0fbua31WNd2zfgYQwHNXyyOQ6kjjXpdhobt7QrsfGRFM701vPdy0I2rxa0yLgalJpwCwJu/qxyDhBuKWnglWSDTDLbkhw82g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793571411; c=relaxed/relaxed;
	bh=9SjWrhc7XGpfrZLDGv5e/UGJ5LKzUlRr1ymU5F3rbK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SjOVrucBC0wRJGdj0jLJRnEHAfW2+KYY99eo/eOvGZIWPEWNeoOzJ35NgqXlYTNna44uAiNn3iSKhqE+CHUIGp9NzYxTFXTHbrtnCXNCgAN37+MrO+L1pvHqkyTNkL3A6ZnVw2CwJe6Itt6A5gaZIrxPAZu/KQ4ZskH4hJZ2uu5tSwJEN1+1Cc1L2SKDxzZIb32IZeiPyCSc/C36+3gDKXlhHj1qlJi8hUew+Pjf8veB5EdS26oZT3on5pro/xCKbVMF8IlZ9NfVi4rWHop+Wn9OIZ4Z0mw+pLmtobopEIcd39ctaPYe17xWm3ZwyA+o0AkAM5s4EtvvBmBhNhoGhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCRw8XNL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCRw8XNL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHq1t3V1jz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 09:16:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32AD660618;
	Sun,  1 Nov 2026 22:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43571F00A1C;
	Sun,  1 Nov 2026 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571406;
	bh=9SjWrhc7XGpfrZLDGv5e/UGJ5LKzUlRr1ymU5F3rbK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PCRw8XNLxhwpgQY+VNJEgyemCH7WcIUexDDLxDQtKsJZyKUtdTMN3MNlZltJ6M0iy
	 0sNvBS5zOI3cOGvEHXCS4FDiiBRJt4YTWvt0Z5W2pEwwNWqyPsD/jW7sJeFMWEVfwu
	 32f/8TpLwxDIfiPxqr6f6Sc8JtU205KYvtKUxdXIsWKDgfMrSec039M8wUBLONKqKV
	 C8h60HgiPJV6UBIQ+RJCyhEArenvuts1IeS5Ti1EIWkF9gSpCYTJmdYsxaCB3+MhvH
	 cKC00fZeAT+3Xb1OaF1XeCb/NrEIVbK+ayJvZHgHKBP7c9ZLF51en7iMywKamnPnBz
	 Vky2U/YXxjHxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1E838003B8;
	Sun,  1 Nov 2026 22:16:46 +0000 (UTC)
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
Subject: Re: [PATCH v2] arch, mm: promote DEBUG_WX to CHECK_WX
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <179357140534.2624073.9989407542230376185.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:45 +0000
References: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
In-Reply-To: <20260926-direct-map-verify-wx-v2-1-efcd64a6b74a@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 aou@eecs.berkeley.edu, agordeev@linux.ibm.com, alex@ghiti.fr, bp@alien8.de,
 catalin.marinas@arm.com, chleroy@kernel.org, borntraeger@linux.ibm.com,
 dave.hansen@linux.intel.com, david@kernel.org, gerald.schaefer@linux.ibm.com,
 hca@linux.ibm.com, mingo@redhat.com, liam@infradead.org, ljs@kernel.org,
 maddy@linux.ibm.com, mark.rutland@arm.com, mpe@ellerman.id.au,
 mhocko@suse.com, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org,
 hpa@zytor.com, ritesh.list@gmail.com, linux@armlinux.org.uk,
 sshegde@linux.ibm.com, surenb@google.com, svens@linux.ibm.com,
 tglx@kernel.org, gor@linux.ibm.com, vbabka@kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Sat, 26 Sep 2026 12:29:29 +0300 you wrote:
> Verification that the kernel does not have writable + executable
> mappings is about detecting security risks rather than a pure debug
> feature.
> 
> Major distribution configurations enable it in their kernels as well as
> defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> 
> [...]

Here is the summary with links:
  - [v2] arch, mm: promote DEBUG_WX to CHECK_WX
    https://git.kernel.org/riscv/c/2e83e2ce34ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



