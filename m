Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C9C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 12:37:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D424F2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hs8PX4sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D424F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GpPt3r9GzDqR3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 23:37:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::442;
 helo=mail-wr1-x442.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="Hs8PX4sV"; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmn34Hc8zDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:24:07 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id n1so18955236wra.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
 b=Hs8PX4sVJIwwkhMnX/i23yvXVKgiBAZ0EflioICFlUiNZBktVM50OF+N1SRAhov5c3
 bEK5SKUGxm13GFe25nWAeNF04u+FVpabTehtOzibHm8/2w1qxPg65sxQcTApGI7GMrCs
 Sdfak0xZuyoukt02m38D386ldKNHrflp0r1yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
 b=nCX+SXZ4FMWnX82EXCjg6Uq7PhJ1jh8yQ68fMoKU9qOVSmsDXEGRD6PU0DiA33j8uA
 DfDpjGHg3wnDz2J6e2sWsGwn886+yReTHF0KpmueFeoWUvbeFOXHemuR3zxitUkOvZwO
 qqEk9K4OGfsZukH09jQuSucm+ZI99TADfXtZImLCSPCftvxHh5kELL1RfnSft0rd1mvv
 38gl8fYnZq4jhCjA/n8BKIBcEJvOXMSrPo4Cabi5XNyAS9GJ1VuhF3MVnyHsBkU7Ff72
 aeWYoEjzYJMvtWsrPJyH+vpeqPEzSuKmFwHrmTAKbJgLLYmD0QVctxigcf6SX+Hn6gPP
 MW3A==
X-Gm-Message-State: APjAAAVYRi8joKlg1FF1rDVxAkTnMYTeeWU4wjqfoB4776NOEgDnTzl2
 qXD657em/ElTEgzDbEYJA0Wr6w==
X-Google-Smtp-Source: APXvYqx1qUmVxbnUojGI2hh8REIAqzLfraBuKrR6T3lZNpWA7RXt75BGBSItMF5rI/cMRCq9gCkq5A==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr10747487wrm.356.1574076243541; 
 Mon, 18 Nov 2019 03:24:03 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:24:03 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 25/48] soc: fsl: qe: qe_io.c: use of_property_read_u32() in
 par_io_init()
Date: Mon, 18 Nov 2019 12:23:01 +0100
Message-Id: <20191118112324.22725-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

