Return-Path: <linuxppc-dev+bounces-29684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E53ECCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:08:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7V8Y39ZFz2xjN;
	Mon, 19 Oct 2026 20:08:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792400925;
	cv=none; b=EPVpKVdJgaYxRktco/CUIbbQKBVX30hf+zukFv9ygARlhKE8Kfj775eH2WQjq0ThxfepUi3S76csoby8i7DMCb2s/k8+V+3nn/alwL2148UrLEQz4Se2LuqXE1hhNGNS+XrQqz+e0a2wCF1dia1xAINrllQ3Q7bYEuJAoDOhWK+/OHqyr8zHoJzDreDpAI6ersiHoOYQU6hxVqetxtAp8gvlcxkU5vAZA71VHsEmgPI2rQcg9eRc7oEA33oimQip4CrjDtPehHnDlDoSD830lB409w1DgBPtrgH28xspjHyhGaWgsaf+CQZg2X14j8hzxwtfSO7OlFESgDTGqiHUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792400925; c=relaxed/relaxed;
	bh=/pB41CYmMwKsKbqW1foc/PLT2lTdajoPoPYMHSrvZcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcflBkJZvpUe4TQyhJECakBf9y3lXbXYQKeFuUCHTAgvQ/M6n7iY//tchKysfyvVhINjw8E9G0r5bftPMlsyLLhAEDpyz4WaMHo4XucB2yfsAb0sI/O+6Pie4hz1sULFLj34+juW5m1zB8PMj3k1o/l68ij6axzoruOkWMQvmtzNA7wEujF09qPd8uH0TPfWKfNsXfcyqvsbk3bdOB7FoBSGJ1QUffVQEUC/iEgKVMTogR2llGcK7Xalovg6D7nF7TlMMjlKEHDXGcbO0uBzGAzC6QqErOpnF2BJhR13qap3+DQ8oLibamUVVzOUy2wHNuDF9gyYP/yupOfAPJq7fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k3oGjjbS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=k3oGjjbS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7V8W39wvz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:08:42 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e98798cbddso6564775ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792400920; x=1793005720; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/pB41CYmMwKsKbqW1foc/PLT2lTdajoPoPYMHSrvZcM=;
        b=k3oGjjbSUBAxsAWN6pUq8Fy92RlUQxF5/bSE8qo3+3RclhZ1QME9prJnC8Vd0JrF+k
         p0gX53hNPa/x2YpwIZ3kBcLzi6CJ0dMyHptcHoIZOaeMZZzx7oEFYn38Kp2EyAVJokF+
         e/HEQsawD6guv2+iuigqUe8J2uH/GcUL9763RHLy59shnMYKMq0fXtzvmui1r/pnFSVK
         hF8qng4XwQThut8C+/1jjTdR1W+LlRT1avLlz3SgpQgLpMQx6yBiyPteVcSXDzDBKT5r
         BTsC7dg0gkoaia1xxof4BYUfuI4n+AvE32yVQ6XvYs85++OY1CUcG9n7hnHEl4jK1yWg
         LZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400920; x=1793005720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pB41CYmMwKsKbqW1foc/PLT2lTdajoPoPYMHSrvZcM=;
        b=wExaSlL5KbdLvwwtQvj7T8yKCCa0MRyNxVbIUKJwTr1VQv1JPYpV5w0PSiDNA/yGAx
         kJTUpyZMywee9bzPoRHinpPYIZ8yMNd5aGANFaiAB/Udi8X3/+hiBjv4Ecbsc8kPCGf3
         m9nSxRCiwERF8/BibSt8opKlwtYGirYJKv60+j6vWBkH/fUrvbU4z9gWha/H7NOk+fZZ
         CMRujFf1w26p3U1AK/r6AFDrBLj4QdqCJsku7SLQzinhRLX7l59YuoaaThEax3+XmSf0
         JYaYJ0QeZhmBmqrrL1GbxmlCKX2CWyLRcow06beCyHYFtqnJYOX/6bnnfVcOb2Dkz/5M
         fm8A==
