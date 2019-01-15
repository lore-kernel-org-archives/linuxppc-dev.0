Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37713C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:43:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DAE20859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ypb9IXpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DAE20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f15D3Kf0zDqc3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:43:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d43; helo=mail-io1-xd43.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Ypb9IXpq"; 
 dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f12C71SlzDqjG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 17:41:07 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id t24so1283423ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 22:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TkNY5HPD0ktz7aiARJ4ys+DVJnTbcayhI0qVYKg1E7U=;
 b=Ypb9IXpqakd72fbgVbU1YPzcB/PiC6ZfpWT4ZQ9Jpw48f/k5tVU+9L1Ib+naRtdENp
 It2nOy6k6LsLdH7MB5KQkGyXBZntbwljmJck+en4k4odEVz65GZ6rA4FVyUkkUjH0XOo
 PzT/mUg2AF/DXngBWWXgFNFl8c7zQfBmu8CcDLixdr7ATCGpDNIIr6PdO1F6Dn3FnS1V
 uNQijjMQMZvQzuPMxc7AgG5q+tqXFC0Xs1n+BsmncCWZfgwmrc17BEHnl9Ww1u6j3TsR
 V4gJUVpa6Sjqa5RvT/On0MEcBroUmGbllozu7ZFqywUzpOnP6WbUG/u/2XzcalcxENGe
 FPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TkNY5HPD0ktz7aiARJ4ys+DVJnTbcayhI0qVYKg1E7U=;
 b=gDqkbl89UCM03SDhHPGDGU9H22uG1E0lCeOn8i/Lhz4psP5u2/TL6F2Ch6HhbCu+4O
 C+Up38xfriCYP/U/HZftqJmXgnUzZ8qVRMUNuz2rVwqwUxefP/uxoxEUoJo+mPllZxy3
 JzkoDSJx/LMg+0MNYSFB3IWa86Of1jKZXR9bLUTYRHjhbLNKRcWMLwmEuFMlkHe8qtUz
 i6Yu4SoIuyY0pPsCotik5scQoyt97swD4Hl/olYHxW92vYPnFQpzG8y7X8/PsvM45iqI
 MA/dDnTONZOCg2EBYNiu4NVgzOqMaXlU8sQ/3mcBQr/sm4G0Nqgd91eVdPo4dMjsqOuK
 yYZw==
X-Gm-Message-State: AJcUukeguZpIxzQQMMvLhzdpnE0gZfpKiEA5wz7f/utQuuqiick/5+jj
 6F7Vr+C1cbPRiRmnG4KbiD5fKpSVXm8r1yRz63Kv4w==
X-Google-Smtp-Source: ALg8bN5V39EHF5H/wRSp6O++DJSHgYOjqDTd3PruCQkEAPCA1xGXLvPffRT8BfiDbQwvC5EMI63W2xJ9tIM27Vz1qlk=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr1063581ioh.271.1547534465678; 
 Mon, 14 Jan 2019 22:41:05 -0800 (PST)
MIME-Version: 1.0
References: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
In-Reply-To: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 15 Jan 2019 07:40:52 +0100
Message-ID: <CACT4Y+ZBKWB1FdF9uiSu11-SpGVx0yy=OJaF9-R4u+Nrdy6e_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Enable kcov
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: syzkaller <syzkaller@googlegroups.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 15, 2019 at 5:20 AM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
>
> kcov provides kernel coverage data that's useful for fuzzing tools like
> syzkaller.
>
> Wire up kcov support on powerpc. Disable kcov instrumentation on the same
> files where we currently disable gcov and UBSan instrumentation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Hi Andrew,

The patch looks good to me. Any reason to mail it as RFC rather than
final patch?

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>
> kcov looks like it's working okay, both kcovtrace and syzkaller seem to be
> working. I did see some issues with compiling and booting kernels with gcc
> 6.3 and earlier versions which disappeared when I upgraded to gcc 8.2, I
> need to investigate that more.
>
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
>         select ARCH_HAS_ELF_RANDOMIZE
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_GCOV_PROFILE_ALL
> +       select ARCH_HAS_KCOV
>         select ARCH_HAS_PHYS_TO_DMA
>         select ARCH_HAS_PMEM_API                if PPC64
>         select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index cb7f0bb9ee71..961f44eabb65 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -142,16 +142,21 @@ endif
>  obj-$(CONFIG_EPAPR_PARAVIRT)   += epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)                += kvm.o kvm_emul.o
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
> @@ -23,6 +23,7 @@ obj-$(CONFIG_TRACING)                 += trace_clock.o
>  obj-$(CONFIG_PPC64)                    += $(obj64-y)
>  obj-$(CONFIG_PPC32)                    += $(obj32-y)
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
