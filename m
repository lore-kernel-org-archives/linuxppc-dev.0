Return-Path: <linuxppc-dev+bounces-18258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54432F506CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:11:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFmk73wzz2yh4;
	Tue, 17 Mar 2026 00:09:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773666582;
	cv=none; b=LdnQrVH7PZIHz0cc8j7RECsRNLpsxm3k+blVp9xGgSJQrZQz1CFxEMdYo7q8cQ5CdIdEkWkbT5wANp6gqo4OZgsMT2+L5KC77BdM25OcM2Bn9PxjvzUoipRP6ztCk20zlKW/oIg/5Ko97ypHE0QSU12ANE+sWVVxXNGbTvzjqgmOaX0bPmMGKhVZ6jCcFIvVAUDecgTtb87NY+FMtRr6oc01gKf1+a5MPV8CyfOwc2/RFl55+kFGceTqKV/AsHYu0t1abZq+/mb1AclQlvGD3dtktxQeNZ/qYL6X9dywOdnlaaIelonsCAj6PuWOp0JObFYcJCU8jFZnA/9SOt0Hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773666582; c=relaxed/relaxed;
	bh=96FoYXx5DdJNjnJjdiL9x4rpswYHhSc9RCyN6+I8ZG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYSNq2BeXgSwbqQP/8OZpBCnZSWRaEvFSpM463g+JmaEkZkB4W1WlqDK/w7zjajPyd3QHwXslBbUK8hiF2ywpASJasigAiqlnOEpILeCg+9fhez4qQ3G4MpZIkuVjxURTVwwV4hrFP85tO1tVmYYY0eThl2LdZTcviRFCz2SeTkLj0zIrrO9lSiYzVZf3KHyH3quCgFVkv+lgpESEEoh1mmetPRXCYcG9IpwEGjWYt9Aa3a+XZehz7qkzilea3+IXNKR3X445Csszl62vqvfVcUixHWFYi4T5fvVr25Q47f+aRDB4WnR00f+BoZgJSWsZThkXpxMLSPrH7kFtYG1vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TJG/Go8A; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TJG/Go8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFmk2FJkz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 00:09:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B9356111A;
	Mon, 16 Mar 2026 13:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4350FC19424;
	Mon, 16 Mar 2026 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666579;
	bh=dLJAyLW52YxQ0AN/NeuZQy3GzYiIO3sQ/ClSljBmA2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJG/Go8A1cY8XS5/cAwBFroFXuBNyK85BM7BXdepftLaaH0hgiTtnWt94hTv5NzQk
	 mi9JB6jBKDTXIVd1hpifEwkrt4trzZ01AHPVwLAJZGZsYdYo/sYYijNdcV3kU2ycvb
	 xS3rsbNrAw2IJTDx0eyKMX4KxE17kIEKHD1bLFjVP8xJBSvxRirbu4wU6Ek2CSMghZ
	 IBkA/mfuSfU/btp4YszcI4RKptelvWUc4mAENue7y7fw0OdVRAlzoR+tvmrvu6llBa
	 hjs0IVHsjxs08YA4JEMwdB9gsTNAPwrbsSRB3yRw4iEgqXIW8+N4/BZ0XXiWAtToyu
	 vrXuiockp9v1A==
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
Subject: [PATCH v2 16/23] tools/testing/vma: test vma_flags_count,vma[_flags]_test_single_mask
Date: Mon, 16 Mar 2026 13:08:05 +0000
Message-ID: <140b9b77da1ef463f969cbeb2b5fb25627301cd6.1773665966.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
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

Update the VMA tests to assert that vma_flags_count() behaves as expected,
as well as vma_flags_test_single_mask() and vma_test_single_mask().

For the test functions we can simply update the existing vma_test(), et
al. test to also test the single_mask variants.

We also add some explicit testing of an empty VMA flag to this test to
ensure this is handled properly.

In order to test vma_flags_count() we simply take an existing set of flags
and gradually remove flags ensuring the count remains as expected
throughout.

We also update the vma[_flags]_test_all() tests to make clear the semantics
that we expect vma[_flags]_test_all(..., EMPTY_VMA_FLAGS) to return true,
as trivially, all flags of none are always set in VMA flags.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 63 ++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 1395d55a1e02..c73c3a565f1d 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -174,10 +174,10 @@ static bool test_vma_flags_word(void)
 /* Ensure that vma_flags_test() and friends works correctly. */
 static bool test_vma_flags_test(void)
 {
-	const vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
-					       VMA_EXEC_BIT
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					 VMA_EXEC_BIT
 #if NUM_VMA_FLAG_BITS > 64
-					       , 64, 65
+					 , 64, 65
 #endif
 		);
 	struct vm_area_desc desc = {
@@ -187,14 +187,18 @@ static bool test_vma_flags_test(void)
 		.flags = flags,
 	};
 
