Return-Path: <linuxppc-dev+bounces-28580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B981CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:08:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvz232D7nz2y2J;
	Thu, 01 Oct 2026 01:08:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790780891;
	cv=none; b=I7Sb7z3mKnc0dYFcmfRUeWiY/ODWAV8HR9dC6FR1CH8QOHMRMnVrdu0xMkbsgzFw+S/0yGeIlDUAkohMhEwoIgKT1WEiqoKPVCoDMtgtb5R1jiTkigRmaBGKPdLNs4E+gfErrSRe5djD8z2abONsBe+4AmZ+Y17o2i1+eCs+vzbM1mLiOJhKcs+dPQ6k4RRRGMpGNbYtyCdmMdkn5T5nh7rnzvoPoQ4u7K2FjwK5fFKExtjyZhqEnJKnvs8u9e0EfifqoOKKbtNcXynHTCW2gAnosjkh1FCSNvkNT00QApFhL1EubMTuwRatE4LK/rtwROn5Sv+36CoYOMjhgBc4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790780891; c=relaxed/relaxed;
	bh=BIHsTwyZ43cnCG3HcUOwIRG07ClCz/sTU0nge1LJvus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROqo2zMoHY3C/++4utpHJDTTsIbUWWId092yUM3ZbZTTbwYSdZgwAILVMBlGukbT+30Z6NGOZu0+H27qzu0zuW5CWLse5rqzoZ6PQXiiCJOGio5hE3FJu2BvWQJj6vCrzh87mQ3x/Fjc0SfbAPyQuh20He3uT6ZrhV2yheunmuRXbSazs6c7aJc0XVBgthwRXiRbUR/MoFt9CyCDyY2wXcDyA3hgqJ33utTdobCMLQKWVhZX3o2uP2eqx+b8A0n20is818s/sO7ZIao9nP9+g0I4skTv2U3vID4cLqdMTshjMYNscU1lqD07IwNSLMTj22p/6BR1E42mDDROO0TjBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=es5EeDGg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=es5EeDGg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com [IPv6:2607:f8b0:4864:39::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvz214vy1z2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:08:08 +1000 (AEST)
Received: by mail-pj2-x2a.google.com with SMTP id d9443c01a7336-2e2d719d99dso7215055ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790780886; x=1791385686; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIHsTwyZ43cnCG3HcUOwIRG07ClCz/sTU0nge1LJvus=;
        b=es5EeDGg4oPztkf7q3NTh5roweecdO8ns/0unwrVy1kCUc/R9qdWyFeZsJfCLCXBoz
         N0OIzpzERxUtWsePRPFlmCob//RrBmgMmLfpfAh0TK3MPN6S6+0mS3DwI2AehKGOLIFi
         UKjejDrV1JKg2FznZjU8znC6sBbhn0oWPPECxA/nWzYvVaDr6EQf/KxJ87MawBsnrDbY
         65qIKTQahsnSMJwu00asxXt7n/KKos4Q9BhvdXMKzEqDuFsXnB2feC5TqxlpRU6s0pNv
         YpS8rVnqI4sLTvNOPwy2DDlNOdqLeBDTvclbL3QSgPGdKzNK4ZHzEGqHovseewOU8GW7
         CfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780886; x=1791385686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BIHsTwyZ43cnCG3HcUOwIRG07ClCz/sTU0nge1LJvus=;
        b=wP2B4DrsfaEocwvZYuhmwzOmJXung03jN53azcwOPfx+ennwyxUBKsvV9yBaSFz76J
         mm9bM+ZjMHOB31i1yxfLqwa7sejLj7WlrYtHsImYApTFzFiPp+4eVG7JEIvsUfzXsWAA
         PyjCl++RoE8trmBCncGSG5ZSlNiE8y+d73wD1K/xdGyDIk2QugSU/pI7dninTSXe72rq
         ppASZ/AhCunl/Iy9pRcJGNcyHhgrCM3kPEEhMAHgE7QV2zznSp7mzv6YHEKrBABZCJ0X
         RCiNVspSktOUdfYUV9aJpfOBqlqA32Lrnn7ISXovyL8htB1zj7+KO/Gj5bNDpM8uM5Jp
         rVBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQmi7xbmZNMuLqVtY3G6atV/XOIcXY7gx+NB1to2iKbp/lIlR3d+d3v59I2w8HHl0Lv3s5uvTlhyqmUAs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIdgVJ0IcyMaP/45aKQJO2PaakL72TIkKhKQstd0Yey24QvSfcl
	CsAn8neZueZFEh2tvrb+rfGGDdrWHrgQT4w5dQqnwixF0iWwzATl2FGlnc8SZ0d6KHI=
X-Gm-Gg: AYBFou0vrrjafvjj5qG52xkZElFjjGIUqW4oLUDp6BSaQJOYdllem46equw5yYKgMws
	zTT/hPox3NBQlKM/osjb++b8tA7AGIhmRl/eJxe6w8GeTJppUybVxUsk/9xowgR/K2kXu9Nn8jo
	7ljrz9kNKwLE50adcbKgg+6aYKKcFcV7+VhLXeIH9Ln0zvQkBF9bb2zHdtQFZuP626QzIC69g3V
	tJZLKYZTDL5xI5gqn1d+oZac6OoUSNNqy8UVBjbBipYRqDlNXjH/zihY2EnCEY8fQTeLhMh0QZQ
	h+Y6/eko6VFMjJNhFH6CjVJ3T0lIHbr+A9v1XZZXd5zkbcHHnRcJN/Sx4jVwRgFi/7Wz165OI0T
	TPIgZgQaHbyR0LlWDYFoghDRZ4OiuSFfwR29HcPaJlqeuaW5RIH3BbNVdP1Vg6BwY3V8s3Cgd8J
	pdMFBfkf+1SaX4kKd8x7tFdSo8OeT8c4qLv8vvtEIbtNU6nVQnin6szL9Va5ekvjTlUqJoveI1u
	3g7y15WQumOunMvQR0=
X-Received: by 2002:a17:903:8c6:b0:2d9:26b3:547 with SMTP id d9443c01a7336-2e2e49f746cmr14145765ad.20.1790780885353;
        Wed, 30 Sep 2026 08:08:05 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e587f71bsm9426885ad.2.2026.09.30.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:08:03 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH] fixup! mm/sparse-vmemmap: switch device DAX to shared tail vmemmap pages
Date: Wed, 30 Sep 2026 23:07:48 +0800
Message-ID: <20260930150748.1134516-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930140627.57431-8-songmuchun@bytedance.com>
References: <20260930140627.57431-8-songmuchun@bytedance.com>
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

prep_compound_tail() makes PageCompound() true. Calling
__SetPageReserved() afterwards violates the PF_NO_COMPOUND policy and
triggers VM_BUG_ON_PGFLAGS() when CONFIG_DEBUG_VM_PGFLAGS is enabled.

Set PG_reserved before preparing the compound tail.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/sparse-vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 4be85e194c78..23b31bc4bf94 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -222,9 +222,9 @@ struct page __ref *vmemmap_shared_tail_page(unsigned int order, struct zone *zon
 		atomic_set(&page->_mapcount, -1);
 		set_page_node(page, zone_to_nid(zone));
 		set_page_zone(page, zone_idx(zone));
-		prep_compound_tail(page, NULL, order);
 		if (zone_is_zone_device(zone))
 			__SetPageReserved(page);
+		prep_compound_tail(page, NULL, order);
 	}
 
 	page = virt_to_page(addr);
-- 
2.54.0


