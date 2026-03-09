Return-Path: <linuxppc-dev+bounces-17938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40369FCA191
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 22:51:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVC0f4SXNz3c8W;
	Tue, 10 Mar 2026 09:50:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773073539;
	cv=none; b=Nxp2xFxxZQCRGEkeqQ//g1lz0/JkbDq96AL9QAYw8w/WdoBk4Ku0zYueKt/FiQRfxeEiTIQC3Ry7BuAyqNDuJNfCZ+J7TVq7ylnCWPs542XbOBW2JNrep/trodrNbvkd9LbTh/M2Kj4wj1uMgyDXENIcjS7LmSSjTbe5tfQYJIG/8t/2F3WHYaaj2qHVl/HOZteUSGAttz9NbD4gZ58CPeJjIhwNZbahlCkf4PMdSsVM/3D6OEIyDHo0CxZ257zhhRkTEAUHqHbkOiRGfD4Kky0LxfNtVdGHGEv2bO3/Oka2uNVxGCsALO0Qtd2HLnzNfKr2f5Y6T29SFbd/Dh2yuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773073539; c=relaxed/relaxed;
	bh=amj6Vi3JmO2oRqniQL19eS7V9c7NrB8GmPrszxzYH5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LTz3LfFRIfYeTLuGrcTqnxQN1wVWd+DLdwekpzUfws/+rc+Ay8zqXVYpA04AR+0PDmtNvtDKlCbpJxGNToQuarIOEP2E9UOSycCeEBfhElHtu4wzZ/eiJNcUE1um5RWyMdzA1FJII/dcY6mo03Ifqc/PDDcaIw5i3JnCycRNsRzfpj6LoDkw9jHqaSgwWedmAWYKSp5W6kT8vfNr1wp/S+ThOFfsh0O0I3Kx7OAnse9oE6bl/1XVJ5LOk5In7Rq39+E3nd6NY3gYdkm5wvZ6SJbIYx6zzC0WHlaCzLRbnActSuxYQy/f7zEw04mHzNluvH3ogIt/TBOLpMRZkaWwJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DOceSecZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DOceSecZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ustc.gu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2S15j4hz3c9l
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 03:25:36 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so4977620a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073534; x=1773678334; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amj6Vi3JmO2oRqniQL19eS7V9c7NrB8GmPrszxzYH5Q=;
        b=DOceSecZC5AKX4OOvt4HSneRjKgXc9gC0K6jMhrF+0Bp5qQKxXex2DbGitCzF+yuri
         W8MDKKZQ9Fpws77sglu5VycPmF4xZXxViiqr9ZUd6JYwDF9JHJbBUz5k+0FihHML92sy
         DySr5EQDvIaxgbKRuQPYgvGBqqeE4cz3PzRw3xex0k7Fyqte3IEI43ELaoQnkTOzqBDd
         EJMStIShNAhlSpUyfvuzWaWPZOZW66HZw1rJUwf/ZPJcBWWHRooejvZ8t3AThGEVOI2G
         +n2xmX11YZFgTICl6tv80Nq3rcoJhKH91so9hqtPAhB37yE4k/84hkTDZd+E9sRLD2S0
         B4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073534; x=1773678334;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amj6Vi3JmO2oRqniQL19eS7V9c7NrB8GmPrszxzYH5Q=;
        b=U4uL40p4o70TyIdmmdy5vKJhT+10tBAyqkYfX6IE/3DJSdA+5V5Rl+lPS02DhD1wRB
         u1lIdMDX1Q9GewhqwVRItQ5Rtn+FRxI2DQ1fAREDzTpLUEr0R8YiBJa9gudbwt1dbqMR
         IUswFQPi0O5Kr+DPmE/6LKfgQbneR7XRwIViopGbkDR+PygtVVNvJvkUrK2xgEWyXE9U
         Ye7Wm06QcmBQbynA8pp0lIuYOKcN2f0VSSnmNBRvKtYO7kWLaVrzbm85UrxAWEvyvbab
         9k7cC0svrILh++tPc+nx+HFDJsJlzcUR9SHxaNeM+VEa4lxcYJfjDOswu0yqoPfgqTs3
         Ld8Q==
X-Gm-Message-State: AOJu0YwdGElKD/OA8KWV8MaEyQAJv1Kf0mwZ5K4yNFWPijWB1RKAhBtY
	S914GNjJVdjPKYPfr/JVOfC2ig0zT9vOLdVa4AOLgkfaH5fzkKuIHlxF
