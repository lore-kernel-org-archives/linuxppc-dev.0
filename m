Return-Path: <linuxppc-dev+bounces-25954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A121C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 05:32:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPJHb4dNRz2yRP;
	Tue, 18 Aug 2026 15:32:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787031147;
	cv=none; b=UfNePOj828pX14kTILZWgzXn12CFBnVeUWwtBMj47xiaPS2O/L/VwFzj5JkWX42GKjmoNOtNHgv9gxQAQNOmN5aHI5tIkUzs8XKNeISpjewT+Pp0iI11Zz34HMrjYgb0BzzjIoCT2TF4WsJo+e4AeEr5zLevqePnnC91JXdcSQaxaYP2D3iC2t81c8n8s/fgPKsgAk4F9qxqnT/4OiEtc6Ogs4EbpS5sCXeUtVyO4z6LAqe+XPCW1obx8rBHa4DurpkY84wkP6j5H7jKr+rDBKh5qMqEpIKhgmoLtXZbxjSh63EhE7KUtvp1ROUx64FXwQricJEWP1HQksp1RRR+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787031147; c=relaxed/relaxed;
	bh=xqEOC9o82H8i32IOhPuRcujpGfAhiDk5sbY8kZHNVEQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mMO64B22LCkPSHry7SOQZtt9aQgnYzBBhM5BDMBp7Cc0MwbRZeaXQfr5YuXHB2FXIshQ9JMMoH1AIEHzxiF4SMfMTYczsCu0pbtbVCkkA+iVaPPfKbgA4NWDmxx0vf5C9kJmiodA8KjAoCEMzreEQAiMVFOnUjk2aouS/8jlmjpCmrX8g/haj4BtBUpc0cNtyyqgXaVw/TCmQ2KFQCPtabzknB8X5IoZFhalsC2V/NdSkGn81NO3/eNqX/56fqn8FVbpyk5XIawYJ4cqlOFF14RRpB4D13EGaqZlHX5amJ9YAJmeXGGMOjM0cfhHxNbOuDPfhf/Sd6iiaPedamUmCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X17YOm3X; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X17YOm3X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPJHZ6pz7z2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 15:32:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CB43601FB;
	Tue, 18 Aug 2026 05:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C471F00A3A;
	Tue, 18 Aug 2026 05:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787031143;
	bh=xqEOC9o82H8i32IOhPuRcujpGfAhiDk5sbY8kZHNVEQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X17YOm3X4GeYsL9scES2J/xoQ709g+sMgwM+Rs/Lt0u7YmBgn0hMUS+A07eLxFpKF
	 5ZnEliZllubPHeJb7eK7HjwE4j6n8GZ9X3xAa2K2doqANan3oidPLjyU3js1medE81
	 O7OzDqoZvJhKh9EqRWPhHKpLkxRqWIpXoCiMqdSS5aHLHENmNDH5lVc3UWKA5omHB2
	 eAlhChtMBdJMkG5iY3AkURDuZ8NVsuxo0ZzMkmrXZ7DK6gO1uPHum/rC9uElhwt4wn
	 efDy4LiGf5CnDQ/wIbBK8b38tQqfY6GOJrSfYegllhnbYlYcgDeoH/9QTG3hJoL6cy
	 jt+ykvy7qoK1w==
Content-Type: multipart/mixed; boundary="===============4478420559103731716=="
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
Message-Id: <887e651f0de24f2955f533b85551294f9aabd54934cd398ef70c3decf43b2a48@mail.kernel.org>
In-Reply-To: <cbbffb007454434ad67a7a09cfe26bd68e1edb5c.1787027080.git.skb99@linux.ibm.com>
References: <cbbffb007454434ad67a7a09cfe26bd68e1edb5c.1787027080.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v12 3/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 05:32:22 +0000 (UTC)

--===============4478420559103731716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")

Does this patch fix a bug in d243b62b7bd3?

The commit message describes the change as moving the dummy_tramp_addr
literal from the top of the long branch stub to the bottom so a
disassembler can walk through the stub instructions without hitting
embedded data. The message states "the actual program layout is never
altered. Hence no effect on overall program size."

The 8-byte alignment invariant the changelog mentions was already
established by the immediately preceding commit in the series, 206e0a244d70
("powerpc/bpf: fix alignment of long branch trampoline address"), which
carries the same Fixes: tag plus Cc: stable. Before this patch the check
already ensured alignment:

    ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
    if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
            EMIT(PPC_RAW_NOP());

where 16 is 4 OOL-stub instructions and 12 is 3, with the .long
immediately following them. This patch re-derives the same constant for the
new position (44/40) but does not repair a misalignment.

Keeping the Fixes: tag will feed this patch to AUTOSEL and stable even
though it appears to be a readability improvement that textually depends on
206e0a244d70 (the reworked comment and constant hunks will not apply
cleanly without it). The absence of Cc: stable here - present on both
predecessor commits in the series - suggests this patch was not intended
for backport either.

Should the Fixes: tag be dropped, or does it repair a specific observable
failure beyond the disassembler presentation described in the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32100929603
--===============4478420559103731716==--

