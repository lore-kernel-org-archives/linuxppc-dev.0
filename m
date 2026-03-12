Return-Path: <linuxppc-dev+bounces-18144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75988106ACDD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 19:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWy6b2Q6Xz3cYK;
	Fri, 13 Mar 2026 06:17:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773343031;
	cv=none; b=cp9DE+s1RXM3DIVxBy3FzkOW2kC+qZYeEMU3gDwKqCTj6U3Ts62nLZWTxEMMzUOfRv0yHI9D0gElKXVmNCs1pwpe8TDiBVIso9xYm5kcpeFyqKLF1COOL/VinSZc7lMf0ZQCfy66UpcXB2Occ3Px0DsKAnmbdSfQkfXJhE/ewXQ/VBwAYBsOlGeplPooIZosRuxorVqZX+2MIktZSk4+pMROMGTg7yZQNiZAzRRyAJNViZfby6+vDni2kpyeY2W/Ee5O03Q8YxS+t1gqB5kbZMokpcUu9m5gyNYm8JeAkvmGajMhxFkpWPJymRjAYUio2dUuQ3ab91wCeaVTNXqTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773343031; c=relaxed/relaxed;
	bh=ZgDko66+4hGUE7qI5wb0JUCmmOUtKO/8i7qOkxmjqLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaheburQDRsyy7yo2LuIPsOVbGJJlR8l/vNAcnhV+giCv8au877WgndOIaFZfn/QNSfc0LjlF9kE1wywfwwMtweu7IVO/ClDDp/I8CMu3dHukJ/GcyLvirBpUCTfDPYIDdIhEyKK1BgQxZhD3vlqhRdMpq5nP9AKL6r8Td/Wf5focoF5cUhqsRxlKPU+5Qv9puBbTCBd0VWtT/nzFRbn47oOsVig4+3EdIhrsLH4wtunzrXrGZG2ogx20+HHlsyZvS+2HOAN+xWsK2ZZamic4EXsMLMXLfjcf/vXo+mGLIcoWAqfQdG/Ewv7EBAeGIXUASNtH3yaWubX3pVjGT+CSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lCzF1EL6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lCzF1EL6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWy6Z49hZz3chy
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 06:17:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E5EA642D7A;
	Thu, 12 Mar 2026 19:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E8BC2BC9E;
	Thu, 12 Mar 2026 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343028;
	bh=i+p3elfatBiwccRrtwrt6PrqJWD9J7hcCLdkdKdPFP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCzF1EL6UxvNJlquvfqUvlI7j5rI7nUseE8n0RKgXj2V/yhEz2VzNeMlMmxytEe2k
	 MLE4/7YKr7+qAcDrU06qTMz0ScZSVc6hv4K0GtRbvY2fUTvzSWbTc+QGHOd5tiRr1I
	 0gG/7Y7g5Znu84JOzEx+LYN+K+6NQpA3xTx16pE+X6wlmlPP6jqJSzUEmLoQT2oWYs
	 k+92/igEcOYF5iRBxNAVus3555sLzV/mfqD8VYURk5hi0o8VzWsAmQP7zEWS0fDHiS
	 3xsezc48bSiMiRz+bMMG+VlJMrP8Y2Hmp0NOic8DObDgCPjNa+qitsFlRod8llDHSG
	 EY+G2NpLC4p2A==
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
Subject: [PATCH 14/20] mm/vma: introduce vma_test[_any[_mask]](), and make inlining consistent
Date: Thu, 12 Mar 2026 19:16:12 +0000
Message-ID: <7b2ad0c46854dc39ba9111ad0e94770e7e1b9f66.1773342102.git.ljs@kernel.org>
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

Introduce helper functions and macros to make it convenient to test flags
and flag masks for VMAs, specifically:

* vma_test() - determine if a single VMA flag is set in a VMA.
* vma_test_any_mask() - determine if any flags in a vma_flags_t value are
			set in a VMA.
* vma_test_any() - Helper macro to test if any of specific flags are set.

Also, there are a mix of 'inline's and '__always_inline's in VMA helper
function declarations, update to consistently use __always_inline.

