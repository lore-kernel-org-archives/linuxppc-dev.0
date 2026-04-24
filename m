Return-Path: <linuxppc-dev+bounces-20033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B147EF589DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 02:56:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1yKG52FFz2xGF;
	Fri, 24 Apr 2026 12:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776999394;
	cv=none; b=CftczBrR74Hwg+yUp5g6aXJtZQqPTz1ZWHkrTbuQaSNt+yhZLrrzqCsO3XmUUIbPKHUTPEzTghXs/uXGBrVzDNZWzBnMwZJDcPrjdSgAOqIzubRGYzrUAXI9XuL5Q5a+mFM3Y15RrYOE8AuHB7sSebvozJV3czAxJzK2G9gsJW+nm/cYTDufJP7BoAslzua0vuOGNAHl1VpAtnixJUcx6SRnDIK+ehQeFdiv2zp2RXbK0D43iv2U6Mn2GDFWkew1lcpizaXSBSh1Z9PtVAw4x6ZB8hDR6Eegj4n5rtfjbPHBxGQ0Uwm4wEyJjRijhwzTotc+TYvPIGQKDc9fx6cTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776999394; c=relaxed/relaxed;
	bh=ETx/tSKnTC+n/nV2wgCSbp2pIhIkVNUTkv0q633meJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FK1xhJY8JoSw7rThYlieBcXmKbMVIy01cFlqOFrArorCDgNWG1Gj8y7Jacy8wgwSpfDWjPg2TswsIrvrc+XwjjYAiwQeg7rQ5D3VoWbMY6lK9QqGT/Cnkq//uwPgAuiY///pI30Ho7AAMAXaJJh43fmYAnOw21wV0wgDhejIkyr4FL1Rcx5ujG341AfSUIGKYkFqDoQVez1/I8TdAWnSMeVVj+NpDInCKfXmS0y8ZJjPo0BpdV9NgKP+uasmWVlwkWcrNEnie+nd0SarxO150iv028/EpuayqRz56SGCcztYYUT7xeLs1chWFcU++fPrQp65+qoolIua/uP0LlRgzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U0ge4YEf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=U0ge4YEf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1yKG0Q2yz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 12:56:33 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso34588325ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999392; x=1777604192; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETx/tSKnTC+n/nV2wgCSbp2pIhIkVNUTkv0q633meJ0=;
        b=U0ge4YEf6bGOF3Xljvak8zdXqTlWJqNNcqJmcKa5Rw7KSVDEx/rsrIQIhXHJHumt4U
         RwljA1EeaNn6Is5nVadYY3KDlger15pIVTNdNpL+K6UCYu830W5/wHB2kSRdsAZGREp2
         8EiLsfAfEZ+Gjw03TpBS624+cKaCy/fKgrk1z9U2xawAmCFjjrXWghtoCqi6TeRVwECs
         Xgv9vLjoHfWZTQmuXeIZpNDCEjAhGWDEQ6ltprYWP6FcyTuzWywgArGaT/S1akJR9zLN
         CeBEJZYodAZKTRwkgkE3w2UYmYfay7Uv1zWCoquCIRvoYAYXa4f5bII787KTZ+nhfe0j
         gNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999392; x=1777604192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETx/tSKnTC+n/nV2wgCSbp2pIhIkVNUTkv0q633meJ0=;
        b=CJJQMdD4wTiMaNSyFtVnwVeYZcmkQoqxMvXeZ7KdIVF7J2jmvDJIeWqH9+6rKSjScG
         1PP/cHa+uS9h7iF2QDb7ZRb/5hB27liGJEtRdluTbkNIdx66SSov0u6uhv0q14YF/Fkr
         DXc/rUswqU6Ao4eECIxZ9JdAfsS1vO7L5AYozqy/N/3o2cBtvNs68IpRQ12/kImXNl+F
         a0o9VegxWiSjwQnKz5dGcwgv+r+q46JnhXA2dTIHiX3d9Sjo8/T0LF59dhe8IBOAEMg4
         Z+aYCUGt+JQdcF5U69sOwiFFXPrFF9KBG0DZOJnGo8sI3S/qc726MzMeb7u7HON6ysG5
         1Fjg==
