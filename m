Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5944C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:38:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F4D20855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bV6Z9fOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F4D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GqmC0b6jzDqd0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 00:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="bV6Z9fOx"; dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmng2Cc8zDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:24:39 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id z10so18961012wrs.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZltWz01c8oCLmnoDvGrjVYpDxnidbYU1IX5rZmzZKUE=;
 b=bV6Z9fOx1VItspILAPRI5W8VOzo91dJcPE/eE8sUJW2P4w2Ur80bjp3SPzzP/d4z/E
 MNBEe1oPE/Q4EqZMdrWa8+KFp0Tesxe54lIFXB7D363t3pkjemC+wSS4s6kTqXeCXtQW
 aUbLE4f3qMlzjD6rC/R3oG1YYH6Zub7/X+FKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZltWz01c8oCLmnoDvGrjVYpDxnidbYU1IX5rZmzZKUE=;
 b=nmSSBQxwRj7mSqnCtN5hf+KszFx8Lby8Nvvdvn3CSNVV1sCLI4Brf6PwfP3QTTtu0N
 DYY4l3hRxEScIbJ2+CjncSxFn72M6wNVA7Wma0B17aaI8XlaXiSFz1gUKXQBRrMOMckv
 4EqluOFzblBIGyyFS3J9VOhwZXLTLPiDqvi5TtO7MoQBAPYp3QbQbYSzJhYGJaDFHW6T
 cn38V9ZToxfOuOcjeJbtIHj1Yv2Gx+KMM5v/0pWyriZxBhBaoSii2CP8xeyveRDqikQC
 a9Rmv2GNqUZmciLALkE5i78ZQx8pBrz798vZNOKkNOrxdItQ+cvHcK+El406wI34DkMK
 fE9w==
X-Gm-Message-State: APjAAAVRx4kW1SJIoaCsF5MQrEcmTl7+pA80E3zxXBr74v2YPBsPPEE6
 LMkOpRKAZcM0omFB9sHPFDYgM3Z9K7Cnvw==
X-Google-Smtp-Source: APXvYqwv5rLwOET/SNGVGrdd9i02wz6KfyE1CgBtoScH76g/+bIKbBO7+P1A77J80UsjXI2JMZ20tQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr16069888wrp.266.1574076274319; 
 Mon, 18 Nov 2019 03:24:34 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:24:33 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 48/48] soc: fsl: qe: remove PPC32 dependency from
 CONFIG_QUICC_ENGINE
Date: Mon, 18 Nov 2019 12:23:24 +0100
Message-Id: <20191118112324.22725-49-linux@rasmusvillemoes.dk>
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

There are also PPC64, ARM and ARM64 based SOCs with a QUICC Engine,
and the core QE code as well as net/wan/fsl_ucc_hdlc and
tty/serial/ucc_uart has now been modified to not rely on ppcisms.

So extend the architectures that can select QUICC_ENGINE, and add the
rather modest requirements of OF && HAS_IOMEM.

The core code as well as the ucc_uart driver has been tested on an
LS1021A (arm), and it has also been tested that the QE code still
works on an mpc8309 (ppc). Qiang Zhao has tested that the QE-HDLC code
that gets enabled with this works on ARM64.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..357c5800b112 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,8 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
+	depends on PPC || ARM || ARM64 || COMPILE_TEST
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

