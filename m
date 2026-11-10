Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0E60A260A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QExuCrRi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP48g43M0z3bh4;
	Tue, 10 Nov 2026 22:25:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.208
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794309955;
	cv=none; b=oBCfqticiTCWLPiH6lIZ8w01wceS8h32oaGZUeYQp4A8lm5BdfLbyHX4EvZa4GaaqUkSKamfFPECX+gGW+Mcc3ocVRUZUDO5cyC2r22xYc5Q7dhlBu5EAQP1JWoq803bcMLp5PW6dw4U8hHY2zlUdKCdrMUVtThiC6WopdP0WtYippKwcvkBKrsQ7VZx26qHaP99v4qQxa4JylZca0oYNI1ODAhLoM5HAgG16FJGu2IocJTtNBWPtrGXrfx0BG2q6ixetd9oQ8JbRgsSzpMe8TZ5fWK/kuvNQ5Yo481nofCM+xRogUimi9eTMChyHyu2ov3LRdUtEKj5AJ6FNIFbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794309955; c=relaxed/relaxed;
	bh=d8GPmNrrbDyVAn3i8pP3Irq5ZXZX7zbqtdgKc3xpyyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQMhydD3bL2d5nSzI320WGzsDogDSMj0cG920HmEVyZ6kRL9UcbmtEj4K5A5GZURoKAx2I2PlwZVSz2HvfE7X3tZMmNYGAFhveqGWWjhBsRQ5oY5OIjXsmMPyS18OwAL73n/B5eilxhPqUkAyjcX+/x3TRZT8wYj/Crv34VoCgmhSj4W5UQhyEO/jSHwj28u7UGJh+5tv643Ojt6n3nqo9eBwepR/OSZxazl2DEBhJwUOqIJWOiVh/CfXq/DOxarZSS0fcTErBbTK8x2qG6DuYeo/uKkEUW5mOuLR08bFmt/OAATAR2SyZ3wPEvdLRH3Vs4A4/upjIvePPY/QG87fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QExuCrRi; dkim-atps=neutral; spf=pass (client-ip=95.215.58.208; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QExuCrRi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.208; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP48f2dDkz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 22:25:54 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kV3VwCyfCvJMLMAaZdOv60N3vXq9IpfkDxA+THuP2XI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794309935; v=1; x=1794914735;
 b=QExuCrRik614pK3Nj/KOJe1vbFP8k6CElmR9Dgf8TsNOov9e8LeC5EO77D9b6PKJboOK+lFo
 463b6I6kv05lBPHwC+AB+1iOCZa3/YFFRpdf/nI1Ys5KBlMHp0ZcrQb9Lj5OElSGUTmskUDxwET
 TC4Bp32r9YoNH2mkU7501V7A=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 1ad4c6caf1eb501e;
	Tue, 10 Nov 2026 11:25:31 +0000
X-Mizu-Trace-ID: 1ad4c6caf1eb501e
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v4 8/9] powerpc: drop redundant unmaps of failed vmap mappings
Date: Tue, 10 Nov 2026 19:25:45 +0800
Message-Id: <20261110112546.261415-9-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261110112546.261415-1-hao.ge@linux.dev>
References: <20261110112546.261415-1-hao.ge@linux.dev>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmap_page_range() and ioremap_page_range() clear the PTEs they
installed when they fail, so the vunmap_range() in remap_isa_base()
and ioremap_phb() has nothing left to remove.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 arch/powerpc/kernel/isa-bridge.c | 5 ++---
 arch/powerpc/kernel/pci_64.c     | 4 +---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 5c064485197a..93029d85e6ea 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -46,9 +46,8 @@ static void remap_isa_base(phys_addr_t pa, unsigned long size)
 	WARN_ON_ONCE(size & ~PAGE_MASK);
 
 	if (slab_is_available()) {
-		if (vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
-				    pgprot_noncached(PAGE_KERNEL)))
-			vunmap_range(ISA_IO_BASE, ISA_IO_BASE + size);
+		vmap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
+				pgprot_noncached(PAGE_KERNEL));
 	} else {
 		early_ioremap_range(ISA_IO_BASE, pa, size,
 				pgprot_noncached(PAGE_KERNEL));
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index e27342ef128b..f74269636d5e 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -139,10 +139,8 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 
 	addr = (unsigned long)area->addr;
 	if (ioremap_page_range(addr, addr + size, paddr,
-			pgprot_noncached(PAGE_KERNEL))) {
-		vunmap_range(addr, addr + size);
+			pgprot_noncached(PAGE_KERNEL)))
 		return NULL;
-	}
 
 	return (void __iomem *)addr;
 }
-- 
2.25.1


