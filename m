Return-Path: <SRS0=QEr8=ZU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD59FC432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:33:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1A021774
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Fs4SgS4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1A021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47P39T08zBzDr6T
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 03:33:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::244;
 helo=mail-lj1-x244.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="Fs4SgS4/"; dkim-atps=neutral
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com
 [IPv6:2a00:1450:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47P1340XjPzDqys
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 01:57:52 +1100 (AEDT)
Received: by mail-lj1-x244.google.com with SMTP id s22so9822439ljs.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
 b=Fs4SgS4/1psPKfkuhI4Ny+x/2oJrTK7HBfKE4/RCaNwwy+uA8dMiNwd3beo5/zLTHw
 62oVxo+n4p+sA9/H9nbzmMU2pfSe0i3IY9PDEKXtA5Y16gW6pwQTd4R0Uiu6nNqFDpUH
 SzXhTou8vQGjVBBwFvDic+ydbfn1zpUpRjhKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QBhz5rvCw4g2Ox9AwtLP/2ydNw3vwlfo4gXSav3FB44=;
 b=Cp1gt8DBww+nFARwzQIx/YARUGNpxfOATLVn2sKgeNGFH0sjkNeAMHrXUA1EXFHOvB
 8rKPFjfR8qbSGjcmDtDLxxfIAa3VCo0YxJU+8zBrodLK8inFDLHykdHdarkoRzrIRUnj
 YwaDXWy9YSAopPmk1MNeglWYOY0SMUwj5D7NwMXOTbdzoAbxIPaGMzGv9Ox7aPktxXFk
 lvdYPnhOqT/z5B0c709UxctsTeRdsZt/pa3ETR+Jx2IHmbh2SVcjySbPBXK5wL05lja1
 pGFgAsI2qdU9GbtV6Tr+ezgJHGf00SB3XgOi4tqcQGQ66qQt+sY3SbohXdk34Q6IibsI
 5u+w==
X-Gm-Message-State: APjAAAX/rtj1pQCZQfEWEb537PJW9C7n9r00oAprobEyI55vUT3kAv4I
 xD8W2F/wnKAqZoSCk2/O7iwPHw==
X-Google-Smtp-Source: APXvYqx99pjU5nTC/rq9MmsMvdS7IjR/57AJ+W7tuU3iN95pO3rx6CAJcCzrdDDJbnd7jwEkPdc8CQ==
X-Received: by 2002:a2e:888b:: with SMTP id k11mr10315128lji.87.1574953068992; 
 Thu, 28 Nov 2019 06:57:48 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 06:57:48 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 33/49] serial: ucc_uart: limit brg-frequency workaround to
 PPC32
Date: Thu, 28 Nov 2019 15:55:38 +0100
Message-Id: <20191128145554.1297-34-linux@rasmusvillemoes.dk>
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
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

According to Timur Tabi

    This bug in older U-Boots is definitely PowerPC-specific

So before allowing this driver to be built for platforms other than
PPC32, make sure that we don't accept malformed device trees on those
other platforms.

Suggested-by: Timur Tabi <timur@kernel.org>
Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index c055abf4c919..9436b93d5cfa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1392,6 +1392,13 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	if (val)
 		qe_port->port.uartclk = val;
 	else {
+		if (!IS_ENABLED(CONFIG_PPC32)) {
+			dev_err(&ofdev->dev,
+				"invalid brg-frequency in device tree\n");
+			ret = -EINVAL;
+			goto out_np;
+		}
+
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
-- 
2.23.0

