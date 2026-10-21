Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D4606A319
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P1nAFsAZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8cVj4NVhz2xKx;
	Wed, 21 Oct 2026 15:58:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::88"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792558701;
	cv=none; b=JbP2qMtkSFNUDqZOi9dVzqZvY+ULdmS3s4ocjRxxm3ZfMc3ZHgIq4NbBV5W6ce0eKenx4bCenVHR+W5YkosgxU6gvApwtgnxWbiSfI713BSxObA1GuEtG++fFpe8UKo/H6WMEjrqY57mK/Y1v4+42BQdlS9R8XtA8I7t+KBqGaQznDAfpSD9QQV3E3ji3VbaUpMizWz9SvddOO+sNXBTg317dp0Lh9dbcQFheo/2cXLSuMlsfrX3Ad1S9KD5dtEHKf+J5oDHgiu5hb2YSg2MwXdxJbyV2gj5yT+qCmFqw+3l3KxymRBtnS0RxuNLcIcoJA3LmM6JQaIR5e0bF9IzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792558701; c=relaxed/relaxed;
	bh=zx+oBx+DrGbWNeI4VpjTvUMhvmqGs16Tkaf005DeV3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5QeR8Jvd7jElW6Q6ktC52QfqsYs4IPuIOOLU+pLoxgzesFWggCyLb+Ja/3YwIGKfg626S5wFGtzYiEEs8H9kzWDTPTdZ39g1KVsC4C1wgUE60bhyQLigzzqRFRz6zS/yBek1cEzKQHSZXiTqNy6nZNYbil515IqHweApSE71oVQ86ser+PJueQ6LlCvvw+/YTmke4wOxsvlZ2NvNNWkXnH2cU3X2LP06QeDs+acbbJ+zH0DgE2E2+uAiUILjwMU5t1YJtNjoxGycxbRPc85D8SOZGpaB03C7JdYSEKH5kFE9KGIAVQqNhAZZsDXeGdpEcKypahf+vVm8CsEXAAbtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P1nAFsAZ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::88; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P1nAFsAZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::88; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-136.mta0.migadu.com [IPv6:2001:41d0:1004:224b::88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8cVc66Rxz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 15:58:14 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=sjeGNUTRu2TxaiR+y3T0ejou+De0JFn1tmqrXPbKj/s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792558670; v=1; x=1793163470;
 b=P1nAFsAZzDdN1cB/IenFnLQPPipDFBuS9xym0lWq5mfYtRLAmQt3QeAFqd9UdI9Z5L9z2SEB
 NkcYKNd/A305qIJHE0prhUlfm8WKsSHDgxEauR4yWMbISsWDa+qtw2breNYExxYCEAtViGNp8eK
 VBrXq8Bz1w3n/fLR8eQeH2sQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 7971245a92a56791;
	Wed, 21 Oct 2026 04:57:50 +0000
X-Mizu-Trace-ID: 7971245a92a56791
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: songmuchun@bytedance.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de,
	maddy@linux.ibm.com,
	corbet@lwn.net,
	muchun.song@linux.dev,
	lance.yang@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	qi.zheng@linux.dev,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/sparse-vmemmap: map shared vmemmap tail pages as read-only
Date: Wed, 21 Oct 2026 12:57:44 +0800
Message-ID: <20261021045744.93554-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261019090830.1917657-2-songmuchun@bytedance.com>
References: <20261019090830.1917657-2-songmuchun@bytedance.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, Oct 19, 2026 at 05:08:27PM +0800, Muchun Song wrote:
>Both early HugeTLB HVO and device DAX use the common vmemmap population
>path for shared tail mappings. Map these pages read-only so that illegal
>writes fault instead of corrupting metadata shared by multiple tail
>pages.
>
>For early HugeTLB, this moves existing write protection into initial
>population without changing the final mapping. Device DAX gains the same
>protection.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>---
> Documentation/mm/vmemmap_dedup.rst | 3 +--
> mm/sparse-vmemmap.c                | 3 +++
> 2 files changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
>index 8c287ae3f86c..76f903975a40 100644
>--- a/Documentation/mm/vmemmap_dedup.rst
>+++ b/Documentation/mm/vmemmap_dedup.rst
>@@ -193,5 +193,4 @@ There's no remapping of vmemmap given that device-dax memory is not part of
> System RAM ranges initialized at boot. Thus the tail page deduplication
> happens at a later stage when we populate the sections.
> 
>-Deduplicated tail pages are not mapped read-only. The mapping layout is the same
>-as HugeTLB.
>+The mapping layout is the same as HugeTLB.
>diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>index 40eba70c0048..ba0496daf4de 100644
>--- a/mm/sparse-vmemmap.c
>+++ b/mm/sparse-vmemmap.c
>@@ -295,6 +295,9 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
> 			return NULL;
> 
> 		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
>+		/* Map the shared tail page as read-only to catch illegal writes. */
>+		if (vmemmap_optimizable_pfn(pfn))
>+			entry = pte_wrprotect(entry);

LLM pointed out that an AO MCE before bootmem gather could still reach
TestSetPageHWPoison() on a shared tail, since the head isn't marked
hugetlb yet.

Wouldn't that trigger an Oops ... Anyway, I wouldn't expect to hit that
during boot.

Reviewed-by: Lance Yang <lance.yang@linux.dev>

[...]

Cheers, Lance

