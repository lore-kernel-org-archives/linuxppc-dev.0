Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1202C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:27:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BC320840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXAuPkwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BC320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rqv31zHkzF3ZR
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:27:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="uXAuPkwp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uXAuPkwp"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSp4sl6zF3X5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:07:54 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p4-v6so451075plo.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
 b=uXAuPkwpjK5d2wkFBfA15bHp5YEAdco3syQlybhjVOk6eRc6PqYfuwOvIikYU7Sduz
 J9hoFai92icnDyMiQ8R4UwmH1tzI9O3gftndo8Uosv1QtcKrhXRJziT6ZFnK/Kf+bBs6
 WRmuoCWCOs1Y3Bk1wKOYP5FYbbH2puwFDmn1Gf3TZ2OLKBOBAK8PS/5P8L0DnWDw11Ar
 Gexpgzt5EZ8W+c+AbOhNpSUCJ7jJNlig6eesNXolZ4PlJjTDIhLubBnHA+UKoFMFY+3l
 K0Gmlt2Gw/sjUvIaDxl/6wamCeWdabwB8KjbFRPlgzt4CacgXFfR2CdIw9UjdeB6AES1
 hYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
 b=lcg9WJHwxYoTVJvW936xAdAoncjJb6nKzryYYhCpoU2nqkNeYgmOe9MSgqoE1T27tM
 l5VBxEgYRAS92XevWnrOxFC/5apS+1uYgXaSFlfoMWDDHC1P91kygHqu9zwWe/f59RQI
 cuqon6Qw0M2YL0pJEa6cg2ltphxr8vlYDsBU4ewO4orqicqGzXwUGKzWTfaI0nnS8PrG
 6EmWMMO1Xm2p2t/mhq5miDWPO8NYtAXt0TZlmhKQnIvTEDfvrR1lJjescGWmjWZRnl9p
 T4IiPhC/SMqs5y9ylURM0sVzTjgg2NawDCHVTIQLC/+OsIQpz4HyEPdYdcFxZt73wqQ/
 5Nsw==
X-Gm-Message-State: AGRZ1gKHhRRYz92JN0PPSBX5dORM4/MJfFx5ZDDKshS1MVps/jM4E7F2
 Y1O7/Jk27f/FtxTt8tKnFN4=
X-Google-Smtp-Source: AJdET5eBIxc+UbyHaV3Ux578DGKF4+kfse3jltkLRGCS4puaAnncK61U7RApJJ2GBt90dXVKS5NrRQ==
X-Received: by 2002:a17:902:ab83:: with SMTP id
 f3-v6mr7368701plr.122.1541743673139; 
 Thu, 08 Nov 2018 22:07:53 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:52 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 07/17] of: overlay: reorder fields in struct fragment
Date: Thu,  8 Nov 2018 22:05:55 -0800
Message-Id: <1541743565-23163-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
References: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 9808aae4621a..15be3da34fef 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

