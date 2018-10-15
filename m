Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7BC070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:46:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE24205F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vddVpi1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE24205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YKVw3mhMzDq61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:46:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="vddVpi1A";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vddVpi1A"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK4102LMzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:08 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id y18-v6so8314202pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=vddVpi1AmJhyFbWAVOaSGOLGGucg2BUuxTM5wvJ2OvyCwJtjgqZm+XdzDCZpavXCyU
 OHf2twaNg8dWJQzJNbvwF549GEuholfxTpWdf1BO2ooOHKlvRDiBqzabv7gqpNNN9Fca
 xhtud/n/B/hJ1WGlCuBwNV0m29wxzMCMwqIFprGB+M+MzS/JtMy3M727yeJEgCfJ1v3V
 OJZRRR2fde/vphpuw+ehqPqGiYuvoensA4vLkD1bA0/xRGvHiaTTkA+0TimUIZWUUdhk
 4F4UroT+e6b1mgkKbGgZPNVOqrDT2jsw71tiCh2PulVy29g8I0hTnovjscE6BLugImS2
 vfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=lveiboTw8Xz7Pw+PIAcqBBC2UNLMfDPvFTOwc8nnwqlGc4dTGvIQUNQgkZ3J2lB0Pt
 PEwQAeqASzgPDaIkGRJthx9nGl0VGmjjl8AJEgWn+fbmaqu4oNZTifnq0dYKcUOFYHTU
 gVZceKTVWmbiEM6rkgTmw1MXmT9bCcwnzDSrwOh+Zz2DXD+tsw5VPUh8e0zpUKjzNBA3
 V07A09pfkBUzODG9z8PVEZybDcZ7pfaDcwLK7I5q7Zff3fW8HzrKViStlgc2W25ZDtcu
 XeojGzWronBUt3H0rEolg+J3XxKixOJu4q3NspaxiIHt9KTtvCD4JFZIYM0WznvyKqKm
 e+2A==
X-Gm-Message-State: ABuFfohdDbcOkn5E7+7HpXwfIRbIHcElLp7+RaxVMqZiBVee5NBIu0g9
 iYWVmSF+x18U+yELou/BHFo=
X-Google-Smtp-Source: ACcGV612kGF23lI/IBRSGRLXD3+AHwU4TUXp3SRw7aP+4Ccv262X6c7pQUwBVf4mxnRI6LNGyoyr3w==
X-Received: by 2002:a63:1122:: with SMTP id
 g34-v6mr13827364pgl.85.1539563167453; 
 Sun, 14 Oct 2018 17:26:07 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:06 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 06/18] of: overlay: do not duplicate properties from
 overlay for new nodes
Date: Sun, 14 Oct 2018 17:24:18 -0700
Message-Id: <1539563070-12969-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
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

