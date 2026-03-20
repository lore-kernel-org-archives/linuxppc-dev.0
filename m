Return-Path: <linuxppc-dev+bounces-18505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403EE1099B41
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 19:39:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fctD74wvLz2yrX;
	Sat, 21 Mar 2026 06:39:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774035543;
	cv=none; b=Xc7cGnYthVIGa44cqiB7ayx4Lc02xHuJEepIbDSIIUmL395txQhn5TlpnXV72tQ09rrjYnyPe5TZKfo+O4COILqakdGEoX6wmYldCD2jnh5nG3AQblzmPtmNQnk6esv9gkceIQfXclNmvK7NCN7TTRFjLXklxFkYHx4ZNFp32bR1K/BAGU5svJTFyK6nOm7LRWwpoNlaerdn8AhhIKqZV2D4U4PlvvdqnkRkzjJXkDNPwSy9Vb91a7zltcBSdC/vQODM0i/+ICG15OYqUh/4kGau3Kf/RISR7Lmc9euPh71CjyBXWkPyqQTgzP/rbp85Geo+nBHGU+sxXvAOT5gWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774035543; c=relaxed/relaxed;
	bh=XyWoGHB40e9zmtkAnucvBo3IE3FL6byo69xHowl4Y+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh+NJPWj6xPmeTgxkyv6cvGakKHOO9LDJC3QNu3UJ8hkIivdbsJHNPZzRqZdK6lkXnPpzUfCttWYWv/Jl6lrccblA6QjyuS5XjdKNyWJ+VEo+ujClAo35HE78hxq3PR2C1QrNCWkDnOKathsMQo888IdP7PoICeycl6wvhFQvjdMC82Ph3e/3YSTXjKWEvxnIRMvP6ixqxuPsfAvZFG4JdSKmE49sWXrEPxtzoKPM/fhE1kl65nuxJkph81RrG2isO5GqD4hGx6JW0EZ985VZK/gdIeRB/ecWLlJdnwmiT79PG1kcoFUZhMJcd4P0+ThpQ1m/DSNYHrN+W83AU2XxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ToLKN4Ld; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ToLKN4Ld;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fctD65GGgz2yth
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 06:39:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ADCB740A5D;
	Fri, 20 Mar 2026 19:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151A4C2BC9E;
	Fri, 20 Mar 2026 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035540;
	bh=sXTA38aR3D+fdGqayQPYQbnT5BeFDDGI8fzyIj7UQaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToLKN4LdRy/Yot9TTIAdSY4cMg3CRRBLRgytOAJucgA33r+R+0vA/TdgQsNZPLxQn
	 avQJPW3vKGw8oOpx49wdKb9uOuHiEa7Av6hWoy5iuFdzQeK/+6sPLtjkZIn8ktN0dd
	 dqtjl4IMAAJhRVkI8Y3x1zE/Q4qAdAtXELuSIE5yO4Qyqu+Eao/rrTdyCEPUAUFCiV
	 I4VSSfYmE62hWPReVjZAQMid3+9ZI6+LCkLWGP5GWlxcDUk3M1zOOe5WVL4Z7Jt1mH
	 Ly2V/v2YXbL4hTHoFX8kTaOx9vIKExQkydA8j4ooRm+7m4NeyDlmKjEoHEG/wzwYsF
	 +mFTHEFlSr9/Q==
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
Subject: [PATCH v4 06/25] tools/testing/vma: fix VMA flag tests
Date: Fri, 20 Mar 2026 19:38:23 +0000
Message-ID: <b19c63af3d5efdfe712bf5d5f89368a5360a60f7.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
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

The VMA tests are incorrectly referencing NUM_VMA_FLAGS, which doesn't
exist, rather they should reference NUM_VMA_FLAG_BITS.

Additionally, remove the custom-written implementation of __mk_vma_flags()
as this means we are not testing the code as present in the kernel, rather
add the actual __mk_vma_flags() to dup.h and add #ifdef's to handle
declarations differently depending on NUM_VMA_FLAG_BITS.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/include/custom.h | 19 -------
 tools/testing/vma/include/dup.h    | 21 ++++++-
 tools/testing/vma/tests/vma.c      | 88 +++++++++++++++++++++++++-----
 3 files changed, 92 insertions(+), 36 deletions(-)

diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 7cdd0f60600a..8f33df02816a 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -29,8 +29,6 @@ extern unsigned long dac_mmap_min_addr;
  */
 #define pr_warn_once pr_err
 
-#define pgtable_supports_soft_dirty() 1
-
 struct anon_vma {
 	struct anon_vma *root;
 	struct rb_root_cached rb_root;
@@ -99,23 +97,6 @@ static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 		refcount_set(&vma->vm_refcnt, 0);
 }
 
