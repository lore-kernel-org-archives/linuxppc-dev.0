Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7F606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBnjPHu1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYB4C5ts3z2xyj;
	Tue, 24 Nov 2026 03:20:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::833" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795450811;
	cv=pass; b=eONU9Z+CP71jYp6Uu90ZvXTWz2N0Mkt7nHkiRDcxb3UeZ7lZ0/USH3CqMrBcTZjtbVylhP7k2n1wt4OzrlCVOqECFvfU0V1RMPiBiFg9qRcqIDNPEr2UJfuYzCaqQRcI/8rP67GA49UwfRNyqbGRfRZ30/Pb+yHwfNBAwBWe4lvHcd2oXlBgqOlhWAVdiRPFVLTm+oEgMr6bdzsYDschNypr1eH13aMat1xyTo4LvvIAJc0tYIJSWrzPijkfUNl8qJUlGpFN+O3yj/dr14RpGJiVZQnSNCHgVNKjADBFgZbTXtqmQEhNCCBSMOkeWaRQuc2CchEpVtENpQ7NVvSzhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795450811; c=relaxed/relaxed;
	bh=mldqwpxZeD1p8uw821ZK1a2yAWOs86dOj1gRQG3CmFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EInluRdVgiFVQETrMYgvjzglNINpTgOcrmZggWtfP19fmkmyk1oYZ3CNCBv8f3fGASjDHOJD8VryrEeJmiX7BYwTOCpyIiwHQVXq+0OK8m0+Zz5cXDY80xA9QacAg2K2eH7LONrpDjlX0EiRAqPI33kzedxCvIKR4HLmMHTUk6pF34KlMm84WCgheefztf+/RPOvx/lTNGcuZAa0ON4Z8J13Fo58kVJwItxqCYsC32+2k8eYSMvk3SbFPOm700omT2Uh4W2HjCnb+OtNVTPOnCtJcJNYvF9N4GXP2ASjQPWu7rQPQAtHmQ9h/18mYOlOw/oensnurebTRuvhoD+3XQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBnjPHu1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CBnjPHu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYB4B3jGTz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 03:20:10 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-55be673e029so440091cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 08:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450808; cv=none;
        d=google.com; s=arc-20260327;
        b=fv9kCxIYOE2t6FrmfIvC07q+RN0FhM5/KT0oQrIK1cY0Dx0RV3w/OXz57AlqzQJLX7
         +h4+8aWpybSMqjgYNwgEOpuyQkrJsKLK0tFouIcElKyEy8a3yCxNORBwXCFprxBEo0NM
         PFNn6D5HoHS3TzMvTraYmawalpZmZrj7JTGqniolyZuL1nfpVlEiMxXLvZOkwCgvAaO7
         kouDJXvoitCppkumxTWOp0F3i1+7tRri272hQo/OG6F0ItimiGgBK27S6Jf4zjtL+wN9
         ecjgw/5PavQgc8JN9zDszmh3IQL8Wc4qLJPZ2IJmp8TIWR3S1o5oNifh9630OBrQpU8Y
         nWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mldqwpxZeD1p8uw821ZK1a2yAWOs86dOj1gRQG3CmFQ=;
        fh=nVb/ujzouj+veiSl30j6W+zEsb0v/JktGyU8A/N/XQg=;
        b=XnUAdpycYN/IZ0F4ZjS36igaK7VMY0JVfWLG24TIoDgXTMn6KA5k3kD9fesU5vmeNi
         fFxxnVK8J0Ny/9nIkTGjEzXqpZiL0SxMK4RPn8AYeMQuPNG+/Q5g1I7dhOH35ecIabcR
         +cmTU1fnBAhumsqnSbyVvWvo5p4UaOK1F/1THZm53y3Mhq9773/Yr6LIm5I1pjcjp8NY
         sPdDNjsKHnVKOkF5qAUeWHqzYvEKQzI9lJ4OjhzQwRFsHmLYJMERtCJ4l5dzovqtUuE8
         mJ3jgIix3YnGPAOjR3tgv08vKHlhFV5xh8oz9kV4NmKw764mmm9TgWRD1kYE5nvvFsJ1
         xugQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795450808; x=1796055608; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mldqwpxZeD1p8uw821ZK1a2yAWOs86dOj1gRQG3CmFQ=;
        b=CBnjPHu1paNFoDJcfmQCB6Uva5T+h2zwZjx3mIt0YabbUBQcBVW/l0Uezd9VgY0JWn
         nyXyhO5HP3C6aYgnQXjfLRbp7Z5o/9k5TFnGnfPIgPMSOCiwWRf1Xa0tmZ9wxiWK0jCo
         992anrpNmn5iZLQPRy+QzG1XxT/YcAx97XNRaDjSy6gEn1fQThN9UPa3LuYmcpRMiURY
         PNDV3lNb1nUc0mvTgRX21YWej9Vpfs1+1b+BdUqJZME/gES9/hKqLHcnWEk6VCU+hBPx
         JBiF08NnJoOCZtFnTqGTb9Shc5qXztAxkgzF9cN6yxBhch3GZL9QtIBTW6GquWj9UeoV
         Wn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450808; x=1796055608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mldqwpxZeD1p8uw821ZK1a2yAWOs86dOj1gRQG3CmFQ=;
        b=iSAba8ecsPej0CnUtYOWVmuTa0yDcB/9HB4a2K29Mi/MceDBf27pZ1iHudMOSzser6
         t7/1ijSUJcAfoBdNRCPOHFRyV2R97k9cLwY76EEfc6HONfXprqI+gOn0IS4PpeInAZNH
         jmDW7eVbryT6opQ9ORnNMaGQq71yPmyPYDzgUjhdVD+eT0MR+KZfskVSh+iNfJOQD6Hr
         ADUfRgZ3svnnlpT7drN1aoQpE5yhe5Kz73mQhkxiFVPxjzBZ6KLr151KrNrJnJ1EU1TG
         pbP3muzu/29VhsxORr+4U/6UX/Nj7X2StRuT8z55d3k5uiKluW9Q5xFe3hgLg5hKzokU
         xe8g==
