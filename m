Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF21C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 04:48:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E93206DD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 04:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOYnGbW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E93206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44D4CT4RqJzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 15:48:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tOYnGbW+"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D49c4GMGzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 15:46:43 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id n125so4697138pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Mar 2019 20:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+lSUqYHxf5m6qNnNO/ABs+ds/pNiZupXpCUsHYtf4QA=;
 b=tOYnGbW+TgR11b1zKDEJVedO7+vKVXEJ7fqOVBix6+OETGqsGLkMEzhr/DXTkSJVkU
 QBvbtrwOnMymyt93aPc6sfyh4wMdoBeDg8+DqPD4A5r2LaBGMROGlXiViLO5u67suT3j
 wDg11rkTmaVWh+NwRdehRAzsVV+pT0wEFLJvc+zhSch6yPzdw107y1RiIjocmSdMxVKb
 aVi13KZnOywaaNZvIPSUlvjsSG2PVPsN7yrU4I1KPS5faB5b4CbPMOiWD0Cj9yJOv9K/
 M7ku+8TuxYJwnJX97tIZrI4lo3ULu7/0wvTywusdt6AnSzZeIzF6j8mvfq1s03NK8DNJ
 HlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=+lSUqYHxf5m6qNnNO/ABs+ds/pNiZupXpCUsHYtf4QA=;
 b=Zw3nuZMBIMikz4SIWxqFuOTUpzj4yl6USq7byjqzPAUAOl5SvlgYoXq4yjYnMLuHLO
 /DWuNJ2U0wLw/3ooEBPekonPWACTK0n7yMdNEtLtqzjOcvHoXg3GDeCLV1PbOyo4YyC8
 KP2PZ7aJznk+IHIQJpOlK2MXhKJHL7MYyLCIZ8/+6/yS9f9d5MTQW7WeCzex/lgWAQJz
 drzA7Lx+TGxQq28tdfawigwacMZESAgxEsJY1nfD2rAT6EJ9jDolfbeci9Qsa3J3RnRq
 L9a3W0RPCjF0E24WoySaSXeVKik5pfbo9t9Uc6auDTIiHl8dArHw+tsqcUBsmHU5dbNN
 Fj+Q==
X-Gm-Message-State: APjAAAVnXJMYrztCibxG1Znq6lWtEGAWLkMUpr95tPIOmIpMrhnpqOkP
 lThUYSqagA5PsBNU4ZYW/7Cb7AdC
X-Google-Smtp-Source: APXvYqyhC9HtoFXKHmAes4/5TOvVY4bSS4w9qJign4Vc49EgwhMbUT6IyLqjcUPuBMRHrlJn9g9Z8g==
X-Received: by 2002:a17:902:9a43:: with SMTP id
 x3mr23942994plv.173.1551761198661; 
 Mon, 04 Mar 2019 20:46:38 -0800 (PST)
Received: from voyager.jms.id.au ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id 23sm13796655pft.187.2019.03.04.20.46.36
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Mar 2019 20:46:37 -0800 (PST)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Tue, 05 Mar 2019 15:16:32 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: config: Sync skiroot defconfig
Date: Tue,  5 Mar 2019 15:16:31 +1030
Message-Id: <20190305044631.27943-1-joel@jms.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This updates the skiroot defconfig with the version from the OpenPower
firmwre build tree.

Important changes are the addition of QED and E1000E ethernet drivers.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Generated on top of next-20190304

 arch/powerpc/configs/skiroot_defconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index bf31334efbce..b3a9ea838244 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -52,10 +52,10 @@ CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SIG_FORCE=y
 CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
 # CONFIG_COMPACTION is not set
 # CONFIG_MIGRATION is not set
-# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -136,9 +136,11 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
+# CONFIG_NET_VENDOR_AURORA is not set
 CONFIG_TIGON3=m
 CONFIG_BNX2X=m
 # CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_CHELSIO_T1=m
 # CONFIG_NET_VENDOR_CISCO is not set
@@ -150,6 +152,7 @@ CONFIG_BE2NET=m
 # CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_E1000=m
+CONFIG_E1000E=m
 CONFIG_IGB=m
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
@@ -159,6 +162,7 @@ CONFIG_MLX4_EN=m
 # CONFIG_MLX4_CORE_GEN2 is not set
 CONFIG_MLX5_CORE=m
 # CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
 CONFIG_MYRI10GE=m
 # CONFIG_NET_VENDOR_NATSEMI is not set
 CONFIG_S2IO=m
@@ -166,8 +170,11 @@ CONFIG_S2IO=m
 # CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
+CONFIG_QED=m
+CONFIG_QEDE=m
 # CONFIG_NET_VENDOR_QUALCOMM is not set
 # CONFIG_NET_VENDOR_RDC is not set
 # CONFIG_NET_VENDOR_REALTEK is not set
-- 
2.20.1

