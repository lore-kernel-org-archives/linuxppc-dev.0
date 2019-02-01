Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 00:43:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D2320B1F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 00:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzrP2UPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D2320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rJJ622RhzDqdd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 11:43:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qzrP2UPe"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rJGK4gT0zDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 11:42:17 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id 101so2280774pld.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+SMMq+TllxuViJZw+u/PIKD+ZAPhynoSbuBQYuRGymo=;
 b=qzrP2UPe6jzcQCJUZcoekv+SCs5LiVOV0kswH17jEht47xFXWeDtc05rUnAaQtrE5p
 0Bq/mUCYlXqOO18BjumVzvKh8KSqcDXI+TRs60VbDXBM9hhgxW6hM+wAvJ62SMoEYOA3
 k/HXNHu3Sq1LzNbNwCGRycAAeG2Alo8OsedZSc2q0yNcBGOoPZpYwfllXl3eNmYm1tJd
 GKG0evVSLug72QgWqk3YqtDDvr6XV6ILCWrFTCDinFDvSzbvYkfN7qlnayNjs/JrAJE3
 yPon/atsHIEwBtfjflLm9ct2g279X4/jxoOr2ZVID4KEV7a10BV//dg45aFNHdf3zwCa
 OC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+SMMq+TllxuViJZw+u/PIKD+ZAPhynoSbuBQYuRGymo=;
 b=td1fmm2xbrKUSetcIKZIM2Rl89O1bE+sOUZogqvpL9r8DSCkwQzTc2708xZR8mRle7
 0V/V+YQYt8kzbKtXQqZYgp6o/kXq25eWezQ1d9Os0VwKCMBJF5cdrZHPEAWQxZ/7NA7o
 M0JTouwYthKA6V7rXq3RMblyk6gVFYZ5ZZkWmVl4Vgi8caHtU4HY9nwTV/tloEU3tvi1
 2eq6lYm4mObl5vY8yEvBAo2/i6CtjVSX7dTrHA0FH+uOzgM0fl+wX4OEnfDp9szk2Y3z
 socsN+fuD8Po5axm1aGQ6/rFjEZzY4lTjBeF9eu3mIvRqkNwduLp3bvg65OgZXjuh5RD
 OtWw==
X-Gm-Message-State: AJcUukdYivWGnsRqpW6SQqhdSryVUvEn//UUnCO5wRIR6CqOXt6cyIgc
 PB+MTQ8WvWjExNhBtT645jiTgcRb
X-Google-Smtp-Source: ALg8bN4/eyEwUXNKkV1BQPcl1BDRBnVTFCbaswVXKbE3p4oBBRCkYX7b1afjuMt+iVYgs1KRNtN6UA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr35887603pls.322.1548981734542; 
 Thu, 31 Jan 2019 16:42:14 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h134sm10602471pfe.27.2019.01.31.16.42.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 16:42:13 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Escalate reset when IODA reset fails
Date: Fri,  1 Feb 2019 11:42:01 +1100
Message-Id: <20190201004201.6512-1-oohall@gmail.com>
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

The IODA reset is used to flush out any OS controlled state from the PHB.
This reset can fail if a PHB fatal error has occurred in early boot,
probably due to a because of a bad device. We already do a fundemental
reset of the device in some cases, so this patch just adds a test to force
a full reset if firmware reports an error when performing the IODA reset.

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