X-Forwarded-Encrypted: i=1; AL+hErGYyyXtglk1F7o4KEcM6BZ1VSq1Kbp+LhJ2/1cLwCGGO5l/wUbbf+QuqIYmum7r4j0zwiS7+Hyich5x958=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Iaf9haLzjYe+kmzJrA/jZpS+4zeZqYCChpV1toXquTqGuajLe
	8u3Xt/rlkPznHsprY418zL2YAIq/Mtu9OJgCuT7RJCodnUyH7fb1+I+blnCOWO0kgtGuTE7HCsW
	+yAdkDM4c/nWkGkpp2DmgzmOZDyCjCA4j3dBmOBgf
X-Gm-Gg: AZFdTZfDoHeaW2AoK3i4ortuXZ3W2O1x97ILqMnrD7JeeAVK2ilXKR0hKIF7/sNAxVs
	+jE9AcV1WOUIjAobpMmyecDhA+rgoM8fHdUtEgjosnCx5vvHwB9M40PX0RotinJazDULgG9ZvOc
	rf4PJH0Ty43j1HsgcSKRKxTEoR2mW63Je/DalCLaIMo1c2OkzVskhRUPeEnWgjXDqcQlqkrqHTO
	KL7GfyckbORu21uURJAR2ydip47j8MuIx/+4wHF9quGYgsNZ3MlrkOR0lm4/0ayidr3vRC8h8lf
	4p5zLvhFmvFRIyQyKzlTaU0InH2rvVvEDfMZ/YE02vEQtqejfbDbya5o0GAcH8tLXnKarUavPsS
	/8JsqwZo3QDJoJ3rqQnYh6TtGS+kdIsPRQAdh/j4SS8yWL9aZgT9zzRQB88acmlmlRBDhIk4=
X-Received: by 2002:a05:622a:5a12:b0:536:6ea4:e6a0 with SMTP id
 d75a77b69052e-55d89047301mr36389711cf.11.1795450806808; Mon, 23 Nov 2026
 08:20:06 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-2-hao.ge@linux.dev>
 <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com> <CAJuCfpHtWJvs4F2L+QCMe9gMJ-qmcj4Q1G4hqVqFe6Z6gPoQ1Q@mail.gmail.com>
 <cb8d8dc5-4ccc-408f-acaf-2f1faa0a1983@linux.dev>
