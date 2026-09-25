Return-Path: <linuxppc-dev+bounces-28228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A57C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:48:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs08V1PVSz2yfD;
	Sat, 26 Sep 2026 04:48:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790362106;
	cv=none; b=he1RlTwe0gzwzU9XdNwB5OE7QTzHc5dlU7z3CnZ5mizpOQez4bv7sZPVqqE4r3gUMTcQZJb+EKHqJ7PdFRyuCLNEDPl+CSjwIUxiPXH8VEIwkZL+E2JAq+Nu3CsxdqHnh8bPjQYs76InJuE3eIsc15VKUuDV/QDye3MqA0qztCU9zsO2vyMLurWOWa+kGP2hjrv+N0FQ4go/BYDXvushWEmNKvxTvx/oah9HWiQh8qAtNak5ed3V+lnTumjKQiTVdFlBxajH3YRmfa0b3uex7RZm64bDFz21h5pc7Y53z3Vsxe6GX/kIbQ3RI8t0QDP6xwI8Qc8IIH0/rLAZ9habkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790362106; c=relaxed/relaxed;
	bh=jSFmNDAKnyRYZoFiFIKsqK4yVtBdCrope6nwABw46j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYiOO7yGyIiwi4zb9gwKBIDMZAeZQloULJmaOeCFIFnq2sVRGpw/m8DUybIw8/zuNA8PKwN+neon6v4UD/yK2YyRpVCIlfZvoqhM7DN6sBjlBTvURXUdvyQ9LnlvlaWaRK/Rpctm3f4Q7YtoFRXMV9HPO7NWwFlOqiiSp75NGUz1zjbnRuLqlOKxhL07U5qgyvzruywA2VO+6N+4hWTbh6Fq370n/ql9stftf/MaVChAud0Wl6+5lRDoBcnm3RF1aUwHjF9XEw7EnoC0xoRONEA0pCStQlOvn2GSHzhJ6ydlYLGPJB1FRjYjPRNDytamO10T0fIVUJiIo5rmhl5FSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0PaOEiL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0PaOEiL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs08T3CDTz2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:48:25 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 364AF60252;
	Fri, 25 Sep 2026 18:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588761F00899;
	Fri, 25 Sep 2026 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362101;
	bh=jSFmNDAKnyRYZoFiFIKsqK4yVtBdCrope6nwABw46j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0PaOEiLjrcw4IPSayxwfHwLMQzk6up584New0jFING0SRgov27OrOUsCidr6qelS
	 QvK3rjVmaIZM93MgD7aYtnpmk5gVM6prMeL8O+nC2cOQ9sWJvhfjTBIHDWuoPHsDcU
	 R9gKHF3ULbl5tvoFBS3ZlmsR0DMQrfdNlAWQaXhDTG4PyDzZk0h+DtjyVLgoqgegXO
	 2ugttiGkIR8l+vwIdXZkLE/uPFR1ebat4U6NOA1Q98zq3xChOxCm5AOftQrJds2Yt3
	 97lONXsyQSXz8NCWfWpdpdeg1xPWJrD8ZEdKLUMEPSGW+2zG9wMe+m1xaVKH7R5LvJ
	 OezDZNbedvpdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Tom Rix <trix@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 6.1.y] start_kernel: Add __no_stack_protector function attribute
Date: Fri, 25 Sep 2026 14:47:58 -0400
Message-ID: <2026-09-25-daily-reply-0006-re-start-kernel-no-stack-protector-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924173100.87358-1-artem@trailofbits.com>
References: <20260924173100.87358-1-artem@trailofbits.com>
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
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: retain this tree's start_kernel() signature, which
>   predates its upstream __noreturn annotation, and add
>   __no_stack_protector. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

