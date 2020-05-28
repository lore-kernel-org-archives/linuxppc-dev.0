Return-Path: <SRS0=Ue3/=7K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A99C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 23:09:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB6A20776
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2020 23:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="nEg6A4S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB6A20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Y3L15PwGzDqYp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 09:09:13 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Y3JB46gRzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 09:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=nEg6A4S4; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 49Y3J95qHzz9sSp;
 Fri, 29 May 2020 09:07:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1590707258;
 bh=ZqDcXrnKtbDhD7f27IYbj2XIbF+KrmpTF647NmJmTzs=;
 h=From:To:Cc:Subject:Date:From;
 b=nEg6A4S4RsHkcFQVYQUB/lv/IMz9r/GuJvPtETwRm0v9ZyfFTRAIB5h1QAEUi+AZS
 t7FFXYGvGvS2W19mamC+PN7ymugU2wY4pOrgeYiSJVNlesJfpKi3xRtamexPOFmKSC
 ZSy3ZIju7RrSKb4Mre1wOgQwDItMdbT08NelTi6d5jUXxntIHSHnG8C9NnOxuVfsB7
 14Zb+yY5RUPCBR5zx3O8D43wyCPjIanPDhuXdGvl6/EFr42V5dExmxvuetTKDsbPbr
 uPpQH+ey+h4tKezPXtbdyMSdbyYFURxzlg8/kJZkNo7znQQV4vpX6JPk5qlwWrz0Y1
 eGejpagYLiD2A==
Received: by neuling.org (Postfix, from userid 1000)
 id A9CAE2C0498; Fri, 29 May 2020 09:07:37 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc: Fix misleading small cores print
Date: Fri, 29 May 2020 09:07:31 +1000
Message-Id: <20200528230731.1235752-1-mikey@neuling.org>
X-Mailer: git-send-email 2.26.2
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently when we boot on a big core system, we get this print:
  [    0.040500] Using small cores at SMT level

This is misleading as we've actually detected big cores.

This patch clears up the print to say we've detect big cores but are
using small cores for scheduling.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6d2a3a3666..c820c95162 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1383,7 +1383,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
-		pr_info("Using small cores at SMT level\n");
+		pr_info("Big cores detected but using small core scheduling\n");
 		power9_topology[0].mask = smallcore_smt_mask;
 		powerpc_topology[0].mask = smallcore_smt_mask;
 	}
-- 
2.26.2

