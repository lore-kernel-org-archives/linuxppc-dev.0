Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44444C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:25:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C4320823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6pmjlt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C4320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TJ1v0zw3zDqDD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 04:25:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6pmjlt8"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44THzg2rWZzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 04:23:59 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id x188so10553823oia.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fiq9HXSF/eDUChK1D39FGIx6tNtbvfiGbda9koLVfWA=;
 b=A6pmjlt81e9rK+llVGSzdBcghOO4EtlGbsJ0l3lWyEpLSAHf/bLKnBU3R3qcdCvHp/
 j2dMyT9ZaHULEC4q3vEvEBigr6tQX3tJH75XM2BHA84lBuuNyF1wHxXw+IzrtRlonufN
 v7dmX6g17fHEUmhU4YBZQX0Chq2l7XAeskeHep+yheFxuJnBniBDJVh/0k/0GQP3KmUG
 RkzwMJpCcLnfIxjgjbqkMm/1druHpS/cGvq7mJtHjglKCy2gQ5ucpIJnhmj9vaOgNP8W
 boLFY8AlKhpelTBMRdE3O8FBDxFqQsZPEN9VYyRhClTEmw+cg+/0HnNcOqxqyoQRGi12
 0gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fiq9HXSF/eDUChK1D39FGIx6tNtbvfiGbda9koLVfWA=;
 b=cEb/GhrORGKXccWnp3Xd+0xeljTrjMUM4kNRoNDLL2otpmGQiEn//LgvNVUYCubWB3
 9boFDTDW4AbAhTbgID6AoQPjVTdXNstfjfssrEVuh87PG6QnSt8Y43LQlWOShUyzJhRO
 5SEvj1py6Z2SZ4JvKq9mIBTPmx1qTObshIwIDvxfz4vehuiDYFWsq7vzdVk7HFkA31BX
 /7kDNwZqXB3+RB8syDUFutV08h+3crjsBb4nm+AI7yEXaRFkO8DVK4DHuC44yp3uOc00
 tpYEWEz5z5ejU+3nsHFAoO7D+yGdAj6/zwfLPg+OGuI7EKjKYq1LNTV/6Zjwu3tB0Hry
 WW/w==
X-Gm-Message-State: APjAAAXIlftXW1/WUFZVbRCVjCPHp0q4NLTiV3SWrIFQjc2iPkuyrRJe
 1vqD4nd2ovtRCC4+dxrmC+U=
X-Google-Smtp-Source: APXvYqzjkiKtK6IggnWjo8r6fNzDaCeM87ogKjs1yliYkxyFn6OQUL5+X/HGcw0UbAXcsZN3NeswYQ==
X-Received: by 2002:aca:4103:: with SMTP id o3mr16554560oia.71.1553621036988; 
 Tue, 26 Mar 2019 10:23:56 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id z12sm3047459otp.2.2019.03.26.10.23.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 10:23:56 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Subject: [PATCH v2 2/2] PCI/AER: Determine AER ownership based on _OSC instead
 of HEST
Date: Tue, 26 Mar 2019 12:23:42 -0500
Message-Id: <20190326172343.28946-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190326172343.28946-1-mr.nuke.me@gmail.com>
References: <20190326172343.28946-1-mr.nuke.me@gmail.com>
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
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shyam_Iyer@Dell.com, okaya@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, keith.busch@intel.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de, leo.duran@amd.com,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, scott.faasse@hpe.com,
 Oliver O'Halloran <oohall@gmail.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI), however the correct way to determine
AER ownership is the _OSC method.

The ACPI spec allows _OSC and HEST to say things that might not make
sense on a specific hardware implementation.
For example _OSC can say "OS has control" on the root bus, while HEST
says "This PCIe device is firmware-first". This is fine when the
platform can differentiate error sources at the root complex. On x86
platforms, AER errors can be routed to either to an MSI vector
(native AER), or to SMM (firmware-first). As this is done at the root
complex level, the example above would not make sense.

Notice that in neither case is it correct to go to HEST to determine
AER ownership. This is the conclusion of a six-months discussion in
the ACPI Software Working Group.

pci_dev->__aer_firmware_first is used to prevent modification of AER
registers when firmware owns AER. This is synonymous with the AER
ownership negotiated during _OSC. Thus _OSC is the correct way to
use to set this flag, not HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 57 ++----------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d029979e61f6..08cee30b3ef3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -237,66 +237,13 @@ static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
 	return false;
 }
 
-struct aer_hest_parse_info {
-	struct pci_dev *pci_dev;
-	int firmware_first;
-};
-
-static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
-{
-	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
-		return 1;
-	return 0;
-}
-
-static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
-{
-	struct aer_hest_parse_info *info = data;
-	struct acpi_hest_aer_common *p;
-	int ff;
-
-	if (!hest_source_is_pcie_aer(hest_hdr))
-		return 0;
-
-	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
-	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
-
-	/*
-	 * If no specific device is supplied, determine whether
-	 * FIRMWARE_FIRST is set for *any* PCIe device.
-	 */
-	if (!info->pci_dev) {
-		info->firmware_first |= ff;
-		return 0;
-	}
 
-	/* Otherwise, check the specific device */
-	if (p->flags & ACPI_HEST_GLOBAL) {
-		if (hest_match_type(hest_hdr, info->pci_dev))
-			info->firmware_first = ff;
-	} else
-		if (hest_match_pci(p, info->pci_dev))
-			info->firmware_first = ff;
-
-	return 0;
-}
 
 static void aer_set_firmware_first(struct pci_dev *pci_dev)
 {
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
+	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
 
-	rc = apei_hest_parse(aer_hest_parse, &info);
-
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
+	pci_dev->__aer_firmware_first = !host->native_aer;
 	pci_dev->__aer_firmware_first_valid = 1;
 }
 
-- 
2.19.2

