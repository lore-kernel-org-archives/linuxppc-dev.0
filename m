Return-Path: <linuxppc-dev+bounces-23885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B1DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 02:39:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwfLQ1gtlz3bxC;
	Thu, 09 Jul 2026 12:39:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783564766;
	cv=none; b=ENfNSfieDmsI5V/XZ4eG3C3OQN8sVAAzbU2NSFoE+alLJwBPAHXffgxbIRUbr61X0PYydxiQ92CVY6VQbfOW7NS0mVw+xIQP0t2T3u4mMVyt8GerMS4hs5eDOUpy8+Yie77uIb9MfTi747A0OAjNt8wq0RpJ67mqgn9Ma6UmRcb2bsYi+uk5CejDyWaYYgUd+qKzpiuMdPnqtqAEbtWS06OJJTbOhQA9ztOekwDu6rLdxs4lnoOToTkkfowhLhEoG0RbJNHAT+unz8hgyTLslU7aZxJJjfvxjjzYeqTELlkQfIkKuqL9wJ66jUEohUtsoT8DsOW8JLyle219MNPqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783564766; c=relaxed/relaxed;
	bh=nU1CGqVFGwcos7tENR0k8m0Nt+0Ib81104RzXou1iFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T0dYQfu3ad1vl+e1JDhoLBzLKRNFb2CxhD3DoYNMwgKipthy38Uwfkv14FM/e8WrX6e3Hpej13xJ9CtK8jlwkMJA7Qn9uQ/eQpV11jl0f/YmMEUJj/TQj7evWIBF7qvtMMXseWAfaqkAd86LmHbKLKE/uvd+0/uh0SakjjP1n4Rk2GRWnSzylJU2ideb7qPPdkEZuGzHY7WaFkDgXeABzyuoZnwEFX1dREOhL0KafBxr94QoLoMwzlPKqTbiUJsq3SnAR1P3pkZgNn91B8ytNOIaYRsIJzDAB85/aWTUOgmCnobOF6dhy1SkIBeA8DAoAK4EMbP5H75NSnKjnUzqoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mS5YZyj2; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=mS5YZyj2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwfLP1Ln4z30DY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:39:24 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nU1CGqVFGwcos7tENR0k8m0Nt+0Ib81104RzXou1iFc=;
	b=mS5YZyj2x7rhaVjaYemm20YschmeI6DYoCPf1ckgP1bFplP7hmfasEJ2cQ3lFnxkosy4gRDH6
	5A3UDFD/i0ErGjIgBF7FK3s94x8FnBN5At2LVKpAuncaOLkMO9riVJHrSoiSkjJwSI7QJddrQjq
	Bi9rtHGbQw+1uEpZnaaKZjE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gwf7h4m4Jz1cyVV;
	Thu,  9 Jul 2026 10:30:08 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id AF5D840572;
	Thu,  9 Jul 2026 10:39:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jul 2026 10:39:19 +0800
Message-ID: <5102cd31-1f44-4651-b681-6b3f56d3b225@huawei.com>
Date: Thu, 9 Jul 2026 10:39:17 +0800
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
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Sven Schnelle
	<svens@linux.ibm.com>, <linux-s390@vger.kernel.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
	<linuxppc-dev@lists.ozlabs.org>, Kees Cook <kees@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, <loongarch@lists.linux.dev>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Russell
 King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
	<richard@nod.at>, Chris Zankel <chris@zankel.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-alpha@vger.kernel.org>,
	<linux-csky@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-um@lists.infradead.org>, Arnd Bergmann
	<arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
	<will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
	<monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
	<linux-snps-arc@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
	<linux-openrisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?=
	<msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.030598804@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260707190254.030598804@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
> the subsequent invocation of add_random_kstack_offset_irqsoff().
> 
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/syscall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>  {
>  	unsigned long nr;
>  
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +
>  	regs->psw = get_lowcore()->svc_old_psw;
>  	regs->int_code = get_lowcore()->svc_int_code;
>  	update_timer_sys();
> 


