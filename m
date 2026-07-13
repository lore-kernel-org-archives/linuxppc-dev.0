Return-Path: <linuxppc-dev+bounces-24080-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DA0C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 01:40:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz4rj6cXPz2xyh;
	Mon, 13 Jul 2026 11:40:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783906837;
	cv=none; b=NB6J4D0CYi9rgz57tkxA4M6Xx/COrHPhbJEO5yzxAsYhxCNhGKAebDwX5DZgM9pBB9stG70i6Nz7iGF0bbYDkI2o2+HIciXq+JK19iLHL2KhgvhsihjuWF9upUx+bAy0WS9lzeO9sOWaSXhbi4NaQBeFCqNRMOHKRTUQplTFDDHYlt8vcnQINcwWOF4UFnywXYLKwSsXOF+u37gGvoLgQPLP1Mvz/2U37jWQ/6AnBKiK9dmQHfG+g6XCRCS9j0/6e1/2rVlSWgiPjLONZ0C7eOK3g0XaLuARhLJJVuz79IZuevEjfR0FVBcOfwfHi5vmBp2GZu4R4lUnL9yeRs1Bag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783906837; c=relaxed/relaxed;
	bh=Hnsf6EzWv9XGmyeCuFGhwViHSLyQheUnNtJIFx91GEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WU2hEy0GL0l4/OVE2TL/iskFHubfBIQiTZISOtSWwKnwAUfOjmI0CSLmH4bAuKBq2OTzTsQRhtKj4YgmxHpWmCFHEj+sUp4qXsjH+cN0xZAXicpkh3xw0Cf6Ha58pgjjV1/5vDfRZbyBBDyVSdtptrRaC8u3IUpM+ZW4ZUkrKEBYXo+amUEj34rIkleY3Mph9DIdyChTW7623oUql32tiROqTSvSGhf0JEYDcmlUvcoFABKjkXws04T+AU6y+49HhXv2bqvlllYEmeLey3lNOOPccg9e8iFy06RwIS9GYiQAMqtdaWvLT6qYKECJ4R2Sh2qqzSs5PtP4X2mGl1sV0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1VnICzNB; dkim-atps=neutral; spf=pass (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=1VnICzNB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.223; helo=canpmsgout08.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz4rh0gCvz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 11:40:35 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hnsf6EzWv9XGmyeCuFGhwViHSLyQheUnNtJIFx91GEw=;
	b=1VnICzNB2Q+9vIZQrcusimHfV/D1Aa9LycEejZLZ/GQ9P1OtnDcmBhJ4Wbrw4dPQUNW+HdLhA
	fjE59wA6tqe0obUfxz2Ta2G4n4XUj7uOgGj1m7JSzkPlF3T/QsSTztoU26yaemzQKQ8H700a/Bj
	gfP9XYIaRwJryIyU/58R1Xc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gz4dv2m9JzmV8S;
	Mon, 13 Jul 2026 09:31:15 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D48C4056C;
	Mon, 13 Jul 2026 09:40:32 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 09:40:31 +0800
Message-ID: <f38fe858-8920-4f4b-815f-f636dc284365@huawei.com>
Date: Mon, 13 Jul 2026 09:40:29 +0800
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
Subject: Re: [patch 3/4] entry: Make return type of syscall_trace_enter() bool
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
 <20260712141346.699072205@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260712141346.699072205@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/13/2026 5:25 AM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@kernel.org>
> 
> This prepares for changing the return types of
> syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
> decision of invoking the syscall from the syscall number, which might have
> been changed in the call by ptrace, seccomp, tracing.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -72,7 +72,7 @@ static __always_inline long syscall_trac
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
>  		if (syscall_user_dispatch(regs))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/*
> @@ -87,13 +87,13 @@ static __always_inline long syscall_trac
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>  		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
>  		    (work & SYSCALL_WORK_SYSCALL_EMU))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
>  	if (work & SYSCALL_WORK_SECCOMP) {
>  		if (!__seccomp_permit_syscall())
> -			return -1L;
> +			return false;
>  	}
>  
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
> @@ -102,8 +102,7 @@ static __always_inline long syscall_trac
>  	if (unlikely(audit_context()))
>  		syscall_enter_audit(regs);
>  
> -	/* Either of the above might have changed the syscall number */
> -	return syscall_get_nr(current, regs);
> +	return true;
>  }
>  
>  /**
> @@ -133,8 +132,13 @@ static __always_inline long syscall_ente
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work, syscall);
> +	if (work & SYSCALL_WORK_ENTER) {
> +		if (!syscall_trace_enter(regs, work, syscall))
> +			return -1L;
> +
> +		/* Reread the syscall number as it might have been modified */
> +		syscall = syscall_get_nr(current, regs);
> +	}

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  	return syscall;
>  }
> 


