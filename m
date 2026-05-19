Return-Path: <linuxppc-dev+bounces-21194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5CBCD5BA4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 21:02:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKnDf5ltTz2xwH;
	Wed, 20 May 2026 07:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779224546;
	cv=pass; b=irH+qIIaO6KbNt+LP3rVRX8RCVDIxRdZWg3EQhzCb5Nz9XswVyxalKTI7MUWVG7xlhKA1Mn3NdDBtj2GApNnejEq9verCGjFOjx9KRgClqAaQGh4yGvTg2Gr4lhd2PJVOEtZQkDvUoHmP4gjoNUdIfwTKechB4hWAXs/b3qO6DNne7SVOXZKTg99w8CryeCmHrWGv+XMjr2YpGxYwJXt2X5IBTv7e5tkHsML+46cMYabnemLJnaRrT/vCIT6I59QO1TrEqKRLOp0qfAaRR+9YXJb5UN2ianfO7eiof7utFJw5/+aMSXa8ri3VhUzIr2hDHjoT+B+GHuUb6+RU9+eag==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779224546; c=relaxed/relaxed;
	bh=Bg1sJVq29IP0l0ZfRic8XdzhSk92ovWlIbkT7xGYhvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eChupQ2+Fs8CukH34sfTP3TRx+KNeS3/G5lKLz1jdwOFgQIR4wsEc9+xhl/dsB+rnqb9LcKoQFQ7kYfBWugshCtxy6oABn5w0fAo9XBv/pwpt+OGpF4LBVeI4N/2ogoEUMIcelQIphY7sebGa6GLDRZe3nk6WtVsg6Rc/DqVIa3ehHJMAdt9zJOdRi0PqZ6616fEWbiywvFcrjUxWH8SsUIuM55nkrgpRaj0R/QWGFCkGrZlWn8CtbohOID02EoS8FhaPitQfurkW1mc7tzgNSWVlnOP6vGVuAjz4Pipil9cRfYoIThKdQXhay2yPqKdwUAz6r8TDn514/oJHjUadw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVpj1P6I; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVpj1P6I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKnDd3l5tz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 07:02:24 +1000 (AEST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-bd11a3729e8so680571066b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 14:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779224542; cv=none;
        d=google.com; s=arc-20240605;
        b=eQk9iQB0Enf6gTsiZD7tAnA6lGmcX2OSsXPHi4RGUS0NRAYpqW9sT+5h86oHXggYc1
         8MvboaPcadtsHqSCF2Gy72Qkc6sfIwp33Dw3xSOKi7bnoLgWmXYxRsUJTKvDz429Yhum
         N9iWVBxt5bzuoIru8oR07ORPQWuUfjJNB5ED+SlPAARBqpQbhjlsiZbNp3ITm1cHng+S
         f8kxAnHkOphSGA0yU2YT5BCs00xZksknvcfv8w+0Lic2LYeomJvFvhIaEDuSjwfEJViL
         rNj33r3wDFO1IcP/f8cavDSgVCI26AORLSI9gZVl4REFKZ7BZNf09Lb34ciYB9WONkXJ
         eAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bg1sJVq29IP0l0ZfRic8XdzhSk92ovWlIbkT7xGYhvE=;
        fh=ThLk883jk7st7X3jLI1oHR68X3g5W7wniowM6KgZc+Y=;
        b=NyZKOgzaJk3+/QCI/E0uJV9AsDJUOPvwee4VrigujX1rAycFpFAQQA1xmrGd8LF6GD
         UAVagWHV2IkOIjhtjEYnFq0pCPgEe8E/DFutZdT0OCJyOoBllLPXddpsxyXdBm+qJdNV
         /swjBYvZkGCh8HJQNKh6T1UBK3iNWU6Mh8vz7HwyzgyXk/RpjgZBja7XWmhlRk9mwJVN
         eG61ktQF3BcNnQpisXEO+9BUJbif+NhghK8Rsmu+enYqpr0pPULd9zvv/fcPtcZx/v55
         u04bEyGUTcf1Fy5FbwVO0YgQ4AwkatZj2TyRm6hH39Fycb5JfK8aIkW1RnfGV+aKd7b/
         0XeA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779224542; x=1779829342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1sJVq29IP0l0ZfRic8XdzhSk92ovWlIbkT7xGYhvE=;
        b=eVpj1P6Iaskrq/s9eoJ/jA9TA3YNH9GGl9K14YOZYsYS86VFDrUyMgMEf/ivf04FvR
         F5bVPDjRpJXPV0GABY7256Pc3H9qkfLzCUPTcno7ckbbhl12RObnm6MFhYel/T/foAQJ
         BV7bMk+lywCoTsCL0YXWUNrqvHP1NMHEJCvR8wX7lMzREZpsOUZWY+/74Oh/t2YeISzd
         n0XYrfAqQnuRtH6wK1SXfG/bd0ClrRY6qZMwb/j4iB96iAdnCxgbngn5ba8EEL1rOn/Y
         OYq7bHiib0qBwL0405ZlMPsrBJkLTWfaFZRPYeCTmPfHsy29vKR+cV4Km5Tnfy2NnTEd
         rtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779224542; x=1779829342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bg1sJVq29IP0l0ZfRic8XdzhSk92ovWlIbkT7xGYhvE=;
        b=AqqBGFWturdcaRV3DeU1hIGZh/eZUMdGGOML8vN102qywGPM0UB00P7IEj2sTuovPy
         liIrfDOIDTGFnfwllo6Ce75OcvhBqQJzXBvcIweTrbN772D/kym/7Z9X1jW5NnvQOlh0
         0Ap5/r8wmdPQfDx5RGywWK6MCCx2OmE+NSct/IBu3nkropsyq/IJelmmrewp1g3iZc7Q
         KTS6TtoTd7at2qk2InuwyPmpEA7iGr1h8R7/h0M3ve1kk5ifjyk655rD4YeQ4QVSOs+q
         q9EOQ31x6NNEwSJUkFX+w4JyrY/e+94DrEOtjTAmK8WmCiOhILxBeDVwEV4NzxGag7ja
         0I0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+Wk9k+NEpokp1hK2GIrk3ejZrXY0SCoVrNdklyubI1b1GddnlnCBOphsxlvWH+ljqunzFKLmKJUSuTG9M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOqllTYj550kE/RU2Du98f4Cj4eHtk3Xm6W+L8M/aI4g76Hsej
	oEBly+ufF0Ew8PAAZZCwT2X+pkZjexPa5f/YMLlEK7VBW2IFVhuMcSvK/ALiL1wA9IAkWxnRci/
	BXYh5uaAxY+LkuDlIFhJFGCkZnbPCtHY=
X-Gm-Gg: Acq92OF7p3VdBoHK2x7JRc01tGmLoDUyZtdAP3aQNVu2UfKssloZZi9lPaALxwtoOb4
	gSVgze+iT7yD4ktOUWnhssYrx8Mususbrp652Ofai/56bjhmm0FcB9BJvVgczAbAyGfoV9/N4uT
	Ti5v/fdgxwI/jjZyuqIg9rLlTm2kLBLASgfHnAzyADtPRm3iGI929DDnFwbvd1Cr2a1dZSGohZR
	FMkrzmYvEJym3m7L29glIl8Clp28Opog9c2B4zAspoyqrKnJgYcEqHvz9B3XErFzQearkKDilid
	bfWlULAk/FH8Ox9o1Q==
X-Received: by 2002:a17:907:1b1c:b0:bd2:387:6bd with SMTP id
 a640c23a62f3a-bd5177afa91mr920483166b.4.1779224541529; Tue, 19 May 2026
 14:02:21 -0700 (PDT)
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
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
 <agxfLNuLCAT3F4cW@lucifer> <agxnJ8R-G3CRjeTR@lucifer> <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
In-Reply-To: <CAHbLzkpjOLrdRSUF3-G4d9uz6tn6QYwgB66UU9bud5WHr5FWEw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 14:02:09 -0700
X-Gm-Features: AVHnY4IdUrtf0zjmci6G1wPksPxXO0JC_jVTm-UIYV_TFA36gqIEv83n9ohB0es
Message-ID: <CAHbLzkrTF7w+T5mGsQuDRuhnTk6evTKBNRcH4oS=nRcUg2zpsg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:41=E2=80=AFAM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Tue, May 19, 2026 at 6:39=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> =
wrote:
> >
> > On Tue, May 19, 2026 at 02:12:10PM +0100, Lorenzo Stoakes wrote:
> > > On Mon, May 18, 2026 at 02:21:14PM -0700, Yang Shi wrote:
> > > > Maybe a little bit off topic. This is an interesting idea. It seems
> > > > possible we don't have to take vma write lock unconditionally. IIUC
> > > > the write lock is mainly used to serialize against page fault and
> > > > madvise, right? I got a crazy idea off the top of my head. We may b=
e
> > >
> > > Err no, it serialises against literally any modification or read of a=
ny
> > > characteristic of VMAs.
>
> If I remember correctly, you are not supposed to change VMA
> flags/size/mm pointer/vm_file/pgoff/prot, etc, under read vma lock or
> read mmap_lock.
>
> > >
> > > > able to just take vma write lock iff vma->anon_vma is not NULL.
> > >
> > > Except if we don't take it and vma->anon_vma is NULL, then somebody c=
an
> > > anon_vma_prepare() and change vma->anon_vma midway through a fork and=
 completely
> > > screw up the anon_vma fork hierarchy.
> >
> > correction: this won't happen as per Barry (see - I managed to confuse =
myself
> > here :), since for vma->anon_vma install we take the mmap read lock.
> >
> > BUT we also have to consider other cases.
> >
> > >
> > > So no.
> > >
> > > >
> > > > First of all, write mmap_lock is held, so the vma can't go or be
> > > > changed under us.
> > >
> > > vma->anon_vma can be changed.
> >
> > Correction: no it can't :)
>
> Yes, vma->anon_vma change should require taking read mmap_lock.
>
> >
> > >
> > > >
> > > > Secondly, if vma->anon_vma is NULL, it basically means either no pa=
ge
> > > > fault happened or no cow happened, so there is no page table to cop=
y,
> > > > this is also what copy_page_range() does currently. So we can shrin=
k
> > > > the critical section to:
> > >
> > > Firstly, with no VMA write lock, !vma->anon_vma means a fault can rac=
e and
> > > secondly copy_page_range() checks vma_needs_copy(), there are other c=
ases - PFN
> > > maps, mixed maps, UFFD W/P (ugh), guard regions.
> > >
> > > So yeah this isn't sufficient.
> >
> > However this is true...
>
> Yes, fault can race with fork. Basically this is actually the purpose
> of this idea. We can have improved page fault scalability. In my
> proposal (take write vma lock if vma->anon_vma is not NULL), the race
> just happens on the VMAs which page fault has not happened on before.

