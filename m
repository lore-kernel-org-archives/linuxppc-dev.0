Return-Path: <linuxppc-dev+bounces-26189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC814C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 21:12:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXSdf70xRz2xfq;
	Sun, 30 Aug 2026 07:12:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788037974;
	cv=none; b=ACI6l7FCCvtIWSX07QfcDZFjgGbMpzYjag6l7KeoqsILkT91fydo80xMmXXb38YdddnxZg170+pZ8pYjJIBqr0UY7TR60QbVqy3+fTT9jxk8iMxGoEmvTP8+kxGHeEUjaLlxOIY/fMy7wxXn6NLPmDuDcQ7OfJD9nXXH+FTUqM3DQUlAlTv4HJX/IFVwAL64c4BfZ0xRQQyODidbJyCl2tHDvrSEuSnxWwMsNgj4IubEXZY2Jhf7/8YUuJHt7BW8ihL/vj5ssfqZuSgM8KmjWpXnuHSJ6raUWeMfCeOvMDmfcZRieNO55l0LdeqX80erL8xyUb97BZLkBA61B4LrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788037974; c=relaxed/relaxed;
	bh=Dtc/3TiWrxvKp0avjjHTAnH0zP9eaKC6iJzs8wdLbVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j8QjsJQkPF80iy1GlQv6MvJMe7PXfisChgPfgxJ0fBD/T3kY9Yl1OI3R/ELvRxREtd3rz8Odvd3Dxz+F93W7/xlGkLbXPYsN5Qy4oGYSR0FgiVwTYu9/YMJBhqX1dPTX48yEadUVBMghMD85vpz9UCE8rUJt+nV/69cH8IOF4OZ6MCvRtsTCnkM0wo5zRLYL2h/vy5/BY9juJ4WJWB6qyAd4ixUfgZSWaITxQRns+0xoQFnGG0qRrYi/i5wuYUqzsbQL/CU89bYDP51Saf8uu5hd/Bzp+fMSzQS5wI8f3JaFDx6taYpf1HNB3AVhDouOSMNPKA0VJv+1RPmZo9D3RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1seToYo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1seToYo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXSdd5lJQz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 07:12:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C70F42D83;
	Sat, 29 Aug 2026 21:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649AD1F000E9;
	Sat, 29 Aug 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788037970;
	bh=Dtc/3TiWrxvKp0avjjHTAnH0zP9eaKC6iJzs8wdLbVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n1seToYoBBT3aH6XYy57AvAYoTN8Sa1DDhmW2pGm9sBs8rkBWyAhcowrHekDBroX/
	 LQ9shz0t6AxoS/RQDPShfDSc0m9IWLcU9cIQJq3FkW1jzrInW5+Iv/KAuW8URYVB2n
	 2vCrp2pcnJfrchIq4fTPd7v9FJeK1MDe0dV9wrUv3zK9IWSwAUoaPxvg0yAGixhM4c
	 Z9dwi/DUpv4kJC8uG3byshQrVjTrnzKYKROHUXMRnPyH/qBRKuo9hNfxOcn7FEeewO
	 jvzQ+uh7MKEZRseKSgUEU40CtjsBO3Ee/xgR+WN5+SACHRv8m1z/ulKCStwZ7OqVFK
	 esh+04RW4xs+A==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, x86@kernel.org, Mark Rutland
 <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
In-Reply-To: <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.816918647@kernel.org>
 <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
Date: Sat, 29 Aug 2026 23:12:47 +0200
Message-ID: <87bjakeils.ffs@fw13>
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

On Thu, Aug 27 2026 at 15:46, H. Peter Anvin wrote:
> Can anyone *please* find out what the actual security requirements are for the
> syscall randomization offset?
>
> The original checkin, 39218ff4c625 ("stack: Optionally randomize kernel stack
> offset each syscall") indicates that it is fundamental that the stack offset
> is applied *after* pt_regs pushing, but that isn't documented anywhere in the
> kernel sources as far as I can tell.

> However, I have also come to understand that there are further, undocumented
> constraints; at least at one point I was told that "the offset should not be
> stored in memory while running in the kernel", which seems more than a bit odd.

This thread has the initial discussions about it with more explanations:

  https://lore.kernel.org/kernel-hardening/2236FBA76BA1254E88B949DDB74E612BA4BC57C1@IRSMSX102.ger.corp.intel.com/

Thanks,

        tglx

