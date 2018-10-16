Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6082BC04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:59:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFB22147E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaiPvwD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFB22147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z0QY3YZbzDrDT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:59:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OaiPvwD2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OaiPvwD2"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzF5zP0zF3Wd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:21 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c25-v6so10652715pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k3NmJ/BND4BSxo8ekIb0GkfOMcrXW/U/Gc8POw3t3ig=;
 b=OaiPvwD2plx5vYUSDpsUGWs6tzYyUjWreHYu+XdKfwBAlhsu3Q3eb2Rv0hY8fzQRwJ
 z7Yk+FjvhywQV2WSV4zDj5Mh4BDJax+OE2YsMA23u4+KLKtcz0qRqyJalx5bq7E1quwK
 z4EDorVOpK6Y6T38JJ24T9ocJFFcqv882VNZawoXSaRjHbBTEiW5iEmpdjyBaoy+JjwV
 q+JgRCExj9IAg9yU3nWSBc/mYEtjYHexrR8AUUja24MeQX9nqKPuFRQ3iV5GSXKtnQvW
 l9H6T5HxJFEo/1zsM1op0nRFSDKW6l2eSNWmnXp03wZB+EGEXqQuU2uMWvdMUPh1KfUR
 DyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k3NmJ/BND4BSxo8ekIb0GkfOMcrXW/U/Gc8POw3t3ig=;
 b=kHi1k8H1O3Mt1KwU9fxoyJGFKxwa689Ymg7aiZx5wyppzkRD3NdtY/AfXrznVPerYE
 D6pQv1QsyyWz85O/HizdRK09O9f0XwIxGaabA+TSNgigCwOO6r5f7SPexfvzN6GQLSTw
 Y3HqF0lw+Jq1bXRRthz7qGKaRLYVWqQShvNA3cFrckvJWm5JPACcn2S8pfCm0pYXsU6v
 r3GHzNMkZlynfvdqjncAYNFb7i/9mSJqz+px1Hj8k34wrh0fDWPPAqXXWp0mXowrrXEf
 arO3IZDKCjoe1aFxfpWIo8pfO7sb6wlr4UZGh/SZV2ukNOBwTZKNGrIGf1W4mhnGPHzh
 /ANg==
X-Gm-Message-State: ABuFfohPpuxZE7aEgOfDFGgOKrp2qZMK9p6/Bdrucgjg5aN9EQkmRmcL
 1hnD5vrpdNmBAWA8AFErvEw=
X-Google-Smtp-Source: ACcGV608fFf0DCYd0Cm3FGyMjFYvcB6NFvBCvQ+y0xOskeOusXL98LiKZDE/pKTOkc++NiCO6xlBJg==
X-Received: by 2002:a62:1c06:: with SMTP id
 c6-v6mr20404340pfc.41.1539657560194; 
 Mon, 15 Oct 2018 19:39:20 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:19 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 07/18] of: dynamic: change type of of_{at,
 de}tach_node() to void
Date: Mon, 15 Oct 2018 19:37:27 -0700
Message-Id: <1539657458-24401-8-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

of_attach_node() and of_detach_node() always return zero, so
their return value is meaningless.  Change their type to void
and fix all callers to ignore return value.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/powerpc/platforms/pseries/dlpar.c    | 13 ++-----------
 arch/powerpc/platforms/pseries/reconfig.c |  6 +-----
 drivers/of/dynamic.c                      |  9 ++-------
 include/linux/of.h                        |  4 ++--
 4 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index e3010b14aea5..0027eea94a8b 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -244,15 +244,9 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 
 int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 {
-	int rc;
-
 	dn->parent = parent;
 
-	rc = of_attach_node(dn);
-	if (rc) {
-		printk(KERN_ERR "Failed to add device node %pOF\n", dn);
-		return rc;
-	}
+	of_attach_node(dn);
 
 	return 0;
 }
@@ -260,7 +254,6 @@ int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 int dlpar_detach_node(struct device_node *dn)
 {
 	struct device_node *child;
-	int rc;
 
 	child = of_get_next_child(dn, NULL);
 	while (child) {
@@ -268,9 +261,7 @@ int dlpar_detach_node(struct device_node *dn)
 		child = of_get_next_child(dn, child);
 	}
 
-	rc = of_detach_node(dn);
-	if (rc)
-		return rc;
+	of_detach_node(dn);
 
 	of_node_put(dn);
 
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 0e0208117e77..0b72098da454 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -47,11 +47,7 @@ static int pSeries_reconfig_add_node(const char *path, struct property *proplist
 		goto out_err;
 	}
 
-	err = of_attach_node(np);
-	if (err) {
-		printk(KERN_ERR "Failed to add device node %s\n", path);
-		goto out_err;
-	}
+	of_attach_node(np);
 
 	of_node_put(np->parent);
 
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index fe8816cca99b..a94f727ec3da 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -224,7 +224,7 @@ static void __of_attach_node(struct device_node *np)
 /**
  * of_attach_node() - Plug a device node into the tree and global list.
  */
-int of_attach_node(struct device_node *np)
+void of_attach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
 	unsigned long flags;
@@ -241,8 +241,6 @@ int of_attach_node(struct device_node *np)
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_ATTACH_NODE, &rd);
-
-	return 0;
 }
 
 void __of_detach_node(struct device_node *np)
@@ -273,11 +271,10 @@ void __of_detach_node(struct device_node *np)
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
  */
-int of_detach_node(struct device_node *np)
+void of_detach_node(struct device_node *np)
 {
 	struct of_reconfig_data rd;
 	unsigned long flags;
-	int rc = 0;
 
 	memset(&rd, 0, sizeof(rd));
 	rd.dn = np;
@@ -291,8 +288,6 @@ int of_detach_node(struct device_node *np)
 	mutex_unlock(&of_mutex);
 
 	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
-
-	return rc;
 }
 EXPORT_SYMBOL_GPL(of_detach_node);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index aa1dafaec6ae..72c593455019 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -406,8 +406,8 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 #define OF_RECONFIG_REMOVE_PROPERTY	0x0004
 #define OF_RECONFIG_UPDATE_PROPERTY	0x0005
 
-extern int of_attach_node(struct device_node *);
-extern int of_detach_node(struct device_node *);
+extern void of_attach_node(struct device_node *np);
+extern void of_detach_node(struct device_node *np);
 
 #define of_match_ptr(_ptr)	(_ptr)
 
-- 
Frank Rowand <frank.rowand@sony.com>

