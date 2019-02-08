Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A1FC282CB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632E7217D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632E7217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wvpv24JgzDqWB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 23:37:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wvkl0zDgzDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:34:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43wvkl02K9z9sBZ; Fri,  8 Feb 2019 23:34:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wvkk5W2wz9sML; Fri,  8 Feb 2019 23:34:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Make PPC_64K_PAGES depend on only 44x or
 PPC_BOOK3S_64
Date: Fri,  8 Feb 2019 23:34:16 +1100
Message-Id: <20190208123416.1051-1-mpe@ellerman.id.au>
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
Cc: oss@buserror.net, aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
64Kpage size from 64bit booke") we dropped the 64K page size support
from the 64-bit nohash (Book3E) code.

But we didn't update the dependencies of the PPC_64K_PAGES option,
meaning a randconfig can still trigger this code and cause a build
breakage, eg:
  arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error "Page size not supported"
  arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error Unsupported page size

So remove PPC_BOOK3E_64 from the dependencies. This also means we
don't need to worry about PPC_FSL_BOOK3E, because that was just trying
to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3f237ffa0649..7a16b8a7b54b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -694,7 +694,7 @@ config PPC_16K_PAGES
 
 config PPC_64K_PAGES
 	bool "64k page size"
-	depends on !PPC_FSL_BOOK3E && (44x || PPC_BOOK3S_64 || PPC_BOOK3E_64)
+	depends on 44x || PPC_BOOK3S_64
 	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
 
 config PPC_256K_PAGES
-- 
2.20.1

