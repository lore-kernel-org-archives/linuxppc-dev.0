Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76579CA9EBC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FF8222C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jKc8arHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FF8222C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4705L33WSTzDqhN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 00:58:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::144;
 helo=mail-lf1-x144.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="jKc8arHS"; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4703dS3Gl8zDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 23:41:32 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id q28so1629510lfa.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vlC6c2mLi3OFOrUlQdhK/IVokJUA43/TPqoeSB5eKTw=;
 b=jKc8arHSmx2y4WG6E6pxme2fpIipCQg3lj3xfo/NE13M78vwKaac8r87bS926CIlOe
 G8HjFyTR6NrrVEFfD2f145q33utez8HIUqLF7wEvHmOg4BYXyAYRqgdqUUut5SdZTL4F
 2f2wUM68LsShYG8dX6rYt18eoJRknZHtyrkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vlC6c2mLi3OFOrUlQdhK/IVokJUA43/TPqoeSB5eKTw=;
 b=PmkOvcTafluPe8awfQaZqRHfBx72Gl3kaGpt2XdTSA8wTALNHr9XZf/VXeNL8be0oY
 mCAjS6gOTt2rrvjXJiiVqSwhNh1n+0ReqLVsRQQJAbkyzwMldCskhDB0MSyepA1IR4PW
 j7rDLYohDzmHLcenCdi5YiJG9XvaF6gMCBEBmS/VoK41PS3aNeJUqfx3eu+hs49wa6PD
 FusKRobOuNXCUCpmkeusj4g2cK8BKLEfl89+FZ4NQjVUFq7zwOpcu0GAttauilHEZrJ3
 VFcg8/cVtGqQaXem//wXJq4TtN9wBMiGj0ayW8EGXwyUp2byVpHq695jlaemqcsmE5K2
 i22w==
X-Gm-Message-State: APjAAAVX8ZZUuwBudS2gDK171+A/UAZpZBONFXYuXJvOt4jq9xVg2oWJ
 3kp3mZE48R9vyK2KDY9/aa+ozkWbRq2rnA==
X-Google-Smtp-Source: APXvYqyOmmWKDKIwnL+Dz+ZoHsEg95l0xY0B31Vt0IMF9adkil2MZ7+eec85cG8dv6k9ac6S6ZK0SA==
X-Received: by 2002:a19:f018:: with SMTP id p24mr2542630lfc.93.1572007288855; 
 Fri, 25 Oct 2019 05:41:28 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 05:41:28 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 20/23] serial: make SERIAL_QE depend on PPC32
Date: Fri, 25 Oct 2019 14:40:55 +0200
Message-Id: <20191025124058.22580-21-linux@rasmusvillemoes.dk>
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

Currently SERIAL_QE depends on QUICC_ENGINE, which in turn depends on
PPC32, so this doesn't add any extra dependency. However, the QUICC
Engine IP block also exists on some arm boards, so this serves as
preparation for removing the PPC32 dependency from QUICC_ENGINE and
build the QE support in drivers/soc/fsl/qe, while preventing
allmodconfig/randconfig failures due to SERIAL_QE not being supported
yet.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67a9eb3f94ce..78246f535809 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1056,6 +1056,7 @@ config SERIAL_LANTIQ
 config SERIAL_QE
 	tristate "Freescale QUICC Engine serial port support"
 	depends on QUICC_ENGINE
+	depends on PPC32
 	select SERIAL_CORE
 	select FW_LOADER
 	help
-- 
2.23.0

