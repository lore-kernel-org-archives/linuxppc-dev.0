Return-Path: <linuxppc-dev+bounces-26423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E57C624D7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:15:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZHCS6KlPz2yCv;
	Wed, 02 Sep 2026 06:15:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788293700;
	cv=none; b=DpD7RZ2TmtlcRix5WKuBpB2iG9aiyISnoxnKOgcXLfU5ueKlAZITvvvr4YfI5YKSxkZ6+laYg+EqbHOhAFaf3x6crBNHIayCqS/lkZTvXLMQ7QHzySPERiefmHDZUEPSQxqqJF8rabAw22sNhtiCD0wgYrgTtkjzEFN2kZGIEit3TRK14DU7mBr20pwTF9K1PJ2sIRMZFLoKbVd76eX3xKwh2kArixQ1IVXQPQqY5p8LzK6g+NU7rnkjcEUueu9S/672m3q/Tl4qgTcY/xtm7K1fiezQivFAR78Fx10wO/9uS7Sh5uQn9aWhDu6Q/atJMx2d11Lk+JprYv8aWXtZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788293700; c=relaxed/relaxed;
	bh=f1/Jwq5+t6tQe5v6CVe+ERoBwhfQo9XFyVXChFbscQ0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QiQ2S8ApW1Dc3wE5bfRtVz5AtrxzA+U2et6GmGKN3ehCGknyIN4pZet7mCACbnXnpslXfS8bsu7B/Eemevp52/VMYJVkMCsGF3aKD5tETks1N8P9pcvqYV1/nMeHGq5wsP+0T3HOmkOg/M2hxU2PIx9ob/Cdhv+uYvh6FOws+gyFUPpWJGR1EAFtEE6Adi5/nTvxq6Ce27hQVq5wkqZ2jUVJV6QSwqjdGFEEfdKEDCyDSFTPrAAXhT/XT2H8itsI/tHzWMK0MQpwqQA+fu/4w6lMz85drK1HElR4v43rFkr9g8h/L3iErFwZcedAWCqGpLb8muVenvRBbSeCSMYtyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bur9NIA5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bur9NIA5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHCR2s9nz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 06:14:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF20D43345;
	Tue,  1 Sep 2026 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7A1F00A3A;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293696;
	bh=f1/Jwq5+t6tQe5v6CVe+ERoBwhfQo9XFyVXChFbscQ0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bur9NIA5VjZqJ3jA9kvUAsKCinpmhYAyRbr8Hb1A0OQctcuO7N9DscX1sNVWHL1V7
	 T80F+vdakutewH2IMUKIulhBeYbTt74ZvhHoMosmzBE80N+qc3JJtFqfa+UOgi4b5H
	 nhJt07pq+F5fJOJSXkLDfT4qSN/I+piV60qOEI6PAZyKdu1ycpYXmW4JdbL3YGBRSO
	 QhxKekth0A8llYBOSGx9oqJNnoi3gtqRLBPJlVRvjImiywEubcsr5hoj1xB8ayZBwy
	 q8rGlbxN+AW6qnyVN4sOrSL4v4mH+oG0IpyaHj57TG+k/Vbf4tA5+oKuV69TJt709Q
	 ed/bhiUFFcOQA==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES
 handling
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-16-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364021.3691424.12328056849597833403.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
> powerpc and x86 arch_crash_get_elfcorehdr_size().
> 
> No functional change intended.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index fc0105c7af4c3..c47e3f867ea1f 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned long phdr_cnt;
>  
>  	/* A program header for possible CPUs + vmcoreinfo */
> -	phdr_cnt = num_possible_cpus() + 1;
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  
>  	return elf64_phdr_size(phdr_cnt);
>  }
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 99eb8583d9321..116410ac90fb4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned int sz;
>  
>  	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + num_possible_cpus();
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);
>  	return sz;
>  }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index a97ed9605602f..e6251dfe451a8 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>  
>  config CRASH_MAX_MEMORY_RANGES
>  	int "Specify the maximum number of memory regions for the elfcorehdr"
> -	default 8192
> +	default 8192 if MEMORY_HOTPLUG
> +	default 0 if !MEMORY_HOTPLUG

This only sets the default, but a user can change the value explicitly.

-- 
Sincerely yours,
Mike.


