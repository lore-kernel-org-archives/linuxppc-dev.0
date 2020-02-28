Return-Path: <SRS0=/+OH=4Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED68C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0CD2469F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3aGnd/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0CD2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TPmk6nVyzDr48
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 20:45:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=h3aGnd/y; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TPkV5KGpzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 20:44:00 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p7so1037197pli.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=asx2YqYw5XNouMKJdq5b+N+FaYty16Vucm/GxcDSciY=;
 b=h3aGnd/yeZ0aS+2K8apgjs0ySyOS1EAbHeE9IAv7BfhMDnIcVFy0MXBBGD/L+vpxrt
 FImHbVDuADBXcfWb3czDfCOHzeyDOrdYeP0xlClEI3Az2ehxYekCk1Q2uYxq8ZbO9lv7
 GtYtJ4onXUn/duxRiKRQVpyKzbhfhUCuPyvuaQhBVg58ivhglEkWjJObnIkbXCB7jRC/
 dsAjrrmgeLreW0OZFsc3EqBGbJFJDb0N3cdx816tdND96zCaLuuLFi/sCuk32OxVsX10
 8/UQ73jNNZE2AFIRKrDZV4vTqwVyn1rTAK3FcZDZVGQ+9XDJzrbyL/hHwlu7zeLLxAIZ
 Po6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=asx2YqYw5XNouMKJdq5b+N+FaYty16Vucm/GxcDSciY=;
 b=qyUhsw6Leo6Ld3SOMLa/XyApLbMheEwtW70t11tZo8UqVvKPazo0rGsJl6BogA/qVu
 heD3E9OGEXdunnEmgdVpvxGVbcZa07M4gQ/BasCYzOr+oBbOHlrYQLmNR7eOgsjeMHWR
 57Sqmo9xCqfIeWsYIeRVFLSf/bgLbToFzN88nYAiJbtdaFmi5RTWygGQ6MpeTxPqhMTk
 kMNYA6bnU8h9pvbfxJWPmbMfApzPVMRnFDkiT0wn8CqIlajctZEvKV+vX/KD+Zp1Ew/G
 +R32w37Vi6Q4yEUUn2aD/dnJEnUzdPQdYwTSE9KsOb4+xQZW7bYX2biFODQuUgNeFZvK
 ZrdQ==
X-Gm-Message-State: APjAAAV6o02zMYg+lx3g5JfNE3/mFUYNCR7ZXRrL3PrV0u03SpbO+U7m
 MvPKFgvOyjQILFw/qKCcaRK7xoMLFQ==
X-Google-Smtp-Source: APXvYqx8ON2N5GymWkNxSg+KaUCP5NWnfolIR+I0ipDvVW+yhmgHVWLZ3XcKL2ChoQXSU7YBKypadw==
X-Received: by 2002:a17:90a:23e5:: with SMTP id
 g92mr3977541pje.14.1582883036901; 
 Fri, 28 Feb 2020 01:43:56 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j4sm10426460pfh.152.2020.02.28.01.43.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 01:43:56 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 1/2] powerpc/of: split out new_property() for reusing
Date: Fri, 28 Feb 2020 17:41:34 +0800
Message-Id: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>, kexec@lists.infradead.org,
 Pingfan Liu <kernelfans@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Splitting out new_property() for coming reusing and moving it to
of_helpers.c.

Also do some coding style cleanup.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: kexec@lists.infradead.org
---
 arch/powerpc/platforms/pseries/of_helpers.c | 28 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/of_helpers.h |  3 +++
 arch/powerpc/platforms/pseries/reconfig.c   | 26 --------------------------
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 66dfd82..1022e0f 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -7,6 +7,34 @@
 
 #include "of_helpers.h"
 
+struct property *new_property(const char *name, const int length,
+		const unsigned char *value, struct property *last)
+{
+	struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	new->name = kstrdup(name, GFP_KERNEL);
+	if (!new->name)
+		goto cleanup;
+	new->value = kmalloc(length + 1, GFP_KERNEL);
+	if (!new->value)
+		goto cleanup;
+
+	memcpy(new->value, value, length);
+	*(((char *)new->value) + length) = 0;
+	new->length = length;
+	new->next = last;
+	return new;
+
+cleanup:
+	kfree(new->name);
+	kfree(new->value);
+	kfree(new);
+	return NULL;
+}
+
 /**
  * pseries_of_derive_parent - basically like dirname(1)
  * @path:  the full_name of a node to be added to the tree
diff --git a/arch/powerpc/platforms/pseries/of_helpers.h b/arch/powerpc/platforms/pseries/of_helpers.h
index decad65..34add82 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.h
+++ b/arch/powerpc/platforms/pseries/of_helpers.h
@@ -4,6 +4,9 @@
 
 #include <linux/of.h>
 
+struct property *new_property(const char *name, const int length,
+		const unsigned char *value, struct property *last);
+
 struct device_node *pseries_of_derive_parent(const char *path);
 
 #endif /* _PSERIES_OF_HELPERS_H */
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 7f7369f..8e5a2ba 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -165,32 +165,6 @@ static char * parse_next_property(char *buf, char *end, char **name, int *length
 	return tmp;
 }
 
-static struct property *new_property(const char *name, const int length,
-				     const unsigned char *value, struct property *last)
-{
-	struct property *new = kzalloc(sizeof(*new), GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	if (!(new->name = kstrdup(name, GFP_KERNEL)))
-		goto cleanup;
-	if (!(new->value = kmalloc(length + 1, GFP_KERNEL)))
-		goto cleanup;
-
-	memcpy(new->value, value, length);
-	*(((char *)new->value) + length) = 0;
-	new->length = length;
-	new->next = last;
-	return new;
-
-cleanup:
-	kfree(new->name);
-	kfree(new->value);
-	kfree(new);
-	return NULL;
-}
-
 static int do_add_node(char *buf, size_t bufsize)
 {
 	char *path, *end, *name;
-- 
2.7.5

