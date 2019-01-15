Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39214C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:41:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067B2208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dhmiZ+WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B2208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fQL8623pzDqW1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 09:41:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dhmiZ+WR"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fQJB3z6JzDqMr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 09:39:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fQJ6093Mz9ttKn;
 Tue, 15 Jan 2019 23:39:34 +0100 (CET)
Authentication-Results: localhost; dkim=permerror reason="key not found"
 header.d=c-s.fr header.i=@c-s.fr header.b=dhmiZ+WR;
 dkim-adsp=none (insecure policy); dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IW2boG6ihUBn; Tue, 15 Jan 2019 23:39:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fQJ5642Dz9ttJy;
 Tue, 15 Jan 2019 23:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547591973; bh=KyVsLshj7W3Ai64l/81iUTI7SdtWvz1JwalwsVimGtk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dhmiZ+WR6XA3bAdULITCXsnmnEupDYaF7At49NrDEKJT/U1X+jdl1V1n1WG1e+HNc
 CobWjKoF3bGQEMODCx/1t1t2Rvagr8ttTt29tx2DL2546TvOTZWieheLKRezbM/Sct
 e+yExQHBVUA5QB25dZOQh+77vm/bvPEWvsQFPFRc/anbgJU/pCWWlZVE7WA5JBwRPG
 UOuns3RwWOn3Fv20QthP8J0o/evNmP3GWeezqtgX3RRYCEMZxND8/xpDPqoJsY8/4H
 7qQPXYzBcezM3+KxcNu2B9wfUmjTEOwsVnX2R+SYJ71WB6C3eF7ThWmRwJIAB1NIdo
 ml9pJTAervxn9ehV0kBcvtIR7BpbZu2OTGAZJEpfEYidjOSU29KDgVTtb5Fof4c5hO
 yENy4/e8g05c1HCeOuYvjcmzHM6ZfZsvusQ2w0RugBmQnxgkMLZGyZGKB4KA15ielv
 MXK3M5HcPMB7NgTOStfmA2ma5hnVtjOIX084luqDgYN9w5/jg+TVP7YVhSfb1y5FgM
 SchSRbbyUv3zhjkuY0EsVzz+mvNy28ELA+Umb08MAo5cPuzvQRjGhlAjyWpqazSQm7
 yA/2iHyebY79Do29TqPisU5g7lsBKoPFdZa/hd53LFz2nQJcsqsDsaxkHmOTtqAXQn
 voObWjc9tncLuFSLQX5eU2HM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E31C8B801;
 Tue, 15 Jan 2019 23:39:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id f9TCxI0y2mEB; Tue, 15 Jan 2019 23:39:34 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AC6D38B7FF;
 Tue, 15 Jan 2019 23:39:33 +0100 (CET)
Subject: Re: gcc 6.3 vs 8.2 Re: [RFC PATCH] powerpc: Enable kcov
To: Mathieu Malaterre <malat@debian.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
 <CA+7wUsy5xbp_t4fiEUw9C0HKQ8GohcBJZkj8qZnna5990Gm1-w@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ea8a051c-481d-ef97-7d1d-8621f194e41e@c-s.fr>
Date: Tue, 15 Jan 2019 23:39:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUsy5xbp_t4fiEUw9C0HKQ8GohcBJZkj8qZnna5990Gm1-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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



Le 15/01/2019 à 08:26, Mathieu Malaterre a écrit :
> [Sorry to hijack this thread. ]
> 
> On Tue, Jan 15, 2019 at 5:22 AM Andrew Donnellan
> <andrew.donnellan@au1.ibm.com> wrote:
>>
>> kcov provides kernel coverage data that's useful for fuzzing tools like
>> syzkaller.
>>
>> Wire up kcov support on powerpc. Disable kcov instrumentation on the same
>> files where we currently disable gcov and UBSan instrumentation.
>>
>> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>
>> ---
>>
>> kcov looks like it's working okay, both kcovtrace and syzkaller seem to be
>> working. I did see some issues with compiling and booting kernels with gcc
>> 6.3 and earlier versions which disappeared when I upgraded to gcc 8.2, I
>> need to investigate that more.
> 
> This is also my setup. Would you be able to tell why I get a kconfig
> option loop when using gcc 8.2 which I cannot reproduce using gcc 6.3
> ?
> 
> gcc 6-3 is ok doing:
> 
> $ make ARCH=powerpc custom_defconfig
> $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> 
> while gcc 8.2 leads to (linux/master):
> 
> ...
> $ make ARCH=powerpc custom_defconfig
> $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
>    GEN     Makefile
> scripts/kconfig/conf  --syncconfig Kconfig
> *
> * Restart config...
> *
> *
> * General architecture-dependent options
> *
> OProfile system profiling (OPROFILE) [M/n/y/?] m
> Kprobes (KPROBES) [Y/n/?] y
> Optimize very unlikely/likely branches (JUMP_LABEL) [N/y/?] n
> Stack Protector buffer overflow detection (STACKPROTECTOR) [Y/n/?] (NEW)
> ...
> 
> I did check that `custom_defconfig` is the minimal defconfig generated
> by `savedefconfig` in both cases.
> 
> Hints or comments welcome, thanks much.