X-Forwarded-Encrypted: i=1; AKwUvBxjWqS7m/zW6qT5+wIWvdO4vNoDkBGJou9aEoYk7UdpIDZeJiMaS+EM6jv4w7vEkL03k/6evbtNYV4t7xk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVVR/tp1Q2VOD4q32w2Qg3ncrh8dKGfzeCUW0fuVAdQ505/Zf0
	DK/dVhxruTg+d7tm85sIiIUK9MrFobDWHenRXLOqwQljH6SYCrsTocIlbr2E05P0TBg=
X-Gm-Gg: AYBFou13zb/osgIFCK7xLdxx9siPUKPLh2yRsNlC9DLJkJK4RQXqKRtUWRlHdur8KxX
	lo0imt/jV5RoGHISotO59Q8t+xOhCNyvGzWKcxzQQIrUhLMZvMye9dB+UddZN957EFIhYk2ggui
	/Xpf3ZtkRMF0JWve/DWkNWlBLqthkPihTx+zEVZ3b428/1gkN7AzPQfaoOOtz2yNsqE9Hfcp3g0
	epcb/pReiZm/siuJr6AStBRoLxlDJDkNXpS/JZV5Lydrj56+h3O5PpxqDbTPtOWOktqmJAWJO6q
	bv0rljIL0GO5bP6dcYy5hUhTmgRd1KaW1mBqb69qhEh17GDyswRlmbbg73qWtyYCVC1r48GHVBv
	+Y4uoSkEaTHiUr0i+MxOOsAuOWjh/zsXlfQWuFDsKsyBD1T5c76H4zx9GHVu4ChJ1rY4iUGVFEm
	HwJF0Qb38pTcliNGfn5nFYaSvN22MskuiQ6ybhHYt+35kXbB8SCd+8lP27Tnrrf9icRWDv6kQGW
	jrsOT9GQTWseRV+5QUu
X-Received: by 2002:a17:902:dacf:b0:2e9:9f14:c44 with SMTP id d9443c01a7336-2e9a6d38bbamr62890025ad.49.1792400919921;
        Mon, 19 Oct 2026 02:08:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e305f1dsm36707595ad.0.2026.10.19.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:08:38 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/4] mm: Enforce read-only shared vmemmap tail mappings
Date: Mon, 19 Oct 2026 17:08:26 +0800
Message-ID: <20261019090830.1917657-1-songmuchun@bytedance.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is split out from the earlier, larger series "mm: Generalize
HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
vmemmap optimization across HugeTLB and device DAX, this subset addresses
a single, self-contained step: mapping shared vmemmap tail pages read-only
at population time.

After the previous HugeTLB and device DAX conversions, both can install
optimized shared-tail mappings during vmemmap population. These mappings
should be read-only because each shared tail vmemmap page backs metadata
for many tail pages. HugeTLB applies this protection in a later,
subsystem-specific pass, but device DAX currently lacks it.

This series moves the protection into the generic sparse-vmemmap and
powerpc radix population paths. This protects device DAX mappings and
makes the HugeTLB-specific vmemmap_wrprotect_hvo() pass redundant. With
that pass gone, the bootmem-only optimization wrapper has no distinct
work and is removed as well.

This is intended to be the fifth smaller step toward the broader HVO
generalization. The remaining HVO naming and enablement consolidation is
left for follow-up series.

[1] https://lore.kernel.org/all/20260513130542.35604-1-songmuchun@bytedance.com/

Muchun Song (4):
  mm/sparse-vmemmap: map shared vmemmap tail pages as read-only
  powerpc/mm: map shared vmemmap tail pages as read-only
  mm/hugetlb_vmemmap: remove vmemmap_wrprotect_hvo()
  mm/hugetlb_vmemmap: remove hugetlb_vmemmap_optimize_bootmem_folios()

 Documentation/mm/vmemmap_dedup.rst       |  3 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c |  3 ++
 include/linux/mm.h                       |  2 --
 mm/hugetlb.c                             |  2 +-
 mm/hugetlb_vmemmap.c                     | 45 +++++-------------------
 mm/hugetlb_vmemmap.h                     |  6 ----
 mm/sparse-vmemmap.c                      | 26 ++------------
 7 files changed, 17 insertions(+), 70 deletions(-)


base-commit: 2887e63d2e8e0cf55402612d8996ce955a2c3e55
-- 
2.54.0


