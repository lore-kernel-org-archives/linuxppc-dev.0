Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A567606A69A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5BDW7FY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWSlF4wdXz2xb9;
	Sat, 21 Nov 2026 08:14:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::833" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795209273;
	cv=pass; b=N1hltm6C2NcnqwEM8LhutLbIXZrdz65Xn6v2PF7YfjvG+lgBO0tpefKDx2VRdNgJh134Wbn8vj/BVtdJyxli5kvun94B0vLIabA2oXhcsCWqqI2RO9w68FYpR4JpTV/k+76+ecFJD3XMl0sHOToDc5KdOj3j0YbbJ0AVytVrPK45VMhzwee5K7tvdcpOLE9gjUPicRfLQ9pzOnGXk1GZQSaeLYQSgbQakDK4JcUaXucz3sSwUywLQUgzf7+A5hkQVmZFa+KB3QK/xWN3nse3EgyEGUKKuP7q9r4Gl46AJpl/TFzZpxNRDeAhIyr0KIZwRMPBxk1EE9STDmT4IY0ukQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795209273; c=relaxed/relaxed;
	bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzUdzgAKA13G4snpXnCNO79h+UjlnSOvn301ofTekqaSaxjc14RfxPs1MFyTyIjWOqNk/lcdSlSkxlm10LnlL1iic48K9uByokuHlrIP8gxFFFYWjh5o7khMMbGtg8EsNWHSDUj3pNbGT81BqD7Feoy6TllLazyiNwOHil+9wTtiIvySh1TELj6UUszOQEh/ntUzTmWb4W8I+IsXD/l1uOZgnn0B55n2QL3+exLukGt+HRiDORPxm+U4CIJkzrvxLqdu83w1tTSo1PV3IV+FcU1SNTM/KDjuFQX98P++me8QoJl/63IuSmIrFNocrLSIAo1fPm5Q/tvIzOHQUvFOLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5BDW7FY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p5BDW7FY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWSlD57BBz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 08:14:32 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-54492d8a988so75631cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 13:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795209270; cv=none;
        d=google.com; s=arc-20260327;
        b=Zz0eU6X/bAhnasCctpgSMymXHaRIJlInrh9ovczlxBqh8XKT+hw2UnIpOC0xIEh9Vb
         bwlbN0aPlkNEmUlB89lC5mqQWUD3RLunLs6nf6cXRQ5zWDopEY705H+/OzFuTmI3R7yR
         MzGul5sytpFB8zeBLLVfAkSKJjxcBXst2kiFtrBAw98J/PfnMiaGMbNj8fY1I+geIjo4
         CikI4zCR9u26aRrIVtCU9enbbiznKF2zb5+KeJaTAfFoVmBuwOKvvGCYG7ZAY4rSkphW
         UF7qjG7IzrQL56wKmFGDz89UPatJ4lnH2lHnGfzxVvkGuoL0w12UshtHWgwjVKODGOWK
         Dorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        fh=XngzG8V4tnuzofKhtz9sN+r1whxPGwMi/Ft+6mqqsF8=;
        b=HfFHlQndAjJpT0FwKHem7yf87sXpGQQlTfvXGI9/8CSuDtdTnzMXXE3bwDlXmF1z6X
         iv/Z1P94djJN620BAsGNdXSu8npp2ZqlFveBEdmJPMBiIbPq809Iw6s5u6CfrVEZ+TRX
         QZuJFb5MtYmfKcco1ECJScN589FbammV7mDlbzD6A4LfU0AIvFwacM91vwp2dZ6T4E4t
         RMESeeDYzwtboeZzw8p3LOwZ2m0d6ND79Ls1TO5yAM+/Ei/Kywg95WOILQtx0YIqh2sh
         1y3IcF14D/jquUZeWQzZmzRf+9lJbY5EPmSQCgcm8vRpvGThqj1js0SMHi335+OLCXoI
         R9aQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795209270; x=1795814070; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        b=p5BDW7FYi6MaFZcIlAO8zGn3mJRIcI04oc8UZUchDhAzdSFwpFxS45X29QdSS/I9sh
         E1loKOJ3TqzhIrN1eKBCfKM/UPLDzIfopHpKVjPZnxzkRkTp7eXq4/GTTRA2pBa/1rON
         1h5uN5juSi4U+3NmIrh6iKbROrQspItLLtZSgGEjz7tWE/d2XOkGHtt7Rb277c3/Vug6
         +NjThvdCzAm58Bf56NsPy5zcFxtBim4c49YwT/XC53DJSAGmqk9HRBAnupE6uV2Zgyax
         tDgT0vzd8X/Jzh1ydUHTucos57D0vezHciqdUnc94LVC+PCvsr1CrnwVE23Mv8SckWen
         /9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795209270; x=1795814070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        b=iAdejEE5SWQ1uI1buRyjHlzYBoNrRcwpT8bhF+OOa4+PgrAKtqPnJSyYQsnJdzqv1f
         wSi45AJePZGGQJSTlPGmXZ9itDYcQOPlkZvW44qKYDILESWOc3HXWkV4PhoKd1cHhPo0
         K9jIYloQInS2ABZZvKFAiWGDpZeJt6qfbQgnBV7LmaRb959hvaRuob/Js4g9lGHPNbzr
         DtRhO6jqglgArxibqf7vlQWSdCRbe6/MZSBp4iEqZispja/T+WYbAn1kpH0od3OShtDr
         C//Ui4wL0AxT1rGihDsj6O5czW0Wbrat2/mP+RGzFZFTkW6XBvdvJDNqx4iNZAgE0BpO
         musg==
