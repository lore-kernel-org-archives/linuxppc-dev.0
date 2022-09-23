Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB1AC6FA82
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 06:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYjgg4Px2z3cCk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 16:59:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CGRO2nd5;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYjfz2D1nz2yyT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2022 16:58:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=CGRO2nd5;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYjft0mtwz4xFt;
	Fri, 23 Sep 2022 16:58:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1663916329;
	bh=uAgDDCHFgO5WnTB/PX3kiltH+MoaVOlY4LZAn4+ojd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CGRO2nd5HVsZlZziX5awok6Bq3jjzY8rZ8KXBWjYG7SJmZpbcsTAQrszCGzIr2XoJ
	 VJVEyIOeJVxAMUPqP3dq0bvAtm3Tk7um5oIOCZquXQWM29XLhDKBgo6f/BcLtMe0qG
	 BYPV1f09oZqqTIvLjyWMwsT4zo0ZPhr0fxrTiV+pdqyJB0iz3hvzp7GLGyNh3Yt9zV
	 2rMpU8tJyvZ2NTq0bQUVa1dQb7movhkYZns9vg2MBwFJgBhJobK2U66vckbse4llHo
	 czDNFXkIADQkilGBEocmKDbBuWxUiZL0xIxidbjJwoU6hrgWMo3V2znrei4/eE+eVX
	 U9s6ZbNEr6qvA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: isaku.yamahata@intel.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 27/30] RFC: KVM: powerpc: Move processor
 compatibility check to hardware setup
In-Reply-To: <574ca90fdaec0f37c197d9600d47d48a74f324bd.1663869838.git.isaku.yamahata@intel.com>
References: <cover.1663869838.git.isaku.yamahata@intel.com>
 <574ca90fdaec0f37c197d9600d47d48a74f324bd.1663869838.git.isaku.yamahata@intel.com>
Date: Fri, 23 Sep 2022 16:58:41 +1000
Message-ID: <8735ci1sri.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: isaku.yamahata@intel.com, Huang Ying <ying.huang@intel.com>, Huacai Chen <chenhuacai@kernel.org>, Fabiano Rosas <farosas@linux.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Atish Patra <atishp@atishpatra.org>, Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org, isaku.yamahata@gmail.com, Chao Gao <chao.gao@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

isaku.yamahata@intel.com writes:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Move processor compatibility check from kvm_arch_processor_compat() into
                                          ^ 
                                          kvm_arch_check_processor_compat()

> kvm_arch_hardware_setup().  The check does model name comparison with a
> global variable, cur_cpu_spec.  There is no point to check it at run time
> on all processors.

A key detail I had to look up is that both kvm_arch_hardware_setup() and
kvm_arch_check_processor_compat() are called from kvm_init(), one after
the other. But the latter is called on each CPU.

And because the powerpc implementation of kvm_arch_check_processor_compat()
just checks a global, there's no need to call it on every CPU.

> kvmppc_core_check_processor_compat() checks the global variable.  There are
> five implementation for it as follows.

There are three implementations not five.

>   arch/powerpc/include/asm/cputable.h: extern struct cpu_spec *cur_cpu_spec;
>   arch/powerpc/kvm/book3s.c: return 0
>   arch/powerpc/kvm/e500.c: strcmp(cur_cpu_spec->cpu_name, "e500v2")
>   arch/powerpc/kvm/e500mc.c: strcmp(cur_cpu_spec->cpu_name, "e500mc")
>                              strcmp(cur_cpu_spec->cpu_name, "e5500")
>                              strcmp(cur_cpu_spec->cpu_name, "e6500")
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 7b56d6ccfdfb..31dc4f231e9d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -444,12 +444,12 @@ int kvm_arch_hardware_enable(void)
>  
>  int kvm_arch_hardware_setup(void *opaque)
>  {
> -	return 0;
> +	return kvmppc_core_check_processor_compat();
>  }
>  
>  int kvm_arch_check_processor_compat(void)
>  {
> -	return kvmppc_core_check_processor_compat();
> +	return 0;
>  }

The actual change seems OK. I gave it a quick test boot and ran some
VMs, everything seems to work as before.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
