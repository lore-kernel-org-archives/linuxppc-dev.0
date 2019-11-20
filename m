Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE1C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:58:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0012222409
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kud3+/eD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0012222409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HnSF4gtgzDqg6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 13:58:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kud3+/eD"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HlWk1rQwzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 12:30:58 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id e6so4500676pgi.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0Bl8NAc5dtNyiODAyNVwL0lIIRdSHEpCC/70N0ShIcE=;
 b=Kud3+/eDBt+V7CVav9bZL8OgxdBqEpTV7iNQa9nbiVdPeZa8wIPwNJJQa/Iv76n08E
 DMDYD74eTLVbI9bAabTXmBooJAXP/fTjRuMOYWFFOB0AJ2Z5AjSQW3ekqCknfxy0jWRz
 Bmoa4415SOWkQ9sznF0y0UCI8QKWjHzvx3azQk18Id2j6X4T4uUrfzN5N3YsMq/0kaZE
 RUHxMZ0JB946/vaob4psHLkCVxfbVkvD1g4prrgKOAV2avg4efQIhMUGQWK9IEOT6qog
 4Y9ifWe1xxDJNqXoyrdh3HFm+0DWlUb/0b7KKjLCq8mlp89qb0i3rIBu6ktCytxnv6Xs
 fxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0Bl8NAc5dtNyiODAyNVwL0lIIRdSHEpCC/70N0ShIcE=;
 b=dAS8qjxV75H45oDYCaWLzoe8/QbFrPMG1ut+WL0BPocQWyawnlB4MeS63eODqpq6Y6
 XkuibvT+m+IITpNxxpOmX1JVUz6IYoodVjjShhwYRCQ/mYxJ9WpPMxfZuvZXJk/UJTrf
 xAzqIox9SaJ+m9j4aE3Gw+MmAPUBtFqUGfuQ50lZFrD3xUJasi26MD1PeYk5cRrBoFP2
 Ibn+VWB0I/N+xmTW+9PtKctg40IHbBmpeMJyK3dv8GtPvzCc4eDsmayuFytx5CljbRfI
 uVegS0dTdyJ2p+pPiW/RofLqqQlh6/rzWRRH9fO9+mc5lBRyD+nUP7LauFNfcywAhYPG
 fPZg==
X-Gm-Message-State: APjAAAV9oA1lkpTzM/bhxG7R8CcdvL1LInpUiQCaQb4smQjMUuORO2/h
 FlOyHlyKozFffcyO9tQpJkM3/Sp0
X-Google-Smtp-Source: APXvYqzRMdhllVUJe9HlcSPCe+gZT1C/0MUlCp3e//CVDJbTd7xs1FtPHVCC1SdvVWWF3+FzAUYVIw==
X-Received: by 2002:a65:6249:: with SMTP id q9mr190461pgv.340.1574213456098;
 Tue, 19 Nov 2019 17:30:56 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b24sm26662116pfi.148.2019.11.19.17.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 17:30:55 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Very RFC 44/46] powerpc/pci: Don't set pdn->pe_number when applying
 the weird P8 NVLink PE hack
Date: Wed, 20 Nov 2019 12:28:57 +1100
Message-Id: <20191120012859.23300-45-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120012859.23300-1-oohall@gmail.com>
References: <20191120012859.23300-1-oohall@gmail.com>
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
Cc: alistair@popple.id.au, Oliver O'Halloran <oohall@gmail.com>,
 s.miroshnichenko@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

P8 needs to shove four GPUs into three PEs for $reasons. Remove the
pdn->pe_assignment done there since we just use the pe_rmap[] now.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2a9201306543..eceff27357e5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1183,7 +1183,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
 	long rid;
 	struct pnv_ioda_pe *pe;
 	struct pci_dev *gpu_pdev;
-	struct pci_dn *npu_pdn;
 	struct pnv_phb *phb = pci_bus_to_pnvhb(npu_pdev->bus);
 
 	/*
@@ -1210,9 +1209,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
 			dev_info(&npu_pdev->dev,
 				"Associating to existing PE %x\n", pe_num);
 			pci_dev_get(npu_pdev);
-			npu_pdn = pci_get_pdn(npu_pdev);
-			rid = npu_pdev->bus->number << 8 | npu_pdn->devfn;
-			npu_pdn->pe_number = pe_num;
+
+			rid = npu_pdev->bus->number << 8 | npu_pdev->devfn;
 			phb->ioda.pe_rmap[rid] = pe->pe_number;
 
 			/* Map the PE to this link */
-- 
2.21.0

