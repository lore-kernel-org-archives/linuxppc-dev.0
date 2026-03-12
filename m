Return-Path: <linuxppc-dev+bounces-18140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D818A106ACE1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 19:17:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWy6P3D0fz3cZC;
	Fri, 13 Mar 2026 06:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773343021;
	cv=none; b=DZUMt9GpaDtPmx2s0b1MZkhGs2U3NuOB6Irax9BMuB/Fq9Jkp+PrkXHMnX0hFt6bvNddLGssQYcVpaYZkTEgCaXbx37QWIe27gkE4+hhS8Xg7sPWpFW2EEsMge2UIn77mgfARSChZ7qTQ8ebMAgsjLWOZKPFlBe2+YatY0nCghTw/BYUve66q8A/bZ5Sj+5rFWBT/GulFUYsAPW3rViLNo0ymA9NPdEkZf6g76INjmQU4NyTamFL6ibs/5EkPY/PDVwPVXoR5icWzITckdc3ZR85aYxReGpVuquXcauAEdQmSpeZ6Wp3RnykmQ0ZvIezsdJJvQFe54Rmh6BVFuGi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773343021; c=relaxed/relaxed;
	bh=pXNtwefo3DI5PZqVhmiWEXF190WSl3hBxhRdARXxK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgaiGp565Esv736AnEQWc5m4RK8H2zQfvQiS9gHeAi3jpwF5CtPi/O6MFlL3low8atgXlHUxiX5XIrXk1CKEC60/bhbO4o/9/qEbma6XEfzW3Bl74VRExLrMfTtgGqRoR8IJAvCh7a4Zm8wLqZWR5Z9iJ5r21zgQT7hy5DrPoHiNl5UySrHTzWDhdEBrjm+xUEQUGu+6fAlX4rRil3pP7t9j6ZGAL55mje2KFZmd9d+tlmrt0Xc6zJCQBgsQIwKoiEOnrS8LDwJuRLn3jXL30GPoyH1g9WGqe6EzRYe7L4iKOkgjtxLCvAKDwBqF41R/+lK1ZcxDn3kJ0IHOamyQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cEiK7/n4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cEiK7/n4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWy6N4MHbz3cYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 06:17:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3BDB44517;
	Thu, 12 Mar 2026 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126E0C2BC9E;
	Thu, 12 Mar 2026 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343018;
	bh=cMZvtYTbVi8gGI62iqsWZ4caZrMQ/fPLlqyhjNcRyx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEiK7/n40R+U6XNkiSalA/AXJ/bEgYclxYDzCqR94yWMygwmC794VCL0NxoNYMt3J
	 RHgWYcxQkKel2D7y5Qt7KDsDDMbbnor8tS00TxPxTu7yixFOVnFjv/PAKh+RDo3tpd
	 yGc6lmIpIhzsiJVtCyAB02NBMWdKtc6jRMZms3t37fq7iqSAm8xvmcKPPar1qbfOd9
	 EvzQJ8XXrWFAYsPwnjWKyAaJA6DLfoLru6ENVdQxEMDyebpaZ7Ji0O9VLo8T3kTXXo
	 yolKRFYDkMz5uAmNg47v7Mny0fse4ZkcVEuNAaoLI86leo+dqL+SZpfMRoIRQSV5f/
	 wEw5+9/hlVO1A==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 10/20] mm/vma: introduce vma_flags_same[_mask/_pair]()
Date: Thu, 12 Mar 2026 19:16:08 +0000
Message-ID: <64129ea327a7280732291e3481f1fd138aaf4caa.1773342102.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773342102.git.ljs@kernel.org>
References: <cover.1773342102.git.ljs@kernel.org>
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

Add helpers to determine if two sets of VMA flags are precisely the same,
that is - that every flag set one is set in another, and neither contain
any flags not set in the other.

We also introduce vma_flags_same_pair() for cases where we want to compare
two sets of VMA flags which are both non-const values.

Also update the VMA tests to reflect the change, we already implicitly test
that this functions correctly having used it for testing purposes
previously.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 28 ++++++++++++++++++++++++++++
 tools/testing/vma/include/custom.h | 12 ------------
 tools/testing/vma/include/dup.h    | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2c16c744d49d..33d0c2af2c75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1209,6 +1209,34 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+/* Determine if flags and flags_other have precisely the same flags set. */
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/* Determine if flags and flags_other have precisely the same flags set.  */
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Helper macro to determine if only the specific flags are set, e.g.:
+ *
+ * if (vma_flags_same(&flags, VMA_WRITE_BIT) { ... }
+ */
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Helper to test that ALL specified flags are set in a VMA.
  *
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 433b3396c281..92fe156ed7d6 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -99,17 +99,5 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 	if (reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
-
-/* Place here until needed in the kernel code. */
-static __always_inline bool vma_flags_same_mask(vma_flags_t *flags,
-						vma_flags_t flags_other)
-{
-	const unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_other = flags_other.__vma_flags;
-
-	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
-}
-#define vma_flags_same(flags, ...) \
-	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 #define VMA_SPECIAL_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_DONTEXPAND_BIT, \
 				       VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index c3be8a2381e1..fa2df96f9dee 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -951,6 +951,27 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 				     vma_flags_t flags)
 {
-- 
2.53.0


