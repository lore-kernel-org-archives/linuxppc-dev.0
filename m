Return-Path: <linuxppc-dev+bounces-28745-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12BCCA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 10:57:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx5NC3F4Fz2xSV;
	Fri, 02 Oct 2026 20:57:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790938667;
	cv=none; b=Eg/AFTQ2CtFjbhDxExh+pzu9RbZgRyok3u320sEYDBSGYW3O6rWfHN2nEm88E0PHOp+Ol3MsUBhA0r+HszkBWrM5KRLhnb0VC3n5hg3qXc+cdv5TDmAA5Kwhfanc2SH7efJ0AtpPtbxq0NFRHdh5dgDEz84Y+4FiOTh3qhr6FC0QQxaqsVu9mrIOyuqfR5JZ7Xnrb5ByiAOgolJ8iPihasnIg9cyj8LekwNBZ6RcFA98MQ6Fgmjh55XFUqN7fLwgNhzfFBPc249sR9XsOtkt/Z42uqpbw1hWH/+fpcfCDMWPINuyMtDi5M3PhXH67U4P3d6nVlo2//XQUxnDjnU1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790938667; c=relaxed/relaxed;
	bh=XhYZeDORiSI8/JK5prOnI48AZTeR83aeNlRw2yNVr5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBrsRnIvI+XGxvNzRrJBmnQJG6uMqqphDUOd5y4tcsDJXFHW7QvfTxmDy0GVJS7JbDVzGg//mRuzIWia/3tQn6eO+HlTprfKsW3W6LW5aSDytFsouc78uqbN39D/2HQCr9ikQkHhQqOplBnFmTAa7RdTyuHEbix4lWBpiCl5V36L7MK28RyvWwzxn+f8JHnMYI73XlTvQUQrzUUQ3L32ionp5y//BA5YLR03t0kfYWK7QUjlUHr2Szlp0SeT/ZyX1Rt80ddYhpb9QmL3KdEWS54kck3vKGNhV0TFl31WvXwGZSbwbi13lcIjBEeSa4MmJ5cvIZt6QOr0EWx9gheN4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWofcNL0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWofcNL0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx5NB43ttz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 20:57:46 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B0FA43E34;
	Fri,  2 Oct 2026 10:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC801F000FF;
	Fri,  2 Oct 2026 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938663;
	bh=XhYZeDORiSI8/JK5prOnI48AZTeR83aeNlRw2yNVr5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aWofcNL0IpfhNz1F+V5tIezxAIC+6gSsXgAkREeV4BVed+0FiauQXMNWVw9LKPLB6
	 ir4DE+mQOj7fAnn9wWN24mGIs2yiLoWuxDgSoIcePHXYebp3Jn+1nUa9x2wySQefzf
	 WQmIi/OFo2WoqQKAzGhoPoMrrzBB5bUlFah8eMf2FJVRJ6H6P9gC/qpBZuRnPjv0y/
	 F5TtGt5oyxTCxCgpw9JS+D+Ugcg53pdmW58E1qfTVRE4UNxCd1Jv8/fulyxe9xvM3n
	 QuSyWTZZF/fLNAxS4cWJJyIBxQRSN/S3tMrqSUHZbQdB27JrxaRUMLy+tg6NqQf98F
	 +C8Ubag62FOcA==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Christophe Leroy <chleroy@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
Date: Fri,  2 Oct 2026 12:57:06 +0200
Message-ID: <179093852073.149722.832232613857480812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=chleroy@kernel.org; h=from:subject:message-id; bh=cZWyz0y5XGYe9zKs9PNHSxiUlxW65egvfT4xEgdntpI=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTt7+OJ/rvq89WD/OHOTgfiuFYb3eV9siQjX6ZB4uV8W fGZTfsNOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBElsQyMkw/0pmesd3U1s2/ +cCt35+i1GxcP3PlXZzn80qx+rxOmQLD/5gj9bZ29RUatWfD9vbt1+NKmTHbS7kya1+avMNCTlt NfgA=
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit


On Fri, 25 Sep 2026 22:46:32 +0100, Nathan Chancellor wrote:
> After a recent change in LLVM [1], builds with the random vDSO
> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
> 
>   arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>   arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
> 
> memset() is now generated when zeroing params->reserved for some builds
> because LLVM has an optimization (now run in more instances) that can
> recognize at compile time when it is assigning a static value to a
> contiguous area of memory and turn that into a call to memset(). Both
> clang and GCC assume memset() is always available [2].
> 
> [...]

Applied, thanks!

[1/1] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
      (no commit info)

Best regards,
-- 
Christophe Leroy (CS GROUP) <chleroy@kernel.org>

