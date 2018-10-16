Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC0AC04EBE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:03:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D299208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tg9xQeeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D299208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0VY5X1bzF3W2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tg9xQeeC";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tg9xQeeC"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzG6cV1zF3WT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:22 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id f8-v6so10077861pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=tg9xQeeCkWQhyodbcvSdj7q+fcOref2z2sntaCR3p7E1gnJ8305hhoo461U+aUZU8C
 /e7A1f/oQWrEZ+nxSTpeYP4Juu0L9CxsC7XQ7wcFKhCO0d1BZqKeR6YtaETtQHlFr4Ah
 zy98BikYtjnC37L8Q8LsvYfLIt2xS46xLXaLLCklO+LAD9+U/pD75X/g1JFA3zmH51Mj
 4p1hBvJTPTXsgcy638l3rD25kEItXXvGd/CL0XkpFSj3J4wWi8dnpmoBIXZvsUyxg3Hj
 UgzlTBEk6O4HckEYIlQzFVk0H2btgsH8mPQwqJwgjDekz4i+kJrJ3nv8aca95mUNYgKp
 kb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=gpxrrla54mbBHwMW4GzNmvzUsI48S74oPg8at4Ug0dJbLQxbVI1/MzR1+0xMbxSGb3
 Gd2uNfx4Nz9Sjlqk6S3RV7TVQIYx9R6b+ZuAb4pMzporfmk5ctPJlD4ZJzlnv0dN9Qfp
 /1YX07pfvpROlj4HRmgUxonAhK4DIFMpVKLc8wpXwqF7CjqQVpbVGSbbAe+VcpMz8LFf
 ULhVh2h36glngifNse0QOWYRzCIQ+sF2DjJKkOrjV/OYxpwo4zqjRuRpZDlA4gxkO6XP
 t9TJCWZ3fsHN8WlwDxS+l/Sg1uPijUKQ+o/nF8BA+4HZ4mZ2DVb+mv1wnqTn3FXkcn9h
 rSpg==
X-Gm-Message-State: ABuFfogc7wEwB73vQGk3BrHak0RY13U/d8+O0u2XF7RBqTxRpIqvXKRp
 pT4AZlPn7b7OZ3RCAc0eWCg=
X-Google-Smtp-Source: ACcGV63dcwn3CfpfcdVSxpP02cwtPNNT8Ar0b4/iVFpYNWFL+3jdOGemzpNooad64rL6NFDMHaH+5g==
X-Received: by 2002:a62:68c3:: with SMTP id
 d186-v6mr12074613pfc.195.1539657561371; 
 Mon, 15 Oct 2018 19:39:21 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:20 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 08/18] of: overlay: reorder fields in struct fragment
Date: Mon, 15 Oct 2018 19:37:28 -0700
Message-Id: <1539657458-24401-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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

