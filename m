Return-Path: <linuxppc-dev+bounces-29676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8D0CCF2D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 05:45:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7PdW5P02z2xjN;
	Mon, 19 Oct 2026 16:45:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::3d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792388703;
	cv=none; b=OkRFWIQIcAMxwTZPWJ2rKpv6uNsWny/iiVD20ypP752H3SweLxzPICGMqRY3XTz9SdTA9QFpxebQmvbyz6LbEn/lNV8FIfKvli42GIYTfs38eBCt4XQC3WaEWJt08N709Mv959rACCbUAYywve/Uvwr5t2O7kNZLoK1VGo7bPksj/i+LGzrxtW25x0J4LNb0LDwvuZGC6CojKag1vMwAW48zvNkWhGx4uUS8wUiUFyQvHuALUzmaAYmYcVSIeK6Xo7xtAIR34+WE8cYG7i/UzaSjuDuNGrToMfRpkgF1f5D1fev9rJuy5GmC7IqqwgKBdsE6HJphYLBuTUaixaqrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792388703; c=relaxed/relaxed;
	bh=d8GPmNrrbDyVAn3i8pP3Irq5ZXZX7zbqtdgKc3xpyyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ra+bt+3ecMeHJ7SzId7JQc7t9zmP2Ak6TODQu4B2EbT2/0y5NpwjB0cAotmmb2PeOnenqZDHUECcIM1VlEQ4R0l0Cdo8c3oE0pT4JGmj2VuvEfqNFPucd9c2l9PHhg3EZmcgrybGQgSFyGqhkCx58t7n3NScknY+VUci4gPS8aQgUXC+194nDvuIu+MvUoupb+pWepZW+Hd6pZUEbE3ncHft4ZhgeyMq/6IeblIOQOLQ/BLKYBhAmB/pKlcB8wFUu2C0GRy/vwkwuso4nrKUJxRq19F9BwoCoJfs/G2qMyL37E+oINik9nXTLINScWf4T4HNnSFSGlBaLgR+4KXr8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bfZyKk5L; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::3d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bfZyKk5L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::3d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-61.mta1.migadu.com [IPv6:2001:41d0:203:375::3d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7PdV4ZFTz2yvW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 16:45:02 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kV3VwCyfCvJMLMAaZdOv60N3vXq9IpfkDxA+THuP2XI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792388686; v=1; x=1792993486;
 b=bfZyKk5LZX7dRUf/o3N3SnxRArbKpVZE0qurYqe4J6IzwXfLBU1qcz/J2eKM5L5RI4zqmbkg
 JBvwTJgyGtuKl7ECfapy0D2k6KKaXkiPMWhNBoU/EiO+sAUS7LNpZ7H6AqB9hsCiVAE7Nxfozlx
 TlUl7BIUqC88uRwtWqauXZ8k=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 21b0a6f41841bf49;
	Mon, 19 Oct 2026 05:44:46 +0000
X-Mizu-Trace-ID: 21b0a6f41841bf49
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>
Subject: [PATCH v2 4/5] powerpc: drop redundant unmaps of failed vmap mappings
Date: Mon, 19 Oct 2026 13:45:29 +0800
Message-Id: <20261019054531.87652-5-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261019054531.87652-1-hao.ge@linux.dev>
References: <20261019054531.87652-1-hao.ge@linux.dev>
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


