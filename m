Return-Path: <SRS0=FJcg=WK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7032AC433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 07:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4DFA206C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 07:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DFA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467h3d0prXzDqss
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com; envelope-from=yinbo.zhu@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467h153f8ZzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2019 17:24:35 +1000 (AEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 182A11A0142;
 Wed, 14 Aug 2019 09:24:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3015B1A0060;
 Wed, 14 Aug 2019 09:24:20 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 620FA40305;
 Wed, 14 Aug 2019 15:24:07 +0800 (SGT)
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Li Yang <leoyang.li@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>,
 Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 1/4] arm64: dts: ls1028a-rdb: enable emmc hs400 mode
Date: Wed, 14 Aug 2019 15:26:46 +0800
Message-Id: <20190814072649.8237-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Alison Wang <alison.wang@nxp.com>,
 Alex Marginean <alexandru.marginean@nxp.com>, xiaobo.xie@nxp.com,
 Catalin Horghidan <catalin.horghidan@nxp.com>,
 Rajat Srivastava <rajat.srivastava@nxp.com>, jiafei.pan@nxp.com,
 linuxppc-dev@lists.ozlabs.org, yinbo.zhu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch is to enable emmc hs400 mode for ls1028ardb

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 8a725409e881..f1e46cc4cea1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -92,8 +92,10 @@
 	};
 
 &esdhc1 {
-	status = "okay";
 	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	status = "okay";
 	};
 
 &i2c0 {
-- 
2.17.1

