Return-Path: <linuxppc-dev+bounces-16863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77128EF99E5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Feb 2026 23:51:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fCTT26HNmz2xlx;
	Sat, 14 Feb 2026 10:51:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771026662;
	cv=none; b=imfu7aV3v+y/98kf6tDLvCMAp3KsStAJt/G7NtJXmctJ0PDQyKc+gmyxmiLchCaWC9H++Ho6EEJsT4Tsljo9NPEfp8RtbjRtgGjHgX8FQ/k3TQtiRLYEnx5D5Dkwb+F9RantDe7NgO79d8QKkyjBeAhWD/1ID3gG/6ZVvuYEA89Y7BCo6RcstMp9gW1GMk+hjb22fEMrH89cjftcK3cfXRKleIMd0vlzjJz5ZZSBihwFOOTMMbVRuNUbYw8zdNWcM10oqeTZVAU1ElSA6Fw2AgrKEr97yo7gD1UJbY96xgH9wXAbPtpKW/2Phu2yoxjbS/ED/ujSEo/wC0d0kAET1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771026662; c=relaxed/relaxed;
	bh=gaYlZBB36TbWDlt2Egqu+9ETrBmf95Xps1WibLPbIUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jj2nNWC8Hj5y0XizLPh4zy9uE7t5QsomlQ+PooT04jLT0VTzDrLqENpnj04/ec1XZGJGwv1jFij0jmmYsFK19wQkWYp8XX52BYnDqTajIqN+HxlzkPadT6q2rkIScPgOJusPWf8cLHGPmAYRh4WHPj7A8U53hNlJUz3vHVszH2TU7D1AeRVsijkH9BeXolYizHHsdqNKUIr0+qtRag09UZy2PSV84q0hGisMjiVtsaJGfGLYRHyZ7G3pmFhfLal5VKcVt2aupc94rDyb257ICbRu9I071E2UGfOqAWUtUr93J7Mnv0sawdkIDgQ2/JqW7a1YeoIYCmkvHsa4H2aYFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EOEHHCPF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EOEHHCPF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fCTT21p4Sz2xln
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2026 10:51:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7A45B61331;
	Fri, 13 Feb 2026 23:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC3C116C6;
	Fri, 13 Feb 2026 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771026659;
	bh=QoKSwSBqaOpHpkjTew6izt4GjR7iLhEwaoFWROxFqU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EOEHHCPFmdLlRt//NivYi2N9zSKkBexO9hurNKzWXSYkuzFGWrrRWxoRM27S3hhDf
	 c5Ci1IJ1PJWQ/ZsKRL5b5G1Pi3h1IyUbMrEitNLnNm9S9GvLau8jcAag/9UypOouEH
	 wXbVwyLXb4VVQZHpr1oZQ+7JzjwARGgKcQn43H5QL6BXLjNG8c/gJ74PIUWVWkUI2D
	 pnCfvn+7qMEDqDcQROGlWFJNOMtz1Dxst8Na1t0Z5sUIDcM90Ly8bW6eUJ8lyfL0Hp
	 PyktTrKI80RVICjuYRxMNeaRpSoSv6odVNWM363TM2DT8MXla0J7z4VNSfGOO0nOAb
	 Uj4GZRGURdPMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B01A3811A44;
	Fri, 13 Feb 2026 23:50:54 +0000 (UTC)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: Add powerpc support for
 get_preempt_count()
 in selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177102665283.2575868.6086661515797836268.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 23:50:52 +0000
References: <20260212092558.370623-1-skb99@linux.ibm.com>
In-Reply-To: <20260212092558.370623-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com,
 sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
 eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, christophe.leroy@csgroup.eu,
 maddy@linux.ibm.com, mpe@ellerman.id.au

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Feb 2026 14:55:58 +0530 you wrote:
> get_preempt_count() is enabled to return preempt_count for powerpc,
> so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
> bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
> powerpc as well.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: Add powerpc support for get_preempt_count() in selftest
    https://git.kernel.org/bpf/bpf-next/c/4c51f90d45dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



