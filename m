Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F9EC63798
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 12:12:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873272076B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 12:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FVCQcP8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873272076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CgNF33jj1zDqZm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 23:12:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CgN5g5N88zDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 23:05:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FVCQcP8a; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4CgN5d2wCrz9sRR; Tue, 24 Nov 2020 23:05:57 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CgN5d1WM7z9sSf; Tue, 24 Nov 2020 23:05:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606219557;
 bh=SWq0jOrSxq/qfLYEJGhXS1iGsH3F30GuyIBmVpG5Mwc=;
 h=From:To:Cc:Subject:Date:From;
 b=FVCQcP8aeJ64ewXPQb0zZtTwXVevNPGPUcKcZOJziH1FQViLQZOGuqKcwCrTAW39Y
 ASR1LnbE2h8LySI/wYZ+5XU9/kgc7lFwCFw7b5LFtU+W/rRODs3JRymp2dltOZ/Y14
 7pZntUTDecBmHoWxRY/SE/DQLpqa5bh5aWkvWERwycvfRRZiACrkT7cw6lF7nzVTlt
 HYEowBZFWa2EovIQtlNPmmuYc/LvrtkBqeu0EM/layOI6JpLhRar9ABEcasRf4ftut
 wfdOzp2UTyRsLn4iGlsaXcncuXWWOXRxIcHuVR+PQ6otMKAzfrNM7Yii0dXnDRUKMZ
 BUKI3PSt4il9g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Make NUMA depend on SMP
Date: Tue, 24 Nov 2020 23:05:45 +1100
Message-Id: <20201124120547.1940635-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Cc: rdunlap@infradead.org, srikar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Our Kconfig allows NUMA to be enabled without SMP, but none of
our defconfigs use that combination. This means it can easily be
broken inadvertently by code changes, which has happened recently.

Although it's theoretically possible to have a machine with a single
CPU and multiple memory nodes, I can't think of any real systems where
that's the case. Even so if such a system exists, it can just run an
SMP kernel anyway.

So to avoid the need to add extra #ifdefs and/or build breaks, make
NUMA depend on SMP.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..a22db3db6b96 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -660,7 +660,7 @@ config IRQ_ALL_CPUS
 
 config NUMA
 	bool "NUMA support"
-	depends on PPC64
+	depends on PPC64 && SMP
 	default y if SMP && PPC_PSERIES
 
 config NODES_SHIFT
-- 
2.25.1

