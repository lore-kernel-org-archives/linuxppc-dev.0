Return-Path: <linuxppc-dev+bounces-28868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A1CA5FE4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 21:32:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxzPW18DGz2xsW;
	Sun, 04 Oct 2026 08:31:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791063119;
	cv=none; b=XJ0+TYEAGOokvOE1E2Eqw/Wn+aqsJIRUn0Ku9oqoCQaOlJZqizW8RluzNyovQIwV8L53S9bnrAnlMNh2udHmxFiq86Jlbbi2wgeZndyrGfizn7o4ssJ37gwn/YbUHmsM+4LW2yoNcDKrbXUmvDbL9+7CReiqytbiqGKvSMsamGkcGNgqRRVLjTNceZU/w0PahQz+3CLgI/HxiPUBbOdhvyQEM41A1a5hLuHswY1k7pWwe4X/Ibjsq2ho7vHIMA8/W6ihM/753EdeeCOIiFOutPU9CX06MnLnsMhiFfg+yDWPIwDlIBdtaspjHIkocCMLemB1dgIbnv7rB5WW8L6/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791063119; c=relaxed/relaxed;
	bh=EF7nOMoHU/lXOBcLECCEmjeD1XvCzGTt0zKSXYTVC24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkwwhS6xMWdwgUuv0wE8ikQmhI0F3PxQNAQbcNFJ1wVwL31tmuPra5vUOvGsYGm3aUTwuP3RAfk3qrWanosOj2I+ifxBYtugCefp0ldcWp51DyT9T+Mmj2FqkLQ9ToKeHfajhUKmygIiqLOQxQ0HgFgdHlozMU/SGJ8zvkQloJM5G9RfAG7z2fwVxqFwXoP2HJOBLcW2iC3qywmSIYfz/wpfaoTY/gxJLysVyg3JTBQQO65+bq7zz+EIxxduXDkdnZUC3EuoLC+NoWv1QHhIiJaoy/o+ZG8mHwZp/EO/xQgGGjorzOoA9O2qouHjbhkQTvIqLckPEuo8nTB8QuTCUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mFbG8MYj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mFbG8MYj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxzPT3Wncz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 08:31:56 +1100 (AEDT)
Received: by mail-qk2-x10.google.com with SMTP id af79cd13be357-93a2dea320fso43476585a.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791063112; x=1791667912; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF7nOMoHU/lXOBcLECCEmjeD1XvCzGTt0zKSXYTVC24=;
        b=mFbG8MYjlMBzLCqxPYS7uVYSbY07WbI8C65wbtuc3D+tKBFedJxRk3TPoLu7VRG2Ge
         V0pw50/k50Egcg5joWn1Rz5nbU/1SSuV4ZkHhVHFXQjRHWgJ10G5Ub2cRCh/a9W94kfV
         EG10SgqIFJniMcut1z0JaxeBPT6OfIachb+fLTBqFG7scZx9SrA+0oe2JE0SFFBfEsxr
         plFhq36udWiNGixWI7tvC7rBSr9gzSZXOENv5g5WdCUOEI0I5XV2V1z3n7B5fplSbeNs
         6A3eHixzajeZbv5ukXK4pzsnYYK4qW7r9rAYgmaB6MivTqyc1lTaq1pDKfPwN/QuPuqQ
         tU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791063112; x=1791667912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF7nOMoHU/lXOBcLECCEmjeD1XvCzGTt0zKSXYTVC24=;
        b=BHs2nwQkC5Gx6YFrptoTnu4HN/JSNI3E9fFWWTLLbKfTGtIyO+Wjnv9Hu+Z03nesR7
         jqdFJP8vf2NNkXyYjtp7e9N8Q1BCWDA0KNY/3UR7/BBWc+bJwx7nmYj2U5SZuOKcJvjJ
         ebIpYXSNerdiTc9oTsVl2tHzE5mTDcHUOqCbkWmsUux/iR4gvOMmp3DcUBzwuj9ldEC+
         9nq83y3Us6mhvWOwIdyg5LlDZL6ABktdoGgJ5S+O67wBW+RtJKuZ6xv4Esnr8y69OR0t
         ti/H5tPuVG2tBqpFdmH2foyb0hXUTdSu0P/TYV9n5HXgXYR25gSkhfF/nXb5JGs6d/Ht
         RcDg==
X-Forwarded-Encrypted: i=1; AKwUvBw1bRLjQCFLJfJTX17WZ+AW334yas0xxHhhH9C0O8YnO3wwkChCcIvv4I13/trOCn4yLhSNAGXcvyf5abQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nJ0W0dIEXQayA8OW5acNFnepRGd6B0FZypxWAVk1pNmLjltelo
	bLBGQMpnWH0dP+FkUyt4zACrdRjwYk01jF8kYHgQS2qzUYSyCrkXEeFN
X-Gm-Gg: AYBFou0iS0Ay5Sf6VJ3lZtU7lngkHaBCU3wILDUQBpuf6nPTPpHQT5UsFCMWH+Fy1Th
	QnWriHZHzsXNo6Wcxg92oqgvtKS6MuQ18gbYofA1gEXjlsd6hlurPwqVGJhcVBRr1ErUugZIH4V
	A8T43bpnBal2xlWQzKjbYvK1/pSaNzLHr/uWb/21UohQG06oihEEu3mc8PhyNgNLfLb5jzVtjn/
	VlCJRsRLGA9vuTkJwFgvYVJxJr4hcVWaLQgt+tMeHK9e1/oZ6kT28vNvoD0HEcFiftUSOmO7lPV
	EhLajXTReLZIu8IYGhtXS3WIromaHNrf6ukWbiOWpK+yq2H3fmEzEcP4/KcBFd6yoCWZCSxeMBN
	4WIfyj00MrHs5iYUfWuvLAWSfiDk6cDkjnd6EyakeYrOygiDOOSV0pZ4x8wUjGGLMUgv/TAJQfx
	F65I977pTbK1l6S5pqBBwL7w7z7tHiSmlcMAiPXLkJJxAnyVoI/l7QWwaV18en13T2D6lmryQIy
	gcjiRN4ynkUeSjVss1nRGn0EFbtwT+pctdURi6iuHays77Di3pbcTRLq8c7Ss8xCwGhNsSEwWtQ
	Uk7LS8WuXZOXDVj6OIHKlNRFN8+0CSubJoIKGWUnI3pEVXcU
X-Received: by 2002:a05:620a:6190:b0:93b:f402:a204 with SMTP id af79cd13be357-93cf1787c37mr1300849285a.51.1791063112470;
        Sat, 03 Oct 2026 14:31:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2c96f4sm526896985a.43.2026.10.03.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:31:52 -0700 (PDT)
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
Subject: [PATCH v3] serial: hvc: use modern IRQ acquisition API
Date: Sat,  3 Oct 2026 14:31:48 -0700
Message-ID: <20261003213148.137206-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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
 v3: resend.
 v2: move call earlier to avoid failure to reprobe.
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
2.56.0


