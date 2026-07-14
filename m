Return-Path: <linuxppc-dev+bounces-24223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D4EC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01LF6w80z30CZ;
	Wed, 15 Jul 2026 00:05:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784037957;
	cv=none; b=bV4wsBKI0pSqr062MnX+4ei61EfosZK4B4yvEXDSEoua0Rl9oNHpJNuCYd3034/z5s6LvNiSyjPvz628/VZZhr1w+C4715gMRFkpaHN+1j8Rr+dRVXYrSBs8g3FQvEBi0B/C9nhNBh2icjI+eJWxOo0Ea8SD4kL0Yvn3zCzozOPlPPtO0X0jwGQyBCrpI2DSdAbMvZKNut/+Iwou23P6LHszE0wlqCPrfFZqcJv84/IjjIQNJLTvmqaYHR+YXkTswKxydaASKDlUDDISMFeoXZGuEHnqH7bgO70X1sA6fSG0iObdn23AokW2So6ZuDKRh0BnThVpvlLMP9lz5GZCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784037957; c=relaxed/relaxed;
	bh=ng20Y1WVsLH0VrG9X7Anb28wNw6mpkVst635uOI6nRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8xEKNb1UMYnSWojj6C+UGCUhuO/v2sZo7O4Jo9NGd980KFoiGfjkRyl6ndvA4a7gBJU2uK/NilC1eNxyhATwui3A6pA31X92AJx/fvwFsOcgj4RIIyUjCoYOMLaNiPliNCJYJstd3ZDwDaiesYxYyxtr5rHhpro+zRbJa/dNy4UAPsgNcvKd8XILK9K1qHUMqcwMmrY4n8XR2+gOyw0H6jSZGacnQecAQwENuxj+86y5ZZGfDQGW1fbz969wM4W5oM45eyC3S0Ed7Duk+8MY3uBjYtXnxWSFtUeJV4gyWiQA19Dxn9IM5MytDkBRvdp90K3eZppPKYMKrC5S5Unvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L/UyKrDH; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L/UyKrDH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h01LD6s4Cz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 00:05:56 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C3B339;
	Tue, 14 Jul 2026 07:05:21 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A07F3F7B4;
	Tue, 14 Jul 2026 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784037925; bh=xWJCKsvCSbOTf1MrL+nqfsWcuzx4IBI4MMfjRE6PTH4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L/UyKrDH31P2AxfsB5zaY1mh6o9sykjNj6yB/yMXG8ePSNTlccGqvWENIvdaG1tfJ
	 Wk0YZEQWyX1mVS8XhODJBz5n9MI25kkc+YIk8/N9y9yuoLWoSBYTDhb1fyTBkqd7HI
	 cav7VW0lg3rVkGLnx2wAlICXEbNLvp2RP9uBMl74=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:03:51 +0100
Subject: [PATCH 02/22] mm: move mm_flags helpers to mm_types.h
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-2-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=3490;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=xWJCKsvCSbOTf1MrL+nqfsWcuzx4IBI4MMfjRE6PTH4=;
 b=hjHVW6q/l9oVND5egfxNDc6FE64eNht6hv1NYHcLYYfk3GK4zKlatRLYEID3yBr+Cr2y6GvLX
 wE73qcbXnDpDJQn8OyUXgdNbqTA1wZVDqiAytR24UH8BGEWoTGJECyr
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=

Some of the mm_flags helpers are defined in <linux/mm_types.h>,
while others are defined in <linux/mm.h>. We will soon need to call
one of the latter helpers from mm_types.h.

Regroup all the helpers in mm_types.h to keep things simple.

Also remove #include's that were added specifically for these
helpers in mm.h.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h       | 32 --------------------------------
 include/linux/mm_types.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 32bb723ffbb9..7a4b8e7ac8f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -34,8 +34,6 @@
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
 #include <linux/rcuwait.h>
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kcsan-checks.h>
 
@@ -948,36 +946,6 @@ static inline void assert_fault_locked(const struct vm_fault *vmf)
 }
 #endif /* CONFIG_PER_VMA_LOCK */
 
-static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
-{
-	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
-{
-	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
-{
-	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_set(int flag, struct mm_struct *mm)
-{
-	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_clear(int flag, struct mm_struct *mm)
-{
-	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-static inline void mm_flags_clear_all(struct mm_struct *mm)
-{
-	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
-}
-
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b4129beb9c4a..a2e0dc5892ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1414,6 +1414,36 @@ struct mm_struct {
 	char flexible_array[] __aligned(__alignof__(unsigned long));
 };
 
+static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
+{
+	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
+{
+	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
+{
+	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_set(int flag, struct mm_struct *mm)
+{
+	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_clear(int flag, struct mm_struct *mm)
+{
+	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+static inline void mm_flags_clear_all(struct mm_struct *mm)
+{
+	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
+}
+
 /* Copy value to the first system word of mm flags, non-atomically. */
 static inline void __mm_flags_overwrite_word(struct mm_struct *mm, unsigned long value)
 {

-- 
2.51.2


