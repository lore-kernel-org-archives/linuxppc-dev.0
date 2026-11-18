Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046CD606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:51:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTz184zWGz2y2T;
	Wed, 18 Nov 2026 21:51:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999084;
	cv=none; b=PoI/RiiyEF98HEr6R/spSaAm9x264Dqu39/ANLZX3CfEql2/oA0nnLmQHMpu6t0kbChSrt7wHZiJvHZFGs0MHzdUIC0NZ8ZE+TaM556wTzTjCj/UVNC9FPD/MF7OzHGHX5DWC7j40I8NZFXD5SSqITXVWi2AfEhGuistX7AxRixqv69NqEU6iY6/wPn3MKdD80uUt4xkkXLAmvBUVOQedbRhVPKMDjHIyWFVR5pnBpwcoX9qrA4oN4K4mBIGYhKo9zoXh96wIawvSrmslfEtscjkjIWC5Fo2JzbSHAyLMhY1fOxiTUOo7x8LowVpYPu20Tzk4EDMtxZcTbkZ8zyoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999084; c=relaxed/relaxed;
	bh=pbcgXBgPca1t8250FLukur4Z8to4BVGD6thMY1PQV8Q=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=BznxV933xgYfvvrpGNzDN4tbkGMUDYP4N3ONyIkAPbXG8EzebWXUcupZ7MIpLFCp6cbuBGdYqK5bMJwTLM3UhHNO4xftvCTkzDfARvoEPUrc3QTe5YR8YjliTgzCyjbTgOnXScoBZzb7VUX4MppWI5s1N0ROG6MaksLpij5zOSVPziv5b1eWMOAUaRAPbeEo1qFm6f+PIxESGvHt2Ux2VOw2bSFvWY4dt+8rLQhGGaNXHdPhw9pP0IXcR9CK+rRGch81Dr45REjrZlO5y1oTqr1hgwrd3jBZvc8g65G6fnEpnnSKe6NkTg60BYzBIcuiw6YJYBiLc/eqfGwcJEgCFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTz173Yhrz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:51:23 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 85CD81231;
	Wed, 18 Nov 2026 11:51:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 69DF06000333; Wed, 18 Nov 2026 11:51:20 +0100 (CET)
Message-ID: <2d0191cb7b92da82302f9d37b859e28ee6c9c85e.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:04 +0100
Subject: [PATCH v2 4/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
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

From: Yury Murashka <yurypm@arista.com>

pcie_do_recovery() only clears the error status bits of an error-reporting
device if recovery succeeds, but not if it fails.  (E.g. because reset
failed, drivers are missing pci_error_handlers or those handlers failed.)

One undesirable consequence is that the AER driver may subsequently
identify a wrong device when searching for error-reporting devices in
is_error_source(), due to stale bits on an unaffected device.

Avoid by clearing error status bits on recovery failure.

If recovery succeeds, Fatal Errors are generally cleared by a call to
pci_restore_state() from drivers' ->slot_reset() callbacks.  If recovery
fails, those callbacks may not have been invoked or they may not be
implemented.  Hence clear Fatal Errors as well on recovery failure.

Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
Signed-off-by: Yury Murashka <yurypm@arista.com>
[lukas: drop cmdline param, rewrite commit msg, clear fatal errors]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
  * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
 
 drivers/pci/pcie/err.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 24a8a8263c2e..a450146fb285 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -289,6 +289,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	return status;
 
 failed:
+	if (host->native_aer) {
+		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+					   PCI_EXP_DEVSTA_UNC_MASK);
+		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
 	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
-- 
2.53.0


