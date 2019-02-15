Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C4C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:37:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB6F2192C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 06:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ht+tZa3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB6F2192C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4413Tp485xzDqDV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 17:37:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Ht+tZa3V"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4413Rq0Hk2zDq67
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 17:35:50 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id r11so21747795itc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 22:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q6PNtRr/ANbdtbDPmSpbMPgsjGqaPc/9dIAPYQDheKw=;
 b=Ht+tZa3VPBOSfQ5+MAD5b22epJXwS2okQKzwgg5uGKkh9SNO7GmT9IjYIjjejXzycV
 FPm1w410gGnOZgTucOZiL8ai8sEUYJHYAX1/h77tgIQrysM/TRcSioI5xpoT3VcEVe8M
 jzijMSHQj1Rnj7iMUqtyOEvMlZE6umU/4QSS163tWlkjaViKtuOza2Qn3tO30aWGarrY
 aHmbzZ03lXxwi9i5kpCiH6vOihR8Uc8tirHK+D24tlTk/EIgix+rZ9s4InLo0v0P7Fdh
 mbOnLHPZs9gq5rOdcia9n6U2aNARxI+JmkhsTtSGqKNLayGGHplof6UnXkBdkGmfO6nR
 FadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q6PNtRr/ANbdtbDPmSpbMPgsjGqaPc/9dIAPYQDheKw=;
 b=o0hmVjoDHTjDU5iACi2lLmLLZSWvkB8YlJP3e+j2KRo/J7tE28d3OVfTh3mabw31Dd
 FrZLcdg4GmTm+TCI/ra223+V/6qcQb8QCReDcgnUwgtVza5rD3FStffVjqNg2x7CyaYI
 7mTFsdGLc820I1uOPK6l4Qa1KEqkWHZZLh8itDMXNjfZtp7Olmj0eYjeXXkIQqzf31Nu
 RP1aY8Mmat0JuXXlatsww21d9/kqgFfShSNE7LEFVEaEbkt/gEo15JowcgXkyBUPvPWv
 7fRGx/FQL43jiR+RYZJKTKnwRD2R2uC5lWfFY8IyoeW5UEKlcFqwV/9y6tK2uDYynHVP
 Qqhw==
X-Gm-Message-State: AHQUAuYsWsa7BbKlopQ7LXjNvgtnSwv+eom+e2QWagzhqra7jvKPNqtM
 DT4np8SIIg/vwvGAl2QSJfTb7MYSlCPJEkUqY8FCdA==
X-Google-Smtp-Source: AHgI3IZYH+uz5H0Ya8tLTYz+4u6dsys+7hKAr3NoD7rZGCHhuEwtbJpxmq7L5CP1dSR7llS1lRkhgW2/6w5Fx5/CuBY=
X-Received: by 2002:a05:660c:3ce:: with SMTP id
 c14mr3727982itl.166.1550212545521; 
 Thu, 14 Feb 2019 22:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-3-dja@axtens.net>
In-Reply-To: <20190215000441.14323-3-dja@axtens.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 15 Feb 2019 07:35:34 +0100
Message-ID: <CACT4Y+Zq9w_bxqKYQ4-OQLkdJwVi3RHBzr6uXp6977SfvDegSA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] kasan: allow architectures to manage the
 memory-to-shadow mapping
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
 linuxppc-dev@lists.ozlabs.org, kasan-dev <kasan-dev@googlegroups.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 1:05 AM Daniel Axtens <dja@axtens.net> wrote:
