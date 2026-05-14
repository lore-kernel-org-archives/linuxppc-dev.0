Return-Path: <linuxppc-dev+bounces-20929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04F0CD4F21
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 02:36:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGDwc1f7Tz2xYg;
	Thu, 14 May 2026 12:36:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778726176;
	cv=none; b=LIAwwLX/1qMrF4vLyCQ/JAL/sxMVG5E6wKgHheApz+70/HV+7YT1iH7jwluWb0oBtuBfqaFqNKyY3HijvaaDyH7DupFpRlEPTeeS2JQMkj/AecQZ0DBI7eQgBD/cLiDCKeP/Spr0aFk5ZOJ/dEQGrHdj9U7I8CY9S/qusaS+8YDzNKyQUMmhz5ljMd8b1GvlE8iyXVywHFfqBRFZhE7TOQdEdDxbYL3uwsc5g/8SnX6XNtQxDVVGpvJQR28Q7MeJvx49UzLcO1mq16CCwYNs/rzQGZYPBoOIVXy6Km6AYBYOJs4BylJZFQ6UuJbYRGpYiVlPgu0Ie1vA25k8H8G5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778726176; c=relaxed/relaxed;
	bh=L4R4J3RwmjA53m4R5RtoEscHz/YnvUKFxIVx8Fa4X0Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FZfdqy4l4Hon8Suawp+K2lFopbduYgcRQ+wrOvVzMFQnNl4zohzq3yD/KQrGSfYqo9XGRWvLxFuWPFMcgvBY10NnX7SbNvGUcrNY7IdChY3rOUZARiwRATHSBVkK0bk4z3Izil71192vlPk3SqOusvlFtWkn/g5dHEIjnYY5R+Jm68woXB/yVqeryVfJF/j9yAYTOkQeO6CL1yseQoo1o+qoPoU3uzl29JcgCqOO9t83ii/nW6CNvnkUR/WQboDSZbumZ05ec2xXdnXdRPWkaEpjaXTK6ABSMJQbivrznTaP5EhRc8alrXAced8YKpkYVEYa5BvpYjWMzTRtRZBBWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G+ZKSnnC; dkim-atps=neutral; spf=pass (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G+ZKSnnC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGDwT4rbYz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 12:36:08 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778726147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4R4J3RwmjA53m4R5RtoEscHz/YnvUKFxIVx8Fa4X0Y=;
	b=G+ZKSnnCixAkusAvNx6AviFC3l0Yw71F5NKxYrgFc01CFGNA8UCorUPtvcKSg93EZexN6o
	LY/S4mSvSVORzskYnSqY3BqBXcs53W74fBdTaaxkCqDTFWUT87NxnO7gEnFac81DF2uyN/
	sbLMEsPwxcBoPKg6XFBJX2woeDspPkc=
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
In-Reply-To: <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
Date: Thu, 14 May 2026 10:34:56 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
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
Message-Id: <72F6690C-D94B-4398-87C7-4611A96C50AC@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On May 14, 2026, at 01:46, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Wed, 13 May 2026 21:04:28 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> In this series, HVO is redefined as Hugepage Vmemmap Optimization: a
>> general vmemmap optimization model for large hugepage-backed =
mappings,
>> rather than a HugeTLB-only implementation detail.
>>=20
>> The existing code grew around the original HugeTLB-specific HVO path,
>> while device DAX developed similar but separate vmemmap optimization
>> handling. As a result, the current implementation carries duplicated
>> logic, boot-time special cases, and subsystem-specific interfaces =
around
>> what is fundamentally the same sparse-vmemmap optimization.
>>=20
>> This series generalizes that optimization into a common framework =
used
>> by both HugeTLB and device DAX.
>>=20
>> The first few patches include some minor bug fixes found during =
AI-aided
>> review of the current code. These fixes are not the main goal of the
>> series, but the later refactoring and unification work depends on =
them,
>> so they are included here as preparatory changes.
>>=20
>> The series then reworks the relevant early boot and sparse
>> initialization paths, introduces a generic section-based =
sparse-vmemmap
>> optimization infrastructure, switches HugeTLB and device DAX over to =
the
>> shared implementation, and removes the old special-case code.
>>=20
>> ...
>>=20
>> 46 files changed, 743 insertions(+), 1812 deletions(-)
>=20
> Gulp.

Sorry for a so big series to refactor lots of things.

>=20
> I think the first 15ish patches (little fixes and cleanups and
> refactorings) are ready to go in immediately?

Overall, I believe the first 12 patches (excluding the bugfixes)
have already been reviewed by Mike and are theoretically ready
to be merged.

>=20
> Perhaps you could prepare such things as a separate series.  Or tell =
me
> which ones are suitable and I'll fudge up a [0/N]?

I'd prefer to group the first 19 patches into a single series (titled
"Refactor bootmem gigantic hugepage allocation"). Therefore, I
suggest waiting for feedback from other maintainers/reviewers;
once patches 13-19 pass review, I will send them out as a standalone
series.

Muchun,
Thanks.



