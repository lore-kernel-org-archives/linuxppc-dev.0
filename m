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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26417C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:34:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B182240D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQaO3P80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B182240D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Hmwm3pcvzDqpJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 13:34:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="NQaO3P80"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HlWB1jNzzDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 12:30:30 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id 193so13324152pfc.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JIqqItZ968DjpNte+4z1cu2655WCfKoBXYByMV613+U=;
 b=NQaO3P801umDScpDzUPkjJQrUN7IsWUHLVJy53MAbI10jhK0f5+5IFElhe/zsvJjno
 JY1yAvtRWFKWMy+CX7Erf9Aba3E7sWNzOO1TR5W46GEEZZ70uK3MVKXQx9/sjV1pk3CG
 pLHW9D8Cytos8FfTRAyFYCiueQwqGruMRRyk9/Ef88SK5FtnIXNh8L0on4f4s6Iplb0S
 2fxosEVYDaNzYq7rVgjm5Dt9uJlflgmGAv6jfHaSnHHUegLUf+wQAIk2VGyTBykz88ce
 VvbzvuLeonVOCfI5VOtMCRwJt1CYUP8gsb6ZGYx0bqm2ZnoR74UeGEkXx79dIEj50W3v
 /HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JIqqItZ968DjpNte+4z1cu2655WCfKoBXYByMV613+U=;
 b=khV1cDGDJcM8TuI8vZz29E+5w9k6ls9E5jaPDITAQx5ufnTyzFSZ1A8buNeQWfTP/2
 yWERZnyeR3roHr7zEl6RlTgI8d1R68lEch5DknnzTezjN+nHtxoOVfdIxV/eMut8uDjG
 sBTfrqN+hxeHlLQq0zB90+Z6FqpM6L84rYit3cIwWHMG4Iey48Cb+Kq14t8w/wCdMFA6
 gQhllkiB34X0LIRfWXdYxMECdSL07OGSCByzs2mwc8jIEhRmU6+F8hBBvrsfw1Lr/a8D
 H6jPAT6E8g9LZJAPeMZcLSuqvo77hNMRDDIcXfkuM5NfdepOJdNkL8TGSr+J45O9TUeW
 PXjg==
X-Gm-Message-State: APjAAAXYU/owmRaYKNDCZzDiCUx/Q7Z6fOG3mRl9V02bzO0Efoa6St3Y
 ybl/hEiLpyH0NetpTi/E2hoOMRzy
X-Google-Smtp-Source: APXvYqyBiMGA+SjHUNz3feITizRS3/kcqKMarWogCA4RFoM8T5lwU7TfJIR8i+EqXI00LWlef/50vA==
X-Received: by 2002:a63:dd58:: with SMTP id g24mr176424pgj.376.1574213427946; 
 Tue, 19 Nov 2019 17:30:27 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b24sm26662116pfi.148.2019.11.19.17.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 17:30:27 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Very RFC 32/46] powernv/pci: Remove open-coded PE lookup in
 iommu_bypass_supported()
Date: Wed, 20 Nov 2019 12:28:45 +1100
Message-Id: <20191120012859.23300-33-oohall@gmail.com>
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

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 98d858999a2d..7e88de18ead6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1801,13 +1801,11 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 		u64 dma_mask)
 {
 	struct pnv_phb *phb = pci_bus_to_pnvhb(pdev->bus);
-	struct pci_dn *pdn = pci_get_pdn(pdev);
-	struct pnv_ioda_pe *pe;
+	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
 
-	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+	if (WARN_ON(!pe))
 		return false;
 
-	pe = &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
 		u64 top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
 		if (dma_mask >= top)
-- 
2.21.0

