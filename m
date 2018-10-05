Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CAC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:36:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C4820834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPHDFL1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C4820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RH5c2vNkzDqsy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WPHDFL1A";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WPHDFL1A"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGc02tTQzF3Fk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:24 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id y11-v6so3043158plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aHk2/msirjmyKqS+4FgQGJlEqHm8O56cobU/W37vLhc=;
 b=WPHDFL1AZ4qHSKkELUE2W1LvCrnK6Pxi8/u4Gxz7KiTGTf2de0QmdT8Dpjo90P2m50
 tBLYvaNIeDrkpCXs5dSvLOloAqmcZJyfUNsU+wtkKNStmHC/lmU5rGpSPeOUWshkGI4U
 3DIoYXkLaRQI6NpX+4XS3alki+OyGC+MXy2YJ9QpsYnZknlzAu75STLnCPs76y3je3YB
 csaYIytF5bx1OxdE/uIl0V1v5FhuVPH5qN3legSD4bV7qal8t0e+R9kw23xhoI1VrgHr
 rTCD6MSXx02IxTgsB8no6OvCzU1aJ2KJWbapwUBCkUR2Sg/gUBN8VzEOTqiRWP0FWlyz
 1BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aHk2/msirjmyKqS+4FgQGJlEqHm8O56cobU/W37vLhc=;
 b=UqHqcWvNb2isuc30BTPqxBBsxRXVI+Sw07KLcXUBTq2Mf3crX3j9+1idQql1jg69fJ
 eTUKwdD/Arkk/XfZCkhzodVM7GlcdIQqL7RD4L9kUZ0ooCMFROGjPSj6ewR6I583wBGA
 7QJ0DPClAEttLrZzwcWRymQbaqOTpV6J+mafIOIM8KPfnVGib3CQPJVVnZ/exNFpqDNU
 KsYbko1kvKVFM4U3vDIVKO8dD+4xsYRBpKqpxKruu/PiPzaqFPcmG8lQ+pCStQJaslO9
 XOyHO7f2QwkBTPfwex60WALJTc/7Vo4fdssMeWUtTTdh4q0BG+2TWt37zlv3lEcL0ER5
 GBLg==
X-Gm-Message-State: ABuFfojaz/QYsKQXiAx6F7C6kqWgJPoRg5w+8YIZzFONiswWHZTydQwH
 aKpCeE3yz+F9PzQ3+OGhsWw=
X-Google-Smtp-Source: ACcGV630SMvEEH91kwNT67O2vqkxPbPUjcKTqO0n6Bwy5xOdSqnPdJwHrDaByoBnEzLWOL/j30P/3w==
X-Received: by 2002:a17:902:8644:: with SMTP id
 y4-v6mr9699660plt.48.1538712862216; 
 Thu, 04 Oct 2018 21:14:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:21 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 08/16] of: overlay: reorder fields in struct fragment
Date: Thu,  4 Oct 2018 21:12:39 -0700
Message-Id: <1538712767-30394-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
index c113186e222c..29c33a5c533f 100644
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

