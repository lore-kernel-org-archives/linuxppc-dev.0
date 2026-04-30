Return-Path: <linuxppc-dev+bounces-20328-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3923FF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 04:17:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5gr63rqSz2xMY;
	Thu, 30 Apr 2026 14:17:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777521912;
	cv=none; b=ih7nzZw5+US2qaqVGhcv1ixS6V+7sZgC1rmnxV2EEEdgp5zwiY7Ou2YmPGHosfSGlNjW6V4MPOm57sMKiIkWDo/5topSXt5C+9qLIVVgpzfePKXWsW51fyyK8V7CpRZDzTWQKX/OVIydrr8eLMlZwD9asQXtyc8sFPtahcnUk8/L4GKlIXMFqzbTpl7GPbJTjHgTQSOyCkLr5XaeDkM5gjgLcSEJSFWRaiJGz/9hlRdFux0XiMb9T8OFzVz1C4fyEyJHPiBYbAv9WnifG3UsfZ3Np1aCDE85Q5S+sJhoY2EdCrXN2tJ5MsKSf2XxKEzSU8q4iNA+/5b986UeDmHnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777521912; c=relaxed/relaxed;
	bh=91miQC+6ESWqee34eo4YVmoqoVtggz6DZAL6gngZUZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAPKLoh5tpz8yWJ4QAPWLAqAdOvs2DU98xW2f5o0a64uEnRncPBRbDS3A786HPOgiqMNanbpsHXdDECZ5hAZBQFAVkRpgPMMeQFmNS75oOWT53S78TeG7OGaLX8qTYtwKk4uElL+HDsDLlcDsFIRnkvd3N647QbD2ZjixMc8EOcxbza7NqrVa0Vc+EgAi7pxtQsJmtuEVW7b9GxWniDANyeCpq/5sRn+M9MFSe3yBUVUB/t86HoWIYuwrgMl7h1V2R8zKR7HEbBaaEWC6gbHCm+rv3Dj8AwqCOujWIuI2oDIZ/coGx3W67gPuui3ygNXy3XWs6UMAwbyMjXFMiMC4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HVHmp1Z+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HVHmp1Z+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5gYg44xXz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 14:05:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 85F7B61141;
	Thu, 30 Apr 2026 04:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BA2C2BCB8;
	Thu, 30 Apr 2026 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777521909;
	bh=IOVfryRIB//G7TP35s/rdTIpoHZE33+XU/HgNFu89vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVHmp1Z+siadLb4Q4UHbDBBFXRgvKznPzVZgfJaZuDYbe4T7jnjjPpsDtJInwZIeE
	 4+I5FPsV3n+vKdFvmZlaVSvEPy/79jVItKW9FKiSkpofZcGT8gtPXTdJbnuWCRBQ7C
	 IotyNjhp+vK1JXwZXT1524wwOq3YNWA8MbefdUygDl892tC+sKqCeBWIognUzoFWBz
	 1ZfPBOz5ggtDlvNtoxkZ97/ykVcs4f1SLEbGN/iXyxKX9lzWM6c+fEG+I0aotBh4/p
	 pL2UOnf780mijkJBKnrAw7yfy8qSdrHqgtuQ3Q+6qcVgHDWif223rrlC6SFHrfHNEh
	 uuxK+cvO1oYsg==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	willy@infradead.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jack@suse.cz,
	pfalcato@suse.de,
	wanglian@kylinos.cn,
	chentao@kylinos.cn,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	liyangouwen1@oppo.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	"Barry Song (Xiaomi)" <baohua@kernel.org>
Subject: [PATCH v2 3/5] mm: Move folio_lock_or_retry() and drop __folio_lock_or_retry()
Date: Thu, 30 Apr 2026 12:04:25 +0800
Message-Id: <20260430040427.4672-4-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260430040427.4672-1-baohua@kernel.org>
References: <20260430040427.4672-1-baohua@kernel.org>
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

folio_lock_or_retry() is effectively only used in mm/memory.c,
not in the filemap code. Move it there and make it static.

The helper __folio_lock_or_retry() can be folded into
folio_lock_or_retry(), allowing it to be removed.

Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
---
 include/linux/pagemap.h | 17 -------------
 mm/filemap.c            | 45 ----------------------------------
 mm/memory.c             | 53 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 62 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1f50991b43e3..500ab783bf70 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1101,7 +1101,6 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