-static __always_inline vma_flags_t __mk_vma_flags(size_t count,
-		const vma_flag_t *bits)
-{
-	vma_flags_t flags;
-	int i;
-
-	/*
-	 * For testing purposes: allow invalid bit specification so we can
-	 * easily test.
-	 */
-	vma_flags_clear_all(&flags);
-	for (i = 0; i < count; i++)
-		if (bits[i] < NUM_VMA_FLAG_BITS)
-			vma_flags_set_flag(&flags, bits[i]);
-	return flags;
-}
-
 static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
 {
 	return PAGE_SIZE;
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 65134303b645..3005e33d1ede 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -854,10 +854,21 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma_flags_clear_word(&vma->flags, flags);
 }
 
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits);
+static __always_inline vma_flags_t __mk_vma_flags(size_t count,
+		const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flags_set_flag(&flags, bits[i]);
+
+	return flags;
+}
 
-#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
-					 (const vma_flag_t []){__VA_ARGS__})
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__),	\
+		(const vma_flag_t []){__VA_ARGS__})
 
 static __always_inline bool vma_flags_test(const vma_flags_t *flags,
 		vma_flag_t bit)
@@ -1390,3 +1401,7 @@ static inline int get_sysctl_max_map_count(void)
 {
 	return READ_ONCE(sysctl_max_map_count);
 }
+
+#ifndef pgtable_supports_soft_dirty
+#define pgtable_supports_soft_dirty()	IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
+#endif
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index b2f068c3d6d0..feea6d270233 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -5,11 +5,11 @@ static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
 	const unsigned long legacy_val = legacy_flags;
 	/* The lower word should contain the precise same value. */
 	const unsigned long flags_lower = flags.__vma_flags[0];
-#if NUM_VMA_FLAGS > BITS_PER_LONG
+#if NUM_VMA_FLAG_BITS > BITS_PER_LONG
 	int i;
 
 	/* All bits in higher flag values should be zero. */
-	for (i = 1; i < NUM_VMA_FLAGS / BITS_PER_LONG; i++) {
+	for (i = 1; i < NUM_VMA_FLAG_BITS / BITS_PER_LONG; i++) {
 		if (flags.__vma_flags[i] != 0)
 			return false;
 	}
@@ -116,6 +116,7 @@ static bool test_vma_flags_cleared(void)
 	return true;
 }
 
+#if NUM_VMA_FLAG_BITS > 64
 /*
  * Assert that VMA flag functions that operate at the system word level function
  * correctly.
@@ -124,10 +125,14 @@ static bool test_vma_flags_word(void)
 {
 	vma_flags_t flags = EMPTY_VMA_FLAGS;
 	const vma_flags_t comparison =
-		mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT, 64, 65);
+		mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT
+
+			     , 64, 65
+			);
 
 	/* Set some custom high flags. */
 	vma_flags_set(&flags, 64, 65);
+
 	/* Now overwrite the first word. */
 	vma_flags_overwrite_word(&flags, VM_READ | VM_WRITE);
 	/* Ensure they are equal. */
@@ -158,12 +163,17 @@ static bool test_vma_flags_word(void)
 
 	return true;
 }
+#endif /* NUM_VMA_FLAG_BITS > 64 */
 
 /* Ensure that vma_flags_test() and friends works correctly. */
 static bool test_vma_flags_test(void)
 {
 	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					       VMA_EXEC_BIT, 64, 65);
+					       VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
 	struct vm_area_desc desc = {
 		.vma_flags = flags,
 	};
@@ -198,7 +208,11 @@ static bool test_vma_flags_test(void)
 static bool test_vma_flags_test_any(void)
 {
 	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					       VMA_EXEC_BIT, 64, 65);
+					       VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
 	struct vm_area_struct vma;
 	struct vm_area_desc desc;
 
@@ -224,10 +238,12 @@ static bool test_vma_flags_test_any(void)
 	do_test(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
 	/* However, the ...test_all() variant should NOT pass. */
 	do_test_all_false(VMA_READ_BIT, VMA_MAYREAD_BIT, VMA_SEQ_READ_BIT);
+#if NUM_VMA_FLAG_BITS > 64
 	/* But should pass for flags present. */
 	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
 	/* Also subsets... */
 	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64);
+#endif
 	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
 	do_test_all_true(VMA_READ_BIT, VMA_WRITE_BIT);
 	do_test_all_true(VMA_READ_BIT);
@@ -291,8 +307,16 @@ static bool test_vma_flags_test_any(void)
 static bool test_vma_flags_clear(void)
 {
 	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					 VMA_EXEC_BIT, 64, 65);
-	vma_flags_t mask = mk_vma_flags(VMA_EXEC_BIT, 64);
+					 VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
+	vma_flags_t mask = mk_vma_flags(VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					, 64
+#endif
+		);
 	struct vm_area_struct vma;
 	struct vm_area_desc desc;
 
@@ -303,6 +327,7 @@ static bool test_vma_flags_clear(void)
 	vma_flags_clear_mask(&flags, mask);
 	vma_flags_clear_mask(&vma.flags, mask);
 	vma_desc_clear_flags_mask(&desc, mask);
