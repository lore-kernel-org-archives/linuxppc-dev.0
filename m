Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA160A2608
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WqdWHyvx
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWVJK4zYzz2xnZ;
	Sat, 21 Nov 2026 09:24:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795213489;
	cv=pass; b=U6fJHJf+JtMbV85onFw2+Kg0z9Vd6+HKwhIKz9clS0bMOHwNGcQAQxY0MJRGRME1NVVtgMePHTgXwSPCpJcRzhKD4n3Ez3mUfCrHyrpSjQRh5A7WP3/cAHUUdH0csQh5czvjOtQNWkuD43JqDKPjRWx3xu90gfHr/h+a6EB/JO/+9nKCg4zLcL7/V54pYol9Yap6WHOWulvL9fpgshf4tAK4Q0VI5wiHNmZhIAyrSJxOIsNqfZdARe56B8H8w8lOYpxT2KiQLr7na8MDsxNjGNWyddJ1z+Oha/03a1eVaD5YJ2c9cJ3WxLs/ccVZ106x/P8XuBaDk8134O5xNtLMkg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795213489; c=relaxed/relaxed;
	bh=1NRDdhSVMLSlkGl3vLfd9oDNXjJR/tyu9kac4iL4k3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjKaQdQ//XNS2qKtKE0UcRe2sf86EbsrxNqHWPZEaZrUAg3swyRhQ8CmpNgkbKOCkkjaazBYN5PUyFLbkwONPUV/5+0NtxGaqbtY+Bz+WsC5yz16OJ4i/6ORl2QRNBjojvNtzjPuf2d20R6TALpu4pzWItbrH6H2YbtfK+tFEjDh4nii1a2JDItCWES6J4DN09O4GCTReh0Vg31HDj1LNQUKFhb74UpOl14MQXBXnIfOWLy2c701XYftpHg/ukiM7pC7Id8G1lF/SQJ2AkJSWy8IN9e9/EMfy4EriH79v9z6r8WyIECgPN5C7kXmk7My/gJcfBwfFPvHmT6dPMlJdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WqdWHyvx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WqdWHyvx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWVJJ2xnnz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 09:24:47 +1100 (AEDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-54492d8a988so94281cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 14:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213485; cv=none;
        d=google.com; s=arc-20260327;
        b=M/NoD2wIXmOYGuFIJaBBYxSjPgYxwBwYd+U8D7sGzcw2t9KeQs9JA0b4J6twWEcApb
         lJqdlYImdS3d33Lb4bcpomGTMm6sshlrlAwRSFhOcu767gMiio17DEcIjWrnNKbH/P6J
         kdwjQjrHiclws5OTAXbqnCE/8rBDtYkLd+2+TnRF8v9clH8G9Xp0O6kaanjTtlum1bnN
         YngqVe+htx1A1M/oYhSga0UvuDv0GQ85FGWbHBS5bfkbTv3NMP65UWWpyO1Qwx86zCpZ
         W4IDYMMAJL92bPbISzzArxxMHbPpHMJuS9yCOoJtB3yxY/8DHeup58fYI4T8iwx1KZ6z
         4ElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1NRDdhSVMLSlkGl3vLfd9oDNXjJR/tyu9kac4iL4k3Y=;
        fh=MF6wWaZnLNfsrhmw5LotHMBI9xtQhPcH4YryPb3qHO4=;
        b=SPkGjWA7AJ1/aYhCE1ob8js8LxGUd4rYOk+5n/t25KyDnvtaSwt3wW5Wt7Z6Q/kbyY
         Q6j0D7Mcev1UwFzAoNMdincKO+d/Nsm5jXwz073g5NBRqUD1h/hj9BB1sMhbM/5SwupR
         kbHjJFaPgRaZcA/3IK3QD01cQ1w+I0R4cJUwZnpeIUgfwwhd4Lwsu3JMZrIUDmZ33CDV
         Wk7L7q0RWHKns09+yL5sRUC/S43freKaiZQZNOQeqTC/WwgGU+f3oO2gFnTshv3rJaow
         UQcJPwn0K2GHxaMp84S0wnYwfSif4oGMGyophZuEe7Dunz70IZeqir+QsvGtPsnLN8hB
         sYtA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213485; x=1795818285; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1NRDdhSVMLSlkGl3vLfd9oDNXjJR/tyu9kac4iL4k3Y=;
        b=WqdWHyvx7YFiGNofOTtVe8zSMCAxXR+SPs3bdrse6Ip/IvvfCJbZHIafxEWJULm6eU
         n5LtER9EqR9hhprkAmWlk6D0ZRNSGVuu7pZEdcvUstx7dnHTUCPPTT5WJ8I08tWzEzBw
         yPWqh6z+CO8YLN5ZhPW1ziB8MOIo2LEN87/qoDoxocQAG6nhbJJk5x/31/8qJJKfhmlo
         AmncNmFBsmIGxnibonLcX0K15p5xXzIsOEUtYFkAV9kgRwoE07sDp5EiBRbBrwtjS6F1
         aSA5XY+ypejoxFYwXSraySQk/HR/ReiFDQWvrUaN42hGyzMBycf6gK4+28QSg8FBBime
         vKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213485; x=1795818285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1NRDdhSVMLSlkGl3vLfd9oDNXjJR/tyu9kac4iL4k3Y=;
        b=ACNaK0j4VXaomoY7Z/qQz473iP658bSOwinXv6Zkoq6SrjacRqSn0n2oqbX1E/0LYA
         /0i7OIIX0rTIBESg5DMDVozxYLLlVHU8KWSGfAkqiME7D9ved8TO4kB/4+JzoRyKZk/c
         xhr6vo3jPg5Sdypf72Vc0EoQJ7gB4j7iXPj+bX6OW107JVHPTm4EXwmmesKyvqas25sw
         6rfhFTiEtxyTV9+0yaVZL6xjqTIqFEp+Jko7/CEoTvMYWKue3n0eWYA+Qxulh+NDeYJc
         zC1cW6rROIinll++nws+RH0c8+LymD+RFdoesLD8pid1m/PEpPnrvntQcKz6Q2XLXwhf
         oriw==
