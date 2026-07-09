Return-Path: <linuxppc-dev+bounces-23952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3782CC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:32:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx3VW2t5Dz2xYg;
	Fri, 10 Jul 2026 04:32:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783621971;
	cv=none; b=hWnsO4GGeGNlgd2/DZOCj6I9bV9UNwWFDguGaiohhadg0Y7FfWEILfPvh5le4u1i0bTa3OmyOHc7g0ZJmbDvdtVPzn++t1H1r6TLa0BjvkCJCaNEMdiJPSw/WDbXnfv4587hrPb8HJhf2L5qaipeqDRgzwM+c1lXinFtPvguhWr8dKQbqD6YzIQuHtamUsRkcGY9zOXFxGgOgxTzxoVk3hNYYcju5uFHQDdtYMqW3oMjrddrnmJ371zA0NxVDfUFoh9UhL5VfRvCwFJE+pIo2Lh3SgXZhqwI8hoBoV2JMgRXbYnnSPzCzbg+tPL5IsACQtxtl3BtXsRy5oGrffKG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783621971; c=relaxed/relaxed;
	bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+oLJabdEXXHFXfAW+y7vwHqwJ/HoDAYIR81+M0tqwF+YNz05i4w1zd8Cp9i2Ct/9djxPHBVWSs4XjuTt3JCjAAsdyB1F/PiE8qjTJsMKKRGLtHiOrnrczKPvzoNa2pFcfAcgWnFTQVHdpi/K8QXvTLXuWKA33PkaxaQLAarLQopIqzFP0l/FHtyI88YkiZXSr0Vkt4ZW8t8rnRM6fUN8h8hvqhA7hvolTgum1W8pvoB5brMEUt3dtYDXh/Gc7aQaUFwnU83p2OZsyzZQtLX8L7qcjVr/HY1vkoalkE1z16zcLmOsI6lMl0vY/Gs8p2qraekz4wwyCue4bxTibNj5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlVbAKDQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZlVbAKDQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx3VT5Q3Lz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:32:48 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-381891a9525so271648a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621967; x=1784226767; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=ZlVbAKDQZm964OuUwbs4o7Z4RHi6JNQXI9cGfYI1DE4w1Q8VYotZ5+4GhA90uZ/8dJ
         fLpWuR3+WJolWe4xrZZSa/nD4jdZeHS3KcLi/5+NQZGIX7tqCGaFX62cCtB7V7nEioSS
         SAaMxhaOaZPuC82LRBjuWUgabT9rdLpsCrGAA4exWhYJRarrUtf99eEOuH+ttvpLUY6N
         Mo4DxKcU37DwMyW3YIyN06vyH33Gow1M6ShJlyDcBPtf/xwVB8qbPaTKRyksDf6/PkFf
         xo5JAeLcDpTBUNViEX/5UNZqZOlkly/u1s1a3mZ1mHPAoMvzD+KgOn+UWWe/VVOpZx0b
         do3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621967; x=1784226767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=Yz0Ex2+28vmHug9GMgmP/rnbhA1qykZQQWO8CN6i6g+Q/+T/3ve/VLgWJEYKSWnvri
         A5abMTdl2cnK7g/ALAAPoEWuTuNTypgtXzIXpsk957OAvVhxBuuwhkeF2G9Cd1/6XbnA
         6gUe50A9dbVP6HKRiGIqMOuc3Bz3xM495LKijy2zfm5Px46F6bY4mFXiviDlPcT8rv74
         wqMnWefM2D6BcVpku60Cyj00O8RRX8MMPMBzRDuArXdQU7nsoAPzH4snt5Dh5NIzmKwg
         wLpaO5+bHw7pg3E3mjVAMFF7NCv84X5A0MJNl3IJEbOBzvWi4w7G2ynCshKy3e51TKMH
         CXrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrwi2QT+M3Hiw+9+ZnVpl4pOObhtVPNCbsyrTO4J5JRpHN8U4NLeErhrD6IOYJ9rQVa+ZpbmhSDpxN6Zcg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzuxsVSuACbhQu2SLmtii4DgTlCwAoQJcfxQ75ngkGFhaD7mQHX
	0zGiEigXi4M2p2q9FWIhzwuzcCrZa71hR7nsYLlrkqtDZxGfuC5nWwl+
X-Gm-Gg: AfdE7cnY5PmAV63wwGF2bUHvy7/49cvc4aMSMh6kk6JiA/rrm7r3vANuWBYssoIAGsm
	i+10k6K/dz11nDxQlF664Vt/I7gxKAv92SyN9UdgpIGm2p8va9APUxJ2gOGd9TMi0VQqVJVOwHB
	TbIErpFskDopE59o4PHILsLOc6KV54+9eKus3EFJh06SpWI5a1NkAxH0QmUXobBwjXNjhTnlqNR
	8v7upwt03scKR/x+YKAn2hvnjj/kgYOrJ34vFWnogEy75LnAjYlPvr1fsKSPUROmlf990wbrx3S
	K5RlAFnVBj7h6+vFTXjaolDTZlca4j5Pq26RQ7Dh+n/gpD2LSPKJlYAxVMg8cAOw5vhrjEcik3J
	St7DSOFY627jIBFwamqA1cdOPMdTydS1XIGIOyUQeXHyQgi04FzOOk1ccqRhKhR3fH02js3Tu6F
	4Z7wO7uHDrLY0CSiFIDFuQC7e0lsqCWfcZAPFcxi4k5A/1NNox9pWL8w4ROU80JRoU6fHgJfQ=
X-Received: by 2002:a05:6a21:3295:b0:3c0:9c18:d5a7 with SMTP id adf61e73a8af0-3c0bd1c4948mr10580989637.68.1783621966489;
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm55669365c88.14.2026.07.09.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:02:27 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
Message-ID: <ak_pE64J_xnLQBMd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.718191130@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.718191130@kernel.org>

On Tue, Jul 07, 2026 at 09:05:58PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Thanks for fixing this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

[...]

