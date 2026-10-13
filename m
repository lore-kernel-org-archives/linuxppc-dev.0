Return-Path: <linuxppc-dev+bounces-29419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594EBCC6B0E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:39:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j40R329Xtz3brH;
	Wed, 14 Oct 2026 03:39:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791909551;
	cv=none; b=MA0wZRfTE0TBu+PMTl3MW64J4yBXwIIw27Zipdyh474b1E6WaZ8ZDiYRBxdh02VydPfnK6VgfxhxAEsLbm5RN1eu388qWQ4HULnBFsJj3pjHd8NB+4BAl25x/5IS22InvzoKbFzTwwc+8jsJ5vczgSxsXcoANltvyYx6Hg5uGQXtUlIUottDRGP+kpfX+uBtZ82v9x/hkgJKlono3cpdxh1flplbKmINIRfQK0YIO50dk/eJ4Z5tS8qZLIOhkKL+ZcS+jSlagV31/FLbRmVGbY1VWvPiidqpCwgQ4ytgrTpHYE542EpRRgoyQUvEZLwV/4DQUUMk5kXmtU3aWEc7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791909551; c=relaxed/relaxed;
	bh=hMGgj7z4LL/41SC/RzPSs++jA5iS5B4RotyfALMsZXw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8DqZ/bFtmvBbg1ObZOpUzfOUuBKzVCV32LLkdlRs6ZDRBuwsANakEIVCNc+fhHZQOcr9vrii4c4MY/Sb6Ho7FIZpCdUNMx5tiv161JTRrrxb7ahDaFINHTiq5nRku6wXagRheglc8WIVQm2ojDvMKI913aaMZ082RWWHzslMxY4k5hvQw6pUl2VF5WNg06IVL6Pqe51pd7cl3pKkwAHNEW9o2v2v7Rn1MPvIQUII7C/SRY+SWaB/digR9nXzyxhCqM3XsRWgjxKEDMJ8CwfyRDfvJ7FN01N+OmVl8Ahkll3D8ci9tOcHQHlZg2I01bXbLYuVkFx1eZtArubo6XWMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOwggLVd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IOwggLVd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j40R13pWcz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 03:39:08 +1100 (AEDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5bce4e278baso10287e87.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909544; x=1792514344; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMGgj7z4LL/41SC/RzPSs++jA5iS5B4RotyfALMsZXw=;
        b=IOwggLVdO+V8AwuCdPDi4EGbNzpiK+hgUW03UGNs/GAHQaxBjjJd+cN5JBH4cxnejd
         yjx6ov7s9NT26YPofHwy7R3KE2mGxwSh5g/tXKAXLzwoO7IHeTdsV2/s63lJ/uUglCXg
         zS879MWftdGDn6n4yOlumSnHhSSIwdK4GmeYOmjn10LXfaZpLvRrHsk39M0o0HxK1XKZ
         xLSwrrXJGwBPPOnJlndwkjtz1hUSjp22QZyjTO+DHoPJ9zJYagaZpsASAfhm4aTVSJxH
         zBpahF2QVDtn4ucxn8cUcyI5P1rECaEJ2bu3aqjNENYQD78TFm06PGzAFhbKGZhRKp9x
         xw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909544; x=1792514344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hMGgj7z4LL/41SC/RzPSs++jA5iS5B4RotyfALMsZXw=;
        b=qTB/k/WCx05C24lPvZCtZAFs4pabhoYY/wpbsm1xZLxDN+UWdecCWwTirukxDcSHGC
         IfI4ZxXkc10WLdXzRuRLhFgBaH+WY7ZlV0hHORilY1H/hdeU2tEULXGytRg3RqIdiomt
         Yt/9l6wk8T5mdyBCc/u15Nki7QMb3+zzckOzCSngvDmU5CVAOhxZ8zDQVM8Wt+2qfDwK
         4PLGevmDvviUcVtEPWFireHkmkSzRv8nc+91QhOMugSCSTQdvxmntFdZXy5bUvBE8r8Y
         PdTNvkjEh+aZ6wlPPwr/BsRJuGInK6k+nvPduQ6/apVc9Ap0oW4Xk+KZXJRlskWjwAOP
         vk/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw0fqTsSAFBnhunqhoW/PCq+Aq6TxAE387MndAbWxrfmG4ZNQfaRmUwO93vxvS8/WgNLGiLOtm/T97bY9M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJP1Qu/Xg56tlozcRexTcK/i3myRNW2PcrX1N4U0RwrLDtKZI0M
	taTlsn0WF2IClXePrekYmDbH6rRGtPEaK2x4T3YEzs7X09wtZi7CbVB+
X-Gm-Gg: AYBFou2HePuwk3R5MSHXwDb+2/u+mqXrLT0r/RUA0ge2ZKQBhQLEx3rnNwr6vjcNWbw
	+yNIDh8xnh0k5+/Ql4k26BHuiFr4bJOiy24pVLZ8Yeq/DJV4gLm5aQXVJO1T5SbqADbbsULvpgi
	E0VGaiyTgohzSsUiLXqLQoUtzrLJrEul7lzNm5FlxJTLUUt8wzUfdqxO4tzZsHLwASUMkF4mD6H
	2/gCy2Ia1NHqd1wXSWSURtfyRVDNrkP2kucGFLPykovepbYV2QZDVIwY+wI+rRUlKmy/LC+7jt8
	ZMJqmvu31W+ebC3vnoT+GzzNMFctkW34K7X8pHdAg0wTQlZlm7Scse/4yU557YRl2OnNBflYM8d
	n4rVMXg5X8IKzykpFIb2CbXiVm/0FeRI4s/KGnWKPspIdcTV4wSdi8nsuuT3OmxbceMl880k8DY
	nb6pFa9XnIxw4Ss24TsfI5aW5ziMtf2jVYOdQZBPoVX/c+IchLPemFCNLz0BR7bKM3S/rY3Em9L
	Y9K1HAK+SuIp9jr/kgs7ZkHxfbCuv8j9hs=
X-Received: by 2002:a05:6512:3d94:b0:5b4:af24:3612 with SMTP id 2adb3069b0e04-5bcdd509e2bmr4530333e87.20.1791909543917;
        Tue, 13 Oct 2026 09:39:03 -0700 (PDT)
Received: from pc636 (host-95-203-22-87.mobileonline.telia.com. [95.203.22.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d8a485sm45759e87.54.2026.10.13.09.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:39:03 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 13 Oct 2026 18:39:00 +0200
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: Hao Ge <hao.ge@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [RFC PATCH 2/4] mm/vmalloc: undo partial mappings inside the
 mapping functions
Message-ID: <as5epHFQF4iE_VQK@pc636>
References: <20261009063619.112313-1-hao.ge@linux.dev>
 <20261009063619.112313-3-hao.ge@linux.dev>
 <CAJuCfpE9VfgTw2ZNMJTEVh41H_R+1RY_MtzeMuZNCD3BFm-Piw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE9VfgTw2ZNMJTEVh41H_R+1RY_MtzeMuZNCD3BFm-Piw@mail.gmail.com>

On Tue, Oct 13, 2026 at 03:23:14PM +0400, Suren Baghdasaryan wrote:
> On Fri, Oct 9, 2026 at 10:36 AM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > __vmap_pages_range_noflush() and friends can install some PTEs before
> > failing and leave them mapped, and the kernel callers do not agree on
> > who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
> > roll back what they mapped before the failure, while
> > vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> > __vmalloc_area_node() rely on the mapping functions cleaning up and
> > do not call anything like vunmap_range() themselves. When the same
> > range is mapped again, the attempt hits the leftovers and fails, with
> > a BUG() in vmap_pte_range() for huge mappings and a warning on the
> > small-page path.
> >
> > After discussing with Suren and Ulad, we decided to put the rollback
> > into the entry points of the vmap API rather than into every low-level
> > helper. __vmap_pages_range_noflush() undoes the whole range it was
> > asked to map when it fails, and vmap_page_range() undoes its range
> > for the ioremap-style mappings.
> >
> > The rollback is __vunmap_range_noflush(), it only clears the PTEs,
> > no TLB flush, nothing has touched these mappings.
> > vmap_pages_range_noflush() drops the KMSAN metadata when the data
> > mapping fails, and an empty range bails out with -EINVAL now, which
> > used to BUG_ON() on the small-page path and map nothing at all on
> > the huge-page one.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Suggested-by: Uladyslau Rezki <urezki@gmail.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
> > ---
> >  mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index db669103dc66..e1b376f57dd2 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
> >         if (!err)
> >                 err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
> >                                                ioremap_max_page_shift);
> > +       if (err)
> > +               __vunmap_range_noflush(addr, end);
> > +
> >         return err;
> >  }
> >
> > @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> >                 pgprot_t prot, struct page **pages, unsigned int page_shift)
> >  {
> >         unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
> > +       unsigned long start = addr;
> > +       int err = 0;
> > +
> > +       if (WARN_ON_ONCE(addr >= end))
> > +               return -EINVAL;
> >
> >         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
> >                 return -EINVAL;
> >
> >         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
> > -                       page_shift == PAGE_SHIFT)
> > -               return vmap_small_pages_range_noflush(addr, end, prot, pages);
> > -
> > -       for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> > -               int err;
> > -
> > -               err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> > +                       page_shift == PAGE_SHIFT) {
> > +               err = vmap_small_pages_range_noflush(addr, end, prot, pages);
> > +       } else {
> > +               for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
> > +                       err = vmap_range_noflush(addr, addr + (1UL << page_shift),
> >                                         page_to_phys(pages[i]), prot,
> >                                         page_shift);
> > -               if (err)
> > -                       return err;
> > +                       if (err)
> > +                               break;
> >
> > -               addr += 1UL << page_shift;
> > +                       addr += 1UL << page_shift;
> > +               }
> >         }
> >
> > -       return 0;
> > +       /* Undo the PTEs installed before the failure. */
> > +       if (err)
> > +               __vunmap_range_noflush(start, end);
> 
> Would it be too complicated to track how much was actually mapped and
> unmap only that portion?
> 
I think it is possible to vunmap the range which is already unmapped.
i.e. in this case it is better to no to track anything as soon as a
mapping failure is a corner case. Also it is more reliable without
extra track logic.

--
Uladzislau Rezki

