Return-Path: <linuxppc-dev+bounces-28446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEACC9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 06:20:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv7Mk13wbz2yDD;
	Tue, 29 Sep 2026 16:20:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790662834;
	cv=none; b=GZrdTOqJBu6YnHIDhA6mHngMPZoSQeRBVtRoEuMO5S34CKYYXk550t9z93sLqTbcPLY+6azlxgU9Ea6Dyxk92Dz/U4NHupUIbPy380U9qmZX72lorBKUeVryvpWFRUo7qwfmxW30Am/eHe/lCE1WBXX8z3vvR5a0727ER7VvSkHsqD+Vnpyi24eqmIFaB3lEFkLv8pFeSySV8fPEM/oUEZmaZezvCPzhfqb8I3FLX0PXJUMU4F7uldLEV0zn2yujP2DtrzHUYq2tQkn2/uhc7whJHHajqKvCIUkJEEcCHootp+y4zcWdSDxJ7r5OZqQoutyZPEtE+FB+cPNwBy8UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790662834; c=relaxed/relaxed;
	bh=lTp0iuvGgJlzLvCthN8H5DikguIjM02dg6D/PwjsUlQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B5EWQ/PX+scmBGTElxxScY64TWuVXtLYAWem2pIrNkb5CGZolMdC8LeakDzMzH3QCqVAZTFtHPcDhX5Jlx7fbBSFkRTxOlLhtTiIBEzcn+9qYfutz0Tjc+egheebbgtJWU8diKazubhKAFLJIB6OtWt8a+h/exhV2P0X8yXqf4CPWzXde4TMQkK1u50Xn/u2wOw4uxBnuukqemGlYELI3GkZG84f465IhOdfVux/SmXBxVsnQfVEIeWDfZuMKw4XlMKfy3ARhwL2MHrdGchQCzDsYunyolCatiPew/1CmmJSFFz3ODfHNFumCZXTHSpAujNRbbDGYTyVc0hRq89DOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEu8IKuJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FEu8IKuJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv7Mh5gQGz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 16:20:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 97594602CA;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE9C1F00893;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662829;
	bh=lTp0iuvGgJlzLvCthN8H5DikguIjM02dg6D/PwjsUlQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FEu8IKuJTM9UMyqWZRahuIUiQ6ZhkU4IDa2UZdQ+AHlfxY177GM88K5j47ZpxQMhi
	 9FiOENuKjoLTRooDK6SGMn2gMDlmCoehRnP5Cw/6TyFOVTgHclMnxY1UKAjDkiTEI6
	 K/Sd5XrAq9hpy03DSh95TZmK/hIC7jyt/XZ/GJsm1/KicRH8pbBdQeoXB2Cik/5FrY
	 LhMT7P074WF9asToy5KM2I1lRfV//rJ6lF3tB8DG7vCsCS3rFqo0lGgSOlqUmWzNHX
	 s6HPW0a40ZjDMKNQPLiD/ZEq0vCO79vhQpa0nH73XgM4QaTO4I76tb4UQji83RPvZR
	 pHebvU6K9zPcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A59239253E9;
	Tue, 29 Sep 2026 06:20:29 +0000 (UTC)
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
Subject: Re: [PATCH bpf v5 0/3] bpf: Fix use-after-free of progs detached from
 busy trampolines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179066282803.293113.8557815551946775052.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 06:20:28 +0000
References: <20260926135605.1217928-1-florent.revest@linux.dev>
In-Reply-To: <20260926135605.1217928-1-florent.revest@linux.dev>
To: Florent Revest <florent.revest@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 kpsingh@kernel.org, john.fastabend@gmail.com, leon.hwang@linux.dev,
 zirajs7@gmail.com, rhkrqnwk98@gmail.com, puranjay@kernel.org,
 xukuohai@huaweicloud.com, iii@linux.ibm.com, hbathini@linux.ibm.com,
 chleroy@kernel.org, naveen@kernel.org, bjorn@kernel.org, pulehui@huawei.com,
 yangtiezhu@loongson.cn, hengqi.chen@gmail.com, linux-kernel@vger.kernel.org,
 aou@eecs.berkeley.edu, agordeev@linux.ibm.com, alex@ghiti.fr, bp@alien8.de,
 catalin.marinas@arm.com, borntraeger@linux.ibm.com,
 dave.hansen@linux.intel.com, emil@etsalapatis.com, hca@linux.ibm.com,
 hpa@zytor.com, chenhuacai@kernel.org, ihor.solodrai@linux.dev,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev, maddy@linux.ibm.com, mark.rutland@arm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
 paulmck@kernel.org, pjw@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, shuah@kernel.org, svens@linux.ibm.com,
 tglx@kernel.org, gor@linux.ibm.com, kernel@xen0n.name, will@kernel.org,
 x86@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 26 Sep 2026 13:55:57 +0000 you wrote:
> A task running in a trampoline image can call a prog that was detached
> and freed in the meantime, when it slept in a sleepable prog before
> reaching the detached one or was preempted right before calling it.
> Patch 1 handles the preempted case with an RCU tasks grace period,
> patch 2 handles the sleeping case by patching detached progs out of the
> images that still call them and patch 3 adds a selftest for the sleeping
> case.
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/3] bpf: Wait for an RCU tasks grace period before freeing trampoline progs
    https://git.kernel.org/bpf/bpf/c/0fb5751a6e41
  - [bpf,v5,2/3] bpf: Skip detached progs in trampoline images that are still in use
    https://git.kernel.org/bpf/bpf/c/17637e1a581a
  - [bpf,v5,3/3] selftests/bpf: Detach a trampoline prog while a task sleeps before it
    https://git.kernel.org/bpf/bpf/c/d5288c519bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



