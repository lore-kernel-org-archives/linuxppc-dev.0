Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEA606A6AB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p/WgAm6W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWTvF14FBz2xLm;
	Sat, 21 Nov 2026 09:06:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::534" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795212393;
	cv=pass; b=XALs6mOXach7m4OG7symbUEqRhWinV63rK/eQUecSb9MSgEeQYKR8KwNH8t4dbxzNHTkPk+Gl7CawgVbyDWYYpEM5W+gSdKHUhP2NhqLOjofUj8FHYOqiUyjR+7IHNbgYkt43VRyEdkTjpLrWydMveNgxiVcFWpy7iBUWR5ZZWVdkoyl9RwVCAyfrH/eeOHn25tKpVO3yq+D2WFoypzZcI6hZILGa9+Nc+rcJ+4/i+OhUdDxgDrWWB4gn8csEQEztDypUMeih1o4+lNeIX/MVd24zODwAd6qnhLicNY0b3TwxkEkTgRCMX7RmmVRFRKWmVVqZ2KKlCy1bezA7GWzhg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795212393; c=relaxed/relaxed;
	bh=Qp2BTPut4j9BWLU7kp/9R3u9IW0btPsFhc2WZOxCd1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnkXkr1Vez58qtb9FeHS+0VbLWwKNErk5y5VFSVqiw5k6I4BPU4l9Zwie8L+68s1dgoytC6m/Q454xi26D/s80F2+zJYcC9v5CPHKdS9ycgXbB3yDvizPPLLPnIxWKPSOJgdEcL/bKs3Tc6+GAyn0K5YagGn7NIp19JLoyGeGhnKYp3Sn8WztbwbRcxLE3nASMGnARLnZR7WQmHZd97GiGp0xffzoVfy1yRAi4xJrpDM65+zVm4eU40GwV7M5M7DUhB7txjYZAm0YXIZjskPnebN5eeo4aZDo9MiN2zxJGM/PQ9zQsB1Aql/8m+BU8vi0aiFhrmxbBRbBb/q66f7SQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p/WgAm6W; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p/WgAm6W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWTvC3Kh8z2xB1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 09:06:30 +1100 (AEDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6ba2bd43dd8so1304a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 14:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795212387; cv=none;
        d=google.com; s=arc-20260327;
        b=o4cMxRSgMFJnMArMbvXmX11AEZFBike37UbrJYmmOIlygVAYkjMlDtkczhNX4GqjKh
         Vk5xStBJ5uG/eWFiKIDoH3dJ3mzgXspyT2zaa6tLZ0rJlWdBvhAID+Jrt/t+6nZKVpOj
         P67C2Pg0/xw9z61bHpX+xQOzyiQAfniQI6BkRSbtc5tddVwe4EDpGrDVNEPlomE3kYYq
         qn+py/5FDQlrNrmIZ4IsOUd490AccqNYj1dD99UcII4mVAEkwhrIqc7VVVFkSr1//XQh
         Ltms1s5jRQIIvnrtxT1yux64+gtkqxZG0TNYsYfyQQSC7qp5miZkmhrtctvp5Q6a4Di1
         rrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qp2BTPut4j9BWLU7kp/9R3u9IW0btPsFhc2WZOxCd1o=;
        fh=Wr2aVZhQmJwo679LpS198mjyo9JqJWuMBvnRBF9f1iE=;
        b=nHPUIbsxjW9cgYybsIUpxQEyPRfpkuikE+FaEIRKvGGmt8gf++1AKYTWh7ta1dKIOd
         70r2XuchXm0UDhKIl7aejLN8DSwQWtvAQjqYw+qB09sKd7HWlCBvOokYp20/MaaKnfQm
         nq8RrQyKPGQeRhJ2BjFz7UtddTjgJZqAP8P+lrvTqX4VmGBYzzzke7LGQyWdFHcgf/kL
         QbZdCyGyfXvByFURNisHn7DdIVgt+692s/SZpx7ErZx/cSuKbx2XNSJtZMWISNmBtUxl
         4F1sOarn5NK8F51ayIErtxjTcnXMIhdKJDkVaPujaIItFZH75i5I5Y4Kv45soKwdAZP1
         4gdg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212387; x=1795817187; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qp2BTPut4j9BWLU7kp/9R3u9IW0btPsFhc2WZOxCd1o=;
        b=p/WgAm6WRz6W2qCYa+25wz+lnMjq9h1fkYrYCdAhNHvzBsCBj4rfSnQQOqC983QV6z
         A6ObeG92Bit1ANfACCFrRRhRziDJANCkrD3K1No/SdB8DLxPK/ZAM0YlNWX8h2ULHQ2v
         C+YTF+81QmgOR7WxssGxNiSc+fpSw/bKQwOw92nu0B07BDYnFRKAEXFXRVl9FwqqFBY5
         gItCFr7n5yLDT2NliHzTKIMFoby96b0cr7qm9ojV2bNM0ByaPZU6p8eXE6NDa5Hj3KhS
         tPgiPu7WR/yOt9pL2uJuBpDEXSovyrdR6RPxWmHRdSLWcs7ay8pmjr1WDZU9IcU0sk9b
         ITZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212387; x=1795817187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qp2BTPut4j9BWLU7kp/9R3u9IW0btPsFhc2WZOxCd1o=;
        b=TWmaDbZWaLuuGUPdCuJhqgRcPaYAvXlHqeeiRGvr+4SrOOhZc3YtNlSMXoQkmL7fK6
         vbsIM4U1zsJVyniGwg3bjeJeTbuPCI9v5GKIyYbjmByVWgPgblkxviV3BbTO6iepoOBr
         ZHYaNPrBT1S7C0sA8Cafr4nkJPuUZYj90M3zKwKJVvoPZp0vDo/B5+auXEdzkVz4Crr1
         v4tZWiAj59wc9+nfsUJDqdQ2wmLxGnGxFAnKFaMACfWBGZJmjts6UdPeccWxVtrVE8nC
         aO1/1PayikqH1fqa/Zp5c9+56ZzkXRlK0f/0B6X1cCvu/DkU9OJ+9bRGHApHsEx+Fe0r
         16hg==
X-Forwarded-Encrypted: i=1; AL+hErHLpiohzF7s0NsFnVqTx8bWaHprmwTrYr42J0aANusWX+vKSYQuEHo9qpbuAlziVHAPaR6hza+g0UhhKWM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9WY27gZ5Gnvj8xh2iSnkfh++E2bx6eDpM6mY+SwyLcRXDXrsuC
	3ehnFsZvKlLGNOlkHdcy/Fy48sZWV78TUGqD1OrmLPD9b1HVoPcRlff+ZL9z94YMvPMdDqjglEE
	XHSX9Kqz0+Gaz9m8dyQG1P5S00ZHk+862tCZ626Ps
X-Gm-Gg: AZFdTZdX87AOCRXgJYFnBxcH9YvlWLVI2njvRzLTQfDyFC9Koxr70NJ2ZEJ5S1j3ABZ
	d0XViH/uO3G3TDPxmJmE3Mgo21L0mgJWq+gSU+TBA6S54vFHcJQg8/CAeh0BHuKYaChrYia6dy+
	Y9KjiGSfy7F+qoovqxGc+xjimQwGeAHdo4MrmpdVUf+flh4Me/QGo+r/OlZAKiX/JuHtmQpZvfK
	pW6HoNKKdKt283+iqhEYaLMFHlldkrjN73tZd9d1MrCtcLA3lMhjY8jbqaa5Ae8BSKWg3ZzNreW
	DKYQ77MmUOtaMaQlHl0YCG4xGLfzPtF8i8RhsK3xM0tmb2uIis8ybw3BoXrvp+trvZ4FYdF5lvu
	dOW8Nk7xeOACmqLbQ1j7F6aEse1qLWwaPY+7X6/N0Rcz5fJdyxYuu7pbLqdGXo7ISfKlD+62HL8
	cgtrmvHOjSI8PbjQwUWId3hq7bqR2+z+Ho+HHKS/hq75HpRw==
X-Received: by 2002:a05:6402:548c:b0:6ba:12d7:69a8 with SMTP id
 4fb4d7f45d1cf-6ba65a76fffmr24683a12.1.1795212386808; Fri, 20 Nov 2026
 14:06:26 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-4-hao.ge@linux.dev>
 <av34JPIcIOVdF0kL@milan>
In-Reply-To: <av34JPIcIOVdF0kL@milan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 22:06:13 +0000
X-Gm-Features: Aa3M54pvZs5QUyjUwxPZUYW951y-yto_861ekfXrLaBmJJ2Uwz172HO5VdEMhNg
Message-ID: <CAJuCfpHOTq5OAQtWnYjtFqUL58nn1GxCXp-DtoK4MsfeLPcwMQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] mm/vmalloc: reject an unaligned range in vmap_page_range()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 7:10=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Nov 16, 2026 at 03:13:17PM +0800, Hao Ge wrote:
> > commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> > PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> > late, because the upper levels may already have installed page tables
> > for a range that is rejected anyway.
> >
> > The pte loop maps whole pages and stops only when addr lands exactly
> > on end. An unaligned end lets addr jump over it and the loop keeps
> > mapping past the range. An unaligned start maps the page below the
> > range and usually misses end too. Such a range is never a legitimate
> > request.
> >
> > vmap_range_noflush() has a single caller, vmap_page_range(). Warn on
> > addr and end there and bail out with -EINVAL before any page table is
> > installed, and drop the check from vmap_pte_range().
> >
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Suggested-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/vmalloc.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 3c0d9e69b886..a168f6f20f4f 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long=
 addr, unsigned long end,
> >       unsigned long size;
> >       unsigned int nr_pages;
> >
> > -     if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> > -             return -EINVAL;
> > -
> >       pfn =3D phys_addr >> PAGE_SHIFT;
> >       pte =3D pte_alloc_kernel_track(pmd, addr, mask);
> >       if (!pte)
> > @@ -369,6 +366,9 @@ int vmap_page_range(unsigned long addr, unsigned lo=
ng end,
> >  {
> >       int err;
> >
> > +     if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
> > +             return -EINVAL;
> > +
> >       err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
> >                                ioremap_max_page_shift);
> >       flush_cache_vmap(addr, end);
> > --
> > 2.25.1
> >
> LGTM,
>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Uladzislau Rezki

