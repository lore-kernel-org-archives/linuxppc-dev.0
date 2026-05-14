Return-Path: <linuxppc-dev+bounces-20930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1A9CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 02:38:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGDzK4FvFz2xYg;
	Thu, 14 May 2026 12:38:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778726317;
	cv=none; b=ir0IrBu2zt9M84FoBxZICctC99uvGTnElYtFrB+KUmHbAtWPlk4cOOLnD9YCUQwNuNO17xZZofw6RvgGf/faBwjYQLyDEfLBnKsFkMgP2FZ16FWvYrrWiYHxwdOn3q6oqFp/kemZ8NLrYrwZ3ctG0HFBcQKR8J3xBuTpwrkBXrnY2K4vKzsJrzqXQo2B4tqc5jWDDlMUTTFU/E0YNnEbNljMMHiy1V1FggznKs17iTWq+YsBS5saE1hVoyQLkBLOKhw7wyqs4hgFN/HnLWuRQ8fYRQC2XA6s0Ia1hnFuGw+Nq76nOhw2kTWJCTWMNazrSAxN/NJtZQ/KrBnqJP0X/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778726317; c=relaxed/relaxed;
	bh=8mMFd2ZuPeB5whmvIjvKFCtK7Zo6oHHV9ZAT05XKL+g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KQlSOBZvOeOrC6jVuKzwZ+K/lPwyNXZPpcBxe5gv2w0yA3Gom7fSyKqF3Bv5TMSw/SMz32l7woWNml84BwPY7ew9p0Pnl+9FGhCPGdXdTI4h35BFuT+LbNADu+hNV6q20E3HFTY/i8BPXZU4HXZNF8zHCpN+VVl8XPdWn5OhbgwBkAb2TkJf5OMyBQk7QldahxgCDdgOi8+zb+HcLJuKdjzI0sPb37x36q+OPuhsty42zyiKtkaRBO7XVqY3qgnsB79U3HP+qzDSBWI1mcmkuR3UqLH1RNnkzV7cjNnGbMIUu8oavS4kf11whN8vAff+ghDvmbI7f7SYmpozyo4RNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YJ8Tnuzx; dkim-atps=neutral; spf=pass (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YJ8Tnuzx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.174; helo=out-174.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGDzF2Gj4z2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 12:38:33 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778726291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mMFd2ZuPeB5whmvIjvKFCtK7Zo6oHHV9ZAT05XKL+g=;
	b=YJ8TnuzxHEEH6IGA816hfhYy2ZuUWTHbBFnfRTdtiCoL2PJPGBTdMLmLT8GaRMx02Xg+qZ
	te5f6Nmt3sPS6YWm2KBMMpFXE0NIapbu4pT7jl9Ixrk9Ly+k8DbJyT6zRyGENmh2GdbFc0
	MqH0D+Ve2tIwNA+2eTcykwWQdcbdS3c=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 00/69] mm: Generalize HVO for HugeTLB and device DAX
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <agTCbglgY23ydrDx@localhost.localdomain>
Date: Thu, 14 May 2026 10:37:28 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ackerley Tng <ackerleytng@google.com>,
 Frank van der Linden <fvdl@google.com>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF9B5F01-7EAB-4655-A6DB-E0594201DE72@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
 <agTCbglgY23ydrDx@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 14, 2026, at 02:26, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, May 13, 2026 at 10:46:40AM -0700, Andrew Morton wrote:
>> On Wed, 13 May 2026 21:04:28 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>>=20
>>> In this series, HVO is redefined as Hugepage Vmemmap Optimization: a
>>> general vmemmap optimization model for large hugepage-backed =
mappings,
>>> rather than a HugeTLB-only implementation detail.
>>>=20
>>> The existing code grew around the original HugeTLB-specific HVO =
path,
>>> while device DAX developed similar but separate vmemmap optimization
>>> handling. As a result, the current implementation carries duplicated
>>> logic, boot-time special cases, and subsystem-specific interfaces =
around
>>> what is fundamentally the same sparse-vmemmap optimization.
>>>=20
>>> This series generalizes that optimization into a common framework =
used
>>> by both HugeTLB and device DAX.
>>>=20
>>> The first few patches include some minor bug fixes found during =
AI-aided
>>> review of the current code. These fixes are not the main goal of the
>>> series, but the later refactoring and unification work depends on =
them,
>>> so they are included here as preparatory changes.
>>>=20
>>> The series then reworks the relevant early boot and sparse
>>> initialization paths, introduces a generic section-based =
sparse-vmemmap
>>> optimization infrastructure, switches HugeTLB and device DAX over to =
the
>>> shared implementation, and removes the old special-case code.
>>>=20
>>> ...
>>>=20
>>> 46 files changed, 743 insertions(+), 1812 deletions(-)
>>=20
>> Gulp.
>>=20
>> I think the first 15ish patches (little fixes and cleanups and
>> refactorings) are ready to go in immediately?
>=20
> I plan to have a (partial ) look at this tomorrow/Friday, but =
splitting

Thanks.

> this series in fixes-that-can-go-straight-away and the feature itself =
would make more
> sense and help ease the review.

Yes.

> Head tends to spin a bit when the patchset grows beyond certain number =
of patches :-D.
>=20
> Would that be possible Munchun?

I'd prefer to group the first 19 patches into a single series (titled
"Refactor bootmem gigantic hugepage allocation"). Therefore, waiting
for your review. :)

Once patches 13-19 pass review, I will send them out as a standalone
series.

Muchun,
Thanks.

>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs



