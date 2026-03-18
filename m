Return-Path: <linuxppc-dev+bounces-18378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C87F103E197
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYG80Nl4z2ynZ;
	Thu, 19 Mar 2026 02:51:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773849072;
	cv=none; b=j7NsJHot8NRiOx8PwFJ7Zvf3JZWDTGYrCCz3T0go3IDez3lDVzLUsg2WDh4MbjhXt2c/8JOdVls52R9W1u+eTq8SQ4v5Xa9l1pjsECs1Kgez49ILRzyhf7ECu+L3gEsvf32qLoM8bvsYKBXWZRKQszvpEcOE/0GkbWbsKrHeh4OlX4CHs8s1lHqEzk8Aef96akfFaL4D20EePpD2CJCofdCNCiDshjjYO75RlNGr3EGNKYY1XeOEXGfwLPU7RXyFNFEM9RLvvWVGBtgI7XKkOKTPK3qDGrQUFbfEr32MU3dOWW5gdErKgcrf+t6Yrkd5v4PARLvo8QbL8PXo4v38Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773849072; c=relaxed/relaxed;
	bh=YPXp+xUw+qiLA4n8LAet54qmXzrkhyXPlTkMGV//3zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE43+GWdVZRBm2t9ucsqpeIK+/nRvmWxO9NjDrij7fqtHD/UrqUN8DZ9CRT++MTIlNLUjp4FqAF4+WzamM2DVtYVwMaasoBt0/NEqDh83VwYKwJ43/S1U1Q0RL1kXULfI+jUnj8y+ur8il2+4o/nDRQDC9TrWgadHahwGhEdGSkAb0vH0F8/GR6PBW8YjK3v97h5Meeb5DFgo6zeZA8fSdWVeFkGT0bNIP/zh75EacDyRaDLBYh7us2GriBC6QP+K4feBT0ksbse3aTBHGgwkyiAcERJp1lO1yCVOiyaiWdNuItw/nQY74BjWFGRo4RautNTgeTGNOK+EoRpW99dhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rmU8NO6l; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rmU8NO6l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYG723mjz2ykX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:51:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3574560123;
	Wed, 18 Mar 2026 15:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF68C2BCB1;
	Wed, 18 Mar 2026 15:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849068;
	bh=8XdVGVcW7Q/NIDMCLqZpb+/JQ5inTXzEVPggkjMwfDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmU8NO6lu68m7dsZm627W2f/PRCpD8agMZwIp+xMIgX3czLSrnNm8zNu3djfRt6xe
	 K7LKrCAiyXun/G+k/XcklluBNhmNgw58TR7VtJEgPXQ0NShUpCjteDW7+kNP25/+sY
	 9Ai7sjoZ1e4/pEsOVNxeuqeSz8JqvGhpTpWpoBfF/kvsWoRc6/xHf4WA4Rk7XFSeIS
	 F3HzRFhNHylMgXuj29cO/H96cAW9cNDQ2yLiWwgiZPsIYY04EPSlgQT3IiNmYdUhMK
	 OtLdkgTgXSMcLSR4tbu8hdjfRD/kZ0UuCJlTEU7HgVskr1JVtwqQK4Lq8IG47CskcN
	 m1/8kOa7UNNvw==
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
Subject: [PATCH v3 10/23] mm/vma: introduce vma_flags_same[_mask/_pair]()
Date: Wed, 18 Mar 2026 15:50:21 +0000
Message-ID: <028d03f1b980b7f65fcc556db2e97224c06af1a6.1773846935.git.ljs@kernel.org>
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

Add helpers to determine if two sets of VMA flags are precisely the same,
that is - that every flag set one is set in another, and neither contain
any flags not set in the other.

We also introduce vma_flags_same_pair() for cases where we want to compare
two sets of VMA flags which are both non-const values.

Also update the VMA tests to reflect the change, we already implicitly
test that this functions correctly having used it for testing purposes
previously.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 28 ++++++++++++++++++++++++++++
 tools/testing/vma/include/custom.h | 11 -----------
 tools/testing/vma/include/dup.h    | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 42d346684678..b170cee95e25 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,6 +1207,34 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
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
index 8f33df02816a..2c498e713fbd 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -102,16 +102,5 @@ static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
 	return PAGE_SIZE;
 }
 
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
index 802b3d97b627..65f630923461 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -954,6 +954,27 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
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


