Return-Path: <linuxppc-dev+bounces-28704-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F53CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 01:50:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwsDc4nB9z2yPG;
	Fri, 02 Oct 2026 11:50:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::93"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790905824;
	cv=none; b=FkDJ1Do1mNTEPFZ6sheJPsNi4J0nTB/MZZvkd1RasGs/8WnCfmVgpxi5zVlDt7M+ZXP3Z4ThfN0b3gf5KSIwvMcxbJLuDpuRct3p6EP7gsYZL77xnYgK3K9BSt2ljBHaj9aEnesE/mZNio7Q9GLyfQTt5jVfxbKWbIdGAxwvgjFD5YuiIHrVdC+IJPPr0wd/pWs2LvJm5mSmYY9XiU/1GMDfhORsKkIVCv6cb09ERJ+aWmV7yAMTXfLxv2T+6XVhFpA8WPXhaoVNjpc0X7GQ4lJyNzJ+PSlEdHlmA1gSopA+6JhtHJ9BLINZJ8DlTjZHIFbJOBGilEFekfuTCSTL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790905824; c=relaxed/relaxed;
	bh=MhZuf98Z81J4Mqd1VfwP+qbvPYzQzUUAYk4ntEuxCgA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BrKuhZDSpQfvhZD8HAsyfryHY14QZtvwxHxPis2cEy4iJb21GF6x2S01DtyBH0n563OevxLAVzpE8VfBsrxrUN+WUKO5bh40WwNxn8y8R9Kx4pgVygSesVErHbf/NRue4reC0k313/PiEvxjSqPDwv7sZbP17AjtkFRhhzQtMTMlZTQIiqhqscsS/C8KTanmIY9Z1neXAV8YJ2LYMUR+35Gnja9DjUd7xJEqzmq8tNEfnI1P/TDdgOIfFv+/etDOBWIGNcQbgM6pp2MgYSGeUaMsTdh4pwaffv0Ttd5bZ8KZKIyW+9RorwlD01A/+VMgNnhliR6JZHj7GxWkHxAI5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ohcTV+WL; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::93; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ohcTV+WL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::93; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-147.mta0.migadu.com [IPv6:2001:41d0:1004:224b::93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwsDX3fFSz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 11:50:18 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=O/F6AKy+1TPXxN7FZeSSixd6YDpdthmqRGsFYibhu3U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790905794; v=1; x=1791510594;
 b=ohcTV+WLBQIjClcA1S1hNHO1DQXU8X2joFAGsI1ThoyMAN+PVq5OqpomUoURl0QZZTMDOsg8
 rUTsUjr8j6+/QF/c69xneTs28BVt9aj99XKSrbX2cQn4X8gxKFZI157OdULq5kABQEEY5+ijQ1g
 unZwtNPkMlkqFp8pYbm9JY2o=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 7473f29920ffea9f;
	Fri, 02 Oct 2026 01:49:54 +0000
X-Mizu-Trace-ID: 7473f29920ffea9f
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page
 init
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ar5xbQsUpSQZg0wO@kernel.org>
Date: Fri, 2 Oct 2026 09:48:42 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <78D5D6AA-BE36-432C-B0F7-453F93DF18C0@linux.dev>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
 <20260929053231.66085-7-songmuchun@bytedance.com>
 <ar5xbQsUpSQZg0wO@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 1, 2026, at 22:42, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> Hi Muchun,

Hi,

>=20
> On Tue, Sep 29, 2026 at 01:32:31PM +0800, Muchun Song wrote:
>> For vmemmap-optimized sections, tail struct pages may be backed by
>> shared vmemmap pages. Those shared pages must carry the same page =
zone
>> ID as the struct pages initialized for the section.
>>=20
>> Warn in __init_single_page() if the shared tail page has a different
>> page_zone_id(), which would indicate inconsistent initialization.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> ---
>> v3:
>> - Collect Acked-by from Qi Zheng
>>=20
>> v2:
>> - New patch.
>> ---
>> mm/mm_init.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 1650d6bc1211..bd02e8d06965 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page =
*page, unsigned long pfn,
>> if (!is_highmem_idx(zone))
>> 	set_page_address(page, __va(pfn << PAGE_SHIFT));
>> #endif
>> + 	=
VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pf=
n)) &&
>> + 			page_zone_id(page + =
VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=3D
>> + 			page_zone_id(page));
>=20
> Hmm, page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES is initialized a tad =
later
> than page so it'll have stale data in the page->flags, won't it?

Lance is right. The shared tail struct pages are already initialized by
vmemmap_shared_tail_page() during vmemmap population, so they're not =
stale.
The head 64 struct pages are initialized later =E2=80=94 right here, =
after vmemmap
population.

Thanks,
Muchun

>=20
>> }
>>=20
>> #ifdef CONFIG_NUMA
>> --=20
>> 2.54.0
>>=20
>=20
> --=20
> Sincerely yours,
> Mike.