Sorry, this is incorrect. Page fault can't happen on those VMAs
because page fault needs to create anon_vma, but it requires taking
mmap_lock.
If anon_vma is not NULL, vma write lock will serialize against page
fault. So there should be no race with page fault. Removing vma write
lock suggested by Barry may increase race.

Thanks,
Yang

> vma_needs_copy() also skips the VMAs which don't have vma->anon_vma.
> So there is basically no difference in semantics other than more page
> fault races IIUC. It should be safe as long as we can guarantee there
> is no writable PTE point to a shared page after fork.
>
> For guard regions, it can be serialized by vma write lock if
> vma->anon_vma exists. If vma->anon_vma is NULL, it will prepare
> anon_vma, which will take read mmap_lock if I read the code correctly.
>
> I have not investigated UFFD yet.
>
> >
> > >
> > > >
> > > > if (vma->anon_vma) {
> > > >     vma_start_write_killable(src_vma);
> > > >     anon_vma_fork(dst_vma, src_vma);
> > > >     copy_page_range(dst_vma, src_vma);
> > > > }
> > >
> > > Yeah that's totally broken fo reasons above as I said :)
> > >
> > > >
> > > > But page fault can happen before write mmap_lock is taken, when we
> > > > check vma->anon_vma, it is possible it has not been set up yet. But=
 it
