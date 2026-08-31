Return-Path: <linuxppc-dev+bounces-26212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0514C624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 05:44:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHx91LMkz2yCt;
	Mon, 31 Aug 2026 15:44:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788155053;
	cv=none; b=JjeYM88bENBsZOtlAIvBuagNKkC2KvYmaJcJWQFULWdfO2EFrxGkyg+tEYFETDm49cKitQovtyvQfArhZ7beydr/hJAjPMMFWqUEz7tKNtkzJ7WrUquo7ql7wrqYyWT7Ii9I1svEUX1yUd732ZpjW7w8W3inHIZo9bU4RRWKdUD1NBlfLvM8GkutknSL+J03tEZ0mqzrzYneqxJxzwQZirWwJbOwPVFUcuYOIcSaP3Evkeopn2Jex3KFraXb9auEsBd4XvWsHL6UtyUJzRpiP0sMV1nCJRXjFfwD/14CuDrqMVLb0mQGhjT9+7vCUk5yEvc8xYWkms/UjcmkHD7t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788155053; c=relaxed/relaxed;
	bh=HX2UJHkvYtIE8Iv3IhpwI5DtNIWDsoCmIUsixatil5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwC2pF454BonpfdhTSu8x+skteLpvoKMwuC6aZ9I6q83ALlZkmwA+qGAWGPGEMwE28fNufbhF//1ZLBEWS07QSFrvtfFPUbpt1f3lQFtyncMib77fZGyPOkOt1Lq0QC54fc/tP57KHCTrdQuXtGtzm0c4kNtBpifJOcSpt1OjCIbX4rxHt7Erd3VS3KWpZScYz0O4ZrZ93x+Xo9rqlvp3lUkkxu61u+N/GwBT0bsBR7nNcs5EhfUPuXluKnasd7Kt+LimFiKu+5Hkfwr/m3tiYI1vmRO6Q7GjUClN0JcIoQHn0B4eTiIGrOFwGxIlgHbIjI6ObUpYzDMQp/i5KbAOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CnW75J3D; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CnW75J3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYHx63W2Pz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 15:44:10 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3F871692;
	Sun, 30 Aug 2026 22:43:34 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96B63F85F;
	Sun, 30 Aug 2026 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788155018; bh=GGK9AC8Tv1PQeecS48AIrQ55e9LqtRQAIQ7FmY+hs+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnW75J3DRkRMOvrNTUSCnYFQNOIbOUOnmVJQMtfF42eAuoH7YKNUi6ESpSwqTyfrG
	 vG0N5mSEM+8VmDd50f9PcBmxjBOkfiS4wh7Lhpjo2rW0nQBSjOK1m4mUYkK3mw+zi4
	 N5OIrqAwr66EWBpqjhoDF/YwciJOKv9ClphMWYs0=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: samuel.holland@sifive.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm: Make ptval_to_str() generally available
Date: Mon, 31 Aug 2026 11:13:23 +0530
Message-ID: <20260831054331.625505-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
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

Move ptval_to_str() inside a header thus making the helper more generally
available for new users which are being added later. While here, also move
another related string size macro PTVAL_STR_MAX inside the header as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- Moved ptval_to_str() and adjcent declarations inside <include/linux/pgtable.h>
- Fixed type s/ptrval_to_str/ptval_to_str in [PATCH 1/8]

 include/linux/pgtable.h | 14 ++++++++++++++
 mm/memory.c             | 15 +--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..e3c8ab96941c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2313,6 +2313,20 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
+void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
+
+#define ptval_to_str(buf, val)								\
+	do {										\
+		auto __val = (val);							\
+											\
+		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
+	} while (0)
+
+#if defined(__SIZEOF_INT128__)
+#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
+#else
+#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
+#endif
 #endif /* !__ASSEMBLER__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
diff --git a/mm/memory.c b/mm/memory.c
index 8b0c2c735d3d..aa6b2fc770fc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -519,7 +519,7 @@ static bool is_bad_page_map_ratelimited(void)
 	return false;
 }
 
-static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
+void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
 {
 	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
 		snprintf(buf, buf_size, "overflow");
@@ -546,19 +546,6 @@ static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry
 	}
 }
 
-#define ptval_to_str(buf, val)								\
-	do {										\
-		auto __val = (val);							\
-											\
-		ptval_bytes_to_hex_str((buf), sizeof(buf), &__val, sizeof(__val));	\
-	} while (0)
-
-#if defined(__SIZEOF_INT128__)
-#define PTVAL_STR_MAX	(32 + 1) /* Max 128-bit value in hex + NUL */
-#else
-#define PTVAL_STR_MAX	(16 + 1) /* Max 64-bit value in hex + NUL */
-#endif
-
 static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
 {
 	char pgd_str[PTVAL_STR_MAX];
-- 
2.43.0