>
> Currently, shadow addresses are always addr >> shift + offset.
> However, for powerpc, the virtual address space is fragmented in
> ways that make this simple scheme impractical.
>
> Allow architectures to override:
>  - kasan_shadow_to_mem
>  - kasan_mem_to_shadow
>  - addr_has_shadow
>
> Rename addr_has_shadow to kasan_addr_has_shadow as if it is
> overridden it will be available in more places, increasing the
> risk of collisions.
>
> If architectures do not #define their own versions, the generic
> code will continue to run as usual.
>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/kasan.h     | 2 ++
>  mm/kasan/generic.c        | 2 +-
>  mm/kasan/generic_report.c | 2 +-
>  mm/kasan/kasan.h          | 6 +++++-
>  mm/kasan/report.c         | 6 +++---
>  mm/kasan/tags.c           | 2 +-
>  6 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b40ea104dd36..f6261840f94c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -23,11 +23,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>                                 const void *shadow_end);
>
> +#ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>         return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>                 + KASAN_SHADOW_OFFSET;
>  }
> +#endif
>
>  /* Enable reporting bugs after kasan_disable_current() */
>  extern void kasan_enable_current(void);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index ffc64a9a97a5..bafa2f986660 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -173,7 +173,7 @@ static __always_inline void check_memory_region_inline(unsigned long addr,
>         if (unlikely(size == 0))
>                 return;
>
> -       if (unlikely(!addr_has_shadow((void *)addr))) {
> +       if (unlikely(!kasan_addr_has_shadow((void *)addr))) {
>                 kasan_report(addr, size, write, ret_ip);
>                 return;
>         }
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 5e12035888f2..854f4de1fe10 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -110,7 +110,7 @@ static const char *get_wild_bug_type(struct kasan_access_info *info)
>
>  const char *get_bug_type(struct kasan_access_info *info)
>  {
> -       if (addr_has_shadow(info->access_addr))
> +       if (kasan_addr_has_shadow(info->access_addr))
>                 return get_shadow_bug_type(info);
>         return get_wild_bug_type(info);
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ea51b2d898ec..57ec24cf7bd1 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -111,16 +111,20 @@ struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>                                         const void *object);
>
> +#ifndef kasan_shadow_to_mem
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
> +#endif
>
> -static inline bool addr_has_shadow(const void *addr)
> +#ifndef kasan_addr_has_shadow
> +static inline bool kasan_addr_has_shadow(const void *addr)
>  {
>         return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
>  }
> +#endif
>
>  void kasan_poison_shadow(const void *address, size_t size, u8 value);
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index ca9418fe9232..bc3355ee2dd0 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -298,7 +298,7 @@ void kasan_report(unsigned long addr, size_t size,
>         untagged_addr = reset_tag(tagged_addr);
>
>         info.access_addr = tagged_addr;
> -       if (addr_has_shadow(untagged_addr))
> +       if (kasan_addr_has_shadow(untagged_addr))
>                 info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
>         else
>                 info.first_bad_addr = untagged_addr;
> @@ -309,11 +309,11 @@ void kasan_report(unsigned long addr, size_t size,
>         start_report(&flags);
>
>         print_error_description(&info);
> -       if (addr_has_shadow(untagged_addr))
> +       if (kasan_addr_has_shadow(untagged_addr))
>                 print_tags(get_tag(tagged_addr), info.first_bad_addr);
>         pr_err("\n");
>
> -       if (addr_has_shadow(untagged_addr)) {
> +       if (kasan_addr_has_shadow(untagged_addr)) {
>                 print_address_description(untagged_addr);
>                 pr_err("\n");
>                 print_shadow_for_address(info.first_bad_addr);
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index bc759f8f1c67..cdefd0fe1f5d 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -109,7 +109,7 @@ void check_memory_region(unsigned long addr, size_t size, bool write,
>                 return;
>
>         untagged_addr = reset_tag((const void *)addr);
> -       if (unlikely(!addr_has_shadow(untagged_addr))) {
> +       if (unlikely(!kasan_addr_has_shadow(untagged_addr))) {
>                 kasan_report(addr, size, write, ret_ip);
>                 return;
>         }
> --
> 2.19.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190215000441.14323-3-dja%40axtens.net.
> For more options, visit https://groups.google.com/d/optout.
