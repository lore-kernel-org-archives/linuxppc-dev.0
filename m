Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1240FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 09:22:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C5D207D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 09:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49RnN20xSfzDqWJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 19:22:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oss.nxp.com (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=biwen.li@oss.nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RnKr3X5qzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 19:20:45 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1266A2000DD;
 Wed, 20 May 2020 11:20:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8000E200257;
 Wed, 20 May 2020 11:20:38 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 86800402A6;
 Wed, 20 May 2020 17:20:32 +0800 (SGT)
From: Biwen Li <biwen.li@oss.nxp.com>
To: leoyang.li@nxp.com, robh+dt@kernel.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, a.zummo@towertech.it,
 alexandre.belloni@bootlin.com
Subject: [v2 2/2] dts: ppc: t1024rdb: remove interrupts property
Date: Wed, 20 May 2020 17:15:43 +0800
Message-Id: <20200520091543.44692-2-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520091543.44692-1-biwen.li@oss.nxp.com>
References: <20200520091543.44692-1-biwen.li@oss.nxp.com>
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
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Biwen Li <biwen.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Biwen Li <biwen.li@nxp.com>

This removes interrupts property to drop warning as follows:
    - $ hwclock.util-linux
      hwclock.util-linux: select() to /dev/rtc0
      to wait for clock tick timed out

My case:
    - RTC ds1339s INT pin isn't connected to cpus INT pin on T1024RDB,
      then the RTC cannot inform cpu about alarm interrupt

How to fix it?
    - remove IRQ line

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1024rdb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 645caff98ed1..605ceec66af3 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -161,7 +161,6 @@
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
-				interrupts = <0x1 0x1 0 0>;
 			};
 		};
 
-- 
2.17.1

