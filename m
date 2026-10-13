Return-Path: <linuxppc-dev+bounces-29357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CE2CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 11:18:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3sKP0zKCz3brV;
	Tue, 13 Oct 2026 22:18:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::830" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791890329;
	cv=pass; b=n+UMF8viY1UPoWd5GSbqdY9rk3waC0jb+tQ3j4fYExIOQgWMjf9S6ASiVxmKjm6Nek6FeyjMFUMV5AXIo+IHbO8hk8XTOEQxdqoXV8vlwuxymxTLlQJIy/joAtXM0yGQ7i+Ey6U+8h/cg0cOaraUyBWl3M3Xhm7iTXDx7Ojf77G0Vwc4czZjS5Hmvjg41tvGA2q5En1sBuKWtWpG5eeaDXLVpP39OPg0MKog82IKmz+sZSkkrllmUUMrsVx9ncX8U2odxgj3pz3hVwpdwwLKlNL8m1q5pR1heNyLjS7N5p5iTXzCaXfAk6fQkiQHdglqLKtFBBTO2yCCwavfmHMCQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791890329; c=relaxed/relaxed;
	bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkfEktyVZS0DJQqVsAcUttZsB4tOgMWUeJxk/mqCkFy2/rXj8pBh/cgpZE6jQ7avuutHJ++KT4zv+T52vsyzcrRsQk0pNmWMOT35uEwTs7RnOOsMtp8DdB7rqlV941NmkhBj3AHIKV7WazUphiUASEHuyZeMoFcHz727ge3bQR1uuYSstMZ7HZ+zV0f/sdMCUtTax/6a23Q7q+VYnM0aDCt4nOpWjYtb85YLL4d8eGr/BmalMxr/1oIgC/9ZtA5sd4YlR2+5OTbUDjpoy4V2cHytz8ONrF1Re494wzyuTyEtb72blMYYreAIsXRQJaoH4iX270Dik7dPYfQYFowHoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lWVJxjhK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lWVJxjhK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3sKM1wNSz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 22:18:46 +1100 (AEDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-5337c7b9937so706241cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791890323; cv=none;
        d=google.com; s=arc-20260327;
        b=Nnv2BqqUu2pcRj5CQIUEUB1zvhja8ydTCzmnUikUX65y3TkClHJbI+kUW9wEk4lEq0
         wtDOu3G1dLWC/4fGQfBqBF/ryMTSp0yuwz6NM1bLG/6DGZEtznoIM73LZYU0o/z2KDUF
         DJNZ/VpJIxf9zC8eFgJxKvWoEOD7FrysRYfK2h7HGerXU/2OkzgIxEKuIU+1s9f3F9P6
         bBGl6h2GLX93IGGIW+gPuhWmx6/U4cbtv5Q+Qit+iDjpqeO5ITKaGbMDrjig1RalVCfw
         /MD5leXNdxRUgAhvBsDLsw3ClJ/JktyHoKeozeceGepWpzSdDFKC70FUpzbE1jCInboY
         VtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        fh=RVNemmq/ICS4xuMVBSm3GziWp5ZWzg2+3uMF1XBHEyE=;
        b=boP7Iafn1b4fWF2dgL+wvX+DryC8iT36/sEFOYhKZDN29WNYJAT2Ie3bBI7vPSvXm6
         sA8GE9MdQ2wv35tFgVIKjaBeHsAUaiHPNqU2jab8Vnf6I6FkM+I5HE3cvCWYEhKtmCth
         XcNZO5YNEt0VSsQcIgVFibHCb5XWJobT1jSswXgL12m4F55cffAJIfC2bMSUJv5e+X4c
         egObi8+ktpRhGOa4R1bf/4E5tvSNa7/PxGrKw47i4cG6P4WMMgyEue3MTJRzeiffDAuz
         HW29HE177A9HvTjIdZ9rzreV/ywjJLnPsVrO6jYqKJggMIBfnk/s1J4YiSCtemyaIUQy
         qnzw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791890323; x=1792495123; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        b=lWVJxjhKLV6mkDpZvkCWRjwJXCaCfSg2TUCBTPV75lhpgsfIAN17HMV9HqOQarzbBh
         wBHFufCoqYqAwkRvfHxCiwu8gCZB7Bp+Nvi+0Yg09AbQumvxiSybNz0ORBk0D1Jdw1u6
         QjK0LuRJjndGRQ4+zGPb9YGs6qiFyCGQigzuJt4pouoTmHTxkl4GAp85yDBMVKhz9v7Y
         STJWMg/0nu6GpvNk/KQubT/GVWCX8i8Jwz+ZS4eUHUgf0oVtTLA9H9DIz10r99kdhas4
         Udj8tBLai7xvHJnoUlPlRBkW2jgyYE0kd8hmMtiZNrzzQDD5BbpEWQHKqpG2XYfP2aV4
         swvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890323; x=1792495123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        b=OlrfDPzzmbmMIM9LvibeYE1eJ7Qn/lpttI/CNy4d2HjNqNd73AYIkNqj0cB4TdtSqm
         ckiwaX8IJ3nhaoBH08wYMAL99Py0G2veQJivwbEaOV6osD8J22bxIABp+dtzbCiMsiNs
         TCfIRwgoGxdAxImuIjU6iZwWw+8+/xFUTr2UhYYbDAK6WrjWbWOiH/a3kHaKGdgVOgKB
         9Std8qwyUFo5d8UuxeIYGKDCwraceFlJqUHgkSV/pWNCZlp3UYES3FCgcJ/7jYNv7XfQ
         YTP+R+dx61Sh8QBqhlvdblJq3L2i5sO9ARviI0Nsz19DAomwUH59imTT9/5Qn2+8XNtS
         ydkA==
X-Forwarded-Encrypted: i=1; AKwUvBwNKjT2bE1tI2YazF7y/KkakHg6aRKO54SCxNdqvcr8qCM07zVuHjyzuS10g35NjnzndbB6Z/Paa9JCptU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI0hs1z+bo6Gt93W4l0x/XpaMJBEPNHK+v9dV8hMsUN38HTRp0t
	sIqS9adBBQ9Am/a5Uw8988rR3pDBc/U/HO/0SaoZE3zUuJFQDwHGUFHa4T6r7gCgj27Y1PHOk0s
	H+V2C7g/S9ua8nBPoIGB/MvIvBDQNwv2BDeuQCSkK
X-Gm-Gg: AYBFou1kTi/pA6sA/PD/UnSnNgXKQOb22buzo2eUPaqN6XVRWrUInjma//Vn3U7onwX
	xlTs4cJbM7jsIwG7vk/CLgHeDPKQjdziiLU0WYZGp+e33QoYGO5jZLfDnoopTu/I9XAbp9/EkjR
	TYpMm9EiKRLD1kEBPiAQ11wHhC9oVF1vzH8cnrBmL60c7nM7hAz2gLE4KubY5nzPeIHsVNQIhrl
	EqhzSyBZYPjLJnPNAbwHBKv8I7jgCsRqGbz6xFqYe2fMx1NzbTXPFgMXJBRSxNJpecRyocj5JKr
	+YyF++MBVym8RbxcTEKiatBh2v7JqRadL/e1egql4d71M/h032qO8mMV
X-Received: by 2002:a05:622a:4cc:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-535b2910266mr48102151cf.0.1791890322506; Tue, 13 Oct 2026
 04:18:42 -0700 (PDT)
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
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-2-hao.ge@linux.dev>
In-Reply-To: <20261009063619.112313-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Oct 2026 15:18:29 +0400
X-Gm-Features: AclHuK-qvcUVrSOqAHUBuFhMyipfniAtX1mtGlvajg8JTqSPRj6kAwYVpLqLul8
Message-ID: <CAJuCfpG4Zq6zRyvXkf40XcsiMSvS78Za28zY2xcaAh=kXpuD8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and BUG()s on the huge
> mapping path, or gets -EBUSY with a WARN_ON() on the small page one.
>
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
>
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_page=
s_range_noflush()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


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
> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>

