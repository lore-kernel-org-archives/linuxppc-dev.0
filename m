Return-Path: <linuxppc-dev+bounces-24797-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3837EC531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6CS04RL6z2yLY;
	Sat, 25 Jul 2026 02:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784908944;
	cv=none; b=eHCWz+TfVjI3p+OHPf2VkBoCFrwGRPpeiV+XI9KtwBlUTP91MRwxXrufdd6rKm1tPgVqu3mMlxS0Yz02yfno4YqFrFAwPzTv41qbIV/frp3WFHqHBfU4brEzz05sv9UqscrKb/zpNJJso+AADTv05Jt2cVsqQw1X6NEgycwpYZqPkrlOxHycay3WuuoUoB4aOpjJH+p10yKBs1VypB96iNISft/Zm28n55BIn6SIr6k34P+xwhp1AShhRngtG9uQn8cjzNWJVe30L/tMbD2Zf6DO+20SOp9lAzPpNmrbxqfr4jbBrHSIQ/8woO03ezygsuuvW/NayP/zIJf9AlZJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784908944; c=relaxed/relaxed;
	bh=xrTaNwEePMfL7vSlVEKHdGZkrLmQaLQJT5QF2W2l8Ck=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=irXA2zZpEwNRY6qqUU7MvicrigRtjnfs3mVdKYiQoiZ111W3CIR3yV1WFG4O4jnjOl1+BO53S8Q0x1k8HrzPu6hJ5hSc2Z9ML0aCMJYt/xYj7Vv7pnm/lJDOUT/Jha5VbfYIOoQzwzjLEY1Z+BJVGOzUMy/QqbnTjzK3uYEyyII3h3I4mI5uDKzNZ0HQRq3+4Cle4Cn43Dl4Os6GJf94fORqpHcqX8YxKNf7cpSLF1Qf41qUNB0X1mZNiz6P+uVwmY9pinH2d5zRTHvAzvShcgPqXizbKLunSMN0oj8iYptqGu1Jb6kOip/yEBU54SV+W9TIsHoCni75I6wrsHZDLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6CRz4Yy0z2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 02:02:23 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 8BBF535E;
	Fri, 24 Jul 2026 18:02:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A3C760CF04D; Fri, 24 Jul 2026 18:02:20 +0200 (CEST)
Message-ID: <0f2f037c7ccf099f0c253cbc4ad9be526c68c5af.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:05 +0200
Subject: [PATCH 5/6] PCI/AER: Move retrieval of FEP and TLP Log into helper
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
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

When aer_get_device_error_info() gathers information on Uncorrectable
Errors from a device, it reads the First Error Pointer and TLP Prefix/
Header Log and caches them in struct aer_err_info.

Those two fields will also need to be read for Advisory Non-Fatal Errors
(which are signaled as Correctable Errors).  Move their retrieval into a
new aer_get_uncor_info() helper for reuse by the imminent Advisory
Non-Fatal Error support.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4d1d99662086..c196c94f43d7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1289,6 +1289,27 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
 
+static void aer_get_uncor_info(struct pci_dev *dev, struct aer_err_info *info,
+			       u32 status)
+{
+	u16 aer = dev->aer_cap;
+	u32 aercc;
+
+	/* Get First Error Pointer */
+	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
+	info->first_error = PCI_ERR_CAP_FEP(aercc);
+
+	/* Get TLP Prefix/Header Log */
+	if (tlp_header_logged(status, aercc)) {
+		info->tlp_header_valid = 1;
+		pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
+				  aer + PCI_ERR_PREFIX_LOG,
+				  aer_tlp_log_len(dev, aercc),
+				  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
+				  &info->tlp);
+	}
+}
+
 /**
  * aer_get_device_error_info - read error status from dev and store it to info
  * @info: pointer to structure to store the error record
@@ -1302,7 +1323,6 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 {
 	struct pci_dev *dev;
 	int type, aer;
-	u32 aercc;
 
 	if (i >= AER_MAX_MULTI_ERR_DEVICES)
 		return 0;
@@ -1340,18 +1360,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 		if (!(info->status & ~info->mask))
 			return 0;
 
-		/* Get First Error Pointer */
-		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
-		info->first_error = PCI_ERR_CAP_FEP(aercc);
-
-		if (tlp_header_logged(info->status & ~info->mask, aercc)) {
-			info->tlp_header_valid = 1;
-			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
-					  aer + PCI_ERR_PREFIX_LOG,
-					  aer_tlp_log_len(dev, aercc),
-					  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
-					  &info->tlp);
-		}
+		aer_get_uncor_info(dev, info, info->status & ~info->mask);
 	}
 
 	return 1;
-- 
2.53.0