@@ -1198,22 +1197,6 @@ static inline int folio_lock_killable(struct folio *folio)
 	return 0;
 }
 
-/*
- * folio_lock_or_retry - Lock the folio, unless this would block and the
- * caller indicated that it can handle a retry.
- *
- * Return value and mmap_lock implications depend on flags; see
- * __folio_lock_or_retry().
- */
-static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
-					     struct vm_fault *vmf)
-{
-	might_sleep();
-	if (!folio_trylock(folio))
-		return __folio_lock_or_retry(folio, vmf);
-	return 0;
-}
-
 /*
  * This is exported only for folio_wait_locked/folio_wait_writeback, etc.,
  * and should not be used directly.
diff --git a/mm/filemap.c b/mm/filemap.c
index a045b771e8de..b532d6cbafc8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1740,51 +1740,6 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 	return ret;
 }
 
-/*
- * Return values:
- * 0 - folio is locked.
- * non-zero - folio is not locked.
- *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
- *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
- *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
- *
- * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
- * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
- */
-vm_fault_t __folio_lock_or_retry(struct folio *folio, struct vm_fault *vmf)
-{
-	unsigned int flags = vmf->flags;
-
-	if (fault_flag_allow_retry_first(flags)) {
-		/*
-		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
-		 * released even though returning VM_FAULT_RETRY.
-		 */
-		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return VM_FAULT_RETRY;
-
-		release_fault_lock(vmf);
-		if (flags & FAULT_FLAG_KILLABLE)
-			folio_wait_locked_killable(folio);
-		else
-			folio_wait_locked(folio);
-		return VM_FAULT_RETRY;
-	}
-	if (flags & FAULT_FLAG_KILLABLE) {
-		bool ret;
-
-		ret = __folio_lock_killable(folio);
-		if (ret) {
-			release_fault_lock(vmf);
-			return VM_FAULT_RETRY;
-		}
-	} else {
-		__folio_lock(folio);
-	}
-
-	return 0;
-}
-
 /**
  * page_cache_next_miss() - Find the next gap in the page cache.
  * @mapping: Mapping.
diff --git a/mm/memory.c b/mm/memory.c
index 00ee1599d637..0c740ca363cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4442,6 +4442,59 @@ void unmap_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL(unmap_mapping_range);
 
+/*
+ * folio_lock_or_retry - Lock the folio, unless this would block and the
+ * caller indicated that it can handle a retry.
+ *
+ * Return values:
+ * 0 - folio is locked.
+ * non-zero - folio is not locked.
+ *     mmap_lock or per-VMA lock has been released (mmap_read_unlock() or
+ *     vma_end_read()), unless flags had both FAULT_FLAG_ALLOW_RETRY and
+ *     FAULT_FLAG_RETRY_NOWAIT set, in which case the lock is still held.
+ *
+ * If neither ALLOW_RETRY nor KILLABLE are set, will always return 0
+ * with the folio locked and the mmap_lock/per-VMA lock is left unperturbed.
+ */
+static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
+					     struct vm_fault *vmf)
+{
+	unsigned int flags = vmf->flags;
+
+	might_sleep();
+	if (folio_trylock(folio))
+		return 0;
+
+	if (fault_flag_allow_retry_first(flags)) {
+		/*
+		 * CAUTION! In this case, mmap_lock/per-VMA lock is not
+		 * released even though returning VM_FAULT_RETRY.
+		 */
+		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+			return VM_FAULT_RETRY;
+
+		release_fault_lock(vmf);
+		if (flags & FAULT_FLAG_KILLABLE)
+			folio_wait_locked_killable(folio);
+		else
+			folio_wait_locked(folio);
+		return VM_FAULT_RETRY;
+	}
+	if (flags & FAULT_FLAG_KILLABLE) {
+		bool ret;
+
+		ret = __folio_lock_killable(folio);
+		if (ret) {
+			release_fault_lock(vmf);
+			return VM_FAULT_RETRY;
+		}
+	} else {
+		__folio_lock(folio);
+	}
+
+	return 0;
+}
+
 /*
  * Restore a potential device exclusive pte to a working pte entry
  */
-- 
2.39.3 (Apple Git-146)


