Return-Path: <linuxppc-dev+bounces-18386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB3E103E198
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 15:52:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbYGZ2grxz2yng;
	Thu, 19 Mar 2026 02:51:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773849094;
	cv=none; b=RxHEj9MUPcRA/4CRb/1HGlVmIuyTDnnExpLbkJ+1Tals3y50eTTvDL65N3V3wRpke1HVj6ln5aYIQApiOePnJ+JDUOXviNlhJgCQ7dqSofjjulA8a0epAhG7a+H78DEKpmu9HRHeEfBAh8unkx/fMSDchDBiQkDUHpOp+zonfF2V/NWJJqRNt8Tuu+KpVUoxBNhXF15Z/NecCySZPcaaAmZqC6MBfFZRcoYMnOBGJhlz1bwPOkUaEX9ZNPv8CTouWd9mtFUBQS+sw6RsAG/KG63tU1PkUymW0WT8ghoN+RHU6Pp6TwrwSIRpwrE7pHKCQTfHNVgeH/7XM7z0MK4KBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773849094; c=relaxed/relaxed;
	bh=QgtlNgL5opTpBn73U5l71gRYTR0A4QeyxntZU129xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgrFSdeCHrkOqUJWmIGL0LJ+ulom82CRtmwKd15R5kJ1vHRMcxZioKB1FRExgmqitGv32y4ox0UltIt1xsh9sGV851Gr7dUI+qNaMxEvBZWJ9o0Eh50bz+e0mgd6TMNPaicoWhiwa15/zMkf7uFxDXdYFItrt4Jnqb4gaMrsM/wN9ghbJBMxrjPPe+e74HyRF0bhzmlPyjkjtTCtEV4U8if1UbCvUbwYqwimjTfDifkUsistGCYNsRftNuquxw0tGsKwdAMHtdVWS1i2aeJSSn+BOp8g2FLxLlVtvTnZnw3Q/cxEtrggekt5J6O3Y3q+HwBHisOOOJK2gY2Ad3Q42w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kYBDbvOe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kYBDbvOe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbYGY4kmWz3bgl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 02:51:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B436D405F4;
	Wed, 18 Mar 2026 15:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68B3C19421;
	Wed, 18 Mar 2026 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849091;
	bh=cshoMqhmsXn21+m564V6gRodJOxo+/21XTwmvJpWcIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYBDbvOefVH8dQP36IUT/9DNjXp+XC6btzKmAwBySknpL8860bXEYhr8djvgUeRiC
	 OPGw3XL+CBA1HOuGfH0Ost7lZwcRkY3fc/7raUu9+cJiqmuBSttO5eeme4v0s1o4Iy
	 HpDkhdHVuquXBSTdYlKqs2yKZhmFQ0StiUOzhekFu2ujNvbpMUTCUnLOZZwLNmJxH8
	 +aULPNpo0wcd5tdoj1ix0e8YLB+EIkW7+n08p7MUPngRSqjYRAMJsm8/RIejPDgvYt
	 lWbeUmVCNrnFxngZwMnFCypGI8SxOxvAb/NItOlBMURYI6peljYWq83Q9KU3WSGEFv
	 mtgUvNx/5gkcA==
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
Subject: [PATCH v3 18/23] mm: update vma_supports_mlock() to use new VMA flags
Date: Wed, 18 Mar 2026 15:50:29 +0000
Message-ID: <8bd076169508ea4640f66f91c4b84b433a3476f1.1773846935.git.ljs@kernel.org>
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

We now have the ability to test all of this using the new vma_flags_t
approach, so let's do so.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 mm/internal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 80d8651441a7..708d240b4198 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1252,7 +1252,9 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 
 static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & (VM_SPECIAL | VM_DROPPABLE))
+	if (vma_test_any_mask(vma, VMA_SPECIAL_FLAGS))
+		return false;
+	if (vma_test_single_mask(vma, VMA_DROPPABLE))
 		return false;
 	if (vma_is_dax(vma) || is_vm_hugetlb_page(vma))
 		return false;
-- 
2.53.0


