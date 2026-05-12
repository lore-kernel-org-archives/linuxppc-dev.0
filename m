Return-Path: <linuxppc-dev+bounces-20787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A67ECD4F21
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 12:09:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFFkb5gljz2xnQ;
	Tue, 12 May 2026 22:09:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778570827;
	cv=none; b=cvSYsFqDDPQVaeZpEMq/DfAgTT8bt6hX8snt/AQYTHDK4QzuMLTVI3u16mneKyWK6nA1MdHQbI+KY4lJ9yh3PE67mY/QC6Q0sQPJFOyTZSzzJ7YXxuh1wiOIS10mBIKw19iYxa5TwXQyFsB81OgCNchNPqn+4gBI6zMYy+N+B3SEHER1R2QDi3MbW2X8TTyBGOYm0bBlr53NEQMD13fIIPZCKkT9O3zHwzRCuSDk3Ay87bDangN7PiC+K5CIsqvZaIxgG0Mg9TTizRcjVKr5uZHHSBfY5R3vFQeDqKnMwQLKOkKhxkXy6MTT+XIBTa02zW65EjFySeNDs29iXxhgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778570827; c=relaxed/relaxed;
	bh=fx4e8OAen0NF75+J/YmhI593eekBwMCjX/uv6e51cmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPUVuoycRWMgwZvmc0V47IWl8W6RgTcQQxWmIsTNtzlyAmXf0N8a5GTApHRWC0el4THsbHAY2uyK14+QAuCRxG4FpvKCuNpwpuvZBc5lZp9mXwO0nsy6gAzEKFyqf5wiGyAPrgZlPn9noXjEBf3xjtAUiisjMN6oSVpgsCpv57yl9vEAF+e5nH3qUe4bRmOzEy21Y+BEhydCgfGeg/o33+C07Iu6bWVn8Xrhsx3CHNyynetVHU2dd2F/Sl9oVKkYM5d0kQTCe0l8/STum0M4yXhhwHDJWeganAGSWUR35Yrl2wFqo9XzpvWYm/aEehCKVFwLP6UwBabOxs2WMtIIsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LKLhDuH9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org) smtp.mailfrom=bytedance.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=LKLhDuH9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=songmuchun@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7T56cMtz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 17:27:05 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2bcd3ac3307so9805005ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778570823; x=1779175623; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fx4e8OAen0NF75+J/YmhI593eekBwMCjX/uv6e51cmw=;
        b=LKLhDuH9QmBaU2PRv+8OGB7zX/0o+1m5w8CpIDYqSWRX9onFZi/ExN95x0vAhRrIkH
         wFgRvpjzgUFc/XfOmTtiSnQIgyY9gbwmPxt+Powv06yHvEi95fVrZZ/H4WiD4AhQgdwy
         dnkO61aHedebxD6oX6SUk33S4nMaRrVarjw6esdR7mLJQtmg8DOMa6PozvudFxwNAemQ
         +zoUBnULzpj0GDJU7fUyUhJLRPnWfJrzvOoB1bJoYhp4sJo6F7CYeQVg0U/MpumukH6C
         7FmgHqRKomHXeMwYD49EWoBidGq4l8mzmpVTxNwZ01Cbv+NQIXExZa4dKiolL2qp8Y5A
         HtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570823; x=1779175623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx4e8OAen0NF75+J/YmhI593eekBwMCjX/uv6e51cmw=;
        b=AxmPF5g5Vc+dI74ZL8ti941YS7MBGsjg4n/ZojFqjktdxt7oOuUczyv1R+Hch1FDEP
         T25k6APM0z018SuYI/RUAxrHhxnr6zLTqj3tzyB9RVnFcAppo/qrDjHJNmpVAWw4z4Z+
         d/FscWJ+s1XSbea5UHUABAXowSrrfSAa90kxx0sM0ofRXH+yx7V5c6qdHtOc9YOHnY6C
         lzQe69GJmAiv//wyC0FEX5fC/8gGh3o1t2JbZ0s8A1YIqGaOSUW0I3pBf5M66tmTl34i
         57fl4w2fdoVn8u8sts6PkUCfwZ+iIq4Qt14Zo+w+z/O/NjcH8+wpus264tYF+jMLbkGC
         kbZw==
X-Forwarded-Encrypted: i=1; AFNElJ8dH/mKU3yo1NwrgQE9+zJKjzIXeC+YFOx6krGNgRqu+iaLu98vfKJ/DD5IBmjcSNAC/jg12V28nS6YNlw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwuGR83bv8q90UCrpxIyRhwewtMW2QkVPDP57igt/OERk8kQ8/0
	og5W87z+uNyc6qIYQUDJg6vt4PFSgwD8ga8Cl0hkBMJ72m8HX64NurtGjxay8OCZtv0=
