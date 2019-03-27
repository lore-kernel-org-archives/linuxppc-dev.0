Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD30AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:24:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B32C2087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cghY5gvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B32C2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TxHG0ZVCzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:24:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="cghY5gvy"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Twrm6Yy2zDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:05:12 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0E8F5217D9;
 Wed, 27 Mar 2019 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553709910;
 bh=Ke7PKD/eQdDk1TotwE2Zwkfq6hKB7erw5boECmEx25I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cghY5gvyWN6n2Y3eVVzFdsQ+vg0t28/A0nzI7fkjHYpJpDRsBlaqOAdOKvuhYeDvB
 dGEU+ivS9vCqoWpqmNxTnYmYMkZJpUqN77K3kKAyFcqCq0Th71dYf1mEa+8oxkHrQo
 iJJjBobRy3wVtq7V9cpiekReezxKZYhPSMsnMB+w=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 106/262] powerpc/44x: Force PCI on for CURRITUCK
Date: Wed, 27 Mar 2019 13:59:21 -0400
Message-Id: <20190327180158.10245-106-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit aa7150ba378650d0e9d84b8e4d805946965a5926 ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

