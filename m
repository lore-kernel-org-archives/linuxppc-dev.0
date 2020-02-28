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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E58C3F2D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 09:47:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3191C2469F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpC+6iLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3191C2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TPpw1Z2fzDrNp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Feb 2020 20:47:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fpC+6iLR; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TPkY5TcRzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 20:44:05 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id z12so1238130pgl.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2020 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wWdhgB/PDGV0PP2Q0tID/JmqriQZD0sF033uwRiSeoc=;
 b=fpC+6iLRzhrsdDEgptCfRQB9cnLs/TGVhNTEL5htfzhLxCATFKkdEtopbzwDe+mhgl
 OfB/OSnvrMXzjXR8ZySnkEHWtLYSgvqT12XRqmsMR9cQ/hS/FsDWVzwW1iwkeNExYACf
 TUlC+VgQyYgZey4v469aKEtXyzsFQLliP1xlOw48nLHHOXndH3FSi/4Xw2A/MeLPMloB
 RISFkzLgQbYTTgi8br+705O/X2lwk1hARCWlmjHUvDotjvt4x7t8uHtUMD6p+3Gw6Ey6
 +pODjSRGDd8kb0T3hf9vAFKBL/up/6Gn4YQpuRGX5oF0YFZbguw5ywLSq987iS6rpTEN
 bJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wWdhgB/PDGV0PP2Q0tID/JmqriQZD0sF033uwRiSeoc=;
 b=h9emjXzu4KdpNbPiBAKMF/Bd9GN64r1RI/i5k9jkTeMQG1Yau425fxdG2Mc2U0/SYu
 Di6om8+hcvyPqjCxaPKSKKSj5h7n4mHGlBlphhHJNDxNXwy2wvd9kOvPzwTGWQ5bnWe6
 CW7ypl1khKz4l1EyuNjZ58aB5TVuJ7xvDN2I/Db23vfk9rs91ZiJ20y1HB3uKICQyg0R
 5RLvgAJ0TOWzeP2MMdv6hkCcth7M5tB98+yHNO08KzqCr3yweJWbVK0vy4LiB+ubNcY1
 dRjD5D/pp82R2Y2BP/jUW2tg90dfVQvVweGoSNkxCovz4EGg4o3Q37u86cW2b4y6jknB
 2jhw==
X-Gm-Message-State: APjAAAVw2P9rxtQWPy2Z8wExOd2cF7eC3WK5n/Tj9XZ+hZjHf1YieCRT
 9hlYPQNuwCGAk4w2tPIgUU5vX877+w==
X-Google-Smtp-Source: APXvYqz2MfKu7l6HTVd+P0hvLe5Pb4QGOSdRWQrIeeW4KSqtMb7m2sTaJsZ1mJ+OiXB7O25pHH+i5w==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr3680046pgi.33.1582883042504; 
 Fri, 28 Feb 2020 01:44:02 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j4sm10426460pfh.152.2020.02.28.01.43.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 01:44:02 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 2/2] pSeries/papr_scm: buffer pmem's bound addr in dt for
 kexec kernel
Date: Fri, 28 Feb 2020 17:41:35 +0800
Message-Id: <1582882895-3142-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
References: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
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

At present, plpar_hcall(H_SCM_BIND_MEM, ...) takes a very long time, so
if dumping to fsdax, it will take a very long time.

Take a closer look, during the papr_scm initialization, the only
configuration is through drc_pmem_bind()-> plpar_hcall(H_SCM_BIND_MEM,
...), which helps to set up the bound address.

On pseries, for kexec -l/-p kernel, there is no reset of hardware, and this
step can be stepped around to save times.  So the pmem bound address can be
passed to the 2nd kernel through a dynamic added property "bound-addr" in
dt node 'ibm,pmemory'.

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
note: This patch has not been tested since I can not get such a pseries with pmem.
      Please kindly to give some suggestion, thanks.

 arch/powerpc/platforms/pseries/papr_scm.c | 32 +++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 0b4467e..40cd214 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 
 #include <asm/plpar_wrappers.h>
+#include "of_helpers.h"
 
 #define BIND_ANY_ADDR (~0ul)
 
@@ -383,7 +384,7 @@ static int papr_scm_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
 	u32 drc_index, metadata_size;
-	u64 blocks, block_size;
+	u64 blocks, block_size, bound_addr = 0;
 	struct papr_scm_priv *p;
 	const char *uuid_str;
 	u64 uuid[2];
@@ -440,17 +441,28 @@ static int papr_scm_probe(struct platform_device *pdev)
 	p->metadata_size = metadata_size;
 	p->pdev = pdev;
 
-	/* request the hypervisor to bind this region to somewhere in memory */
-	rc = drc_pmem_bind(p);
+	of_property_read_u64(dn, "bound-addr", &bound_addr);
+	if (bound_addr) {
+		p->bound_addr = bound_addr;
+	} else {
+		struct property *property;
+		u64 big;
 
-	/* If phyp says drc memory still bound then force unbound and retry */
-	if (rc == H_OVERLAP)
-		rc = drc_pmem_query_n_bind(p);
+		/* request the hypervisor to bind this region to somewhere in memory */
+		rc = drc_pmem_bind(p);
 
-	if (rc != H_SUCCESS) {
-		dev_err(&p->pdev->dev, "bind err: %d\n", rc);
-		rc = -ENXIO;
-		goto err;
+		/* If phyp says drc memory still bound then force unbound and retry */
+		if (rc == H_OVERLAP)
+			rc = drc_pmem_query_n_bind(p);
+
+		if (rc != H_SUCCESS) {
+			dev_err(&p->pdev->dev, "bind err: %d\n", rc);
+			rc = -ENXIO;
+			goto err;
+		}
+		big = cpu_to_be64(p->bound_addr);
+		property = new_property("bound-addr", sizeof(u64), &big, NULL);
+		of_add_property(dn, property);
 	}
 
 	/* setup the resource for the newly bound range */
-- 
2.7.5

