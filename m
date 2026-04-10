Return-Path: <linuxppc-dev+bounces-19610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B62F4485A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:40:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsdGM3d6mz2yZ6;
	Fri, 10 Apr 2026 23:40:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1235" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775828411;
	cv=pass; b=aJM2EApZISPtkYKArxAwJ5Iaw1Y4e9uoQiVn2qtXRQTrzl6uq9Eckjx1lxk5sD5EFiBq/pwfA/YYIXHGri015rI4DorB0wAvG1gx0YiLdCfOTbgdWT//hOOGDlRBhSBdj4fnbutXw/H60FU9WXdq/qpWE61QUgPYEG4tDzGBtIEYM+COF5JLQTD0naADXnb37o1fWsPjDDBy4JiBogEVoV8ultwnN1dywFVgjwy0XwYNe4aS3xte5u1rUc1WPrEqYWbexh8dpNoEcL7wMk3AkAcrwY1j3SUbyjWYVN4BBcpv4ffzUbN7yTFohBHpdrKR6rORhpX+6PMuFWt1V0/qYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775828411; c=relaxed/relaxed;
	bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpO9yPrRFY0fULCMh5d2In6mmn2v0kHn/xUzqMgeTffiFXr0+VMHyDWVAF6NKYVUZhnMq2NT3WhMktRDQNPelYQAVN9lfZAwH9QzcVdkepL28A2Vy4tyWNExOC0bQ0zJLmQIFaikHA22OkU7/sD3Npu0wp+ILeyQqz4uLubhK+Qhd9LcdMHxiXTQlJlWt0Vb/KZ9qA10orE96A+any74P+f9POoGhxmXFwd2WFMjO5cKJuRXjouWF/i/b6PtR2SqtPCEM/+VEXwt8CcRzPMGft3uDT6OXm0yjWp09M/I+/OWkz+vp+Xnk2kvl0kBZWfRcbDFVM1ob2S2IKsXLQNf+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nVxA9xkL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=elver@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nVxA9xkL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=elver@google.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsdGK5vK0z2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 23:40:09 +1000 (AEST)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1279eced0b9so3035216c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 06:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828407; cv=none;
        d=google.com; s=arc-20240605;
        b=aJH2SjP+rumFZJ7OJEQOkz6D1K2AeOLPhfG/htTOXOmlp7yf4LOklhRThWIpD/8RSC
         fjAR+GKUvrrwey6NDI+TgBng5Lrfi2WXA9ZH27VzhBNc797dTtdG+m22OVvPutXvqzVx
         /Mong9AkTc/O+YoHGSVDtnNNGuAUF0QSKJjQ/h2sT95c+p+L2nDlZCSW+AG2bv2qlPrq
         XfWqgpGait0c9Mvc3r8IZiB/gW1Mrw0FTjCAhOgk29NCSmXMkdKjuPc4p3o/Tvk80LlT
         ulrlGKE2adXRe8uuHHeyRBSxocd0+EVinAEN4IFUzBNYTVVcAEOcTU6beAQry2ksu7Ca
         gF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=3KU+y8OBr+cT4NQ6tSrBqdhV1lDuF27WNxFIOyN8hqg=;
        b=MqJhozKOIEmcpVQLiH366u9+V1saC32ZFkFcwq20/aKrWYlyS8Rs8lNQVgMp61JcQE
         Ap6NSMEUuO2cCrv0BTG7al+orzBwh7hCuruFtFcS3MIgrb7SsQurIZpw68EMFDI4o0P+
         8nKhhZk1dS9J5Dla3uoHjDj5ELcpqL8+b38wZQG2ULYMCupOii7JBK2s94e3CFMx9ve4
         xc8HhjcGb40J0wTogfTEtB1irPVvX4Qge8FEnDuUiKeFJ4HrsFuGjxVpr+JhPrQ6Etr7
         Q+mS+N+ZfM92yTlMfacwpNouYTJ/LDcRb1KfNCVRDl/FHp57ciHjRceyqmWsf4ABn2Dv
         64Dw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828407; x=1776433207; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=nVxA9xkL9q8wo3I2W031AR2lV3Sc/w7+OVX5qD4fc4E3yDWmo2kpPhP1s/G6MX+h8+
         +FM2OxuowkmNhjvnT8oDe05zxoNi2xvPcQAVIoWhWHv8cixEG0/fRLgH9BK9FD8D3utV
         NdSKmdEUc4LrKBMre12bi6ZMepb6oTcTveg4ta6q19GaUtqdc37aDYTjHwHNQ+OKtxkd
         JDdDS3cyQgzPHjvB+YLg4Nx1Yx1laqQS6R4cjbs9gPGcaW8s38c1iyDqxFZqN+QMa4N2
         dCazaEkoTYMnp6srWoR42bDika8qsti/XOmoQ/GDkPu5IkQQDeuzFzUT+N9TDYanoTDo
         1O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828407; x=1776433207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=L5ui/Im/zc6hNkbOOTVie7Ut5J4+7PhcoBWXR/Aa7cM9Zo/GjyP3tlPFob+3+woAHQ
         fZ6oRQVKHpmCGLuUFps06ebytdW5Glol8jqJRK/EKYsKEg4lc7kEYckAvr4bLTJZt61O
         e+468elbhUmIW3/j2ucjBrFl6JRllDKfZ+6CrWIkcSh0Xcb1Ag2q9eatK6Fv+MiNliOD
         GFEiBGYjqC+ovPJG6xeZCjLfMvmoK+IL5kNpFqfKeDR2E3GvynxSfUo8JbQwb8vkoHgK
         iIJVrtdNFTreVfYQI6+uOspNmwcepKgCzM6dEmhniO9Txm2JAx0mqgmPG8ySRBum7sso
         GRDA==
X-Forwarded-Encrypted: i=1; AJvYcCXX67odSIO9v+Q6cXIl+9bT1xEpUVQWj5GxQBD4TFQUwcMNmuS3JkH4mKzu5E6qpz71XDG1EqwIgPLVNe8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfrSKfXD/Hh2VkUiO4zP3vVCgFKP7rVmk+5swAlXChRvVS3A2P
	8k6WYxXMFBB3AfbWII/C8Pre/C+2JM0URLQJRu5qx06ambkXZXBOywKNV6qTGB8AWQ8XDNChjVC
	eTyUsp4fSdycytqXlq0wGvJQxpxAcOeJcOPZ7Hk5t
X-Gm-Gg: AeBDiesUBnjPufOyr41SV/VOWdq2UtDkk0Gf334uw+s0Bil2QM23JN5FItVMlJNSNic
	D3qTGx8W/Jqz81L2RcAqAWteImJyPDegPC/FfHvtHlB7w2PitJqnIhsd+1C4fTf7L3Qny8jX3PL
	ZrLBgLeLEjIMOl1nR43//F/EB8QHI3EA/Z5ukG6Sp/728pP4cKphlm0I/zfJSovaDQgHTIwZBDZ
	QuhAmq5upi2yRdm84nUxgyoO+UEMoNqzVmX05VEGkHkPGA+bViC4B8sIZ4B9N2BuKE0YMEt+a0g
	EDLWCe1xvGC6DxWbzXuR+zfObfjGMh5QFra2aUXfZ855NrEZ
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
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
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>