I think you should do:

make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- custom_defconfig
make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

Christophe

> 
>> ---
>>   arch/powerpc/Kconfig                | 1 +
>>   arch/powerpc/kernel/Makefile        | 7 ++++++-
>>   arch/powerpc/kernel/trace/Makefile  | 3 ++-
>>   arch/powerpc/kernel/vdso32/Makefile | 1 +
>>   arch/powerpc/kernel/vdso64/Makefile | 1 +
>>   arch/powerpc/xmon/Makefile          | 1 +
>>   6 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 2890d36eb531..d3698dae0e60 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -134,6 +134,7 @@ config PPC
>>          select ARCH_HAS_ELF_RANDOMIZE
>>          select ARCH_HAS_FORTIFY_SOURCE
>>          select ARCH_HAS_GCOV_PROFILE_ALL
>> +       select ARCH_HAS_KCOV
>>          select ARCH_HAS_PHYS_TO_DMA
>>          select ARCH_HAS_PMEM_API                if PPC64
>>          select ARCH_HAS_PTE_SPECIAL
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index cb7f0bb9ee71..961f44eabb65 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -142,16 +142,21 @@ endif
>>   obj-$(CONFIG_EPAPR_PARAVIRT)   += epapr_paravirt.o epapr_hcalls.o
>>   obj-$(CONFIG_KVM_GUEST)                += kvm.o kvm_emul.o
>>
>> -# Disable GCOV & sanitizers in odd or sensitive code
>> +# Disable GCOV, KCOV & sanitizers in odd or sensitive code
>>   GCOV_PROFILE_prom_init.o := n
>> +KCOV_INSTRUMENT_prom_init.o := n
>>   UBSAN_SANITIZE_prom_init.o := n
>>   GCOV_PROFILE_machine_kexec_64.o := n
>> +KCOV_INSTRUMENT_machine_kexec_64.o := n
>>   UBSAN_SANITIZE_machine_kexec_64.o := n
>>   GCOV_PROFILE_machine_kexec_32.o := n
>> +KCOV_INSTRUMENT_machine_kexec_32.o := n
>>   UBSAN_SANITIZE_machine_kexec_32.o := n
>>   GCOV_PROFILE_kprobes.o := n
>> +KCOV_INSTRUMENT_kprobes.o := n
>>   UBSAN_SANITIZE_kprobes.o := n
>>   GCOV_PROFILE_kprobes-ftrace.o := n
>> +KCOV_INSTRUMENT_kprobes-ftrace.o := n
>>   UBSAN_SANITIZE_kprobes-ftrace.o := n
>>   UBSAN_SANITIZE_vdso.o := n
>>
>> diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
>> index b1725ad3e13d..858503775c58 100644
>> --- a/arch/powerpc/kernel/trace/Makefile
>> +++ b/arch/powerpc/kernel/trace/Makefile
>> @@ -23,6 +23,7 @@ obj-$(CONFIG_TRACING)                 += trace_clock.o
>>   obj-$(CONFIG_PPC64)                    += $(obj64-y)
>>   obj-$(CONFIG_PPC32)                    += $(obj32-y)
>>
>> -# Disable GCOV & sanitizers in odd or sensitive code
>> +# Disable GCOV, KCOV & sanitizers in odd or sensitive code
>>   GCOV_PROFILE_ftrace.o := n
>> +KCOV_INSTRUMENT_ftrace.o := n
>>   UBSAN_SANITIZE_ftrace.o := n
>> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
>> index 50112d4473bb..ce199f6e4256 100644
>> --- a/arch/powerpc/kernel/vdso32/Makefile
>> +++ b/arch/powerpc/kernel/vdso32/Makefile
>> @@ -23,6 +23,7 @@ targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
>>   obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
>>
>>   GCOV_PROFILE := n
>> +KCOV_INSTRUMENT := n
>>   UBSAN_SANITIZE := n
>>
>>   ccflags-y := -shared -fno-common -fno-builtin
>> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
>> index 69cecb346269..28e7d112aa2f 100644
>> --- a/arch/powerpc/kernel/vdso64/Makefile
>> +++ b/arch/powerpc/kernel/vdso64/Makefile
>> @@ -9,6 +9,7 @@ targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
>>   obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
>>
>>   GCOV_PROFILE := n
>> +KCOV_INSTRUMENT := n
>>   UBSAN_SANITIZE := n
>>
>>   ccflags-y := -shared -fno-common -fno-builtin
>> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
>> index 878f9c1d3615..3050f9323254 100644
>> --- a/arch/powerpc/xmon/Makefile
>> +++ b/arch/powerpc/xmon/Makefile
>> @@ -5,6 +5,7 @@
>>   subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
>>
>>   GCOV_PROFILE := n
>> +KCOV_INSTRUMENT := n
>>   UBSAN_SANITIZE := n
>>
>>   # Disable ftrace for the entire directory
>> --
>> 2.11.0
>>
