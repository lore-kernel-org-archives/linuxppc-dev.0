Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1A606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:53:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTz305X56z2y8p;
	Wed, 18 Nov 2026 21:53:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999180;
	cv=none; b=FptmXSXDOLx+Igb+d03YY/G+DPOuyMKGwLiJCfcz5h4M65bXRXoPdh+miierU6N/NHlVfMsiI+WAMlEreDcaAsvJrB0z+nO8s+ZyfvF4XbysP2rwHqQ3g93aXEOPtogVHC8TZ0ijas/ZntVFmWqzdDAgn22ICOsyZH2Dkb+sN1MdvVwdAeYCH81PLhQisrT6jhnHCjU5lnm1ix0Xmeoq47zyoX99WJ3aAfAoTtXKqSjLO9AkVG29JJkn8fbS3jaZhdQXFgH040ab3bCFk9/Zem/ffOBil0733yUT7gPIji+KO1Fn/x2bSzo63FSuPHAJC9dOfvGzEF3vaFYnoToS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999180; c=relaxed/relaxed;
	bh=xFd4QcaJAILIr1wan3gcR+j7Yhd7/dWnbfc57Nzs0UQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Bkfs1sWCcFxUuvInqdl1ctWjMguRw/Wz85QbfTMfHSdo2ttBvdW0cghVhYRlGzgmowK6eumuAuPpox6RUHRUjy16NS61Xd5epMfGOiFlHApFzIEAOl2NUICsLBD0wbtbALiLeEcCsb+1OzfarR26wzjbSa8LTsuXb6UfxG8fofVuG7rjjuB6fl/uQ370QPffNyp8aRsIrU/K+M1Km9hy0TW2DcBKadgegi5hQoOVWXo26Yb4pZcZa7eRe0tsBbC4fBNm0TiEGI5DoDsbnQM1QOoumic+PZn2BlIAumUnSsQcmqIgxeVzOSAXaITF/zSSdGNhJvluE89a3ZpHiK0kVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTz300r7qz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:53:00 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 3F15235CF;
	Wed, 18 Nov 2026 11:52:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B4C06000333; Wed, 18 Nov 2026 11:52:57 +0100 (CET)
Message-ID: <c16f4a8b76745b03f3e90d6056c5ba6d092c947d.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:05 +0100
Subject: [PATCH v2 5/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
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

Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().

The call is superfluous because the function is only called from:

  aer_probe()
    cxl_rch_enable_rcec()
      handles_cxl_errors()

...and aer_probe() is only invoked if an AER port service was instantiated
in get_port_device_capability(), which is conditional on:

  (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
  pci_aer_available() &&
  dev->aer_cap && (pcie_ports_native || host->native_aer))

...and the last line of those conditions is equivalent to
pcie_aer_is_native().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer_cxl_rch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index b480dad8bbf4..dfcedb7d277d 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
-- 
2.53.0


