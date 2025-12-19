Return-Path: <linuxppc-dev+bounces-14894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4105AD711D6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXgK43v2Fz2yFd;
	Fri, 19 Dec 2025 19:13:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766132008;
	cv=none; b=SQkWmaBfc3AcUJHs7c6i3jGvGcU7M0BO6ORp8pmBDmHAd2q3A7FEmVTVlq8KO3+vQTtljAKWJT7Jz9/fnQdYnhutvSzkzvYJaaMcI4C1JY6ArVejmfOFA/pRo/6FaMnl5OawPZCrWlddRWdVT5z2Cu6uIUtDmykSSp5QnYhDBgD6CeTnu10H3+SqKE++wJm1fzwo3Ga9Xf6PahnTTNT4BdEkPnihyo4L+P4GPkkBp/SMsm7IjmnS02ZMIcCPKQ0fldQfuaZslkCVLMJI1qpfBNWivlRs4ziJ/IKUWA8Ua8zt1PebSi8HAFQ4m/4xG6vFoxekGM8+PWCLGScGWIxQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766132008; c=relaxed/relaxed;
	bh=SJjgxmXldWO+gLQl+eiXN07E8mK6jMZGSsZ/vefjBYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YoWo1Z9DdUy/Ut2HT9cGhFRgYohv/3nDa10ZpGZyrX7WJrmVruHKmWO7CVwh/Nv/P4K23RU81vaq5zYWvBa736SZDyX/+rhcL6faCgD3TY1prU0zRD3oaxxqlEzfME0UqaoL+5jxcVpitJhDdo9IM0NfpyBDbOvyCS0orKGZIlEponEnR8qni67AmxNN1THzRaaVp+i/mA+c8H6a+QFYFBMUMJyysb6gvJ+vBogyH5zUCgv4GBFx2HiGKYaAs/0b0cB1ngeIb7rTsLrrCXZSDnG1RR3el2x2xEhiVceYVkQ+a3P6RlRgK+tFWZu/JGmSZvB075DV5tElh19UKmrcmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VFqc9JjX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VFqc9JjX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgK401CJz2xfK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2025 19:13:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 690324445B;
	Fri, 19 Dec 2025 08:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483C9C116D0;
	Fri, 19 Dec 2025 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766132006;
	bh=VFiTUqFKrbPqxZ9+NNyag6Ajy0uzkayrmpB0IcPZ4PU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFqc9JjXV4mr5LizAyAg0tm5CJ5+ZKRz2e441pHxsOiibmeY59xqgqo0crFansJqy
	 P4iE+LwFzjEO14DLRaSWWuqKz/n7erWqILtXs9Lv/MNRN1owKC0LAzXRhNgKAx58lp
	 tCR21R2Dw0bWznLJdN91LGXcdkvn7rx4jeDVemHE8IzxC1Y4JBCay11De2Xm5vEcbu
	 /4J0e8p+7t4L6eUrHmM/cZpJ3p6Ww14fgV6pv5nQ+0hOx32UTmjPSSI9YD07/Dl1O5
	 ++5+k0gllM3NNDpP4jmGzEK4n89hxvNhgOvvTI0omoe5NZ2P4gzH53HInU9C88e17j
	 c8ndEnoCuJn4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79F14380AA50;
	Fri, 19 Dec 2025 08:10:16 +0000 (UTC)
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
Subject: Re: [patch V6 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176613181528.3684357.16950067300895090684.git-patchwork-notify@kernel.org>
Date: Fri, 19 Dec 2025 08:10:15 +0000
References: <877bweujtn.ffs@tglx>
In-Reply-To: <877bweujtn.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org, ylavic.dev@gmail.com,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, lkp@intel.com,
 linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org, pjw@kernel.org,
 palmer@dabbelt.com, hca@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, linux-s390@vger.kernel.org,
 mathieu.desnoyers@efficios.com, andrew.cooper3@citrix.com,
 david.laight.linux@gmail.com, Julia.Lawall@inria.fr, nicolas.palix@imag.fr,
 peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Peter Zijlstra <peterz@infradead.org>:

On Wed, 29 Oct 2025 10:40:52 +0100 you wrote:
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:
> 
> bool foo(u32 __user *p, u32 val)
> {
> 	scoped_guard(pagefault)
> 		unsafe_put_user(val, p, efault);
> 	return true;
> efault:
> 	return false;
> }
> 
> [...]

Here is the summary with links:
  - [V6,02/12] uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
    https://git.kernel.org/riscv/c/3eb6660f26d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



