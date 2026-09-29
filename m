Return-Path: <linuxppc-dev+bounces-28470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A74CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:36:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBP270S6z2yvy;
	Tue, 29 Sep 2026 18:36:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671014;
	cv=none; b=k+gbwqv2ebigKTcT86UBp3pzjGLZzTRUklEzj2Ey7jg5YxXOJ+WaEWDb6sHQuIxL6s/NIwHzfOjOd+ZcwHKZkn9Ai2WS21xrACIgE+eg9cPS6fmVI9nWEY1WM+dRGd96d1dcaJjKPnp/OypKS4ERH+CLiHNw7pk65gzBYocTXL6B/zK0QfcriNen5gbje++D9sYa5olHzoZkv5BiBzXMCTz4gI76q3cHK/FtelKqx7gyEBE9vCDQ00iBEQXD/J5JqRhnPZKbba6tlYhw1aWuPiO8cLEHnk6XKlQLoz9PRt/pXYIrfsAvfUFe9DZ2A0Uws1Hj8VfcbpnQ44Z7jJ56DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671014; c=relaxed/relaxed;
	bh=7gl7Dbkf6zYEyNTSd0tfJx7Wb2qDhRetsdKvP0HB4MA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ggtN2m1M2DVR1WBH1VGRqGtKQly4Zg01Rbv/omw24zY9TcvvDynbPFyH5tvVNlf0hA8PGSEnCHjUfME8lphQoIZIgCiQnDmCjaRDZGftr1X/LZztJYLsYQFEd2e4iRPq3xqlXlB1K3nSmNUjJ/I2to7rlG/dUYD1j1pRaDp+yrmEdOAXL3nglWhQ12MrGMleXqfn09gHwz3PbDslRde3xammZ/0fkHJ+W3rORy2twWDzAET0eFj6FZUJX5L+dzDs3/BYMQJV7DkBCBzvft0iuuQfdH3rka7aK0T6Wuzk0yXvdDwmRupLS4BRWbCLimEsgpd5LzjL9QtI6+oTNiOCZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WMXbedJM; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b7; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WMXbedJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b7; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBNz36Dsz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:36:49 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=8vfz9yom+ls/aQov6CVfDaBZr7Ko9IZV3QMRLqEpVmM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670991; v=1; x=1791275791;
 b=WMXbedJMmbqaftd1IpCIhlKKzGIzCRayG9NJsx7HkivNiVYX7SV3JIweXkHE+jmSxSGZGFY8
 cOpVlP8jKib3bYDO45TF0mzuc9vNN19kzoQfIv0Dl7DmxdKGdmnTYmyYPURpDDWxQSCsyxwG715
 JozrFQ1Ypj7BSyJi0O8Z7r2w=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 7b4496e5929f9e79;
	Tue, 29 Sep 2026 08:36:29 +0000
X-Mizu-Trace-ID: 7b4496e5929f9e79
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
Subject: Re: [PATCH v5 07/12] mm/sparse-vmemmap: switch device DAX to shared
 tail vmemmap pages
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1b542015-8e5a-41af-9e98-9810333e6725@kernel.org>
Date: Tue, 29 Sep 2026 16:36:07 +0800
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
Message-Id: <53A73178-93E5-414D-8ECE-96B3082384C4@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-8-songmuchun@bytedance.com>
 <1b542015-8e5a-41af-9e98-9810333e6725@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 15:36, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/27/26 04:54, Muchun Song wrote:
>> HugeTLB vmemmap optimization now uses per-zone shared tail vmemmap =
pages.
>> Device DAX has not been switched to that mechanism yet.
>>=20
>> Switch device DAX to vmemmap_shared_tail_page() as well. This aligns =
DAX
>> with HugeTLB by using the common per-zone shared tail vmemmap page.
>>=20
>> The optimization is enabled only for DEV-DAX through =
pgmap->vmemmap_shift,
>> which supplies the compound page order recorded in section metadata =
before
>> vmemmap population. Unlike FS-DAX, DEV-DAX does not modify tail =
struct
>> pages, so sharing them is safe.
>>=20
>> Since the shared tail page can now back ZONE_DEVICE vmemmap mappings,
>> initialize its entries with PG_reserved for device zones. Also skip
>> poisoning vmemmap-optimizable sections while their struct pages may =
be
>> shared.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> ---
>> v3:
>> - Move device_zone() after the definition of NODE_DATA() to fix
>>  non-NUMA builds.
>> - Update the commit message to describe the compound page order =
stored
>>  in section metadata
>> - Collect Acked-by from Qi Zheng
>>=20
>> v2:
>> - Explain why sharing tail vmemmap pages is safe for DEV-DAX
>>  (suggested by Qi Zheng)
>> ---
>=20
> [...]
>=20
>> -
>> static int __meminit vmemmap_populate_compound_pages(unsigned long =
start_pfn,
>>      unsigned long start,
>>      unsigned long end, int node,
>> @@ -551,21 +536,18 @@ static int __meminit =
vmemmap_populate_compound_pages(unsigned long start_pfn,
>> pte_t *pte;
>> int rc;
>> 	unsigned long flags =3D VMEMMAP_POPULATE_DAX;
>> + 	struct page *page;
>> + 	unsigned int order =3D pfn_to_section_compound_order(start_pfn);
>=20
> const and all the way to the top.

OK.

>=20
>=20
> I did wonder about the poisoning change ... because the memmap usually =
gets
> initialized once the memory section gets moved to a zone.
>=20
> SO now I'm a bit confused about the ordering of events :)

Yes, the normal memmap entries are initialized later when the range is
moved into the zone. The shared tail entries are the exception, though.

The ordering for device DAX is:

1. sparse_add_section() sets the section compound order and populates
   the vmemmap.
2. During vmemmap population, optimizable tail entries are mapped to
   the per-zone shared tail page, which is initialized by
   vmemmap_shared_tail_page().
3. page_init_poison() is reached after that population.
4. Later, move_pfn_range_to_zone() calls memmap_init_range(), but the
   latter deliberately skips vmemmap_optimizable_pfn() because those
   entries have already been initialized.

Therefore, an unconditional poison here would overwrite the initialized
shared tail page, and the later zone initialization would not restore =
it.
The non-shared entries are still initialized later as usual.

I agree that this ordering is not obvious. I will update the comment to
make it clearer, for example:

  /*
   * Poison uninitialized struct pages to catch invalid flag =
combinations.
   *
   * Tail struct pages in a vmemmap-optimized section are initialized =
and
   * shared during vmemmap population, so they must not be overwritten =
here.
   */

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David



