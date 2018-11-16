Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB34C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:13:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54BE2086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 22:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54BE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xXYR5pCDzF3jL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 09:13:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.66; helo=mail-ot1-f66.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xXW34gRMzF36j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 09:11:11 +1100 (AEDT)
Received: by mail-ot1-f66.google.com with SMTP id t5so22780383otk.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 14:11:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dm96ml3cZNVLC3eH890iFCugyIdMvaya0M2JyB3z1mo=;
 b=XmKvZgB+kM9+f+v56aH35pswbf/MtorLv4AWQ3WdUd7kaHEjO6h1TqECiYYRQJ/27m
 GyCCKONR5pYg+cvWVNDMOA5NaCXfJ0jzLMpmHLupkppH5gulxDMZ2PP+cwGa5QeKyjFm
 1EjSRe3nhHbQBhK1cZSNkXoV0h/OMF/ouGm6GjqzvZRqRlMaliC+wiWMhQxZ5GpNykUx
 YQvcZinSooJgP1DmHcb90ALiJ56vEHkCAH7XzGVslnM9S43ebDrg7iJ8/2vxPTtciVgA
 Pu+RCnS6FF/FxxQfA0cW29vEjLtRuwSj8Wkbx/mYl9znyBooQaJgEIodJcL/vbqlw2WZ
 rgkA==
X-Gm-Message-State: AGRZ1gL+PpHpWkEd9k5cdBQzwdm3RIdk6xgdz2bc9863KzK8/g2zr6s5
 EnLZpk/ZoH9F8XEq4jcVeQ==
X-Google-Smtp-Source: AJdET5dNN4gUHZyvBz+rVWnFbgEJaLp+TdTbHCd2q7CntIQ2dQJVLTZbWNJVnIJDXpLglNVm2oJPDQ==
X-Received: by 2002:a9d:2c94:: with SMTP id p20mr7089642otb.92.1542406269333; 
 Fri, 16 Nov 2018 14:11:09 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net.
 [166.173.57.127]) by smtp.googlemail.com with ESMTPSA id
 p204-v6sm12142631oib.25.2018.11.16.14.11.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Nov 2018 14:11:08 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Rework btext_find_display to use of_stdout and
 device_type helpers
Date: Fri, 16 Nov 2018 16:10:59 -0600
Message-Id: <20181116221104.23024-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

In the process, the of_stdout pointer can be used instead of finding the
stdout node again.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/btext.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index b4241ed1456e..488b0875ed66 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -232,20 +232,12 @@ static int btext_initialize(struct device_node *np)
 
 int __init btext_find_display(int allow_nonstdout)
 {
-	const char *name;
-	struct device_node *np = NULL; 
+	struct device_node *np = of_stdout; 
 	int rc = -ENODEV;
 
-	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
-	if (name != NULL) {
-		np = of_find_node_by_path(name);
-		if (np != NULL) {
-			if (strcmp(np->type, "display") != 0) {
-				printk("boot stdout isn't a display !\n");
-				of_node_put(np);
-				np = NULL;
-			}
-		}
+	if (!of_node_is_type(np, "display")) {
+		printk("boot stdout isn't a display !\n");
+		np = NULL;
 	}
 	if (np)
 		rc = btext_initialize(np);
-- 
2.19.1

