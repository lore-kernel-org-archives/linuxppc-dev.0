Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D8BC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 04:16:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8A820855
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 04:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwOywCX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8A820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gngW5fDtzDqvL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 15:16:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qwOywCX7"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gndY5v4TzDqtQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 15:14:25 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so5741442pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 20:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QvatLJrzlgOvaGkj3zRF3vT9ge5UNz5ivCppBZRnLFY=;
 b=qwOywCX7m7l+Uqpp56fSpH4aBzHfa6HCIteKp8zQcXpnIGtPllEmZEQfdTR1xOGsbo
 WfemIiabUMQZxuY2PKCwW7axrbmR1Jfq5iKZpEDfvuHJMCbzRoPn5Fs04hbZAkh/J2Wy
 CB0M6h+Bl2eRX1PQzCTmubxCMZZwhppL6FjVbnWrpB2mqgrMmlKGQHjQGn3vVWMobut/
 3S0fZIjzbBsdwY4syHgW2jTJxfYvFsGjbpUR8WmyLtKpA2oYKOjc06wrDeNqG82vxQ0H
 pkbUX5/nAgvEtDWu27aen5xeiUXVnCJ/jhxctkO0VvG0uP9X2Yd1QdNxC5g/N4ENKZ5t
 j3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QvatLJrzlgOvaGkj3zRF3vT9ge5UNz5ivCppBZRnLFY=;
 b=jKV/clunzvmh46FWXu0KCNxj26HzKIcyasI6q9kBlQx7nshW+cn7cNmqrt+tzlvmHB
 xXoXxY77T3YQdYwI0K9SKKH/0tPu++FIjSUFrghE23M3JYivAsQKLIOcsEOb7GK5F9HE
 QXKQ7KQSUmwP33tHilOlhoxYZGpE8uBkWG1MHQs1I8qTzGfK6bwqWrxFoloqZYwY85kp
 B6hNTWLlIi8+n+2bm+flBqnc+dGYZRpTOUzxkW81xHwWi5i+K4gNHEFn30ipgt27u91M
 vRL8k7PCmbbsG0ePY2418LG4Tcd5hA/ArvuQg3SeLb1xZaWgR/418wYZunNZ5P5HoQHG
 aC4A==
X-Gm-Message-State: AJcUukfzqXQzDU7THwhv9X8UiLkcMzBq8ja/2IHTpuLosAa94wrNJluF
 6xLWpqFaM+UmhtAL6KSr8QMAhSh0
X-Google-Smtp-Source: ALg8bN5Lxyg44HwP/47hvaZeOIZ9glZ95Cx0CJqpaEtf8X0rxg2xZZ+fr8WddCyg49PTlYVYvRbe7w==
X-Received: by 2002:a17:902:5a5:: with SMTP id
 f34mr17719846plf.161.1547784862944; 
 Thu, 17 Jan 2019 20:14:22 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id c13sm6029554pfe.93.2019.01.17.20.14.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 20:14:22 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Force an freset if IODA reset fails
Date: Fri, 18 Jan 2019 15:14:07 +1100
Message-Id: <20190118041407.25792-1-oohall@gmail.com>
X-Mailer: git-send-email 2.20.1
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

The IODA reset can fail in cases where the PHB has encounted a fatal error
during early boot. Typically this is due a malfunctioning device directly below
the root complex, but can occur for other reasons. This patch fixes the problem
by forcing a reset of the PHB if we get an error back from firmware when doing
the IODA reset.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1d6406a..53982f8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3943,9 +3943,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
 	 * transactions from previous kernel. The ppc_pci_reset_phbs
-	 * kernel parameter will force this reset too.
+	 * kernel parameter will force this reset too. Additionally,
+	 * if the IODA reset above failed then use a bigger hammer.
+	 * This can happen if we get a PHB fatal error in very early
+	 * boot.
 	 */
-	if (is_kdump_kernel() || pci_reset_phbs) {
+	if (is_kdump_kernel() || pci_reset_phbs || rc) {
 		pr_info("  Issue PHB reset ...\n");
 		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
 		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
-- 
2.9.4

