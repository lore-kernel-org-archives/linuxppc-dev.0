Return-Path: <SRS0=T73o=BE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1CAC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 08:14:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81259206C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 08:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDi7yhId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81259206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BDJl23jBDzF0dd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 18:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XDi7yhId; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDJhw73s3zDqcx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2020 18:12:48 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id md7so6720910pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2020 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=em1rX+rDdO+EZvcNqlC1ieKAjVheu6k8Vunq2/2SWpM=;
 b=XDi7yhIdw+CtcZgjPTDQe1HSZzVJe9CpV3+Mjpuz8d1Jxr1+lcUf3tzrNUrJdFoBY4
 lZFCMYJsmn17GVQouefccKxkTAd/WGDkT0paIAT54AzZqjRG6uvc5hFlfCYycFCimgSz
 rGLwJEhftOP5/7x7+YnamZsqfyqSN0DEZWULR0dbu+DTu0M6gYX55PwaWoWnX2ITx/eG
 U4My6SD10MHANhS1RKW1IjnkPd6zpUGn0ILj5+TmlDNhL0VmL9mCtFF8+bWMRFNC6dPN
 nB4t5lH2QGAT8CZDWs+S1Dj8r+sYKVyXZ1yuPmVz3cSoBdGkC6zXWF2QkF0UXD10msF4
 XcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=em1rX+rDdO+EZvcNqlC1ieKAjVheu6k8Vunq2/2SWpM=;
 b=Qwd59kQH9vIQeJIr6XiTzvHsLDhiz5IIDkeFrZ2N0zWeEyZE3i7Pk2hAFwUe7UEAPZ
 b1SLxYvG1cqoU+0v8Uo2XunNvCEMttUXyUHkA+OIa3UiMQ9RRNPwoSC1ihOuq1DpCC16
 6mQ3NrXC6/wvfF3q3+2jY92b/u1i82ESv0wM/yQqTM1laMLgVupkWpGIx8wU3IE47ROn
 zCx5p9QfCwOH0sOyjZVrNrckLRJjLRhqjC+KmBKgYiHn0fSAOn25G0neut727Cy0IBLv
 qgY2jv5EXOkSmC/sn4WALsVwrg/3Ughs9tPZNFcsUCL3qmuikYSEyN7lWxAjbhEQbfQs
 BGMw==
X-Gm-Message-State: AOAM532zT5KJe5fD0aJQ3ODbO/SjOrbcYg7/7eTlH7ajd5ML5dzjWMgy
 iByIlBGHjtCpqI9AM5H+OXAQKsCy9uA=
X-Google-Smtp-Source: ABdhPJxfNjGX5b5x5OKUFalEWS8mI1hxjL73tEFXTECdm8Uixufe9lrlmGBYzf60L0Ak+B579oLOOA==
X-Received: by 2002:a17:90a:8009:: with SMTP id
 b9mr9806707pjn.190.1595664764880; 
 Sat, 25 Jul 2020 01:12:44 -0700 (PDT)
Received: from localhost.localdomain ([118.210.60.180])
 by smtp.gmail.com with ESMTPSA id a26sm8647360pgm.20.2020.07.25.01.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 01:12:44 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 01/14] powerpc/eeh: Remove eeh_dev_phb_init_dynamic()
Date: Sat, 25 Jul 2020 18:12:18 +1000
Message-Id: <20200725081231.39076-1-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
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

This function is a one line wrapper around eeh_phb_pe_create() and despite
the name it doesn't create any eeh_dev structures. Replace it with direct
calls to eeh_phb_pe_create() since that does what it says on the tin
and removes a layer of indirection.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Added sub prototype of eeh_phb_pe_create() for the !CONFIG_EEH case.
v3: Same as above, but done properly.
---
 arch/powerpc/include/asm/eeh.h             |  2 +-
 arch/powerpc/kernel/eeh.c                  |  2 +-
 arch/powerpc/kernel/eeh_dev.c              | 13 -------------
 arch/powerpc/kernel/of_platform.c          |  4 ++--
 arch/powerpc/platforms/pseries/pci_dlpar.c |  2 +-
 5 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 964a54292b36..1a19b1bb74c0 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -294,7 +294,6 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
 struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
-void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 void eeh_show_enabled(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
@@ -362,6 +361,7 @@ static inline void eeh_remove_device(struct pci_dev *dev) { }
 
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
+static inline int eeh_phb_pe_create(struct pci_controller *phb) { return 0; }
 #endif /* CONFIG_EEH */
 
 #if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_EEH)
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index d407981dec76..859f76020256 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1096,7 +1096,7 @@ static int eeh_init(void)
 
 	/* Initialize PHB PEs */
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
-		eeh_dev_phb_init_dynamic(hose);
+		eeh_phb_pe_create(hose);
 
 	eeh_addr_cache_init();
 
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index 7370185c7a05..8e159a12f10c 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -52,16 +52,3 @@ struct eeh_dev *eeh_dev_init(struct pci_dn *pdn)
 
 	return edev;
 }
-
-/**
- * eeh_dev_phb_init_dynamic - Create EEH devices for devices included in PHB
- * @phb: PHB
- *
- * Scan the PHB OF node and its child association, then create the
- * EEH devices accordingly
- */
-void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
-{
-	/* EEH PE for PHB */
-	eeh_phb_pe_create(phb);
-}
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 71a3f97dc988..f89376ff633e 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -62,8 +62,8 @@ static int of_pci_phb_probe(struct platform_device *dev)
 	/* Init pci_dn data structures */
 	pci_devs_phb_init_dynamic(phb);
 
-	/* Create EEH PEs for the PHB */
-	eeh_dev_phb_init_dynamic(phb);
+	/* Create EEH PE for the PHB */
+	eeh_phb_pe_create(phb);
 
 	/* Scan the bus */
 	pcibios_scan_phb(phb);
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index b3a38f5a6b68..f9ae17e8a0f4 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -34,7 +34,7 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
 	pci_devs_phb_init_dynamic(phb);
 
 	/* Create EEH devices for the PHB */
-	eeh_dev_phb_init_dynamic(phb);
+	eeh_phb_pe_create(phb);
 
 	if (dn->child)
 		pseries_eeh_init_edev_recursive(PCI_DN(dn));
-- 
2.26.2

