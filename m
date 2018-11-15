Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A2C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:33:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAC5208A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIcLNF+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAC5208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wyN76DwFzF3QG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:33:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oIcLNF+y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="oIcLNF+y"; 
 dkim-atps=neutral
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wy0m62pNzF3gX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 10:16:24 +1100 (AEDT)
Received: by mail-oi1-x241.google.com with SMTP id t3-v6so395069oie.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/PmV1hM4vrJlqJyO21xijvwrR0pYLkAAA5QXEtDSQMk=;
 b=oIcLNF+yYQ013z44r1tNgoJwxIhR3FmZvqn62c/4aCbaIc0Z3aUWvLWj93DzAuHTwa
 gq0DrCk+lFgcGJQrDL3/BWwvLwhnJr154/FCj1Z5b5Tb6WlgVgXzczj8Vf/mtWLwXj46
 TnzRY0a6KXM26AYLwqkd4P7QAVAeXBw5d3X+UjdmI+X5ZCUiaQvtE0iKImfVYTdFKRe4
 bF30KDK0uPyPcuFN3JfKCixfspFpAuY8JyFzXGqFLrdFwO5ZxuRMms2f0scLXgwwUQ8P
 gbUX/LYpUaXDZ62W1CY3jIvy4S1sdcsYw8t8g9Qu6cgk/K+CEvx7q1JAD3h4r+Dzivpv
 ls2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/PmV1hM4vrJlqJyO21xijvwrR0pYLkAAA5QXEtDSQMk=;
 b=iPIhm3nlS0bkkx2z3juM3Ve4tFrPG1gNVsg1o5kdYT4OvOLcMwwkVx27STO8ELDk8f
 qqjbkJ3irUqHZjU44NHH6pSXFNE9XWhtz6pHboamfR1QG6IJQcKLoj9X9mrtF30wgD+H
 bGczGkyNIUhmjha9fqIbROem9edqyUh083kqvOWtq5i7KbRUDrivKvndt+cjo8xt+edH
 TpRbUC8LfEqk3Mm+6oD5UyAbBz+3yLEsykfYgLaEZpSgM0wVqAtkRa1K47Y4V5vyQoDO
 CHQbheO9Wy8CebI75yeBLBldZhO6qqqe4sDzpHJ8Ij4VNnDoZ1v3z/zgZm76ym3VqNiu
 tnnw==
X-Gm-Message-State: AGRZ1gLw+PdmhRYu5IFSoZQn8bbyTuGyPq9WL+AXpplJP7xpd3TVxPvR
 VZOtK/nadyd1HC1c1YIPkbY=
X-Google-Smtp-Source: AJdET5dEM4LH/60J1XaBaSQP72vzRRSWkD/tk88ONGpgvdu8jH27+iSofBXX7RzMh67AkjhyG65g8g==
X-Received: by 2002:aca:a6c5:: with SMTP id t66mr2568680oij.225.1542323782908; 
 Thu, 15 Nov 2018 15:16:22 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 15 Nov 2018 15:16:22 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: helgaas@google.com
Subject: [PATCH 2/2] PCI/AER: Determine AER ownership based on _OSC instead of
 HEST
Date: Thu, 15 Nov 2018 17:16:03 -0600
Message-Id: <20181115231605.24352-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
X-Mailman-Approved-At: Fri, 16 Nov 2018 10:26:13 +1100
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
 linux-pci@vger.kernel.org, Shyam_Iyer@Dell.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI), however the correct way to determine
AER ownership is the _OSC method.

pci_dev->__aer_firmware_first is used to prevent modification of AER
registers when firmware owns AER. This is synonymous with the AER
ownership negotiated during _OSC. Thus _OSC is the correct way to
use to set this flag, not HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 57 ++----------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac014151b7a6..dd9594e8ed08 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -240,66 +240,13 @@ static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
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
2.17.1

