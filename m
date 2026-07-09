Return-Path: <linuxppc-dev+bounces-23979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3588DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 22:52:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx9Fh69L8z2xWY;
	Fri, 10 Jul 2026 08:52:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783637528;
	cv=none; b=mDME/hTOQidKHzmyN1w0TgrFiTVtPU/QzNyUPuJXEF10LswDhBQM4+2cT28XvFOmwiYgAiNdiahn8BKqZB7IOwOfCtbEOtXKMm2pwvd7PJEJKW1MeHBJ3Uh3A/K1N3Ii+FbTzC8rcojpX5lZZIvaGApZ0ZlwzHB2mL4/x4Nmrmsw76d171IAHWzb2QBdEr5fhkTEQ2t2zFCEwZmE5WbHC4zOOsN3v5m6N+HHLO6Pr0zuxFKOuckx2RUz8wT2rVxkQw3ptL3EZN2kzADiE0O7ONLmHWxdFavicQ7LnVtTFDGdaZZaD7lV00cK4fE4mUL6oW99Zuc+QkP6paBMQBtLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783637528; c=relaxed/relaxed;
	bh=Hw0YEWuasSELzyN3iJrE8ZYwT4ynNuVYIAHj0t2PlKA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GMxChOn46ne4zrDwILeADcCLh8A2/tOpvG0VzlCFpyn6h9KtG2/ksWDkFT24YjQfxJWVzRCzbLl60qLU5WeHKweiH+2BXlCUNq9vNsGe/xZMtqtJbeyJNoomFdsMxKEVS+cKAkmNnGKuO4CZ3bCFiPYRfJaM1TRKx4VWVhbIXFiSOsOzhK1J/O5uZHTXr1Aumz64TY2aGF8PRhbEBVhnttdRdgeYydWL5uzlnF7Tmj9QnJ/apWOUCgcZYpv74B40PDbn2s2OoiNcRCFkbGkbA1oGOs/zBudvbPCYhtYtcA7FTwyt+meaTibVnyV/Q4vWYoun750J3H5CGZwbP8bkXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=casgykTh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=casgykTh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx9Fg5QKFz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 08:52:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E09E443D8F;
	Thu,  9 Jul 2026 22:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791EE1F000E9;
	Thu,  9 Jul 2026 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637524;
	bh=Hw0YEWuasSELzyN3iJrE8ZYwT4ynNuVYIAHj0t2PlKA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=casgykThI4O4unGWnXTN9WG4KF/VKUV9GE6wYwIRge1Tt+l0NfI/WlVJnsZzjY+Dn
	 FPytoxw9GkCKjWGqUuHcEuDMu38yUmPcrSFXSAYAG08vHsPut/iQvlgqLzQeRpqunK
	 SlYYhv7OobZIYv4bhXb/mK9KVFa9Ff/2fMi9UEXHWUSzBlq1xGLr0LpXT5uqy5Ap73
	 WyILKIFInr0hVE29AWhzb1PjGfL0WBJmPtIctAzxitq98MJ/5Cg/lHePzfoxYtyZtI
	 sCf+/tG8zIvS8yNKLqRZ0VImJ4H+4D7g0gp0P2dE6i/524P30v40jS/HNxRPNe2Akd
	 twoEoZCkL4JWA==
Content-Type: multipart/mixed; boundary="===============2104876237906351994=="
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
Message-Id: <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org,gregkh@linuxfoundation.org,sashal@kernel.org
Cc: bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,loongarch@lists.linux.dev,linuxppc-dev@lists.ozlabs.org,linux-riscv@lists.infradead.org,x86@kernel.org,ast@kernel.org,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Jul 2026 22:52:04 +0000 (UTC)

--===============2104876237906351994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.
> The BPF JIT allocator packs many small programs into larger executable
> allocations and reuses space within those allocations as programs are
> loaded and freed. When fresh code is written into space that a previous
> program occupied, an indirect jump into the new program can reuse a branch
> prediction left behind by the old one.
> Flush the indirect branch predictors before reusing JIT memory so that
> indirect jumps into a newly written program don't reuse predictions from an
> old program that occupied the same space.
> Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
> static call for flushing the branch predictors on JIT memory reuse.
> Architectures that need a flush, can update it to a predictor flush
> function. By default, its a NOP and does not emit any CALL.
> Allocations larger than a pack are not covered by this flush. That is safe
> because cBPF programs (the unprivileged attack surface) are bounded well
> below a pack size. Issue a warning if this assumption is ever violated
> while the flush is active.
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

The reuse path this patch hardens (bpf_prog_pack_alloc() finding a free
area within a pack, and the size > BPF_PROG_PACK_SIZE branch) comes from
the pack allocator that first packed many programs into shared executable
allocations and reused freed space within a pack.

Should this carry a Fixes: tag pointing at that commit?

  Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29054648899
--===============2104876237906351994==--

