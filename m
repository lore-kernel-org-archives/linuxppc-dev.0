Return-Path: <linuxppc-dev+bounces-23221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5FDC44500
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:32:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqRwD2R4Gz2yft;
	Wed, 01 Jul 2026 01:32:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782833532;
	cv=none; b=LatVBilEAHOs7W/rhHS6VtSamCG7iM/dyy4izRx8HJxGLBUTxO/Qc1EGjTs1Euy6GAV16t+sJ1BZWyv28NZUZouMhKifrmSFAUakU74SyOpXaWP/ottE/eTecC+LC39Vl/ETAPNB0fbpOsqN7wR6TbIb8B/fgi4GeAs4njq/8HQVb3DwWYwCz35CB+0pCRCu4oPBokFgmKdFgu9nbYOiSB4sYiZ50kRukYFh8IfQR5/UAYA1muo8x8fe1RTljUwzJEovQ2OxSJon6Anbv1LW4KAuEcDoFpc6Bo8OiEytRIYfJa2ivmvl6rBIcUoKEt/HeNA0fcpD12572ohtl42UCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782833532; c=relaxed/relaxed;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbyGXKGsKCrxCBJGT2yVMbk61jB9dnOaW027ZhJzRjvWibKrJYCZ07Sj5vCXeqImBKndHNYKzGWpWmZ8VVNtTYTtbChBGrLa+wxmEY0xVnN3ATRGTxSHjfuX5gnpCK1zE/lKsJ+oqOiR6MSO3an0/jAg2EfGD07wYTisBr18j4sF8NLUsAFr0/GCJ4C2ckRU1tLr5M2GSXSzuI6zFtJVB9MhB+aQpxsKyS4Wqq6s16N2ctBaEXZ2RVR3YGS3WJ0q7xX8y7Mk1YojySJoDRdBIhmS9c067JPUdEyte3IPXRfcnj+oNd0Gw1894U11u6WKgJ70TMCAm3ZXgV8akvxtoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qu/1s0nH; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vVSU3b5g; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=qu/1s0nH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vVSU3b5g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqRwC2Wpvz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:32:11 +1000 (AEST)
Date: Tue, 30 Jun 2026 17:32:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782833526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=;
	b=qu/1s0nHQC6KFpDGuKrxXJLqBTdl1FoH/4yCYl34ohT2guoTuARwKQEULMNqdYWydigyrj
	UQsxj+D6QvmsMUbHcM7u3rM86IjWKPJT39xqCzzGIvsLgqe2Hz4HBOvbz7iysNXKPy5W/u
	R/GUuEzOAf1ZZdsDdNL4Jr6q/bCrdt9+3kstOwvKETmQg7hIqCfC8XESzPiKTthZJ9Oc09
	xpBcumA8KxG/PCdAqz4l1iGj82SI/tB9ALWL8NP8tofOtWsr179TrHBkKBYCmCED0scKGL
	24UnriDqIvgBJ16vM4xBQFbAgoL54zsV+WuM26JgtD+5w8qeomuxalv2Kqf/NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782833526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdsRgNbVkI3Xb/bXMSfj+yw5lewzrynD2xqGGnGzV8Y=;
	b=vVSU3b5gGX9pyXfPgfu3YTbbfDnrmDCkQKRUwm+vxUCIXLFG0mbsTHQglZDx4c5OUPi7Tu
	n00gEBCaZoE4kFBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	peterz@infradead.org, wad@chromium.org, thuth@redhat.com, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com, 
	song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com, 
	broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com, 
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de, sohil.mehta@intel.com, 
	andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
Message-ID: <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
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
In-Reply-To: <20260629130616.642022-19-ruanjinjie@huawei.com>

On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
> Syscall User Dispatch (SUD) requires the signal trampoline code to not be
> intercepted. This is necessary to support returning with a locked selector
> while avoiding infinite recursion back into the signal handler.
> 
> Implement arch_syscall_is_vdso_sigreturn() for arm64 to support this
> exclusion mechanism. For native 64-bit tasks, it checks whether the current
> PC matches the 'svc #0' instruction inside the vDSO sigreturn trampoline.
> 
> 	SYM_CODE_START(__kernel_rt_sigreturn)
> 	        mov     x8, #__NR_rt_sigreturn
> 	        svc     #0
> 	SYM_CODE_END(__kernel_rt_sigreturn)
> 
> For COMPAT tasks, it verifies if the instruction falls within
> the architecture's 'sigpage' range, allowing the kernel to safely bypass
> dispatching syscalls originating from these areas back to userspace.
> 
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: kemal <kmal@cock.li>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/include/asm/elf.h |  1 +
>  arch/arm64/kernel/vdso.c     | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index d2779d604c7b..f43d4dea916a 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -185,6 +185,7 @@ do {									\
>  struct linux_binprm;
>  extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  				       int uses_interp);
> +extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);

A header for that?

>  /* 1GB of VA */
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 592dd8668de4..5a0314a3c26e 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  
>  	return ret;
>  }
> +
> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	unsigned long sigtramp;
> +
> +#ifdef CONFIG_COMPAT
> +	if (is_compat_task()) {
> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
> +
> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
> +	}
> +#endif
> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> +
> +	return regs->pc == (sigtramp + 8);

Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
instruction and use that with VDSO_SYMBOL().


Thomas

