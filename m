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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850BDC070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:51:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016442086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 00:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMyYo7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016442086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YKdB2R7LzF0PM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 11:51:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOMyYo7c";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iOMyYo7c"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YK433WNGzF0QC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 11:26:11 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id p24-v6so8751181pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=iOMyYo7cQGkHcR4M21tMOuqmXENQrywNbXP/BiYtiQjNER4f7ceGq8FB9+tO5XgKsp
 PGa1zDu659YIwqT1kEcV1QR6bDtpD2lJY9n0rPCXI9qDi2z2lI+vl08sK/EpKQFF0kYf
 Ol4SmKQxwNBJCIu0MbhfEnQBcjakp6tlEHBv9Sj1SVc1aQSvlYdXF0enIIC+QJrUwius
 6youP2KEfv2hs+JuDsitUvzR7Us5qRBbbrlUcXMj+EgbUHRm6w45y8mFn8I6Y0B5AWDM
 UEreYywyhJcK8TL0jqKOGl3Fxdt3827T3CEI4wACtyz1mvFLS0u9rPnGm82sVgXImBbc
 +PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=B5En912awoRwJivfyaNTSn7CmURzzaXXG+XyL36kti1+iVkexl+ebEo7WZqPSOWekD
 c2DqcN09Wul6yVXgNNWGyGMOFAfrrvE2cA7+DGUHLKOOer87o3NoP9VNH658qABT5W3C
 3QziBFAzeWtpS63AB7fUpsaLRFg+Ipy91uPVzX6nwASYlEsRfwH54rHyAWu1OoVZCw66
 6f8/IXWZdDpyArK1N99kC1BElEPsLU1OSjD1ogYAVhEQTCi/eO2dXDEGxG2suW8hnD3N
 SF0P80OEO/Hqkh/LdR1nLF2lx5ttrkXrpNx4b2W2GeXFL1Ty52PcAjZ8vfptVhVZhjyM
 jQdQ==
X-Gm-Message-State: ABuFfoho2bLBQhYOSpe2dFAP1EeAkDZLXFoqK0ZhzjJM2eW1I6PbiIaX
 uhPesDPVh+mio2dF5wZTQtc=
X-Google-Smtp-Source: ACcGV616gXF14EvbCBZbigcydPI5LsDgstZBQWiK9CyU4KDlnfDthsmeNvoELqh5MZIYjt/CKZNGgA==
X-Received: by 2002:a63:455e:: with SMTP id
 u30-v6mr14101901pgk.30.1539563169975; 
 Sun, 14 Oct 2018 17:26:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Oct 2018 17:26:09 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3 08/18] of: overlay: reorder fields in struct fragment
Date: Sun, 14 Oct 2018 17:24:20 -0700
Message-Id: <1539563070-12969-9-git-send-email-frowand.list@gmail.com>
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

