Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE81606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTyqk4YBJz2y2T;
	Wed, 18 Nov 2026 21:43:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794998594;
	cv=none; b=kvrCWuZNgzA8/6B7QbJOrXneTebL2C7dNPahxote2eigk+4tX9MGT3W4rgaJs4ojnyA1iWN/6lP37egbg+gyoIPY2XIeEK7xP2wACwXNn3fyui/DFwRlWPq7Pj2XDgVpJAu+rXu6+0UI+yqrsqKpWpruvVAWZhtX5bGf6jMQVYX/ZVq1CiaF9HhIRSS1TxOmPe7dGFp4ohn7DL4bf3gGo2r5kFGPrgM970Jb7gvpXmJlPCTDLirRpntFwQH2xFvAoE0M32UlySZFI4Oij0CXQChOGBnKa310KZFKaOtW/QZTSsiLn7k5iP/FAEFYPOC9j76/AbfPq0B5s1ieNpNcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794998594; c=relaxed/relaxed;
	bh=LqclN7WFt5LvJVhfyvx/2gcR4Wbr6X3khlrklqjfyoc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=XJj63e+iCDSIimdlWLxDhMmCZ7tyFv+PpxesGqWCPa/ENq7dnXzBJ/x4G3TZaP8kfkXyFBpS5DAATFpQddiMglfFS1KK532qHyvoUP2/pyIqVPRviAJkLOzkrwxJ1HbdtH8kBdMJlReRfWY1XRNcrtNrp4dTmz2fZAcrc1fETlbA47v5hbpIfK7F9hplw5y0nFuQh0GjJTelgDL+Z8eKUUv9VIt34c669BC4FRXZas13gow70uRrJXLjSwuFsDmlXcVmhNsS02z+0mDZsFPmAf/LM3mI14TT7VT2/rHj3d49MwhMcZn49ObtC/+fGYRGhGeZVQtbj6DiuFCp5x4CEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTyqk05rcz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:43:14 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id D75BC25CB;
	Wed, 18 Nov 2026 11:43:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B12306000333; Wed, 18 Nov 2026 11:43:07 +0100 (CET)
Message-ID: <58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:02 +0100
Subject: [PATCH v2 2/7] PCI/DPC: Reinstate support for AER-incapable ports
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

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
ownership") seemingly inadvertently constrained DPC to AER-supporting
Downstream Ports by inserting a call to pcie_aer_is_native() in
dpc_probe(), which implicitly checks for presence of an AER capability.

Drop the call.  It is superfluous because it duplicates the conditions
applied by the PCIe port service driver when it decides whether to
instantiate a DPC port service (see get_port_device_capability()).
If the conditions are not met, no port service is instantiated and
dpc_probe() isn't executed.

The only difference between the conditions in dpc_probe() and the ones in
get_port_device_capability() is the check for the AER capability, so by
removing the checks from dpc_probe(), DPC is supported on AER-incapable
Downstream Ports again.

Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org # v5.8+
---
 drivers/pci/pcie/dpc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index d02cbbbe3143..a0880e3cd68c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -496,9 +496,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
-- 
2.53.0


