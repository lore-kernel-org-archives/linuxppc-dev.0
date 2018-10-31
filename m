Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62356C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 07:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40B220821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 07:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40B220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lK7W4KRGzF3KZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 18:03:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com; envelope-from=andy.tang@nxp.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lK5G4Q52zF3G4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 18:01:54 +1100 (AEDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 950EB2000AB;
 Wed, 31 Oct 2018 08:01:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91ABB2000AD;
 Wed, 31 Oct 2018 08:01:45 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E4632402D6;
 Wed, 31 Oct 2018 15:01:37 +0800 (SGT)
From: Yuantian Tang <andy.tang@nxp.com>
To: oss@buserror.net
Subject: [PATCH 2/2 v3] clk: qoriq: add more compatibles strings
Date: Wed, 31 Oct 2018 14:57:36 +0800
Message-Id: <20181031065736.32719-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181031065736.32719-1-andy.tang@nxp.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yuantian Tang <andy.tang@nxp.com>, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add more SoC compatible strings to support more chips.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v3:
  - undo deleting old bindings
  - split the dts and driver to different patchset

 .../devicetree/bindings/clock/qoriq-clock.txt      |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 97f46ad..c655f28 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -28,6 +28,12 @@ Required properties:
 	* "fsl,p4080-clockgen"
 	* "fsl,p5020-clockgen"
 	* "fsl,p5040-clockgen"
+	* "fsl,t1023-clockgen"
+	* "fsl,t1024-clockgen"
+	* "fsl,t1040-clockgen"
+	* "fsl,t1042-clockgen"
+	* "fsl,t2080-clockgen"
+	* "fsl,t2081-clockgen"
 	* "fsl,t4240-clockgen"
 	* "fsl,b4420-clockgen"
 	* "fsl,b4860-clockgen"
-- 
1.7.1

