Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416F606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QmZfN2jP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG4cn1Q3jz30T8;
	Fri, 30 Oct 2026 13:22:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793326953;
	cv=none; b=XlPrIplHdbUqkPMWK4Ja575jJmHZEHUwcFkru5ImsPNdkXrmANS/C0aNWRim9RkQBpvJYeg8ArkERux+1B0ZLoaUpoDmVm4kiCZIuYxE3RA6SStCFk9bCRd3fz1+saWDWehncpjN4KgbhOVXp7HQgzsjXcAZCp7Ccwa4pnFObfo70Nar2cyVV+EiknYpMEqHEdAEWLSyd+oNHRJ7myopb8s+XnDf8YwAyNigV36fVRJauRxUT4Jlyxtkc/xGAbC6CVI1568ta5vZk+D2FhQSredilU8Gx6c62fEV7ge3alGMLtcC8XDxxrIi0Gz32TtINLfNd6MOfvI5EAXlbS7gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793326953; c=relaxed/relaxed;
	bh=GuCXOFg/eaPoMDDOQ3AZlcKE9moyp2CTPmKEIesl8bI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UHqMf7lclaTVGoVC4Ut2KLpxkhug28cWOIXt7Zq6+Tq9z4dN9+Dnq9wLRn+GaIqp9X/BYHbWqF65fh61QhVHFCwhGQmjhXeifv4kVJj+AfHE00GG0K5PnhyEM0boOZYBVznklhzgsYBbQ6vM+bFfc/rDy+0J/lZYa2z7rvtqK2VZ2fV7mEsTpJKgT7NFcRQ1ADPs7TXhPMwub6HYO8xKAEJNAgwzMu1xB2O27t1rCWpIyn/7zKPzLaroZURX1Et9Hg9M/O9OMXA7TyKEF4rMpVpYJJWHKu1zu6Y6lwTLEioGV8/NokhbK1SfAJOq3L+jpDkj9qL91gWENl697F6PdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QmZfN2jP; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::25; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QmZfN2jP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::25; helo=mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-37.mta0.migadu.com [IPv6:2001:41d0:1004:224b::25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG4cj3tCZz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 13:22:27 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=3W7i1+QOf/eQW3A33+hQoH7jzxTnHmjxgFZBOXgW78U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793326927; v=1; x=1793931727;
 b=QmZfN2jP4dUxZiSnaSdskWPARHinFT7ZQjige5i32RhnTdt4N/azDq2U0wo/Qo+edWEqH/dr
 wTcZ9xnxq0+TcBW1ZiGbvdN0hfQwM6QskzlG829WFPm+f6byXk7j16RBEoGB9JMu9iSQCdQdntl
 jbux+ZLv64nT6pKsqXoD95M4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id bb3320411df55916;
	Fri, 30 Oct 2026 02:22:07 +0000
X-Mizu-Trace-ID: bb3320411df55916
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCHv2] mm/huge_memory: set the mmu_gather page size in
 zap_huge_pud()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
Date: Fri, 30 Oct 2026 10:21:49 +0800
Cc: linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Pavithra <pavrampu@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4012569A-93C1-4662-B6A3-3521B97B8C57@linux.dev>
References: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On Oct 30, 2026, at 08:07, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Unmapping a device-dax mapping with 1G alignment on powerpc radix =
kernel
> built with CONFIG_DEBUG_VM triggers this warning on every munmap:
>=20
>    WARNING: mm/mmu_gather.c:176 at =
__tlb_remove_folio_pages_size+0x38/0x230
>    NIP [c00000000063d508] __tlb_remove_folio_pages_size+0x38/0x230
>    LR [c0000000006fb688] zap_huge_pud+0x1b8/0x2d0
>    Call Trace:
>     zap_huge_pud+0x170/0x2d0 (unreliable)
>     __zap_vma_range+0x1604/0x1e20
>     unmap_vmas+0xa0/0x1f0
>     unmap_region+0xb0/0x130
>     vms_complete_munmap_vmas+0x120/0x310
>     do_vmi_align_munmap+0x1ec/0x240
>     __vm_munmap+0x148/0x220
>     sys_munmap+0x28/0x40
>=20
> To trigger this - it is enough to mmap() /dev/dax0.0, touch the first
> byte so that the whole 1G is mapped by a single PUD and then munmap()
> it.
>=20
> PowerPC needs MMU_GATHER_PAGE_SIZE in which mmu_gather needs to record
> the page size for which tlb flush is needed. zap_huge_pmd(),
> zap_pte_range(), change_huge_pud() etc all do this already. However,
> since commit:
>  dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
>=20
> a device-dax PUD maps a real folio and zap_huge_pud() now hands it to
> tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE). At that point
> tlb->page_size is still whatever the previous user left behind, which =
is
> 0 for the fresh gather set up by munmap() and so the check fires.
>=20
> Fix this in the same way like how other similar paths do.
>=20
> Fixes: dbe54153296d0 ("mm/huge_memory: add vmf_insert_folio_pud()")
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


