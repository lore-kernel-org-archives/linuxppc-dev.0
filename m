Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65592C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:28:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E6D21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 04:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="e+m8Gf+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E6D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4444N90b5jzDqKR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 15:28:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="e+m8Gf+G"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4444LV44gtzDqFY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 15:26:41 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id v28so11186927pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 20:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=9MynePvsPVk8X1P+uxZdw9Bz1lOhE8N74d9cqj+mXSY=;
 b=e+m8Gf+GGWnGdjQP1/UA4ZCrphfdFtKDoMk0PZNMvjfmOlpdOmiyNfAeo7nSrq8LcI
 KMGreXhic6InZaokdfHGr0mj5OT9Oz96oQUiLTA/eCH2EyQbfwWL341x2MW3qFFl31vI
 XIYKA8LBX6vYPyiS/b2XZcazbXDNAORxGW+IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=9MynePvsPVk8X1P+uxZdw9Bz1lOhE8N74d9cqj+mXSY=;
 b=pZ4qxOI7aPocOh6KZEGkem8xHcZ6bpm1zlkJWf4xn6G1PnmUBKll3Gvfo6+ug9IMQI
 hVqGs3nKxhFwmDrY7jagmDjWTgKHxm9PrkNbQOCYSl0ia1GMQRseobceYo2ZBhbItuyZ
 pR8c6oMgvqdgkB6zN0V2M760p8iAVIaxU7ZDpL6yTFnMyfFQ4W2xU1kF6q6YGGRBPu66
 gOptIubeh6nJnuOn+DSHa+IWFJcNc4i3/I81nYmgLeZBjIeGWUo7Z4sL4KQR8NoKlDCR
 DiuNDi0OU9lo0pqOm0Cj70sR0YOJjCaV5ffypTCeI83Q1OSajHeyrUP5GSPyfn3e8Wlz
 Hl4w==
X-Gm-Message-State: AHQUAuZZGoTMEd/nIKMUNbBU+/xzJU/R9pzcBhTB706W6n+wGcgLeRG1
 7v8pFxE32cfYDdkItMoxGHf2Tw==
X-Google-Smtp-Source: AHgI3IZ5FgVj3D4jqTKuaGAvXPaMrG1sRWUXLlc8aEFU/AB3UzkJDDVStVDjcsGEFCVcc+AvpQKKrA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr26414372pge.93.1550636799053; 
 Tue, 19 Feb 2019 20:26:39 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net.
 [121.45.196.25])
 by smtp.gmail.com with ESMTPSA id 1sm39710379pfy.68.2019.02.19.20.26.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 20:26:38 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc: Enable kcov
In-Reply-To: <20190211002002.26038-2-andrew.donnellan@au1.ibm.com>
References: <20190211002002.26038-1-andrew.donnellan@au1.ibm.com>
 <20190211002002.26038-2-andrew.donnellan@au1.ibm.com>
Date: Wed, 20 Feb 2019 15:26:33 +1100
Message-ID: <87o9772ih2.fsf@dja-thinkpad.axtens.net>
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
Cc: syzkaller@googlegroups.com, dvyukov@google.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Andrew,

> kcov provides kernel coverage data that's useful for fuzzing tools like
> syzkaller.
>
> Wire up kcov support on powerpc. Disable kcov instrumentation on the same
> files where we currently disable gcov and UBSan instrumentation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

I needed the following diff to get this booting on a T4240RDB:

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 961f44eabb65..fbe9894d6305 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -3,6 +3,10 @@
 # Makefile for the linux kernel.
 #
 
+KCOV_INSTRUMENT_cputable.o := n
+KCOV_INSTRUMENT_setup_64.o := n
+KCOV_INSTRUMENT_paca.o := n
+
 CFLAGS_ptrace.o                += -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 # Disable clang warning for using setjmp without setjmp.h header
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f965fc33a8b7..0140e7e12c29 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -5,6 +5,9 @@
 
 ccflags-$(CONFIG_PPC64)        := $(NO_MINIMAL_TOC)
 
+KCOV_INSTRUMENT_tlb_nohash.o := n
+KCOV_INSTRUMENT_fsl_booke_mmu.o := n
+
 CFLAGS_REMOVE_slb.o = $(CC_FLAGS_FTRACE)
 
 obj-y                          := fault.o mem.o pgtable.o mmap.o \


The change to kernel/ is required to get the kernel to even begin to
boot, and the change to mm/ is required to successfully set up SMP. I'm
not sure preciesly why they cause issues.

I was then able to run kcovtrace and the results seem to make sense.

Perhaps in the future some further stuff should be trimmed down to make
the coverage results less noisy (restore_math is probably not telling us
anything interesting, for example), but certainly this is a great start.

With those changes,
Tested-by: Daniel Axtens <dja@axtens.net> # e6500

Regards,

> ---
>  arch/powerpc/Kconfig                | 1 +
>  arch/powerpc/kernel/Makefile        | 7 ++++++-
>  arch/powerpc/kernel/trace/Makefile  | 3 ++-
>  arch/powerpc/kernel/vdso32/Makefile | 1 +
>  arch/powerpc/kernel/vdso64/Makefile | 1 +
>  arch/powerpc/xmon/Makefile          | 1 +
>  6 files changed, 12 insertions(+), 2 deletions(-)
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
> index cb7f0bb9ee71..961f44eabb65 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -142,16 +142,21 @@ endif
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
