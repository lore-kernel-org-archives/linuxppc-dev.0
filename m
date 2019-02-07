Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0269C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 02:51:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED614218D3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 02:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED614218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w2rK3SzszDqLg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 13:51:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w2pV12qHzDqLT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 13:49:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43w2pT6zxkz9s6w; Thu,  7 Feb 2019 13:49:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43w2pT6NSyz9s7h; Thu,  7 Feb 2019 13:49:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: Force PCI on for CURRITUCK
Date: Thu,  7 Feb 2019 13:49:35 +1100
Message-Id: <20190207024935.30456-1-mpe@ellerman.id.au>
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
Cc: bhelgaas@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The recent rework of PCI kconfig symbols exposed an existing bug in
the CURRITUCK kconfig logic.

It selects PPC4xx_PCI_EXPRESS which depends on PCI, but PCI is user
selectable and might be disabled, leading to a warning:

  WARNING: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS
    Depends on [n]: PCI [=n] && 4xx [=y]
    Selected by [y]:
    - CURRITUCK [=y] && PPC_47x [=y]

Prior to commit eb01d42a7778 ("PCI: consolidate PCI config entry in
drivers/pci") PCI was enabled by default for currituck_defconfig so we
didn't see the warning. The bad logic was still there, it just
required someone disabling PCI in their .config to hit it.

Fix it by forcing PCI on for CURRITUCK, which seems was always the
expectation anyway.

Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/44x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 4a9a72d01c3c..35be81fd2dc2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -180,6 +180,7 @@ config CURRITUCK
 	depends on PPC_47x
 	select SWIOTLB
 	select 476FPE
+	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	help
 	  This option enables support for the IBM Currituck (476fpe) evaluation board
-- 
2.20.1

