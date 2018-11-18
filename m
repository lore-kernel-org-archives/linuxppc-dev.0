Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3B9C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 10:33:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC0F20815
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ls5kEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC0F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ySwq6r6pzF3H8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 21:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7ls5kEI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=ys114321@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7ls5kEI"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yPHt5Z0qzF3fG
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 18:49:30 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id m5so44130160qka.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 23:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mmUp9bVLzAjLxvxpuGqKyizUS3hwC0JQZLZ/D3xx8Dw=;
 b=E7ls5kEIfXFrL+O3NSrT0/OjSCJW5QTbXrKomsxzn2oupTGH3ZXPKGoQgkbSU8B5Zl
 gkc+zA/bX4ToSOFH2H5o6CtP4ricuUiCt2wanR+G6FwpSQOBW3YqB07UnpSrjYVgaH9L
 bIJlxpteq/vKIBBFHQdhciAJI7S0R4RQG3wd7Lk+SzhND9BeAx77n7nUVXQx5KdcEo3V
 suJgNmxMeltBkBRyRUxPQ+qYIFc1ZF/O/4h+UoJUTgM+gG3V0dlSfSlKhW8T/GatjXQD
 1Yp0kRC12IXkvaMP11VbHXkIvMeaXLe9Wc+4XDsFVSx4QSWlbZWXdcLNkeIww6Ur8c5r
 R9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mmUp9bVLzAjLxvxpuGqKyizUS3hwC0JQZLZ/D3xx8Dw=;
 b=VqsccKfWIg1B960IcmN1qMHjsXGS2UJDds9PmvNufBWr8SOliG/1WwVhpxxl1uhbT/
 O7fPD2YkP5KRCWhkoe2VmePKaZLHmMb9I8wjn/KJayDrdOWI8trMWeagXHXGWLhOZkmJ
 UbO75ft0Nr0/1jgjVRUbpzyHg1QQE5pIVbZ8Pp/cpBK2iSPfp7gLncnMZ8X8PDHqtsdO
 Y8b4LlRtJ9zvFIocVD3mIGOdtZHD7uBfIMEj7vHIl3dF1dklQjhoA8by28LUBhekU901
 8ekHrYipCF9jfCsz73+ad1Hl08aszTYjovQeJM8gbVkGMJvTwAapZ/HtaOv/OXTWOvKt
 RE0A==
X-Gm-Message-State: AGRZ1gIg2FOMAX8U7RjfD9p1uNC8v2al9q7qcErIXqBinXldrhYNLnMq
 WNA2pLHMYBUu69x1/++qSu5Z4MYnOOJaeKwqu2w=
X-Google-Smtp-Source: AJdET5d3ZByMLTrTWsR1nu6Ai5Phm/hGfev7RqCiKZlcFDEKSwvvy/6aIFstM0swTZP2DkMUIuQ3wpj/VhhKU76VdPc=
X-Received: by 2002:a37:41d2:: with SMTP id o201mr16064899qka.24.1542527368265; 
 Sat, 17 Nov 2018 23:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
From: Y Song <ys114321@gmail.com>
Date: Sun, 18 Nov 2018 07:48:59 +0000
Message-ID: <CAH3MdRX5MYv-QQGj25APd4-17syF3Vc_f0AWpEgUoL46qbHrGQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bpf: permit JIT allocations to be served outside the
 module region
To: ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 18 Nov 2018 21:28:50 +1100
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
Cc: mark.rutland@arm.com, linux-mips@linux-mips.org, will.deacon@arm.com,
 Alexei Starovoitov <ast@kernel.org>, paulus@samba.org,
 sparclinux@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 catalin.marinas@arm.com, jhogan@kernel.org, Kees Cook <keescook@chromium.org>,
 arnd@arndb.de, jannh@google.com, linux-arm-kernel@lists.infradead.org,
 eric.dumazet@gmail.com, netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, paul.burton@mips.com,
 jeyu@kernel.org, rick.p.edgecombe@intel.com, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On arm64, modules are allocated from a 128 MB window which is close to
> the core kernel, so that relative direct branches are guaranteed to be
> in range (except in some KASLR configurations). Also, module_alloc()
> is in charge of allocating KASAN shadow memory when running with KASAN
> enabled.
>
> This means that the way BPF reuses module_alloc()/module_memfree() is
> undesirable on arm64 (and potentially other architectures as well),
> and so this series refactors BPF's use of those functions to permit
> architectures to change this behavior.
>
> Patch #1 fixes a bug introduced during the merge window, where the new
> alloc/free tracking does not account for memory that is freed by some
> arch code.
>
> Patch #2 refactors the freeing path so that architectures can switch to
> something other than module_memfree().
>
> Patch #3 does the same for module_alloc().
>
> Patch #4 implements the new alloc/free overrides for arm64

Except a minor comment, the whole patch set looks good to me.
Acked-by: Yonghong Song <yhs@fb.com>

>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: sparclinux@vger.kernel.org
> Cc: netdev@vger.kernel.org
>
> Ard Biesheuvel (4):
>   bpf: account for freed JIT allocations in arch code
>   net/bpf: refactor freeing of executable allocations
>   bpf: add __weak hook for allocating executable memory
>   arm64/bpf: don't allocate BPF JIT programs in module memory
>
>  arch/arm64/net/bpf_jit_comp.c     | 11 ++++++++++
>  arch/mips/net/bpf_jit.c           |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp64.c | 12 +++--------
>  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
>  kernel/bpf/core.c                 | 22 ++++++++++----------
>  6 files changed, 31 insertions(+), 35 deletions(-)
>
> --
> 2.17.1
>
