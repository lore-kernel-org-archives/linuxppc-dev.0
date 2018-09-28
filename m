Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80E6C43143
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 22:51:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BA6206B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 22:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BA6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MRkP1hLmzF3Qm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 08:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MRhJ2JvkzF3KW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 08:49:51 +1000 (AEST)
Received: by mail-oi1-f196.google.com with SMTP id d63-v6so6739931oic.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 15:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qJjaNrXr1jwNWUcqFYNoeheLOX/BIq6piV6Dc8qewnY=;
 b=C+YGqvSK/HudC0Jwo2MQ5ysYQgmJ4fRUhoERxFYqGBIuElukznRKvBFE5xYB+gKbvs
 RvZnyiGbyoajrXLlCKe4In1cQk4T3/5AcQ6INvfy8RYStBfDHnXaPimhjJeUxgZ6Aho1
 MeuzN5o25wRFS2beEB+/DnlQYwa7Rn38fPdLcTny4pCEphNpSRf6ulpIDcARkUr8yf9f
 kHiMhXpSyDEIIBFO22fZg/bzvbE1ryzQCc34ScPfgPCM8EBPn0cRYmkxhgLFLd5OTLsJ
 GtXd3W8napMaaFHb01VoEdKv1MvE0yhe1fToMXfEgaFiZnCo0RV1I3JLXe3KJgLRWrC7
 Jv2g==
X-Gm-Message-State: ABuFfojlIBkxSiIJTHLyED2832KOuN8gxRPqxo00ZtalGKdofk68uyIq
 fpsfuViW+R1XyJYTNL127A==
X-Google-Smtp-Source: ACcGV62S/T/OeHDfWOwoqTgL2Zvwdw0qAKLwt/Uf3IUUTu+RpC7qS12Bw2d8UM4QWzUdbQaezf++4A==
X-Received: by 2002:aca:3546:: with SMTP id
 c67-v6mr382026oia.249.1538174989463; 
 Fri, 28 Sep 2018 15:49:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 n26-v6sm1972676oic.5.2018.09.28.15.49.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Sep 2018 15:49:48 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: Convert to using %pOFn instead of device_node.name
Date: Fri, 28 Sep 2018 17:49:47 -0500
Message-Id: <20180928224947.19058-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
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
Cc: Paul Mackerras <paulus@samba.org>, linux-i2c@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Peter Rosin <peda@axentia.se>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Remove initialization of parent

 drivers/i2c/busses/i2c-powermac.c | 17 +++++++++--------
 drivers/i2c/muxes/i2c-mux-gpmux.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index f2a2067525ef..f6f4ed8afc93 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -388,9 +388,8 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 static int i2c_powermac_probe(struct platform_device *dev)
 {
 	struct pmac_i2c_bus *bus = dev_get_platdata(&dev->dev);
-	struct device_node *parent = NULL;
+	struct device_node *parent;
 	struct i2c_adapter *adapter;
-	const char *basename;
 	int rc;
 
 	if (bus == NULL)
@@ -407,23 +406,25 @@ static int i2c_powermac_probe(struct platform_device *dev)
 		parent = of_get_parent(pmac_i2c_get_controller(bus));
 		if (parent == NULL)
 			return -EINVAL;
-		basename = parent->name;
+		snprintf(adapter->name, sizeof(adapter->name), "%pOFn %d",
+			 parent,
+			 pmac_i2c_get_channel(bus));
+		of_node_put(parent);
 		break;
 	case pmac_i2c_bus_pmu:
-		basename = "pmu";
+		snprintf(adapter->name, sizeof(adapter->name), "pmu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	case pmac_i2c_bus_smu:
 		/* This is not what we used to do but I'm fixing drivers at
 		 * the same time as this change
 		 */
-		basename = "smu";
+		snprintf(adapter->name, sizeof(adapter->name), "smu %d",
+			 pmac_i2c_get_channel(bus));
 		break;
 	default:
 		return -EINVAL;
 	}
-	snprintf(adapter->name, sizeof(adapter->name), "%s %d", basename,
-		 pmac_i2c_get_channel(bus));
-	of_node_put(parent);
 
 	platform_set_drvdata(dev, adapter);
 	adapter->algo = &i2c_powermac_algorithm;
diff --git a/drivers/i2c/muxes/i2c-mux-gpmux.c b/drivers/i2c/muxes/i2c-mux-gpmux.c
index 92cf5f48afe6..f60b670deff7 100644
--- a/drivers/i2c/muxes/i2c-mux-gpmux.c
+++ b/drivers/i2c/muxes/i2c-mux-gpmux.c
@@ -120,8 +120,8 @@ static int i2c_mux_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(child, "reg", &chan);
 		if (ret < 0) {
-			dev_err(dev, "no reg property for node '%s'\n",
-				child->name);
+			dev_err(dev, "no reg property for node '%pOFn'\n",
+				child);
 			goto err_children;
 		}
 
-- 
2.17.1

