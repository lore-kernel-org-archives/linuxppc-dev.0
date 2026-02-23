Return-Path: <linuxppc-dev+bounces-17041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1418EA4FAE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 11:11:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKJ8R39SGz2yDk;
	Mon, 23 Feb 2026 22:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845111;
	cv=none; b=KmiZl3Z6WMnKKhlkFXZMhjPwH6S6xUO26Ba8ULDfW810CEL0wktAZ6Hj0eE9lHvK/8gfiuRSDdX5TnIpqRkGEcpWUszHgdOxrBUi9oC5Sqe4bCqDPUG6c3WbBIDT6ycLdYIL3pRQObeHy3vSnrV/NKaRawkHaUNkoK/N/XGH8l+Y5euN3ZzZA/nHhlBUItoQ7AdWwg73Rj/TLrqkQShmydI6m5jxZPu7Kkkhg5rowk3+HgemmgBoqxWFFW0zbOBa4gIXxmexWwREaNvDyqOrww/l+LC+v3FKo30lNWrx1qDFxvENqLiOZxqvaTkT5HpSEijS5XNMIU6X6jGBhjJcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845111; c=relaxed/relaxed;
	bh=YiUxMRBXcEegnqapVg8O2o71IpqvdfaK2t96TrJJZ6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZvzf8eohDMqAj5d9uc0tvCpY9xt19y6xZ0P3LrOiRr3HXDmnKcgCJu6sJJLkKMyXHSUmMrgK7VzFW2qwS3Pj7BQHUrzV9eUEE3N29WzUusnc3GLGfZIJMLK3taZIaw7Upl20O6LBtSdMLHWr6bhuu+ORZ9tvjBNdpuvcVeQ1+6BZk4brx09mmckOpYDQtaVa5zW9OifT2yD5A5Kmtt8A3b8eyj/Q54B/YISZjqAhOsAyX6oZ90Puzq1D7uTJ8sLKiH/NqnftWjNdzgDZIytVSZoeXCdIkbWWyg0bG6LJpWsr19nfU9YJnlK7vosf/V0NVMYS0fI0mGqdwe/KYTUpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HDvmzPJe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HDvmzPJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJ8Q3vcqz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 22:11:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A3F3D60097;
	Mon, 23 Feb 2026 11:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18D8C116C6;
	Mon, 23 Feb 2026 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771845107;
	bh=0uFodMjPk+JdxwNtlnU7QI0PCWofEIVQdGNdAJv3Vpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDvmzPJeDymRiXhUdN+v5LljAu0rrNYefw1DhVUo8pqJn5TK1NMDi8Fx0SnG1oR/L
	 fr7Qb2pkwv2cI4/1UaNT/GxgCKJIEjdSC1ckWdwjmAlZ7JB6b8WBYNbn4oaHJaRWmM
	 3M+TjXdKJi1egsPeUERu3pVIsnJ4+oQauLgBySZWDeq4OG9nmjhumL78OlmTWf4Slf
	 pbegYAJCqZ8d+FjManjffY/f7pQxniuw2y4G2aQ6w3L6v27wqmhYVNHAaEU1YGLk37
	 +iZFhDFwSJ02ivvrorgLlYPzYkC7fxAFtol6HrhSxYewZrq0VJoTCKLJbbjmyLmDpc
	 U9wojsxnSq2TQ==
Message-ID: <1956c912-c880-4214-9bc3-e205902459b5@kernel.org>
Date: Mon, 23 Feb 2026 12:11:43 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: Enable private stack tests for
 powerpc64
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260216152234.36632-1-adubey@linux.ibm.com>
 <20260216152234.36632-2-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260216152234.36632-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/02/2026 à 16:22, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> With support of private stack, relevant tests must pass
> on powerpc64.
> 
> #./test_progs -t struct_ops_private_stack
> #434/1   struct_ops_private_stack/private_stack:OK
> #434/2   struct_ops_private_stack/private_stack_fail:OK
> #434/3   struct_ops_private_stack/private_stack_recur:OK
> #434     struct_ops_private_stack:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/progs/struct_ops_private_stack.c   | 3 ++-
>   .../selftests/bpf/progs/struct_ops_private_stack_fail.c        | 3 ++-
>   .../selftests/bpf/progs/struct_ops_private_stack_recur.c       | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> index dbe646013811..1df1111cd029 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)

Won't this also trigger the test on powerpc/32 ?


>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> index 3d89ad7cbe2a..e09c1a8782b4 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> index b1f6d7e5a8e5..791800835673 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> @@ -7,7 +7,8 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)
>   bool skip __attribute((__section__(".data"))) = false;
>   #else
>   bool skip = true;


