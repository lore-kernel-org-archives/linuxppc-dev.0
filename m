Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7261DC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 19:26:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0D12075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 19:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nOvrAq5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0D12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fZ021wGnzDqMM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 05:26:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org; envelope-from=mchehab@bombadil.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="nOvrAq5S"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fYwj5bv0zDqMT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 05:23:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmBdTZ6oZZ2ohazDbNmfaTnFHgD1lhGpRbyHozB19dY=; b=nOvrAq5S37WwJevtw+HTqm2/PA
 nOkxq9zrPgVHoWXLUOa0F4Roo8DZMYkkbU8W9L/W8TQq0duQW9Bz6D7U0G+g8WlQi2e8GX3K4271+
 W7ZSg12W0jSw+1SF7CLdcO6R9i5RKbZtp9Ogd1EVQrvI0Taf9EXeBUD+Tn+/hiXHcObPnrdc4L5XQ
 MHbGvrMl2wvw1tDQxVK8RpMKFMew1NqSlrLuT1N9YkpkfSPz3YUt6MnjyuG4MI6m+8wYZN0oe/QBL
 qRDEa0xetYFvgg/yYgNs7GcNX+96zsg1AeX8h2deinIciuvsaMZ8Yq9SX9a7tC4Xt8rVwdhiUbBff
 AB7JNCvg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23]
 helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEIoQ-0003RG-OI; Wed, 10 Apr 2019 19:23:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
 (envelope-from <mchehab@bombadil.infradead.org>)
 id 1hEIoJ-0000z8-0K; Wed, 10 Apr 2019 16:23:03 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v2 11/21] docs: hwmon: ibmpowernv: convert to ReST format
Date: Wed, 10 Apr 2019 16:22:48 -0300
Message-Id: <2f6f8109dfe2f212dfc1b9be7447c9b17a720bf8.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Paul Mackerras <paulus@samba.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ibmpowernv to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ibmpowernv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 56468258711f..3f1feae3901c 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -2,6 +2,7 @@ Kernel Driver IBMPOWERNV
 ========================
 
 Supported systems:
+
   * Any recent IBM P servers based on POWERNV platform
 
 Author: Neelesh Gupta
@@ -29,6 +30,7 @@ CONFIG_SENSORS_IBMPOWERNV. It can also be built as module 'ibmpowernv'.
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
@@ -78,3 +80,4 @@ currX_enable		Enable/disable all current sensors belonging to the
 			0: Disable
 
 energyX_input		Cumulative energy (microJoule)
+======================= =======================================================
-- 
2.20.1

