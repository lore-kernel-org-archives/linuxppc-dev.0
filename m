Return-Path: <linuxppc-dev+bounces-17186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF41FCEE81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 11:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLX400MpDz3dW6;
	Wed, 25 Feb 2026 22:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772017935;
	cv=none; b=WydFxdsJHpFK2cQSg/0lq/89sQpUSC3e8cZ5bT5orciDHEDH5kfr7rCpZb5Gj03+ZtmsI4wk21DIrZg2lE3D94n0zBC/27JZv/icAWNrCDeXlyTDaq4mRHb6jUN/EGKCC7vp01xaza8wxF9JmhA2GoKvBR9WgzVAPceq/QxMkqBLYUmD5YmjOEvuLGOdguKj50isLRD+p9cL5dZw21A2Im6on7GAuWTD0DmO//SRJErgB77Z4ZoojIfXFoN8qUMOs6numCXkyd5Vn9p+0S+4HTuJubEnIz9Kyf2ijF07RvATyAkB+uCbjIDpl9/ajYhZM2ceYocb7c7nqejMtrenyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772017935; c=relaxed/relaxed;
	bh=7qaBUEw90Sa6zxnPTfDgoCJaiVASDo8vq0mnkIynwQU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JksJ6NJ1prtdArUOcCUVTQ9E6zNsD7orw76pC0dvfUWU3siIhVjHJISXGB1t6TVrsUf40fzKxeQ/VNJIKgUgh9RVkF9dI4X40rz2QrU638E53SDKZKtwdOPo86rN+5X39AdMsXRBoedMS5bGoVvi83nXHVC9Ipm+0/POiLZfnoUb/W4qDLGc0X8/33Wb7cRLAVJ3sFluY09LTsj4zpOaeuwICMcQTVcmmVMQZr+djc6oO+mf/SiBtBo36Tb0FbutdVhTWX4fLIg+lIXvOyFYX6ykIeNr7KGL+x5FGRP1EkMbpsgjrh5KdAxRrP37Fi1uGwD5cWaxvK1yIBZkpEzdoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RK6SAmZX; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RK6SAmZX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLX3y4FYYz3dLM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 22:12:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 69AE460053;
	Wed, 25 Feb 2026 11:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016EBC116D0;
	Wed, 25 Feb 2026 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772017931;
	bh=euv0b1jOYXmox0xMfxa8d34uU4tYwxcEjUzRv5RY1lM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RK6SAmZXI79+Yt1NFJ3rv3BhrnDrpdbVVJ4edONcjJ1B+KIrPbbXRFzbVTNCBOElN
	 us5NL4WrigLTzuc8zOMv/ejciOlR2uGxv0AXzX0BGQne3wtRIoSEB2S6d+pnr6vMDq
	 G+B+CCejF7vN7dbLGQFgDL7wJh45HEoQWMQ8stdDaarOenW8BtGJffyv9hxJZ2hBZC
	 zYc1xgtNvRldltjvkaSp1UaICv2dEBLMw2XperskQE17RuxsP0fPgOsZwI84MZxXTX
	 yueNVe9hTOq9lf9BUPwTJfICRkk3vGec9/Tghuee8A0aoH7LlCbcB7y3mmwCt5XPNA
	 gOMpLxglQ2uOg==
Content-Type: multipart/mixed; boundary="===============6469514507980447881=="
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
Message-Id: <05836ab33e1d18dd049c73ae561f9348a3ec5a24dd9de56c72ebab6db14dcc60@mail.kernel.org>
In-Reply-To: <20260225153950.15331-2-adubey@linux.ibm.com>
References: <20260225153950.15331-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Enable private stack tests for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,hbathini@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,maddy@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 11:12:09 +0000 (UTC)

--===============6469514507980447881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,7 +7,8 @@
>
>  char _license[] SEC("license") = "GPL";
>
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)

As Christophe Leroy noted in the v1 review, __TARGET_ARCH_powerpc
matches both powerpc32 and powerpc64.

bpf_jit_supports_private_stack() in bpf_jit_comp.c returns
IS_ENABLED(CONFIG_PPC64), so private stack is only available on
powerpc64. On powerpc32 skip would be false, the tests would
attempt to load programs with combined stack depths exceeding
512 bytes, and the verifier would reject them.

Was this intended to be addressed in a follow-up, or should the
guard be narrowed to powerpc64 only?

https://lore.kernel.org/bpf/1956c912-c880-4214-9bc3-e205902459b5@kernel.org/

> [ ... ]

The same change appears in struct_ops_private_stack_fail.c and
struct_ops_private_stack_recur.c with the same concern.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22393518231

AI-authorship-score: low
AI-authorship-explanation: Straightforward mechanical change with copy-pasted test output, typical of a human developer enabling tests for a newly supported architecture.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed review comment from the PowerPC BPF JIT co-maintainer about __TARGET_ARCH_powerpc matching both PPC32 and PPC64, causing test failures on powerpc32 where private stack is not supported.

--===============6469514507980447881==--

