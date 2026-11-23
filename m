Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D2606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KMXLemqK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY9wV2CFYz2xdb;
	Tue, 24 Nov 2026 03:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795450410;
	cv=pass; b=B/RuWURLw4FUF2j3bGjnbEe1lkp9QGiOsG2NwvvypdD8MvKmQCmEK9EICUlqWkyrDD3icJ2sIrCKvh4G5AC/G4X/o60W4AAKHDOgKC9cvgA5jK4PlWNuZmWd/WX6dCRCzHlmhuZCxZ7h3NAfrllyVUhOwSDE9EqBdckOlTnekjfQMPujEM0LnLzqZ0GWG0Y2d/RZPeOQIcV61i5viuEMqHR2h7E1oW5YY+4G934a8WBgfI/U87zGLcM/upT0caEDuh1fJkfHn4UsR1jP7TI1PWBC47owM7kd8B3Y2jkMxaT4Jf3vM5qzbBCtYNFmRIWyL1+MGlZix2bUuJ1bMcMfTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795450410; c=relaxed/relaxed;
	bh=VC60GZZo31yUNr+wgKLno9Qh5+CFy8SXNEOHTmSSUVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKI+F31ELB74gZa+6Cluz99hEI5kqQ2LdVA4/DsuVja4HPIRBElPjyx9nnpbeIJj+aUXXmXuyYsSoQtMgijnIkbcutsh+5JqMiH+SQRxrlcl5M4lgkgwFSxBvyeStCA/GQkHQyEfGG80q/AdCGtxfwTRivX90R6YN3GBhcDDT/ZGOTSc5gk7eWQLQ2WxihJg2rVoJhALvbb8/vvzdYZ+ZNUNDTjs4BzwcDFb4s7prGvIu7RpED34PvtDj76qD3AracdWyXtiDVssKW1kTMOebcjpZD2ZjCZ651qvrqkNF+tin59nnbClV56Z/WUKDy2kBl4MDbu5pn7FVUmvRuYfsQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KMXLemqK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KMXLemqK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY9wR5sRQz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 03:13:27 +1100 (AEDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-54492d8a988so510161cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 08:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450404; cv=none;
        d=google.com; s=arc-20260327;
        b=gumIsisQM8S82GzMHIFyH2oDdZyVWe/aLVSuIIEF9io1XEnt+po/xeqSBkrupXgdRx
         5/T2pbyHAE8zDly0cD/9MOyIdi0xoO/mB9qSimRruSf2kMMa6qanaaUF0A1lKqjLtzX2
         TZ7OXpWe9wRaDB11FB8uDelkMEmv68VC3Cn3nzdiXps7dw/pimaeDZL5w5x/UUm8Sr1e
         m7tqoDo9V7KpFUGRvP7M9dzTS3PFk6JOJf4Qi/nuso1jd6HV10/+nNjp1Gbq1rYSStKp
         Wrbz4c5+gakNJTCrTRY9tObdVylPy2mFmgIww4eBfrHVcnPTr6M1eK091Ov70YFhlM5B
         hurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VC60GZZo31yUNr+wgKLno9Qh5+CFy8SXNEOHTmSSUVw=;
        fh=73RLfFZB0rNfDPMADQAGNoIh65KkPqpIP/rAmt5T53M=;
        b=n6r+FleJd3Ddc18TVkmMU+J/HZnO6ESPqT4oLUMzeiNqALSnJJLkKFJGKnvMh8rBVR
         fXvgdhIsilK/Sx890eY/VLXmjVZEWAti5tIT04YVXC/fIF+ybJTc8ibuVo73qjCqeYmw
         DCmm7uuiChr2SdI+X0CXODIpVsUW5FpiWJmsEICwp/O3/TInu8pDWceeIfxFWXB+57wU
         O6jDHpmJ+BHrGMAmm2Lx3GLaEoo2FfYhMUkV+130sR8tAw88OX//MeHJFMYViMaQtukd
         F0relmS91/Uio5hXcFo9mnEuvgHKBiJHelPMqu1g3D2ozOxqs4JUtEtISR1JGRoCttRj
         lX3Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795450404; x=1796055204; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VC60GZZo31yUNr+wgKLno9Qh5+CFy8SXNEOHTmSSUVw=;
        b=KMXLemqKdf1eslSZf5OmPTSJCwLymh3SEuZIF652rh0kvQ4XlnkWAMwCyCoCpthBuo
         sCwwWSVKGkEzSgN+uTRs/OgDka3m6Ppxhf/84yXTq4MtGz8N6SRAyG7E8fj9FWKoGr51
         H9FH27kJoEYUjpk0WPXYHBCA/xPMHPOVP9TRH2s8lFdwWscT1GQ+tWIHSndmmmNhzRkj
         asAfs8YOJD7xEyKDtzLUoGDPz3qQNqJU810MkSYYoCvQGZY2UqGWS22bbRJtSgvw0GHu
         9h9e95O08V2pFqiKLWuaukJf5Uc7BsX8EdzwJg48slVi60+JHMSLBRmXKsbsXhq7llnY
         89AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450404; x=1796055204;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VC60GZZo31yUNr+wgKLno9Qh5+CFy8SXNEOHTmSSUVw=;
        b=MWX9jOnlSh+AVf5KXzzfRKvArzNv+HpkunKU3lu+tcws2pe70AhkCFNxIZ2gHdt7gP
         EVfKi9XNG2SwYdTDOUV1Cu3I8mwPgJHQLQscJsJLiv1Mvc9d5UUrwqG96HBluLWwKq8m
         U+PdecJP9uvO4fZxvb63Zu0PjRjZRpNJZXpDIdBSkcgcP6myJFL2TtOKIm4MVB6Tzheh
         PaTUlTrmBOWlAxed4cMl1cEPXh+jrk2UaVoeD+aNATXrA1N5KFB5T5Sf1BQkn03BSnLS
         5mzHMFWNfIcHIvstBDjnTjK6oSYqKiWxhemaqAiu5qu2m0ucNtpmfZhnni+sodp49xNT
         lDoA==
X-Forwarded-Encrypted: i=1; AL+hErGlDgqz8GHzX3RLmOx4iajmmXzIRyiKxnw8LY2Vi+KiLzCFOaaWkRpMPEKmZp4LK0Z30FjuaW/w17WBxtk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9qBAsW6UjOi25wZ7MRP3N+fbVS5GcCuw/prwfJsuljZqUrQ3PX
	1q5M/sQOFDORMfT8F6u5w+Ol/0eAeCwxWvMmMIXy4UkH56/HE4YTXIpJEG4mxTZ6b+c01mBv3BZ
	ZaK9MW5/KMAkJLRy+7SXPbCvu9q1fimAXvIvRL38Q
X-Gm-Gg: AZFdTZfDkBNAEg6pXFSI9YV79lTqpeic9cleKOqjyW1wo8zBGhjUd8jazg2HaUpBI9D
	0neVtHAf0KUh/5rI/unX2f5cXtNe7zt8J/Mnvi4x1UZa/hW8BXsxgfbpzmOlIBTqBcOafYLj+P7
	Eq8HQ/Zt5Rndmo6mme7R1MhNkziHKmmh3uvHpLKiGQxmX45ieP3pPM+Q1cBH++7Q+BDA6eRAZ8y
	A0y1U9xVoGJeRDbBi3XuAf0ti8WjEDmjzYFJ1CIolciKSD+rlzWjGX+6EKw30yAl+YMZC1i1FDa
	4ED+SgpnmY5LXhpGjuNduaIHvPxd68lOAX7lN+/wUjt1EqCuvRZ7AveFqiK4zVMNJNNjarMADUP
	eOc7m1ZgyRbvQvWSxXxImdUrGKO0GlyKcGm7dgvpBR1axYv/ftMW3Ry5CIP9VqG5WGi8PflU=
X-Received: by 2002:a05:622a:2b44:b0:55d:3243:574a with SMTP id
 d75a77b69052e-55d880eb263mr39740601cf.3.1795450403673; Mon, 23 Nov 2026
 08:13:23 -0800 (PST)
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
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-10-hao.ge@linux.dev>
 <CAJuCfpF_=KV3ArFO5LtMjc4EGMr79tX_tX2K=YCG_JTvC51OfQ@mail.gmail.com> <0e30c5c2-b9d0-40ea-b7f9-af9a8854bd58@linux.dev>
In-Reply-To: <0e30c5c2-b9d0-40ea-b7f9-af9a8854bd58@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 23 Nov 2026 08:13:10 -0800
X-Gm-Features: Aa3M54r0R4skiMgKsHIc0IKP4yYJ-BOLVODQJYPoar_iFImIJ0fTee_iDqFXrIw
Message-ID: <CAJuCfpE7S3uTX2rqEkmYqhO6zuqTKtDH88w20m1_fMHF8L672Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] mm/vmalloc: undo what vmap_pages_range_batched()
 mapped on failure
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 3:32=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> On 2026/11/22 12:13, Suren Baghdasaryan wrote:
> > On Sun, Nov 15, 2026 at 11:14=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> vmap_pages_range_batched() maps the range batch by batch. When a
> >> batch fails, the batches before it are installed, and the failing
> >> one may have installed some of its pages. mapped_end follows the
> >> end of the last installed page, and the error path undoes
> >> [addr, mapped_end), never past the point where the walk stopped.
> >>
> >> The KMSAN metadata is set up for the whole range up front, so it is
> >> torn down as a whole when the mapping fails, like in
> >> vmap_pages_range_noflush(). The only caller, vmap(), also calls
> >> vunmap() on its error path; the double teardown only walks over PTEs
> >> that are already cleared.
> >
> > As I mentioned before I think this patch should be merged with patch 7.
>
> Ack.
>
> >
> >>
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  mm/vmalloc.c | 22 ++++++++++++++++------
> >>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 28e65073624a..aa80bc273ec0 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -3748,13 +3748,14 @@ static int vmap_pages_range_batched(unsigned l=
ong addr, unsigned long end,
> >>         const unsigned int nr_pages =3D (end - addr) >> PAGE_SHIFT;
> >>         unsigned int prev_shift =3D 0, batch_idx =3D 0, nr_mapped;
> >>         unsigned long batch_start =3D addr, batch_end =3D addr;
> >> +       unsigned long mapped_end =3D addr;
> >>         int err;
> >>
> >>         err =3D kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
> >>                                              PAGE_SHIFT, GFP_KERNEL);
> >>
> >>         if (err)
> >> -               goto out;
> >> +               return err;
> >>
> >>         for (unsigned int i =3D 0; i < nr_pages; ) {
> >>                 unsigned int shift =3D PAGE_SHIFT +
> >> @@ -3764,9 +3765,10 @@ static int vmap_pages_range_batched(unsigned lo=
ng addr, unsigned long end,
> >>                         prev_shift =3D shift;
> >>
> >>                 if (shift !=3D prev_shift) {
> >> -                       err =3D vmap_pages_range_noflush_walk(batch_st=
art, batch_end,
> >> -                                       prot, pages + batch_idx, prev_=
shift,
> >> -                                       &nr_mapped);
> >> +                       err =3D vmap_pages_range_noflush_walk(batch_st=
art,
> >> +                                       batch_end, prot, pages + batch=
_idx,
> >> +                                       prev_shift, &nr_mapped);
> >> +                       mapped_end =3D batch_start + (nr_mapped * PAGE=
_SIZE);
> >>                         if (err)
> >>                                 goto out;
> >>                         prev_shift =3D shift;
> >> @@ -3786,13 +3788,21 @@ static int vmap_pages_range_batched(unsigned l=
ong addr, unsigned long end,
> >>         }
> >>
> >>         /* Remaining */
> >> -       if (batch_start < end)
> >> +       if (batch_start < end) {
> >>                 err =3D vmap_pages_range_noflush_walk(batch_start, end=
, prot,
> >>                                 pages + batch_idx, prev_shift, &nr_map=
ped);
> >> +               mapped_end =3D batch_start + (nr_mapped * PAGE_SIZE);
> >> +       }
> >>
> >>  out:
> >> -       if (!err)
> >> +       if (err) {
> >> +               /* Undo the part the batches installed before they fai=
led. */
> >> +               if (mapped_end > addr)
> >> +                       __vunmap_range_noflush(addr, mapped_end, true)=
;
> >> +               kmsan_vunmap_range_noflush(addr, end, true);
> >
> > So, you are unmapping (addr, mapped_end) range but removing KMSAN
> > metadata for the entire (addr, end) range. Is that intended?
>
> Yes, that is intended. The metadata for the whole range is set up
> before the mapping starts, kmsan_vmap_pages_range_noflush() at the top
> of vmap_pages_range_batched() installs the shadow and origin pages for
> the entire [addr, end) in one go. So on failure the metadata is fully
> installed and has to go as a whole, while the page tables only reached
> mapped_end and are undone up to there.
>
> I know this looks somewhat awkward. The asymmetry comes from the metadata
> having to be set up before the mapping starts, I don't see a way to avoid=
 it.
> Maybe add a comment explaining this?

Are there any side-effects like the one we found earlier with
unmapping PTEs which we never installed?
I don't think a comment is needed as it's quite obvious.

>
> WDYT?
>
> Thanks
> Best Regards
> Hao
>
> >
> >> +       } else {
> >>                 flush_cache_vmap(addr, end);
> >> +       }
> >>         return err;
> >>  }
> >>
> >> --
> >> 2.25.1
> >>

