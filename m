Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AFAC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:58:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119BD20850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119BD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398gY0RJ0zDr0f
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:58:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398VY5b5jzDqXK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:51:01 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id x202so18595523oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=95v299N8kaDRKNE2Prutd/fuPK+JAW7Lyf4TJG2OQ3w=;
 b=rTto9shv3M8FVGpsCin5TysOyvVuaoolWNy2hV5s0XNjeb/NeT03SZGNsguj4lqOzJ
 mcrauA0cZqmsw5c+IEgIGKJ5KfadIbj73v6hxp3ls49OksHQOri4+NqnrrpaO73S7bXT
 7RkQ+EcTCEoFMc2/Wp3dAwVFRD1/gZTAmYo+ixI04XiZCGYC8YUkkaB2L+iz2Ao8YE4A
 sWjksUvD0D9xIdD15RnmWoOW7MKtiXBE1f4FdDQ4JrUOQxXmx03N8W74/90RrHSgCv3A
 PIzeK23qKjGhD3cdxS4p1jow5G8MAnzY2haMuqikZEbpqB7/dwdNtNRBPjje7H/U0alp
 XsWQ==
X-Gm-Message-State: AA+aEWbaukni197/Y8IzvYuq8aVjbQ/Ik2v3h0YY5dKdANhJSEePy9ll
 aosAERl8qWU0+1isQSKlmA==
X-Google-Smtp-Source: AFSGD/U/BhIK5HWrmu8AYPyJZr/C+BCGzlNsvIP4c9x60R84Yomzon+HhAD85vVQOIe9LLy3bCa9LA==
X-Received: by 2002:aca:d644:: with SMTP id n65mr15258115oig.287.1544039459973; 
 Wed, 05 Dec 2018 11:50:59 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:50:59 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: powermac: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:24 -0600
Message-Id: <20181205195050.4759-8-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/i2c/busses/i2c-powermac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f6f4ed8afc93..281113c28314 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -229,9 +229,9 @@ static u32 i2c_powermac_get_addr(struct i2c_adapter *adap,
 		return (be32_to_cpup(prop) & 0xff) >> 1;
 
 	/* Now handle some devices with missing "reg" properties */
-	if (!strcmp(node->name, "cereal"))
+	if (of_node_name_eq(node, "cereal"))
 		return 0x60;
-	else if (!strcmp(node->name, "deq"))
+	else if (of_node_name_eq(node, "deq"))
 		return 0x34;
 
 	dev_warn(&adap->dev, "No i2c address for %pOF\n", node);
@@ -304,7 +304,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter *adap,
 	}
 
 	/* Now look for known workarounds */
-	if (!strcmp(node->name, "deq")) {
+	if (of_node_name_eq(node, "deq")) {
 		/* Apple uses address 0x34 for TAS3001 and 0x35 for TAS3004 */
 		if (addr == 0x34) {
 			snprintf(type, type_size, "MAC,tas3001");
@@ -331,7 +331,7 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 	 * case we skip this function completely as the device-tree will
 	 * not contain anything useful.
 	 */
-	if (!strcmp(adap->dev.of_node->name, "via-pmu"))
+	if (of_node_name_eq(adap->dev.of_node, "via-pmu"))
 		return;
 
 	for_each_child_of_node(adap->dev.of_node, node) {
-- 
2.19.1

