Return-Path: <linuxppc-dev+bounces-28445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DB4CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:34:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv6L21zs0z30dn;
	Tue, 29 Sep 2026 15:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790660042;
	cv=none; b=mjV7QZJaqQUET9DkTXqrZviMrJja0g7PBJYXv/L2zo+eKH6j7OapMFbLiVC018MSt4tK6zSOUWu7QGV+BcRxc43OboWacs8SYCIkwAPwvtgEng5uN4BR2HHwLXgsSPYgCwi+gkUgEMHdtH+JIqBjij/KVPhMjQcfFieNx02Kp/NjHqo3B8/x8NlSck65iYDjDnjKb202ChD3ZF7dxjxSNqDlowCrs6lkaV1K9t0biLcBjEIu06oPUmwp1FRpI7Nz1ebin9Auw3Iq+CUtIv2tHi7e1TcO3NZoyJ9r4OHShGoAfPT7iwBPgFVIDHR1Yf2hZTWgvNtvK6+LsiORLOqFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790660042; c=relaxed/relaxed;
	bh=aIKIMkYuFOTq61i+iCqWLdJrE5c2b5L+SL6VyhrzHK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPyNcFIGz4Fenqi0gyvgg9m+o2RyLPcp9SFIrmXJjj7sdCuz+GWlx+ic7PZj/1mNB+9yuGQLdLXlsBBoEna1TOKjrxvTevlT4Qp7gQNLSTYg0+Q3/iPoUOMGQrfHljqD2D5VNR4376Hcw9aDtMIVMdGqnb+9DQZXklLI6lAl2Pwgi0bo62nG1hZv+EEawSKt74MRLQ6fRZX9YJ4ZXx4ZqjJMz93FNDXiGZyba0J0vhrPVyIMezqqlOUed1/szP5EZGw7qqWuFqWjYqsuqTmyubEyVpfR1dpFn6HvQXXP/6kqCHGAXsrilfWVGHLlYmDINhcp25QLS5ywGpBvXeAviw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aCrV4Qb9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=aCrV4Qb9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv6L1102Gz30dj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 15:34:01 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d747ec6188so17567355ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790660039; x=1791264839; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIKIMkYuFOTq61i+iCqWLdJrE5c2b5L+SL6VyhrzHK0=;
        b=aCrV4Qb9rTBF87mmkKTe0481JmxGjAV+aMEUTol0KRIYBEu+A8sr+utwhB12vc7nC0
         F6tOZIiWf9rshBNG76Py4DaicongQy9eITnKxFvb3ySxao4bsjljH0rTzQoBn6U4fXfd
         MigB6WnbgA4jLpxZ9jQUQoNxUoMFF0nopPn5MmigeCmuo7ye5v0iPhn7FEY9IFiSuOOF
         jmg5mm6xg/qinuIRoA+6z8Qb7WRPYeCsr+qBAqPFyrHwHOqj90brmkkZuw9+5L0KUTuE
         vuyQ/sl1124rIdRxd1rgEqw1lmhCDlW8loXkm1bclS3WHCPr+FeAOWMq3glRDODyQQ8k
         7e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660039; x=1791264839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIKIMkYuFOTq61i+iCqWLdJrE5c2b5L+SL6VyhrzHK0=;
        b=t7nsGeuS1fkxpldpPmO0autT6s8yDlkudgPab9WiqzZs3ZCNdTZNmJUs12X3IItH8X
         Z/xuk9iYIXM9lAoyEIsupcb4n0xh6xR4pSg+gVONYL2hjXMRi+yP45bT7726ucgffqYQ
         hA/9BZhqZq4neIcTs+qVGDcUpieq3VUqZPINy9Hj/btBhhVgzksOXFe/u/SMXs2ZAf6e
         XXzAAlkw4mXYBQr4iq8HiysXWDN+tTR/O3jyEnJJTYkry14D6EUhizP1HwSferMthza8
         bp05FFt+fYClxKLy/bmLOa7ye9GEwvVgcYCgygcsZU/01HV2789TazMteC7Wsa8Dmoff
         BVjg==
X-Forwarded-Encrypted: i=1; AKwUvBy9FXveyPOBL6jO8phH8bOCPp0iybuyPnor2qO4/4nJi2G23lbfd85IhZ0crkvmH/CNXHF+R8+jLAYeFHQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYID05bOmFG63J+1x9ZkY5iGAXcIn6+L7Mp3u7xAwxoMcEUmgWBq
	ejUVzjHGrZG1SLLbe1o/uloI6TMb3ADTKCQwLKOn6OQra6Pfoagk4iH2PNcfACVf69A=
X-Gm-Gg: AYBFou0porWT5rkXQlFvAMnFCU9UaQ8J+SPYHGpWgrMtcpQS/F9fIwgNsKoXV8U6TlC
	7DzC2qqwKY9Javmf5nrJ1D6RB1pXFaYvev/3Hcal9cqE9faADdGUi+ENKYFVrYXYIWbAon47jMv
	4uaaqQVV28BslNwdNtlJ74oFVINkCti0Unmirz8TPMyWsbD1cUTAfsOpHkVtlff2NzQP1yJ7q9A
	grBTPwMj5ZIVBz8BKZQxpA/esQNu8G6JhnqIWNflWVRVM+bnNQ/6SiATflCnJRuv+p7cVLtPq9d
	jTkxBOfPW4zeHJElII6kkgxjnPdZl9/EC1WQ60VrBS2xSMIZniFl6AT/drOWSFcvfb7/9122lRg
	olO/w8FHnVoVu9EMoEf/DKr+ECq3W0Y4821F4KabIH+c1Rg+jKa58sDcBP9sW/XmgNZ/Cmd/A6I
	tD6PmMd0kv5PZ+pQWt9APRBCXKzdh2hNBnKVqYKE1S+oCcGWnMyJklAKQ2FzdaBoh8lJpbNM3sF
	9LCaiOcI9tTa9vDw3kVo7UMfgOMQQ==
X-Received: by 2002:a17:902:f710:b0:2dd:3ddf:b87a with SMTP id d9443c01a7336-2e2c937e018mr7110035ad.0.1790660039331;
        Mon, 28 Sep 2026 22:33:59 -0700 (PDT)
Received: from G6L4RL2QG9 ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm49251765ad.51.2026.09.28.22.33.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 22:33:58 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH v3 6/6] mm/mm_init: add zone mismatch warning during page init
Date: Tue, 29 Sep 2026 13:32:31 +0800
Message-ID: <20260929053231.66085-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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

For vmemmap-optimized sections, tail struct pages may be backed by
shared vmemmap pages. Those shared pages must carry the same page zone
ID as the struct pages initialized for the section.

Warn in __init_single_page() if the shared tail page has a different
page_zone_id(), which would indicate inconsistent initialization.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng

v2:
- New patch.
---
 mm/mm_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 1650d6bc1211..bd02e8d06965 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -609,6 +609,9 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	VM_WARN_ON_ONCE(vmemmap_optimizable_order(pfn_to_section_compound_order(pfn)) &&
+			page_zone_id(page + VMEMMAP_OPTIMIZATION_NR_STRUCT_PAGES) !=
+			page_zone_id(page));
 }
 
 #ifdef CONFIG_NUMA
-- 
2.54.0


