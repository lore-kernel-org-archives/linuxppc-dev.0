Return-Path: <linuxppc-dev+bounces-19725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48431F531D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2026 03:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvpzq08jGz2yrD;
	Tue, 14 Apr 2026 13:05:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776135910;
	cv=none; b=ZeNdefj5G25nV1sz6qAaplGDIP5zFFmVpGF7YSne9oOt91dphkpnG+0v8Q/QfvLnJg+e5+VX+NbgDSZdZaTA7XlWsOODxkOpb0txE8RbeLKOipZo3bNoAlSqyzNVblLR/AQLmsJwTbq6dFO2Z7tRuEjRc8hRSwQAKwmt+IvFS4mmX8IeP56lbHcMhivhH3yypg9neCnKhfWvf/DH+cZtcB3eOcp7yaPXcU5wbVToWcuOVEGm5x8t9nQ3qsb+q8hAFQ0sV8olR0SiEHZcl9rKgpQwEmzgrhHg85t6pLAbT7MIDLMZ2rwiadHa/+OflbnjlWiRckAP/Tzk92+f5U5ijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776135910; c=relaxed/relaxed;
	bh=3FYu2CGFYAk0qz0gN9Zhq63kXcX9UNvQTBocmoERSRo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GOT8bXWzhFPgSYA8N8LtY1SexSINZ3ajDOvP+kzg24A2Y2OVW9UTef4EhCO3fJKywP/9Rw4ytfcaMNA6G+bNdb2mEGSqUV2dMwSHD2G8hekOFX5f2fx9cwLd0eQaNv8h9BQdK9mjqJgsFCvK3gjQEOBVlEDGfKxWxrNYhXq3MmQ8bA1qHQU3xOHmFOKJ5eK1eCC2Yi1vqjX4ulGRkWTlRI8ZgRD3+T2aPs+ZiWZjgUixFKy4bSkXXJ40Nnt8NHRRfvFcCglQMEFsQJoAjzTY1Fkq4gkJkhwlFHp4bD75pDJsvGZnJmX2iCnGf/nVBBLmTQt2639bCy4cjowDjjSEXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BWCLoDKy; dkim-atps=neutral; spf=pass (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BWCLoDKy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.176; helo=out-176.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvpzp2RKlz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2026 13:05:10 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776135890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FYu2CGFYAk0qz0gN9Zhq63kXcX9UNvQTBocmoERSRo=;
	b=BWCLoDKyxBJFi3Ak8GVKAz3mczB5fhYPqbcTIn1JLJPdaRGKuULfEgReV+W36aXs54UIbv
	N6iKcqxl/Jq+Aytf+mV9Vw3DB8IDAjq24brNkTJwfYetGa4OJz2ESJjTkIKKipP/I2cSLQ
	nvwBpt3fEMn40XHMClXyUhbDujjNcsk=
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
Subject: Re: [PATCH 06/49] mm/mm_init: fix uninitialized pageblock migratetype
 for ZONE_DEVICE compound pages
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <42ba7f13-846f-4150-8195-32a775bb6812@kernel.org>
Date: Tue, 14 Apr 2026 11:04:13 +0800
Cc: Mike Rapoport <rppt@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Liam R Howlett <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADD34ADF-76A9-4073-A15C-024DDEABB35E@linux.dev>
References: <adzvdRPrK55TutT6@kernel.org>
 <ADC5EFE8-454D-4B9D-8BB0-39FF671290F0@linux.dev>
 <42ba7f13-846f-4150-8195-32a775bb6812@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 14, 2026, at 02:50, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 4/13/26 15:57, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 13, 2026, at 21:28, Mike Rapoport <rppt@kernel.org> wrote:
>>>=20
>>> =EF=BB=BFOn Mon, Apr 13, 2026 at 06:07:44PM +0800, Muchun Song =
wrote:
>>>>=20
>>>>=20
>>>>=20
>>>> Of course not.
>>>>=20
>>>>=20
>>>> There are indeed many more cond_resched() than before, but I =
don=E2=80=99t have a
>>>> concise way to write it, so I took the easy way out.
>>>>=20
>>>> How about:
>>>>=20
>>>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>>>> index 2d680636b67a..d13a2577c4c3 100644
>>>> --- a/mm/mm_init.c
>>>> +++ b/mm/mm_init.c
>>>> @@ -683,7 +683,8 @@ static __meminit void =
pageblock_migratetype_init_range(unsigned long pfn,
>>>>=20
>>>>       for (pfn =3D pageblock_align(pfn); pfn < end; pfn +=3D =
pageblock_nr_pages) {
>>>>               init_pageblock_migratetype(pfn_to_page(pfn), =
migratetype, isolate);
>>>> -               cond_resched();
>>>> +               if ((pfn & (pageblock_nr_pages * 512 - 1)) =3D=3D =
0)
>>>> +                       cond_resched();
>>>=20
>>> TBH, I don't know if 512 is the right number :)
>>=20
>> I picked this number out of thin air. I=E2=80=99m not sure as well.
>>=20
>>>=20
>>> pageblock boundary was a convenient point to have cond_resched() =
along with
>>> setting the migrate type.
>>>=20
>>> Here we might be able to squeeze more iterations between subsequent
>>> cond_resched() calls.
>>=20
>> Choosing an appropriate number is indeed difficult. We need to =
consider
>> both unnecessary cond_resched() calls and scheduling latency, and the
>> specific value also depends on the current CPU performance. At the =
very least,
>> I find it hard to choose a correct value. Since we all agree it =
should be larger
>> than 512, why not just pick 1024? I can't think of a good evaluation =
criterion
>> or selection method either.
>=20
> I think in some other code we just use section boundaries.

It is a good suggestion. I'll do that.

Thanks.

>=20
> --=20
> Cheers,
>=20
> David


