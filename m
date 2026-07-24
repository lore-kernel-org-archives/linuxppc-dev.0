Return-Path: <linuxppc-dev+bounces-24794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04726C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6C5H3DMSz2ybR;
	Sat, 25 Jul 2026 01:46:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784907971;
	cv=none; b=TR36LgeWM/+P6Z1pLN9ZJoG7fSO0JIAEXK4y44pQUJcLN4KE1ET1CeU+Vuzzbtgl/v64l0Lwzso6FQ2ZLMDXe4SAl6TRosAwXpCFTkxNfI5NQET1/Ff2KO1k7cdw5NsOqY/aiuXjegumSCbqS3byWSYv8esGY88LM0hACbB3JBIeC17CcIRoZkDfVGHzvPDSB/VaqHu9dtIGwJsj37QKLNBiLjxvnSei00rwRsAszGtXELFE6wtin+BxRlB44MSbTvXHwqepEyzX5A36AiO/wm2jytSE0bb74zDRYmRfNnbxtaCMyZh57OjxboHesK3x4TByoe/w9MRQzVXAe2qEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784907971; c=relaxed/relaxed;
	bh=JMRc8E1XHiFMbxT78w04MoNBF9TKDq3cThWyTgp7boY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=joHR9j65100SBTgtCFM0qTuUC5bxG/+Kgpi/KzVSljUkCrXik+N14OkvJyesUOBYAlVErvQTy5HULESPcelFhq/Lx4KP93uhdwb3L1fkaWxes7tiejtG0Fw/FqSWudZ+Mrnbr0/t4yGAS0bYzRcM/EQQB9hWjGf0FLOpSMkKY7Z73wqGEszCQQgF1/W+VM2FZZdSkuD1kldT7WHMogQHDhXZRb4kouLSyQPn+zwQ3LIVaOQqCCCc/1Czjq5n9Cy7Nu7M30CGct7mBoqhRpdQ7ut/LVC/3Yirl+WVGg6aItxqpVF5gMPxSDbaEdlQdCfPW5vsxHyDffwkPn8PTNZoTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6C5G5ddTz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:46:10 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 4443935E;
	Fri, 24 Jul 2026 17:46:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3381D60CF04D; Fri, 24 Jul 2026 17:46:04 +0200 (CEST)
Message-ID: <3a5d1624d6912db1bc8c4e89e7a6a72ac510f4dc.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:03 +0200
Subject: [PATCH 3/6] PCI/AER: Deduplicate logging of Error Source
 Identification
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

aer_print_source() already logs the Error Source Identification Register:

  AER: Multiple Correctable error message received from 0000:b7:02.0

However aer_print_error() subsequently identifies the Error Source once
more by emitting an "Error of this Agent is reported first" message.

The additional message was introduced by commit 0d465f23502e ("PCI: pcie,
aer: fix report of multiple errors") because it deemed the message emitted
by aer_print_source() confusing:  When the Multiple ERR_COR Received or
Multiple ERR_FATAL/NONFATAL Received bit in the Root Error Status Register
is set, it doesn't mean that all errors originated from the device in the
Error Source Identification Register.  Rather, the errors may have come
from multiple distinct devices.  The commit sought to make that clearer.

Achieve the commit's objective by rephrasing the message emitted by
aer_print_source() and drop the additional message logged by
aer_print_error() to reduce dmesg noisiness and simplify the code.

While modifying the log message anyway, fix minor grammatical issues:
Append a plural "s" to "message", add a missing closing brace to "(no
details found" and capitalize "Error" to match the spec.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9cdac1c8c52e..c21139b9079b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -875,12 +875,13 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 {
 	u16 source = info->id;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
+	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
+		 info->multi_error_valid ? "s received, first one" : " received",
 		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
 		 PCI_SLOT(source), PCI_FUNC(source),
-		 found ? "" : " (no details found");
+		 found ? "" : " (no details found)");
 }
 
 void aer_print_error(struct aer_err_info *info, int i)
@@ -888,13 +889,11 @@ void aer_print_error(struct aer_err_info *info, int i)
 	struct pci_dev *dev;
 	const char *level = info->level;
 	const char *bus_type = aer_err_bus(info);
-	int id;
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
 
 	dev = info->dev[i];
-	id = pci_dev_id(dev);
 
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
@@ -906,7 +905,7 @@ void aer_print_error(struct aer_err_info *info, int i)
 	if (!info->status) {
 		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
 			bus_type, aer_error_severity_string[info->severity]);
-		goto out;
+		return;
 	}
 
 	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
@@ -919,10 +918,6 @@ void aer_print_error(struct aer_err_info *info, int i)
 
 	if (info->tlp_header_valid)
 		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
-
-out:
-	if (info->id && info->error_dev_num > 1 && info->id == id)
-		pci_err(dev, "  Error of this Agent is reported first\n");
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-- 
2.53.0


