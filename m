Return-Path: <linuxppc-dev+bounces-21990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF05CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 02:10:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gW7M56lCSz2xll;
	Thu, 04 Jun 2026 12:10:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::aa"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780539025;
	cv=none; b=IdcHbsbQSj+Jg28NLeG4gMAC6NMPS/VOkPya0pZfjOJCOJlCz3qTbr2SYWcEsOVILsCHwxRHDjCkAdOx5WW6vPXiHJrroSrr/2fAsqSfZelNAfvXsV/P1+ZaURMtevEGMkEJrNBYGbs//ltdFpE7LV7GHk/slEeqPL7Q8ZYaaIxB04CTv3iHC02puRHHW7HcAyvTuQ+NndpIkbyfyBWDaL9tYiHqztq6wKxQIVmCc4PknWashCYw61IqTZ2zyITwakWD2k0Zz2iNRrjKJTa6VKT8mOmj0wgVjTYbsJT9wRj0cHWK9LPit6oCGO6ca3wVMQkrqsDgxwrcV1tRZe3mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780539025; c=relaxed/relaxed;
	bh=SYYlpuIZtVb2DJ6ddOz5+v3tiHxrY2b/L9P1iXO5xQw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aWQmFJBtLSSGVCTn4gGhEmjmxNKwmtOZxSzHLfifh3UkPPSD1BvYWo1rf9SOCVgK5+WcQd6YSfjIjBgvH6XA//eRfm7SI1/3ocNwv7Hfx8DhHo8odJAUZUOZAuJTHVnmGIp9HZKsuGp0nUcfwLuN5Xvuxt3xrRM35ROmydX3DzE73ii19sUzqVdehbeYUIqYWb+huJjfUUZ5POqW+KhAvVrpc2V54B2Mx5L5w6+J+X31h2OLXwV8+zhtmylRTgsVQCxAtYppiARuHNiT921iSM/ClsKmiTW1nSM4HBi0+3O5ACgM3WUePyMYUVAHG6Th84ubgGHsE1Y+OpqhwkZ5Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BVM+v5AS; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::aa; helo=out-170.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BVM+v5AS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::aa; helo=out-170.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gW7M06gzQz2xMQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 12:10:17 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780538996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYYlpuIZtVb2DJ6ddOz5+v3tiHxrY2b/L9P1iXO5xQw=;
	b=BVM+v5ASLEaiZ4JQLzfJvFLqOPWTDAaGV3KSPFn4gTmSu1BmjE3O6M4yv4EtfiH47FXbD2
	cmbSuWpxrMaBHktf3GQUIFVP8zvy+XElWOSf4Sdq+OWHkKiqyLF/NSOOby8Y92bPZLZcGe
	WIdlju8y8/J0hbvxMAfo8q7jpk0gJzE=
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
Subject: Re: [PATCH v3 03/19] powerpc/mm: Fix wrong addr_pfn tracking in
 compound vmemmap population
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a4tbwv0s.ritesh.list@gmail.com>
Date: Thu, 4 Jun 2026 10:09:05 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4242FACE-1A30-4EE9-8679-A0B6284BB0B9@linux.dev>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-4-songmuchun@bytedance.com>
 <a4tbwv0s.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 3, 2026, at 22:36, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> Muchun Song <songmuchun@bytedance.com> writes:
>=20
>> vmemmap_populate_compound_pages() uses addr_pfn to determine the PFN
>> offset within a compound page and to decide whether the current
>> vmemmap slot should be populated as a head page mapping or should =
reuse
>> a tail page mapping.
>>=20
>> However, addr_pfn is advanced manually in parallel with addr.  The =
loop
>> itself progresses in vmemmap address space, so each PAGE_SIZE step in
>> addr covers PAGE_SIZE / sizeof(struct page) struct page slots.  Since
>> addr_pfn is compared against nr_pages in data-PFN units, it should
>> advance by the same number of PFNs.  The existing manual increments =
do
>> not match that and therefore do not reliably track the PFN
>> corresponding to the current addr.
>>=20
>> As a result, pfn_offset can be computed from the wrong PFN and the =
code
>> can make the head/tail decision for the wrong compound-page position.
>>=20
>> Fix this by deriving addr_pfn directly from the current vmemmap =
address
>> instead of carrying it as loop state.
>>=20
>> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap =
optimization for radix")
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>=20
> Thanks for fixing it. I guess this was not caught because section size
> on powerpc is 16MB and with 64K pagesize we have 256 pfns to map. The
> vmemmap size required for this is 256*sizeof(struct page) =3D 16KB =
which
> is < 64K (pagesize). So basically we never loop in
> vmemmap_populate_compound_page(), because
> next =3D addr+PAGE_SIZE will be > end after the 1st iteration itself.
>=20
> But I agree this is a bug which needs fixing and it can be easily =
caught
> with 4K pagesize, where we have 4096 pfns to map within a 16MB =
section.
>=20
>=20
> The change looks good to me. Can we please add stable tag too?
> Cc: stable@kernel.org

Yes. I'll add it next version.

>=20
> Also, feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks.



