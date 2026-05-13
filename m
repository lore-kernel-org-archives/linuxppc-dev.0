Return-Path: <linuxppc-dev+bounces-20871-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F4FCD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 13:10:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFv1t29gbz2xSb;
	Wed, 13 May 2026 23:09:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778677778;
	cv=none; b=MltNpds1ecuqZNk8uvvyw1UAh0Zo6owTjdjadH6KIGNSxzu7NZiIatTMAFNTb4CragPvMXTn/tLG078YVw9pAeXi37nB27r47Z8dYezhZodE72JwdIJC7e2EYzWAFZu6uOV0mrdaJr8YPTwkQ5aFJRHoIUzrUof8RXdCUTNwyOpPSfHz/0Y13Nq5/9OyEGiVCZye/QE+6nIGoj5JbuX2HBSNOMcmqWiQhBWY3XoNtWX5k5zkaGe768QsDidr0hLnTeRxMdTmIAFW0XoAMNGvbWXUAb1N5I+o0SJW/YoreqW1yEbhcsN5H/g7Nd/K2bXkxUT4KF/2Iw4eJ9zoP7H5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778677778; c=relaxed/relaxed;
	bh=T0ssBedciqiVv0raptLCn49uzFGNVgYKzMgS4u/pGVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+J1BZ40lMSO9Ar0R7HyJjGOxydnCCsgtVEdkExVgS8bPSb5x3NoxqZS2NNQuhdzg87rw7r8O5SvpB5LPCOSmwt9+m1BUI5JoVLXQo3CXI9mR9EIk6UT8UjtAnO9g+7Z+RzDSERskIhFVGMy0Kknnlq6DlAhGvLh5ISiaXvsi7t0r0UQu37SJTAuVyD07Owewds60ekGdYJCGIho8GlNSnB5czycqj1jV7DxWVcBI5uHE8dsp16wlLpVN2xNnKfIqxcGWpbUW9mLZEy/BC02aZSv7OI0iWZ9Vt5EfpDMRKzQyv3BiYRFctFJ2KU4ZvcLWDujMSmoT847my3gyQ0xFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=A+ghXsRI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=A+ghXsRI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFv1s2jCPz2xpp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 23:09:37 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c8016d642b2so3639543a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778677775; x=1779282575; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ssBedciqiVv0raptLCn49uzFGNVgYKzMgS4u/pGVs=;
        b=A+ghXsRI+5L7082/nQIgnhzz/28NCvMgTNIJ1lAYdGgtsI/TxQkd++JOCQhC32uAnn
         ZckmdH1K01BAYvWZdO09hYhDkROVlZDZJd71baRi4+7kCKoQCXbgUFwNHf7MQ+Yk/hdw
         oYaZuoBgXCppwTFiY34O92j7fhRiF5FV1nH690pyawnx3A67+SiyrYX6ZSaRgI9Oiw6N
         fboQJ9mq1x5uURrTQPXH+gaPPkvumJMdGGuyQeplYua9sST2Nf9S+upptTzDp8Lkwe/Z
         XxrliHR2/9fV/uPHSc1izhYLkYQN+g/oDy7IQrNGWT2O+f9oKTQBtCAf0ZwbOhXNEk+V
         QBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677775; x=1779282575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0ssBedciqiVv0raptLCn49uzFGNVgYKzMgS4u/pGVs=;
        b=Rna1iB9817ydx8KzD3E/t+GQV3FneJXqqHa56r/O8zDSiXtUyOhLq5FxaR4P8G/Pgb
         4cxyaQCkh1jYEAx54yG2Mrb0TSh64lOiool+pGjq7JYilOOHtYy05sefBOFtuwZEPzJM
         Sq+Wgou6YJPLt/4Mrim5coZMcUgdH86vy7hANVHjYrRGU6kGC8g3z0JpA0oPAcVrRlOy
         +4ly/a6H+pBUE+00EX5oBHBh0IKUJWeewNc8E/MDQHd0uCA+b9jzU/gaEQFvnf/EpwDw
         cTp7lreYZwjoOTcR/lI+pWqyLq7uqdg7Djn1iHpQQaG6UngbpjQCvn8lAnquHXuWFvLX
         takQ==
X-Forwarded-Encrypted: i=1; AFNElJ/u2QKLa3gREeNQg7AkF5i4DBBLJ03HloO4zvU3XJQXrtq3M3yZVWWR0akwL7ubnnKIwnk097duTXSFUwg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQhwkJXzjdqSAnR+Y2V/a8+8PS4wWoC0x3eAOZvy3CROeNxsOA
	crGz9MyoUqxugeT1f4D2/EFiSdtznOOU/58usIdcZfcltooTuw2lKQSYjyCnObs8KeX1X5Sdrur
	bFmfDGeGQmg==
