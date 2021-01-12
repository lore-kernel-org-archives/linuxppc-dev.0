Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C51C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:15:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CC42310E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CC42310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFcdq11YGzDshf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 04:15:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=iOrQ2yzL; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=CxIH9jkB; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFcQ31fqszDr6P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 04:04:55 +1100 (AEDT)
Message-Id: <20210112170411.281464308@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1610471092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=lCQcsUW6BG2TViN9PATPu0nvlehpGiocV+x+/eINNhI=;
 b=iOrQ2yzL7qHCBZMxPC7End9fO2OxSIYpXRwgowQ+kbHLNZtaezvOR94fNwfVroCra3r4Ew
 BP1Ix24/uzar89ES2eJRfzvUGDOwogScWlMzV76pJo8FD6DZNSP85cyJJUT5Z/SvHDfVxQ
 d76g/BhCGzVnTM+e8iRAh+j1uaqXXRNdD/M6HzdNWRAf2nn3Ax/9PBrMTnOwDKJrIpAZif
 inUKRshmheImrOw6IypO8IVb813XGgw6SFS/SebA5YIKRivqRd8RvMNd/pr9H2NbPUqT8r
 GASetIkWO4dF+yELYnO3NATQJmWYI5uCS07afeSQj/9MjvMUb41Lwa0JFXCYMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1610471092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=lCQcsUW6BG2TViN9PATPu0nvlehpGiocV+x+/eINNhI=;
 b=CxIH9jkBW11gEiftSavoeDam6PfkbYmCUt93JwwJEGwDeGCrbr+M/BpvsPEseuYsWR26v1
 MLveZEz3EE/eCIDQ==
Date: Tue, 12 Jan 2021 18:01:40 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 4/4] powerpc/mm/highmem: Use __set_pte_at() for kmap_local()
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

The original PowerPC highmem mapping function used __set_pte_at() to denote
that the mapping is per CPU. This got lost with the conversion to the
generic implementation.

Override the default map function.

Fixes: 47da42b27a56 ("powerpc/mm/highmem: Switch to generic kmap atomic")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/highmem.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -58,6 +58,8 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+#define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	\
+	__set_pte_at(mm, vaddr, ptep, ptev, 1)
 #define arch_kmap_local_post_map(vaddr, pteval)	\
 	local_flush_tlb_page(NULL, vaddr)
 #define arch_kmap_local_post_unmap(vaddr)	\

