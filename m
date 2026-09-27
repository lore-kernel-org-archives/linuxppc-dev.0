Return-Path: <linuxppc-dev+bounces-28304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4C2C9832A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 02:56:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hspwV1CW5z30dn;
	Sun, 27 Sep 2026 12:55:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790477754;
	cv=none; b=BA58+QpME3KRWiCxA6ieqiRrh/tLhuHyMLn33bXl+WLbxgeJuvD5AgbqusnIh1t4d7OFH2JNxBM+bviQjxsIrje/xyx39hUcfe+/UtQw+w7iwRtMRhFwDFL9FtcSdYelB73ySb17CsZDZXt1NYvKBo5zRhOeKo6/FDOZPGAOzyhnHxNimSxlSi3KfxP9WlNNxOCi5pi0Ir2nEWiY5CU+wZyoZT2Jun5o4jDdFtBaqBB31dgpmHEdp0xuHtw72WoJALqkNj/suOegMcpOeSMojqhbdbAZOyZo1cHspgnh+BETOMuqa4a1G2lamd4hbONPMM3z1UNQgrtezR4i1+08/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790477754; c=relaxed/relaxed;
	bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evHy6LcMqHlQezxdkMcvBKbYo8RLk9iVI9d3oOL30tGoVATY1g1KHvHxwcePUpg9xjYzO4gNWKpErXNqPAF0773j5g4DRPijsYRVRuhgzFDskX+3UHgvOMAnrfmpuYzm6EPk8e7dpUuRx3QhQke9Z076XFNFgTHNJFZh3/16cO0IULiDaFe1RfXGROGsOPGixOVzmoZRj1h98m2U53asrVhfgiLC6jDkzEKbW1fG/cYTMRBapqu6QX7cnl/HDSJECcuVMml3EQiPRkJqMW+iZhKW9uMvDWUhhztdhFXZylVQTdfdHiIo2lLLSGeg8v6b45D7e2E6RDu76LThmOTzDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kFFDKaa4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kFFDKaa4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com [IPv6:2607:f8b0:4864:39::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hspwT2tFGz3048
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 12:55:53 +1000 (AEST)
Received: by mail-pj2-x0c.google.com with SMTP id 98e67ed59e1d1-3a0dc47fee0so392335a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790477751; x=1791082551; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=kFFDKaa4icI/fHzQSJdwPkvnrqb3CTAKb5/q4ThE7BznTRRy+LU0/Mf42hUYksg4a0
         QGgO6k2sNEtnQ0uoH5D7ByHFq6UD5aik/HFd6tgfbNcjheX0HbebDg7DixSpQQfzjMqs
         pS0pcW3rYXpOQ9Z4nxPrft7yUSfSAJs/BeNThth1xD4BW0kaGT/85/bCI/yXr0T/OHwU
         NL8OGGlq2v6w0sAmZHRt8kT8iKNN+QijA671y1LBs8W0OXzjqzYwxVxDGtTfgGuIEp45
         8b9eJi1M7+tjQEfUYUNR40/OEvW7L7sCxbZrv57CIwQHK4JK181W93RufSOrzugWEjQe
         g7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790477751; x=1791082551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUhtpwjDYsFhZVHLtQ8dC1wt8tqWIMzZ7omgfR51vXw=;
        b=bNf70ga2MIZK4tfx/FYfZ9GLAAShcHk9CHFZ6CwrtsLLJe2q9HLOwLqbsRbX3GsmTz
         9WjbBDkCZtBSLETWg/rv5+uo4fuIsASO2+SPuM9joSrUYu3KpQ+PR7VDGB3Ysjnzmx14
         s+mdUZEjT81PUXmk0UxAxN0rxZUSRDvz6LyteUbz6xw2454lRJZDWom3iKVjTMwacbyh
         KuDblxzECuq35mLgMX2duTWBGI4o7UqCVaH4Wq59lCNe1ZB19XLDZp6z8r27/Gv9eO7z
         lRt53mcdcqfZ9D7t//ETPar9zkMQL349k+p+LMKXYrPWP9HLu58Ubw/e7jtzkWSIKV88
         yxzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT0uxPZMjfLCUIHet9+RFJ3NNRydDcARfYoABzjvDmVbu3WeGsZnPesMjXuP2WMHA+pEjVmDybclgUUM4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJoOeRkq4GTrPRO6qPGzbGtYomWSu+LjWmGCykWeZkDObbMZeUk
	2vpNz47QgNIyiB5Gm/ODnwxRmcrDAcz2m67FAzSrWEol5LI4RAXSVj3l9v/qiLLCnU0=
X-Gm-Gg: AYBFou3D+NN/vgEqMdBVxgUmX4xeTx4hpxc+LG+cTO08ovOUzrA2FGQUAJIWVp7Fthj
	ocLSX+Pwz7vFAi7QuBWs7RVu9W4ewuXoBgu1AdwPYdVO7/aEJKdAwhoU9iXcDRSY6kR0POQGQy2
	I0vS0AVt2T/7W5z/7k6FpwR1cf4UZvZ32PovxEbK9ZC+LPtaV7lbsbC1gr86onBycjeeAz0LHRL
	I1pPSNh0woo7FV3fgA0qx5YzG1cHjtOrXgms7Ku9ijRWebkgAfsuYiWMZxD2ovhzQyOe0r7+UO/
	2RLQvghVVdIiD9mmUF/MQBYve3j10zdLeguIlwMJlUzMIsiNLd7EredyKtdURob7xXEEEtn/Kiv
	w+YT9pa1vTf9XMjHgf2ArpnWPDVCOLecbOk9Exq5bH2EBmH7z9nd/6HGCYnLmWD7ZVgHXqE1NUt
	pKXY1MBi+MHGbJEKMJKNinrWsEqEz7Ku9d+uoaJJDOIp8PDbbMEl+wnZlt3vx/E2aYYSpsT1Y4p
	qK5rVIwFc8+j7PETS+k
X-Received: by 2002:a17:90b:580d:b0:39e:6c69:f47e with SMTP id 98e67ed59e1d1-3a098d4ec7amr8377687a91.61.1790477751333;
        Sat, 26 Sep 2026 19:55:51 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm13461377a91.1.2026.09.26.19.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 19:55:50 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v5 12/12] Documentation/mm: update DAX vmemmap deduplication docs
