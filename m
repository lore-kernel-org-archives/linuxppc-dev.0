Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B3607084B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dexPQGju
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGKHn3mGPz30Vs;
	Fri, 30 Oct 2026 22:53:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793361221;
	cv=none; b=Qs8WWdUEbsNUkRya4jBZlKiITmKlrRGOayFrQLosP+goR1l4Mr2eoiE3XgyttogYE1G/gC+TPWFcwbnNznYgWor/XNYQbhMP2B7/NMzFMlnloS3v3Cn7CF9tQLK9dzsEQHJ6ANU2GkSVVcNPuqxnH+twJa/PvDlozTZXA9zajhB7OOQzWdq7Lhfln3aufvtd7h2BydEjWyH09P5zPKgO/Fi58uvMkzSJlvGV2kKkMUBZoP4RQ9Dx3oP9ETg6AwMQJ0mOC9jsCLD7x3zJUR3VRjLgv+ifXTKEp1ow9wf8RERqc7HHS4/EkQ8VwPG7kD3ympyvwLQ3BBpccITo6oJIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793361221; c=relaxed/relaxed;
	bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jwjn4l9vhhuQ81r1j5drvCRJHOc5rOeEXk+nBz9DqfOkbN53N5YXExvXMXSbWOVSNqlUeNP+N6H0AMmc1vMuhIVo/ez1u6FQVJrZf6hEpRlFIztE6fIHd6tuqC3Tql7u8LiFvzOB0gGjJR10pLEUYzz7GrUEiuY8z2yfHHMORLbtTUeiWBrSjxE/Tpo4+Csv2sSypA0gYlxnMsLOe3fdS/bvTmqwkoDaSd7Ypy/U3d7VyEZ/XuGpovaY3aJ8R6FFlT2iBIusmsODInRcW14LyvNpyfF56rKCzNVapaNUSigL/XkJh1NuUuS9efaKM4JaLXrD+49E71mZShG25v+rYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dexPQGju; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=dexPQGju;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGKHl2jdHz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 22:53:38 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso209431b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793361215; x=1793966015; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
        b=dexPQGjuK+gAPOVjZX6j1gZgnS4ThD/zzOhI5rnXeBSYAAHNrH60+vM+ZeTsHxHeHI
         1HjvQKSQboc00G3AM3a0SGHX7pr9uD2Lyr+hXOaPwtvUToLL4/HH5kLDWb1HrRIH4Jsy
         AxDU6WYHPZQVj/YRBMukxd8oc8YtVUyRAybpJ3ciy/JRqmJpTf+uRVVLf50lGGfOwI/F
         vKC0/tBkXS6SXBnYIa/A5G7rih4ZlZ+Y9nB2KcNOLrxiRJol9H0d+baeziXceGtjrkr2
         Lc7CMii+gbg1TadYab31aqqMmdaXulktc/6GFckk9MJ56PPRsaqxlgNWwbYQUFYBV7hd
         IQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361215; x=1793966015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ruvz+vAepzPKRTBn1LAj+/ZsyRqQngmycGqMeNBfwOQ=;
        b=CGBb9PvDHahLr7TI6OdnjjA1Z5WY924g6eSVWemRxkzLfVQVxzF5Sd2ULgKFFCFSYi
         OQIXejz7AFWPSHi6l9O3+NKCB0I2rsMGMTC3tLXDw46hyOQIJXqSmiTGTx3sGxJL4Ehe
         ZGUINqWnN84e8KfSSQ6d6/uNeAZ5yDvACOuNjvCKRUi06kbJ9jqcwK2mKNX6okjfRJXQ
         IGHNk1/OHHoqgHwQFgCL/+G+Tzhva3uIZ8nlviz4okFrqLnoTedwFOV1JLvSxNSllfGf
         Gmy8e+ZSY4afh5xNB+JkXpELfkNMYGtm/sVWIuJ+ZNtoMls4g+B3UqSWmJVx7bsDCnbM
         4vnA==
X-Forwarded-Encrypted: i=1; AKwUvByaV1Aw8tFpDn8z1rwZY4Yhv+5so7hVYtTDEPaeuYfjXRn9Zk4VuuTN7dlQBe6oMWTsPZ2TpwhpsSbQ0/M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLwNiUFMJXq2kzHy5ARt1G4/gGmrkWz3kKFnyVrcfwx2tKHz8br
	gfJ75YnzfZGAL1DLLeZtVV+r0vukiVEYdR+WPoPj78EBfhuYeEU1ZWiTE8LDWobzPhA=
