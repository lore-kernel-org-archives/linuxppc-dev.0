Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32190C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:29:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6E220449
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="owXuWTRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E220449
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415xq3c6DzDqfr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::142; helo=mail-it1-x142.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="owXuWTRM"; 
 dkim-atps=neutral
Received: from mail-it1-x142.google.com (mail-it1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415t33DSmzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:25:15 +1100 (AEDT)
Received: by mail-it1-x142.google.com with SMTP id i2so21403935ite.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a+diSEO3YqhEhfT9sS5fz8zL1ng46IHkns/dSa4cfFI=;
 b=owXuWTRMQC5hFXvPVkgh3VQJA38GS5pBlpA7mC0QOBgfotXTp/fOERBqGfPo7ugVLr
 xVIycEqzCb2RJpNemskQx1k8QebGqG8YVgqV0ItTJ8Wv+yTcaYl6mI00z+dVifG948jC
 Tb47cWMKSQSpeQROkjgLo6HtrlHnWbj4v/wxeavuuNze8NG2T+ZeXq9pWYlvCfJ+1ujj
 crdQo/StZVBysMs9mpnUDlsSG31csQc25SHeiLl+Qo7jgrSdScwaBjwNT98jABmKeVXe
 xjC6mMEudPR/cDac1UZ3VqSOva7NvYsJEI7XYHITuqlzYNAt/pNV1PehpIRTW2kUIxZb
 C0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a+diSEO3YqhEhfT9sS5fz8zL1ng46IHkns/dSa4cfFI=;
 b=haj+5w0e9IxXfmoXyCDQbDMDD/Ym9hbrst1aQiozMhGrCtKy0oGos72Rt/7qMy/wjD
 IZ0CNIVCHJQKlzORqZxlgSRpzS19nFFqkhC8wnbKyeeYCViZF0rL8noPMcaLQujD7/cD
 BZLl99epjRnzyhOu1WTFDXA9OMMWVrwxs9Lyn6Zia+7uNdY+HkneHC6dkF1yJRMY2jEQ
 SLYCTr+aQbm3+OpVmEutLVI8qbXFvrn0GeCYQOuX69Ak0sH6T5dziHD/5muj7ghUxPqN
 A5qUjEN8IdMfmT6TrT7ITcazh72Yl/Ybx9HieHcpDZUDblIiO/LZae+nLM7Ry9E2X5Qy
 j/2w==
X-Gm-Message-State: AHQUAub8zu6BTNlSnxhdye3n3l0v81lyxejIppV3mY15ExmL86G6O14E
 hmmKYjaPYse5j140AP4MukLp6YqthERySgSxOqCjeg==
X-Google-Smtp-Source: AHgI3IYCy7l78kqTlrw/hrKKfkPb94x/0UMs1sQEh4hZanVA+zXaybG52EhIu1hsQDrudbLOrma5WLLLoIDA4zaANGA=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr4869437ior.11.1550219113279;
 Fri, 15 Feb 2019 00:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-4-dja@axtens.net>
In-Reply-To: <20190215000441.14323-4-dja@axtens.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 15 Feb 2019 09:25:01 +0100
Message-ID: <CACT4Y+a3ww8HQfpOJ2QWE8g9x5QJn-hMQ-DHo+fVS5xP9sz12g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] kasan: allow architectures to provide an outline
 readiness check
To: Daniel Axtens <dja@axtens.net>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 1:05 AM Daniel Axtens <dja@axtens.net> wrote:
>
> In powerpc (as I understand it), we spend a lot of time in boot
> running in real mode before MMU paging is initalised. During
> this time we call a lot of generic code, including printk(). If
> we try to access the shadow region during this time, things fail.
>
> My attempts to move early init before the first printk have not
> been successful. (Both previous RFCs for ppc64 - by 2 different
> people - have needed this trick too!)
>
> So, allow architectures to define a check_return_arch_not_ready()
> hook that bails out of check_memory_region_inline() unless the
> arch has done all of the init.
>
> Link: https://lore.kernel.org/patchwork/patch/592820/ # ppc64 hash series
> Link: https://patchwork.ozlabs.org/patch/795211/      # ppc radix series
> Originally-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  include/linux/kasan.h | 4 ++++
>  mm/kasan/generic.c    | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f6261840f94c..83edc5e2b6a0 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -14,6 +14,10 @@ struct task_struct;
>  #include <asm/kasan.h>
>  #include <asm/pgtable.h>
>
> +#ifndef check_return_arch_not_ready
> +#define check_return_arch_not_ready()  do { } while (0)
> +#endif

Please do a bool-returning function. There is no need for
macro-super-powers here and normal C should be the default choice in
such cases.
It will be inlined and an empty impl will dissolve just as the macro.

>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index bafa2f986660..4c18bbd09a20 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -170,6 +170,8 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
>                                                 size_t size, bool write,
>                                                 unsigned long ret_ip)
>  {
> +       check_return_arch_not_ready();
> +
>         if (unlikely(size == 0))
>                 return;
>
> --
> 2.19.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190215000441.14323-4-dja%40axtens.net.
> For more options, visit https://groups.google.com/d/optout.
