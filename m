Return-Path: <linuxppc-dev+bounces-28467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1513BC9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvB5G3qyVz2yDD;
	Tue, 29 Sep 2026 18:23:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790670194;
	cv=none; b=gpfDkCfIrcSFTlVXD2GTIk0Yci2ZiEJZrQr5nczdmT/ORFnanGo7CrXeiXt79GqROO799JD+p86R4NH5Tlan+bAollb2EzxeNQEsschQAc9UIv6VedJMArT7U1/ZjGFDvCL3gnTNUjT8d8+QNscGfEKLlZZxNxiaTMz/XxerICRHJOEJr8oXn7eXtYqcN9wamBeG76TgB/TBvr1Ed4lOV10xNlZKdqPeVc0hn62Iujgk+UsprNHom3KF/X7UpSFYtrskpVvB1VyYPXRpT8SFXmCWuidwxZ2wtavgE7AREYa5kKy+RfbW9gv1WBG/c7fKTuK8G3XjBPk1/q4uL67vSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790670194; c=relaxed/relaxed;
	bh=3zBg+5VBkyp2Y1TWNPP7zQmgWetEBkn4yYW+Phr6HGI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H+em8yJY3mAR0lFwRZX9EY/avpxKlghP76SoQeJJP+CXt1NvEbecRcC3RK9LBxFTxNMu0KAWrj7nGWVtpnvb0ruKOAL2cFj1qvE9v1MfDcNyzuOAKADz3YSE3NopQUNiaMx9BHiaE5DCajS5MIVyFR1v8N6XnjPtIcJSDpySs0Rlbwe6OC3uF6SyBMR3NN/ONs0xScxmKlWOm0Q8zdTi5H2lZa9o97TOa0J0ljP9jG2Z3rIxnfi59gvXTu1hgTYC2gzDqBQiq/SfQOPMPVEYKy48+psYR1DuQGSlSkb2v2bYyaEfKIJoMiGwgaVjhM4XIA5W6/lUfa7F0UcNOuOrTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sz0RinNF; dkim-atps=neutral; spf=pass (client-ip=95.215.58.48; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sz0RinNF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.48; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvB5B6pTNz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:23:09 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=on/JchLIm7ReTjkHsHsqt/RBkZgWaTOn8Aj08/8SF5A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670170; v=1; x=1791274970;
 b=Sz0RinNFmiKdVAVddhMu3kIoX3ZxK28AKwddLyOdiX0cJJEgwsz5utrXn+KgFlmzUsIAn9fq
 U1KrdVB11KZb3o0NopaqAyq0Jhw0NupOCTn3A4ZP2TeSRUL66baUVhN4r8YkD0kk0egDPyTPW1B
 4sX9wI16Le8m2jpiqJti63M8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 94a06a54ff95dd08;
	Tue, 29 Sep 2026 08:22:50 +0000
X-Mizu-Trace-ID: 94a06a54ff95dd08
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
Subject: Re: [PATCH v5 06/12] mm/sparse-vmemmap: set compound page order for
 device DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <751f6586-625b-4485-9f27-409fdf38bf3e@kernel.org>
Date: Tue, 29 Sep 2026 16:22:29 +0800
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
Message-Id: <A77F22EE-0C10-483E-83D6-CC88D8485E88@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-7-songmuchun@bytedance.com>
 <751f6586-625b-4485-9f27-409fdf38bf3e@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 15:30, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/27/26 04:54, Muchun Song wrote:
>> Device DAX can use vmemmap optimization only when a full section is
>> populated with a compound-page geometry. Record that geometry as the
>> compound page order in section metadata before populating the =
section, so
>> later vmemmap accounting and population decisions can use the section =
state
>> directly.
>>=20
>> Clear the compound page order when the section becomes empty again. =
Also
>> reject partial additions to a section that already has optimized =
vmemmap
>> mappings. compound_nr_pages() determines how many struct pages to
>> initialize with a section as the smallest granularity. A section =
therefore
>> cannot safely mix optimized and ordinary vmemmap layouts.
>>=20
>> Partial additions continue to use ordinary vmemmap population, so =
they do
>> not save vmemmap memory. Such additions are uncommon, and the lost =
saving
>> is negligible.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Qi Zheng <qi.zheng@linux.dev>
>> ---
>> v3:
>> - Update the subject and commit message to use compound page order
>>  terminology
>> - Use EOPNOTSUPP instead of ENOTSUPP
>>=20
>> v2:
>> - Explain why optimized and ordinary layouts cannot share a section
>>  (suggested by Qi Zheng)
>> - Collect Acked-by from Qi Zheng
>> ---
>=20
> [...]>
>> static struct page * __meminit section_activate(int nid, unsigned =
long pfn,
>> @@ -838,8 +840,13 @@ static struct page * __meminit =
section_activate(int nid, unsigned long pfn,
>> 	struct mem_section *ms =3D __pfn_to_section(pfn);
>> 	struct mem_section_usage *usage =3D NULL;
>> 	struct page *memmap;
>> + 	unsigned int order;
>> 	int rc;
>>=20
>> + 	order =3D vmemmap_can_optimize(altmap, pgmap) ? =
pgmap->vmemmap_shift : 0;
>> + 	if (nr_pages < PAGES_PER_SECTION && section_compound_order(ms))
>> + 		return ERR_PTR(-EOPNOTSUPP);
>=20
> Hm. Why should we support optimizing the vmemmap in case we fall into =
the same
> memory section as boot memory?
>=20
> In that case, there already is a memmap allocated during boot for the =
entire
> section. IOW, we really shouldn't mess with the vmemmap in case we =
have an early
> section.
>=20
> But maybe I am missing something and this is already disallowed?

Yes, this is already handled.

For a partial addition to a normal early section, after updating the
subsection map we return the existing boot-time memmap here:

	if (nr_pages < PAGES_PER_SECTION && early_section(ms))
		return pfn_to_page(pfn);

Therefore, neither section_set_compound_order_range() nor
populate_section_memmap() is called. The fully populated boot memmap is
simply reused, and no vmemmap optimization is attempted.

The check above handles the other case: if the section already has an
optimized vmemmap layout, as indicated by section_compound_order(ms),
a partial addition is rejected because we cannot mix optimized and
ordinary vmemmap layouts within one section. This also covers an early
section whose vmemmap was already optimized during boot.

Thanks,
Muchun


>=20
> --=20
> Cheers,
>=20
> David



