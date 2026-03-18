Return-Path: <linuxppc-dev+bounces-18387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4BA103E198
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:53:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYGd0XZtz2ypw;
	Thu, 19 Mar 2026 02:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773849097;
	cv=none; b=aq+ehIm6dgamfey45e9BGE3TAcftAxh9WnD7m5tIYjQAdIt1mswueB4R0W8AMIwPkdHMqK7GXblrBefH7voWYUC+k+qEepEdtrKkk2Zi6DDl3op9ysZ0/mDQN7K318aF0f2dDUOzpFYtwa6L96WtFV6HdJ7GbMgDIgA49vfahWPDr8yvV8efsdk3OLEodMBt9cMsj+uRmR03aAQXNRFxJFZmNwAnJ1ck+oNEsoOd0z0XlryZ0aodAM5a/3/kFKgXUJ3V922jlCL3bsJLRfl8blDfBzZklSwRH1whBuMQ9TKuRRLCz2eJO9JOn9Dfrkz61f3QIEsEXP9G1lAtoG+HCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773849097; c=relaxed/relaxed;
	bh=glto3nNF1o9CHd2IWYLUNY37G4HJU66Jefs9tYxHtxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJovdJBuhTLzKKI9XvubSSv8TwiWBHNnTClMPjvkyXZSB9/5Ib5May3lmJFqK+6/Xrt+JR5AwoQaUWHbS28fNk0SfL95vnEv/8JjATaGVoQZ+pP9S8CgWI48wkjpFi+e5wvB6Xt0qAdyXB+Dc+4ZrxwN4J4dmkQltUZ8LW1+Gz5mCuIcJ7HsFc3Z4N3UUjC7fX0nHdrdBGUIVkdsflyFwaTf844zDv2YLUzjVfGQLGv17pvMOdUciWYS2uMQUyWt/fzXqfxAvtliWAw65M8SCyne2jKdrXfZUPE7YHfsGfP7eVD+l6cnKnEDHsPb+kLp/segwQb+jq3ZRqFIBKviKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kDPMxDLz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kDPMxDLz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYGc1t3Zz3bgl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:51:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A4DEE43584;
	Wed, 18 Mar 2026 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB3EC2BCB2;
	Wed, 18 Mar 2026 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849094;
	bh=150j1rGpWka5LRXWKCunu72PErJxZ/dfG4LF16Tl7W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDPMxDLzDvDDTbMPL2/3zxMJcUyos/Kd1krK7p0PTRGQJegUO1mUk5Q5Xf1QCFPHh
	 cmOM/2QPFmFxh9bxIBrCqlkQp3t2DXUBsQN7TiLXICJj27sUQSjx5hD01nv0TYVNLa
	 po/CcfNmhBTzUUuinyzxLAsS5JsdajCIt8aA4k9S4kkfSaWKlUeE93uFoI6TaABUJy
	 FP1L6CjQjhQ8349B9Yf6djzVckaaM9suzrhHQ4HkUvJTJ4WYydMQPStHwmL7Rby5NI
	 FLVa5pmYi3r1kS84AhGJs+gxE9WLqEykq5Z4i1FB4hnpQOB7ih2wwMO94sdFH7a9b+
	 De0uTburJz5FQ==
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
Subject: [PATCH v3 19/23] mm/vma: introduce vma_clear_flags[_mask]()
Date: Wed, 18 Mar 2026 15:50:30 +0000
Message-ID: <b2edda6f00c10ef63013257f282cf155fb371b06.1773846935.git.ljs@kernel.org>
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

Introduce a helper function and helper macro to easily clear a VMA's flags
using the new vma_flags_t vma->flags field:

* vma_clear_flags_mask() - Clears all of the flags in a specified mask in
			   the VMA's flags field.
* vma_clear_flags() - Clears all of the specified individual VMA flag bits
		      in a VMA's flags field.

Also update the VMA tests to reflect the change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h              | 16 ++++++++++++++++
 tools/testing/vma/include/dup.h |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb1cbb60e63b..4ba1229676ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1368,6 +1368,22 @@ static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+/* Helper to clear all VMA flags in a VMA. */
+static __always_inline void vma_clear_flags_mask(struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	vma_flags_clear_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for clearing VMA flags, e.g.:
+ *
+ * vma_clear_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_clear_flags(vma, ...) \
+	vma_clear_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Test whether a specific VMA flag is set in a VMA descriptor, e.g.:
  *
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 36373b81ad24..93ea600d0895 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1065,6 +1065,15 @@ static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline void vma_clear_flags_mask(struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	vma_flags_clear_mask(&vma->flags, flags);
+}
+
+#define vma_clear_flags(vma, ...) \
+	vma_clear_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
 static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
 		vma_flag_t bit)
 {
-- 
2.53.0