> > > > seems to be equivalent to page fault after fork and won't break the
> > > > semantic.
> > >
> > > It will totally break how the anon_vma hierarchy works :) See the lin=
ks at the
> > > top of https://ljs.io/talks for a link to various slides on anon_vma =
behaviour
> > > (it's really a pain to think about because it's a super broken abstra=
ction).
> > >
> > > You could end up with a CoW mapping that's unreachable from rmap and =
you could
> > > get some nasty issues with page table entries pointing at freed folio=
s :)
> >
> > Correction: actually we should be safe given mmap read lock on anon_vma=
 install.
> >
> > >
> > > >
> > > > Anyway, just a crazy idea, I may miss some corner cases.
> > >
> > > Yeah sorry to push back here but this is just not a viable approach.
>
> No worries. Thanks for all the feedback. Just tried to explore whether
> such an idea is feasible or not.
>
> > >
> > > And this is forgetting that we have relied on page faults being block=
ed by fork
> > > _forever_, who knows what else has baked in assumptions about that
> > > serialisation.
> > >
> > > Forking is one of the nastiest parts of mm and has had multiple, subt=
le, corner
> > > case breakages that have been a nightmare to deal with.
>
> Yes, this might be the biggest concern. The page fault can race with
> fork. If some applications rely on such subtle behavior, it may break,
> but such applications are fragile too.
>
> > >
> > > So I'm very much against changing this behaviour to try to fix someth=
ing in the
> > > fault path.
> > >
> > > We should address the fault path issues in the fault path :)
>
> Yeah, this idea was inspired by Barry's "not take vma read lock
> unconditionally" idea. Maybe irrelevant to Barry's priority inversion
> problem, just an idea for further optimization on page fault
> scalability. This probably should be a separate topic.
>
> Thanks,
> Yang
>
> >
> > Above still all true though.
> >
> > >
> > > >
> > > > Thanks,
> > > > Yang
> > > >
> > > > }
> > > >
> > > > >
> > > > > Based on the above, we may want to re-check whether fork()
> > > > > can be blocked by page faults. At the same time, if Suren,
> > > > > you, or anyone else has any comments, please feel free to
> > > > > share them.
> > > > >
> > > > > Best Regards
> > > > > Barry
> > > > >
> > >
> > > Cheers, Lorenzo
> >
> > So still a nope :)
> >
> > Cheers, Lorenzo

