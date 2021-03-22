Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E44C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 17:54:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BCD61974
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 17:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BCD61974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F42Dr65zkz30Dh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 04:54:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=GD0yghqn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2d;
 helo=mail-yb1-xb2d.google.com; envelope-from=andrii.nakryiko@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GD0yghqn; dkim-atps=neutral
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F42DN3Lgwz301l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 04:53:37 +1100 (AEDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 8so7483646ybc.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LDxueTAdL2AWLL01bMdPUnnD4HpNdzZ8wxBaFyudbww=;
 b=GD0yghqnscxyOcEfRGbu64M3NgeRrenUULJiEi5bCLXNE3wNB54a0uKIwAzyRLE79Q
 i7Psp/g1lRRzYuPcpO1EYWr6pPnrDf8CYcbLJZXFAyhlMZPs20msacukrWM+V8klkGBn
 S7GEp+0D24bDkhJjS/7j7nsC4HJUVPutq8aobGVCiGcQRiMDsENSWwK3nZiakusrfzNh
 StTlo3VkkAAojKRwNXTB/lHkD8xigej+brwiTtfDoiWMwAiEIEboHv1vNEriHsBi7lFw
 U9Xc5vGW7AODw0+EPj2Iq3WFH5teenIb5l0iSeGD3aYFHD6lQ0fUd9OR52Bn3n16zcq0
 takQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LDxueTAdL2AWLL01bMdPUnnD4HpNdzZ8wxBaFyudbww=;
 b=DIlCnYMKbNSiIn8L1ysSmzc0hBusI+iDt8C4D8/V7vitc9uQbkNUYPAcuNBJnF4tFO
 C5aVdTDwmweVSV2eQQCtsA4cK2UAbmON4X2qVPNQM41B55J5YWRwloXOP9qGGoj/ZwT0
 fsCYI8WIKaSR/CYKv4WFLOS/3NbkO4WLYkIEDnk7gqq+SsK42qrToMGdwWNhC9UEgQY7
 D9h4d9Q3DEFplOsRdu33eFAKghsbCmqc5KlkdinSYWBeRpXKvXBEodKsmCOcx3AlrS+/
 slbkLrfjebnSaz8I+lHeheAiagRQTBlkMYjGxT7V+y6IpmFXdffAQz5SkQX8UP9dMkmP
 hcrQ==
X-Gm-Message-State: AOAM530OauTl8OftrqkY4jvc8WHqw/AsM0Posr7k+7LFQSFyEbhtNJIP
 LAtK6AsL9gaNPRmUyjHrOcAhX55HdFQXAclFwco=
X-Google-Smtp-Source: ABdhPJzfCsjWCQu7sHhVGimfTT+JwVEP97RTB0MeZGcbm/du73/RGc8gfc2AFNRyR0lZZU+NaCM++NpLD/IRCN5iUdc=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr838725ybc.425.1616435614417;
 Mon, 22 Mar 2021 10:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616430991.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616430991.git.christophe.leroy@csgroup.eu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Mar 2021 10:53:23 -0700
Message-ID: <CAEf4BzZjNK_La1t5FGyie02FCABBieZJod49rW4=WtMs7ELLSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Implement EBPF on powerpc32
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 john fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, naveen.n.rao@linux.ibm.com,
 Networking <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 sandipan@linux.ibm.com, KP Singh <kpsingh@chromium.org>,
 Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Martin Lau <kafai@fb.com>,
 open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 22, 2021 at 9:37 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This series implements extended BPF on powerpc32. For the implementation
> details, see the patch before the last.
>
> The following operations are not implemented:
>
>                 case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
>                 case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
>                 case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) += src */
>
> The following operations are only implemented for power of two constants:
>
>                 case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
>                 case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
>
> Below are the results on a powerpc 885:
> - with the patch, with and without bpf_jit_enable
> - without the patch, with bpf_jit_enable (ie with CBPF)
>
> With the patch, with bpf_jit_enable = 1 :
>
> [   60.826529] test_bpf: Summary: 378 PASSED, 0 FAILED, [354/366 JIT'ed]
> [   60.832505] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
> With the patch, with bpf_jit_enable = 0 :
>
> [   75.186337] test_bpf: Summary: 378 PASSED, 0 FAILED, [0/366 JIT'ed]
> [   75.192325] test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
>
> Without the patch, with bpf_jit_enable = 1 :
>
> [  186.112429] test_bpf: Summary: 371 PASSED, 7 FAILED, [119/366 JIT'ed]
>
> Couldn't run test_progs because it doesn't build (clang 11 crashes during the build).

Can you please try checking out the latest clang from sources and use
that one instead?

>
> Changes in v2:
> - Simplify 16 bits swap
> - Rework tailcall, use stack for tailcall counter
> - Fix handling of BPF_REG_FP:
>   - must be handler like any other register allthough only the lower 32 bits part is used as a pointer.
>   - r18 was TMP_REG, r17/r18 become de BPF_REG_FP
>   - r31 was BPF_REG_FP, it is now TMP_REG
> - removed bpf_jit32.h
> - Reorder register allocation dynamically to use the volatile registers as much as possible when not doing function calls (last patch - new)
>
> Christophe Leroy (8):
>   powerpc/bpf: Remove classical BPF support for PPC32
>   powerpc/bpf: Change register numbering for bpf_set/is_seen_register()
>   powerpc/bpf: Move common helpers into bpf_jit.h
>   powerpc/bpf: Move common functions into bpf_jit_comp.c
>   powerpc/bpf: Change values of SEEN_ flags
>   powerpc/asm: Add some opcodes in asm/ppc-opcode.h for PPC32 eBPF
>   powerpc/bpf: Implement extended BPF on PPC32
>   powerpc/bpf: Reallocate BPF registers to volatile registers when
>     possible on PPC32
>
>  Documentation/admin-guide/sysctl/net.rst |    2 +-
>  arch/powerpc/Kconfig                     |    3 +-
>  arch/powerpc/include/asm/ppc-opcode.h    |   12 +
>  arch/powerpc/net/Makefile                |    6 +-
>  arch/powerpc/net/bpf_jit.h               |   61 ++
>  arch/powerpc/net/bpf_jit32.h             |  139 ---
>  arch/powerpc/net/bpf_jit64.h             |   21 +-
>  arch/powerpc/net/bpf_jit_asm.S           |  226 -----
>  arch/powerpc/net/bpf_jit_comp.c          |  782 ++++-----------
>  arch/powerpc/net/bpf_jit_comp32.c        | 1095 ++++++++++++++++++++++
>  arch/powerpc/net/bpf_jit_comp64.c        |  295 +-----
>  11 files changed, 1372 insertions(+), 1270 deletions(-)
>  delete mode 100644 arch/powerpc/net/bpf_jit32.h
>  delete mode 100644 arch/powerpc/net/bpf_jit_asm.S
>  create mode 100644 arch/powerpc/net/bpf_jit_comp32.c
>
> --
> 2.25.0
>
