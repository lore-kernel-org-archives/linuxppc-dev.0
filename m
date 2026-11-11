Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1D606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjlk2HdB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPwxQ6stLz2xLm;
	Thu, 12 Nov 2026 08:04:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794431050;
	cv=pass; b=MCluJZhjPPlprMl8MugsTt67LjWsmYYhdzBG5xYiKGpojEyjLY3CidlWrxtMPEsK/a8DOIsYHHRFiGjF17wNNJlWH/0v7XtDnqtTldpTh5wfOyprAQnqs3Kd2Ekk4yGUGP285B8ySzwvzfZLij1YS0syDrsXT3gQnaiVqn0FI5Eoam+UXZBmMrg0t8BZFxkxgTNuq+E4F7FsNvT1nNBRLcYJX2ST24cCKmyZZloxQNVAAo4lmghPOAwPQTtnnIL8J+8qllUsi+tdJYnWhnj2+pRJx78lX7hcfCObnOQ/I4XJmjjy/ixMqKy5fBowzmU9s/fQDhrFvTkQd1eLzZktIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794431050; c=relaxed/relaxed;
	bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pis0Gamw8Wy9b7ElMR4WG20e3TYe6gXISC9a4fhYF/H8WYDvhZOUA1bEwbq27F6GsNIuE+nxyLhHYSEHWZYEkrTq9xvypVDQ8psshjPqbXA7bGIM1d+OLbmqeLfqM7jl20bTCSO562qewYgw7bFkn9ugkN9Iix5D2a3HIoiq4Wm00p/IEYBzB+yoe5A1JSl7Pq3ghsoBYIZHFJVZKKhCoxehVvz1fyeRXx9cNUwOJwnnPRQr/ocKI4KARVNQBMCxMxsURrpFriuHJsp25JvRPRTQ1RUhyBo+HmJ/mJAH8WaVkGljj/9dESXYPIKm1lsUv+nOkIVE0YtqYIYolVl2ug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjlk2HdB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bjlk2HdB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82b; helo=mail-qt1-x82b.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPwxP5734z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:04:09 +1100 (AEDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-533202fe429so9051cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 13:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794431047; cv=none;
        d=google.com; s=arc-20260327;
        b=frPlU7DSxf3+jeexVKO9u4qfR/OXnjO0t174rUR5FfsMRLvONmQeXfN4is7CP4iug4
         g9R2NrsKJacD6AWyz18I4BjnfIQyKMvu+3djlSRqC/6uyubc4MviZl2ME2kr1PW1Utez
         4qDzPa40iqsmABNaTqDWPTwbYjhlpNTmXd6pYsG7DjfQfH7pJQA7jOsNXUk/DX6yha+B
         OwdJsslFkFdvqX3GvPS0dKDbDpFG9mR4ZxcNaGIftvQy0H3Q6twTBkvLfvcoZuBD43wx
         rkMHghF7g0GMTngERGvGfzHf7kzDqKMPAhfaDuXevsTu8fcRprm+xY/XA82Xpn8habau
         Swew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        fh=vpctSWffQWZTwDqFRe050zUc3MLh/6l2wGmMWjvV3bQ=;
        b=g/A0kyMSIc6kWvJUo4dRC8XKs71vFDBuUEGqX/0fEHV2GMEvSfCqo88h/VuCo9bzt1
         +k1hrW+MCcPZF5S1U3//SMZ9dM0YZBuqM1avWJVRGkEYLlmzaWWnUGVGlgbN/HILaRUF
         qt+19yJKTxrhr75ZIiJG3ohwsMWkLqdNWV++zWBCnonHT8qW/5tp6RodEaRme3veFqOO
         iUu1bPbEyrSiKZw7lyFFnhC7FdT7SlMPK500Xm34UY+Lhmf6P7GRnLdTTW/oBVObF2Ek
         yWseIGvs/V7q5j8hilO9yd2UeuezdG//b8X6MruriuVkrYUziYHnax2HC4rJyxwU5bxk
         3ZcA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794431047; x=1795035847; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        b=bjlk2HdBD07wvoITdbBl8eWbsnFR51TBi+OnG0JXxsyqMSPBAEiGH1UdsnOarmyx6J
         smLmUIINbABBwf172YkFl8bB6s8JkiFMgh2iyxpue5wEn6OS/apI/AxcldHqpC6FMHCj
         4oL3dMswiYHh8hqGd+vInIFLwp27blpj61rFLOzWeOCJjh/uj/45VHWouls+sb6s5i3P
         xsRHClHgpalySTITIYxBFDTXFZdovkPjlWqeY6Inh1fypBbUi/tbpOVel1SjthnvwII1
         nWWQ8dwkyvQrdz4kT0rc/plW8KFGKj/fQY7/3aqBzL4Ltdl9Fq2m+TYzHlpU6vWIbcE9
         vPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794431047; x=1795035847;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        b=VKQ1Y5ir9ye5hrYlJUan7pduyINsupUwE6lkx8o46vx5yBd/kk/GKIGg+fxS42lGsu
         Wo+yjOf/YpHX7ySC7sQF6X99uQQ71eh0vXx47tCFvCtatt3jFadE2lCFKquYhoqsGn9C
         WEIhkRI+XF984GeYN9uh4l6TzxdV7baZtVCHbrI/+e2Up/2F5+4hPzWRX4BmeYcDcE0g
         Zsueb60waNc3yP2EQtqsCGm04oh/DXOzs0p0H7QUT2IN5SpgFI3Li7TX/LR1btpps6Sb
         kJDE6leZyREMyxqTsxm7M2B02gTxhcBqSh7Gees4ExO9Jy4fA8RoR0ti4nCup3KC/bZ1
         VY2w==
X-Forwarded-Encrypted: i=1; AL+hErFdc/5Z+EMRKM8fZ1cWKbo4TB6OJeF1g2nl+JRUuM9F8zOeUzzYkOtnWgcZyP+vcXeD+fTXWfJoyOTHWBg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8otcw9zZr4WvCRlBahIoNVWUhjUXDCgewihCjzl3Gv3YJS20wh
	d5O/dZztYMUQSidWA90woGCGPfJnvzUjbgNddv1I5bfvJlR0pz/ewXHqHGt2jl80kQSYkm/wdoO
	iH6c9vm02M7CAetUe6xUCZNr5bB2Qz+R1KQ7/srUW
X-Gm-Gg: AYBFou2yS9ihOt5RMydWrEW8iaD90rk/LOI918AHQAZ4bH/P+7tl+01MCR3NYl6frOa
	Onz8RnEzDmPaDSKBnVtBVM1QotvunhCRMS/IOqNHD9aQ48mvw3d4XKYOa5hHgWaX5JZT/do9MLj
	EJ8HoX0zxQOk+QIc6wNPlj3qTvpMHx4cp77Fug5r+sPbDgCWOkBqfVCFm5hS5f2WThSB5PLz8O+
	4LX3rVg+eVLASaYMO3a19pGbsVrNIUVSY7ZM03rzZVCK1eZxdUdfgs4y79aEw3fHqeb9CM4c248
	mCeNNisymFWuiriqPnIDBf+1jvqsrvfb254xwzu+HsEysSpL6p9Kvb3qNDkIoRrR8ZD/6TQtbCv
	2Ad62vqQ6SVLBJ88y717mOUy65eb8G8mq3GjxTfxE2Woh0ksEyTKQrIyLY6QA0+WL8uOfVYz89t
	IvTaUZWwaa55+tv7G9O/Bcmrw4
X-Received: by 2002:a05:622a:2612:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-559670434c8mr4152141cf.0.1794431045881; Wed, 11 Nov 2026
 13:04:05 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-2-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Nov 2026 21:03:53 +0000
X-Gm-Features: AclHuK9dy2sCAhDvi6AKjzXMWgnJES78GwGzZ1LsZZk9UkuHFg5q24wLvar7eig
Message-ID: <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and fails with a
> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
>
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_page=
s_range_noflush()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..2166086d3dc3 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long sta=
rt, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end);

Sorry, there is a problem here. You introduce "can_resched" check to
avoid calling cond_resched() later in the series (in patch #7), but at
this point __vunmap_range_noflush() can be called with GFP flags which
do not allow blocking. Before recent Ulad's change called "kmsan:
remove hard-coded GFP_KERNEL flags" this function was called only with
GPF_KERNEL but now that's not the case. I think you can move
introduction of can_resched flag into this patch.

> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>

