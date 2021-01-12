Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5423820B1F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5423820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFcY80tjlzDrRB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 04:11:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=gXKVOF3f; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=Q/AYXgDR; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFcQ14QMNzDr6T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 04:04:54 +1100 (AEDT)
Message-Id: <20210112170411.187513575@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1610471091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=pTk1FcH5+/wyB8HB1QRJBoXsx85zfAu4dJubIkq5SzI=;
 b=gXKVOF3fh+FZwnz+sbLIbpsIqGtmfmcazChwcDdjZCPkH513hGnuY50e8hxBerCj+Wozq6
 WjgYTVQGcNu19gSVoPSMUUdPEFQ6UewzPdWwBUpbQGo2dR9GuoXtYO5tLQghs+5Gjdhfvn
 apTCXHcWAlg1m4tdfKh2Fgae4QM+vz+2vlBm4AaiqkvBvmXsD/lmVr2DpvbTvOmvz+ugxx
 o++jLvhtnn57Ujm52fOxGmyjUtgnJ2JI/8kE5srw5yeujHTimsvfFlCi8JDN5enGNJgu8H
 gUy6dDFWPVPpAWxPgD0mWAXhgQoHM2Kh/3GuZjlZ99rD4A8Fm1EkjhsFkFaArQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1610471091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=pTk1FcH5+/wyB8HB1QRJBoXsx85zfAu4dJubIkq5SzI=;
 b=Q/AYXgDRbN6MB0ck3kKpvdlAZd4tF/RVCxjLqReI6YlcdY4xdER6sSEIJpfVazoon1EasT
 Z/sRhKeZnnCkqaCg==
Date: Tue, 12 Jan 2021 18:01:39 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 3/4] mips/mm/highmem: Use set_pte() for kmap_local()
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

set_pte_at() on MIPS invokes update_cache() which might recurse into
kmap_local(). Use set_pte() like the original MIPS highmem implementation
did.

Fixes: a4c33e83bca1 ("mips/mm/highmem: Switch to generic kmap atomic")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/include/asm/highmem.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -51,6 +51,7 @@ extern void kmap_flush_tlb(unsigned long
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
+#define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	set_pte(ptep, ptev)
 #define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
 #define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 

