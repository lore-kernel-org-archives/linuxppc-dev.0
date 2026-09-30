Return-Path: <linuxppc-dev+bounces-28552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644C0CA5FBE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:10:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvrQT4KkBz2yqT;
	Wed, 30 Sep 2026 20:10:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::8d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790763025;
	cv=none; b=hyWzPCazQlTQk7Sl/FdEKV3Tee4w7XOXolteRY8tRYkzkUP9+lSEwoasSrlrdT7WodvUlvZNeoYQhxKusIvmfPBXlVEFtwlN2IbZYOQU6mO+jK2FpxDO1EzbWH87BzAwUoIDUdCC3UoEzvZvJhMA/eNumdRG5zczH0/+/+FgYKxLTRG+dqPca7DU+QB9KMpusxCwdyEfiBumG+3pOWbfLRrV3Y2o0reEsv1s1kLgVOYJyFkw0p332kdpYX2qHu20B8mstdwGMNVfRVDiSeoqlNPwHfIPvgVqPJV/vBvQFvFPNZU/8lUl9lt5cX2VZA6ZuQjAWo3rEKptrHNFLt8MJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790763025; c=relaxed/relaxed;
	bh=w8TdMHuVObPqzYZTfk2DxdvouGjhEk2R8v52SYa0+5A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PZHemPh3SwaOFQmb/qSCHU70kIxVUwkjnIA9CMWre5b0A4rZVJhedfGf+ATudWGb6zMPLGHHkDXB6isslU0HPg0lbxUTQdTBTN0KOWDnXOzwK3T6I6VuUmQY3R/W81Okbc4oVCEtDSR/Nmt1DEvLETOcI7Ce5NhMYc1wHridA1ACoRYbK5pnJfmROROI9rkfAXjPvlGtTFvSJQKUIeyiCyBkWRqlEvgVzMt8r3laO3RFStA0ZxqeyRrXGzL9F0ii914/RbnGs7hnkgZjIpSZQhNzOKe2Bryo8z89hH5uOtUCYdVNpQ8ziFDD83Xw6UoNMqNuNsS69pJt8ELHV/QKdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A+9Lx1hl; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::8d; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A+9Lx1hl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::8d; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-141.mta0.migadu.com [IPv6:2001:41d0:1004:224b::8d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvrQR3bVgz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 20:10:23 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=2chB+6TPhVuRnOZXELhxZytj9BOYBqeVPMdvplCJobM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790763003; v=1; x=1791367803;
 b=A+9Lx1hllhbzQT0VcT76xVSjE63/J/iCHuwgomiIP1JGBQNX+bpmZLL2rdN+38KNTMew03mM
 l8n0gaq+4699FSU5oBbhM3iQEkFbfdOye5D9JJ3wb0pPTLKQEvySj56HTgFuuX85wysCVmBbazy
 t+6HjsWq0gX/oLU7H1YGW9dQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id e1901c4a5a410c4d;
	Wed, 30 Sep 2026 10:10:01 +0000
X-Mizu-Trace-ID: e1901c4a5a410c4d
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
Subject: Re: [PATCH v3 2/6] mm/sparse-vmemmap: support device DAX in common
 vmemmap path
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260930085329.17337-1-lance.yang@linux.dev>
Date: Wed, 30 Sep 2026 18:09:41 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 maddy@linux.ibm.com,
 rppt@kernel.org,
 akpm@linux-foundation.org,
 david@kernel.org,
 mpe@ellerman.id.au,
 npiggin@gmail.com,
 chleroy@kernel.org,
 ritesh.list@gmail.com,
 sshegde@linux.ibm.com,
 ljs@kernel.org,
 liam@infradead.org,
 vbabka@kernel.org,
 surenb@google.com,
 mhocko@suse.com,
 qi.zheng@linux.dev,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev>
References: <20260929053231.66085-3-songmuchun@bytedance.com>
 <20260930085329.17337-1-lance.yang@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 30, 2026, at 16:53, Lance Yang <lance.yang@linux.dev> wrote:
>=20
>=20
> On Tue, Sep 29, 2026 at 01:32:27PM +0800, Muchun Song wrote:
>> The common vmemmap population path cannot yet handle optimized Device =
DAX
>> mappings on its own. It uses pfn_to_zone() to find the shared tail =
page,
>> but Device DAX populates its vmemmap at runtime before the =
ZONE_DEVICE span
>> is initialized.
>>=20
>> Teach the common path to use device_zone() for runtime optimized =
vmemmap
>> population while retaining pfn_to_zone() for early boot. This allows =
the
>> same path to support both early boot mappings and Device DAX.
>>=20
>> The backing PFN supplied by the Device DAX-specific population path =
is no
>> longer used, allowing the redundant lookup and population code to be
>> removed later.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> ---
>> v3:
>> - Collect Acked-by from Qi Zheng
>>=20
>> v2:
>> - Expand comments around slab initialization to explain zone lookup =
and
>> page refcounting (suggested by Qi Zheng)
>> ---
>> mm/sparse-vmemmap.c | 64 =
+++++++++++++++++++++++++--------------------
>> 1 file changed, 35 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 8219abc6c3e5..ee4c113ca938 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -237,18 +237,43 @@ static __meminit void =
*vmemmap_alloc_pte(unsigned long pfn, int node,
>> struct page *page;
>> const unsigned int order =3D pfn_to_section_compound_order(pfn);
>>=20
>> - /*
>> -  * Device DAX still relies on vmemmap_populate_compound_pages() for
>> -  * head/first-tail allocation and tail-page reuse.
>> -  */
>> if (!vmemmap_optimizable_pfn(pfn))
>> return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
>>=20
>> - zone =3D pfn_to_zone(pfn, node);
>> + /*
>> +  * Before slab is available, vmemmap optimization is used for early
>> +  * system RAM, whose zone can be determined from the PFN.
>> +  *
>> +  * Once slab is available, only ZONE_DEVICE memory reaches this
>> +  * optimized population path. Its zone span has not been =
initialized
>> +  * while its vmemmap is being populated, so pfn_to_zone() cannot be
>> +  * used. Obtain ZONE_DEVICE directly from the node instead.
>> +  */
>> + zone =3D slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, =
node);
>> page =3D vmemmap_shared_tail_page(order, zone);
>> if (!page)
>> return NULL;
>>=20
>> + /*
>> +  * During early vmemmap population, the shared tail vmemmap backing
>> +  * page is allocated from memblock before its struct page can =
safely
>> +  * participate in page refcounting. Therefore, no reference can be
>> +  * held for each shared PTE mapping, and the mappings must be =
unshared
>> +  * before the vmemmap is depopulated.
>> +  *
>> +  * Once slab is available, the shared backing page is allocated =
from
>> +  * the buddy allocator and can be refcounted. Hold one reference =
for
>> +  * each shared PTE mapping. The architecture vmemmap teardown drops
>> +  * the reference through __free_pages() when removing the mapping,
>> +  * preventing the backing page from being freed while it is shared.
>> +  *
>> +  * The backing page may be shared by enough PTE mappings to exhaust
>> +  * the positive range of its reference count. Stop populating the
>> +  * vmemmap if another reference cannot be acquired.
>> +  */
>> + if (slab_is_available() && !try_get_page(page))
>> + return NULL;
>=20
> BTW, shouldn't __add_pages() undo the earlier sections on a population
> failure? Say the first section is added successfully, but populating =
the
> next one fails, e.g. due to an allocation failure:
>=20
> void *memremap_pages(struct dev_pagemap *pgmap, int nid)
> {
> 	...
> 	const int nr_range =3D pgmap->nr_range;
> 	int error, i;
> 	...
> 	pgmap->nr_range =3D 0;
> 	error =3D 0;
> 	for (i =3D 0; i < nr_range; i++) {
> 		error =3D pagemap_range(pgmap, &params, i, nid);
> 		if (error)
> 			break;
> 		pgmap->nr_range++;
> 	}
>=20
> 	if (i < nr_range) {
> 		memunmap_pages(pgmap);
> 		pgmap->nr_range =3D nr_range;
> 		return ERR_PTR(error);
> 	}
> ...
> }
>=20
> We still need to undo the sections already added in the failed range,
> though ... memunmap_pages() won't touch those, since it only removes
> completed ranges.
>=20
> If the range starts at a section boundary, we'd hit -EEXIST in
> fill_subsection_map() on retry while those subsection bits are still =
set.
>=20
> The old DAX path had this issue too. Could we roll back [start_pfn, =
pfn)
> in __add_pages() as a separate fix? Something like this:
>=20
> ---8<---
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 796af1028ee2..16a0a2c885bc 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
> int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> struct mhp_params *params)
> {
> + 	const unsigned long start_pfn =3D pfn;
> 	const unsigned long end_pfn =3D pfn + nr_pages;
> 	unsigned long cur_nr_pages;
> 	int err;
> @@ -417,6 +418,10 @@ int __add_pages(int nid, unsigned long pfn, =
unsigned long nr_pages,
> 			break;
> 		cond_resched();
> }
> +
> + 	/* Roll back the sections added before the failure. */
> + 	if (err && pfn !=3D start_pfn)
> + 		__remove_pages(start_pfn, pfn - start_pfn, altmap, =
params->pgmap);
> 	vmemmap_populate_print_last();
> 	return err;
> }
> --
>=20
> Hope I haven't missed anything :)

Good catch. This is indeed a pre-existing issue, and the old DAX path =
was
affected as well.

Your proposed fix looks correct to me. I would slightly prefer keeping =
the
rollback close to the failure:

            err =3D sparse_add_section(nid, pfn, cur_nr_pages, altmap,
                                     params->pgmap);
            if (err) {
                    __remove_pages(start_pfn, pfn - start_pfn, altmap,
                                   params->pgmap);
                    break;
            }

If the first section fails, this simply calls __remove_pages() with an
empty range, which is a harmless no-op.

Would you mind sending this as a separate bug fix? I will ACK it.

Thanks,
Muchun


