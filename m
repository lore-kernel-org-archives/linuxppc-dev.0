Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E28C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:54:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CAF20850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 19:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CAF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4398Z51wKSzDqtk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 06:54:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4398VQ1RjzzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 06:50:54 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id w13so18622602oiw.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 11:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0eacEPZ/q29QHdXEtgllpAxXndz/of7y8zfxjsQnjWw=;
 b=GUtV+LIiJtCPy/ErB0/okWWIUKkaSgGgK2EoA1vAKaKVCtwzrA4sZvT6Z642EV+kFJ
 sjKsGXGDMcZtWvhfmZsyGh/8L8G1TfyUT2tCabTBzfhEdaNX2OEtvmp55ThnEE+6qRuP
 9hoAKa225brykR4fMWfrRUOf6HKJ/g9n2oMbmABSKdiDlCm3uEvZbXBSE5pwy/JRMPSm
 EBKw+/Zd0tb/mcTKO2lnOHhThoxIwOBaYc53bQPgMeJbQ55jsmfIhzPX+HU0fuZw7vdj
 U5nnyGiGMXAhB5tt9+j2X2H4R56nmXUk8LbIBdq/O9puZyzIYs+gzqfUk7jIyNcm0BY2
 u/tA==
X-Gm-Message-State: AA+aEWamADTOvmsGPBeUx5lfLP2Jvk9vl37kIjylPVZSsAqfzdhETSPv
 DhgK8Aohg9jHXYlTKbJQ6Gp/EY4=
X-Google-Smtp-Source: AFSGD/URpix61sQvCxE1cgkH52X1QspSG78AH0Y+CfPHhNX+ApN3AH0WS9juWTX2F2S4rIs5iyw6Sw==
X-Received: by 2002:aca:d644:: with SMTP id n65mr15257858oig.287.1544039451943; 
 Wed, 05 Dec 2018 11:50:51 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:50:51 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: pseries: pmem: Convert to using %pOFn instead of
 device_node.name
Date: Wed,  5 Dec 2018 13:50:17 -0600
Message-Id: <20181205195050.4759-1-robh@kernel.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier. pmem.c was
recently added and missed the initial conversion.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/platforms/pseries/pmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index a27f40eb57b1..27f0a915c8a9 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -52,8 +52,8 @@ static ssize_t pmem_drc_add_node(u32 drc_index)
 	/* NB: The of reconfig notifier creates platform device from the node */
 	rc = dlpar_attach_node(dn, pmem_node);
 	if (rc) {
-		pr_err("Failed to attach node %s, rc: %d, drc index: %x\n",
-			dn->name, rc, drc_index);
+		pr_err("Failed to attach node %pOF, rc: %d, drc index: %x\n",
+			dn, rc, drc_index);
 
 		if (dlpar_release_drc(drc_index))
 			dlpar_free_cc_nodes(dn);
@@ -93,8 +93,8 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
 
 	rc = dlpar_release_drc(drc_index);
 	if (rc) {
-		pr_err("Failed to release drc (%x) for CPU %s, rc: %d\n",
-			drc_index, dn->name, rc);
+		pr_err("Failed to release drc (%x) for CPU %pOFn, rc: %d\n",
+			drc_index, dn, rc);
 		dlpar_attach_node(dn, pmem_node);
 		return rc;
 	}
-- 
2.19.1