Date: Sun, 27 Sep 2026 10:54:41 +0800
Message-ID: <20260927025441.741633-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260927025441.741633-1-songmuchun@bytedance.com>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
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

Device DAX now uses the common per-zone shared tail page for vmemmap
deduplication. The old documentation still described a DAX-specific
layout with a separately populated tail vmemmap page and half the HugeTLB
savings.

Update the generic and powerpc documentation to describe the shared layout.
In the powerpc document, keep the radix and 64K-specific details, drop the
duplicated 4K PUD arithmetic, and replace the repeated device-dax diagrams
with a single parameterized PMD/PUD diagram.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
---
v3:
- Collect Acked-by from Qi Zheng

v2:
- Clarify the commit message to state that the 4K PUD arithmetic is
  intentionally dropped reported by Sashiko.
---
 Documentation/arch/powerpc/vmemmap_dedup.rst | 90 ++++----------------
 Documentation/mm/vmemmap_dedup.rst           | 32 +------
 2 files changed, 21 insertions(+), 101 deletions(-)

diff --git a/Documentation/arch/powerpc/vmemmap_dedup.rst b/Documentation/arch/powerpc/vmemmap_dedup.rst
index dc4db59fdf87..8286acbca9bc 100644
--- a/Documentation/arch/powerpc/vmemmap_dedup.rst
+++ b/Documentation/arch/powerpc/vmemmap_dedup.rst
@@ -19,82 +19,28 @@ With 1G PUD level mapping, we require 16384 struct pages and a single 64K
 vmemmap page can contain 1024 struct pages (64K/sizeof(struct page)). Hence we
 require 16 64K pages in vmemmap to map the struct page for 1G PUD level mapping.
 
