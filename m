Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C12C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:57:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F6F2089E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz2XI+1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F6F2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0Ms1RtRzDrDT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:57:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pz2XI+1O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pz2XI+1O"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzF1JddzF3Wb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:21 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id r64-v6so10636652pfb.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=Pz2XI+1ObqUZo1ImYBBq3zxgz48Xj61KFjDE8Byrv/fwDR3xsoNnKThcXWQ7CVJelA
 /zoexFsTfJsm4xS7+UPjlEqibbPlFZNm7i0uVfZQQVvbpgvIhAcoCENWsQ7V9W4Swrxd
 W7l549iqzGALxPUDBWQ3EH27cX467WAUPOHSSPaAqGw44o+7qo23a44cdcdr6CYIhd08
 4b8Xr/AIskYHMU5neqoxKBK1qj4Ab5sQsijSqgVOfbQEKD62oxPSZSpqLqs0raJ52zay
 pTey4Iu1LmYkZe+QctnvuNNlCW+C5nBYTGAEDM3HDqemNmynH0evHZIpaXWFfGjoEZ8l
 ffew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=W2z2RR5al8YfBNGAi9M31ZnZM0Or8dOhpWTYUk/STyajFlkWliQLHHIl2cvmNB2bqO
 D8Fzsaz7CtK8Bk2r2AE1BLdN4tUw0Y5h4Wiw71HFPebXdv+xRH1k6jBOSu+dIOyv+XwR
 YU38S8v6hy85ta8TAaUri6F4jgmawdxPMqyt0WGsjCifou/+DHoCbRn8J1D5oQWGmRJS
 TvGsj/hifaD0oDPyShaAiDvJ0oOcXzjCcxDO9jcbUQuBEHVoKSHmqexVSUXftvTanR78
 9CA/fVadPMVq/kxLjPkfCWgbHsje0dz8U8gwjrWldHvPpTVkTDugzQMBJcvw4045wTUV
 sZgQ==
X-Gm-Message-State: ABuFfojl/J0xMMDxrgrNF0YHzNO/iGy2a6WmFqJZwOaD3Za03CHsxZby
 0QDFr8KiiuLtVmxnwRqBkSw=
X-Google-Smtp-Source: ACcGV60K/M9+CikvdZOPwFw1Q5QCpd7ylyYXwlW3XonkKatKXmbeVjH6iLN3brTXbGrFHskcBfrN6g==
X-Received: by 2002:a63:7d43:: with SMTP id
 m3-v6mr18490443pgn.341.1539657558952; 
 Mon, 15 Oct 2018 19:39:18 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:18 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 06/18] of: overlay: do not duplicate properties from
 overlay for new nodes
Date: Mon, 15 Oct 2018 19:37:26 -0700
Message-Id: <1539657458-24401-7-git-send-email-frowand.list@gmail.com>
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

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 94740f4ee34c..7fcf4a812d06 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

