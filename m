Return-Path: <SRS0=1NAR=C5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34987C43463
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 00:22:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE4B20E65
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 00:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGBkf+G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE4B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bv7Yz6jjDzDqvH
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 10:22:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::642;
 helo=mail-ej1-x642.google.com; envelope-from=chunkeey@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SGBkf+G6; dkim-atps=neutral
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bv7V41mRBzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2020 10:19:06 +1000 (AEST)
Received: by mail-ej1-x642.google.com with SMTP id j11so13015649ejk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2020 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hqMUCWqnC8X95n93xXKHH2Uq/hu5MulcBebPHENOdFo=;
 b=SGBkf+G6Np9pJqBOPISg28JjR1ib/N8myichiaw9TwCRXukGwMZmjGJXPap9BIVniq
 DPAHoC69KnCBZo0IGapn2UwnXpCa4J8wOCCAkskbHK+rZ3V5CFNu6yIIzfxX4qF3yfLm
 JzItLWzIjlc3aclaoo/xwVGpfZkCYx+B6AplCXIFum7XKd4OPDEma8ieBV3z63J3zfZ7
 obfL0a4P/Cqqs2q4uGb69GJG74VieWhdnAoTZLLV2bLNSMTQlGevmimVWYAWFCJYPApK
 09B7fj9RYqicUoiThXjDuDth+fkByONc6nItGIUuP3MTi8bV96OhbuoviBAXYUw0pMn+
 lGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hqMUCWqnC8X95n93xXKHH2Uq/hu5MulcBebPHENOdFo=;
 b=SuapVWFHPkmE4+crwNVAMOftCZ8m9pDKnIIwHPnTgXXv9XFYoogWcfpEkkCWqJFmQV
 GGX3l94JiLThBSfocuHiEBXT85Mdwv0pFxNpTGeOGOBaojk00ifDX2E5OH31JY8EqDGS
 xumrb8MumfTjphy8vvCapvc8D83u+tWIOfpHxDKdi/29ggvUoytO2ZI8OsNAyDVDJs0W
 fyea8CbR7XbZ0jviyIiarMwvTh6NaII92oid3Q9jwXc43sFLG2AdjItZx/2cPFNsVV9K
 2jvTLxzJZhsIXnE8L5CO6X/tNCuJMHI6w7XIRoefjsTlv/u9ug3J1NH0uoV7PJilZx8P
 cwow==
X-Gm-Message-State: AOAM5333V+LrxGiOf/1FG9g6X6GHTb3RPBRW0CoYhtfIYNPp7Utrwo6K
 hBnEWaFfh7PuLXCEM5SZ5+OkhtHyGdnk1A==
X-Google-Smtp-Source: ABdhPJxNmSBiqkIfzhUTXm3NBMml7mRBIGv59XKGanZt/f9JaWrH1kRKbscUN/xtqGd/Zk5ezzEqWQ==
X-Received: by 2002:a17:906:16da:: with SMTP id
 t26mr42258394ejd.172.1600561141738; 
 Sat, 19 Sep 2020 17:19:01 -0700 (PDT)
Received: from debian64.daheim (p4fd09180.dip0.t-ipconnect.de.
 [79.208.145.128])
 by smtp.gmail.com with ESMTPSA id a15sm5326886eje.16.2020.09.19.17.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 17:19:01 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94)
 (envelope-from <chunkeey@gmail.com>)
 id 1kJn4A-000s3r-Eh; Sun, 20 Sep 2020 02:18:54 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: [PATCH v1 2/2] usb: dwc2: add support for APM82181 USB OTG
Date: Sun, 20 Sep 2020 02:18:50 +0200
Message-Id: <c8a9f98e50482fd068232deb7161f35910631bf6.1600560884.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <a43868b06566f5d959d8cfc4e763bede2885931a.1600560884.git.chunkeey@gmail.com>
References: <a43868b06566f5d959d8cfc4e763bede2885931a.1600560884.git.chunkeey@gmail.com>
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
Cc: Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

adds the specific compatible string for the DWC2 IP found in the APM82181
SoCs. The IP is setup correctly through the auto detection... With the
exception of the AHB Burst Size. The default of GAHBCFG_HBSTLEN_INCR4 of
the "snps,dwc2" can cause a system hang when the USB and SATA is used
concurrently. Because the predecessor (PPC460EX (Canyonlands)) already
had the same problem, this SoC can make use of the existing
dwc2_set_amcc_params() function.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 8f9d061c4d5f..6d2b9a6c247c 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -210,6 +210,7 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "amlogic,meson-g12a-usb",
 	  .data = dwc2_set_amlogic_g12a_params },
 	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
+	{ .compatible = "apm,apm82181-dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
 	{ .compatible = "st,stm32f4x9-hsotg" },
-- 
2.28.0

