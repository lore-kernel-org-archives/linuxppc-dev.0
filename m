Return-Path: <linuxppc-dev+bounces-20909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F53CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:22:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvJZ5SSFz30DX;
	Wed, 13 May 2026 23:22:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678542;
	cv=none; b=kTiXjjyIuRodQuf+f39yGKgIdeC2jc9fUp+kWpKXm4yTfoMoCW66o4a+TOyBCr57LeHrEMJdXPkNjBq5z4x6oMlx0zp28nFbt5arXXcP8Z2DQLqfBo8+dFPCigyGHGJ2DGwViw6VexE/DidD7Dztf3qRBR8lo+G/oSNajgC9EYiXe7Qww/ZQbmWpAbgDexVz6br6W+aF7E+KOFxD+FD0g/uDatgfYf1/UlMS96bRDnuQUmJjfvb0ACcHDSFOqz/32AWwgoitefM/HeMTeIPZrOsrzWlrj2n0gKWjeEK8N5oAjXlwrifH97hDFhqfz0Ib/ZKd1KLwIQkVM8L/yq7l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678542; c=relaxed/relaxed;
	bh=CiUCqo7mN96xuEU3BEXI0sREbdNGZzXWZJQTkejfapo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2XXXiTyJpJSo+8mzP4QDkMGA5GsrguzXk45R2ddrzkxkZXSwUKeQOb3dvlpq2KRrQF+QaFnCA7e0Py+WtiXvryg9UUl6Jn+qrbGpa8HLsUxUJ5Hux/TwqqB1L7VQCn7ePxquaFRStCpjN0CTAgduiv1wXmkB71S/ixbMWRLULp43oArzJi5KfS4Fc/kEFT+3y0ymO1GoBkg7VOFiR/FZhUrlNLigf31UL66Q22xjAei9a9qhZopAVC/MvCRNCAkEkDT3BXi+tjJBv47WcpPyJ9HasmJMFKQD4KDAzecdk8tJlMuz7h0N5orHgZ+rsk+8DPt9b3y/o5NwwON8tRvoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lt+a5pMq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lt+a5pMq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvJZ0wPRz30DV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:22:22 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so2958675a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678540; x=1779283340; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiUCqo7mN96xuEU3BEXI0sREbdNGZzXWZJQTkejfapo=;
        b=lt+a5pMqUimAO45sd5U1AeGYdL43Qd67QDMDkVPY7VhA4TQ66+vRwdIy7U97t5/ZYZ
         rrHRVmqA5HSgrCTGpnZ7Z1HLBj7OEubcxEpGe7fwN0Pvx68kQJt/ZpLQCisjV3uQynoB
         4ge8VO+f/Gv/uUdQxCcPKGRbqO7aOxIuA6H2DIGwqeGDzIFmbohbbstUTnFXqh5B/yNS
         rFr/bIMaNAkeZ6f0bE3Gjfe0mkdLpbAOjo4LsoZiuGoFPVDFj5r4dwN9sOzAJ40Q8wxN
         yrTWAEu5ZsLirKIGq7BqD1sfYXNctEwtfNiGeAdtTAjyb3hjPLt4mN5ZHe5e1nHTRq/2
         O40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678540; x=1779283340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiUCqo7mN96xuEU3BEXI0sREbdNGZzXWZJQTkejfapo=;
        b=U8EHlNkVWCjfJs2hR+gPpx9gAWuL8i2angjVPTna+6exTQEh553CsxY9TI2DSXjoqy
         DHmiSGJdhBYPUph7ud1we7kUGA4+vkknzpzt8+J3a84opfTD6YVEFQJoEOOl6ODgc398
         FcbixnmleSVIyYBU0lYDOTsogJVO8EG17EHUWnaJvX+yqRUgYJj97TFQqUIIKLO5WnWA
         IqcvhQhrurQKYIwtWJ4mdqT4azV31LHxsCQx5U6vnJQfUTkGJqNdBstdPRGbCsZO7hbB
         nM21NKECOsM64at7zI0VlGqj4ZNgVJoRjCxxOO+Ej3kerCV8LQHOxs9CptnyJ0LFsrH0
         vagg==
X-Forwarded-Encrypted: i=1; AFNElJ/8n8q2Al9kPi99hV2LTtYithZWWcL68TisEMIy52doaZk4aCgBAMp6bAOEiOB2FwWlUdYWq+Mh366lx2k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxsznX0M4WPYYvqRm++aVIKjQFVTJ7ArUipeeBSFu4+bhUJT/6
	x/mQIG6LJXYnNaTobeYbyddvcfFOcNVVjVWYOZnNALoQtEE3t0zc3n4KMNK0heKloFA=
X-Gm-Gg: Acq92OGMcxFb0UGPKUtPgpZCPmvTsOo+zwX/1sKOHJzu9pro+Z3Hw7JAjcsinjCgStN
	wkbbwozDYUWm5uiLtD/g5iUWEj7PHf8ksMAsPAkNVhyYaq1tzM38Hgi3YNqCzcq/qTl0f+OIqjJ
	fu/MfzGLtTeeNNIGoU4SBM+9Pr3mdL6IXbH8C6m8guRlOKlKMQ4M9M5gaiwfkU6W3pFjJGkIons
	/uHI0IX2exrWjdQtutJbGExanbbN3azAxsGRclOiYvIGXpiu9QIA2UfOyNYYi6qCPDk7w5ItMp3
	Nn/w8pe1IYrzfwqq7YMNqpIhxCE6XIo756+USUTvnEfHGKo5s5M4KBXWI9EBOUCBDbVjdUfJ4Lk
	GTp6PdWDhFVxhJ0Ch86+2w49MCSnXdKE17SdFi3B3yq12WGi1pESVkSrwhbWNDFHU5j90qx11ML
	FhUxlOxzq/uQ6MuIMWRoohrc67TZRqF5Wh3ncxuwRtPm6cClNBzvZpwuafPRUo
X-Received: by 2002:a17:90b:4f92:b0:368:f179:ba07 with SMTP id 98e67ed59e1d1-368f3aa9f3cmr3656850a91.9.1778678540011;
        Wed, 13 May 2026 06:22:20 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.22.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:22:19 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Frank van der Linden <fvdl@google.com>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 60/69] mm/mm_init: Check zone consistency on optimized vmemmap sections
Date: Wed, 13 May 2026 21:20:25 +0800
Message-ID: <20260513132044.41690-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513132044.41690-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
 <20260513132044.41690-1-songmuchun@bytedance.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For vmemmap-optimized sections, the shared tail struct pages are reused
across compound pages and should already carry the expected zone and
node.

Warn in __init_single_page() if such a shared tail page is seen with a
different zone or node, which would indicate inconsistent initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mm_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4ea39392993b..95422e92ede8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -605,6 +605,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	VM_WARN_ON_ONCE(order_vmemmap_optimizable(pfn_to_section_order(pfn)) &&
+			page_zone_id(page + OPTIMIZED_FOLIO_VMEMMAP_NR_STRUCT_PAGES) !=
+			page_zone_id(page));
 }
 
 #ifdef CONFIG_NUMA
-- 
2.54.0


