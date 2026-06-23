Return-Path: <linuxppc-dev+bounces-22946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E5FCDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 20:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glGMN2WgVz2ydn;
	Wed, 24 Jun 2026 06:07:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782245264;
	cv=none; b=jGbJKaqTtu+Uh/BGOzQXlDeMhYqiT/I6FD8rRMUPXE0ZsT3n6aG2/CEzz458Bc+VZTfkjEhZwd7+nPGvfmHozaTUMQrfKf1t+vfUeTSOiIU85ec4atxsM1DYIGORfuCGBXpmEidY/6QMcXE60F5ldnBFbfhGe8rmb4UXGbHw/hrG+iY4nnaGeJyixZZo3TFT7hTTfZakab3sX+wggMTzeL1k55j3Xk2uELIyjTvTXCoAb/6dEhN/O7oQIcwmzJLzF9FcV+UTQSuer6G/rOe5HVMUSgSLGbKXtBXbKK4mtvITcNeE3jMDv4IAglPStbRwI5kKzX40/U+FuIUMScvTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782245264; c=relaxed/relaxed;
	bh=XWHa62l/YiCsFLEmqWnO1R3ebE4heGP/6x4UVAPjgds=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bOR2ZT4ESpZZ7mV5BxU5wfJ2ihbGRpW+gEhm2UFrCrvaEJrNCXg9VIrMybm/kJgSe5e0wZW2t3R9ooM66MKNoVsUhIulZ24P+nPFnONwN1w9ZM1DLMvdF6v1rVio9krBYeM89op/Ymw0J4pd6TnyZ2Q5TJS3wsf9C4BNCr9UjweeWLVaBFuAs9Pca9LayFAboSjxlGRTU0M50ljrgXgEfCYbkmnhhkoT2RUkoIKUV5mI3RUTeiblSVpE3/LNMWIrbEJG85fzT+HpvoWMhzmuYsibdL78HczlrT9MMaEOez+blX50AbGdIUoW5o/HqcZHk6OocNEUKoAt/KZGRmJtpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAaQXCqe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAaQXCqe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glGMM4MwSz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 06:07:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D924B60008;
	Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B021F000E9;
	Tue, 23 Jun 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245260;
	bh=XWHa62l/YiCsFLEmqWnO1R3ebE4heGP/6x4UVAPjgds=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BAaQXCqe+0gOROgwKims9hjNuTtcOYeu7FT7Os3GgzLHUg+O75W1gGIM6rgN6ZHTA
	 rs7wYg61r+qBb9cJMUdf2sg/BHAqlrJ0tXJu/cXWEWLpPUIv8+PaUIu67FgF3tkCGR
	 dCKHvlSCcgfmYTUrGNb79dvBY9DHXz2D55Az3HtK5r/xSpq717G/3mMUgk2BvENkjt
	 i/XgGfhw8RJH5awZgoy59w7Z/M/uNzGyDzjwyPrSL7zFMl6luNvIb5+OsnJMEK+bD2
	 AIGSxcqpIDPt76p9fLNwRxYPhgc4gQoNOJVHuBU3lK7YKTWqkFcqQsgHeXQEpneyl4
	 ZBnElVhS0Rwzg==
Content-Type: multipart/mixed; boundary="===============0809908519728760187=="
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
Message-Id: <aaba19274fbd51ba6014af6f1a9928eb202775b6278c2fbac3d0be9f26863d01@mail.kernel.org>
In-Reply-To: <20260623231411.6216-3-adubey@linux.ibm.com>
References: <20260623231411.6216-3-adubey@linux.ibm.com>
Subject: Re: [PATCH bpf v9 2/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 20:07:40 +0000 (UTC)

--===============0809908519728760187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Move the long branch address field to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. The last bytes exclusion is logically necessary to
> prevent disassembly failure, otherwise the actual program layout
> is never altered. Hence no effect on overall program size.
> Also, align dummy_tramp_addr field with 8-byte boundary.

The commit message describes fixing a disassembly issue and updating
offset calculations for bpf_arch_text_poke(). The change modifies how
dummy_tramp_addr is positioned and how its offset is calculated.

Looking at the diff, the offset calculation in bpf_arch_text_poke()
changes from:

> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */

This corrects a calculation that was introduced when long branch stubs
were added. The original implementation placed dummy_tramp_addr at the
top of the stub and calculated its location using the stub size. This
commit moves it to the bottom and simplifies the calculation.

Should this include a Fixes tag for the commit that introduced the
original placement and offset calculation?

  Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28051760380
--===============0809908519728760187==--