+#if NUM_VMA_FLAG_BITS > 64
 	ASSERT_FALSE(vma_flags_test_any(&flags, VMA_EXEC_BIT, 64));
 	ASSERT_FALSE(vma_flags_test_any(&vma.flags, VMA_EXEC_BIT, 64));
 	ASSERT_FALSE(vma_desc_test_any(&desc, VMA_EXEC_BIT, 64));
@@ -310,6 +335,7 @@ static bool test_vma_flags_clear(void)
 	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
 	vma_set_flags(&vma, VMA_EXEC_BIT, 64);
 	vma_desc_set_flags(&desc, VMA_EXEC_BIT, 64);
+#endif
 
 	/*
 	 * Clear the flags and assert clear worked, then reset flags back to
@@ -330,20 +356,27 @@ static bool test_vma_flags_clear(void)
 	do_test_and_reset(VMA_READ_BIT);
 	do_test_and_reset(VMA_WRITE_BIT);
 	do_test_and_reset(VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
 	do_test_and_reset(64);
 	do_test_and_reset(65);
+#endif
 
 	/* Two flags, in different orders. */
 	do_test_and_reset(VMA_READ_BIT, VMA_WRITE_BIT);
 	do_test_and_reset(VMA_READ_BIT, VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
 	do_test_and_reset(VMA_READ_BIT, 64);
 	do_test_and_reset(VMA_READ_BIT, 65);
+#endif
 	do_test_and_reset(VMA_WRITE_BIT, VMA_READ_BIT);
 	do_test_and_reset(VMA_WRITE_BIT, VMA_EXEC_BIT);
+#if NUM_VMA_FLAG_BITS > 64
 	do_test_and_reset(VMA_WRITE_BIT, 64);
 	do_test_and_reset(VMA_WRITE_BIT, 65);
+#endif
 	do_test_and_reset(VMA_EXEC_BIT, VMA_READ_BIT);
 	do_test_and_reset(VMA_EXEC_BIT, VMA_WRITE_BIT);
+#if NUM_VMA_FLAG_BITS > 64
 	do_test_and_reset(VMA_EXEC_BIT, 64);
 	do_test_and_reset(VMA_EXEC_BIT, 65);
 	do_test_and_reset(64, VMA_READ_BIT);
@@ -354,6 +387,7 @@ static bool test_vma_flags_clear(void)
 	do_test_and_reset(65, VMA_WRITE_BIT);
 	do_test_and_reset(65, VMA_EXEC_BIT);
 	do_test_and_reset(65, 64);
+#endif
 
 	/* Three flags. */
 
@@ -367,7 +401,11 @@ static bool test_vma_flags_clear(void)
 static bool test_vma_flags_empty(void)
 {
 	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					 VMA_EXEC_BIT, 64, 65);
+					 VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
 
 	ASSERT_FLAGS_NONEMPTY(&flags);
 	vma_flags_clear(&flags, VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT);
@@ -386,10 +424,19 @@ static bool test_vma_flags_empty(void)
 static bool test_vma_flags_diff(void)
 {
 	vma_flags_t flags1 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					  VMA_EXEC_BIT, 64, 65);
+					  VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
+
 	vma_flags_t flags2 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
 					  VMA_EXEC_BIT, VMA_MAYWRITE_BIT,
-					  VMA_MAYEXEC_BIT, 64, 65, 66, 67);
+					  VMA_MAYEXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					  , 64, 65, 66, 67
+#endif
+		);
 	vma_flags_t diff = vma_flags_diff_pair(&flags1, &flags2);
 
 #if NUM_VMA_FLAG_BITS > 64
@@ -432,12 +479,23 @@ static bool test_vma_flags_diff(void)
 static bool test_vma_flags_and(void)
 {
 	vma_flags_t flags1 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					  VMA_EXEC_BIT, 64, 65);
+					  VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					       , 64, 65
+#endif
+		);
 	vma_flags_t flags2 = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
 					  VMA_EXEC_BIT, VMA_MAYWRITE_BIT,
-					  VMA_MAYEXEC_BIT, 64, 65, 66, 67);
-	vma_flags_t flags3 = mk_vma_flags(VMA_IO_BIT, VMA_MAYBE_GUARD_BIT,
-					  68, 69);
+					  VMA_MAYEXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					  , 64, 65, 66, 67
+#endif
+		);
+	vma_flags_t flags3 = mk_vma_flags(VMA_IO_BIT, VMA_MAYBE_GUARD_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					  , 68, 69
+#endif
+		);
 	vma_flags_t and = vma_flags_and_mask(&flags1, flags2);
 
 #if NUM_VMA_FLAG_BITS > 64
@@ -502,7 +560,9 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(copy_vma);
 	TEST(vma_flags_unchanged);
 	TEST(vma_flags_cleared);
+#if NUM_VMA_FLAG_BITS > 64
 	TEST(vma_flags_word);
+#endif
 	TEST(vma_flags_test);
 	TEST(vma_flags_test_any);
 	TEST(vma_flags_clear);
-- 
2.53.0


