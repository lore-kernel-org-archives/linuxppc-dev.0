Return-Path: <linuxppc-dev+bounces-24796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38322C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:53:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6CFW5kkhz2yYf;
	Sat, 25 Jul 2026 01:53:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784908399;
	cv=none; b=gRe6dlLxbQBjcH61Fmw6DSqW84jRBqkqJlH1bZqdHxkpmum3sYLPc05IUKwCGKvErCvWD/ZCLXTeiCxiuMFmO1RdI00Hmld46auIPb6czEQWa3l4syb/ejTv0ZRVMODagJxgoL5uNc45jI79N3cM6FzsLUfwPzxXUAn5Y7+Q6JmwURf4C2SGixc0KNLcg/ag5tXpknsO9RkwJ6tFdobkj8cxrfdKhWEsyM2+c3yPpdFRS1i0OQgqPpaj3523Uy4cQ8RoNkuT03Fdm8QqC/628QrVwYdw/ZNwflEmF4COcjyYUIaShVWJ0vNRTqIVR+eIGqZwE1K4qO4QMNM7J7LGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784908399; c=relaxed/relaxed;
	bh=r/FC9BEIy9R6DGefw/Y+/mAduHhc6GyCnCTsmGyRcAo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Z1Dwqo6F9izauIqCq9LR+cRkkwiJDifTPGcTQXENDxk6j24yWRynfLyeNs7pp2nJpT0QLQ2KJBZUap7Q1Kx9lYA8UJJOfUyPfphzSlACmYf/ZcKDFXmheoRJsr2ztW6BxUqKeuZOOBMcHJgmsx0qGRxMX7vG6uYa5J5p4LpOXnCFYM4gaTPSDPmqvTQbklwKR3ZGtMd3/btV1E3cTIbtzeu9y0wWq1fKudw0Cc9gpBuzJ5xKM08c3nWI83vgVlDvNnZqLExs1ZACJPlUgVQfY7hSFpZC1hM2qebyJ6hiO+nqTXKHiJlraplXx3ydd7Oy3J2DYCKhtzozdso6/k04aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6CFW0m02z2yFg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:53:19 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id CFF8C10DCC;
	Fri, 24 Jul 2026 17:53:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BBC4560CF04D; Fri, 24 Jul 2026 17:53:12 +0200 (CEST)
Message-ID: <2e712b96ba5bfc729d78bfc23f7fb7d285aa3d6d.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:04 +0200
Subject: [PATCH 4/6] PCI/AER: Emit TLP Log only for unmasked errors
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

Per PCIe r7.0 sec 6.2.5, the prefix and header of an offending TLP is only
recorded for unmasked Uncorrectable Errors.  Yet when the AER driver
determines whether a prefix and header has been logged, it does not take
the Uncorrectable Error Mask Register into account.  Fix it.

Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.19+
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c21139b9079b..4d1d99662086 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -954,7 +954,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		info.level = KERN_ERR;
-		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
+		tlp_header_valid = tlp_header_logged(status & ~mask,
+						     aer->cap_control);
 	}
 
 	info.status = status;
@@ -1343,7 +1344,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
 		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
-		if (tlp_header_logged(info->status, aercc)) {
+		if (tlp_header_logged(info->status & ~info->mask, aercc)) {
 			info->tlp_header_valid = 1;
 			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
 					  aer + PCI_ERR_PREFIX_LOG,
-- 
2.53.0


