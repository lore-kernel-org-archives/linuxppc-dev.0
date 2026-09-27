Return-Path: <linuxppc-dev+bounces-28339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F0C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htCMb2R4Tz2yMn;
	Mon, 28 Sep 2026 04:17:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533035;
	cv=none; b=JOPAQ5CRLNMvoOCcMuad5EeEUqoBPZTeGLYzNRrWttXoEnyaD7UocNI2nnxjOFZ1rnIoXo33gclWD6cqEVm9aYaE+FKpezyKmMJZzrvIVcRU3rA+T4pna03Bv1ye/XMMRmmmgGz6lqgpEWmmZrTigIi/26HIYiETqG2fn206OyS3q/TSsFTm8DeNjpD/3//mmUUvr9ggUrNGdEtAfc7ouhGExYQX+EObUe9O1ug6iBp0GiSzfNAn00hfHf0cbZ9kSnaG44rrvVmzzhlAsdwhwAjRkViyjCBUlKzkShYjSxJc6o3v8aBqYuo/45yRRu6tgF5KfNBp6pBQKSmMMPM1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533035; c=relaxed/relaxed;
	bh=MlEtNSXMwdu7++Z9fX9PCV3yeiVSS6ajfcx2TCzHQUM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=kxGJ6LTgobqCc5zlbAhFWr+9B0giNpz4uS72jERc5ID34vU1hux1saNBCLEbp0x66yVM+kr6RAtuNwZv+4pQN06J6ie4lmPizKtRYo+0KmTtlMwU89yJ3weLij4AHyhnb/60LPgiVnXTdJN8jPOESosA5+Oqv3u864wWBNKm7EdrqgjmOvEJGFL1S4XEKMOWOesml4w7ivvquTISGmQaCsFj14V099BVOIyOa/6QeB69EVHLOCsJlvwn0+k7/DCFhJD9tVATzox3LbpijMjCgHzTSrTrqVmuPy6QP7lwV/WCYG8P9G824PSW067S6uG/2U7z1y1PPHCCo2Ik/YA69g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCMZ31gLz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:17:14 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 03E09709F;
	Sun, 27 Sep 2026 20:17:11 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DE15F625294D; Sun, 27 Sep 2026 20:17:10 +0200 (CEST)
Message-ID: <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:05 +0200
Subject: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
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

When firmware grants control of Advanced Error Reporting to the operating
system, that not only encompasses the AER capability, but also error
enable/status bits in the Device Control and Device Status registers
(PCI Firmware r3.3 table 4-6 bit 3).

PCIe devices without AER capability still support baseline capability
error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
but the bits must not be modified unless AER control was granted.

pcie_aer_is_native() is unsuitable to check for control of AER-incapable
devices because it implicitly checks for presence of an AER capability.

Move that check to its callers (where needed) to allow using the function
for the imminent baseline capability error reporting.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..34a8eddc427a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -257,9 +257,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	if (!dev->aer_cap)
-		return 0;
-
 	return pcie_ports_native || host->native_aer;
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
@@ -280,7 +277,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -299,7 +296,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return;
 
 	/* Clear status bits for ERR_FATAL errors only */
-- 
2.53.0


