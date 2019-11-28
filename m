Return-Path: <SRS0=QEr8=ZU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9AFC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F479217BC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e4aBLwHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F479217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47P2lC73V3zDqxV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 03:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::243;
 helo=mail-lj1-x243.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="e4aBLwHS"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47P12r3h1TzDqsw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 01:57:40 +1100 (AEDT)
Received: by mail-lj1-x243.google.com with SMTP id a13so5670951ljm.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MvM6nM6rYnMj/7VFTI0rv5G9KH57+NDrgUtr1bVU1Oo=;
 b=e4aBLwHSEzy8sONERW/IwRDhDSYmz2xR72o/4T0/8DlresPv1aHRcv2mF/UxFqnVYZ
 dr0Cd9fhZZRCC+/2Z7pzkTYZpfIa5RO/B5S5colgeJW38Clo2Jv9cfK7JNcF+4votG96
 jEiOkgJ4r2LBjozkTCIyUlgmBI9ZKS6LH7WCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MvM6nM6rYnMj/7VFTI0rv5G9KH57+NDrgUtr1bVU1Oo=;
 b=dImKK+dgqUyWjOr7UvDzcvsjF2c7/jlYeFN6ckiOGIKz1R1c+p52Nuh13fb7R/oQk2
 kZEYUR++i3ZsUTn/XZ4TmDkJL36/KG0PowO4BG+JsjoVRaxGLka/TJzgab6l0vkrkWxT
 4F3isRrxA64G16A3TOIxnp752dfDT2dOlevPLSFJmfbjDxMr3Ov1d4z+ipEKIYrGJmaI
 9TGmjwjtFe89XtTAb4JU/hvZHqVECb7LSfMS2FKh2+pqZ2TiT2vCpLumvLmpeKCa/RDx
 PprZ62N6mtcgtfHS5Sf9oZeL8XCJFyNsLch/HB7cvU6QIuKFvBcpHeoVQwbqTOnM75MR
 0sJg==
X-Gm-Message-State: APjAAAVDE0R5ryk1ht/5gFIC+WHqch32k020tuCIuePMFq9EUa5KFGXB
 7zCw0E3DVkSY46nV1DD+49FbEw==
X-Google-Smtp-Source: APXvYqxmpuOqtK7ASzusSfLJEMa3pAop3ficVhHUNDn6fZ5q7zMOSDs2fGSSox4I3LFNqV3q5D+1oQ==
X-Received: by 2002:a2e:3a15:: with SMTP id h21mr34921217lja.256.1574953057257; 
 Thu, 28 Nov 2019 06:57:37 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 06:57:36 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 25/49] soc: fsl: qe: qe_io.c: use of_property_read_u32() in
 par_io_init()
Date: Thu, 28 Nov 2019 15:55:30 +0100
Message-Id: <20191128145554.1297-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
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
Cc: Timur Tabi <timur@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is necessary for this to work on little-endian hosts.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 61dd8eb8c0fe..11ea08e97db7 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -28,7 +28,7 @@ int par_io_init(struct device_node *np)
 {
 	struct resource res;
 	int ret;
-	const u32 *num_ports;
+	u32 num_ports;
 
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np, 0, &res);
@@ -36,9 +36,8 @@ int par_io_init(struct device_node *np)
 		return ret;
 	par_io = ioremap(res.start, resource_size(&res));
 
-	num_ports = of_get_property(np, "num-ports", NULL);
-	if (num_ports)
-		num_par_io_ports = *num_ports;
+	if (!of_property_read_u32(np, "num-ports", &num_ports))
+		num_par_io_ports = num_ports;
 
 	return 0;
 }
-- 
2.23.0

