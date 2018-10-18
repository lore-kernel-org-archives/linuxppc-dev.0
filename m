Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF18C67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:08:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2752098A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 23:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1uOYwXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2752098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bl8C5lqLzF3CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:08:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1uOYwXo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1uOYwXo"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bkjD2fmZzF3Fj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:48:16 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id y18-v6so14877339pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=c1uOYwXosBtCvyj575Wmy7ttuIHcMNK9WOp/qfAIhCEVXIWwLVi/nvSSksbKtHFKk6
 vwqJ/TzTagErWp2a6azNCOXFrxllNtmGdHomVGNrcs9LaXZhSjHpgPg0n2juvUueNNOA
 98H4XSt0VABliigRqjNwrv4SlO2eO68UVfqTIu8adDRz8ZSiv4gC2WqnC8U2vWyqTSqy
 zymdMTQ2RTGM2JrvnUcf7hLOPimQR6lqgxbqO3bxwegYcRLhfKZ21hR5xNpp96h4taI9
 7HBHgMMWTmtRsUhbdQNFXV+tZ2Kx27721aXVGRjvmtvpxhqoq+YNH1RjX2gYgbZZY1sC
 hUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=LD7VpU+IRk0HwJBi5JpvoZv6aJx2/yTGZ2czI+nPTpxcuDEwokkLNDtBL4K6X+umMF
 4yFPDP8CmAeO+SOI7xG91pn5cZ4AK23kxzGT7jDrtjsaWWdk3nkIW2GJm6lpikQNdccs
 uykw/MKSg0w5oLQEyGU1I4FOF9AEjQCf5T1x8oEs73TlegDA/qr2lmWiZXPD/wE6pgnu
 5LmVASK5udWUh2o+gPJjik+oBV/p1GmVdlEVG7LoDOQS5yCNB3cxkq29JgHB6sS6DLW7
 5f3NRFat4YFBdjAhQ5u4GqjsGPe5xxiQhRAI8mlrgLunTL9ixarOdtjWWu5+RxfKAdny
 xVvQ==
X-Gm-Message-State: ABuFfoiCK/DQALOZKRm2gaZHCgBtBsCUcoG5eA+rNOiQHHGJ1yDi/CAJ
 J4OnZDbyQ2h5F7204V8CgB8=
X-Google-Smtp-Source: ACcGV60ystnSRz3PymYh6lwweFjt6UrpHkGgdyEVaBm+PihEzfeJGpjawOlrkGo5MlBDcSq2mu+lyA==
X-Received: by 2002:a63:f553:: with SMTP id
 e19-v6mr29964960pgk.417.1539902894348; 
 Thu, 18 Oct 2018 15:48:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 18 Oct 2018 15:48:13 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v5 08/18] of: overlay: reorder fields in struct fragment
Date: Thu, 18 Oct 2018 15:46:26 -0700
Message-Id: <1539902796-8382-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7fcf4a812d06..272a0d1a5e18 100644
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

