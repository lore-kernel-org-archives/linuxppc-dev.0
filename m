Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74BC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:32:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F007720771
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 04:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vby5ZaWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F007720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBMyV00VyzDqcY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vby5ZaWh; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBMqX6KHdzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:26:48 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id a14so520828pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 21:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WPgbA6syf2uFsq+aIVI8/TqLCA8J+yQihPglV3lGMig=;
 b=vby5ZaWh0I4sl56m5z8Erd850E4zzITE22dkhDrEBfBsryKBrTwWwiouuMh7Yk9ZYZ
 Jbkd9OEhWC/1M4WeEgDQwUaaLjxPGPNfbHKdHUsAlQ25whS0crWZ1tso2MC3z8tIppXT
 ekK6secYeTGemWGmgdGKuV+6VXxPQc307TGY8Su935jaAPBFti/pwijwjQhXY1gQTY75
 pTMrNEUIxHvqFTlTBRnUxc518CF9Q7mFobketg+Fx/tzUs8FMuuwQLiEGksenENBg5JU
 Y2R0ahvfkURs742wEFEb1LCCr87ZNEPE4PM7Bd1OdQSFlpN334BhVwtOaDqbBN82Tjp5
 rvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WPgbA6syf2uFsq+aIVI8/TqLCA8J+yQihPglV3lGMig=;
 b=XVkbojrKUTBFX2KbT8S4ezYqibhDC2bqCO0Asit2cCePB/KwJwu5xk0YFwPT9mwpub
 o1niNbO7kDurD+0+i89zb1jeVAzDB01aScWQHSQaPFS4GLvzKVur9vS1hCCKTJw9qAcF
 5+4QeVhvse6kNP1LXIhVlmXIBDK0d8Dlb6DP/TLK5bYMAdpXVrwoNxrSosOUiz0yJtuH
 DMRXbNyjBL8PGT4T9fGVBC9HAFFfb4lejUQ2vTTWiVxJg9upFb6yzn3jXc4o17NbuVu8
 64m6msuVHYsn0rzRjEdIy6W9v0rKnSwl6+IB0ucACUL3TI+fbOP0OxRomMToLxL86oyg
 gyrw==
X-Gm-Message-State: AOAM531dh5os++vVBRK80sMzlijDgtiwbqCC+FMs9D8dpMJ9VB2rqgkr
 HhDsLOO17b5FCa7h+BU61iYdvk5njgw=
X-Google-Smtp-Source: ABdhPJxeKyeWFIin/ZYMaDuwMj8cTsqt07u9wUkDh9iOkaJhq3w59alxC/oTL7jlsKCNTRCIPy8dzA==
X-Received: by 2002:a63:3cc:: with SMTP id 195mr24267810pgd.296.1595392005584; 
 Tue, 21 Jul 2020 21:26:45 -0700 (PDT)
Received: from localhost.ibm.com (203-219-159-24.tpgi.com.au. [203.219.159.24])
 by smtp.gmail.com with ESMTPSA id d4sm20583709pgf.9.2020.07.21.21.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 21:26:45 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 02/14] powerpc/eeh: Remove eeh_dev.c
Date: Wed, 22 Jul 2020 14:26:16 +1000
Message-Id: <20200722042628.1425880-2-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722042628.1425880-1-oohall@gmail.com>
References: <20200722042628.1425880-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The only thing in this file is eeh_dev_init() which is allocates and
initialises an eeh_dev based on a pci_dn. This is only ever called from
pci_dn.c so move it into there and remove the file.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: no change
---
 arch/powerpc/include/asm/eeh.h |  6 ----
 arch/powerpc/kernel/Makefile   |  2 +-
 arch/powerpc/kernel/eeh_dev.c  | 54 ----------------------------------
 arch/powerpc/kernel/pci_dn.c   | 20 +++++++++++++
 4 files changed, 21 insertions(+), 61 deletions(-)
 delete mode 100644 arch/powerpc/kernel/eeh_dev.c

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 64487b88c569..8537dd334094 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -293,7 +293,6 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
 void eeh_show_enabled(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
@@ -339,11 +338,6 @@ static inline bool eeh_enabled(void)
 
 static inline void eeh_show_enabled(void) { }
 
-static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
-{
-	return NULL;
-}
-
 static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
 
 static inline int eeh_check_failure(const volatile void __iomem *token)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 244542ae2a91..c5211bdcf1b6 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
 obj-$(CONFIG_PPC_DT_CPU_FTRS)	+= dt_cpu_ftrs.o
-obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
+obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
deleted file mode 100644
index 8e159a12f10c..000000000000
--- a/arch/powerpc/kernel/eeh_dev.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * The file intends to implement dynamic creation of EEH device, which will
- * be bound with OF node and PCI device simutaneously. The EEH devices would
- * be foundamental information for EEH core components to work proerly. Besides,
- * We have to support multiple situations where dynamic creation of EEH device
- * is required:
- *
- * 1) Before PCI emunation starts, we need create EEH devices according to the
- *    PCI sensitive OF nodes.
- * 2) When PCI emunation is done, we need do the binding between PCI device and
- *    the associated EEH device.
- * 3) DR (Dynamic Reconfiguration) would create PCI sensitive OF node. EEH device
- *    will be created while PCI sensitive OF node is detected from DR.
- * 4) PCI hotplug needs redoing the binding between PCI device and EEH device. If
- *    PHB is newly inserted, we also need create EEH devices accordingly.
- *
- * Copyright Benjamin Herrenschmidt & Gavin Shan, IBM Corporation 2012.
- */
-
-#include <linux/export.h>
-#include <linux/gfp.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-/**
- * eeh_dev_init - Create EEH device according to OF node
- * @pdn: PCI device node
- *
- * It will create EEH device according to the given OF node. The function
- * might be called by PCI emunation, DR, PHB hotplug.
- */
-struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
-{
-	struct eeh_dev *edev;
-
-	/* Allocate EEH device */
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev)
-		return NULL;
-
-	/* Associate EEH device with OF node */
-	pdn->edev = edev;
-	edev->pdn = pdn;
-	edev->bdfn = (pdn->busno << 8) | pdn->devfn;
-	edev->controller = pdn->phb;
-
-	return edev;
-}
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 4e654df55969..f790a8d06f50 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -124,6 +124,26 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
 	return NULL;
 }
 
+#ifdef CONFIG_EEH
+static struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev;
+
+	/* Allocate EEH device */
+	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return NULL;
+
+	/* Associate EEH device with OF node */
+	pdn->edev = edev;
+	edev->pdn = pdn;
+	edev->bdfn = (pdn->busno << 8) | pdn->devfn;
+	edev->controller = pdn->phb;
+
+	return edev;
+}
+#endif /* CONFIG_EEH */
+
 #ifdef CONFIG_PCI_IOV
 static struct pci_dn *add_one_sriov_vf_pdn(struct pci_dn *parent,
 					   int vf_index,
-- 
2.26.2

