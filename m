Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B681C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 07:28:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8819820859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 07:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8819820859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f2503FDvzDqdV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 18:28:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f23B61GPzDq9p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 18:27:02 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id v6so1403791oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 23:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zdbPFLnCKUfwy2sH2tvFvFg2xzQVow647shAKo81L9c=;
 b=GP8+PfaOKa2B5n+c0eLdkjKlEI3tEJCPhu4cw9VYwZGCDaofeOpjX1ULLFdtco5zgB
 1kdW5mNoOZMojEEeHhRunt5iYRIa1jbyPpVPDsflwXQDAox4NKT70TBK2KwW7Tpclxbs
 dhcvY++bry03yyWxkH9+oKq47/7Bk5w9uPtAafH7P8sAjk418IYCE7iotKFY1bj8NW0Y
 tYGRFZHRIfpSxid25uRI0ZMBJ1/3YwtiS4PaaCChlU2OFXwcRuU/qTWbNje7wK7fTLnr
 K1PkxzC0eIuDbwuiMQbVT2Al44gjt/3+FHmifWa7dku7OfBZQE6YVJoYkmhEYPwGoeGp
 e4/Q==
X-Gm-Message-State: AJcUukcEb9WwkMzEkQYS4YWCnpWHy9kKOaKG1hkN1ygvedF1b4X23WDt
 jmNu4zLEk/O0N3NYL5cjJnUlVZk45PDozZKYXGWYpE9A
X-Google-Smtp-Source: ALg8bN7E2hd3oWsk2msisMfw+WyLsd2gsCXa5/KVmbxXTqIz2ra2fg889U2NOr5B5ZiZCgvSaK7wrPlAra2Qn85QfhU=
X-Received: by 2002:a05:6808:13:: with SMTP id
 u19mr1327640oic.57.1547537220511; 
 Mon, 14 Jan 2019 23:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
In-Reply-To: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 15 Jan 2019 08:26:48 +0100
Message-ID: <CA+7wUsy5xbp_t4fiEUw9C0HKQ8GohcBJZkj8qZnna5990Gm1-w@mail.gmail.com>
Subject: gcc 6.3 vs 8.2 Re: [RFC PATCH] powerpc: Enable kcov
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[Sorry to hijack this thread. ]

On Tue, Jan 15, 2019 at 5:22 AM Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
>
> kcov provides kernel coverage data that's useful for fuzzing tools like
> syzkaller.
>
> Wire up kcov support on powerpc. Disable kcov instrumentation on the same
> files where we currently disable gcov and UBSan instrumentation.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> kcov looks like it's working okay, both kcovtrace and syzkaller seem to be
> working. I did see some issues with compiling and booting kernels with gcc
> 6.3 and earlier versions which disappeared when I upgraded to gcc 8.2, I
> need to investigate that more.

This is also my setup. Would you be able to tell why I get a kconfig
option loop when using gcc 8.2 which I cannot reproduce using gcc 6.3
?

gcc 6-3 is ok doing:

$ make ARCH=powerpc custom_defconfig
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

while gcc 8.2 leads to (linux/master):

...
$ make ARCH=powerpc custom_defconfig
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
  GEN     Makefile
scripts/kconfig/conf  --syncconfig Kconfig
*
* Restart config...
*
*
* General architecture-dependent options
*
OProfile system profiling (OPROFILE) [M/n/y/?] m
Kprobes (KPROBES) [Y/n/?] y
Optimize very unlikely/likely branches (JUMP_LABEL) [N/y/?] n
Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] (NEW)
...

I did check that `custom_defconfig` is the minimal defconfig generated
by `savedefconfig` in both cases.

Hints or comments welcome, thanks much.

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
