Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF86076349
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=xOVKebtb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKcmV2RcMz2yfS;
	Thu, 05 Nov 2026 07:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793824890;
	cv=none; b=GiQXGpTstzBI+CQ30X0Vtozna+t3ZpCbluCjmtW4quflhD1C/myTKhxWV9lSFsQf52lrsQU1AKBCQqEw9f2HKMuorb3GfBVXONNwbRSj8eIuF2NhTt6ndjz0nK1FHah2cvDApf5dAxIb1XWCetJpaHZcnCm8N7vi0HtYNfFNvxsc7vZ6PC60B4awzMTdJ7ramaykLOpL7HuTIovkdgMQhzKk+A3HjwfsjtEUSgAeWR+NQZbGGxXEmZva2RvkV3s3SGhHaCeiSD/v+4CcUmdwMfzYM8Dp3LdO0ybXzCbHxCaO3QJnYyIBeXv9KEhhK0CKfY2LUHzMhw6G3mmg+cIAew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793824890; c=relaxed/relaxed;
	bh=8NvaapzcaIzWq7uSJ2Dmb2kXv0T6bAtnj/aHzkzSaTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1P8l7x1YGjDG8pYvs00nX9cSIBDgVClZCjFHREFV+iSRktLSTs28y4ItKcLhFhbUG2jC2iApbIQPB6yUGFEFV0LXqdmVxNM4h1HsePRAkXt7VYR8vxJtsyl8kK8NFGDMMCxPj18CzeY/44Baw6C9RjOZ0Lg40jOXDtYkFc7aHOxmNwStaantZS63gsvVleZlwBnDPSDT0uH4iVOw/3kcbSKaSgXvRKjkzgQ+6kJTYYR6Pe33g1ZXJCAMZ7shunOQDqL2185plil12+4sm3GmF43Cvi7Pe9goArnhzAlgPf7TnsYr3kNx5OdBmqw33YRIIRKzZOUDS/WKEHGcONilw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=xOVKebtb; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=xOVKebtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKcmR5DQyz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 07:41:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=8NvaapzcaIzWq7uSJ2Dmb2kXv0T6bAtnj/aHzkzSaTg=; b=xOVKebtbd/EVZ7lZG6G
	8m0N9BIWb2IuyaQghh4TLmXRxLxz/MXauFib8S9ABq51e0GQptN8mnttoAgBsAvanC+trTeMr5nWY
	SfHMybSPUg2ATor/GYqmNcJc8xNHr+H2qciP20/61cF0efUIagIBsu1lmi1mfdX2jxFjX5Xgl4pUE
	K6T2MmUNy9fQXHtRdGWZ0vFv+aMeiYHJcDvBn6INkKKN7ITqsIeqIT1V8/sKCsC/RuaO5U1J1HcAd
	nKhzxOcXd9UNJkXg0zQcG5Hf5ADJ5bE6+Sm9Jw7nkiTM+jsE8fdduVPJk0tvHsoPivtBaSRKpe0l8
	yRhGpFonCnKyePA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xOhj9-0018X2-0G;
	Wed, 04 Nov 2026 21:41:03 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 04 Nov 2026 21:40:55 +0100
Subject: [PATCH v5 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-1-c56d0d26f970@virtuozzo.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=iPYZJpAFEq5ph4FddJEQxBtKa8SgnHL269s4IuW5Tpk=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq65hcBG32k9kB2WWl8wXCX995WkhP71w2AQSsM
 B5MJ9jheT6JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCauuYXAAKCRBRlgpH+WFc
 KjG3EACkdO7SpcAiJeF3qfGv/z8JO2DLU1rJOcZ6SnCgxtXjDTkNEPd3hDmxHcjtf9+GJyRpnND
 bd/KybasDP+Qa55evA+W5XG46E362tSI+80ly6JgX4ZJyi+1dVbAvi2L5v1vuG99SNqhC3HNfTj
 TeAtu64vAegOR5yW1V+mLBoGQbWXrBNEOv/W6fz3qAM5J6YZarwsmySzHjwZLZWVLRYvYrguMke
 Vy9sqAa1voB5JtAe12r1tqpSMoZAur9G55YIgiwjoxc/qKdBy8OENrQhd5mFh/Vi5PoDKwXrbEg
 v9OW/ZG0TnCRZKzCDWkfcOUx8XZ5hWNGi1ekVgS0EguNQ4HIzWlzshfRHnbRrT9DYcBg10zXcpQ
 dhXgOKvbDxkYzzxNMzt7bzqppgmnCsHzwc2O4X5kHtDtLVVY714S3Z6OWuGzLvyYR7Jl8weZlPu
 Har5Cb1McuXx8waVgTVEFo3TNc7ME9y0a6GmOw2iMw9Zox62sbKzRSbmVv7cJGypoQGwQmIoP81
 v9rOR/+btNakWwKECAHDi5apelwxkciYj/xLN8E1pgbBDrG4CXcr/euHuH5BShb3ssVDnnK14NO
 B3HEH6mQ8yzBLMc185k5pVVF4wN7d93B36XA38i0JzZ8QJmHCU4/9arvRr+cZHgRLdsp6l77GVr
 CTL7Lmh6wJ6XrnQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
__folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
PTE mappings to the folio instead of one PMD mapping.

The helper has no caller yet, the next patch adds the first one. Pass
PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.

Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
Cc: stable@vger.kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 include/linux/rmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 74cca0e3c7264..87c88a9811933 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -558,7 +558,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
 		struct page *page, struct vm_area_struct *dst_vma)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PMD);
 #else
 	WARN_ON_ONCE(true);
 #endif

-- 
2.43.0


