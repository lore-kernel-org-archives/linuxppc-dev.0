Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 02:30:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A0F207E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 02:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qtRnfcDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A0F207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Fgw109vzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 13:30:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="qtRnfcDy"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Ff73dnVzDqSm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 13:29:18 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so377547plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=FiMPZLlW7yIaLuXHXXo3K4bY7ifrWaIje1CVelbo0pw=;
 b=qtRnfcDyN7es02/T90U5++gz5l4sfGK+UZimsZHTd3CbVcxPGCBye5DS9pTQWm6266
 FInof0YFfKOa0b1JK6v4X2mzSrfUEjokW7/d+oAeCLCLxYlrA3PjysimDZpTS8SjijZ+
 kNT8yCcmEfn9TfTubRWrxem5s3KDql62rK8DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=FiMPZLlW7yIaLuXHXXo3K4bY7ifrWaIje1CVelbo0pw=;
 b=TLXKlaAit+F3Di1Yell/RxS2Fl/qFR0wviJ45aTAasQKbxkHpBRPzkjYbbmOzOZqgC
 2/pjqoqqeuHXqXbvqtpGpUQqwgz4NoreU1wRGnGfp7BfRvuRcSmLvTWxRG8+Ht/RIxTM
 nh3BsKLaSW/zLQbFXtKbr2whRYpmvPVbsosqzFFiYiVi1UJnINX2dJdcJHdq6LwW8rOa
 OymxZMGkivsB23/q4dBl6vFAaWyutOdByRbEwgqGXKTSJFs8nUZ9Q6aicvB1vmtCGXc9
 oPi/gwP8FAJXKEtTqgd9r+C5CzFbdqbafKOGaZXFJi6Mpa/fjjNTEWmq74nBUIZ/BSaz
 j1Jg==
X-Gm-Message-State: AHQUAuZAWWMMOV/zBkPZSFKjb1l/h5F+8o6Sp2a7Q5vw9ThTcNc7nf6V
 akUNNJkPhXC4pGjb2ceLMSwR8A==
X-Google-Smtp-Source: AHgI3IYpRCJm1zdbfY8La38tPgAfHi+MqSPKF/+I1tBVLAtOeeu63a9xDTAx9ZZMUXkbr3mGqSgmiw==
X-Received: by 2002:a17:902:aa8d:: with SMTP id
 d13mr1729534plr.293.1550802557032; 
 Thu, 21 Feb 2019 18:29:17 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net.
 [121.45.196.25])
 by smtp.gmail.com with ESMTPSA id h3sm143778pgv.38.2019.02.21.18.29.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 18:29:15 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] powerpc: Enable kcov
In-Reply-To: <20190222004046.14914-2-andrew.donnellan@au1.ibm.com>
References: <20190222004046.14914-1-andrew.donnellan@au1.ibm.com>
 <20190222004046.14914-2-andrew.donnellan@au1.ibm.com>
Date: Fri, 22 Feb 2019 13:29:12 +1100
Message-ID: <87lg28369z.fsf@dja-thinkpad.axtens.net>
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
Cc: npiggin@gmail.com, syzkaller@googlegroups.com, dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Andrew,

> kcov provides kernel coverage data that's useful for fuzzing tools like
> syzkaller.
>
> Wire up kcov support on powerpc. Disable kcov instrumentation on the same
> files where we currently disable gcov and UBSan instrumentation, plus some
> additional exclusions which appear necessary to boot on book3e machines.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Tested-by: Daniel Axtens <dja@axtens.net> # e6500

Just confirming that this still works for me.

Regards,
Daniel

> ---
>
> v2->v3:
> - Add additional exclusions required to boot on book3e (dja)
> ---
>  arch/powerpc/Kconfig                |  1 +
>  arch/powerpc/kernel/Makefile        | 12 +++++++++++-
>  arch/powerpc/kernel/trace/Makefile  |  3 ++-
>  arch/powerpc/kernel/vdso32/Makefile |  1 +
>  arch/powerpc/kernel/vdso64/Makefile |  1 +
>  arch/powerpc/mm/Makefile            |  5 +++++
>  arch/powerpc/xmon/Makefile          |  1 +
>  7 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2890d36eb531..d3698dae0e60 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -134,6 +134,7 @@ config PPC
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_KCOV
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API                if PPC64
>  	select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index cb7f0bb9ee71..3ae079014c04 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -142,19 +142,29 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>  
> -# Disable GCOV & sanitizers in odd or sensitive code
> +# Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> +KCOV_INSTRUMENT_prom_init.o := n
>  UBSAN_SANITIZE_prom_init.o := n
>  GCOV_PROFILE_machine_kexec_64.o := n
> +KCOV_INSTRUMENT_machine_kexec_64.o := n
>  UBSAN_SANITIZE_machine_kexec_64.o := n
>  GCOV_PROFILE_machine_kexec_32.o := n
> +KCOV_INSTRUMENT_machine_kexec_32.o := n
>  UBSAN_SANITIZE_machine_kexec_32.o := n
>  GCOV_PROFILE_kprobes.o := n
> +KCOV_INSTRUMENT_kprobes.o := n
>  UBSAN_SANITIZE_kprobes.o := n
>  GCOV_PROFILE_kprobes-ftrace.o := n
> +KCOV_INSTRUMENT_kprobes-ftrace.o := n
>  UBSAN_SANITIZE_kprobes-ftrace.o := n
>  UBSAN_SANITIZE_vdso.o := n
>  
> +# Necessary for booting with kcov enabled on book3e machines
> +KCOV_INSTRUMENT_cputable.o := n
> +KCOV_INSTRUMENT_setup_64.o := n
> +KCOV_INSTRUMENT_paca.o := n
> +
>  extra-$(CONFIG_PPC_FPU)		+= fpu.o
>  extra-$(CONFIG_ALTIVEC)		+= vector.o
>  extra-$(CONFIG_PPC64)		+= entry_64.o
> diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
> index b1725ad3e13d..858503775c58 100644
> --- a/arch/powerpc/kernel/trace/Makefile
> +++ b/arch/powerpc/kernel/trace/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_TRACING)			+= trace_clock.o
>  obj-$(CONFIG_PPC64)			+= $(obj64-y)
>  obj-$(CONFIG_PPC32)			+= $(obj32-y)
>  
> -# Disable GCOV & sanitizers in odd or sensitive code
> +# Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_ftrace.o := n
> +KCOV_INSTRUMENT_ftrace.o := n
>  UBSAN_SANITIZE_ftrace.o := n
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
> index 50112d4473bb..ce199f6e4256 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -23,6 +23,7 @@ targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
>  obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
>  
>  GCOV_PROFILE := n
> +KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>  
>  ccflags-y := -shared -fno-common -fno-builtin
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 69cecb346269..28e7d112aa2f 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -9,6 +9,7 @@ targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
>  obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
>  
>  GCOV_PROFILE := n
> +KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>  
>  ccflags-y := -shared -fno-common -fno-builtin
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index f965fc33a8b7..d4d32e229ace 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -55,3 +55,8 @@ obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
>  endif
>  obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
>  obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
> +
> +# Disable kcov instrumentation on sensitive code
> +# This is necessary for booting with kcov enabled on book3e machines
> +KCOV_INSTRUMENT_tlb_nohash.o := n
> +KCOV_INSTRUMENT_fsl_booke_mmu.o := n
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index 878f9c1d3615..3050f9323254 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -5,6 +5,7 @@
>  subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
>  
>  GCOV_PROFILE := n
> +KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
>  
>  # Disable ftrace for the entire directory
> -- 
> 2.11.0