In-Reply-To: <cb8d8dc5-4ccc-408f-acaf-2f1faa0a1983@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Nov 2026 08:19:54 -0800
X-Gm-Features: Aa3M54qAZLYw0m2OwS5IQ2Il_ZIKZH-wm8JIT48ds8WuRflK3snOxTbasMdxo14
Message-ID: <CAJuCfpHfz-nNhhN2kDgi07eTMNjMEh+ZK2Ejuxb=-q8wbanJDg@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
To: Hao Ge <hao.ge@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 10:17=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren and Dev
>
> Thanks for the review.
>
> On 2026/11/21 05:07, Suren Baghdasaryan wrote:
> > On Thu, Nov 19, 2026 at 5:02=E2=80=AFAM Dev Jain <dev.jain@arm.com> wro=
te:
> >>
> >>
> >>
> >> On 16/11/26 12:43 pm, Hao Ge wrote:
> >>> The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
> >>> since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
> >>> flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
> >>> GFP in __vmalloc_area_node()"), so an undo of a partially installed
> >>
> >> You mention this commit too, implying that vunmap_range_noflush() can
> >> be called in atomic context right now, but in this patch in
> >> vunmap_range_noflush() you pass 'true' unconditionally to
> >> __vunmap_range_noflush()?
> >>
> >> Can you give me the call chain existing in current kernel which makes
> >> this bug trigger? In case it does not exist but is only triggered when
> >> you add the rollback code later, then this patch is not fixing a bug.
> >
> > Yeah, IIUC this is a prep patch for later changes and does not fix any
> > existing issues, therefore should not have any Fixes tags and should
> > not be CC'ed to stable.
> >
> > Other than that LGTM.
>
> Right, this is a prep patch for later changes. I will drop the
> Fixes tag, this patch fixes nothing by itself.
>
> I would keep the stable Cc though. The next patch, "mm/kmsan: undo
> the shadow mapping when the origin mapping fails", is the real fix
> and it depends on this one. Per stable-kernel-rules.rst, patch1 in
> a series should be marked for stable inclusion when patch2 depends
> on it, otherwise the fix lands in stable without its prerequisite.

It might be worth spelling this out in the changelog to avoid
confusing Greg and Sasha.

>
> Or did I misread the rules?
>
> Thanks
> Best Regards
> Hao
>
> >
> >>
> >>
> >>> mapping may have to run in atomic context, where the cond_resched()
> >>> in vunmap_pmd_range() cannot schedule.
> >>>
> >>> Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
> >>> can_resched argument and skip the cond_resched() when it is false.
> >>> The existing callers are on sleepable paths and pass true, so nothing
> >>> changes for them.
> >>>
> >>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_=
pages_range_noflush()")
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> >>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >>> ---
> >>>  include/linux/kmsan.h |  8 ++++++--
> >>>  mm/kmsan/hooks.c      | 14 +++++++++-----
> >>>  mm/vmalloc.c          | 24 ++++++++++++++----------
> >>>  mm/vmalloc.h          |  3 ++-
> >>>  4 files changed, 31 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> >>> index 7da9fd506b39..0016c032d1e7 100644
> >>> --- a/include/linux/kmsan.h
> >>> +++ b/include/linux/kmsan.h
> >>> @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush=
(unsigned long start,
> >>>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap=
.
> >>>   * @start: start of vunmapped range.
> >>>   * @end:   end of vunmapped range.
> >>> + * @can_resched: whether the unmap walk may call cond_resched(); pas=
s
> >>> + * false from atomic context.
> >>>   *
> >>>   * KMSAN unmaps the contiguous metadata ranges created by
> >>>   * kmsan_map_kernel_range_noflush().
> >>>   */
> >>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long e=
nd);
> >>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long e=
nd,
> >>> +                             bool can_resched);
> >>>
> >>>  /**
> >>>   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_ra=
nge() call.
> >>> @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_r=
ange_noflush(
> >>>  }
> >>>
> >>>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> >>> -                                           unsigned long end)
> >>> +                                           unsigned long end,
> >>> +                                           bool can_resched)
> >>>  {
> >>>  }
> >>>
> >>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> >>> index a706666db097..69008b085658 100644
> >>> --- a/mm/kmsan/hooks.c
> >>> +++ b/mm/kmsan/hooks.c
> >>> @@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned lo=
ng addr)
> >>>                                                KMSAN_META_ORIGIN);
> >>>  }
> >>>
> >>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long e=
nd)
> >>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long e=
nd,
> >>> +                             bool can_resched)
> >>>  {
> >>> -     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(en=
d));
> >>> -     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(en=
d));
> >>> +     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(en=
d),
> >>> +                            can_resched);
> >>> +     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(en=
d),
> >>> +                            can_resched);
> >>>       flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> >>>       flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
> >>>  }
> >>> @@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long sta=
rt, unsigned long end)
> >>>               if (origin)
> >>>                       __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
> >>>       }
> >>> -     __vunmap_range_noflush(shadow_start, shadow_end);
> >>> -     __vunmap_range_noflush(origin_start, origin_end);
> >>> +     /* ioremap metadata mappings are always GFP_KERNEL, so resched =
is safe. */
> >>> +     __vunmap_range_noflush(shadow_start, shadow_end, true);
> >>> +     __vunmap_range_noflush(origin_start, origin_end, true);
> >>>       flush_tlb_kernel_range(shadow_start, shadow_end);
> >>>       flush_tlb_kernel_range(origin_start, origin_end);
> >>>  }
> >>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>> index ccaf158c5b7f..3c0d9e69b886 100644
> >>> --- a/mm/vmalloc.c
> >>> +++ b/mm/vmalloc.c
> >>> @@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned=
 long addr, unsigned long end,