Finally, update the VMA tests to reflect the changes.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h              | 49 +++++++++++++++++++++-----
 include/linux/mm_types.h        | 12 ++++---
 tools/testing/vma/include/dup.h | 61 +++++++++++++++++++++------------
 3 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 84c7f6ac5790..4b574d941ea3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1013,7 +1013,8 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }
 
-static inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma, vma_flag_t bit)
+static __always_inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma,
+		vma_flag_t bit)
 {
 	const vm_flags_t mask = BIT((__force int)bit);
 
@@ -1028,7 +1029,8 @@ static inline bool __vma_atomic_valid_flag(struct vm_area_struct *vma, vma_flag_
  * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
  * valid flags are allowed to do this.
  */
-static inline void vma_set_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
+static __always_inline void vma_set_atomic_flag(struct vm_area_struct *vma,
+		vma_flag_t bit)
 {
 	unsigned long *bitmap = vma->flags.__vma_flags;
 
@@ -1044,7 +1046,8 @@ static inline void vma_set_atomic_flag(struct vm_area_struct *vma, vma_flag_t bi
  * This is necessarily racey, so callers must ensure that serialisation is
  * achieved through some other means, or that races are permissible.
  */
-static inline bool vma_test_atomic_flag(struct vm_area_struct *vma, vma_flag_t bit)
+static __always_inline bool vma_test_atomic_flag(struct vm_area_struct *vma,
+		vma_flag_t bit)
 {
 	if (__vma_atomic_valid_flag(vma, bit))
 		return test_bit((__force int)bit, &vma->vm_flags);
@@ -1249,13 +1252,41 @@ static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
 #define vma_flags_same(flags, ...) \
 	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+/*
+ * Test whether a specific flag in the VMA is set, e.g.:
+ *
+ * if (vma_test(vma, VMA_READ_BIT)) { ... }
+ */
+static __always_inline bool vma_test(const struct vm_area_struct *vma,
+		vma_flag_t bit)
+{
+	return vma_flags_test(&vma->flags, bit);
+}
+
+/* Helper to test any VMA flags in a VMA . */
+static __always_inline bool vma_test_any_mask(const struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	return vma_flags_test_any_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for testing whether any VMA flags are set in a VMA,
+ * e.g.:
+ *
+ * if (vma_test_any(vma, VMA_IO_BIT, VMA_PFNMAP_BIT,
+ *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
+ */
+#define vma_test_any(vma, ...) \
+	vma_test_any_mask(vma, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Helper to test that ALL specified flags are set in a VMA.
  *
  * Note: appropriate locks must be held, this function does not acquire them for
  * you.
  */
-static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
+static __always_inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 		vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&vma->flags, flags);
@@ -1275,7 +1306,7 @@ static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
  * Note: appropriate locks must be held, this function does not acquire them for
  * you.
  */
-static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 		vma_flags_t flags)
 {
 	vma_flags_set_mask(&vma->flags, flags);
@@ -1305,7 +1336,7 @@ static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
 }
 
 /* Helper to test any VMA flags in a VMA descriptor. */
-static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
+static __always_inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
 	return vma_flags_test_any_mask(&desc->vma_flags, flags);
@@ -1322,7 +1353,7 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
 /* Helper to test all VMA flags in a VMA descriptor. */
-static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+static __always_inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&desc->vma_flags, flags);
@@ -1338,7 +1369,7 @@ static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
 	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
 
 /* Helper to set all VMA flags in a VMA descriptor. */
-static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+static __always_inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
 	vma_flags_set_mask(&desc->vma_flags, flags);
@@ -1355,7 +1386,7 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
 
 /* Helper to clear all VMA flags in a VMA descriptor. */
-static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+static __always_inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
 	vma_flags_clear_mask(&desc->vma_flags, flags);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 63a25f97cd1c..4a229cc0a06b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1101,7 +1101,8 @@ static __always_inline vma_flags_t legacy_to_vma_flags(vm_flags_t flags)
  * IMPORTANT: This does not overwrite bytes past the first system word. The
  * caller must account for this.
  */
-static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_overwrite_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
@@ -1114,7 +1115,8 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
  * IMPORTANT: This does not overwrite bytes past the first system word. The
  * caller must account for this.
  */
-static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_overwrite_word_once(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
@@ -1122,7 +1124,8 @@ static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned lo
 }
 
 /* Update the first system word of VMA flags setting bits, non-atomically. */
-static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_set_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
@@ -1130,7 +1133,8 @@ static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 }
 
 /* Update the first system word of VMA flags clearing bits, non-atomically. */
-static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_clear_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = flags->__vma_flags;
 
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 9a3fb99416d3..70cabacdb9cc 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -765,7 +765,8 @@ static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
  * IMPORTANT: This does not overwrite bytes past the first system word. The
  * caller must account for this.
  */
-static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_overwrite_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	*ACCESS_PRIVATE(flags, __vma_flags) = value;
 }
@@ -776,7 +777,8 @@ static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long va
  * IMPORTANT: This does not overwrite bytes past the first system word. The
  * caller must account for this.
  */
-static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_overwrite_word_once(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
 
@@ -784,7 +786,8 @@ static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned lo
 }
 
 /* Update the first system word of VMA flags setting bits, non-atomically. */
-static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_set_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
 
@@ -792,7 +795,8 @@ static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
 }
 
 /* Update the first system word of VMA flags clearing bits, non-atomically. */
-static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+static __always_inline void vma_flags_clear_word(vma_flags_t *flags,
+		unsigned long value)
 {
 	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
 
@@ -1002,23 +1006,32 @@ static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
 #define vma_flags_same(flags, ...) \
 	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 
-static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
-				     vma_flags_t flags)
+static __always_inline bool vma_test(const struct vm_area_struct *vma,
+		vma_flag_t bit)
 {
-	return vma_flags_test_all_mask(&vma->flags, flags);
+	return vma_flags_test(&vma->flags, bit);
 }
 
-#define vma_test_all(vma, ...) \
-	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
+static __always_inline bool vma_test_any_mask(const struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	return vma_flags_test_any_mask(&vma->flags, flags);
+}
 
-static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
+#define vma_test_any(vma, ...) \
+	vma_test_any_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline bool vma_test_all_mask(const struct vm_area_struct *vma,
+		vma_flags_t flags)
 {
-	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
-		(VM_SHARED | VM_MAYWRITE);
+	return vma_flags_test_all_mask(&vma->flags, flags);
 }
 
-static inline void vma_set_flags_mask(struct vm_area_struct *vma,
-				      vma_flags_t flags)
+#define vma_test_all(vma, ...) \
+	vma_test_all_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
+		vma_flags_t flags)
 {
 	vma_flags_set_mask(&vma->flags, flags);
 }
@@ -1032,8 +1045,8 @@ static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
 	return vma_flags_test(&desc->vma_flags, bit);
 }
 
-static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
-					    vma_flags_t flags)
+static __always_inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
+		vma_flags_t flags)
 {
 	return vma_flags_test_any_mask(&desc->vma_flags, flags);
 }
@@ -1041,7 +1054,7 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_any(desc, ...) \
 	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
 
-static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
+static __always_inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
 		vma_flags_t flags)
 {
 	return vma_flags_test_all_mask(&desc->vma_flags, flags);
@@ -1050,8 +1063,8 @@ static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
 #define vma_desc_test_all(desc, ...) \
 	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
 
-static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
-					   vma_flags_t flags)
+static __always_inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+		vma_flags_t flags)
 {
 	vma_flags_set_mask(&desc->vma_flags, flags);
 }
@@ -1059,8 +1072,8 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
 #define vma_desc_set_flags(desc, ...) \
 	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
 
-static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
-					     vma_flags_t flags)
+static __always_inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+		vma_flags_t flags)
 {
 	vma_flags_clear_mask(&desc->vma_flags, flags);
 }
@@ -1068,6 +1081,12 @@ static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
 #define vma_desc_clear_flags(desc, ...) \
 	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
 
+static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
 static inline bool is_shared_maywrite(const vma_flags_t *flags)
 {
 	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
-- 
2.53.0


