Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514BCA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D25621D81
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="E1hiJE/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D25621D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4705Ts6LS9zDqg3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 01:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::144;
 helo=mail-lf1-x144.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="E1hiJE/N"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dT2QDQzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:33 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id y6so1635905lfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
 b=E1hiJE/N8uyirc34yldY8uoOKyp6Aafi6pTD1KNMz37l7ZxFuQTs1ly4mphyCyeoLm
 BIfJpTGn7JnPGMw2F/xN60qCJErNEMevmCpDy0g8zwOdSCaqJCYYVHT4CQPIamvwj2L3
 MdqAsCo4b5XqddEjICpt0BEm/DeSmy611x/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
 b=nKZd2MqnU78LTfNJ96/Xt6dHaCPRLXtye9OVDMUyEOs1bpNe+qZPo+eAMyhxWkSaVN
 moDyuhZu9R/1f8ByTl0jlz/OLCpT0FX73Dm/XKeKHzgB7kNJOKriORBDJ1il70ihU/G+
 mmfsyx4E7CI2IrSnnRL95qSG2+QRNDeQxqYWKVsah4s5qFIytOu5SFg9kcDLqYK7aA+C
 OJek4NvbCqRj6V/b88sWFAjqqC4SnRvkC/PGJ4mPjtC84a3n42nANA9rS2vZdPUqcY3C
 6j4Bv2VYgvFWCzPHb3Or2nF34nizwLrkIuozOxjSiaKCHFx+xP0BLvqNJvrE64eqrS2/
 vZsg==
X-Gm-Message-State: APjAAAUUlEPnYmPt36Jm1nzoiHfvFXYYm2Kvd0P9mKrOENJon1Kf4hG8
 f9EQEozHSjG62piGJ4USWhCJ5A==
X-Google-Smtp-Source: APXvYqzWdgjzit8ixR4YnUZ9xLOIPsZHRAlHxEezNI3JzgRLGEBgrKtCg1284a/7LWYjFvAyXUS6gA==
X-Received: by 2002:ac2:4c15:: with SMTP id t21mr2581867lfq.7.1572007290172;
 Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:29 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 21/23] serial: ucc_uart.c: explicitly include asm/cpm.h
Date: Fri, 25 Oct 2019 14:40:56 +0200
Message-Id: <20191025124058.22580-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This driver uses #defines from asm/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..e2c998badf81 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,6 +33,7 @@
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
+#include <asm/cpm.h>
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
-- 
2.23.0

