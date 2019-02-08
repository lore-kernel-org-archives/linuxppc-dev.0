Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE13C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:16:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EED2146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 03:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI92gZUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EED2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wgMJ5vWszDqMx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:16:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pI92gZUv"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wg9l1mZ8zDqVs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 14:08:27 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id c73so975918pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 19:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BHhOTwz/mUdH9y7ngAafp70OCACSi4EoAfLi1XwkdPs=;
 b=pI92gZUvoF5e+dMgETv5Vb/aLVKg1WHi4phAlA+pM0NOsDs9XBvWPDYxPTlPsgm9nI
 M2tfqyKRQbt0A3FkUkcI6svJwGJykABSmJ0VHHbnHsj3gzekNpHFUhhwlXcQ5/jRMuzK
 Vf03q+Dr2lQObtQkhL3HTB0CoFV+5RXwoPPsstm1se9glVCVmeP3XC2vqHqQ2c3En0w9
 24Yd5sQoRck0C6HaG09YiTf5hD7RGcRlpb2X9mCn/UjwWCakxe8YhWYy0i2m8J+9S6Yq
 2KxJBCL7H8MRe2Y+5IzCj60twywCH8+Bvmf2UmXkO+ZDlesBHAz90SdTAwDvoJEJSnu2
 7TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BHhOTwz/mUdH9y7ngAafp70OCACSi4EoAfLi1XwkdPs=;
 b=sr8nwTzfk6tTiquRLZFULr0koD+U6Nrsvax2YTmF3kqpT9ennCyUM/FSPl1zMHpI7L
 6pMPzyXEwTmv9Sy5oC+DoJpy+w30O/61ckyuRv7FucBhembqVUIHvStCTFvnsphqb7AY
 +u/qJgx5Xe9zhp4LTVIG5psQb4bS+UHX7qc4RUrlgjTyyZKzpOkfWVlMPjkyPscFyQY1
 OsZkkoB//4EhrmUSTCOg28jwk4JD6eWMjWTRE5f8qAl5CIy2fbaL7xjew30wvv7mVVIP
 diIKNRIVk1C3Ezu8aSsuyEJKMLNtIVSn++YBQxfnaGrrmcL9p75traLuZeJPzBVDGcMq
 x15w==
X-Gm-Message-State: AHQUAuak1ixNDwE2ZRLRpCTtuFg0UnvclkWV0umnwJKRT1uvsiuUrej3
 m8x0WpSjnZDMivYLEQUA2sN4cY4R
X-Google-Smtp-Source: AHgI3IZ1AVVjjRGOesYHEEmAUC0i5CWXAcvrgZ65ChcAO4mrUUcnUsI2hBI2anH6dfKRvIgYHIRaeA==
X-Received: by 2002:aa7:850c:: with SMTP id v12mr4318410pfn.145.1549595305106; 
 Thu, 07 Feb 2019 19:08:25 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o66sm658884pgo.75.2019.02.07.19.08.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 19:08:24 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/7] powerpc/pci: Add pci_find_hose_for_domain()
Date: Fri,  8 Feb 2019 14:08:00 +1100
Message-Id: <20190208030802.10805-5-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208030802.10805-1-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
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

Add a helper to find the pci_controller structure based on the domain
number / phb id.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  2 ++
 arch/powerpc/kernel/pci-common.c      | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index aee4fcc24990..149053b7f481 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -274,6 +274,8 @@ extern int pcibios_map_io_space(struct pci_bus *bus);
 extern struct pci_controller *pci_find_hose_for_OF_device(
 			struct device_node* node);
 
+extern struct pci_controller *pci_find_hose_for_domain(uint32_t domain_nr);
+
 /* Fill up host controller resources from the OF node */
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			struct device_node *dev, int primary);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 88e4f69a09e5..958f38c698da 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -357,6 +357,17 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
 	return NULL;
 }
 
+struct pci_controller *pci_find_hose_for_domain(uint32_t domain_nr)
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

