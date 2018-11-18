Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76968C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 10:31:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806CB20815
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAN2iaJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806CB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yStC4kvtzF3L0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Nov 2018 21:30:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAN2iaJe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=ys114321@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAN2iaJe"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yPGB5p3yzF3dh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Nov 2018 18:47:59 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id d135so44105773qkc.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 23:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e9jUmSTLaGX0A7LyE7aM7FouS47os25e/5PoGajRO0w=;
 b=jAN2iaJegYuO7y2ZKWZRRtWbl2StGyxw+Y3Ox6vHmmX1u2mpwTX33rfiW8Rnh0yT8U
 VVfx/9FWFpzETBNWLWvFFlz9/UMtPz62DIHQFevJZPuOsK3mGmkfS/8yBtfOWU6MLJQr
 ZPiSKBIMvUpuXc09hQBvCHHuNS5su52O3gDhV+N6L343+bjvYGBZlmwMcXyd4MqquJot
 xZAcShyQkOZyMJx1uPOyYChnnnG7qrY88Zhd8tL4i8+2aXc5SQJFLGJBAceou0Je/K7z
 vm3sHwjFX7SPavSdCrnjDcpaKyNhgIjiD+TnJJ7ri9uZ6eObpw/b+q63HlCLrWBxLcye
 Y7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e9jUmSTLaGX0A7LyE7aM7FouS47os25e/5PoGajRO0w=;
 b=oxOfrPsdKwtP58d61d7sfOr7aCQfOpGYC/bOhGrL97T36NqaYrs1VxNZ2ktzGVYhdM
 XEXxhJO7zJyovELFiRQiXeZ3GcCcQNfmFH98iNKw4yk8HBy2pZQqpjfEum4HJmJPGALA
 xtCtnO1h5uMNSgSxUiay3MwzrAhq+vBf8wM/Elcpi92Bpu267AY8j2fTHnFWkxrqMi2H
 ZpWn8xc7DLW3W907I2MedY7aC7+SK1IIo9/juXRkoUCx4/AMFYqhrTnSergu9Xq7LCOW
 joZWiGzzXwJATEP01lJ9hX7zLdkNq++M6PAui6Iwx9IaFkU/6RLO3m1fbnqe9koTbnHB
 +ZOA==
X-Gm-Message-State: AGRZ1gLzI84zuk2OxHiCgizKALO4EHPYG/RfFc3Zbr5O6QLj1DS0KMeN
 MCm1CjtWT3GcD0lByMmr39bw3GtH6pQiADxQ1jE=
X-Google-Smtp-Source: AJdET5d0B2HeX5Nvr+wGZPdX7m6Rl24zd7KaVOpOiDtE/8uwUkfLAjvZ94pD068kW1H4Q3oUAYfLsNkd4p788UzoOuk=
X-Received: by 2002:a0c:bf0d:: with SMTP id m13mr16906324qvi.139.1542527276900; 
 Sat, 17 Nov 2018 23:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20181117185715.25198-3-ard.biesheuvel@linaro.org>
From: Y Song <ys114321@gmail.com>
Date: Sun, 18 Nov 2018 07:47:27 +0000
Message-ID: <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
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
> All arch overrides of the __weak bpf_jit_free() amount to the same
> thing: the allocated memory was never mapped read-only, and so
> it does not have to be remapped to read-write before being freed.
>
> So in preparation of permitting arches to serve allocations for BPF
> JIT programs from other regions than the module region, refactor
> the existing bpf_jit_free() implementations to use the shared code
> where possible, and only specialize the remap and free operations.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/mips/net/bpf_jit.c           |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
>  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
>  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
>  kernel/bpf/core.c                 | 15 +++++----------
>  5 files changed, 14 insertions(+), 31 deletions(-)
>
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 1b69897274a1..5696bd7dccc7 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>         kfree(ctx.offsets);
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index a1ea1ea6b40d..5b5ce4a1b44b 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
>         return;
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 84c8f013a6c6..f64f1294bd62 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
>         return fp;
>  }
>
> -/* Overriding bpf_jit_free() as we don't set images read-only. */
> -void bpf_jit_free(struct bpf_prog *fp)
> +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> index 01bda6bc9e7f..589950d152cc 100644
> --- a/arch/sparc/net/bpf_jit_comp_32.c
> +++ b/arch/sparc/net/bpf_jit_comp_32.c
> @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
>         return;
>  }
>
> -void bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       if (fp->jited)
> -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> -
> -       bpf_prog_unlock_free(fp);
> +       module_memfree(hdr);
>  }
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1a796e0799ec..29f766dac203 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
>         return hdr;
>  }
>
> -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
>  {
> -       u32 pages = hdr->pages;
> -
> +       bpf_jit_binary_unlock_ro(hdr);
>         module_memfree(hdr);
> -       bpf_jit_uncharge_modmem(pages);
>  }
>
> -/* This symbol is only overridden by archs that have different
> - * requirements than the usual eBPF JITs, f.e. when they only
> - * implement cBPF JIT, do not set images read-only, etc.
> - */

Do you want to move the above comments to
new weak function bpf_jit_binary_free?

> -void __weak bpf_jit_free(struct bpf_prog *fp)
> +void bpf_jit_free(struct bpf_prog *fp)
>  {
>         if (fp->jited) {
>                 struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
> +               u32 pages = hdr->pages;
>
> -               bpf_jit_binary_unlock_ro(hdr);
>                 bpf_jit_binary_free(hdr);
> +               bpf_jit_uncharge_modmem(pages);
>
>                 WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
>         }
> --
> 2.17.1
>
