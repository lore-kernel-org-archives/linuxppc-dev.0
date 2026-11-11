Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CB606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KEEpeY2R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPwWj1twhz2ylm;
	Thu, 12 Nov 2026 07:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::834" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794429921;
	cv=pass; b=JfFQ3TVzCWtzHrvHGQscbU6mdgUI7AqWc4UfqHp8fjixxVbWLCOTsV7ETGfyR9O85uz7tS0yeya+pfXBHwesOhONhLONo5JPiwjsQSVcBCKz0WRQ2W9tC203NiHSMzt4wSwanc1szRo7ioldXrr2geCTX7tPki9kb7rrbyYSyPymGgGkeiX0s+phjS3vrr4Iu2KOhFEmjIzLqNmZNXg05nWdoYpAXBnkMaN9kLTcJ45raG7eggnpIk6Ma5ckLHfLJbFlPwNZtWKRBRRHhLDLsNOkSyDrIqjpaWApyvnVBwhSm9URTUE5U34QnplJGC8Gbka6dBCCP2oGVcSYUg7RlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794429921; c=relaxed/relaxed;
	bh=ejReHMBjl59d9ux/+j0JWqbuls8q6pULA6fL9qb3kCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8vPvXXbN9sECmGoNaff4GLv0UIprn3PiWykrU7v9a04wxFWZlK1sKQNjoejKJEXMrVM7469J6JHGtmQ/H8fXh37iDoUAX9knD7zxOGm8x4duvGm8OUg0cDWShRBuT0Xg6SbeWf/ythduZnQOkkDRffLUqkUll3xeKF519DtS0VzqDFXXI1ztNDtQd0UWof3bFskwwdKH+IQf39eG1iTmSncse32xxrU1BzjdWMBiJAdxbvUGfgsIS7tc4s0Z7of15JIpmBbyjPLF9+1+6gf/qUCkSWEkC+pHVn0Y+QuCn2rEV3gSbywtpiNjgWGKjQo0H2Swq7eiBjqFS39I4eaYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KEEpeY2R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KEEpeY2R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPwWg3RTRz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 07:45:18 +1100 (AEDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-535f598d126so46931cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 12:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794429915; cv=none;
        d=google.com; s=arc-20260327;
        b=AfogiBrx/7nG3qmRqCzFB9zuijFAfsbAM/qSQ578FrfpRWHX5I7qmZ2uDFK3xYO25P
         WFOivfTH7WrNfxEGSquA58pLiNhzVshEkrEzRmUIU2DFxmHACFhxC4JYhwWcqqSfFcrg
         X0pOAY4KPGLjrKqKVW+SeMZvyN29riWoKxCc6H+przI4905zpRwrf4k1j3SXFON2KEI0
         bAxajmuacAvhHQyvIjDhtvmWACcxabZW6ZBawMLSkCf+muJoFowN6dIomjJE1bzKRwDw
         mvONziw3bbrw2tSOnFb0wrMa18bV5QH75Ubk8AQYkg4EQxKqDIVbRbAR569m4nQkdmQg
         2ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ejReHMBjl59d9ux/+j0JWqbuls8q6pULA6fL9qb3kCo=;
        fh=y0aWDAojF1IbL24Bi+pPuUyiSdTJEwCAX5B10eDb4I8=;
        b=pxB4IE7yJ9QfwrPxinQGh8du4gRym+XIWrRk0mSfVbJCf+toESYl1fUnWnhGkl+b4O
         pFaXITamkvli7csb2vV5SUjd5AxDb6E8EjzZl3kGaTqkPZoK2dHLqWaJuXmrDwf4xpq7
         6FgVk1kUWLmsXxmKeqkhYvcv8llKa6gv18QZhG+BdfgN7hA5xphPcmSXh9+fgiWYLWM3
         CMKVSt6Wao8GhNx/5CTC9qKASBg7NyvKqMPjSKZA7LoxSOsYsDXomNfIGFE63WaD6nB3
         Dwy7++qaAMosQ7Wed6RjU9/4Pv61+Eqquqsw9jGcLVpwrJvUukI7KrFY0pRenk7ompG0
         qrgg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794429915; x=1795034715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejReHMBjl59d9ux/+j0JWqbuls8q6pULA6fL9qb3kCo=;
        b=KEEpeY2RwqPYpJTMEwCTXwCHeUoz4c81lEC3DxRitodxIx9GvpVKOi1uqIE8c0vp1Z
         A6Gx3cnD5tzfLGQ6YGK/KwCC5BjLLrZEFYXaIvQZdODJ7CaCS8a7gJ3OsRfKFDSVT+7z
         vSHyxW4pa80pOfz2mhftPW/cyN2CKgAgKooEldY/Tz1hQoXcf1fKoxx4WC4s3ADUd8O1
         Sw6xMTQy4RqDHvFSZZgq1YU6xZQ01Mm8+QB8JI1Q6T1bnod1YsAs0GNtU/FApgWiaHnM
         XllVN4Sy/YjkVGcJ8FcfY2h3vNoG/ZJE5x6p1IIlAk8NBNO7QOR/a+rJwTiHOQ9mlf9J
         CYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429915; x=1795034715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejReHMBjl59d9ux/+j0JWqbuls8q6pULA6fL9qb3kCo=;
        b=qOcH1DDPQ4Cp4JeGtUDhQ+n1wVlQfsleiHTz51iCQD8vBChgPZJce4XHuirrB9jp6T
         N0mfv+cygbVuJMFsYuvP/aNlqFjT1ZlpkR43o/Gh4wEJtWTpHZqQNomkpOcrieU8LJ9I
         C87gNxP0covObooBYN9mAMqcGTgSxUk/C8XfW0AfXgmo2gzDZOKPJhOIvBL6GWSL8/UG
         LZzdrwNqWOx490GPUKwpcSH42wzlFdYJ9Omzwtk9Vd1t009cHDvOd8uV8YLuOUlE18xu
         lgaaGeSiLVDuSi3P5irKGPYT80hzOXUNFtoXH9dtYn4O0Q4xSZbTh77yYyV+d0oHfsq3
         xB+Q==
X-Forwarded-Encrypted: i=1; AL+hErEbh58HFKGQfKCQfMDZP+x7rjLpf7VEi1OTIDBQZ6a4aen10qx4YVUMkibSWkLnRA4xe2b5eSbMVsvKQCs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/YNsSqxjYwj/1+7m384v9qhIP+b8QVcQhXa5PS0j9NunvRYKn2
	daomV1YeLwxnTnWv14791oLqgPrR8kS/lc66rkhvfj8VuEBb3kSPv5u/DoGWxxMq87/lgLFegPG
	Clg7NvDAcLVIdKnTLVXOLd4xtFOHelHFWrOMSF6h+
X-Gm-Gg: AYBFou1AImPA6MY5dBWLVDiAeRM961nIS2IflvdtMmoVmeQa8liPu6rRNiz/4M3UJUZ
	c+tEJRo0D4B07kwBgMyxopUcBXM6s+9bDmE79Mi6e/yOvmVkyIrZl/95kmvCexSvAYVUsdd6NdN
	lRys+6VIaWU6k744ALTHWPp2SZZ1FiMbcIGWJe5mhHYjPczaz33uMzxjbXQNkrRFd+M3V01K9Q+
	xe5kidyhAkA+Nd3BWnSxzanPHhTfcI5yhB2f7n827BH8JS0uruXG1zJoUjMSgTxVg1eSOc0voSA
	EyeMTHAO/y4vGN+wctm4bVfjIsWqIB6KQwJdJ+xkADhFGgt6Xjg2E/HUFOy12t1oIO4SU39QDsO
	qA3IBWJ59mktcnKRfexKhr/aQVFx5LOIyr2XSLhdcQZQmTpZsQ7P+mSKvpf+ewxOEWvAMVXeKtT
	aYBDLzQYSglsaPwI0JfIGQ6qX5
X-Received: by 2002:ac8:5c84:0:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-5598d505571mr488441cf.9.1794429914175; Wed, 11 Nov 2026
 12:45:14 -0800 (PST)
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
References: <20261110112546.261415-1-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Nov 2026 20:45:02 +0000
X-Gm-Features: AclHuK-ZSzUbXpuTPMxX4-S9gb3Y2E-tjBJBsqLyAoT0xCfZuwy_cCHQcxiXGC4
Message-ID: <CAJuCfpEUVDVZ53Pe3uzUVU_=4V3vipCLqY8jo_CC5kA_ZJSnEA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mm/vmalloc: fix up vmap error handling
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> __vmap_pages_range_noflush() and friends can install some PTEs before
> failing and leave them mapped, and the kernel callers do not agree on
> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
> roll back what they mapped before the failure, while
> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
> __vmalloc_area_node() rely on the mapping functions cleaning up and
> do not call anything like vunmap_range() themselves. When the same
> range is mapped again, the attempt hits the leftovers and fails with
> a warning in vmap_pages_pte_range(). A leftover huge pmd is worse.
> During the retry, vmap_try_huge_pmd() calls pmd_free_pte_page() on
> it, and the x86 implementation cannot tell a leaf entry from a page
> table and frees the mapped page.

Please note that there is a new function called
vmap_pages_range_batched() which should also unmap its incomplete
mappings on failure. This function was introduced by a patch called
"mm/vmalloc: map contiguous pages in batches for vmap() if possible"
in mm-new. I think it should be handled by this series as well.

checkpatch.pl also complains about "Reported-by: should be immediately
followed by Closes" on some of the patches, which can be easily fixed.

>
> After discussing with Suren and Ulad [1], we move the rollback into
> the mapping functions. A failed vmap leaves nothing mapped, and the
> callers no longer clean up after it.
>
> Patch 1 is the KMSAN part. The shadow and the origin of a range are
> mapped by two separate calls, so the rollback there has to cover
> both. Patch 2 is its disabled-KMSAN counterpart. Patches 3 to 5 bug
> out on an unaligned range at the entry of the three range walkers.
> Patch 6 only flushes the cache once the mapping succeeded. Patch 7
> adds the rollback to __vmap_pages_range_noflush() and
> vmap_page_range(). Patches 8 and 9 drop the powerpc and percpu
> cleanups that are not needed anymore.
>
> Changes since v3:
> - drop v3 patch 3. The clamp papered over the caller bug, a bad
>   range now BUG_ONs at the unmap entry
> - drop v3 patch 4. The reworked walk (24bbe1c56f63a) propagates
>   the errors already
> - drop v3 patch 6. The walk below checks the range already
> - the map side checks moved from the pte level to the entries of
>   vmap_range_noflush() and the walk, and became BUG_ON, in line
>   with the unmap side
> - rebase onto the walk rework, commit messages updated accordingly
>
> [1] https://lore.kernel.org/all/20260915070001.113559-3-hao.ge@linux.dev/
>
> v3 link: https://lore.kernel.org/all/20261026080329.140244-1-hao.ge@linux=
.dev/
> v2 link: https://lore.kernel.org/all/20261019054531.87652-1-hao.ge@linux.=
dev/
> v1 link: https://lore.kernel.org/all/20261009063619.112313-1-hao.ge@linux=
.dev/
>
> Hao Ge (9):
>   mm/kmsan: undo the shadow mapping when the origin mapping fails
>   mm/kmsan: skip vunmap_range_noflush when KMSAN is disabled
>   mm/vmalloc: BUG_ON() on an unaligned range in vmap_range_noflush()
>   mm/vmalloc: BUG_ON() on an unaligned range in
>     vmap_pages_range_noflush_walk()
>   mm/vmalloc: BUG_ON() on an unaligned range in __vunmap_range_noflush()
>   mm/vmalloc: only flush the cache after the vmap succeeded
>   mm/vmalloc: undo partial mappings inside the mapping functions
>   powerpc: drop redundant unmaps of failed vmap mappings
>   mm/percpu: stop unmapping the CPU that failed to map
>
>  arch/powerpc/kernel/isa-bridge.c |  5 +--
>  arch/powerpc/kernel/pci_64.c     |  4 +-
>  include/linux/kmsan.h            |  8 +++-
>  mm/kmsan/hooks.c                 | 21 ++++++---
>  mm/kmsan/shadow.c                |  9 +++-
>  mm/percpu-vm.c                   |  5 ++-
>  mm/vmalloc.c                     | 75 ++++++++++++++++++++++++--------
>  mm/vmalloc.h                     |  6 ++-
>  8 files changed, 94 insertions(+), 39 deletions(-)
>
> --
> 2.25.1

