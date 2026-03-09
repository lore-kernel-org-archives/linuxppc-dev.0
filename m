Return-Path: <linuxppc-dev+bounces-17915-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC7F41807
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:19:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV0zy2Dnzz3c9b;
	Tue, 10 Mar 2026 02:19:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773069582;
	cv=none; b=hFSJJnBJgzGRHHf2iQatVLydujP+XNP/005PMXlD1BIMB+yw7JMxgp2BW9e0RHPmDLxQ8qd6P3xBEkA1QisfI3eJZqMxs5CnBIVVzg+KB7Wl28/cm0snUJN4Jed/jovzxLWKahNrsCcJqplBdiL4C2bRLZ+t/B1Dzywr35DSNBEfV2p7taKLLcvwvi6h0JoXcRxW1shTPWWDC4vHuXaCyL9rsqiZ//T+Ha086OppckJ3NazPGgozCOuWH3qySBSNxPMAlzOUUQYMCkX9zRooLNWPA7y+jtDvleG8JdnSyyYUM3AQXRPmGKYd7NFwJca/q1lmybScFnZl/xVuVTqI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773069582; c=relaxed/relaxed;
	bh=UE9tiiF179fknKTCh62gfe1AP0ZR587kZVIsQ/0ru2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7Yh+F1oX8tU5hzMKJiiDeIfNuOE6Wu897bmFotcTLAgzAADrXhliUFMdCXT4ZSjJdSCjmPfKkD6o6q6x3TcPuD23zaBSgorjWd2fIjK8uFuzrdp83qHC8oc4ieRVdRXPHtQGXWmo9Oxa3WiXkiFaVNfTARncqi2UzAk5kvgvu0SirOGgpIElonTf4n54n5RCK07id6PeuBqfp77tipSUXiV37b44t3EUOwXm1ab7RSzNxXdQH7+5fN0si0QwdfXn7ZKwPwFdAf5UiFYv85rxWPlki3ErqUZMTreAa38ZDz7R+V9jaXsj1IHn/O5elwYvyLjPMso6W89z4iwDYwsnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e5ADz3X4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e5ADz3X4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV0zx5Dl8z2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 02:19:41 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0488F60122;
	Mon,  9 Mar 2026 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68A3C2BC86;
	Mon,  9 Mar 2026 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773069579;
	bh=q/OK9MenvejDughLrSZOznakkVUTLmx28+Vi6bUHGJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5ADz3X4fdfGQ+QEhi4NobrQcvdh+sIqHuN1lR9eH1IXLKh4ehimkDrH425UOshs6
	 cvqoazVhrxU+UDeYiyGlmsmBOHdE/Gqhy1joKiUvwHgZOeKu3MIbzsRI3rNSFZ0pOp
	 0X985TzMHB6ViaeHWx2+Stsi4ao7uIV1Fx09Hz3kQCklf53GBAm6F+oQIcmqY05hR6
	 w7rzTfbsry5MDrFfNLgFpeT0QH0ZSWVceRoG9a1pDHeUkO2cUruTyZ7lxIAA3UuZ7U
	 cNb2r8U+cFd3WnW1Tn+i6azBCX+almkPPgh4gl4k0F7UXbmkov6JCACpkkg5tOQtHp
	 v9hC3syVh165g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 4/4] KVM: PPC: remove hugetlb.h inclusion
Date: Mon,  9 Mar 2026 16:19:01 +0100
Message-ID: <20260309151901.123947-5-david@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309151901.123947-1-david@kernel.org>
References: <20260309151901.123947-1-david@kernel.org>
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

hugetlb.h is no longer required now that we moved vma_kernel_pagesize()
to mm.h.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 08e5816fdd61..61dbeea317f3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -36,7 +36,6 @@
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
-#include <linux/hugetlb.h>
 #include <linux/kvm_irqfd.h>
 #include <linux/irqbypass.h>
 #include <linux/module.h>
-- 
2.43.0


