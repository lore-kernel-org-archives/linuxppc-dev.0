Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C3C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:13:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1822084B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt0dwQqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1822084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xhqd5vWhzDqMs
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pt0dwQqw"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xhnk5SpXzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 17:12:10 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id z5so2980889pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 23:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=utxswtJJ+dRCea30iGSLjFY6Yy31vkXkff+lFsqPnHs=;
 b=Pt0dwQqwNRuXwhXvPPakZs/qkwhGEjATPk3qrc+v+4V+NrDN9hCnQiqv0bw47dKj3B
 oFP4WyNH2XP8+c2w6kTxOuvos79Jv+6GCaZ1GD5HANUTJAsnYHM5xtVt+f2uJpmMUXkl
 lG/5II65nHX6L0qgzGfYxJjnsbEolNnno8BrTp6TCLlqf/Qjjlj4SJ697xnlMOXQhQ1j
 naeg7qEYNtQ76Xye+d6f4OyyGRMt59i048eUcZeHsLPW3IDxDy1KopxtHipMTkzVK/tu
 /qEs7H332HqPtu8Mi/szooQEh0oD6HPyP6LTob/PENNDVIE+4YJeBK86/lFG8IHyVPY2
 kpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=utxswtJJ+dRCea30iGSLjFY6Yy31vkXkff+lFsqPnHs=;
 b=U2WX+coxD7KVidD0INEUZxPa/kOQ6G7yNiJZOp9LdsK5yQVbx3GCuroNkydm4t6T8q
 0NZiaZle0uJJaIPWp9cEX1FPgATxzQeIFWlzssuJrcb8I52Ae5BdJVEvpyXnvlsvFvE2
 5Ng8qEYIzMIPiMx3ca/uSoAufxz0e2zCM13axtNwtE5n4i1ixfFwaO/ooZ6TGCzMSAZN
 9+rWwcBJda3GEgMU9CgxaSuYb02pomL3gQYWkMVC1pd4pYoup3ZShVRogSfdbQmkmRkN
 0MvcDtdj1AaDGHev0QO6m2GPRYRSR0YQKO7dXzAJR9TduFUlJSYz969paxl3ZzpsEhRM
 FrHg==
X-Gm-Message-State: APjAAAVbk9uUFI76NXi9djUZaMrlCmsla4R3DheZQlo4sS2kCSgZcwn+
 bjiIEcMKmirzkhWZ4KADfa0=
X-Google-Smtp-Source: APXvYqzOwFNqiYRFhdtUDcIVxvJoVtRUMeMwtUGesVDp9UUsBGZXGjJoN1QMoeg5dXhnv3r3p+qrkw==
X-Received: by 2002:a63:6fcd:: with SMTP id
 k196mr46906200pgc.238.1554099125427; 
 Sun, 31 Mar 2019 23:12:05 -0700 (PDT)
Received: from voyager.jms.id.au ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id a129sm26783916pfa.152.2019.03.31.23.12.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 31 Mar 2019 23:12:04 -0700 (PDT)
Received: by voyager.jms.id.au (sSMTP sendmail emulation);
 Mon, 01 Apr 2019 16:41:59 +1030
From: Joel Stanley <joel@jms.id.au>
To: Michael Neuling <mikey@neuling.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Documentation: powerpc: Expand the DAWR acronym
Date: Mon,  1 Apr 2019 16:41:56 +1030
Message-Id: <20190401061156.31366-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: linux-doc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Those not of us not drowning in POWER might not know what this means.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/powerpc/DAWR-POWER9.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/DAWR-POWER9.txt b/Documentation/powerpc/DAWR-POWER9.txt
index 2feaa6619658..f6c24e54ce83 100644
--- a/Documentation/powerpc/DAWR-POWER9.txt
+++ b/Documentation/powerpc/DAWR-POWER9.txt
@@ -1,10 +1,10 @@
 DAWR issues on POWER9
 ============================
 
-On POWER9 the DAWR can cause a checkstop if it points to cache
-inhibited (CI) memory. Currently Linux has no way to disinguish CI
-memory when configuring the DAWR, so (for now) the DAWR is disabled by
-this commit:
+On POWER9 the Data Address Watchpoint Register (DAWR) can cause a checkstop
+if it points to cache inhibited (CI) memory. Currently Linux has no way to
+disinguish CI memory when configuring the DAWR, so (for now) the DAWR is
+disabled by this commit:
 
     commit 9654153158d3e0684a1bdb76dbababdb7111d5a0
     Author: Michael Neuling <mikey@neuling.org>
-- 
2.20.1