X-Forwarded-Encrypted: i=1; AFNElJ/v8auEGESWXmwvGnR+KiodBPOuAKDOefah3NzdwkR0qH7s4/eZfC/+csal0/U4b6uRVBrdLog7PoOYHTE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMSQ/OEYGYci018+HgCTfZvhbcL/ckAhcX/FNZaEYErBIZmiFu
	/s5/CqvPT5DtcaWRjp43qvyQkRK5KbQTUi7+13sCzzsJAzJxdiEdCQzGk6T/PlR0UJo=
X-Gm-Gg: AeBDieuHB/yp81ea04xOuvD2vBOXLoH9Cq27TVBaVlhl+7P1l7GtWXMqRPvo7L9Hh6h
	aoF5lvHKjeFB5hjgYfocTnXEIL4gxJ6MYC6Gh3BxCRGiaf3VmdvL2RULVSWefqQbnhaf1I0NtAd
	qAA7he/tE5Or00K1JDd5m62KTb5+WTcY5k9lbXqyqGHHOc2FVevOcol/OGIEpGIWX0kUNcaFTdM
	ypbgWhOBYZAOODZALz+Vob3SWTO7qzJLWL0u5bFRYv1MKw7AGupg64U11eZ8JSl0f94LlNZ7NEo
	xiEUa5qAl7LFoQyH4iiRQLWnJgFTcUmBiRvfiLRcWNV3U1WX5KS8Px8Ain1SMImKJOro45yes7g
	vK0OEVdD5/gU1gUO1bkNgqspvh4YHg6mj7apsbwh3g8aqHIf7wKU9ug0D8snMPvYxNI8Tw9OYeP
	zfU3tPkzvvkFr7F0hJVMEnzLHEIrtcRUrE9lIS5J6ypd4A3I8Tok3eJ0F9QGvnlQdmWQ==
X-Received: by 2002:a17:902:6bc2:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b5f9eaf6a6mr216777385ad.17.1776999392104;
        Thu, 23 Apr 2026 19:56:32 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:31 -0700 (PDT)
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
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 7/7] mm/memory_hotplug: Factor out altmap freeing checks
Date: Fri, 24 Apr 2026 10:55:47 +0800
Message-Id: <20260424025547.3806072-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
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

Use a small helper to centralize altmap freeing after verifying that all
vmemmap pages were released. This keeps the check consistent between the
normal teardown path and the memory hotplug error paths.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7bfdc3a99688..ee150d312bd9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1403,6 +1403,12 @@ bool mhp_supports_memmap_on_memory(void)
 }
 EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
 
+static void altmap_free(struct vmem_altmap *altmap)
+{
+	WARN_ONCE(altmap->alloc, "Altmap not fully unmapped");
+	kfree(altmap);
+}
+
 static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 {
 	unsigned long memblock_size = memory_block_size_bytes();
@@ -1425,12 +1431,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 		mem->altmap = NULL;
 
 		remove_memory_block_devices(cur_start, memblock_size);
-
 		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
-
-		/* Verify that all vmemmap pages have actually been freed. */
-		WARN(altmap->alloc, "Altmap not fully unmapped");
-		kfree(altmap);
+		altmap_free(altmap);
 	}
 }
 
@@ -1461,7 +1463,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		/* call arch's memory hotadd */
 		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
 		if (ret < 0) {
-			kfree(params.altmap);
+			altmap_free(params.altmap);
 			goto out;
 		}
 
@@ -1470,7 +1472,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 						  params.altmap, group);
 		if (ret) {
 			arch_remove_memory(cur_start, memblock_size, params.altmap, NULL);
-			kfree(params.altmap);
+			altmap_free(params.altmap);
 			goto out;
 		}
 	}
-- 
2.20.1


