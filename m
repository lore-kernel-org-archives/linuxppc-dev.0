Return-Path: <linuxppc-dev+bounces-25885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A122C5DF6A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 13:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMgcC5NXWz2xnp;
	Sat, 15 Aug 2026 23:56:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786802171;
	cv=none; b=AID2SjtcNsvM5U4/u9B2O/vjCLsdsWcd/hXIICTdbA44xu5dM8vguDBz5x23YEOHxPEzTCIEfGOOEdonDKKf2vIA40RwlpW9AM97qN2fSrLbe7RmE72ij6fd//FS93wS2UEFq5CEYp1LQMI6pzYMgrxkLgSTH4NPswjKnV5/agyLMahxWpSNPLy9Biat+CKNeu9DXFbDLlGiWhRREg8tXZo04hunLY5Rg+M/c5vYDyU/DhML81JxoRYsfD/klDukxilBJtNFWOReXctjzaiv+yglSEgROs4RwVo+sqMHWHSNiWwW489GJxP34ZVDfcgN2dKIofJgn6/bKaNp9Fss3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786802171; c=relaxed/relaxed;
	bh=ZjadfM9Qojeka+fBmfhMWSSNy4mHnx5ijRWzXnkKOj4=;
	h=Message-Id:From:Date:Subject:To:Cc; b=bEnVijopcAKAfu9F1Bor7H8S3R0l67uwve2zo35sFJ3rKs5DdPsh0vBhCm7dmok/Yi3p+0VxwNegMOkI9gX0JpATdouomUq0ncgytbRhjWNaKYSbzk86IPlv1vMjmDCJtAkEYjPr9Qwrm+gIeqG/10sSjmFKYDwPRHnOJ04KeTGz2VNFMuRKWvOs3BJoJsm3VsdevNeoidjo90xWE4GoSV8lLBjz32Wg5yG9Yj0zXLn2TgGa5VkTglFF2jUZ1X8ghtdNjKrTyBR0nCeO6ci4v61rxA4HAZNWAiKaRBQSJjenMOdX2EB/204my/QiIiGMGJaYB+9OmP/WPdDsKopbkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 517 seconds by postgrey-1.37 at boromir; Sat, 15 Aug 2026 23:56:09 AEST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMgc92jH5z2xnW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 23:56:09 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 693F1C28;
	Sat, 15 Aug 2026 15:47:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E23F61AD955; Sat, 15 Aug 2026 15:47:10 +0200 (CEST)
Message-Id: <120da0565eac0157ffd913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 15 Aug 2026 15:47:10 +0200
Subject: [PATCH] PCI/AER: Fix ratelimit and log level of Advisory Non-Fatal
 Errors
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list

When Advisory Non-Fatal Errors are reported, the Uncorrectable Error bits
should be reported using the same ratelimit counter and log level as the
accompanying Correctable Error.

This is done correctly when they are handled natively in aer_print_error()
but it is not done correctly when they are handled in Firmware First mode
in pci_print_aer().

Fix it.

Fixes: 21963e6e4e04 ("PCI/AER: Support Advisory Non-Fatal Errors")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
The offending commit is the top-most one on pci/aer (queued for v7.3-rc1).
This fix could either be folded into or applied on top of it.

 drivers/pci/pcie/aer.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2a380bb..dd2aa5d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1028,13 +1028,15 @@ int cper_severity_to_aer(int cper_severity)
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+static void __pci_print_aer(struct pci_dev *dev, int aer_severity,
+			    struct aer_capability_regs *aer,
+			    bool ratelimit_print, const char *level)
 {
 	const char *bus_type, *sev;
 	int tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
+		.level = level,
 		.severity = aer_severity,
 		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
 	};
@@ -1043,12 +1045,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		sev = "cor";
-		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		sev = "uncor";
-		info.level = KERN_ERR;
 		tlp_header_valid = tlp_header_logged(status & ~mask,
 						     aer->cap_control);
 	}
@@ -1067,7 +1067,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	 * For Advisory Non-Fatal Errors, record statistics and tracing
 	 * even if ratelimited
 	 */
-	if (!aer_ratelimit(dev, info.severity))
+	if (!ratelimit_print)
 		goto anfe;
 
 	aer_printk(info.level, dev,
@@ -1094,10 +1094,25 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		if (anfe_status) {
 			aer->uncor_status = anfe_status;
 			aer->uncor_mask = 0;
-			pci_print_aer(dev, AER_NONFATAL, aer);
+			__pci_print_aer(dev, AER_NONFATAL, aer,
+					ratelimit_print, level);
 		}
 	}
 }
+
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
+{
+	/*
+	 * Precalculate ratelimit counter and log level so that Advisory
+	 * Non-Fatal Errors are treated like the accompanying Correctable Error
+	 */
+	bool ratelimit_print = aer_ratelimit(dev, aer_severity);
+	const char *level = aer_severity == AER_CORRECTABLE ? KERN_WARNING
+							    : KERN_ERR;
+
+	__pci_print_aer(dev, aer_severity, aer, ratelimit_print, level);
+}
 EXPORT_SYMBOL_GPL(pci_print_aer);
 
 /**

base-commit: 21963e6e4e0425b12d3128eea5a5104a3bc909c4
-- 
2.53.0


