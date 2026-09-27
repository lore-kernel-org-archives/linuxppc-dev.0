Return-Path: <linuxppc-dev+bounces-28345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD25C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 20:47:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htGhS62ctz2xy3;
	Mon, 28 Sep 2026 06:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790542024;
	cv=none; b=STEtstJBSnFaBgRdyuzV67NmgSxgacdKc0P3Zz1kDBzH2eTuOP+VDIIG9ANV+/mOejcq9W14KvK8s+IG4JkbhFOLawlwhMAbHRm7Wc0TyBDyo+kWy5VnH88f7F/Rs6vi2WyhC9NGSCOLPlpg4GENHBBRTDnmr3ZbWJYkPEinVBzAmpTaxRxc5VvhEngVkr68eDnEIZZkkK7E8MaxqOAhFjwNLizsEzCsrc7tz6YGXu45eE4qMWWppXRXVs7Z/QHTQ9oTJ64XdAnNi2b++Q3OoI7iVawJ8Ss9p8kK89Rc4r5HqryNrcsO5CPhuNQNyIopCN4PQt1jCuXQCU9RlGxVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790542024; c=relaxed/relaxed;
	bh=ryZRJZuTPWZfnBV/TlZKfTdjR8/6L8XQUKUndimBZns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZjmHVQZC6/OUmfyH1uW8YXr0Z62ylKMJyGrpxYraAWAbVKiLHby75tamom/8iqyzKQ9OJi0POCWEBykeqkekhZSKsNmnXBvinrzL7iAv40rO/k+9P3WU/rhd5eKylG1Xauec9H2IX3sbLiOvRBlAsW7WSMSqUbt1UGbVGZwe91XHRrkNL3Q6aMiH9KEGkjHdWsS4QKc1/RDQHt3VOcVQm+1max8GgBUkUWpYVpnQS6beSQsqxsTXnCcWVHQUiJizZHvQk2JOeLq2dCbQj7rawKt32X/ixdgZFLYgIVylOOUZPGLUs3XaylX2GfDQp9Nq5vghWanIz18qZM+d2Strw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlahAEaf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VlahAEaf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com [IPv6:2607:f8b0:4864:39::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htGhR6bbVz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 06:47:03 +1000 (AEST)
Received: by mail-pj2-x0c.google.com with SMTP id d9443c01a7336-2dfaf76605dso3073145ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790542021; x=1791146821; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryZRJZuTPWZfnBV/TlZKfTdjR8/6L8XQUKUndimBZns=;
        b=VlahAEafmHjJ54X7cRJQmHJg0wWdnkCmNNVZCS28voDWLLy2n1DRC47xadYEt+qFbV
         liVHoO14phtu9ebE7e4ke1JnaV51Kf62EN97zHdnq8EzWRE4cl7liKbN1jw+9w5TZgd7
         0PuMquEgO2eCxgZ4D7+m8FI5AAtiECMn1zsu+BsuVUT8dKzo/yquwWmAsNQPvMW1caxH
         m1ju8fbtWRcV8e28ZRVPaSVQV8zjDZoe1vbciOqvUjVneS+PurzblI0Cx/JvIYepxA2H
         3YPnjrdd2DiEmJx46XHARl+4eFui0pwALOZ6jS/gREmG/1tId+msZ+aobXwr5LVSwQhd
         OlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790542021; x=1791146821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryZRJZuTPWZfnBV/TlZKfTdjR8/6L8XQUKUndimBZns=;
        b=m+nR9ojRRZ3+8jtVmrJnVqZAvivhNFmDPNXnbIya+CDXbeG2ANY+T6qZ8kje2epnxy
         5hMlAlPD/YdCVbLK5D8jNWaAalk2qSp/1oSLs70ykRu4yrP9npSoDz5G3C/M41Bla/FN
         hYqtn7tNlKRl9ddf8Xf8CUxw6HD5ZgE43fWhFDQ+IYDLlnV3p/UMKELP2sMP7L8R0/25
         yGLMJDiMzk0kY3rqIH97agep8nAXc+Af2B+O7c8CMnr7+mfoEK9F2ZrUgl4ZP66+vN6x
         J5pMar3r0jBt9Lx7afLRGz/4e37Hr2+6BAm1UiAxzJwZbZCEabt814MwElSXxHYd5a3U
         25UQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6Jys6hcle6SQU8BK55iHOPToGVXH6LN1HUpQCZDjIqCtgWjIIifv1ujMOw+qMN9MVtqJvhaW9DK2ateU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKxGikI2AGtVsKY3aocz1I3H3n//+ESAUiBdGlwqLphX6fe7RUU
	GdaybIhcAJuX5TZrKQOqpqmY7wuqkzLbWqWJfSOQC1/0llI1/tRuIwvm
X-Gm-Gg: AYBFou1AgusmrrqPggJcyM9QTZ6cyCUr/8uj7lErSrrhmjT3sh4t/G5KyjwWsPv4ydq
	QsHQX5w/nbmDr4XIS/mYBZEeLCwTqgnLLyUkuM3kn6uqUtOr9CZ/5k5L7lFEc6+XF+KhDGDHqGL
	b9FhRGhDT3AJGfV1EJCducZzjYto6BtyC+Nc90PaODs+3HhKT4gjG0y7i4Ks0kPGDJ3p6PYWQp6
	gUbgtykkHSu3PA/EqgyMiXJ/aYnuIGGJLw6l0xZzzpCY7L6SLOq7/4wcemzl/mOwMdm6UjaCRVI
	rML/kUNkIyWn9jHtzafMc+NbL2sQcaTIvn5YezNEXVwtHu7avdgeUdb1uBgLWSeju2nYvSU3mhS
	QdxWovn6uhucyU1rge4bbZFDnYR1mnoJvSzSAkjC2L06Q6tICoqIXJ0dkX8KCQUYNyYo4FVfoNX
	2uDwrmBpoWE3QLWSvMvrlCnP1gKihyaIV8a7yWQOSPYtSQvMIhUDYKsV5aAWe/a8UGfFC17oipR
	41Llzto0QA9bh7K7pfKNOnx5oSwAXpejwlBgEPwmrBUsPgH4eDMFsbscdArUvRRQWsqIA+7CYba
	qT2C85QKmQmJ9KrFoS23+5EI1mfkE2ryeNEel1luNk//yOWC
X-Received: by 2002:a17:903:1aa7:b0:2dd:ad74:6d1d with SMTP id d9443c01a7336-2df7daacbdfmr95981625ad.26.1790542021386;
        Sun, 27 Sep 2026 13:47:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91443823sm31303465ad.57.2026.09.27.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 13:47:00 -0700 (PDT)
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
Subject: [PATCH v2] serial: hvc: use modern IRQ acquisition API
Date: Sun, 27 Sep 2026 13:46:58 -0700
Message-ID: <20260927204658.24338-1-rosenp@gmail.com>
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
-EPROBE_DEFER and other errors. Move it earlier to avoid having to call
kfree() on the global array.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/tty/hvc/hvc_opal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 402da9e7c534..fb9a566ca213 100644
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
@@ -176,6 +176,10 @@ static int hvc_opal_probe(struct platform_device *dev)
 	reg = of_get_property(dev->dev.of_node, "reg", NULL);
 	termno = reg ? be32_to_cpup(reg) : 0;
 
+	irq = platform_get_irq_optional(dev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
 	/* Is it our boot one ? */
 	if (hvc_opal_privs[termno] == &hvc_opal_boot_priv) {
 		pv = hvc_opal_privs[termno];
@@ -209,8 +213,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node,
 		boot ? " (boot console)" : "");
 
-	irq = irq_of_parse_and_map(dev->dev.of_node, 0);
-	if (!irq) {
+	if (irq < 0) {
 		pr_info("hvc%d: No interrupts property, using OPAL event\n",
 				termno);
 		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
-- 
2.55.0


