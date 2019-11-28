Return-Path: <SRS0=QEr8=ZU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09299C432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:21:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E6921771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Nov 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DA9W24cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6921771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47P2vW60BbzDr4d
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Nov 2019 03:21:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="DA9W24cK"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47P12x06gDzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2019 01:57:44 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id 203so20233894lfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2019 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
 b=DA9W24cKzldoyLYNRJ2Y6/1zVnkA1lJTOnZNVCGLnBtLy9SDw6v1MH1Lm6m8gUytky
 c/CaDP3iN1dNJBfmYpol42g9n5EFLkk812cLsAvU7B2qNvOG91C4+6uQAfeMnsMVXDe4
 rOJD9KS0Hi/+zmyHdu2abRIo6OPt5+3pur4ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/uGhuZC6bGDe/vY5pHErjTk2s243PKPkhdUERJxYak=;
 b=SQdTg6f7LOX9lh5Y8L2Ivet4xoO1kNbTTfq25m0ecsjHijeML5EMaNndDDPGHYYwky
 Jc28q/sgvInVo81clcXHY4E6ntny9XCpQVzkmpOEXKvB8ZSOzA6HmSO5XGtJXJNHLNHC
 4viMwO6yzFedaObg0TAfL4uft2i962QYWad2P5rcj5MLkc2A0rFWguOSHtb3YtTI4YvT
 QTEmux8e5thIPFmNZXdx9PSCtfwQTd3NmBfXW/J54WhMD8SQJUqwJvpvN0BKg41H0PAB
 nKcsXVd5k185Tb42yl9Kwltetjudmmec7IVNqLYrsJf27Qddj/2/YNLLKUyWkIExi87N
 acag==
X-Gm-Message-State: APjAAAU3+uhCkXNLy068Sg4dQMVnjAZlQi3o0Cn1yMA6fN957iLEa1Ar
 Ft83IxxzKot3C91Kvgql7w18dw==
X-Google-Smtp-Source: APXvYqzw/jYuIoVJsHxaPiDPkjZLXx2+FnqCB2evJQRnfVYU2j3q8zmQHgBLElskKwZbaunbylGJGw==
X-Received: by 2002:a19:756:: with SMTP id 83mr6610746lfh.173.1574953061494;
 Thu, 28 Nov 2019 06:57:41 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 06:57:41 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 28/49] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date: Thu, 28 Nov 2019 15:55:33 +0100
Message-Id: <20191128145554.1297-29-linux@rasmusvillemoes.dk>
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

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