-Here's how things look like on device-dax after the sections are populated::
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     15    | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
-
-
 With 4K page size, 2M PMD level mapping requires 512 struct pages and a single
 4K vmemmap page contains 64 struct pages(4K/sizeof(struct page)). Hence we
 require 8 4K pages in vmemmap to map the struct page for 2M pmd level mapping.
 
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PMD    |                     +-----------+                       | | |
- |   level   |                     |     5     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     6     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     7     | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
-
-With 1G PUD level mapping, we require 262144 struct pages and a single 4K
-vmemmap page can contain 64 struct pages (4K/sizeof(struct page)). Hence we
-require 4096 4K pages in vmemmap to map the struct pages for 1G PUD level
-mapping.
-
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PUD    |                     +-----------+                       | | |
- |   level   |                     |     .     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     .     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |   4095    | --------------------------+
- |           |                     +-----------+
+Here's how things look on device-dax after vmemmap-optimized sections are
+populated. ``N`` is the number of vmemmap pages required by the DAX mapping
+above::
+
+  Device DAX                  vmemmap pages (N pages)         backing page frames
+ +-----------+ ---virt_to_page---> +-----------+   mapping to   +-------------+
+ |           |                     |     0     | -------------> |      0      |
+ |           |                     +-----------+                +-------------+
+ |           |                     |     1     | ------+
+ |           |                     +-----------+       |
+ |           |                     |     2     | ------+
+ |           |                     +-----------+       |
+ |           |                     |     .     | ------+        +-------------+
+ |  PMD/PUD  |                     +-----------+       |        | A single,   |
+ |   level   |                     |     .     | ------+------> | per-zone    |
+ |  mapping  |                     +-----------+       |        | shared tail |
+ |           |                     |   N - 1   | ------+        | page        |
+ |           |                     +-----------+                +-------------+
  |           |
  |           |
  |           |
diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
index 9fa8642ded48..8c287ae3f86c 100644
--- a/Documentation/mm/vmemmap_dedup.rst
+++ b/Documentation/mm/vmemmap_dedup.rst
@@ -1,4 +1,3 @@
-
 .. SPDX-License-Identifier: GPL-2.0
 
 =========================================
@@ -192,32 +191,7 @@ to 4 on HugeTLB pages.
 
 There's no remapping of vmemmap given that device-dax memory is not part of
 System RAM ranges initialized at boot. Thus the tail page deduplication
-happens at a later stage when we populate the sections. HugeTLB reuses the
-the head vmemmap page representing, whereas device-dax reuses the tail
-vmemmap page. This results in only half of the savings compared to HugeTLB.
-
-Deduplicated tail pages are not mapped read-only.
+happens at a later stage when we populate the sections.
 
-Here's how things look like on device-dax after the sections are populated::
-
- +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
- |           |                     |     0     | -------------> |     0     |
- |           |                     +-----------+                +-----------+
- |           |                     |     1     | -------------> |     1     |
- |           |                     +-----------+                +-----------+
- |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
- |           |                     +-----------+                   | | | | |
- |           |                     |     3     | ------------------+ | | | |
- |           |                     +-----------+                     | | | |
- |           |                     |     4     | --------------------+ | | |
- |    PMD    |                     +-----------+                       | | |
- |   level   |                     |     5     | ----------------------+ | |
- |  mapping  |                     +-----------+                         | |
- |           |                     |     6     | ------------------------+ |
- |           |                     +-----------+                           |
- |           |                     |     7     | --------------------------+
- |           |                     +-----------+
- |           |
- |           |
- |           |
- +-----------+
+Deduplicated tail pages are not mapped read-only. The mapping layout is the same
+as HugeTLB.
-- 
2.54.0


