Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5EC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 07:29:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E310A20714
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 07:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAtaviGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBRtF0GfZzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:29:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=rAtaviGr; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBRB40jZbzDqv3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 16:58:03 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id g67so690824pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2020 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gYLUIQDudARZS2ppTMcFMprGe8T6RymlErRvYcS+NhM=;
 b=rAtaviGrOwMolVVqU1D9XlB3v5933VsKhh6lA01jOHALnx9XbAufHJq3ivE3y0T9ry
 diqefzccaVT01S822Casoo984eYUzpgIlza+sEGxhmoJyzCdeE/C6dMShWkkeTTAtZOd
 Xf/sSo3EKMPwoubZImsRmWLbHZ9ZzpbRSKgvS4S+WPM1HYjhKKDbFizh/LXUdY8fL7Yl
 hGT4Pf5sU3VEJK297YAx4CwedTuBKeMBmoP40agmO+EHwL4TPBe4+lvktEpctuwofiic
 zBL2/n3eHKcjdedIQxXqZDCMhaoJxFKi8QEngip2Qea4La7G7E1gi6XQL0CJoro9zSaw
 hEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gYLUIQDudARZS2ppTMcFMprGe8T6RymlErRvYcS+NhM=;
 b=AUb6dFxSCOQvi4InREZqaHZ6wNa8hDYEBiCd9eiycLw3GjdFkh3LYSiDwd2mEUTJNg
 cKUCqAOdIpvYNKDtEy0f2aWAAzcA+3TXlbbITuHyPnt2rILE0qejy95wdLoPPilKNpV3
 HALREOxRU1wqUraqiFa+58mUvTtyo5Q1SUKi166Q+bm94VWlRdem0l77V8AR1DdnoiYX
 8VsDiJ9lde4JSNzsQDJj9dBa1QuspBZEUeeJdcVliyUcK9mkzzZf5RKzmxYyJhmVfXXr
 zitDDr/bRfBUrjC0iC8VpbJXRH0RqinabNXIFB3rVRf+8++4V99383+enH1XX2dlBlja
 y+tw==
X-Gm-Message-State: AOAM533q+P+OA2kUte5Da71PePiuaACWFAq3eu6SpwOL6PNncXJxFm8O
 yA66AzfvFAoMCxh7KGE9jzidAk9AbPk=
X-Google-Smtp-Source: ABdhPJz4EZ9W24c91caTpH3hTXw0j8Y/W7l7VIpKj13z656hPDgZSwpl3lGHWOkN/B23y2E8XXYa3w==
X-Received: by 2002:a62:1d90:: with SMTP id
 d138mr27972281pfd.159.1595401081093; 
 Tue, 21 Jul 2020 23:58:01 -0700 (PDT)
Received: from localhost.ibm.com (203-219-159-24.tpgi.com.au. [203.219.159.24])
 by smtp.gmail.com with ESMTPSA id c14sm22645104pfj.82.2020.07.21.23.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 23:58:00 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/16] powerpc/powernv/sriov: Remove vfs_expanded
Date: Wed, 22 Jul 2020 16:57:15 +1000
Message-Id: <20200722065715.1432738-16-oohall@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722065715.1432738-1-oohall@gmail.com>
References: <20200722065715.1432738-1-oohall@gmail.com>
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

Previously iov->vfs_expanded was used for two purposes.

1) To work out how much we need to multiple the per-VF BAR size to figure
   out the total space required for the IOV BAR.

2) To indicate that IOV is not usable with this device (vfs_expanded == 0).

We don't really need the field for either since the multiple in 1) is
always the number PEs supported by the PHB. Similarly, we don't really need
it in 2) either since the IOV data field will be NULL if we can't use IOV
with the device.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v2: New
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 9 +++------
 arch/powerpc/platforms/powernv/pci.h       | 3 ---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 76215d01405b..5742215b4093 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -213,8 +213,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		iov->need_shift = true;
 	}
 
-	iov->vfs_expanded = mul;
-
 	return;
 
 disable_iov:
@@ -256,6 +254,7 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 						      int resno)
 {
+	struct pnv_phb *phb = pci_bus_to_pnvhb(pdev->bus);
 	struct pnv_iov_data *iov = pnv_iov_get(pdev);
 	resource_size_t align;
 
@@ -267,8 +266,6 @@ resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 	 */
 	if (!iov)
 		return align;
-	if (!iov->vfs_expanded)
-		return align;
 
 	align = pci_iov_resource_size(pdev, resno);
 
@@ -290,7 +287,7 @@ resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
 	 * If the M64 BAR is in Single PE mode, return the VF BAR size or
 	 * M64 segment size if IOV BAR size is less.
 	 */
-	return iov->vfs_expanded * align;
+	return phb->ioda.total_pe_num * align;
 }
 
 static int pnv_pci_vf_release_m64(struct pci_dev *pdev, u16 num_vfs)
@@ -708,7 +705,7 @@ static int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		return -ENXIO;
 	}
 
-	if (!iov->vfs_expanded) {
+	if (!iov) {
 		dev_info(&pdev->dev, "don't support this SRIOV device"
 			" with non 64bit-prefetchable IOV BAR\n");
 		return -ENOSPC;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 902e928c7c22..c8cc152bdf52 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -234,9 +234,6 @@ void pnv_ioda_free_pe(struct pnv_ioda_pe *pe);
  * and this structure is used to keep track of it all.
  */
 struct pnv_iov_data {
-	/* number of VFs IOV BAR expanded. FIXME: rename this to something less bad */
-	u16     vfs_expanded;
-
 	/* number of VFs enabled */
 	u16     num_vfs;
 
-- 
2.26.2

