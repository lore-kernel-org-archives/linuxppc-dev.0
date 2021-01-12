Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61088C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:09:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26DA2311A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26DA2311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFcW43CLMzDrQr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 04:09:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=ORqdfppD; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=J0FN5ZDz; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFcQ13QSczDr6P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 04:04:54 +1100 (AEDT)
Message-Id: <20210112170410.905976187@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1610471089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=BjHyx3TQA52ByPsCeTq6N8/6SlSmPZzIU106dD0/fYw=;
 b=ORqdfppD06eQ0ZtlbH7MYyPKjna93z9ENP0IyxUC4Iw+h8mTmFOQEoeWffNqPwJ05tpoTf
 BxSBtF0qLne6qr+iL9EF/A2QjbTRAvrPrA803FWgEdZ3cx74FSjnNeeCHqsml+N5I0eSlK
 Y1m+lZE8U9RRJxBqUeoPi8PANlp2ZUfN3FoMXFuwzT0271iX6iIIePHqCZ5FT4LdgqabFo
 boArQRMp3xXzOvXBeXDsoKUvbI8AjYR2vOvjCyJWmgTpopFj+73MUQj/VKElVv7DgMIiIu
 HVXrTc2BdN9e0ttqxo1T9zkDesqgXxOvpuA9ceXRlD5ek2kdBO8rK4uq5D5NEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1610471089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=BjHyx3TQA52ByPsCeTq6N8/6SlSmPZzIU106dD0/fYw=;
 b=J0FN5ZDzaq16C8M0zmNKp9Th8jxUyTdPHrkY+b/W+4Hf8ZWFnW/gJMBR3JEy3Xo18wKTAQ
 Rcs6OW9e4Kkiz/Dw==
Date: Tue, 12 Jan 2021 18:01:37 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 1/4] sparc/mm/highmem: Flush cache and TLB
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andreas Larsson <andreas@gaisler.com>, Peter Zijlstra <peterz@infradead.org>,
 Paul Cercueil <paul@crapouillou.net>, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent conversion to the generic kmap_local infrastructure failed to
assign the proper pre/post map/unmap flush operations for sparc.

Sparc requires cache flush before map/unmap and tlb flush afterwards.

Fixes: 3293efa97807 ("sparc/mm/highmem: Switch to generic kmap atomic")
Reported-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/highmem.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -50,10 +50,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
-/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
-#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
-#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
-
+/* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
+#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
 
 #endif /* __KERNEL__ */
 

