Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCAFC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:49:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311F72085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpgZ3o/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311F72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcYn13slzF1RB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:49:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bpgZ3o/d";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bpgZ3o/d"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3s06PNzF197
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:05 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id i4-v6so4372198pgq.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
 b=bpgZ3o/dLLW5JQfdO2WtI3t++aSL1ev4v/ap+54HN0AWZT9trya4mbc8xf8I4SN45O
 2ooTizEquN5TrxEPJeubz+e3DNVEuy05lp4PyVOYTxg3LM6HwlB1gWf8+h3WQfZIY96N
 G5f3YVG1w9mQLKVWSW2lTHri1FUE2NGxH6muHD5AZyJepz0owgKKXVqGXEklCwiL+JvJ
 NEK+b6pGaWCy1pMHMMEo1/3+9U6V+xVg4FbNViDDq+NDlHjEWp3GHhSbD6IKAhm+F4Wp
 rNCCGrq4fWFn2spKrt0k3/EnhVJCy9ZOPKOEVlyHiKTlCLMx8ov/wFvzbbit4MMq6sbG
 HTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jF7CtwoKyOCOUUznnCb9oRyK4jRjdXLVVX13D8F3sAE=;
 b=He9BVhSvtMBxKFxIWassR1oxO7R+mmXBHYpwQH4PH5z3s4xKjBI5Z+06mz3i6HTkYF
 m57hMeCv1yuWpy6Mq/DQTo+BiYn90Ye1A/8G7+wbM+LD1lrfDBENvdkHiIHALrT4iR3N
 h/evHuv4jO+6preJ/3u2/KZvaaOvc/PUPvSv8U9XuGBcAypZDL2ynej+1vLlpa1g6lda
 Bw8iftT9ng2PyVOHUXlZ/Jfh8+762vL5XoVHrKRUInCNhO29/gC17hqbMcwQHOi/RskU
 SjsUQHX7tQ2tjW1apTl9ul4+mfl5m/6jAoIdy5HPHZXoq/Ha8EG6JaGi6PloN25qm/kx
 r3GA==
X-Gm-Message-State: AGRZ1gIv5cg+lSFFxrS+uQJvXMrC3ZagKm+YHVOU5yE6D5t80vDfDlez
 IrybjAkiyMsPgyl5bBG/9g8=
X-Google-Smtp-Source: AJdET5d3U+86JkkVAwDoC/NH8Ul07GZpAGbcOuoc/UWSGneCrAC2sd/MiP6Np5IF47sJJhVtgD0sgA==
X-Received: by 2002:a63:4141:: with SMTP id
 o62-v6mr4073305pga.370.1541431622887; 
 Mon, 05 Nov 2018 07:27:02 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:02 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 08/18] of: overlay: reorder fields in struct fragment
Date: Mon,  5 Nov 2018 07:25:05 -0800
Message-Id: <1541431515-25197-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

