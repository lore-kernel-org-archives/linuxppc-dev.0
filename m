Return-Path: <linuxppc-dev+bounces-25935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1203C5DF82
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:01:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGY0G5kz2yFW;
	Tue, 18 Aug 2026 14:01:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025684;
	cv=none; b=DkuuU7FypXErHTvQH921cw3T/TbPYh5+PhvAKEdgSjtfySbO96EqRkG6+l7iYBelLMyh8NBQeS5L7dEZrjHIG7sc062A9s2Gy3UseWzOj8PbN9NZx1MJkkE21glhO8YDr7ymQwhxAoCuleARy2BZGO+a97PjJ5sJE0tkQRkwcXd6/41D3tgvzglwn+u2IZ7SSVRTn9TBYRc11V2x+f2HTMzYJ9kY3Z1vSJBDfzZrrNO+WoPaXDqSip6oo6FSOhRmQne585rY0hbZasRFqo7EURUx+R4znW71usi2+EUv4E8M82mlyfQvHT73tDVeD2Xf2SVPrgk+lsHzSuoNiuuX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025684; c=relaxed/relaxed;
	bh=JBldtpHBDgaNn5UCzD5QqxCVKi38f4fFGgLWcwhAWyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y++9+Tsh4xvNJjubZ1fu725rsRlVDAAtDVoPtlwFdlRDcQKQ6wQvRM1JJm+cnvAKjA43+guOwXrSofW57hRDnx/UEN72lITpiRPYsdT3TD15zdNw34JkXrG1Emb6IBd2+j66WIC1JPl1aaGmewf6cvyh6s0OHv/XmvdPyEFYOtaEz9d44EKdBadqkqKAUCEz7PZKpf6OrVKsUeNB1cH06jKND2pLaUW22H/ZJ9ZiBD9aas0dVEVBp3AnYL3Joffa36dJtlh/evzcRfYYkbrgbGuQmnIaH4LHjfvEplw4tc1yug5ufDYFkDFMurVAFYfHaGqiFgjgJ75v1Hv8T3dVcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nm9wKCIr; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Nm9wKCIr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPGGS5B4Pz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:01:20 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A7D1713;
	Mon, 17 Aug 2026 21:00:44 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A313F66F;
	Mon, 17 Aug 2026 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787025648; bh=ttb24YxqPfvdlZDv4/6sPaZz7dp5RDI+R8A7FcbdkQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nm9wKCIrKirdGI7EsjFmNpzvktBxen3s+Y8bQddcn8JS5ntzJoAry+6wo+3u4vhyn
	 M7CRYhYAvk1FZnrpGWYeR2L9tvn1Sn/4mF9BXA7BiP3Pw3dmPL/RpL6VcCsRFudXyN
	 14LSMlFlRUiV28bQxOW5lFnD7s8QFTIgvbWS0vko=
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
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
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Date: Tue, 18 Aug 2026 09:30:34 +0530
Message-ID: <20260818040041.1891769-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
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

Move ptrval_to_str() inside a header thus making the helper more generally
available for new users which are being added later. While here, also move
another related string size macro PTVAL_STR_MAX inside the header as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm_types.h | 15 +++++++++++++++
 mm/memory.c              | 16 ++--------------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b18c2b2e7d2c..a5b514e55dd7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
 	return flags & MMF_INIT_LEGACY_MASK;
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
+
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/mm/memory.c b/mm/memory.c
index 01893720b6d8..752fc04ef8ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -46,6 +46,7 @@
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
 #include <linux/hugetlb.h>
+#include <linux/mm_types.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/highmem.h>
@@ -519,7 +520,7 @@ static bool is_bad_page_map_ratelimited(void)
 	return false;
 }
 
-static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
+void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
 {
 	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
 		snprintf(buf, buf_size, "overflow");
@@ -546,19 +547,6 @@ static void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry
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


