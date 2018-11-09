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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E713C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:25:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131CB20840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD+xGwnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131CB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rqrc1P69zF3ZJ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:25:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aD+xGwnU";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="aD+xGwnU"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSp3TcNzF3X0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:07:54 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d13-v6so453015pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
 b=aD+xGwnUvNx7F6b5urQpDG08DAJqs9jR2F8TYWw1qtOia26z4rR03LnvPYrfajbXLB
 RR5CNLZbosvqOQHPkylM8pddXfa7QTqT7CgU7GJ98FDCwjnH23YTcxJnU4r/d1xW2XZE
 UT3Eh/eeXGhyG6vbrvp5M+foTwbUxJIE2MZbQqEbfs0PEw6vlrtmOp3H2iVnDKBJzI5H
 K2fDD9UA/fFaZlQIt8n41Izu0jSKhILi7ue+b2ZlvBnaT1z9eOspkucRPofNoBYJXN88
 j58myxzYKAW3evN+SmeTuWMrmsQpkofTnsyT6JL0AB2tIFjqmUXI9AP/gRbA5rkxyi2d
 0+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mDWmpK0OiVEqlMHbao8c5fx+Nz1R8IrIrFeiQ9xLgiE=;
 b=UWOyd6lZC/dI11Fg+Wh6+SFvo4tZE+NzILUd/1LZhFqC7T8o3h+2a9b5x24Tj7jv8f
 WKe3fa3Mg3gn6Su1w8mvHTn6SprJlajkzWtQvQKQ2MN41M84l2e3Ur8ek0TY9AGqNAcZ
 Kgj8YtgHMNGXA+xql9krxqv2jt3mbTSuGbY0uFUaumOp7n1+kh8xBTgQkRc/zwze/G+4
 WWMRCk3DMG2hS3PPsk/pj/4jhkl+BpblWPYNl8WbVTY2Qz9B2cR8m3w037v3tfiDp6JI
 GEcM2/4dFA44X27FbEyTBjucxIh6YOFW5uwCbEsOgA2WhSFPAGqU7bYwkq2z0yWuE8M5
 IAxw==
X-Gm-Message-State: AGRZ1gJXbR9ZfB8hOPA2JCUp1cqQiSov/9mTqhFs+IEdrG+/YPD1JL/h
 D7eVViTiA8Hi30+92Idsve4=
X-Google-Smtp-Source: AJdET5fsZmSstsbi43stjFnRnWNJknkhYNkENqZsgyaNhzHhVlyaud0easBVeFglZJBFloKafLiWXA==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr7629189pfs.6.1541743671902; 
 Thu, 08 Nov 2018 22:07:51 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:51 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 06/17] of: overlay: do not duplicate properties from
 overlay for new nodes
Date: Thu,  8 Nov 2018 22:05:54 -0800
Message-Id: <1541743565-23163-7-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 6fd8e6145e10..9808aae4621a 100644
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

