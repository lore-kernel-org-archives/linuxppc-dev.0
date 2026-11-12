Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B413606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oZGykpkZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ1Cb0Jfrz308H;
	Thu, 12 Nov 2026 11:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794442602;
	cv=pass; b=M8CW9Hjld2Ofy2afUsvc2fcZ48s49pyr0cs3i//onQlOrGUcHviKuwY2eUO+SRDOe4cZKO7pgPWCXooYl2MtrL7uVHAkFUbQe6ITZb3NgQTGrZb2o3uM+FOTAQOwDc1UKcpM37wh/8iZgTalVPo+ig8Sq+QFxJ1BKoAAh0HqRUEa5Dha19l50bE13zh6IvLooyA5AF76euL1kH4u/j8Vac2xbiwiTli3Cf0exmfpDTbkPq668sSbs/wf0ajOkkSyCCdotqqfkFr6Y5wXmxWLptkM2+LnPOO82AtRKfNKNELZNsBfH9sPxNBrnsaHYHlBW2m9TciSE9+8jR11hoaPMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794442602; c=relaxed/relaxed;
	bh=SFwg5Wnnu6Xe8mLPG0VsSJGBINJAyrjERL8cq1SoEgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvP6H1x6rDmUvCImreOnH6plV5wF461InqE9viYleGSBfoKCRuN2N6KFxCICQEbnF+rBPNR8q3PXxAV3usc5UIwx16Opp2Wo5AoT/7PDINCi+tDUNsOpzcXU83FiAjB0Ug3LOIsVwkGX2LseuxUL6+0lhgXKaLVEhr9L1X04GUdvGOWFrZmIeXyMYLJE71s0iesKdAxEi273fdQKZV9eoPYgT6OuMCR5zKR2i0hEkAEcL/FTWl/ZgO/P5AngpHrsfG8NG9GoKD5aLy5dqnRaKgEGYRzCpG9Z87t736rRIRnzlGvG6r09ksmeos1xl+a7ymNxT+Vdm/wu9IQAZqKfsg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oZGykpkZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oZGykpkZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ1CY5QnCz2yqx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:16:41 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-54492d8a988so53711cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 16:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794442598; cv=none;
        d=google.com; s=arc-20260327;
        b=fPFbCK30X3KGXdMol1xxQIIiVW6qTNOO5QrBqgl/WqjUllgU563jGNRjWRWFoQ9nsl
         dg9qxd0d7PZGcez9lT6mCozMrtc2A8bV22mpBx6EuraDIEeyxbY+iztQEL/mY0Ehyo49
         B9Hy6rSj5d+Ta4+dRolcTYtbIJ7DtMGDJgUl9K/qNtSb0s5BOT6ViGLdXcxs8To36jWd
         R7B5jZ9RbklBJG8E71NYsa2KD766GRdYP/F8L5gUEss4rKzbUIW22LH1KM5rb+hFzjyV
         WeHtcXKki8H85s7BHb5d26YYDKffaTAcG8SbFCqt0K1MJdf7RkMsg0Cb5ap6D0GBJw2O
         WDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFwg5Wnnu6Xe8mLPG0VsSJGBINJAyrjERL8cq1SoEgo=;
        fh=n8Iu7Wqi/KTTyo+wuPYvnNvWsX6vgpL8ybBVp57Tbhc=;
        b=d4/ZzH5CNfQ5OsYgjvneYcW8OXgre8BAm5LTTseyb26Gg25zJVjMFd7cxEASlxxnrX
         18njaOvtzZmUG58i45jNnFJwerHkRSbgU4cyn3xyKSUR7w3O91WZ0h/ZUdT+zaJhItA2
         /gjLNSn+FET9rAPbHSMPBWufxtYDGVUaOcDkqcEdPyZgzQC57sWvmrnj/Ouofvgh7BJ6
         9x0ETQ3Rrcu3Sf09Yd3C8e6LPAMUZu5IJiIodwtxwE0QyGgEJnLcpAI2GzUyQVQOuqTl
         Pop8gvRG9/coSqswHXEi3cQruvbQlOSQIH9cJKPNVQ7/Lgt+3zjm3aeqe1gp8cIilA9S
         yFSQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794442598; x=1795047398; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFwg5Wnnu6Xe8mLPG0VsSJGBINJAyrjERL8cq1SoEgo=;
        b=oZGykpkZ2pOm8krkTPxdZNGUPhINcEkOoW55wh1AXPl5bme9h63rpqYXr5QOjvCkpb
         ejZWU6Ynu/XnuAOXqt6LMth6c3D/6dH+sGQd2TdmWSvK/T4H/N0WZvlxbOvWelYPyRmi
         in3O9aRzfkaDwM9jgVyuxR5TJuiXtKzB8ks1auGHumfeiObQ4vYu/B9C7aZ/rIYLrIau
         SaQ2x/qN9g4IOQ8aFOvWMfx9+QZVzf++f6nuyInO8Ez06FWmRRLdWTFqZr0gGh838yA5
         owECRn4hZ2ykpmteQE32usTpX0jeQupx/acdQ/yvkZqCkLaQ9jchQ88uBvQ/ji7zk/aH
         HLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442598; x=1795047398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFwg5Wnnu6Xe8mLPG0VsSJGBINJAyrjERL8cq1SoEgo=;
        b=CYDN/jQPiJgN27CKM+Z3sh0LvZXUMi8LEZfSl4ZS8oFwFhTH19mtdY5DBW9LwxojfD
         CZJVBiXtjbvs9PcwtFmbBNh+qIkFT+FBPfGWViTDGwxEHHbMXSzO7/di2sJs8pqdFtjj
         jLN5oLk9YewF8wVQqg00gnj675bhMeMjD6zghkBmTH4KMSThl9bGBUjCYBQanDkmdW/B
         9GcVayApfc3Yskt3dtd+KLnc0G/bGlSksyb4Q0nRh7FoNRPUGjGnRx6bRisSp68iVO1G
         5LnMZlWANrtnd9osirgtrB1A7m2JsaH1D3PRc1tLUvUuu63kJ6Bf4GNPEQfNS3eYcCcM
         Lpfg==
