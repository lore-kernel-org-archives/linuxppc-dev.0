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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD5EC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:12:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2B720895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN0C2NGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2B720895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCVw2DnzzF3V3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:12:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TN0C2NGh";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TN0C2NGh"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7P5y9BzF3Tw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:13 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c25-v6so7159385pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=TN0C2NGhYjK88hDnYMJu04tPsvFFVQF89aayf5OmNyzWECQvEkD9ulD0urAGCZP40I
 5fptg6J9R/ZumR/RQz/ABDlVWOXynH/hsJuzy4xE4l4aggHZYuslxbeEzDK7Ncw1bx0o
 d+6OuWgSdHZYvNw4OAgPK8BbD5AkaRyJvyTcY1H1LToN61kZXEfrnNqpLwq6BXuWUDfh
 T8mHJ2+ti0xk2gTVmR3tgGIcyOOfivfQae6ymBFUT8aZdJY2ZjDcqwZS085aKyrJVfWk
 u4Sz3n6iKFyfDqxdzcZQY8hWUN2opLuOSIq4Gr3jHfBQAJeWAObvyUo8ErSXj5eDR41/
 453g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
 b=ExSVrx9/UGYSQA9Z/aD4BGgtpxQowbcx8SKt0A35G+j07roXnGo2gxvMwLPrRy+Y9l
 xlC72DqvCjkNBRIeer8jcySmCOsH6snqoEzJd1lqvch3Lr4uNUhLVZH3Dm8El9LKFF+1
 pT4NeVzRXEtmd36LU3uX0xUfzo5/CkYh6yK0kDzCF1REfBGNUNNBE7ZeKWFexAeTbplP
 Pe18anaR25UWyquXq4hl/dc/197TUEOhWhbfRTNrLWGXnlIaMJJbAXmPj8EP7IFSRmrF
 6F0Znll8juzSB9JVajSSFmdhEyYF57md8kxJiQUIthQn2L1bFq1VPumicWpuxX/2MBiy
 1lXA==
X-Gm-Message-State: ABuFfoi8V2BclzxreRzX+2UgGiJcau33s49ggqnMljJp47iS6xfIiep8
 o/ZE3zGKBFz9mthN/57dEX4=
X-Google-Smtp-Source: ACcGV63QjsrJbRwU5cAl0MzKeHSMW/wwfoQ5OxrsVSViU8k1wPBAVs/y59uPeF9znxjnDgYruHnI7g==
X-Received: by 2002:a63:78cc:: with SMTP id
 t195-v6mr8146071pgc.329.1539406512206; 
 Fri, 12 Oct 2018 21:55:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:11 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 06/18] of: overlay: do not duplicate properties from
 overlay for new nodes
Date: Fri, 12 Oct 2018 21:53:26 -0700
Message-Id: <1539406418-18162-7-git-send-email-frowand.list@gmail.com>
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

