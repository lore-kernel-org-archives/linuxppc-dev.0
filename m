Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E36FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 02:04:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FC720739
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 02:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa25DBJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FC720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0TQc3jwczDqd9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 12:04:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sa25DBJk; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0Sq71jjHzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 11:37:07 +1000 (AEST)
Received: by mail-wm1-x341.google.com with SMTP id l17so37595014wmj.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jul 2020 18:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xHyBPZVyu4P9eONW2f8PiKj2LdeUBq5JU/8OZX6L4W4=;
 b=sa25DBJkVqL4BBIjGenJf25H23Q+ZThu+47vSBaNxMUK+JxFcfUDAlsLO4PjiAZE6+
 8h+Ml+f4f3sAUx8rxuUTGNVdLPzxjdGbgXlYifNWAv73P5viJ4D6UmWUriLl4Cqt07Lt
 4LlMSog74Vzp1ZO2RXhzG5qFO57ObHeN69gmCVbYYF/HXR6YbwtuLPtVn0N4k2HbsSix
 /VdNBXc8AnpBi59p0xAHWyDUVpHLy8AzYoVPgcfJthGzA7/GhismDk8oifRxaTwSqWYG
 Dzs/DfqyPrRhcjo8lPL6py1FGhgTkK0QMjosKoenB5B4acnE7a4nZNfATPWdp9MhrjZi
 yZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xHyBPZVyu4P9eONW2f8PiKj2LdeUBq5JU/8OZX6L4W4=;
 b=PceRJF6zUX6zvSTK8JALWrY5xzOpbtmViwRJZC4kSw/pbkP3BoMOxAnz7KZdUGLto3
 5h73SS3mFmcsKWkU6uXyvvEDR4Ad/BVlaISR2eiZ5I1ZUn+NzNJiKW789+MJqtKGQHq5
 y/HEHxK2s57mFYpUOl82NVRPYzu9VK6JtStSRipKEXZlEiOKtE50EgCjZB9eEI757VC0
 7O8gATSvv4/lIyHcRWYBLB2W9cgdgHzM1mvULFUYec4TPRTozygvXfT9AHdGaYrqfovO
 QeQ2qF/RKB2l4iFuQX4bkxC1Qot/U2/9tmAcfTKuwIh14oQus5X/+SjyAGduz5CgC7/d
 1+iA==
X-Gm-Message-State: AOAM530vCb2wqEJJsUhBqfSQjiujS50GT4y3RFec/Kzr97bdOelKmVtN
 Rag1myZLH/deRbTTOTRmBe2qGxQUGaU=
X-Google-Smtp-Source: ABdhPJyaYqiJ1FTAAT4RRezf9q382ykPKN6/lxcqsEatFmEKQYKQOmb/3zhOtXaoLJB/4UkVyuxTKA==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr1359413wmj.31.1593999424047; 
 Sun, 05 Jul 2020 18:37:04 -0700 (PDT)
Received: from 192-168-1-18.tpgi.com.au (59-102-73-59.tpgi.com.au.
 [59.102.73.59])
 by smtp.gmail.com with ESMTPSA id v6sm9533392wrr.85.2020.07.05.18.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 18:37:03 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/14] powerpc/eeh: Remove spurious use of pci_dn in
 eeh_dump_dev_log
Date: Mon,  6 Jul 2020 11:36:15 +1000
Message-Id: <20200706013619.459420-11-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200706013619.459420-1-oohall@gmail.com>
References: <20200706013619.459420-1-oohall@gmail.com>
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
Cc: Oliver O'Halloran <oohall@gmail.com>, mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Retrieve the domain, bus, device, and function numbers from the edev.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/eeh.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 1a12c8bdf61e..f203ffc5c57d 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -167,23 +167,17 @@ void eeh_show_enabled(void)
  */
 static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 {
-	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	u32 cfg;
 	int cap, i;
 	int n = 0, l = 0;
 	char buffer[128];
 
-	if (!pdn) {
-		pr_warn("EEH: Note: No error log for absent device.\n");
-		return 0;
-	}
-
 	n += scnprintf(buf+n, len-n, "%04x:%02x:%02x.%01x\n",
-		       pdn->phb->global_number, pdn->busno,
-		       PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+			edev->pe->phb->global_number, edev->bdfn >> 8,
+			PCI_SLOT(edev->bdfn), PCI_FUNC(edev->bdfn));
 	pr_warn("EEH: of node=%04x:%02x:%02x.%01x\n",
-		pdn->phb->global_number, pdn->busno,
-		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+		edev->pe->phb->global_number, edev->bdfn >> 8,
+		PCI_SLOT(edev->bdfn), PCI_FUNC(edev->bdfn));
 
 	eeh_ops->read_config(edev, PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
-- 
2.26.2

