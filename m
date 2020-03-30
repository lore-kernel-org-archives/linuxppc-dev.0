Return-Path: <SRS0=0bRz=5P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88968C43331
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 14:34:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5EC206DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2020 14:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5EC206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rZjX5ZK4zDqg9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2020 01:34:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rZfq4VQrzDqW3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2020 01:32:16 +1100 (AEDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BB7AD162473A5A092442;
 Mon, 30 Mar 2020 22:32:06 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 22:31:58 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <mporter@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/44x: Make AKEBONO depends on NET
Date: Mon, 30 Mar 2020 22:31:53 +0800
Message-ID: <20200330143153.32800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
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
Cc: alistair@popple.id.au, YueHaibing <yuehaibing@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix Kconfig warnings:

WARNING: unmet direct dependencies detected for NETDEVICES
  Depends on [n]: NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

WARNING: unmet direct dependencies detected for ETHERNET
  Depends on [n]: NETDEVICES [=y] && NET [=n]
  Selected by [y]:
  - AKEBONO [=y] && PPC_47x [=y]

AKEBONO select NETDEVICES and ETHERNET unconditionally,
If NET is not set, build fails. Add this dependcy to fix this.

Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/44x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 25ebe634a661..394f662d7df2 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -199,6 +199,7 @@ config FSP2
 config AKEBONO
 	bool "IBM Akebono (476gtr) Support"
 	depends on PPC_47x
+	depends on NET
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
-- 
2.17.1


