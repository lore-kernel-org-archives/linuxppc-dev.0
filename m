Return-Path: <linuxppc-dev+bounces-24079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5448C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 01:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz4ld1kFRz2xyh;
	Mon, 13 Jul 2026 11:36:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783906573;
	cv=none; b=EPNjQDCLXkZda7sgbeR43DHpQQwWlc0R+Do9HieLX4tR6+BOoYm6pyTcczHL9enRDmFjliZzmTee1idyct0RWOjgDgzsU8pWyMLraXbn2a24FcNcqQcJDMgVx0LyErS0d8euHxJEhiDX3yJwWUIrw/bimK7C6xlnuYyO7m9OjXBpg6rW0vNmKkDm40M8uvpABYO315AMrtogEpyJh2Ggw0/Pon2O4Gk/jnCUJx+l7orE/X538x3vaWDE2GUo67pANyHLMUZvzzwh6gmuYG0i3f5ZHfWvQx5zO7tebsNgA9lm5dOu5XdGhCYnAq4cQcGdhBR/mqp7agfchvgC4Qpytg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783906573; c=relaxed/relaxed;
	bh=iSKyRunqi7Efa2Mu72Zd3vRWZxizzKBzPxtAO2+QtZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l3cKkW4jr1EGryMZl1al7aMNCpcimRBXRSwiRmHK9GEB+8/OZvgUknMZ1B9C4oaioUwiXsgqpW03Fat85ZJnLvtoJo8WeemOECYuLdlR9uBUa2PiQjl2GgpO5e5MLaK9+Mmut1xz9QUg0qJsvSYzjLGcxSVCUy3vbb2Otk3H8RjWIhU24XkFcXZUdsR7GdP8bDkgXyJzr/qBKysNUq5B4DxbeUuTK6jFDn4JSILxZ9ueDVMPgTl0w7Hk/wW0jCjrZB4WSw36dPYZ/kMrEo8eTpa4yqZ3AG//FQNzR+4AufUGp4NECd97S/22Uj9TiGpOU19Mnz7Fm7TP9AQ72/hzyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OhHsWWrF; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=OhHsWWrF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz4lc12D7z2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 11:36:11 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iSKyRunqi7Efa2Mu72Zd3vRWZxizzKBzPxtAO2+QtZI=;
	b=OhHsWWrFqDF4iw01ju/V/wuedSNvk4Qd5RncBOtws+2WzWqGVxRMLU8DWnT+L5aKc3F63rC9o
	zSQF8j/UbvpacJIgfpEFOqJvNSjHOZU8gpv7Avy6L6yPLnkBEoTgPNgjsMMuUcSswDQ5mIW5KFE
	AkTfC23kF7UYdY3K6BSmLV8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gz4Xm1fF1zmV8S;
	Mon, 13 Jul 2026 09:26:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 559ED4055B;
	Mon, 13 Jul 2026 09:36:05 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 09:36:04 +0800
Message-ID: <ad9b5f8f-7c4d-4fbb-b0a3-69859ee8b365@huawei.com>
Date: Mon, 13 Jul 2026 09:36:02 +0800
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
Subject: Re: [patch 2/4] entry: Rework trace_syscall_enter()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Huacai Chen <chenhuacai@kernel.org>,
	<loongarch@lists.linux.dev>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>, Sven Schnelle
	<svens@linux.ibm.com>, <linux-s390@vger.kernel.org>, <x86@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Magnus Lindholm <linmag7@gmail.com>, "Mukesh
 Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Radu Rendec <radu@rendec.net>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.639115923@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260712141346.639115923@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/13/2026 5:25 AM, Thomas Gleixner wrote:
> Reread the syscall number from pt_regs and stop returning the eventually
> modified syscall number.
> 
> That moves the reread to the end of the syscall_trace_enter() and prepares
> for moving it to the call site.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h  |   10 ++++------
>  kernel/entry/syscall-common.c |    9 ++-------
>  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -58,7 +58,7 @@ static __always_inline bool arch_ptrace_
>  }
>  #endif
>  
> -long trace_syscall_enter(struct pt_regs *regs, long syscall);
> +void trace_syscall_enter(struct pt_regs *regs);
>  void trace_syscall_exit(struct pt_regs *regs, long ret);
>  void syscall_enter_audit(struct pt_regs *regs);
>  
> @@ -96,16 +96,14 @@ static __always_inline long syscall_trac
>  			return -1L;
>  	}
>  
> -	/* Either of the above might have changed the syscall number */
> -	syscall = syscall_get_nr(current, regs);
> -
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> -		syscall = trace_syscall_enter(regs, syscall);
> +		trace_syscall_enter(regs);
>  
>  	if (unlikely(audit_context()))
>  		syscall_enter_audit(regs);
>  
> -	return syscall;
> +	/* Either of the above might have changed the syscall number */
> +	return syscall_get_nr(current, regs);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  }
>  
>  /**
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -8,14 +8,9 @@
>  
>  /* Out of line to prevent tracepoint code duplication */
>  
> -long trace_syscall_enter(struct pt_regs *regs, long syscall)
> +void trace_syscall_enter(struct pt_regs *regs)
>  {
> -	trace_sys_enter(regs, syscall);
> -	/*
> -	 * Probes or BPF hooks in the tracepoint may have changed the
> -	 * system call number. Reread it.
> -	 */
> -	return syscall_get_nr(current, regs);
> +	trace_sys_enter(regs, syscall_get_nr(current, regs));
>  }
>  
>  void trace_syscall_exit(struct pt_regs *regs, long ret)
> 


