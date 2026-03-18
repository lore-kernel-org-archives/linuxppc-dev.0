Return-Path: <linuxppc-dev+bounces-18376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7341103E19F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:51:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYG14zkNz2yks;
	Thu, 19 Mar 2026 02:51:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773849065;
	cv=none; b=iUJSnxPZSPkiNP8I9LSHpctnvLJTFdoKWLBeIZLfI96b9a60ZnI2SjjGiSt+cscOxprlRzNxDQMbcnlB3t0eQYm9AxIz1xXFvl3arWutVGmh46ZADSrwH7azpM9lXEPARUqr6QO+ULfDnM2+/sG3X+fycaVOtvLuHh54PCfcAOmSMfzjMKLdKbmsozKKUJeNywZyoBhAYcCFmj/ikBe5ZgF4788ebaGHNi8bw34I4BCltpcUv7RTL8TeuKoLe9C6AjDA7+i+Div0+/Hzuj+TbwBoJWm5JdL8A2D4D+TzB39WkgJrj3rmS4UBUVcNJarakBHX5EKiTcmyml34qRsq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773849065; c=relaxed/relaxed;
	bh=qw1fJgZxAmJTvtiklKZgUvTgS9NPkNuogar+KC9Y62Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8TY8Ecx+ziUloV7dsVqGeY+fDtFMVAL+VIktn1TlZAMQNm4TPVO+cWj+191WuxJNk+8L/r+SmTeWH19BC4FQxX6RnCbxyNsdTVYtG8x0+w6WSa6l+ZKCHyLV9wTU6njc3QjcJucb3Xt+coHQv7au2z7EdkoGLD49p3kIOeA6jNLJWCF9/FDMT5U2tcV+kXCXOslRzxulEVk+KLtCsF2Stq1rblAZzmA79W13ymm7SHcQmIwDGJXB5Pq1wMqeczFxBqlewlIkp+QGjPwEGyJvtSt/YPRgnmhoudmDOFsMF6vluo4w1kQOLMZ5RuoZOHNRj3jIljlobtNxlMKUAS/tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bHv9eKMO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bHv9eKMO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYG10NY4z2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:51:05 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 67F6F43699;
	Wed, 18 Mar 2026 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66852C19421;
	Wed, 18 Mar 2026 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849063;
	bh=CbVUiCL/t2srd5zwtc07H5gs2GSHrFH2Iq8wD8euBls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHv9eKMOTXaW3e/PYMPxcSHWVbRiZhQ2ghRjhPQUitNyovT4KZngeu2a1vjTY8Op5
	 lGNzeo0DREgBbiCFv14zlBUPG/gA0kAJZzZzi4i/Pkvtt9H09VRFYUN6bXgy1G2x64
	 3173p7qWD6AkcIreGBb5olInwOQ7hBrqYiyyw8Yinj/GHk3//U8WI09jLtEjpRWIkq
	 rHzSgCbquZCEMB3jVvJf48OOM1pipHJrMdcyLR7a+fcC0W/EmjsJkbz9+rF0gh0H6Y
	 Scgj1UdqYBQfQWuQNWayII7hcsPtkW8/pzt+8mSwjjI+QItn6+vZ3tUfH2p+GxFdeI
	 01txAq3SyTVRQ==
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
Subject: [PATCH v3 08/23] tools/testing/vma: add simple test for append_vma_flags()
Date: Wed, 18 Mar 2026 15:50:19 +0000
Message-ID: <45960c2380b7dd30571fa7e082a16da016a7f53e.1773846935.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773846935.git.ljs@kernel.org>
References: <cover.1773846935.git.ljs@kernel.org>
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
index a2f311b5ea82..802b3d97b627 100644
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