X-Gm-Gg: Acq92OGTTWN5vpNZs3lke49Ki8ydP4+SCkmQm6DAaf4dCbltKiKqsARFNiUTJjDFKLI
	rFl5oJ2BO3n561329zoPlZEAD37rpxbOt+2YUC4HKvajwwuRwvfaI/QLQWWjmzD4Rsakqx+41yT
	SzOs+PzjGIrA6RrRF+blv9QrwoiO3zaiELA3SE2huYrQ+XpXi2UZG7w04TG71by35gPPp4xHjwQ
	zm5S94J06UjKWgbVnepYX/zrrUDogZvrl5hO7IToUV4QKWGpXH3bQGcI4fqMXS1tb3fPHWhDRaB
	AqWmwRLEqITxOtLxTP6zHqTvSFH3cMvjfKpi0ZCA23AQFBRjryKigX/LpjdgLjLqGbFUQst++Kx
	+UXhcI03BuLuzXUC0eOSO1S7Knebw7FjFsyskyrwRdimlfRgUZsSo62/uevqvmFip/y1Qh8MiIe
	te4MPHrxpCS4GzyXMHmw/TbfGQq0qBY/L3xXfjOvaUb/FO/KpwLSZELyGGIDg=
X-Received: by 2002:a17:903:320d:b0:2b2:5070:8b with SMTP id d9443c01a7336-2bd270fa021mr26473735ad.1.1778677774883;
        Wed, 13 May 2026 06:09:34 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e90854sm166641925ad.66.2026.05.13.06.09.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 06:09:34 -0700 (PDT)
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
Subject: [PATCH v2 22/69] mm/sparse: Drop power-of-2 size requirement for struct mem_section
Date: Wed, 13 May 2026 21:04:50 +0800
Message-ID: <20260513130542.35604-23-songmuchun@bytedance.com>
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

struct mem_section is currently forced to a power-of-2 size so the
section-to-root lookup can use a mask instead of a modulo.

That requirement adds configuration-dependent padding, especially with
CONFIG_PAGE_EXTENSION, just to preserve the lookup scheme.

Drop the constraint and use a plain modulo for the lookup instead. The
divisor is constant, so the generated code remains cheap while avoiding
the extra padding. It also removes an unnecessary layout constraint
from the type.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h  | 8 +-------
 mm/sparse.c             | 2 --
 scripts/gdb/linux/mm.py | 6 ++----
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 40b1cea98b82..ae0271eaec05 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2027,12 +2027,7 @@ struct mem_section {
 	 * section. (see page_ext.h about this.)
 	 */
 	struct page_ext *page_ext;
-	unsigned long pad;
 #endif
-	/*
-	 * WARNING: mem_section must be a power-of-2 in size for the
-	 * calculation and use of SECTION_ROOT_MASK to make sense.
-	 */
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -2043,7 +2038,6 @@ struct mem_section {
 
 #define SECTION_NR_TO_ROOT(sec)	((sec) / SECTIONS_PER_ROOT)
 #define NR_SECTION_ROOTS	DIV_ROUND_UP(NR_MEM_SECTIONS, SECTIONS_PER_ROOT)
-#define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
 extern struct mem_section **mem_section;
@@ -2067,7 +2061,7 @@ static inline struct mem_section *__nr_to_section(unsigned long nr)
 	if (!mem_section || !mem_section[root])
 		return NULL;
 #endif
-	return &mem_section[root][nr & SECTION_ROOT_MASK];
+	return &mem_section[root][nr % SECTIONS_PER_ROOT];
 }
 extern size_t mem_section_usage_size(void);
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 324213d8bdcb..9457a4d6a6fc 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -331,8 +331,6 @@ void __init sparse_init(void)
 	unsigned long pnum_end, pnum_begin, map_count = 1;
 	int nid_begin;
 
-	/* see include/linux/mmzone.h 'struct mem_section' definition */
-	BUILD_BUG_ON(!is_power_of_2(sizeof(struct mem_section)));
 	memblocks_present();
 
 	if (compound_info_has_mask()) {
diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index dffadccbb01d..da4e8e9655a6 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -70,7 +70,6 @@ class x86_page_ops():
             self.SECTIONS_PER_ROOT = 1
 
         self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
-        self.SECTION_ROOT_MASK = self.SECTIONS_PER_ROOT - 1
 
         try:
             self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
@@ -100,7 +99,7 @@ class x86_page_ops():
     def __nr_to_section(self, nr):
         root = self.SECTION_NR_TO_ROOT(nr)
         mem_section = gdb.parse_and_eval("mem_section")
-        return mem_section[root][nr & self.SECTION_ROOT_MASK]
+        return mem_section[root][nr % self.SECTIONS_PER_ROOT]
 
     def pfn_to_section_nr(self, pfn):
         return pfn >> self.PFN_SECTION_SHIFT
@@ -249,7 +248,6 @@ class aarch64_page_ops():
             self.SECTIONS_PER_ROOT = 1
 
         self.NR_SECTION_ROOTS = DIV_ROUND_UP(self.NR_MEM_SECTIONS, self.SECTIONS_PER_ROOT)
-        self.SECTION_ROOT_MASK = self.SECTIONS_PER_ROOT - 1
         self.SUBSECTION_SHIFT = 21
         self.SEBSECTION_SIZE = 1 << self.SUBSECTION_SHIFT
         self.PFN_SUBSECTION_SHIFT = self.SUBSECTION_SHIFT - self.PAGE_SHIFT
@@ -304,7 +302,7 @@ class aarch64_page_ops():
     def __nr_to_section(self, nr):
         root = self.SECTION_NR_TO_ROOT(nr)
         mem_section = gdb.parse_and_eval("mem_section")
-        return mem_section[root][nr & self.SECTION_ROOT_MASK]
+        return mem_section[root][nr % self.SECTIONS_PER_ROOT]
 
     def pfn_to_section_nr(self, pfn):
         return pfn >> self.PFN_SECTION_SHIFT
-- 
2.54.0


