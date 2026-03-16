Return-Path: <linuxppc-dev+bounces-18250-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D27F506D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFmH6mF7z2ywS;
	Tue, 17 Mar 2026 00:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773666559;
	cv=none; b=a5JbnKvra8wWWZhj3ycmYG0eN3qqIT2vns0kbwGorRkAN0mfHKjDm6BJLy4e3Dj3hDzxWgaoZ7+RPrxNmv5hwwn1dlI/kNxli9X2+6jFagTZiwMhFgg8ZBSv6K3gpU19+w3j56KwO2BgOPU6fB2BL88Hc7g7zIa0KuBfnbR0AHMu0F4re2cikMd7CEWs3T7EFnRoAfBJDypFiCVvgzslCQ17Py/8wQJH6lpVBD18UrMvoT2KeAnmBGsPp0Rv2l56aj1/oIuNS4CeLpXx/b0WHm5D6PoCvy6JeeZlRZACeAAt7C7oT2imrZMHwKCQquiA8OvX13lEgqfDjG5OIt1Zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773666559; c=relaxed/relaxed;
	bh=j4kG0RbL3l029ryDrxTmQzkYAT92Dc0c2piFlYr1zFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyGpNyb9dRqy40coJfMX5kCLqnK6r2cDnx583cnpHvrRpBfaf2p0SFVJlxh2t2QejEcRARwQdQYNjpw0BG5ZFyL34+RNX5qi8Fp4Dq7LkzqzG/DACJRksjTR2qOW4WYlwpsD0gy7zBBrGae0BVenIHLrYlP9DNeBN4qtZaENywPrDRH7qNkshNcK/J43oVXexj5TDlQq5Em/OOtAs708uWIPM5sTkkrSioeu0PqQk9olE/oIH+7SpWAYMiukMbYHF4+SnMEMe1Qn4cmO0I6mQ2J/TzolCHa9daI2cpA5YS0zDmJoV7PtNHcQ314191equyzurRtSfsFpe4GH4sXBvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kYw7DD7g; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kYw7DD7g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFmH1sPyz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 00:09:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A2796445BF;
	Mon, 16 Mar 2026 13:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FEDC2BCB1;
	Mon, 16 Mar 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666557;
	bh=VG9qmmmFOegmFxOvw//0MFdBoWLaQ29ukQyS87tCN9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYw7DD7gHjlD8HQJ1arhnEYfasRRA/k4Bstjh5nze0eUneMwI7Gat2tEEico37Joq
	 YFLs6klU3jz97aBpGDKboLlJ4lZ8/Yi1vy11O1+GuvU9L5qByshxed7GjngGpUWAfa
	 8VQJ2KI6kNkiHuDMI+sUWk7sKWjH9XpgcxRvHBw1PgPTCh+Wllm4lHTjPLxF4v+no6
	 UfyF4AvrJ9cWuhh94T0mwyeRO7Z/PcFvTv5c9oCskCIS8sQxvubdRAPlzoanyeqmu5
	 MsmeTurX8AaYhahNG8wyPPMrR1L+jCuqqomTjL79sIBu3wRVDMEUb+CXX69VnE9mBS
	 e6f2HZNziUBqA==
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
Subject: [PATCH v2 08/23] tools/testing/vma: add simple test for append_vma_flags()
Date: Mon, 16 Mar 2026 13:07:57 +0000
Message-ID: <8253a553f354e6ef9b1ddea4831c0033e64eb796.1773665966.git.ljs@kernel.org>
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

Add a simple test for append_vma_flags() to assert that it behaves as
expected.

Additionally, include the VMA_REMAP_FLAGS definition in the VMA tests to
allow us to use this value in the testing.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/include/dup.h |  3 +++
 tools/testing/vma/tests/vma.c   | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index cbdeb03ee7e5..47ad01c5d15e 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -345,6 +345,9 @@ enum {
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+#define VMA_REMAP_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_PFNMAP_BIT,	\
+				     VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)
+
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
 #define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
 #define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index feea6d270233..98e465fb1bf2 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -555,6 +555,30 @@ static bool test_vma_flags_and(void)
 	return true;
 }
 
+/* Ensure append_vma_flags() acts as expected. */
+static bool test_append_vma_flags(void)
+{
+	vma_flags_t flags = append_vma_flags(VMA_REMAP_FLAGS, VMA_READ_BIT,
+					     VMA_WRITE_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					     , 64, 65
+#endif
+		);
+
+	ASSERT_FLAGS_SAME(&flags, VMA_IO_BIT, VMA_PFNMAP_BIT,
+			  VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT, VMA_READ_BIT,
+			  VMA_WRITE_BIT
+#if NUM_VMA_FLAG_BITS > 64
+					     , 64, 65
+#endif
+		);
+
+	flags = append_vma_flags(EMPTY_VMA_FLAGS, VMA_READ_BIT, VMA_WRITE_BIT);
+	ASSERT_FLAGS_SAME(&flags, VMA_READ_BIT, VMA_WRITE_BIT);
+
+	return true;
+}
+
 static void run_vma_tests(int *num_tests, int *num_fail)
 {
 	TEST(copy_vma);
@@ -569,4 +593,5 @@ static void run_vma_tests(int *num_tests, int *num_fail)
 	TEST(vma_flags_empty);
 	TEST(vma_flags_diff);
 	TEST(vma_flags_and);
+	TEST(append_vma_flags);
 }
-- 
2.53.0


