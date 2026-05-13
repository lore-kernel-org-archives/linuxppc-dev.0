Return-Path: <linuxppc-dev+bounces-20896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CE3CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:21:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFvH262trz2xld;
	Wed, 13 May 2026 23:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778678462;
	cv=none; b=GvOTDSOF6hIlK+CuLNmh5o9pYVNeD+MN+5KHv6Ojrrdr0KaP7npXsn8usOl4Y7jfnbcyL0f9CSijIrHg2LD2LRI3+UyCeKB1japakKnVWMk0CnIrRa7o22lXZMLgDSE8hFjRARAaAX4r+DZm1Nv6OZYJCZP6/ASI9Vip9ToEq37diUpGXMlVe+8M3ZCoWt3z9bLUS5k7+mMiAeP28rD9Ez1w3J6Tnok2o9aYprw3jv/h/BLeRCHiJiR+nzeTa3tV9fWRyxrYfVDbKMqV5oEiiuFcqm3ep4tu103k0bePEHR8yznPBLAIePDSapb/r47ZuLz2eHammPD9yPO1/72dbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778678462; c=relaxed/relaxed;
	bh=8trDTW/nV8eHiIfDFU7p2YkBuzRrf5VwZ270y/B/pfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZu337J7QRsmUTtZBbr9BZk7u80B6y9BbumvDElRUPJMFP3mtHBYXtsZ+awEE+SySLjLciIJfntAlce6qnAwlS+XBzNg2ZNEBvAiHl5/YFCmqQ7d8o9JlxTWDbDs9X5+u40hZqTIXvNpJzT/0LAI4i5agmiIzQpEBtHlU11Oa0BPmWu8HS1036TcXPndQj4yWzKMKD+Wl11cR12kQdSnyxJtLFKc5+TDBdJkz+HvuraaioPuan4YD4h04mhhNNnJ279SEnfQr1MPI/RJ97Y2bYlegqzvF/f1BbC6Q1XofE+7guvfmw4DWZaFaMHTd8xqE47pWIHre3eQ34NGYOH6zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jKZoaK8E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=jKZoaK8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFvH06n9Wz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:21:00 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-366375c43c2so3969728a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778678458; x=1779283258; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8trDTW/nV8eHiIfDFU7p2YkBuzRrf5VwZ270y/B/pfU=;
        b=jKZoaK8EgYOkqMuSBqflWkTJ3StI2wXU0J07/OHdJykymRDLP0hbNMSM6NZithCkcn
         gW9X1vADfkvrCX7Ejxl/6SkvtAU543DEY3h2CH59CDuMrwOvhUZibXFgZAPDkcGuHvf5
         Wbvc68LoejfnYBFN33M54RRckHe5fPAYDO0Sc43496SClYHvoRYvd+gUgvKPyFZsuyZl
         wIrnbLSB5Tbca3JCDI3mDfhjNTJxHR5QvbGYfK9n/l47XczZHl4eeI+rXDE33jblCPTW
         eEJXXS1N/jC9lyM013UM3/wABNVGaom21Eag6bNXKHEo3kYtX8+etGN0tAySKbrwHk3p
         EPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678458; x=1779283258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8trDTW/nV8eHiIfDFU7p2YkBuzRrf5VwZ270y/B/pfU=;
        b=TKj8tOXGULD27NcUnh63a2xijUQ0GRw4099m6Or24kHtKDdKpt6Bp75BghWlK1MCsl
         rfkMLUVqDPOedj0SBp/yHciwqMvcrxHElCPEN4j8n9Bg8jt4v1deCUfWPKBl2XuN4sEa
         GYUS0Bnjg5/Vhe3zBrPLvmtBwt9xqJYOALamH/Fe4JiiMX5dQ+lqHxNWrIv9sSmYmPdL
         hOjHwoF24OsdMs0JFoafYLTCxEs7HjqGxtk97SV1sjzlscX1DpyfpRl9AY153TAbvLm7
         7mwkOjOTEzLeDpihkjuGrcNBZr5GJTGfl02+/u2z3Kz6dZVPldzcKqhVbKH8oDxJ62hL
         J+Dg==
X-Forwarded-Encrypted: i=1; AFNElJ97hYPUcIiCFyuweGwnpRLs9wzvbApYE0g7MRmRXs3ugt5HSaS+/5DmHGxuWWAZSHTZvmYJdEUuIBFQ7DM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNiwAbFvFzmXlhyKk5v+t5casgBUV3zA0vsKsrNXGRHhLg0HvK
	9QEKj3SRa5+aS5brnzuynqMP4et2+V2P/zs/uLSb6SpkhXKJw7alUdedDNp+uQ/f0lU=
X-Gm-Gg: Acq92OECOwSA62NyBPhfwiGeVlW7w6ZWeAglMHt2aYajOdSjLIguzTv2Hr9yWUGf1OG
	SxyIsbQPXZiiM6/NWPj756y8JlUS+aOzgO/GulXo4nyshMI+EulpNxQ4TOwNyVxB8vPnpWhRrLf
	MSaJUlvdbXxESdph6lZuhyzqtrwVmiMFLZcxVfslzUtMZW38jym+spKC+FSF6KMLpzitKzxoAUq
	hfQ5+e6l/W32oEms2cwZGyt2I2qoJnjndmutoVLLDl/0XxPl6o+uDmh3etPCbu826b7VCCJYMW+
	agof/22p/YF7tQNRpsACZgFHehQt8ASUW9R8V+oaDnJzLb602GQ7ta4EgCmqozbmnoZp7nraddV
	OeCImRFLekDS9Smle208DOKdirC/bmo65x6NOHL//UTAfCi2JEgBC6h63xO5unKZRBSHY8JR/on
	+/eDE+YC6j+6/bO+HPa1z4UPyW65lGYsy4EIrWnQ8pUUv9RVKMJsCymUIv9evk
X-Received: by 2002:a17:90b:380e:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-368f3e680d1mr3685120a91.14.1778678457609;
        Wed, 13 May 2026 06:20:57 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf7cbc2sm3098406a91.14.2026.05.13.06.20.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:20:56 -0700 (PDT)
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
Subject: [PATCH v2 47/69] powerpc/mm: Map shared vmemmap tail pages read-only
Date: Wed, 13 May 2026 21:20:12 +0800
Message-ID: <20260513132044.41690-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

Shared vmemmap tail pages can also be installed through the powerpc
radix vmemmap populate path.

Map reused tail pages with PAGE_KERNEL_RO so writes to shared tail
vmemmap entries fault immediately instead of silently corrupting shared
metadata.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 18b24bb891b7..4c3d027c823c 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1053,7 +1053,8 @@ static pte_t * __meminit radix__vmemmap_pte_populate(pmd_t *pmdp, unsigned long
 		}
 
 		VM_BUG_ON(!PAGE_ALIGNED(addr));
-		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
+		entry = pfn_pte(__pa(p) >> PAGE_SHIFT,
+				reuse ? PAGE_KERNEL_RO : PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 		asm volatile("ptesync": : :"memory");
 	}
-- 
2.54.0


