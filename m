Return-Path: <linuxppc-dev+bounces-28464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9DBCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:56:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv9Tz5dpYz2yDD;
	Tue, 29 Sep 2026 17:56:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790668567;
	cv=none; b=I0aKSTjR5XusWQZ7O6lkFDS1Zx+R9c/kMnzOesKrrs/+6crIoKL45TMLMbhSe8dfoIFujeueLUwdKPQc6bsX0mik/OkXLLGZKvA52/Tl94BOJ+nm9T0hbnfDdmTMJ0BmcC7hTYFSSmhZP0jaInVHZwzhLAl9VZAUzQR1lykFGtQYTb4BELlwMIP/wO16fbqtAoTh2ZrammEY3L7Xvvqy7dVU1+hfBWQ9f/xlqi3/ze3iWbwjJlGZhCg/4SoTlOn15YZEr73Ox2D9+V8UiMYGH48FIWMBI6CTmpBrMQNkWFXU+vYUtFLKUTU6mRyvPSMORHDx3JNT0xpKRYq52RTIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790668567; c=relaxed/relaxed;
	bh=jMi3M1iULFUfuMEEhHz4Tqsh151CRH++Ayaby/JxpbM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fAwv/DsWsBcbvnr8IkWPM2xh7Wyw1hoy5zP53EklZciE4B0GSi0SGNDOSlVReOf4/Mi9pGSZ6TEtOopsqU10ah705QNJT6FPPbsCuAr7VRqyon9837AIqiJ8nf6wd9jRi4jRU+Ct24gIxi+yhbTwRlEFV9WyKqnFz6jk8PW3EcLBrw+pD82NTLcEyztaYyed1NdwvHQy6wvV7yUbgb8Zti+jgfOmtx2Ux8glUjy2LtjH8SYlhpQYSYQUryvSM11wqApd/AAoLiTwZxHlAZmaRvfS7nhOcrVrIiy8X+ftcyxn67dCKmhdjzDpgjlSPYJUDAKuGhhnjg7ASofm6SA4vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NDrUg/Ro; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NDrUg/Ro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv9Ty3q35z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:56:06 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=nj3wtQVl7vcnhMbNppV9t0dGEHcungOiAb7gmBQ9b+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790668547; v=1; x=1791273347;
 b=NDrUg/RoF1bPvVighGofc9LgFh5CsV8P86ekZ3WhxBT7oEPsv2EaiQEbUnovbXjLyRji/zXp
 zu1s05qQAaWgnEjHbV11T2RK/fszFU/20H8cgPwE/HMRnaKxGC/qzDC7+I+Z6jOgfFoZRyMwaa0
 RyucxV3hUsLBqVNRW5VdkRs0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta11.migadu.com with ESMTPS id 06442dbddb022582;
	Tue, 29 Sep 2026 07:55:38 +0000
X-Mizu-Trace-ID: 06442dbddb022582
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v5 01/12] mm/sparse-vmemmap: factor out shared vmemmap
 tail page allocation
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5c73e3b9-4eca-4b84-ba3d-85bb7d6f77dc@kernel.org>
Date: Tue, 29 Sep 2026 15:55:21 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lance Yang <lance.yang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BA39A32-5851-42B2-8822-F427D08577D8@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-2-songmuchun@bytedance.com>
 <5c73e3b9-4eca-4b84-ba3d-85bb7d6f77dc@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 15:16, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/27/26 04:54, Muchun Song wrote:
>> HugeTLB and sparse-vmemmap each have their own helper to allocate the
>> shared vmemmap tail page used by vmemmap optimization.
>>=20
>> Factor that logic into a common vmemmap_shared_tail_page() helper. It
>> allocates the page through vmemmap_alloc_block(), initializes the =
tail
>> struct pages, and uses cmpxchg() to install the per-zone shared page.
>>=20
>> This removes duplicate allocation logic while handling both early =
boot
>> and runtime allocation through the same helper.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> ---
>> v5:
>> - Move this patch before CONFIG_VMEMMAP_OPTIMIZATION is introduced
>>=20
>> v4:
>> - Update the commit message for the renamed VMEMMAP_OPTIMIZATION =
config
>> - Collect Acked-by from Mike Rapoport
>>=20
>> v2:
>> - Collect Acked-by from Qi Zheng
>> ---
>=20
> [...]
>=20
>>=20
>> #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> -static __meminit struct page *vmemmap_get_tail(unsigned int order, =
struct zone *zone)
>> +struct page __ref *vmemmap_shared_tail_page(unsigned int order, =
struct zone *zone)
>> {
>> - 	struct page *p, *tail;
>> - 	unsigned int idx;
>> - 	int node =3D zone_to_nid(zone);
>> + 	void *addr;
>> + 	struct page *page;
>> + 	const unsigned int idx =3D order - =
VMEMMAP_OPTIMIZATION_MIN_ORDER;
>=20
> Nit: constants read much nicer all the way at the top.

I can update to this next version.

>=20
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

>=20
> --=20
> Cheers,
>=20
> David