X-Forwarded-Encrypted: i=1; AL+hErE8ITqQOKH9iGqhpd4J9jvvJ3vQ+qs7Ka4CGsTnneGZmb7/K2M+KJRD6FQomUG/W9Ei/eeH3P4bdZk/LH0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9nEYLQNSx5MOFsqB61Jh1J4n3kIU2bgNz+bl9kOy3RtFVh7iWD
	tQdSHbW+c/fDQzqmP5g8XnXhUiyXd+maVlQEZkxMw1vjHUZths5XA/ht/2ZD/5T8c5DDbXsCOJ1
	Zk3vDfDa3YJEv6sJsb1qaaTVe88d0DljNjt6h67YQ
X-Gm-Gg: AYBFou1+yvimaogDoEDkUi/QcYm3XvYVsZRxQf8Fk21kJO00QF6dElnR7EvjbvFtEOU
	F0Pbo4ZffHsyce2E147eDCkywD4Y/fXuBfKsdh6COB92fllMpyafc9DhyGC1pJxn0sVJOeJrY/R
	BDymElkNS81QJRHVI5rKDXZm0kBzSGZCJ9J7+LiRgPniGLEEC6rk/ao9XEaRZ+hWyd4+Xn/D+/c
	BKa8zmyePT+NYwZ97YM1oFIoEXLP+nR29QSq9kEcfmsBBGePRzsIDVORGgd66PUjKXyIiKOXVeP
	S3MHR9j9oqw++Krw0eApVWBH4ZtCZt8vLv5CDjly8tHak32tn3HN9zrY2zPi68OtVwVQaCqJnbN
	Z5aTKU4kU8KwoLkF855ZwmBTYsEFsII1A36Kc3uEn4g6v+PsycjkGsL6ahIth0sybdmoy/hbj0O
	Nbb9rb9zvb0daBYC2jOpENTde4
X-Received: by 2002:a05:622a:c15:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55d88014944mr3792091cf.2.1795209269050; Fri, 20 Nov 2026
 13:14:29 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-3-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:14:16 +0000
X-Gm-Features: Aa3M54plrOc1jkMpHJwvUpjhSrspGdyrmpubZwGwGNbiFNMddwdSWFYtVtM3KLk
Message-ID: <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
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

On Mon, Nov 16, 2026 at 7:13=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
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
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/kmsan/shadow.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..212449db34a1 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long sta=
rt, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end,
> +                                      gfpflags_allow_blocking(gfp_mask))=
;
> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>

