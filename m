Return-Path: <linuxppc-dev+bounces-20375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C00CD3424
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 18:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6fcK42GJz30Lw;
	Sat, 02 May 2026 04:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777659953;
	cv=none; b=DOHSxVJkrxfjIyRMzWJDa18C4jeag+ojDfcIBjMoLMlqEgLuIBGl7rz0hjk+8OMXxPzvDJjJNfO6Cnvi81VlPTrWtepk6ARsWNgrWqpIQI8d9I5VtlYabF+E+DXY13/pT0uur36S6Sn4sapnDrSQaAAQQrvoThXGDs6RnLmPIs9reJMSjx2EsiPRdexC+nJTBNsBB2WJHTlucPC1i6pkx/beXF2XRkiT3aeTdgOdrz0MFudEWejLsPEFcO6YA+j33pcxuju1BO7EUoHkQhXTuf4oLszP8fQC4+SuO+5J415Iei2xExD6F0rADPPVBBc+QhyEAUUKts4PzzhJRJYbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777659953; c=relaxed/relaxed;
	bh=D4A1t9IUPAxFiSXYXl3Z4jwgMAwfMFsg3JsxiXOyKCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knbkbyiDquHMT9k978XFXANFDyLFNw9jmArcR0aVMKDVsNSfoshuuW1EHsIhkZDFnKY8iqKMHyL6SoKb8PmLZHla4OOZvAyrSX2AWtuhaCeMdMH8L+14QAJPfcZH5pqihcW6EIvqWIyRjn2tuv/AkYQuRbE1Ot0/0387fQ1z+fyM8jETLrC1GAUWlW+Nk6GYOKSRdX29QWxQFDNte8Ik1R8fSpCfrtrNVj4x1QRRQDuvTux6u02fC74CLxG5rFK74qoUR3KeOtlpZN7/GqZaSVVk4S7GBAu1OMKdlWeb5oct7yegh/goz1GlwTlD6YkRZl9C8HnYeplISxTU9jsl2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FIVeO3aI; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=FIVeO3aI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6fcJ2f1Wz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 May 2026 04:25:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E45F344555
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 18:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB309C2BD00
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2026 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777659949;
	bh=lT/rPel9FmT35iq3NDhHuchj5jXwn6oKumOJ4dCsmXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIVeO3aI7z+jFqDqXITJ+jWsf7lknsacv1Vzwcn4Qsr6jBLZMM2APApvdOADED8Ln
	 tAIwXt9R3qywh7SwzohMPLV0t1vg1LPT7kOq55TgbdDGfwhWLLAjfL+brTf/OPCywN
	 jEfUkX05+1k8ouTnvv+GA9F+JEnzTnf5Oa3U2Pt8IrB7QbY20FMPALZdtczL2ANGRj
	 CrACi6wIjjOv4ftAgLt74Gg2ts3YaDODuAFLoaOg1uLSZtNISIx6WZBJZfcCC4lqXH
	 2KD3b4Y7/PA6fAAoCZuEsL9/UflhQWvEAIT7FBdFCoa8CcfRc5UKFiKNKCX0uHRqoY
	 UbCOWCsY8mKUw==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e97863425so20851781cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 11:25:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VxHJu4Urb2DOEOYrZcdciRR65l/99361k3sthxpBVc3HQ5YyHUmMYfb80z4vbcbn7AAZvwQGO3dUam/Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxVg9UY/AT61rdvnkTkMt49R5L0cGSMxA8WdQeda8GX8c3SD9R
	xiykhbdPHdU+AnT/LE4Pnamf9EtCYE1V4xE9cHMBLtsDTqCP2QFQNiPYrhaY5tB1Jr3bjxrt5lV
	Ljp7ZJnNtbVct3QfcKVnfcg72HOI5M4w=
X-Received: by 2002:ac8:7dce:0:b0:509:2455:2b53 with SMTP id
 d75a77b69052e-5104bf755a7mr5248631cf.49.1777659948730; Fri, 01 May 2026
 11:25:48 -0700 (PDT)
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
 <afTpoL3FklpQZNMM@casper.infradead.org>
In-Reply-To: <afTpoL3FklpQZNMM@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sat, 2 May 2026 02:25:37 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
X-Gm-Features: AVHnY4Jc3ag1bUQ2844h_SA5sVSne-TN_r5pli71-jMQXFzkdxM1Ig0IdK36GUU
Message-ID: <CAGsJ_4x8sNtgv7Y198Gh9NSY+SE2o_JPFAxG9aWE+xXsB9vwGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > 1. There is no deterministic latency for I/O completion. It depends=
 on
> > > > both the hardware and the software stack (bio/request queues and th=
e
> > > > block scheduler). Sometimes the latency is short; at other times it=
 can
> > > > be quite long. In such cases, a high-priority thread performing ope=
rations
> > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to=
 wait
> > > > for an unpredictable amount of time.
> > >
> > > But does that actually happen?  I find it hard to believe that thread=
 A
> > > unmaps a VMA while thread B is in the middle of taking a page fault i=
n
> > > that same VMA.  mprotect() and madvise() are more likely to happen, b=
ut
> > > it still seems really unlikely to me.
> >
> > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > the entire VMA=E2=80=94just a portion of it is sufficient.
>
> Yes, but that still fails to answer "does this actually happen".  How muc=
h
> performance is all this complexity in the page fault handler buying us?
> If you don't answer this question, I'm just going to go in and rip it
> all out.

I=E2=80=99m getting quite confused. In patch 4/5, you suggest a more
restrictive condition using
if (folio_test_uptodate(folio) && !folio_test_writeback(folio))
rather than if (folio_test_uptodate(folio)), before we decide to skip
retrying the page fault [1].
That seems to suggest we should be more cautious about when we can skip
retrying the page fault.

However, in the cover letter, you suggest removing all retry code entirely.
Does this suggestion apply only to file-backed page faults?

[1] https://lore.kernel.org/linux-mm/afTQl12XcXVnku9J@casper.infradead.org/

Best Regards
Barry

