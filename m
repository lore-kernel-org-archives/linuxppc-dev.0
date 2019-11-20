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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA317C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:56:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B83822409
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 02:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChIaVNmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B83822409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HnQL1sVFzDqgx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChIaVNmm"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HlWg6rJ6zDqfc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 12:30:55 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id e17so5111576pgd.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 17:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xB7H8aAE0/pj0pYyU2ZT6KJuHPFhuvF1Dc0LT2YbyVo=;
 b=ChIaVNmmYiv/bW3h5nUf1J0hrnmmFoE8OMOXJsQiru9cnrfE7awWm9H6GPITPg4RnA
 kBcWO3DOqQPW2cEpmp1kqt4BxaxccRkKrhWfd3GhotH8UrODjDzN57Le9qJ5hDVQ6fsC
 Q8RWRcocm6CRV68rI9wuoaIJyLWfsDZF1DsjbY3l8fQHrg/rHnP71dPkN/8BUCNr34iX
 E7qiGpP/VG7uonnr9i7tqy7P3XGGQAmRmgUURW7bsyq+9F+yKky3L7tb5NdyuFY35zJm
 GlQ4Fv2GXhuXGQkyh0/pLYDzNqgTHQeb6vJZ28qFxhD6pHUeCo5cT+QsjlnTDcNs+GKk
 VgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xB7H8aAE0/pj0pYyU2ZT6KJuHPFhuvF1Dc0LT2YbyVo=;
 b=OlhlBJSLzhQo+ulPdOhbJ7YMdq/f/l3GgtIJF+Ftjc5Jj68SNYWnp7jbvbjJQxZwRH
 E5KtpEBg5HTFY5lIjzb0tSpGXlqe2hJrkaTd8aWCajeonvTeAOupPpl+7UYrg10tpEQ9
 JAwNMHd5+VZzbyxccZcKlAezxedD5J6DPP2JEqnHhFytkEwnNGvwbDXvyTpwoeVfxwzu
 li3GC0JPViqnNM/YUuAZu4z9zFxzr79D54R49LYX8jAVTbasNMhOlefdsCeT14U0r/si
 zRduWDFcPFMiQTA7DNHR8cDw8UFnA81EHZrBcxPEVmnP+yRNOMgQClaHF6qPYSvE/xcT
 rH2w==
X-Gm-Message-State: APjAAAWM50rg/RAMju/8MPn4CzGSVlH+oWhbCFSVw52Zu/C4S+0DSmey
 M0qXDfNaxqZUGCPQVlfT4rc//j/C
X-Google-Smtp-Source: APXvYqzD+uXawALDltcj3IvXWRHkCZYJJwNRBzl7Eep7eRfYpEQv2KsnjJrKLe5Ck01l6M6A5Oxvjg==
X-Received: by 2002:a65:424a:: with SMTP id d10mr196254pgq.122.1574213453770; 
 Tue, 19 Nov 2019 17:30:53 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id b24sm26662116pfi.148.2019.11.19.17.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 17:30:53 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [Very RFC 43/46] powernv/pci: Do not set pdn->pe_number for NPU/CAPI
 devices
Date: Wed, 20 Nov 2019 12:28:56 +1100
Message-Id: <20191120012859.23300-44-oohall@gmail.com>
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

The only thing we need the pdn for in this function is setting the pe_number
field, which we don't use anymore. Fix the weird refcounting behaviour while
we're here.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Either Fred, or Reza also fixed this in some patch lately and that'll probably get
merged before this one does.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++++--------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 45d940730c30..2a9201306543 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1066,16 +1066,13 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
 	struct pnv_phb *phb = pci_bus_to_pnvhb(dev->bus);
-	struct pci_dn *pdn = pci_get_pdn(dev);
-	struct pnv_ioda_pe *pe;
+	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
 
-	if (!pdn) {
-		pr_err("%s: Device tree node not associated properly\n",
-			   pci_name(dev));
+	/* Already has a PE assigned? huh? */
+	if (pe) {
+		WARN_ON(1);
 		return NULL;
 	}
-	if (pdn->pe_number != IODA_INVALID_PE)
-		return NULL;
 
 	pe = pnv_ioda_alloc_pe(phb);
 	if (!pe) {
@@ -1084,29 +1081,25 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 		return NULL;
 	}
 
-	/* NOTE: We get only one ref to the pci_dev for the pdn, not for the
-	 * pointer in the PE data structure, both should be destroyed at the
-	 * same time. However, this needs to be looked at more closely again
-	 * once we actually start removing things (Hotplug, SR-IOV, ...)
+	/*
+	 * NB: We **do not** hold a pci_dev ref for pe->pdev.
 	 *
-	 * At some point we want to remove the PDN completely anyways
+	 * The pci_dev's release function cleans up the ioda_pe state, so:
+	 *  a) We can't take a ref otherwise the release function is never called
+	 *  b) The pe->pdev pointer will always point to valid pci_dev (or NULL)
 	 */
-	pci_dev_get(dev);
-	pdn->pe_number = pe->pe_number;
 	pe->flags = PNV_IODA_PE_DEV;
 	pe->pdev = dev;
 	pe->pbus = NULL;
 	pe->mve_number = -1;
-	pe->rid = dev->bus->number << 8 | pdn->devfn;
+	pe->rid = dev->bus->number << 8 | dev->devfn;
 
 	pe_info(pe, "Associated device to PE\n");
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
 		pnv_ioda_free_pe(pe);
-		pdn->pe_number = IODA_INVALID_PE;
 		pe->pdev = NULL;
-		pci_dev_put(dev);
 		return NULL;
 	}
 
-- 
2.21.0