X-Forwarded-Encrypted: i=1; AL+hErGW5zQS32ryQaAnh2Nowli9CDYwLR66i5fVfqf+aaomoOnlwWDh78w//SNk9ALxPwtX5rR4u4jW5Yt2aOI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+RLE6tLpc//n8RXqfW/rP5jI5xFQpXzjTFhdaW2MUDOHnwnn2O
	J1oEWrnQs1jV4Vcsv7cAbKhs6xVPmxEAXNDPiE/AKzS6KU0uKALy8n1y1VqXvQQTrmO4Q173/0E
	dspgCtpCY4BHuCwhKxaxPLe1seP6vtIZ/A8m+8BwI
X-Gm-Gg: AYBFou020MnP7oz3SKqKnXG748+1J/FNk2i1CInpwn3QPZrbNqLNsosHJnDhIF3E4uy
	QtfkWqnpMkyrTKAsKSX3vSNZ9wgA25z6wkFjRmh1oPA/i1XKLqteaiepTvtcD4AfQba5jfBJXRs
	ZbOhf78lza2WkKhclLcQSRfLTfM1CwJNQ9cfP/Y2Emb1ozITurGKnGDJWoxYSnnQOnYcI4Oq6YY
	fAe+7cEjFP8XQmQ/HrOAWYQUJEg1c4e29oY2mAJwEKCP6uJHhMUiZRyDbsSg46f0HLj2B+Fd05H
	HF26pxH+NWGQO4/D0X4K0bdWnlOq7AJOuf2dO0p7fZp/UDtQHFHy3cElj/XPYsR1VoNG09AFUnp
	IHbB+G/33XVBztFFDC03iXgnbOKpUJMsYWj0rdrVkBOSwkM+veeUHGP2GyNuLWt2QdT7lZgS8pM
	Ljk1lS4rSPgU9pKGcoDBW7B9sd
X-Received: by 2002:a05:622a:191a:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-5596ded2f3emr7342891cf.3.1794442597663; Wed, 11 Nov 2026
 16:16:37 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-5-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-5-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Nov 2026 00:16:26 +0000
X-Gm-Features: AclHuK9X_nBP4XE80Cus7A2PIJ2z-t5IzbqPy7J7kM6JfZcsfXvHNVWcxL1W9Bw
Message-ID: <CAJuCfpGMtHZSUhUra9rp5xGvD+L6reopCMb3qXgRSctQ7wnYFg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] mm/vmalloc: BUG_ON() on an unaligned range in vmap_pages_range_noflush_walk()
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>
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
> The pte loop of vmap_pages_pte_range() maps whole pages and stops
> only when addr lands exactly on end.  An unaligned end lets addr
> jump over it and the loop keeps mapping into whatever follows the
> range.  An unaligned start maps the page below the range with its
> first pte.  That corruption is impossible to debug afterwards, so
> bug out on addr and end at the entry of
> vmap_pages_range_noflush_walk().
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 27f2674a5556..86fbb1d2b27a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -698,6 +698,8 @@ static int vmap_pages_range_noflush_walk(unsigned lon=
g addr, unsigned long end,
>         pgtbl_mod_mask mask =3D 0;
>
>         BUG_ON(addr >=3D end);
> +       BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));

Instead of BUG_ON() here can we error out early in this function's
callers (with or without a warning)? This is a static function with
only 2 callers. vmap_pages_range_batched() uses it in a loop but I
believe if we check the original address alignment then consequent
calls are guaranteed to have aligned addresses.

> +
>         pgd =3D pgd_offset_k(addr);
>         do {
>                 next =3D pgd_addr_end(addr, end);
> --
> 2.25.1
>