X-Gm-Gg: Acq92OHVrPWP5HGIhq2kdZ3K3zyvPqgBuxL3W9i6bl3J390i5D0AE1tVGQdB6MESIGM
	hL9fLS2ay2UXLHhS/GfscESZxgHIzHITFXDE9ssdSL0v02Xzh/N9B0vAimw9wIevG8xxFAgCgwO
	KtVY/SnaAi4G6t0p4cRMdEJJ1YhbV5eiqTpLCv5ZH5iNXzF2LeXzfHDLzFMy1cNCWHFGxvhKcAK
	zdSPQA+5gVdSiFDDOWaIkkEI9ikkAjf2dDGS6biYzOPuJu4qMb1V8vvwT8W6iUft5mwhNFE5xPl
	00nHG+8VfUesdP1dupqog53eH/53arfiq303Htu4hDQ5OQfaizwF/lJ/kSCc3MacVjnRJKw+Kf7
	WynUzEXKrMl+bfkhY0jjQ8nlrelx+0m6rJ0gkg+CtcXZdgBza2QzmMzPJYHjkrzvGnDkk2ooQQe
	cX/hb/aDUXr52nEc53HA==
X-Received: by 2002:a17:902:c401:b0:2bc:ebb1:e3a7 with SMTP id d9443c01a7336-2bd012b3330mr24218975ad.32.1778570822529;
        Tue, 12 May 2026 00:27:02 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::343])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm129200635ad.2.2026.05.12.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:27:02 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev
Cc: Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Donet Tom <donettom@linux.ibm.com>,
	muchun.song@linux.dev
Subject: [PATCH v2] drivers/base/memory: make memory block get/put explicit
Date: Tue, 12 May 2026 15:26:35 +0800
Message-ID: <20260512072635.3969576-1-songmuchun@bytedance.com>
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

Rename the memory block lookup helper to make the acquired reference
explicit, add memory_block_put() to wrap put_device(), remove
find_memory_block(), and use memory_block_get() as the single block-id
based lookup interface.

This makes it clearer to callers that a successful lookup holds a
reference that must be dropped, reducing the chance of forgetting the
matching put and leaking the memory block device reference.

Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Tested-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
---
Changes in v2:
- mention the removal of find_memory_block() in the commit message
- drop the redundant extern from the memory_block_get() declaration
---
 .../platforms/pseries/hotplug-memory.c        | 14 ++-----
 drivers/base/memory.c                         | 38 +++++++------------
 drivers/base/node.c                           |  4 +-
 drivers/s390/char/sclp_mem.c                  | 17 ++++-----
 include/linux/memory.h                        |  7 +++-
 mm/memory_hotplug.c                           |  5 +--
 6 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 75f85a5da981..94f3b57054b6 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 
 static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
 {
-	unsigned long section_nr;
-	struct memory_block *mem_block;
-
-	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
-
-	mem_block = find_memory_block(section_nr);
-	return mem_block;
+	return memory_block_get(phys_to_block_id(lmb->base_addr));
 }
 
 static int get_lmb_range(u32 drc_index, int n_lmbs,
@@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
 	else
 		rc = 0;
 
-	put_device(&mem_block->dev);
+	memory_block_put(mem_block);
 
 	return rc;
 }
@@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_offline_lmb(lmb);
 	if (rc) {
-		put_device(&mem_block->dev);
+		memory_block_put(mem_block);
 		return rc;
 	}
 
 	__remove_memory(lmb->base_addr, memory_block_size);
-	put_device(&mem_block->dev);
+	memory_block_put(mem_block);
 
 	/* Update memory regions for memory remove */
 	memblock_remove(lmb->base_addr, memory_block_size);
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 11d57cfa8d72..5b5d41089e81 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
  *
  * Called under device_hotplug_lock.
  */
-struct memory_block *find_memory_block_by_id(unsigned long block_id)
+struct memory_block *memory_block_get(unsigned long block_id)
 {
 	struct memory_block *mem;
 
@@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
 	return mem;
 }
 
-/*
- * Called under device_hotplug_lock.
- */
-struct memory_block *find_memory_block(unsigned long section_nr)
-{
-	unsigned long block_id = memory_block_id(section_nr);
-
-	return find_memory_block_by_id(block_id);
-}
-
 static struct attribute *memory_memblk_attrs[] = {
 	&dev_attr_phys_index.attr,
 	&dev_attr_state.attr,
@@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
 
 	ret = device_register(&memory->dev);
 	if (ret) {
-		put_device(&memory->dev);
+		memory_block_put(memory);
 		return ret;
 	}
 	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
@@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	struct memory_block *mem;
 	int ret = 0;
 
-	mem = find_memory_block_by_id(block_id);
+	mem = memory_block_get(block_id);
 	if (mem) {
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		return -EEXIST;
 	}
 	mem = kzalloc_obj(*mem);
@@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
 		memory->group = NULL;
 	}
 