> >>>  }
> >>>
> >>>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigne=
d long end,
> >>> -                          pgtbl_mod_mask *mask)
> >>> +                          pgtbl_mod_mask *mask, bool can_resched)
> >>>  {
> >>>       pmd_t *pmd;
> >>>       unsigned long next;
> >>> @@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsign=
ed long addr, unsigned long end,
> >>>                       continue;
> >>>               vunmap_pte_range(pmd, addr, next, mask);
> >>>
> >>> -             cond_resched();
> >>> +             /* The undo path may run in atomic context. */
> >>> +             if (can_resched)
> >>> +                     cond_resched();
> >>>       } while (pmd++, addr =3D next, addr !=3D end);
> >>>  }
> >>>
> >>>  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigne=
d long end,
> >>> -                          pgtbl_mod_mask *mask)
> >>> +                          pgtbl_mod_mask *mask, bool can_resched)
> >>>  {
> >>>       pud_t *pud;
> >>>       unsigned long next;
> >>> @@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsign=
ed long addr, unsigned long end,
> >>>               }
> >>>               if (pud_none_or_clear_bad(pud))
> >>>                       continue;
> >>> -             vunmap_pmd_range(pud, addr, next, mask);
> >>> +             vunmap_pmd_range(pud, addr, next, mask, can_resched);
> >>>       } while (pud++, addr =3D next, addr !=3D end);
> >>>  }
> >>>
> >>>  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigne=
d long end,
> >>> -                          pgtbl_mod_mask *mask)
> >>> +                          pgtbl_mod_mask *mask, bool can_resched)
> >>>  {
> >>>       p4d_t *p4d;
> >>>       unsigned long next;
> >>> @@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned=
 long addr, unsigned long end,
> >>>
> >>>               if (p4d_none_or_clear_bad(p4d))
> >>>                       continue;
> >>> -             vunmap_pud_range(p4d, addr, next, mask);
> >>> +             vunmap_pud_range(p4d, addr, next, mask, can_resched);
> >>>       } while (p4d++, addr =3D next, addr !=3D end);
> >>>  }
> >>>
> >>> @@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned=
 long addr, unsigned long end,
> >>>   *
> >>>   * This is an internal function only. Do not use outside mm/.
> >>>   */
> >>> -void __vunmap_range_noflush(unsigned long start, unsigned long end)
> >>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> >>> +                         bool can_resched)
> >>>  {
> >>>       unsigned long next;
> >>>       pgd_t *pgd;
> >>> @@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, =
unsigned long end)
> >>>                       mask |=3D PGTBL_PGD_MODIFIED;
> >>>               if (pgd_none_or_clear_bad(pgd))
> >>>                       continue;
> >>> -             vunmap_p4d_range(pgd, addr, next, &mask);
> >>> +             vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
> >>>       } while (pgd++, addr =3D next, addr !=3D end);
> >>>
> >>>       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> >>> @@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, =
unsigned long end)
> >>>
> >>>  void vunmap_range_noflush(unsigned long start, unsigned long end)
> >>>  {
> >>> -     kmsan_vunmap_range_noflush(start, end);
> >>> -     __vunmap_range_noflush(start, end);
> >>> +     /* The unmap paths are sleepable, keep the resched point. */
> >>> +     kmsan_vunmap_range_noflush(start, end, true);
> >>> +     __vunmap_range_noflush(start, end, true);
> >>>  }
> >>>
> >>>  /**
> >>> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> >>> index d8372a4f65c4..4ec114a75f04 100644
> >>> --- a/mm/vmalloc.h
> >>> +++ b/mm/vmalloc.h
> >>> @@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigne=
d long addr,
> >>>
> >>>  void vunmap_range_noflush(unsigned long start, unsigned long end);
> >>>
> >>> -void __vunmap_range_noflush(unsigned long start, unsigned long end);
> >>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> >>> +                         bool can_resched);
> >>>
> >>>  #endif /* __MM_VMALLOC_H */
> >>

