Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A9C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:16:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F65920895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9auGlgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCc02nTszF3TB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9auGlgy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9auGlgy"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7S2B4vzF3V3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:16 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id l81-v6so7167002pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=O9auGlgy9Z0x96YJvAYLdz2ST9vhVjlVWQVyAFSXEZqJqvQgoJSMX7PUxtVv1htyyn
 j6MdDUExsrb+fu88348j/h+zw7BCl5yhPdLFjcEkrNSH1Skg/Ts0bqF6I8ef0P9rkG0Y
 4DbhknmzACpRxV1Gi2+1QuiTBqjX3xoXRGk3TMrb/nRl2JfSMvRwWTwZLxkxe+SOkD/I
 Zi7Ot06wyBOXbR/93+NNuhw/zpkVy/N1wS5lFroZjDp19WXcpzEjinIKuOpz18QDVgZu
 4amOrTXFE15X6J8FYLvgmFFR9R2qZZATrL/ozteZDrt4glo8NVTOnCqLOJC3W7VhUPVP
 B3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
 b=KuEem+O/ALR80upDKuZSpJcZPXCA5roJohA53ix+yo0bZkAHHSJVMg2ed26Mksz/N4
 hn3MMrQyhP42+/799noSZwcfkFMKUS0UZMmfAyTKyN/tD7YzkNvFPAH2eK41SJYdJT5d
 P29o8CpGGRwet6/QyACypjZMIwdplm+eudjVE69Wzmh9bovlZEIZLh8TLNiFbHzlHdzu
 vNIY8Wjr9dQYzKW4ClKnuJbqI3wPj2AWlb5+W9N5AxtfZR+vu3Zmy3axPuG3TBadZK7o
 gTNGOuGxg5IW2CyNQakkDnBtNHqz2mbsoOjc0xYAGlqGxYg6B6tjRyTv2sicIH1/SRhP
 WSDg==
X-Gm-Message-State: ABuFfoi7R6xEg6HmXcunnqPYhI04OSI0KmgsNhYyVkGc+byJoTr3Z8J9
 0+2tup5eP4wchziQu5XeNxU=
X-Google-Smtp-Source: ACcGV62/3cjHH3VSCDcqLdDQDe1vjv4RkZlK643dZfhmlauhKbpks3bxf0tdhPRVcJpdfMly1+U6Ig==
X-Received: by 2002:a63:40c2:: with SMTP id
 n185-v6mr8236018pga.116.1539406514759; 
 Fri, 12 Oct 2018 21:55:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:14 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 08/18] of: overlay: reorder fields in struct fragment
Date: Fri, 12 Oct 2018 21:53:28 -0700
Message-Id: <1539406418-18162-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

