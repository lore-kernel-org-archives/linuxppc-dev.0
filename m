Return-Path: <linuxppc-dev+bounces-23793-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0BC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 09:16:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwCC93t7mz2xll;
	Wed, 08 Jul 2026 19:16:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783502197;
	cv=none; b=WVdG7lahR5lh9GDbGeu4dMXvXd6irIx0aY3QeqtzZn8Gp9A7cf2TrKuQYIRqAcSA7UKktqQM/wPGca2boBJ04mJ0ukHOZAzcrHkGKzdz5zJBw6XpO7HDBhwG4H8B9IeBfYBeSKJfo/V/FQ+IcZbWoO1/xg3V7iCYJYgylWxJAVTHs0xDwwwtPA22lh84EZrXHq/K0J7TD9To5GuZQLy31Zp7lajyAlPS0BiR9WGDfkZ5cIQvgfwJ85eoE8SLitptZ1hUg41Z285+IYWlyzAeVeeZmpVTzNVaduz2YCF/FjoGMao4BDapOv8Kwx8jDUri8RxlHyCji0YdBDM2OsqLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783502197; c=relaxed/relaxed;
	bh=mYG6WaG7m68VASwoH/Qbw0bAKXQeJJcttE2MKggz9kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKoEGA1oC3biiMD6B3WAQJ6hxHUQI0SZ4S6ogMGyqc3Gj92FV5PASVZJuSpOOqG8S5mkx7xSjTtvlPKhVYjr33HvtIm/zIMn+xCjqOPWNkwGCu46CMkbNPg1nOa/g954th2aeKx02nKJxvmxEBM4rk+vcpHNROBPKlierBOaR0Il3LNzixyVfz5aOFHZzSqIpUHRyv3HZb+JVujZSiZnDMaQbhfd1WYLgSert2A85lASHUDl25R+B/DXadR9w1wF/BqDszIypo/+KJ0sweZA4wtpOT71nd79yENV0K8ozXkGo0OCH+TaHRHBQuqKwg3ByKJnvnW7Zv+I/+hSeXVNhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1o7Cy/2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1o7Cy/2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwCC82l0jz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 19:16:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5308240128;
	Wed,  8 Jul 2026 09:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F891F000E9;
	Wed,  8 Jul 2026 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502188;
	bh=mYG6WaG7m68VASwoH/Qbw0bAKXQeJJcttE2MKggz9kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N1o7Cy/2UAb5pvDnsW2W/2IEWfzlvPb5qh6tUiAem8Gf2M7VhGzhZ/Y2Jx40amSta
	 eRYwR2//CYve1u4uzypgFTemTLGPafIx5fVQioLJD5Sn4hdfvpP5u4eZkeOM833ouq
	 3G+3Mlh8e7JmA5rStlaPedSdWHh/t+ELsZVQ0VNJ6mieO79DKlgD0lbLcCskpo8frt
	 Ek2lck3KWosiUBwUhmEc4sxs8Xn8DQLyVRoOsZlF1VniYeV+rnE4EXiJUggm2doJ5h
	 E24L6gP0rJ3vUHlKDAV+stjtsRYHo0Hqfr+yfpngxNIhAv4MFlNEU9teLXpTQ3Gqv7
	 Wt6aASI6cp48A==
From: Thomas Gleixner <tglx@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann
 <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Huacai Chen
 <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Sven
 Schnelle <svens@linux.ibm.com>, linux-doc@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Kees Cook
 <kees@kernel.org>, x86@kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Vineet Gupta
 <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain
 <bcain@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
 <dinguyen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [patch 18/18] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
In-Reply-To: <5c202ab4-33f1-42e9-bef2-81fbd0a9992e@linux.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.603111179@kernel.org>
 <5c202ab4-33f1-42e9-bef2-81fbd0a9992e@linux.ibm.com>
Date: Wed, 08 Jul 2026 11:16:25 +0200
Message-ID: <87y0flrgd2.ffs@fw13>
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
Content-Type: text/plain

On Wed, Jul 08 2026 at 10:51, Shrikanth Hegde wrote:
> On 7/8/26 12:37 AM, Thomas Gleixner wrote:
>> -	r0 = syscall_enter_from_user_mode_randomize_stack(regs, r0);
>> +	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))
>> +		return syscall_get_error(current, regs);
>>   
>
> There is one missing )

Bah.

