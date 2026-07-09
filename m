Return-Path: <linuxppc-dev+bounces-23910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A11C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:36:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmxJ2dCmz3c6q;
	Thu, 09 Jul 2026 17:36:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783582596;
	cv=none; b=jYN28XzD/IEev3nwt+7oD4cpDXMPduMfdN09rZ4lqyaMRqSr67/ACxsvON8jqIxJ+I34ZTynoDF/xHhaJkLFG89AA5iqd2LQKyK7QKxRZBI9dmreLkeM7gC1zC4avAlJBpGWjueYzr71dwOwYpgLxEOnzExr5ijoJAmRd1FOWZiazgw/Ko+octvseVm2lJZqjaRmeeQJXzLvJ4e5k3hF/S8g/Uk4k0Ksdh9JHkrMP86nXn9tsYcUecRiundcRDpstr/GFErHJGSNIucul8k/QVSf25CsTZpCwzcLzAJurFXN2sYMaZfk5j/l+7QqnKmYj+XNYUY0u/yYwihkRkLzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783582596; c=relaxed/relaxed;
	bh=fpSVJy70b3xqWnZXpAlUFJdEu5JY/bMxQLCNfbP622U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCtUedaCzWg/KdnOjG08xqg2Z7sgKMJx5s5ms8IhooDp+HS4UjpjQYPJudi3EVeBr10gIGmfV9EX4tC6SoWpC6Hx7M/3hFYWwM+rqsEaaHWLRoGizj4xYt9FvMuHeitopy/dNdDcHHwzcQQxb2Epq477ZlyYLOHP5XHUhSnuJVunLv2bh8OV1utFQu0zEDjbDmGQTahy69MoYzkO2h+cZ6Tm13frFXtdK1RQDXztort5xsCqhHX0r/pUEncyCq+TTC3iVl6animCBox6hYqiPkvDAlY/uiAWPTAFW3vPFQR3VYuA8EM0GK9xL/7uW1PUA7bjC4lFm74PAHy/nYqhow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g2iecoGH; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aPsm4KX2; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=g2iecoGH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=aPsm4KX2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmxG5Hwpz3c6n
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:36:34 +1000 (AEST)
Date: Thu, 9 Jul 2026 09:36:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783582589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpSVJy70b3xqWnZXpAlUFJdEu5JY/bMxQLCNfbP622U=;
	b=g2iecoGHP1Q35gwzozGqpuJ0N4IBF+7Mb6UtjI//sGz3GDw2QvbFIwzqQxpn8FGVErlS7s
	omQVYbjmgyDJmhF1MmCJlIHllgyUO01Sr/yBhSgxI73gtjpY4E1vXqhtHTENlpaAPa12sQ
	COfi9C4/Sj1r2xVrGyKnP9WxPszidYfKAY5LkVWbCCQrazun7IsY1JN+lXSdvSLidQy+zJ
	JM42AdQNLsIiZHirxAYPzrO+5JXzDJKtydCvmMQjV1j+RrDzi32PI8QdtKB5/Db1jOP9ap
	STdYW58tGV3g9BcaZaDXSYefwyq4ViT1/8sPNvUgcWKCHxRJXZjUOZPPxh01TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783582589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpSVJy70b3xqWnZXpAlUFJdEu5JY/bMxQLCNfbP622U=;
	b=aPsm4KX2JqjVkOTd9TekKMBY/H0/KYVBKvaYO+P4E5asdbyGTnkQwhT9fbb+nkBTJB3oUI
	nJc65qufMiJf3XAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, nathan@kernel.org, kees@kernel.org, 
	xur@google.com, peterz@infradead.org, gourry@gourry.net, 
	lukas.bulwahn@redhat.com, ryan.roberts@arm.com, yangtiezhu@loongson.cn, 
	sshegde@linux.ibm.com, mchauras@linux.ibm.com, austin.kim@lge.com, arnd@arndb.de, 
	jchrist@linux.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] syscall_user_dispatch: Introduce
 ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
Message-ID: <20260709093404-0b19988f-8d19-4fae-86d8-396aa747307d@linutronix.de>
References: <20260709072803.3843948-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709072803.3843948-1-ruanjinjie@huawei.com>

On Thu, Jul 09, 2026 at 03:28:03PM +0800, Jinjie Ruan wrote:
> Currently, only x86 genuinely implements and supports Syscall User
> Dispatch (SUD). Multiple architectures provide a stub
> arch_syscall_is_vdso_sigreturn() returning 'false' simply to satisfy
> GENERIC_ENTRY compilation, which creates a false impression of feature
> support.
> 
> Introduce ARCH_SUPPORTS_SYSCALL_USER_DISPATCH to decouple this mechanism
> from GENERIC_ENTRY. Select it exclusively on x86 and remove the redundant
> stub functions from other architectures.

Nice, this confused me before.

> Link: https://lore.kernel.org/linux-arm-kernel/akZgV0Y4YAmB43_g@J2N7QTR9R3.cambridge.arm.com/
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/Kconfig                         | 1 +
>  arch/loongarch/include/asm/syscall.h | 6 ------
>  arch/powerpc/include/asm/syscall.h   | 5 -----
>  arch/riscv/include/asm/syscall.h     | 5 -----
>  arch/s390/include/asm/syscall.h      | 5 -----
>  arch/x86/Kconfig                     | 1 +
>  6 files changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 0c01521c2f3f..393d0fb75eac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -116,6 +116,7 @@ config GENERIC_ENTRY
>  
>  config SYSCALL_USER_DISPATCH
>  	bool "Syscall User Dispatch"
> +	depends on ARCH_SUPPORTS_SYSCALL_USER_DISPATCH

ARCH_SUPPORTS_SYSCALL_USER_DISPATCH is not declared as a config option,
so the 'select' will not do anything. Needs this:

config ARCH_SUPPORTS_SYSCALL_USER_DISPATCH
	bool

>  	depends on GENERIC_ENTRY
>  	default y
>  	help

(...)

