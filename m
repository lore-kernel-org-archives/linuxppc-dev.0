Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F6CC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 06:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7200720883
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 06:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7200720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dcFr2RwXzDqLM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dcD55C4VzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 16:03:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44dcD51HrQz9sQv; Tue,  9 Apr 2019 16:03:33 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44dcD50W7hz9sR0; Tue,  9 Apr 2019 16:03:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs
Date: Tue,  9 Apr 2019 16:03:24 +1000
Message-Id: <20190409060324.16941-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: schwab@linux-m68k.org, hughd@google.com, aneesh.kumar@linux.vnet.ibm.com,
 ben@decadent.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent commit 8bc086899816 ("powerpc/mm: Only define
MAX_PHYSMEM_BITS in SPARSEMEM configurations") removed our definition
of MAX_PHYSMEM_BITS when SPARSEMEM is disabled.

This inadvertently broke some 64-bit FLATMEM using configs with eg:

  arch/powerpc/include/asm/book3s/64/mmu-hash.h:584:6: error: "MAX_PHYSMEM_BITS" is not defined, evaluates to 0
   #if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
        ^~~~~~~~~~~~~~~~

Fix it by making sure we define MAX_PHYSMEM_BITS for all 64-bit
configs regardless of SPARSEMEM.

Fixes: 8bc086899816 ("powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 598cdcdd1355..8ddd4a91bdc1 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -352,7 +352,7 @@ static inline bool strict_kernel_rwx_enabled(void)
 #if defined(CONFIG_SPARSEMEM_VMEMMAP) && defined(CONFIG_SPARSEMEM_EXTREME) &&	\
 	defined (CONFIG_PPC_64K_PAGES)
 #define MAX_PHYSMEM_BITS        51
-#elif defined(CONFIG_SPARSEMEM)
+#elif defined(CONFIG_PPC64)
 #define MAX_PHYSMEM_BITS        46
 #endif
 
-- 
2.20.1

