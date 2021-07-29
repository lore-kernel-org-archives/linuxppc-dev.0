Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4796C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 13:42:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567446052B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 567446052B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GbBYH5Dr0z3cVY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jul 2021 23:42:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GbBXs40wMz3bWC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jul 2021 23:42:18 +1000 (AEST)
Received: from [192.168.0.7] (ip5f5aeda3.dynamic.kabel-deutschland.de
 [95.90.237.163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 378E661E5FE02;
 Thu, 29 Jul 2021 15:42:12 +0200 (CEST)
Subject: Re: [PATCH] powerpc/vdso: Don't use r30 to avoid breaking Go lang
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20210729131244.2595519-1-mpe@ellerman.id.au>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <392b3b47-1878-d27a-9656-4596fdc7c343@molgen.mpg.de>
Date: Thu, 29 Jul 2021 15:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729131244.2595519-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Michael,


Am 29.07.21 um 15:12 schrieb Michael Ellerman:
> The Go runtime uses r30 for some special value called 'g'. It assumes
> that value will remain unchanged even when calling VDSO functions.
> Although r30 is non-volatile across function calls, the callee is free
> to use it, as long as the callee saves the value and restores it before
> returning.
> 
> It used to be true by accident that the VDSO didn't use r30, because the
> VDSO was hand-written asm. When we switched to building the VDSO from C
> the compiler started using r30, at least in some builds, leading to
> crashes in Go. eg:
> 
>    ~/go/src$ ./all.bash
>    Building Go cmd/dist using /usr/lib/go-1.16. (go1.16.2 linux/ppc64le)
>    Building Go toolchain1 using /usr/lib/go-1.16.
>    go build os/exec: /usr/lib/go-1.16/pkg/tool/linux_ppc64le/compile: signal: segmentation fault
>    go build reflect: /usr/lib/go-1.16/pkg/tool/linux_ppc64le/compile: signal: segmentation fault
>    go tool dist: FAILED: /usr/lib/go-1.16/bin/go install -gcflags=-l -tags=math_big_pure_go compiler_bootstrap bootstrap/cmd/...: exit status 1
> 
> There are patches in flight to fix Go[1], but until they are released
> and widely deployed we can workaround it in the VDSO by avoiding use of

Nit: work around is spelled with a space.

> r30.
> 
> Note this only works with GCC, clang does not support -ffixed-rN.

Maybe the clang/LLVM build support folks (in CC) have an idea.

> 1: https://go-review.googlesource.com/c/go/+/328110
> 
> Fixes: ab037dd87a2f ("powerpc/vdso: Switch VDSO to generic C implementation.")
> Cc: stable@vger.kernel.org # v5.11+
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/kernel/vdso64/Makefile | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
> index 2813e3f98db6..3c5baaa6f1e7 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -27,6 +27,13 @@ KASAN_SANITIZE := n
>   
>   ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
>   	-Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
> +
> +# Go prior to 1.16.x assumes r30 is not clobbered by any VDSO code. That used to be true
> +# by accident when the VDSO was hand-written asm code, but may not be now that the VDSO is
> +# compiler generated. To avoid breaking Go tell GCC not to use r30. Impact on code
> +# generation is minimal, it will just use r29 instead.
> +ccflags-y += $(call cc-option, -ffixed-r30)
> +
>   asflags-y := -D__VDSO64__ -s
>   
>   targets += vdso64.lds
> 

The rest looks good.


Kind regards,

Paul
