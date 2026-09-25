Return-Path: <linuxppc-dev+bounces-28229-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2378C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 18:50:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs0Bg1ydcz3048;
	Sat, 26 Sep 2026 04:50:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790362219;
	cv=none; b=WkPC56ArZFJJsj3DaOiLOUtxFZWzUWAMJD1hQIK4VJjaac6Nv9H+wJSwqSr2OzVxBuA+IPZ5VE6Ng+sWxiM5z2lE3n57o2JHpJPSJ/2vqy2Vfpsec5hg/WWBfudFF0OogUHL5ubvlkOQp/uKMhmzxSPNG8RkR/M5HT0gpXU5QbPR/9ezYyW+SkdqVMiMfDsN8KTo8KEdQXysQ7v73keYCd0/t9Lamut92mlEQdOD4MuDmqfBLvhk8bnwQeY4VzzAGvhncbr3NVoViZU8d0WvUNamJMLQLGj6b7GUA/wkKMFvyvuChcW0Q5Cg9+5jaRXyecWoNZuwGsC2Cx43jJij7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790362219; c=relaxed/relaxed;
	bh=isylCd+SEsmLJzgVMJ967rAHOM7cwy6tX3oI9l3rtxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9B5fMgZ+xeFf7bZovtcDyaenTYVDsPGxFRBEz6DOcxANnyI1XzXE+PgmeEikukak+vjVmTkqBVEf6rW+fkyWHtq1CoUyz07prWlisZ5lorqR6gPUL2X0Mg7Z6+AXsrn9ujMFJyFUUvXCj/tPI41kJk1p0826OtchXO+5W8QGf7dd5AajiLdIGXdfUPi3uqcE52O92/JWfzN8JxeJj3z/YJdysVabN5dfYAboNUHX9w0zO4sLysD6RapxORbzhQS28QdU+G453HTxzvyjeh1o77Ow3P7Na4bKFr1sgN+8eX48HpK9ZvEpbxGn/MVer8mBXVvRaUo7wqYcIZ0Nh26WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0ldGSN5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:31::d; helo=mail-oo2-x0d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0ldGSN5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:31::d; helo=mail-oo2-x0d.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com [IPv6:2607:f8b0:4864:31::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs0Bf0TFCz2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 04:50:17 +1000 (AEST)
Received: by mail-oo2-x0d.google.com with SMTP id 006d021491bc7-6b1ae6b1b26so653593eaf.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362214; x=1790967014; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=isylCd+SEsmLJzgVMJ967rAHOM7cwy6tX3oI9l3rtxI=;
        b=i0ldGSN5Ax830MnpGIg+09GQIrrv63J3/8BBkwPNY2efiRyKd0F6UaHmW+AYwkMXMU
         9cWaKM9kSiL4XPGqRX/wX70frHYo5FDpmxHpdafSglSUg7mgYrOXDThAjLGSryWplgFP
         141Bo3GiLFUIAhZToqeBCnSXipS36so32dJGtZekIniH6q2jMwAAshkRzPA24dK5Cmwe
         IkICu9nOgTXRtGnrwvAdQL6eifRo9So492xAnfZWUJSGskehRK5VWpKNRW4xMddS2r+i
         1+4yJNdXd1ZeOalgfO3lWQ3Qgma8EkmKV75DwqQTtFTWDW42n5Kg6fiFdk2ifuRy0EjS
         yjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362214; x=1790967014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=isylCd+SEsmLJzgVMJ967rAHOM7cwy6tX3oI9l3rtxI=;
        b=FdDMrUjY3FTF0iQWgDy4BwUdEo+WFPlXxNxx2QhH3Y9Gcrbl5JeG2a1kjB9GSzGVLU
         2CstKwlz5NYM9lHW5fEv/KSHGrV5TOJ80TnjQG/vNvfhtHrXu82r41eCNleWOzVretMk
         fyz6MsiYlT1UdaaPcC5wUk6V9O6/dPllct0U7aK1c5SWkOCfMic9wBsmlOqmmyCHU7BJ
         h1zfFYN6Ovz1IrIxtKEFAtinHlN1Vfwebd4ukD+j5Oth8Q1P/AzI7PsUITeC4MxUrj28
         DXP+XkZ/BTjwkbAiMH5M/31PGu1gxZ2ErMUoumCulMyfz+JrGCvti3uRF2HvZ0Ck1fmk
         /Wdw==
X-Forwarded-Encrypted: i=1; AKwUvBzoWZ2v1rSa5wUx8a8xlpzgS+/u+vkrx7acKHLeN6DsCPh6zUnpa5MnJ20PwXoZAe/le7eBjK9WOUbtzOk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++knU57p/9APsENJ7sey33KHaxc1C6IG5nEPDOVgAZqdtmCw2nPi
	/kPV7vW49WDqT50MLiFrOtgUF91tt78ODN/fC8UoRoMw4fjRD5oEdLYh
X-Gm-Gg: AYBFou0VMosvvdWMtKpvkeNnu4M4l9gixjWN9te1cdd/5GLWbkRQjP9yQpcIUl4xwzB
	+ST/ZfEYYD0oCv9U8z/wpnvzVVDV7U7MA0aEeOxisK4vSN1FB/9VAsidOt/LkTCJVmTQjuU3jgY
	IoiP6lRBfrnqn/PfXDijAwMvR97pB1IJq1wF7arGBS4OsuI7IUXhupy1h/94mRiJZvI17CQ46Wg
	z5tliEuMlrVcDWwc7mkVWihKDdqj8T5WZp5aOzffc2si50b/gVwh2WVXO61t44glNgo+j/Nwmxh
	jdIzYCYab757WfO3gSFLp+gauLg0ylVQmT0RgMU1Y8uOxoKqXGKCxO1vFMEccx4r4FVqWYnbFsV
	aLudC8EnXNA9SJHp98xDHe1HFebVNWKAkreT5AH0ZBZoTl02sQC9LW1ixo6RETPi0K58Ke4pYld
	bGlivpamzaPEhThhyQ00aEO+ciembRI7g85OMGaVNaUoHxtejc7qUc65o0iq77fyQY3bW+TqYPX
	2IYf/WfvNjptLIDFSQXPLL0UX/cxW4aFv7i2/vOOiijCOrcuNbgjqSkPc049cN9vfZz6zmo3KLe
	CJv8M8DMDuMbmkt8XbMHUE2MMqgrdlmFWOA1Tyl8Br1mPrz3
X-Received: by 2002:a05:6820:1c8d:b0:6c2:396e:b991 with SMTP id 006d021491bc7-6d44053a4a1mr6522021eaf.61.1790362214384;
        Fri, 25 Sep 2026 11:50:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49347da3079sm2555780fac.14.2026.09.25.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:50:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-serial@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Subject: [PATCH] serial: hvc: use modern IRQ acquisition API
Date: Fri, 25 Sep 2026 11:50:11 -0700
Message-ID: <20260925185011.61259-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use platform_get_irq_optional() to be able to handle potential
-EPROBE_DEFER and other errors.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 402da9e7c534..ce726b8b5ab0 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/console.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -157,8 +156,9 @@ static int hvc_opal_probe(struct platform_device *dev)
 	struct hvc_struct *hp;
 	struct hvc_opal_priv *pv;
 	hv_protocol_t proto;
-	unsigned int termno, irq, boot = 0;
+	unsigned int termno, boot = 0;
 	const __be32 *reg;
+	int irq;
 
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
@@ -209,8 +209,10 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node,
 		boot ? " (boot console)" : "");
 
-	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (!irq) {
+	irq = platform_get_irq_optional(dev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq < 0) {
 		pr_info("hvc%d: No interrupts property, using OPAL event\n",
 				termno);
 		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
-- 
2.55.0


