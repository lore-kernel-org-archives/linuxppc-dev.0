Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04FD606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lC+ch6oY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHfh7023lz2yf9;
	Mon, 02 Nov 2026 03:00:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793548854;
	cv=pass; b=egPJBc6Uxa+z2lPm8aMpu5njFqjSx0hSWKpu58Gym0j5mNTwBMFyMP8T7QYMNJMguFLh1LdPOL6qsF7PHBgfTTCm0FswJb6N/H23I+HNEwxDeqx24TJsf79SMfxEQUyQQGJsxhh9sUNMwUWCYN7p/Mk+yURhIn5cy048S4PXjyhjZ2HWnGB3Ox/83XSw4tTe2C6ph4hsrxbu5I3omL8PEwSvPHRGN6cy+tdXt0sjWYRYbVh8pcxSrBdr+206Gjx6VsBymmvr5DXtuWo4OHiLOyjTqGxWFIIv9Hvtla+1GQWFkEuir9Qsa90MDtWjf/yRgAtntok5poHG+8Opi83vMw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793548854; c=relaxed/relaxed;
	bh=qKQDgkRL9E3S6U2cAM4sdtFLp25slrgCe2pH+1FhaxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCt0hIdXO5UojU67CSTQXEwH9gj0MshDbOVDCugdzwIt32q9pDnAs5590JvSPEfB4c1jmEA4bdMoR6VmbWtcIq6oPLm06dK1as6nbSG74Ns/Y4TfCAccLfTQkPkperE44zG7/72SHBCKzTjXtqgi0zTkLk0WeFCd0W9zYJjtxiIfcRuyIUHMeSIXbWHqYjrW3hrXjAthiLLj4diOGm9lORRY8F/xgA7f9BgayIXc/H/mpiRU9LCVhrfK16B2fLry7Exr53ETKhBAEteZbFM5+82WybMZcRs9Q1Y9tSCx5fb/i1hFnadU5zwzMDtdfidtsQUP994GgxH2zAEy+fq6FQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lC+ch6oY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lC+ch6oY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHfh501Srz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 03:00:52 +1100 (AEDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-535f598d126so190771cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 08:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793548849; cv=none;
        d=google.com; s=arc-20260327;
        b=C3GsvFoB35tB5NfNtCzSo9G6dnijjv4XMQcFuAUAeM4RN0MYK8gHNOuIdpB4FjPLYB
         0UjN79PxvEEBmJ9e//T7CtpCo2/hCxKZ0EkOgxLTwmQqQju+50WU49Ayf/RkSS/TnhXv
         dcUpShUyv2Z1DP8khb/XdGB2d8re/V+C4mQSTju+qlDZVK61YIZKiR56hCLXeWI+bNoV
         5u/KbbPKax5ssQnwSV9WcTJ5pB70uDBb5RZ0PHX5i6z7oWoxkQKNqZ8ZkpKBOvNhjmOD
         +sL1ZG+nPzbtcRd8VqlpT73WkwnNd3BP49mFlZIPbWo0FY9uePdnasWNsYw/fhNXtvZg
         T1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKQDgkRL9E3S6U2cAM4sdtFLp25slrgCe2pH+1FhaxY=;
        fh=oDBaZJDiWln2/SyC/Xg7mRLAwGvUdij1Iy/zr8io9rM=;
        b=nnMZIjrqBN58ustzqYeAZrsWB89X6l6LjwkD9W/cFO8lFri6KrlyRvkonKcp0Lq/+8
         cS2/3Xc4jpId7Hr026FvOf0ajIK0sE5Fgw500/OvLTMRZL/sseendBGjpQ2oM818Gfp6
         I8hVdb6enFGd/pcrH9WQ4/P46cN1BZo4BSo1UmntugNAhimyplAMcYCrqGZFvv9oMApP
         K+ySBL23iH2qBVfesA8LUskUzuOhXUOhXGTYsuxaZ7FmZ5izcaLcpmBd6YrpYMCFbJNM
         fO7wcNteWb0iKTRNPhio5VTtrPi6bXy4G6SA5cf7SdQwoOqXyqPEmT8OvkL4ZC62TZCN
         EbVQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793548849; x=1794153649; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKQDgkRL9E3S6U2cAM4sdtFLp25slrgCe2pH+1FhaxY=;
        b=lC+ch6oYI+WChybdguh4xmTo54PaFdCBPAcCpcWJurMWpFAfvA0DF/CBJLGwIvWq49
         lxpq3vyJoA3meMqE05q7ZVVeQ+6j+cjhY0qg37p8zMW+13R6SJMD6NE8u9dJEBZwIuNU
         B8y5vYJXiukEEIBWbokr7w3BbeN9VerveVusxu06E6vAUKU5KLciVouhMmIKorrRfMKm
         c4qU9ayxhuQ6bLxOjClkw8tp1VLFb3CDPjPhAX7jl7UsqzGdW5PQVVuksplascW0gLCt
         ZS3Iurx3z4IVHsrfeB/+yWMS4F+3zf26yqCmdWHWNLlZIMiMdoR3x6x+DHuMk+6RyHjc
         D1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548849; x=1794153649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKQDgkRL9E3S6U2cAM4sdtFLp25slrgCe2pH+1FhaxY=;
        b=o5qd5kcOgBaUYEzuOF1uA7EFyuqZBeWmuS4evLyaVAjY+6KqZkbs1UOo51JGifg+BE
         DzadqVhluEUEpoD6nnXk3EdQAGtRG/0rjlAmSnWxEL/zyTS4vUTxMR3W0s13GbGG5xlr
         2wULFJN/IuIPPYznYN5ofgjz1RQTepVSx0L/sRRYDFdp9qfo3t7zpujhYdI8sEOwuJcM
         SA88byc18N9+87jlSG4iWzJp+6nWF+WskFy3N3mMXhOyWF3Xc9yd502eW3dVWBb5dDHv
         v1zZr1SC/xWB92kBzmDLHfNRqlylQtj6oAcNfaylI0NIanYr36ClECk31uD04mlJSdXS
         Z0nw==
X-Forwarded-Encrypted: i=1; AKwUvBw3A7RfEsof29LAu2P/kihzE8bsCerwbDYz+ESkxM6WNv0+OZT83FXnOzha71RahUn/1oEkX6DTotm10OA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIxnuQ8zHCDNcpt49KGThLezBZjIhgCDWFZ5b7+1Np2Kf5bbgIe
	8XJN1oJyW+qAfWUHeCe0mzycqnzZBReOKTe7tTFjZc8Zh4MED68XcyswsU3iKzZ3k9v2oA036Hu
	EBPI05yUgfWxki9pNL/jHyybvrUqP0SZgipqU9kkN
X-Gm-Gg: AYBFou0BUPBYLumTcvNsCGbm9SChppeVWLUM2NPdak4FaMYY+4Xhm7Cmup3AjgQg6fm
	VVjolUTGAZmYcqoqY7WktpKJpWhE6uyn6vFKSLsB+6XivF5TQsGDk6Sz7cQ255nj3C467cMGHDG
	a7b27W4918kwpVmC+9EPwMySs+XhUCR+i9LbYqWM6PwSi3M8pohymhVhuB4RLna4kbRravSstmt
	P/AfXt+/ltKt0jf76u8BhVyP3UlO7ORNIZJC+v+PBWa4DkuFMya1Ns5a+x9y5i2e0PcA7/2IU3j
	x0R/6T/qr+UkAt3adCDaKuVT13z+NwlnGu0+0ozjkR3CYkEKX9vqgd/VLrW+MCBgPWjtBRJmQRr
	UdaD6gbM7GehAZ7+I6lwgwmAjGdBTwyR0sGg=
X-Received: by 2002:a05:622b:1c2:10b0:546:92f2:7830 with SMTP id
 d75a77b69052e-54692f2886fmr8712951cf.6.1793548848845; Sun, 01 Nov 2026
 08:00:48 -0800 (PST)
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
References: <20261026080329.140244-1-hao.ge@linux.dev> <20261026080329.140244-5-hao.ge@linux.dev>
 <e1cfd568-8fdf-4aa1-a8c5-961bb8d7efba@arm.com> <5b0f90a4-c7d2-4f12-9d95-95c7149c49c7@linux.dev>
In-Reply-To: <5b0f90a4-c7d2-4f12-9d95-95c7149c49c7@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 1 Nov 2026 08:00:37 -0800
X-Gm-Features: AclHuK9081SXnilxbhxPhUG0EsiIt3QEWxeLpuWJxyGCO1FD5elbMhuUvO38YFc
Message-ID: <CAJuCfpHOZPKKd-bGWavBmBf5cmR-PEZO7a_jxXMZVS8tsgG5PA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] mm/vmalloc: propagate errors in vmap_pages_p*d_range()
To: Hao Ge <hao.ge@linux.dev>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 2:16=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Dev
>
> Thanks for your review.
>
> On 2026/10/30 15:29, Dev Jain wrote:
> >
> >
> > On 26/10/26 1:33 pm, Hao Ge wrote:
> >> vmap_pages_pmd_range(), vmap_pages_pud_range() and
> >> vmap_pages_p4d_range() return -ENOMEM whenever the level below them
> >> fails.  But vmap_pages_pte_range() can also return -EINVAL for a
> >> page without a valid pfn and -EBUSY for a pte that is already
> >> mapped.  Pass the error up as-is instead, like the vmap_p*d_range()
> >> helpers for vmap_page_range() do.
> >>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >
> > Fixes?
> >
>
> Sorry, I missed that.
>
> > Reviewed-by: Dev Jain <dev.jain@arm.com>
>
> Thanks! If you have some time, I'd also appreciate a review of the
> remaining patches in the series -- or Suren and Uladzislau, if they
> get a chance. No rush, I know everyone is busy.

