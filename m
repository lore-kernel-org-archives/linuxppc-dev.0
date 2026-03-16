Return-Path: <linuxppc-dev+bounces-18260-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61429F506CB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFmr4Kz9z3bbm;
	Tue, 17 Mar 2026 00:09:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773666588;
	cv=none; b=iIUvXt8T/SXFQ/n2CP3NTiEOujV9Z0GXvG2Pa9zhc90lEgpO1Fim7InmrzmQz4viMvvCivOr7wgqVIJyfNEHXZ+73F/BBQJ5R3Y+abFgFRYMWvaAmFEX8oT+fJ2mTBckfJHRNXfEg6k287NONVZk9swl7VhWe52rO4MwFcLJ+9GihgqApMzbzA+WxOzpS6e5Lr8Yf9L66i/HrAP18yxNhQPrcYO7ePfRWdfmhMY9bsFTNj5rIpQ+1ujDVJ72zybcMA9qsJcBKU0mOj8Yd8H1A2MXRJdnDwAI7mDiprK4qimEHAFL8BEmchnJdL3djIYne8KiyphoLAQ/rVUckYuHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773666588; c=relaxed/relaxed;
	bh=QgtlNgL5opTpBn73U5l71gRYTR0A4QeyxntZU129xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp7Hb6Wco/lXNYapdPkElrHHfnA6tdUsBV6MSXk7f/2DZsUiFtPWIOi0ans/L8j/4R7zvv/ECZmi/oNV/3cG+2CPlaPWESq/eqCVsi042tr9HD8LBkb+EuBaeHS1qGgLUH7Z7lYY+Q7duFtWiZnE0hhoWOZ8ixoW3RDfNqIt/fvY4+phVIYoEivxT1io0xzbs4vY5Jj4EnlsxVe8OhE9rGCKUh7jDjwxkTPYr2HS5DkFDvlQR/ZJDi9PlsaXk8PUsYHKj+T2T0l5MesVdkJOoBrcfbL6rx2DJUxbMd9NszIaaKiiXGIH1EhibbH/9beCs7GcBHFqJT6wTaIjN+T7gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GoYjdYK+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GoYjdYK+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFmq6JK1z2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 00:09:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EA3284082E;
	Mon, 16 Mar 2026 13:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B5AC2BC87;
	Mon, 16 Mar 2026 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666585;
	bh=cshoMqhmsXn21+m564V6gRodJOxo+/21XTwmvJpWcIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoYjdYK+uvokPnGKuT3tc4SmdUKqIx09gnlf1i1/a6ik3xs2zAiEgRyMQmBT7XnHq
	 5W0IXEMJIsxuNBLQoFNXi+P7nWI71CHQCAclhg6VRgt3ctqVGnmM0+ba8uvws/wIzN
	 WHLV4C8QGtteLWCCHBdv5Ri58aZ95Cmo+uDYbFCBwbVw2TH0mo+x0PQuZWczCJa7lF
	 0WrejdRKjymUGNI5gFdHuyMUwTEDpsxZZroj6vnq3ALslUw5YYLkoz87Ksi63EALhr
	 4DEgEdhyB8ia4nSpei+grNhfrdUn/u5yx27XEj6UK9j6N/d+BrLJXs+U0omOi8nV/n
	 UH0Yws4m9dtZQ==
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
Subject: [PATCH v2 18/23] mm: update vma_supports_mlock() to use new VMA flags
Date: Mon, 16 Mar 2026 13:08:07 +0000
Message-ID: <2f82b5b93599e89b391ee4672928cefdfd2fb2f8.1773665966.git.ljs@kernel.org>
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