X-Forwarded-Encrypted: i=1; AL+hErF2R557QSOYu52T5J5VckvAdEfRpKodRVl2k57aAQuBTgbXl5HcOKp/wjhxUN0f0a3g9wNJ47V+KgWkznU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9p46qUfXfsrulJyzDK4UKU6R+NJqnp7EmdVDE9g183BONQ5WlS
	5j7/2MbXb7W7msYgV6QQ8EDLWFvK7PCLKes5RoVKCWeEP115gqbON2wwUDOhophDZk5LXZmttDM
	AtpsDjBzdOIpu8NYYshsPj9zOurgcHsor/ogMynlA
X-Gm-Gg: AYBFou3c0+XQldhjEVOSXzhbsjsCgJzP7cupGfl+4I38T9PTfxUFkvOaFXbR9vrhuca
	9Zht5S6HqiVfHYpDyRH0uTcJfZlMyFHux12b7CsyfJwbfEz9dDuw3mwVmwMSAYJzIB31oiSDKtm
	cGoW5nR84mxSh4ee5t/r7vtuXBo4OOwUvZojcwP09A6ZOSM7tMzn19vZTEQeEMbaw/Gg0TBHy88
	fG5ks/so0kiUYsSZy3Dtr6Ga3wxJda4ox9I3JrDyQE5gxcxdTKnYTcQUNJaaAB99hqt9YmS7nyD
	F0gfHatlzo9iRcKbdHmc/e+ha/Dre1nZ2IvHo9PhpFVjqfYUrHTEw9pKSUnhFgMCBgXysPNemyO
	XPJScolxYQ7J1nXQSrURv8rGNfr4uxLYePfMoRzMTBaChQBKsofLot1QMBk+X4X+qI5NuLxTmUA
	rgnjDRpTIsrHjSEsjVqoF7yO5cXvYQqrozMA6A3vtumYN5xA==
X-Received: by 2002:a05:622a:2303:b0:535:84ef:2e26 with SMTP id
 d75a77b69052e-55d88ff9f2dmr1848781cf.7.1795213484666; Fri, 20 Nov 2026
 14:24:44 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-6-hao.ge@linux.dev>
 <av39BuCsq-dRFiMM@milan>
In-Reply-To: <av39BuCsq-dRFiMM@milan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 22:24:33 +0000
X-Gm-Features: Aa3M54rJ7M1MnGNtQP9_VRtJkxxQVQjNLEl48ynPtV8As3xDhStKJU8NtpTSd_E
Message-ID: <CAJuCfpGoH+M6Ni6b13LOLkcCsGJdGofUwNaLaED-s2q+bRtefw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] mm/vmalloc: only flush the cache after the vmap succeeded
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Hao Ge <hao.ge@linux.dev>, Dev Jain <dev.jain@arm.com>, 
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

On Wed, Nov 18, 2026 at 7:31=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Nov 16, 2026 at 03:13:19PM +0800, Hao Ge wrote:
> > vmap_page_range(), __vmap_pages_range() and vmap_pages_range_batched()
> > call flush_cache_vmap() before they even look at the error code. A
> > failed mapping is never used, so the flush is pointless at best.
> >
> > According to the Sashiko review it is worse than pointless on UML:
> > flush_cache_vmap() there is flush_tlb_kernel_range(), which syncs the
> > PTEs into the host OS. Flushing a half-installed mapping therefore
> > leaves host mappings behind for a range that was just freed again.
> >
> > Only flush when the mapping, and for vmap_page_range() also the KMSAN
> > metadata, is fully set up.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/vmalloc.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e2b63cb1592b..d99d7710e1ba 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -371,10 +371,12 @@ int vmap_page_range(unsigned long addr, unsigned =
long end,
> >
> >       err =3D vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
> >                                ioremap_max_page_shift);
> > -     flush_cache_vmap(addr, end);
> >       if (!err)
> >               err =3D kmsan_ioremap_page_range(addr, end, phys_addr, pr=
ot,
> >                                              ioremap_max_page_shift);
> > +     if (!err)
> > +             flush_cache_vmap(addr, end);
> > +
> >       return err;
> >  }
> >
> This is incomplete. Maybe merge with 6.

Yeah, by itself this would still keep failed partial mappings, so it
doesn't really fix much, right? Merging with 6 makes more sense to me
too.

>
> --
> Uladzislau Rezki

