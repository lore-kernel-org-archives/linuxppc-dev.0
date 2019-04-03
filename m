Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D638C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 00:51:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6646D2084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 00:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ2RTc8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6646D2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YnZT5PyhzDqQL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 11:51:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJ2RTc8l"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YnXf6dpjzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 11:49:37 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id 188so7232067pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BeQamHxxl8/umvsBARok3v8l+l2foWC2Lgr4/q+UCrc=;
 b=PJ2RTc8lquejAKYF7qYbATxo+igNrFuJNyD+28WnZecNuVMSb4QWIXqepPITU5h3Me
 vwlks4krEJra90EXfRvIOYYlH8MqgiUVtbQzYdMAdMLTtdMa/w2td/q3YD6S7o9LonQB
 x7RmGlHo1rwIbPKJcVi11KDXTy63IW3lV6MNF9W8zZUSy6Bgr8/+/WAOk9oRqeGbR4r/
 RE3u8QDypPjItebcWnuxwP3NVJa9YC0KMIK743jEcuVrXyUS69B0G7fBbEcND56TsbZ8
 xGEA5sIbUBUEFUw5LEVWzKYrOCR3602KTngd03y6Q+lEawMTrrxJE/dA/JewnNKJvgnl
 SmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BeQamHxxl8/umvsBARok3v8l+l2foWC2Lgr4/q+UCrc=;
 b=e8ljVf3YTjidEpjKORhApuafxQHz21yZjxMWiMhYpDDApERdj1gADS4YRoLhLKUfeg
 JZs5V3jksLe2O2xb8TktfaYAG5UMssMYI3wyr2zHyPp8Y10yIOQa8PcATnwaOoggXGA0
 ueJ8weLGp+U9v29FMKXAkpFb2uNpk9Odr2QuAXEpfY71/HgMdy4p/09xWZkPkMqKti5j
 AWbJXA+BEQGfT8zpFaKuVHohUKIoHMAa0rAa8lWysBfjPwnZjcQ8OjXuM2kBparg0MbK
 gNx+A6Rfq1xChltIi869b2XPxfZEaGKDB3dREApkdpwijjxtfKKGe3fNBPQ4RKMC+jBd
 suiw==
X-Gm-Message-State: APjAAAVbEM+J14tyCRRMAjg7Pgqte/8qrfF+2wrjCtdAk82DdAjXbdSL
 OnQs0CoFQ4ytNmL8iJplU2EgL8W71dSepA==
X-Google-Smtp-Source: APXvYqzmgwwV/mQITBhVWf7n77ilWRCkdLhaDds7cw6WdgV30FVj4yOsJxsCOVhY+Acwso0sq/O4DA==
X-Received: by 2002:a65:410a:: with SMTP id w10mr69408647pgp.206.1554252574288; 
 Tue, 02 Apr 2019 17:49:34 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id e184sm21904862pfc.143.2019.04.02.17.49.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Apr 2019 17:49:33 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Wed, 03 Apr 2019 11:19:27 +1030
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: config: skiroot: Add (back) MLX5 ethernet support
Date: Wed,  3 Apr 2019 11:19:26 +1030
Message-Id: <20190403004926.6702-1-joel@jms.id.au>
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
Cc: Carol L Soto <clsoto@us.ibm.com>, Stewart Smith <stewart@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It turns out that some defconfig changes and kernel config option
changes meant we accidentally dropped Ethernet support for Mellanox CLX5
cards.

Reported-by: Carol L Soto <clsoto@us.ibm.com>
Suggested-by: Carol L Soto <clsoto@us.ibm.com>
Signed-off-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 5ba131c30f6b..6038b9347d9e 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -163,6 +163,8 @@ CONFIG_S2IO=m
 CONFIG_MLX4_EN=m
 # CONFIG_MLX4_CORE_GEN2 is not set
 CONFIG_MLX5_CORE=m
+CONFIG_MLX5_CORE_EN=y
+# CONFIG_MLX5_EN_RXNFC is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
 CONFIG_MYRI10GE=m
-- 
2.20.1

