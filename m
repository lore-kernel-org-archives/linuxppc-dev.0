Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:05:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01C421934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 01:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0bg/4iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01C421934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440w7756mjzDq5v
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 12:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0bg/4iQ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vlC2st6zDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:48:39 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so4072134plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FTwQJuUGr7h1UBt/MtQm1bIZcXeS1u3lRvTZ6hw0r4A=;
 b=s0bg/4iQjPZnJ0reI2tpSBAlkz1ZMZyElBqbSk9cPqSHJA5qB4kDaQfU0Lj4hcFHqO
 +dEh4TtsDQ+6SNSgLFuFHnTCpWzXsaU6o/cI3qtMJDnQi2yB++7y5P4rkPzxUUYnbs1W
 /BYg5z2ZxzTxDbH4xfoRHjO5yq2KbZa2r9YTmcP7oE95BIt89BvDYtouZ2XXB9PnoVU8
 IPXmEP3dt/ZjnewI3FiwRCF1s6vScVomUnkWOvdX6PU1pEDH3xZqY1rLMmOcZ0L57r1N
 3tcm6NK6i6E7X8JWVv4HxUlS5kxg6AFI7g0nCaU5h0UyQlEl3wocA+N7IF3w/661Efby
 GNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FTwQJuUGr7h1UBt/MtQm1bIZcXeS1u3lRvTZ6hw0r4A=;
 b=KPcYmxxH4HJH4nnkAWvyu6pJTEyDqNiIVN4iU6Po4SvmXq5Sg+8NHtGcUSCeTFN2aV
 12u3sm35+T4te4kJeX37NLb+guC2tX9zUPFoVKy+yhrbq6VLzuOw2q2PJ/untZaF17jp
 1R/b9k1ahH3gkeChRh1hzCUgYBgpW8e3aYYQtJ0WbK8uXU6arTzoeOSy3aZq1XbT/cSm
 RPzMJ3X57SzG1vOg3ulSpWY7s3XwkRIkGChF29Z7qKRVA/6V9cK3XM2ZKWzHtjr0S/RB
 k5lWDA0UdH7Of5puiU6/jAopH77ncqlTrIa9yKmRkEgl2bMSbhwGgzE3BJxWsIeYlKOt
 zVfA==
X-Gm-Message-State: AHQUAuZ2iSc6PsyQElxq5jokPFH6+gobHFj3K13BzeXIfHBrdaKiPMD5
 eK5NnUhk0zAZjlnCXs3bxZP2NUEA
X-Google-Smtp-Source: AHgI3Ib+ZjevH8eddJ1w9dece0gFtAlxf90nnwi3hfOswudnwtdUQB2Xz9PPo0eg10HCG4KpxdFfZQ==
X-Received: by 2002:a17:902:7204:: with SMTP id
 ba4mr7305752plb.186.1550191717571; 
 Thu, 14 Feb 2019 16:48:37 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id v26sm4993751pfg.62.2019.02.14.16.48.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 16:48:37 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/7] powerpc/pci: Add pci_find_controller_for_domain()
Date: Fri, 15 Feb 2019 11:48:15 +1100
Message-Id: <20190215004817.19961-5-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215004817.19961-1-oohall@gmail.com>
References: <20190215004817.19961-1-oohall@gmail.com>
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a helper to find the pci_controller structure based on the domain
number / phb id.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: Renamed pci_find_hose_for_domain() to
    pci_find_controller_for_domain()
---
 arch/powerpc/include/asm/pci-bridge.h |  2 ++
 arch/powerpc/kernel/pci-common.c      | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index aee4fcc24990..feea9534a015 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -274,6 +274,8 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
 extern struct pci_controller *pci_find_hose_for_OF_device(
 			struct device_node* node);
 
+extern struct pci_controller *pci_find_controller_for_domain(int domain_nr);
+
 /* Fill up host controller resources from the OF node */
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			struct device_node *dev, int primary);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 88e4f69a09e5..21eeeabb3e0e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -357,6 +357,17 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
 	return NULL;
 }
 
+struct pci_controller *pci_find_controller_for_domain(int domain_nr)
+{
+	struct pci_controller *hose;
+
+	list_for_each_entry(hose, &hose_list, list_node)
+		if (hose->global_number == domain_nr)
+			return hose;
+
+	return NULL;
+}
+
 /*
  * Reads the interrupt pin to determine if interrupt is use by card.
  * If the interrupt is used, then gets the interrupt line from the
-- 
2.20.1

