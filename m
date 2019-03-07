Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90696C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 03:50:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085B320835
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 03:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="H0t6WsJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085B320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FGqd4WYxzDqCc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 14:50:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="H0t6WsJx"; 
 dkim-atps=neutral
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FGnl4mTTzDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 14:48:42 +1100 (AEDT)
Received: by mail-qk1-x743.google.com with SMTP id y140so8235107qkb.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 19:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=cfMkd7k5sfsoufvYvmOTamvmreEyC+E68UQtEbBo5qI=;
 b=H0t6WsJxPvqVTlR4Q3olCA72TjvAPUP+vKPl9pHZXpppxrE8Ns3we2BgNC0dTLc4os
 B9muEuGM7xEDfL7tanpS8Kwgcc9TmhwQ45G0ES/P0fjVNU7h1yf2Ae4vDOkvawcAIWH/
 wwzVnzUQFgOGqfLCG0GEGYgXEtzBx+SZYA9AXsviSIyhZ6/b5gFDWemapxo/KTDjuR2/
 bz6kxTpOJXYJW+0IzOjaI9zKDtlwNDjyODxSRpVsRdzVlmtmrSS0NnG4a8voiH6PQspM
 3SaMYjyZqGxQDLKsUO57bbF1pq8/MYOXk2aqNcRq0lBF8ReXyyq0yAinonZ6iIeSbyKu
 nc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cfMkd7k5sfsoufvYvmOTamvmreEyC+E68UQtEbBo5qI=;
 b=eVbvAGHz81hR2TsOpDXuNdjJp+whtNvgCROQUT2rfz4O/xmlclEvKRvrEKbbkF80iX
 QethGyZQVt6mpMGQX/3vWdmmBrVETeJXcux/A80DrdDVUYR5GYHjAUTC51K4M2auEYQf
 w85XxxPLiLIPtLnuh99EMcTZRwcTK+dZ1bp9lz/8rChCox/CXHWI0l8sH2bWBgzYJX8o
 Awxjbw1dGZgS4cFg1Ca+I49V1SfDQLMZZvyKY1dWwg2/tr8xp7YT2KTXJAj0szzqKg6P
 3iNaJxGotSAaa8m/qDsu1JNRlpFj4YFmpjHL/4zn6BDwA8rn4Nvg3EyHiv5CzZ0RpcII
 cxjg==
X-Gm-Message-State: APjAAAXysV7dHBKwwNv8MPAvI6EVjp/Uhz/0jTNlkpqxzQoAIl5tYB1k
 mvSNFH+qhnIrmmuRUoNpnJPE9A==
X-Google-Smtp-Source: APXvYqwBvaruU+dvEpOiKiLSyAr5JJG0Xdp9CifuxSx7Xxz/lqhTZ12AZRaEKlSPq47iFlbTRT9Uag==
X-Received: by 2002:a37:f507:: with SMTP id l7mr8630648qkk.302.1551930518976; 
 Wed, 06 Mar 2019 19:48:38 -0800 (PST)
Received: from ovpn-121-103.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id p127sm1726897qke.97.2019.03.06.19.48.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 19:48:38 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: silence unused-but-set-variable warnings
Date: Wed,  6 Mar 2019 22:48:21 -0500
Message-Id: <20190307034821.48769-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
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
Cc: Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

pte_unmap() compiles away on some powerpc platforms, so silence the
warnings below by using the argument to pte_unmap() as a nop. Also, fix
checkpatch.pl warnings "Single statement macros should not use a do {}
while (0) loop".

mm/memory.c: In function 'copy_pte_range':
mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
[-Wunused-but-set-variable]
mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
[-Wunused-but-set-variable]
mm/madvise.c: In function 'madvise_free_pte_range':
mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]
mm/swap_state.c: In function 'swap_ra_info':
mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
[-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 868fcaf56f6b..ec00ce6dd312 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1006,7 +1006,7 @@ extern struct page *pgd_page(pgd_t pgd);
 	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+#define pte_unmap(pte)			(void)(pte)
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e77ed9761632..103071afab3d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -205,7 +205,7 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
   (((pte_t *) pmd_page_vaddr(*(dir))) + (((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)))
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap(pte)			do { } while(0)
+#define pte_unmap(pte)			(void)(pte)
 
 /* to find an entry in a kernel page-table-directory */
 /* This now only contains the vmalloc pages */
-- 
2.17.2 (Apple Git-113)

