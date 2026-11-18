Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F142606A325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTz5F2L1Gz2yDr;
	Wed, 18 Nov 2026 21:54:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999297;
	cv=none; b=jNChyJCCgTw1NBigECANkRlBe2ZaKHvLILR/qutgiCHNRVWYiwM5RuXMwdzjd5lYEbdJAvs2p7Q7OeUO5FLe8wZr0F0EBtNSOQSmk6ylChnFZI2KyFrUQObrW3FP2PKZniFLWa/LV7WDTf3kCZTDrD8U1WxlG2EgYecxQaH0oPIMrY6Z1kX+YBIA0FXvN6pjuorZI0TmKb9NNX8c/OY+o7ajCj30FenGg+hE8W6urZAAJzWyMFb5ALi5QsbLF5fbIK75czirPWoqcjLsYz7pf7DTq7YzbpySlJP46d6aDOtr5ub/TywqYWN1y041HONelF16veiSqjzehKcajVsfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999297; c=relaxed/relaxed;
	bh=MU5tVZLUEvK9QUdrpLV2yQsfNmaL2MNnbAVNzb9N48o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=JvduOQ6K2mgFkndtWg/f/8Dp5Y9jdmaA5VzRWm60AW2D45aPfu9mQUSdq6sOsNLxM+vkY9ETa7uiTucEjHvatgyy13ut/s9YlT5vnQC59FQey9aWK+I1codVnDMwP7tpftUmmyjS2HFA7nutAOvez2QORrUC773Rz1JWu3S/bIxISJQGsNq9W4pElvhM4qXXs9zz08BF/lq7zJ7UgO8vVY07xAsrHFLobjwxMDm55Vbi7yKsTW0g4FhMzQl+R5//rBPJd40dLhjuq19WmcqvDYD2FTBRMNKlzjtzg8L/5/JUs+7N5q0cZhDb6gRi62awHKbT67AS2mhVSCNUYtZf4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 705 seconds by postgrey-1.37 at boromir; Wed, 18 Nov 2026 21:54:56 AEDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTz5D1lsrz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:54:56 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 38C124154;
	Wed, 18 Nov 2026 11:54:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 138026000333; Wed, 18 Nov 2026 11:54:53 +0100 (CET)
Message-ID: <df17268a88d7099c34098e5c3670a493801e9c59.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:06 +0100
Subject: [PATCH v2 6/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

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
Changes v1 -> v2:
  * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).
 
 drivers/pci/pcie/aer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 51cf2ff8c85a..9bb8e2127849 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -263,9 +263,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	if (!dev->aer_cap)
-		return 0;
-
 	return host->native_aer;
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
@@ -286,7 +283,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -305,7 +302,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
-	if (!pcie_aer_is_native(dev))
+	if (!aer || !pcie_aer_is_native(dev))
 		return;
 
 	/* Clear status bits for ERR_FATAL errors only */
@@ -1288,7 +1285,7 @@ static bool find_source_device(struct pci_dev *parent,
  * Mask registers.
  *
  * Note: AER must be enabled and supported by the device which must be
- * checked in advance, e.g. with pcie_aer_is_native().
+ * checked in advance, e.g. with dev->aer_cap && pcie_aer_is_native(dev).
  */
 void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 {
-- 
2.53.0