Yep, it's in my review queue.

>
> Thanks
> Best Regards
> Hao
>
> >
> >
> >>  mm/vmalloc.c | 24 +++++++++++++++---------
> >>  1 file changed, 15 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 7131f60d1a8e..d60b99b81ec9 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -600,16 +600,18 @@ static int vmap_pages_pmd_range(pud_t *pud, unsi=
gned long addr,
> >>  {
> >>      pmd_t *pmd;
> >>      unsigned long next;
> >> +    int err =3D 0;
> >>
> >>      pmd =3D pmd_alloc_track(&init_mm, pud, addr, mask);
> >>      if (!pmd)
> >>              return -ENOMEM;
> >>      do {
> >>              next =3D pmd_addr_end(addr, end);
> >> -            if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr=
, mask))
> >> -                    return -ENOMEM;
> >> +            err =3D vmap_pages_pte_range(pmd, addr, next, prot, pages=
, nr, mask);
> >> +            if (err)
> >> +                    break;
> >>      } while (pmd++, addr =3D next, addr !=3D end);
> >> -    return 0;
> >> +    return err;
> >>  }
> >>
> >>  static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
> >> @@ -618,16 +620,18 @@ static int vmap_pages_pud_range(p4d_t *p4d, unsi=
gned long addr,
> >>  {
> >>      pud_t *pud;
> >>      unsigned long next;
> >> +    int err =3D 0;
> >>
> >>      pud =3D pud_alloc_track(&init_mm, p4d, addr, mask);
> >>      if (!pud)
> >>              return -ENOMEM;
> >>      do {
> >>              next =3D pud_addr_end(addr, end);
> >> -            if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr=
, mask))
> >> -                    return -ENOMEM;
> >> +            err =3D vmap_pages_pmd_range(pud, addr, next, prot, pages=
, nr, mask);
> >> +            if (err)
> >> +                    break;
> >>      } while (pud++, addr =3D next, addr !=3D end);
> >> -    return 0;
> >> +    return err;
> >>  }
> >>
> >>  static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
> >> @@ -636,16 +640,18 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsi=
gned long addr,
> >>  {
> >>      p4d_t *p4d;
> >>      unsigned long next;
> >> +    int err =3D 0;
> >>
> >>      p4d =3D p4d_alloc_track(&init_mm, pgd, addr, mask);
> >>      if (!p4d)
> >>              return -ENOMEM;
> >>      do {
> >>              next =3D p4d_addr_end(addr, end);
> >> -            if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr=
, mask))
> >> -                    return -ENOMEM;
> >> +            err =3D vmap_pages_pud_range(p4d, addr, next, prot, pages=
, nr, mask);
> >> +            if (err)
> >> +                    break;
> >>      } while (p4d++, addr =3D next, addr !=3D end);
> >> -    return 0;
> >> +    return err;
> >>  }
> >>
> >>  static int vmap_small_pages_range_noflush(unsigned long addr, unsigne=
d long end,
> >

