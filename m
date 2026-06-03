Return-Path: <linuxppc-dev+bounces-21931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AFCCD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 02:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVX4R1vZyz2yRF;
	Wed, 03 Jun 2026 12:40:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780454439;
	cv=none; b=DVNWf/epXg6Pc/QC1OHjJoT4QKikt2l8F80AUhq/MlgWlJ/P6oLzw+Cp4ExVNL4r5FDkbiEe20KrKuKtxUf/pvP0aja5MVNih2cLajM8wsgW00y3zxiF+WgE5QziimgHL8wkR4VW8cqf+L29XczEWg34aud4onFTZoJFofojd4gaJ8cMrMPRTuGWFyE4pq4itJr/Q8Mf8okJq+ctDGCcocQDIjmqkochl7Lc1PCDRtGSXj1MLcprbtOnMjzBmKAglVNbTk6mhwlJKthPAIvRSfml60MAgBSxVeGqbATpzggomynuKvjD/QGM7N5MuMs587JvHoq9CQxzkWBef1VLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780454439; c=relaxed/relaxed;
	bh=enhp+3s0SIGEOwjQc/7W6s5wIzCQbFdyWa31w7PMhyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KaFzngN2PtIGjJkgt6khkzkqbTj1b4wgLwBDSnCONiNo5sNl0FS8cGTOu89ypKoEGmYqwT14Zz2E7ahUwAgwy1AosFM0TrWHym9H5hXmFGEj91jWGjeOvoSG1W7XFBV8j2KYiw7G56jKOjP4sUrLjl3ryI0bbQDhw8iqbZyOu+lZ4obxVQxPgTqlr7dvauH9AHvLSotyn/nvBZff4+PePm8St1yAH8HGMCJzBtwWj4aEI9gguhk1ceNRH4nb4O47kNXmvGy4jycGhO7VZzc/yF2LX+9HEdXeH6qswhaKBzeDfcb0EbUNYDFfVU8z21xyilfXTyeBaxJCG1MWZHxE8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a6OO/AGV; dkim-atps=neutral; spf=pass (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a6OO/AGV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.187; helo=out-187.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVX4M0LPxz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 12:40:33 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780454408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=enhp+3s0SIGEOwjQc/7W6s5wIzCQbFdyWa31w7PMhyM=;
	b=a6OO/AGVjZPTkYLmFE58mUZkc+Ig9OvucaVesgXboaIsfd35hyTrwEOUiKCMdq62BTHjWY
	3iDA8+TOhj7GAKI9lEBKJK0ZAnOuZOAJh+A43sHVWZsP4eRe4lyDV6hA2e/VlitznVZPoQ
	w1ZVN5buyzqpE2WMljQJpn7BDAJVmsc=
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
Subject: Re: [PATCH v3 19/19] mm/mm_init: Fold __init_page_from_nid() into
 __init_deferred_page()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <178041489408.457517.2991925440539441241.b4-review@b4>
Date: Wed, 3 Jun 2026 10:39:20 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10D5F5E9-889C-4B4D-B104-A1579A771F45@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-20-songmuchun@bytedance.com>
 <178041489408.457517.2991925440539441241.b4-review@b4>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Jun 2, 2026, at 23:41, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Tue, 02 Jun 2026 18:10:39 +0800, Muchun Song =
<songmuchun@bytedance.com> wrote:
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 41b83dd18c01..f1bbf3b9a321 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -771,10 +746,27 @@ defer_init(int nid, unsigned long pfn, unsigned =
long end_pfn)
>>=20
>> static void __meminit __init_deferred_page(unsigned long pfn, int =
nid)
>> {
>> + 	pg_data_t *pgdat;
>> + 	int zid;
>> +
>> 	if (early_page_initialised(pfn, nid))
>> 		return;
>>=20
>> - 	__init_page_from_nid(pfn, nid);
>> + 	pgdat =3D NODE_DATA(nid);
>=20
> Nit: we can initialize pgdat at declaration line, other than that

Yes, will do next version.

>=20
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

>=20
> --=20
> Sincerely yours,
> Mike.
>=20


