Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95553C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 12:03:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB53A206F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 12:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FYQSeShC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB53A206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Gnfw1XY4zDqRf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 23:03:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::343;
 helo=mail-wm1-x343.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="FYQSeShC"; dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmmk5j1bzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:23:50 +1100 (AEDT)
Received: by mail-wm1-x343.google.com with SMTP id b17so18332999wmj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jc+8R+PtxSGR+WKCXh82E6vFl/rmsOl6moV7TXDxFX4=;
 b=FYQSeShCWT/8kbxczUE8H7YG/XQtMqnXxNVEjckd6xnEMHFWk5vtrXmQF68eICMnrn
 1tvoUFgdokaMmtSx9ge1FPGkAUcySGE/0JkA5bV3MqEnoUsQA9nD8oYuzMwzMZabZIDE
 Hxv18FM/wBb4YSN4sJdLEXodTBJI3sbMGWeh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jc+8R+PtxSGR+WKCXh82E6vFl/rmsOl6moV7TXDxFX4=;
 b=l2hmrd+RIONUMFTJjloVrYrN+fufjK3wUjly85bH/KVjc5geRrZux5RvUs4VG9o6Kx
 2xgiTSI+e+/4J1At9+EO/nbndgdaLWP8EqgtK1fzpNlbkDSmR90285JkCQGf9gUoJkEt
 qgfQsOM4BmKzazR2XaooF7J7K1aQjUqzbu4OyA6Bj65IZxkY+++zCnJNnOM/+JMx13X6
 1SXY7OfukiRodNzODOwFjt8aNWE5YJ2t9kIFzWRgHPYaEVX2YakHd8tI08Q89B/dOWSb
 HD677IerRofp6ZVFJBfW5HcwrBAlf5+Y4j89RLbI+3D5mHGVCkJwnMCmEMjISXrGT+3b
 NmlQ==
X-Gm-Message-State: APjAAAVJA4xzTgbkj552d0l5p87nyg1hx8OwahlCkEKV3CHf5AIezG3H
 noh4cTmWFhap+1ZCP9fHQ5EQRg==
X-Google-Smtp-Source: APXvYqznv6JjVQ5qTzcvdcfne6tEWGUypLqwCOu7CzE5RZilsDdY1MDVJ1TvuugpKKC5nRYwvTTgIw==
X-Received: by 2002:a7b:ce12:: with SMTP id m18mr30518794wmc.130.1574076227529; 
 Mon, 18 Nov 2019 03:23:47 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:23:47 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 13/48] powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
Date: Mon, 18 Nov 2019 12:22:49 +0100
Message-Id: <20191118112324.22725-14-linux@rasmusvillemoes.dk>
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

This is now exactly the same as mpc83xx_ipic_init_IRQ, so just use
that directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/km83xx.c      | 2 +-
 arch/powerpc/platforms/83xx/misc.c        | 7 -------
 arch/powerpc/platforms/83xx/mpc832x_mds.c | 2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c | 2 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c | 2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h     | 5 -----
 7 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 5c6227f7bc37..3d89569e9e71 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -177,7 +177,7 @@ define_machine(mpc83xx_km) {
 	.name		= "mpc83xx-km-platform",
 	.probe		= mpc83xx_km_probe,
 	.setup_arch	= mpc83xx_km_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 6935a5b9fbd1..1d8306eb2958 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -88,13 +88,6 @@ void __init mpc83xx_ipic_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
-#ifdef CONFIG_QUICC_ENGINE
-void __init mpc83xx_ipic_and_qe_init_IRQ(void)
-{
-	mpc83xx_ipic_init_IRQ();
-}
-#endif /* CONFIG_QUICC_ENGINE */
-
 static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 1c73af104d19..6fa5402ebf20 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -101,7 +101,7 @@ define_machine(mpc832x_mds) {
 	.name 		= "MPC832x MDS",
 	.probe 		= mpc832x_sys_probe,
 	.setup_arch 	= mpc832x_sys_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
 	.time_init 	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 87f68ca06255..622c625d5ce4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -219,7 +219,7 @@ define_machine(mpc832x_rdb) {
 	.name		= "MPC832x RDB",
 	.probe		= mpc832x_rdb_probe,
 	.setup_arch	= mpc832x_rdb_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 5b484da9533e..219a83ab6c00 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -208,7 +208,7 @@ define_machine(mpc836x_mds) {
 	.name		= "MPC836x MDS",
 	.probe		= mpc836x_mds_probe,
 	.setup_arch	= mpc836x_mds_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index b7119e443920..b4aac2cde849 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -41,7 +41,7 @@ define_machine(mpc836x_rdk) {
 	.name		= "MPC836x RDK",
 	.probe		= mpc836x_rdk_probe,
 	.setup_arch	= mpc836x_rdk_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index d343f6ce2599..f37d04332fc7 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -72,11 +72,6 @@ extern int mpc837x_usb_cfg(void);
 extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
 extern void mpc83xx_ipic_init_IRQ(void);
-#ifdef CONFIG_QUICC_ENGINE
-extern void mpc83xx_ipic_and_qe_init_IRQ(void);
-#else
-#define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
-#endif /* CONFIG_QUICC_ENGINE */
 
 #ifdef CONFIG_PCI
 extern void mpc83xx_setup_pci(void);
-- 
2.23.0

