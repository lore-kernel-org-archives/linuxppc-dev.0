Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8962DC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 03:42:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19C8613DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 03:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19C8613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3vKG0mzmz3bxl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:42:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=b8g4K1XK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b36;
 helo=mail-yb1-xb36.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=b8g4K1XK; dkim-atps=neutral
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3vJp28WKz2yjS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 13:42:18 +1000 (AEST)
Received: by mail-yb1-xb36.google.com with SMTP id m9so18490460ybo.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 20:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hSm4lDQmvuYcNCJIDeoEyVLYEDl2O+na4iPfgEBo8es=;
 b=b8g4K1XKnGa0I4a6RVUeAajfdq3ihZvzQ2SFupYVUvkuetR6V7C/ZsVH3wtc3n6GNS
 UAdJ8hO/Dy2tB4L77mF7tvHUV/nJDLI38kqk+bfYwMtAhwR0uEf9FI2E4adb5WeLpWoF
 oeXcvhfIXyuCgTgcJA7YyHoEDfaDrROGxTitG23AflJ/JjcbBh3y1wxPXFvKVX9/luxD
 /tG3zci1NYk23GcE1IvM/hZqQv/llEKN4fo+0iQO5Ia7qTdLTjO4XWOuW5Q3nBF/YErc
 +BUZBYAWZY3uQxo2PM7sxDSvuChRPzpW6/Mmol9HB/2wEfEquYaY4Pp6xc4IkeWMejA8
 xGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSm4lDQmvuYcNCJIDeoEyVLYEDl2O+na4iPfgEBo8es=;
 b=IxUsOl2zESKkHBXBqUjuQ8ZZ/lK9Y/SjvmE3hmgkudRsKwgxjSyJEtji0NrtG7ck/a
 JIeKzVu+Ji0sc0fYo4hh1ExEkufVbntaHARsPg33OhTHFR53pI5NpYbPRI6lc/xQiB4e
 vIARcYNxpcjMtgAAmdJmY8RgYbcyJD6M3ME+tF8e+LPH0digF7fO8j/H7UEY2hl0B5A7
 y5Pfyy6x1H4bK57bYsFPay7Lh07EP1k6NHQl175TBW6HXLA108y6MoirhZcxsUTlH3Me
 NM2h/gLpirQIVtmu+bgfxSYLcagCGAqANEtvdW0A4qmx8vU5SRcNb8XfUvLu5U8VtUME
 slvQ==
X-Gm-Message-State: AOAM5315iSUvpU0N+267T8FLtlpmAHCFGj5P85c0E6wVY+VoBU7b3tFy
 2GfMqe7PKgRy7K+5djdtiGGu0VNg8z/3tImTeF0=
X-Google-Smtp-Source: ABdhPJyJlaazuVTiHhxwPWGRiL+TnZD0tSp1fyqD2f0GyTEVhJqpni/fKv1dqGASeqvgTr2Ftb0zhSeJodqBbHPL7zw=
X-Received: by 2002:a25:69ce:: with SMTP id
 e197mr27366126ybc.265.1623728534967; 
 Mon, 14 Jun 2021 20:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f6b9c8c83170ed310953eac2f5b14539bfc964a.1621516826.git.christophe.leroy@csgroup.eu>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 15 Jun 2021 13:42:03 +1000
Message-ID: <CACzsE9o+nuDEPk9ENig8_aAbLYLmpoWP8_JZKJWX=AqfOV2ODg@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] powerpc/lib/code-patching: Make
 instr_is_branch_to_addr() static
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 20, 2021 at 11:50 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> instr_is_branch_to_addr() is only used in code-patching.c
>
> Make it static.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/code-patching.h |  1 -
>  arch/powerpc/lib/code-patching.c         | 18 +++++++++---------
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
> index f1d029bf906e..f9bd1397b696 100644
> --- a/arch/powerpc/include/asm/code-patching.h
> +++ b/arch/powerpc/include/asm/code-patching.h
> @@ -59,7 +59,6 @@ static inline int modify_instruction_site(s32 *site, unsigned int clr, unsigned
>
>  int instr_is_relative_branch(struct ppc_inst instr);
>  int instr_is_relative_link_branch(struct ppc_inst instr);
> -int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr);
>  unsigned long branch_target(const struct ppc_inst *instr);
>  int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
>                      const struct ppc_inst *src);
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 0308429b0d1a..82f2c1edb498 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -367,15 +367,6 @@ unsigned long branch_target(const struct ppc_inst *instr)
>         return 0;
>  }
>
> -int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
> -{
> -       if (instr_is_branch_iform(ppc_inst_read(instr)) ||
> -           instr_is_branch_bform(ppc_inst_read(instr)))
> -               return branch_target(instr) == addr;
> -
> -       return 0;
> -}
> -
>  int translate_branch(struct ppc_inst *instr, const struct ppc_inst *dest,
>                      const struct ppc_inst *src)
>  {
> @@ -410,6 +401,15 @@ void __patch_exception(int exc, unsigned long addr)
>
>  #ifdef CONFIG_CODE_PATCHING_SELFTEST
>
> +static int instr_is_branch_to_addr(const struct ppc_inst *instr, unsigned long addr)
> +{
> +       if (instr_is_branch_iform(ppc_inst_read(instr)) ||
> +           instr_is_branch_bform(ppc_inst_read(instr)))
> +               return branch_target(instr) == addr;
> +
> +       return 0;
> +}
> +
>  static void __init test_trampoline(void)
>  {
>         asm ("nop;\n");
> --
> 2.25.0
>
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
