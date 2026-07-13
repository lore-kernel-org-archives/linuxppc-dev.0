Return-Path: <linuxppc-dev+bounces-24078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD5FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 01:34:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz4j91NR2z2xyh;
	Mon, 13 Jul 2026 11:34:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783906445;
	cv=none; b=f/dO5zcmx5LmB/m83TnX+A0r5UXnLS1yrRsnEmKrJ6q3H91qxEdjoDS9BFOIE4tMsPIcuLTscIf/+bSyOJCW4/iXYLJ44kAi88rCxO6l+RYF9EudYWm2Q7ALzO0X6zUhzOFlanLKUqfPLHbb7PVrAvGUcN5oR8TtN4EY6WT86cyPtYUKWT0vvw7Kf05ssKO+VYE+NmzHJrJBbk7D04KVn/HhIqxqzTkdRqmgacecZH4kPOOtqN5IkCXmA8rirBD1p/lXVu/5X88ijlhuaaN+7IjAuXGqoz+lGJna0rlGfETEBxUN1Sk2X1p/ZQSVGcmR56EvAJ8zs8ZIhyCnVw8fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783906445; c=relaxed/relaxed;
	bh=nIM4m5e9jGc2sCxhzH+mYlnpqbqKe9faxrdPztB+tkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Em8KJuGBgsF8lQuEulLAhojYjG5uFZFxJOAogh1Tgo0c94+oiUEPlbqbNEqql0deed5TZTTmckk+lQuA6fdaJ0g1wi+oPxLpXI4LsZK//RODebQi28+2siqK0wgVyfwWdD5rV84VEBeoOQbUggStytqSFFzkKMrP+yJIcdVKWeiY41hVjWBu3nunhdkGKw4Ln4yFcfrRnIUfKI2R2ksA8GX5PVahrI5b2oNaYL40dH6rBVzPn857sNxtRhyI1ffRD26zYyTnAR+cwwxSvGomMtC5QdPUmLxugVMgp3UNY15rqZuJeWwD7FSWWSWNQFXh0k2oirgkcj9X5mFpAKeMjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=As7yTkFf; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=As7yTkFf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz4j62rNJz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 11:34:00 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nIM4m5e9jGc2sCxhzH+mYlnpqbqKe9faxrdPztB+tkM=;
	b=As7yTkFfrwDJVeeOgWTYV+UMEyVi3b+jQMQX7rfkp/tm1wuMS9j4Dw2TgZKn8WKc6c7OKl2xJ
	4J+tM+ADkcJXS8glDkArkowYGIiT2JlAmOdOPIng5dw3tqTx9gh09KANnSex0ZsCV4lA0wnaDZY
	fsG/wYMyPD4R0cNbSBIwSTI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gz4Tr5crRz12LF7;
	Mon, 13 Jul 2026 09:24:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id DD07540561;
	Mon, 13 Jul 2026 09:33:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 09:33:54 +0800
Message-ID: <7480b818-d44c-47f5-944a-5f17f3429d09@huawei.com>
Date: Mon, 13 Jul 2026 09:33:53 +0800
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
Subject: Re: [patch 1/4] entry: Rework syscall_audit_enter()
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
 <20260712141346.576865340@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260712141346.576865340@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/13/2026 5:25 AM, Thomas Gleixner wrote:
> Move it out of line and let it reread the syscall number on it's own. That
> makes the low level entry code denser and allows to move the reread to the
> call site of syscall_trace_enter() once the tracer is fixed up.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h  |   14 +++-----------
>  kernel/entry/syscall-common.c |   10 ++++++++++
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
>  
>  long trace_syscall_enter(struct pt_regs *regs, long syscall);
>  void trace_syscall_exit(struct pt_regs *regs, long ret);
> -
> -static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
> -{
> -	if (unlikely(audit_context())) {
> -		unsigned long args[6];
> -
> -		syscall_get_arguments(current, regs, args);
> -		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> -	}
> -}
> +void syscall_enter_audit(struct pt_regs *regs);
>  
>  static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
>  						long syscall)
> @@ -111,7 +102,8 @@ static __always_inline long syscall_trac
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
>  		syscall = trace_syscall_enter(regs, syscall);
>  
> -	syscall_enter_audit(regs, syscall);
> +	if (unlikely(audit_context()))
> +		syscall_enter_audit(regs);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  	return syscall;
>  }
> --- a/kernel/entry/syscall-common.c
> +++ b/kernel/entry/syscall-common.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/audit.h>
>  #include <linux/entry-common.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
>  {
>  	trace_sys_exit(regs, ret);
>  }
> +
> +void syscall_enter_audit(struct pt_regs *regs)
> +{
> +	long syscall = syscall_get_nr(current, regs);
> +	unsigned long args[6];
> +
> +	syscall_get_arguments(current, regs, args);
> +	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
> +}
> 


