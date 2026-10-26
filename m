Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D5606A31B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qyKRnBCP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCmND5gnVz2yMK;
	Mon, 26 Oct 2026 19:03:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::91"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793001820;
	cv=none; b=D/IyBh7KtlNPzXWhWSbmGsTYrsgnKFFFBNOKIPuxj6zgDrHSu0TqCCnl7uXH/omdJi7fZGJQ58g6ODwJzBxxj3Ns5aQznCvvC6UhgsAJkuknYv1fumwt7d9wqmZYom/rpMfBD/4SdAzxRttJa/hC/g74N6kDpa0mTpuHQ7rAe3Urd2UeLom4lzsaywO0H34COT04QVeQEUCxsl0H7TyivRQUCP+aXgZc45zk0W7/3Y8HwkVgZ/ki9X3XXoYSH2oQvKumeCDGH/6fAqOEPKps/DfAL5vHyHXzRWbn3NT2dYqmAAovLTFlgMaWVLR/pI8ls6324RqYZpFqEWQkl0FR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793001820; c=relaxed/relaxed;
	bh=d8GPmNrrbDyVAn3i8pP3Irq5ZXZX7zbqtdgKc3xpyyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n8l5ZmzSMDk2cQVmr+98vvZCb2JYsc+DxpACKhM/Wl3oR2suT3LSHvtBcPYMkFiu2HiSq+jFzEArHiaJjUTq6UJqDngFHCqUOfDu6dMedvVtncm+U9VqJOOcJLbWMrItYWKvDKwhLpZ8kj35REf+quY61P46PtMJR+q2VX48/fUbKFPgOHf80c8NpDpkdbyqjYJX82nYndMoLAeGvcG6AWbqHX06C6CA6jhP5vOIYnAOXUAeB8H2UhzWa999mOCIUuMCd1Gs60bQ51fSj1UNv8o5x71fHIxxuvl6tlns003tE84nmCMNqdmDv5jGwXdxaybeLR54u5UlBa4v3S/BXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qyKRnBCP; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::91; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qyKRnBCP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::91; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-145.mta0.migadu.com [IPv6:2001:41d0:1004:224b::91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCmNC5V05z2yLF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 19:03:39 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=kV3VwCyfCvJMLMAaZdOv60N3vXq9IpfkDxA+THuP2XI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793001801; v=1; x=1793606601;
 b=qyKRnBCP1/DLY20sFPHkrBgt3kqGJqxE0y7pbr0EUIROplVrVVmK5rVEIEMqbcpGe41+DnHG
 T+LWts4J4Nqu3uAu2LIfKzgOaS5yG3alaLSiD5yDC38vAKELVMSkUwyJBV+/UMtpmEQFPlpTnZh
 KerYyvOR1Wyu7C1/y7YSPQMs=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 16a4ca664e40d64c;
	Mon, 26 Oct 2026 08:03:21 +0000
X-Mizu-Trace-ID: 16a4ca664e40d64c
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
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
	Christoph Lameter <cl@gentwo.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Hao Ge <hao.ge@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH v3 09/10] powerpc: drop redundant unmaps of failed vmap mappings
Date: Mon, 26 Oct 2026 16:03:28 +0800
Message-Id: <20261026080329.140244-10-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261026080329.140244-1-hao.ge@linux.dev>
References: <20261026080329.140244-1-hao.ge@linux.dev>
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