-	/* drop the ref. we got via find_memory_block() */
-	put_device(&memory->dev);
+	/* drop the ref. we got via memory_block_get() */
+	memory_block_put(memory);
 	device_unregister(&memory->dev);
 }
 
@@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 		end_block_id = block_id;
 		for (block_id = start_block_id; block_id != end_block_id;
 		     block_id++) {
-			mem = find_memory_block_by_id(block_id);
+			mem = memory_block_get(block_id);
 			if (WARN_ON_ONCE(!mem))
 				continue;
 			remove_memory_block(mem);
@@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		return;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id);
+		mem = memory_block_get(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
 		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
@@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 		return 0;
 
 	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
-		mem = find_memory_block_by_id(block_id);
+		mem = memory_block_get(block_id);
 		if (!mem)
 			continue;
 
 		ret = func(mem, arg);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		if (ret)
 			break;
 	}
@@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 void memblk_nr_poison_inc(unsigned long pfn)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem = memory_block_get(block_id);
 
 	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 	}
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
 {
 	const unsigned long block_id = pfn_to_block_id(pfn);
-	struct memory_block *mem = find_memory_block_by_id(block_id);
+	struct memory_block *mem = memory_block_get(block_id);
 
 	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
-		put_device(&mem->dev);
+		memory_block_put(mem);
 	}
 }
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 126f66aa2c3e..b3333ca92090 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
 		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
 			struct memory_block *mem;
 
-			mem = find_memory_block_by_id(block_id);
+			mem = memory_block_get(block_id);
 			if (!mem)
 				continue;
 
 			memory_block_add_nid_early(mem, nid);
 			do_register_memory_block_under_node(nid, mem);
-			put_device(&mem->dev);
+			memory_block_put(mem);
 		}
 
 	}
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 78c054e26d17..6df1926d4c62 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
 	addr = sclp_mem->id * block_size;
 	/*
 	 * Hold device_hotplug_lock when adding/removing memory blocks.
-	 * Additionally, also protect calls to find_memory_block() and
+	 * Additionally, also protect calls to memory_block_get() and
 	 * sclp_attach_storage().
 	 */
 	rc = lock_device_hotplug_sysfs();
@@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
 			sclp_mem_change_state(addr, block_size, 0);
 			goto out_unlock;
 		}
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
-		put_device(&mem->dev);
+		mem = memory_block_get(phys_to_block_id(addr));
+		memory_block_put(mem);
 		WRITE_ONCE(sclp_mem->config, 1);
 	} else {
 		if (!sclp_mem->config)
 			goto out_unlock;
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
+		mem = memory_block_get(phys_to_block_id(addr));
 		if (mem->state != MEM_OFFLINE) {
-			put_device(&mem->dev);
+			memory_block_put(mem);
 			rc = -EBUSY;
 			goto out_unlock;
 		}
-		/* drop the ref just got via find_memory_block() */
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		sclp_mem_change_state(addr, block_size, 0);
 		__remove_memory(addr, block_size);
 #ifdef CONFIG_KASAN
@@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 		return rc;
 	block_size = memory_block_size_bytes();
 	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
-	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
+	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
 	if (!mem) {
 		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
 	} else {
-		put_device(&mem->dev);
+		memory_block_put(mem);
 		rc = -EBUSY;
 	}
 	unlock_device_hotplug();
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 5bb5599c6b2b..463dc02f6cff 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(enum memory_block_state state, void *v);
-extern struct memory_block *find_memory_block(unsigned long section_nr);
+struct memory_block *memory_block_get(unsigned long block_id);
+static inline void memory_block_put(struct memory_block *mem)
+{
+	put_device(&mem->dev);
+}
 typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
@@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
 typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
 int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
 			       struct memory_group *excluded, void *arg);
-struct memory_block *find_memory_block_by_id(unsigned long block_id);
 #define hotplug_memory_notifier(fn, pri) ({		\
 	static __meminitdata struct notifier_block fn##_mem_nb =\
 		{ .notifier_call = fn, .priority = pri };\
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 462d8dcd636d..890c6453e887 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 		struct vmem_altmap *altmap = NULL;
 		struct memory_block *mem;
 
-		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
+		mem = memory_block_get(phys_to_block_id(cur_start));
 		if (WARN_ON_ONCE(!mem))
 			continue;
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
-		/* drop the ref. we got via find_memory_block() */
-		put_device(&mem->dev);
+		memory_block_put(mem);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.54.0