X-Gm-Gg: ATEYQzxicniTJ9ua0I5Ne7v1rHeEzwNCw5phMltEpSTpjCnGRk15TqlYMWz+79p2j3G
	cX3LL3K2UiyawtCbMN9kJFZ+L5p9JUJY8zpOd2utgoNjchrScdD8bRURGk5HQrRgIhUjhoiIWIo
	hN9iHys3qmleyKD0b3+gxwHBNenktwXVaAPpFoKWpe6V/F6PZCpfUqBwS34tGog0NeD/BrVddUS
	GJfmkyVAV5+VMyqdvFpDJ4j/m1fTl51HtaqrO0jpZx+mYk+cvv1QawtBzMTtyoVBVcR5V3cGrM8
	HRfuzGtTtad45PD/wdPa9xdl9nd4Dn3acnK+iJd9bvqhNQnf/rFMNs/o0PUblBa79OiH9SefV2p
	cS9HRKhW8PSrxmM18xuPzM7sZQFPppJT08iJ5U9uYKeUO0t0lcbev97FALkh3TE0Or8UkacXs/a
	JSAvUxWmTzu3I59PFIKi44AtOMXmPOS16C35LC
X-Received: by 2002:a17:90b:184c:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-359be2bfbfdmr10994814a91.12.1773073533488;
        Mon, 09 Mar 2026 09:25:33 -0700 (PDT)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:a816:d74a:dc19:1ab8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05ee51csm93198a91.1.2026.03.09.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:25:33 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 10 Mar 2026 00:25:30 +0800
Subject: [PATCH] soc: fsl: qe_ports_ic: Add missing cleanup on device
 removal
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-qe_ports_ic-v1-1-608293026561@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHn0rmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MD3cLU+IL8opLi+Mxk3eREk2RLi6QUw2STNCWgjoKi1LTMCrBp0bG
 1tQBw1Lw+XQAAAA==
X-Change-ID: 20260310-qe_ports_ic-ca4c98bd1c4f
To: Qiang Zhao <qiang.zhao@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773073531; l=2073;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=f/RO7d/NYBpPJNaikZKFHoe0PWI37oNS5SAvFGmT8u8=;
 b=rQOMzyC4PngOHoIqO/7Df48MEyWpk4Oq7n+UJMoMvx/yCaEy1QVE4QxtLf/8M0dTWTRlNeTre
 OBK6HibNoz9BSdq5rxEWpjidNyO7PJHufEyodw+dTqpnS22U+VATvl+
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Add a devm action handler to properly clean up the irq_domain and
chained handler when the device is removed.

Fixes: f0bcd784e1b7 ("soc: fsl: qe: Add an interrupt controller for QUICC Engine Ports")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/soc/fsl/qe/qe_ports_ic.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ports_ic.c b/drivers/soc/fsl/qe/qe_ports_ic.c
index 8e2107e2cde5..5e3fae19f314 100644
--- a/drivers/soc/fsl/qe/qe_ports_ic.c
+++ b/drivers/soc/fsl/qe/qe_ports_ic.c
@@ -17,6 +17,7 @@
 struct qepic_data {
 	void __iomem *reg;
 	struct irq_domain *host;
+	int irq;
 };
 
 static void qepic_mask(struct irq_data *d)
@@ -92,11 +93,18 @@ static const struct irq_domain_ops qepic_host_ops = {
 	.map = qepic_host_map,
 };
 
+static void qepic_remove(void *res)
+{
+	struct qepic_data *data = res;
+
+	irq_set_chained_handler_and_data(data->irq, NULL, NULL);
+	irq_domain_remove(data->host);
+}
+
 static int qepic_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qepic_data *data;
-	int irq;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -106,17 +114,18 @@ static int qepic_probe(struct platform_device *pdev)
 	if (IS_ERR(data->reg))
 		return PTR_ERR(data->reg);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
 
 	data->host = irq_domain_add_linear(dev->of_node, 32, &qepic_host_ops, data);
 	if (!data->host)
 		return -ENODEV;
 
-	irq_set_chained_handler_and_data(irq, qepic_cascade, data);
+	irq_set_chained_handler_and_data(data->irq, qepic_cascade, data);
+
+	return devm_add_action_or_reset(dev, qepic_remove, data);
 
-	return 0;
 }
 
 static const struct of_device_id qepic_match[] = {

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260310-qe_ports_ic-ca4c98bd1c4f

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>


