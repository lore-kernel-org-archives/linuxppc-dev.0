Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB8C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:13:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2280218FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 04:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2280218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MBtp5zSnzDqXT
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 15:13:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MBrT6ktnzDqc7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 15:11:21 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 (helo=home.buserror.net)
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>) id 1gaYb7-0000TC-ND
 for linuxppc-dev@lists.ozlabs.org; Fri, 21 Dec 2018 22:09:10 -0600
Date: Fri, 21 Dec 2018 22:09:08 -0600
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20181222040908.GA354@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: [PATCH] powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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

This is required for CONFIG_DEBUG_INFO to work.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/configs/fsl-emb-nonhw.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index e0567dc41968..d592ba27b122 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -25,6 +25,7 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEVTMPFS_MOUNT=y
-- 
2.17.1