X-Gm-Gg: AYBFou0Y4tcqBUrDjDKfy9QW1IC3fbZ5cIXGx3gJjzQz6oO8bgy116NRiv/N7EzDIle
	gro8VFi2UE+kb758wuXxMlgGda8jdua6SvvaQg97KM4w4yP1i4z0gH+10h2kx/WeaybASUd4Eje
	rvWbcnhIdbRy1mHaLKcqWAMCA0y/tXcI1NuhtsJgvBBECsANkswFzWisV7kyjDk+asBsmbfqWa8
	xrZOxQCUKPgWwsZK8IDPa5C5/cna8qN3T4u8ZKyVsaiYvOQc2sGE7UPIrxlEc0OA2VeL2xpq+ey
	SJYql01vC0cFQNh9tIhxCdvIc5/y04myboL0SEPAEQVtPPez80YUR40iC+cbsBCENKLFS/ETrTw
	bUvxCOCAVJiPea2D3kBPPiDJw7YwUlm2G0qc842QHdVnI++AT4ezK0w2hqFjxjdAGf/JjtQsZsp
	Utl0omiYr1w26msthdjzt8nwQNE3sBx+IKjHs+qwIn2dK6G6swAcRGqInv6R3IpyTgb3v0YZgzZ
	OZzVARoQaD7XQojxSMzjVKkQQAVN5iXkTxa8HM4+jqMzLd1lnwd0BfUMqW1FGYuZe2rBdCobBpS
	6agJkrjA3cCLWdsvFcJX9QgeUvbL022w39uaxZssAR67otK2qMs=
X-Received: by 2002:a05:6a00:3a21:b0:881:7ff5:606f with SMTP id d2e1a72fcca58-8a9bf71bbb0mr1772756b3a.43.1793361214559;
        Fri, 30 Oct 2026 04:53:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eff2684csm663223b3a.48.2026.10.30.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:33 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
Date: Fri, 30 Oct 2026 19:53:25 +0800
Message-ID: <20261030115326.1005755-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PowerPC radix vmemmap population can reuse an existing PMD mapping for
a device DAX range marked HVO-enabled. The reused mapping is ordinary:
its tail struct pages are not remapped to the shared tail page.

Leaving the section marked HVO-enabled makes memmap_init_zone_device()
treat the range as optimized and skip initializing real tail struct pages
that remain in use. This first triggers a zone mismatch warning, then
faults while initializing the pageblock flags:

  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
  Call Trace:
    memmap_init_zone_device+0x164/0x430
    memremap_pages+0x43c/0x93c
    devm_memremap_pages+0x3c/0xa4
    dev_dax_probe+0x264/0x3d0
    dax_bus_probe+0x140/0x1c8

  BUG: Kernel NULL pointer dereference on read at 0x00001400
    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
    memmap_init_zone_device+0x358/0x430

Without these diagnostics, the uninitialized metadata remains latent until
userspace accesses the device DAX range and triggers a later panic.

Mark the section non-HVO when reusing a PMD mapping so its state matches
the actual vmemmap layout and core ZONE_DEVICE code initializes all real
struct pages.

The Fixes target predates the section-based vmemmap optimization
infrastructure, so this patch cannot be applied directly to some older
kernels. Older kernels instead need to pass the vmemmap bounds to a
range-aware vmemmap_can_optimize() and reject optimization on PowerPC if
a PMD leaf overlaps the range. This reuses the existing mapping normally
and makes core ZONE_DEVICE code initialize all real tail entries.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: <stable@vger.kernel.org> # see patch description, needs a different fix for <= 7.3
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>
---
v2:
- Rewrite the commit message.
- Describe the range-aware vmemmap_can_optimize() fix for older kernels
- Note that kernels through v7.3 require a different stable fix
  (suggested by Ritesh Harjani)
- Collect Tested-by from Pavithra Prakash
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..4f75f10ed68f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
+			struct mem_section *ms = __pfn_to_section(addr_pfn);
+
+			/*
+			 * Existing PMD mappings can cover the edges of a valid
+			 * HVO populate range. They are ordinary vmemmap mappings,
+			 * so the current section must not be treated as HVO-backed
+			 * when its struct pages are initialized later.
+			 */
+			section_set_compound_order(ms, 0);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}

base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
-- 
2.54.0


