Return-Path: <linuxppc-dev+bounces-21375-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F270DCD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:06:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMKBn4tq2z2xSN;
	Fri, 22 May 2026 19:06:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ad"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779440769;
	cv=none; b=L2iD7oo0LLt7Og2JwUY5zNHWZkYaWFUtYidiHLb3JfB1H/lTBx6UBrjPvmZXOoBRDVupJNqT+pT7o5V/oAS0nUtRconcxkMCTcF+Ze0m/SB4AbBCqMCI605TDp3+JbzIOuIJ15Lu3rUqDsXpp8NH34vL0oOpZd31YgjSuyxkAfaDvfA6mzJvYzZIVowkAvrd8ZGZkhepKgl1pX+QGH/Se2GedAogK+DAYR+dSBjWIdlEVlS+xwp5Z1szvvF2QSef5AioJkYxaHi57nipqKUts54KTJ/B19jQZLbwp85/AQq0TEtbAj27gcANnaNLnZHnqi2NOauIwH5DPPV/GhA/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779440769; c=relaxed/relaxed;
	bh=1NVGJAwjRYdYLDsgDMYCGdkDCjTx9lBBzpo10EYl6JA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZeJeWZjM+VvbF6W33bsMXEKFKBHHIIas7Y8tHxnA9U4EQyVtx2orrIoo6UVCxj7H5SWleCv5MZWHClQ7zapil0fSs4iSe1AL68A8wRnOFwi0pzShfTycrwe4S6O+tVJQwEQIyrdKpZo45FA8rihTKaZrTDXTv6u7ikC2mn967tE9odwXXTge6UiSMa2ZKhuDo5MiV7YW2Vx9AUqjwNgqd1MOju35tska0TcjgRJdRj+qEInFMDXDYUtL2yg9UisrhsfAug4GBkBEowPupyGM6uoay8v1Gqw+J1y2hK02t31RqJnTdEjtG9Xby7J4idZzFmcOO+3mNX8Hjy33MZ6FWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B49aNU7k; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ad; helo=out-173.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B49aNU7k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ad; helo=out-173.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMKBk38B9z2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:06:05 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779440744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NVGJAwjRYdYLDsgDMYCGdkDCjTx9lBBzpo10EYl6JA=;
	b=B49aNU7k6CX1dZenwrn+rErfz6tvzbRfrKIkl8CoNbbMplacayg0mtXqthPft0rU8/bFpZ
	PZ3rd7X3CeHi5njAUJSgw90RlK8XzisAA7J9jS/U3TYejrLiUFpEQVX0Oz2l9XLPIihRrd
	S95uIFSihKgrGC5Zwx0FLO/KNTCWnJk=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 13/69] mm/hugetlb: Refactor early boot gigantic
 hugepage allocation
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <177944019668.3663073.6529634450029926963.b4-review@b4>
Date: Fri, 22 May 2026 17:05:05 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
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
Message-Id: <D8D2C0F7-7B60-46FF-BE1E-8CBF941D4744@linux.dev>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513130542.35604-14-songmuchun@bytedance.com>
 <177944019668.3663073.6529634450029926963.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On May 22, 2026, at 16:56, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Wed, 13 May 2026 21:04:41 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>> diff --git a/arch/powerpc/mm/hugetlbpage.c =
b/arch/powerpc/mm/hugetlbpage.c
>> index 558fafb82b8a..ff8c5ec831bb 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -104,17 +104,14 @@ void __init pseries_add_gpage(u64 addr, u64 =
page_size, unsigned long number_of_p
>> }
>> }
>>=20
>> -static int __init pseries_alloc_bootmem_huge_page(struct hstate =
*hstate)
>> +static __init void *pseries_alloc_bootmem_huge_page(struct hstate =
*hstate)
>> {
>> struct huge_bootmem_page *m;
>=20
> This can be void *m and powerpc code does not need to know about =
struct
> huge_bootmem_page at all and its declaration can be moved out of
> include/linux

Make sense.

>=20
> Other than that
>=20
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

Muchun.

>=20
> --=20
> Sincerely yours,
> Mike.
>=20