-#define do_test(_flag)					\
-	ASSERT_TRUE(vma_flags_test(&flags, _flag));	\
-	ASSERT_TRUE(vma_test(&vma, _flag));		\
+#define do_test(_flag)							    \
+	ASSERT_TRUE(vma_flags_test(&flags, _flag));			    \
+	ASSERT_TRUE(vma_flags_test_single_mask(&flags, mk_vma_flags(_flag))); \
+	ASSERT_TRUE(vma_test(&vma, _flag));				    \
+	ASSERT_TRUE(vma_test_single_mask(&vma, mk_vma_flags(_flag)));	    \
 	ASSERT_TRUE(vma_desc_test(&desc, _flag))
 
-#define do_test_false(_flag)				\
-	ASSERT_FALSE(vma_flags_test(&flags, _flag));	\
-	ASSERT_FALSE(vma_test(&vma, _flag));		\
+#define do_test_false(_flag)						     \
+	ASSERT_FALSE(vma_flags_test(&flags, _flag));			     \
+	ASSERT_FALSE(vma_flags_test_single_mask(&flags, mk_vma_flags(_flag))); \
+	ASSERT_FALSE(vma_test(&vma, _flag));				     \
+	ASSERT_FALSE(vma_test_single_mask(&vma, mk_vma_flags(_flag)));	     \
 	ASSERT_FALSE(vma_desc_test(&desc, _flag))
 
 	do_test(VMA_READ_BIT);
@@ -212,6 +216,15 @@ static bool test_vma_flags_test(void)
 #undef do_test
 #undef do_test_false
 
+	/* We define the _single_mask() variants to return false if empty. */
+	ASSERT_FALSE(vma_flags_test_single_mask(&flags, EMPTY_VMA_FLAGS));
+	ASSERT_FALSE(vma_test_single_mask(&vma, EMPTY_VMA_FLAGS));
+	/* Even when both flags and tested flag mask are empty! */
+	flags = EMPTY_VMA_FLAGS;
+	vma.flags = EMPTY_VMA_FLAGS;
+	ASSERT_FALSE(vma_flags_test_single_mask(&flags, EMPTY_VMA_FLAGS));
+	ASSERT_FALSE(vma_test_single_mask(&vma, EMPTY_VMA_FLAGS));
+
 	return true;
 }
 
@@ -309,6 +322,10 @@ static bool test_vma_flags_test_any(void)
 	do_test(VMA_READ_BIT, VMA_WRITE_BIT, VMA_EXEC_BIT, 64, 65);
 #endif
 
+	/* Testing all flags against none trivially succeeds. */
+	ASSERT_TRUE(vma_flags_test_all_mask(&flags, EMPTY_VMA_FLAGS));
+	ASSERT_TRUE(vma_test_all_mask(&vma, EMPTY_VMA_FLAGS));
+
 #undef do_test
 #undef do_test_all_true
 #undef do_test_all_false
@@ -592,6 +609,33 @@ static bool test_append_vma_flags(void)
 	return true;
 }
 
+/* Assert that vma_flags_count() behaves as expected. */
+static bool test_vma_flags_count(void)
+{
+	vma_flags_t flags = mk_vma_flags(VMA_READ_BIT, VMA_WRITE_BIT,
+					 VMA_EXEC_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					 , 64, 65
+#endif
+		);
+
+#if NUM_VMA_FLAG_BITS > 64
+	ASSERT_EQ(vma_flags_count(&flags), 5);
+	vma_flags_clear(&flags, 64);
+	ASSERT_EQ(vma_flags_count(&flags), 4);
+	vma_flags_clear(&flags, 65);
+#endif
+	ASSERT_EQ(vma_flags_count(&flags), 3);
+	vma_flags_clear(&flags, VMA_EXEC_BIT);
+	ASSERT_EQ(vma_flags_count(&flags), 2);
+	vma_flags_clear(&flags, VMA_WRITE_BIT);
+	ASSERT_EQ(vma_flags_count(&flags), 1);
+	vma_flags_clear(&flags, VMA_READ_BIT);
+	ASSERT_EQ(vma_flags_count(&flags), 0);
+
+	return true;
+}
+
 static void run_vma_tests(int *num_tests, int *num_fail)
 {
 	TEST(copy_vma);
@@ -607,4 +651,5 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(vma_flags_diff);
 	TEST(vma_flags_and);
 	TEST(append_vma_flags);
+	TEST(vma_flags_count);
 }
-- 
2.53.0


