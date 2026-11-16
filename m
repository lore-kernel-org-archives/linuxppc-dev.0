Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EE606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfDaiG1q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSfJN6zXKz2y32;
	Mon, 16 Nov 2026 18:15:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794813300;
	cv=none; b=VQwtkji1RdhHfxKceLpIvvQ/MrNXyI37elsebJd5gizFjyUlIotIn+5bbfWSTQesHPSFwi8SBDWqzDRqYxyDuHR8x2ILqnIpFVxvYI1mNvv+X1s1gUpnNQJTNIkqrhVPdG9Wyy50DzZcJUqT9zprqaxgOm8NdAdRN+PzhG8XrPv0RjmHIilFCHJ9xNOOoEwR+0J8ybEfA4ZWXr8UEg/o+sUh+LH7nbu07VcgpU029QDTRcxJ42+tCfrJ6lpZCE42BTmC0Sr7p0d9u8NhW5FYqWs93vifc3u2QZVssFCLP2C4AwQNVNGop5+awe8pDJEfzDsGNmIQhHnMpo5FhbP37g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794813300; c=relaxed/relaxed;
	bh=d8GPmNrrbDyVAn3i8pP3Irq5ZXZX7zbqtdgKc3xpyyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oC2OqJIQG8u+Tuf1K7U1iP2X3OK4aInM8JItlcA8fZvVW94m+cc2m6ihrmz4Wf6vCws8/UU10gT2D2ogyggsZRSFSJHCFwop/DP1fHFKTNTiBxKc2BZWniHSZH15IYzptntfABNOAuRaqxFvo3z2g6can/VcTgtc5a8eD1xMzY/Cdj/DXCCp1PVDGw1k/zGp2xaRzUQSaY6G6f1oP4NQdLZWwEeiyS8orLRLGgtKO7fyxs2mHf/A38rMxJkJXDjR/XwzNUhgOFuukvleqEz06j/qx56D8IL2rEfuV73ctEi3kkVecpEpjLI+RM7oXoDFjpNMB3FMgeAExnwMXjYKWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfDaiG1q; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfDaiG1q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSfJM4J2Rz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:14:59 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kV3VwCyfCvJMLMAaZdOv60N3vXq9IpfkDxA+THuP2XI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794813281; v=1; x=1795418081;
 b=DfDaiG1qMVulpMmALcrcCWJ5j9wSA2DSpO+s2Ir5iKBYn9xCRhKJbdGFXRPC4FL51hLHD6sf
 yBLGtGdEVEWLedCVu9bnWgjBRBv5v46B9V+aClPEIKFCB4xOUb1fPbklONeSBpQt8hCtX9qtIS2
 SUt02hZEPCPRSsF/7l2Tabi4=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b12c8b10ff90e4bb;
	Mon, 16 Nov 2026 07:14:40 +0000
X-Mizu-Trace-ID: b12c8b10ff90e4bb
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
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
Subject: [PATCH v5 10/11] powerpc: drop redundant unmaps of failed vmap mappings
Date: Mon, 16 Nov 2026 15:13:24 +0800
Message-Id: <20261116071325.263682-11-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116071325.263682-1-hao.ge@linux.dev>
References: <20261116071325.263682-1-hao.ge@linux.dev>
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


