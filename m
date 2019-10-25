Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E50CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 14:12:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B378F20663
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="O1Zrkhgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4705fS5dxRzDqdW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 01:12:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="O1Zrkhgi"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dW6D16zDqdP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:35 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id x4so1616678lfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
 b=O1Zrkhgig/GHdHnwKsmpqtbkvDL3Y1rbK+JGj+Cs0DZWtFaWKeld23eELOlF+fW35i
 ahKQ49AZ8AKtvvJqeiZLjoI7J8pcRbGnauSMHAK4OFjos9Ny65vqjsTi7H7vouL3ATlL
 cOrkitUQVw23vF5rAUldJcjlmIvXqFsHyVYjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OvUZNskoObmKKJYsbx/wH8iXu8sDYM+jDByiAdju3Rg=;
 b=ZlxiOso5555U/361efj3EAQ5jCUmQo+Gk0GCpo+JazQknQ4DAossYKtyzkKCZkPUk1
 FAaiUvOxjuR3kBEqcrVQdu/pvKWuZs1C1X2aMAEDAbclBY6RlZIO94v/IrVuw4GBsv+t
 427k62MhgfnaYLjDD0ljn6QVqTuymtczAar20w3ccwgoutB6ZZ5/mHLzOqIqtDrvdRCK
 EhqazklwVaMlGodA2X835U59ggYverrmiweGCmZg/VDbkJobd2zTf7VgZdW5Pl8xs41k
 3IiVszk0DAweIIkFacVFZXe+lwAwi2OnYJaN5L1NTS4VXLTK7mv8E+zlhxd5mNmtxVPL
 9yfA==
X-Gm-Message-State: APjAAAVOMONRsHOzHnUA61dzriO6oYDngdbsNQUkjcuSbfonZefhgYtT
 eMxEmRKbzoAcmgtIq60EIzacjw==
X-Google-Smtp-Source: APXvYqzaZam+cJPG9bi7OgeGhos6Wma0vuM3s9YGw4M43Jx9w05f90bLjSb8WkcVyEkm6MHVqZnaoA==
X-Received: by 2002:a05:6512:40e:: with SMTP id
 u14mr2657599lfk.73.1572007292444; 
 Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 23/23] soc: fsl: qe: remove PPC32 dependency from
 CONFIG_QUICC_ENGINE
Date: Fri, 25 Oct 2019 14:40:58 +0200
Message-Id: <20191025124058.22580-24-linux@rasmusvillemoes.dk>
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
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The core QE code now also builds for ARM, so replace the FSL_SOC &&
PPC32 dependencies by the more lax requirements OF && HAS_IOMEM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
index cfa4b2939992..0c5b8b8e46b6 100644
--- a/drivers/soc/fsl/qe/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -5,7 +5,7 @@
 
 config QUICC_ENGINE
 	bool "QUICC Engine (QE) framework support"
-	depends on FSL_SOC && PPC32
+	depends on OF && HAS_IOMEM
 	select GENERIC_ALLOCATOR
 	select CRC32
 	help
-- 
2.23.0

