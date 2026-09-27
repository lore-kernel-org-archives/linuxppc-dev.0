Return-Path: <linuxppc-dev+bounces-28337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB3C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:11:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htCFS4DJLz2ydN;
	Mon, 28 Sep 2026 04:11:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790532716;
	cv=none; b=aFMQ+vDYBAj5qtno88B7J9LMr+vYErVisO1VSWf9t6cZ7GAN/XTyNZxFn1oX7u6nWLTi4fzSdB+SH1H+noIEnfLsqOv3ej6svJamDcCeHniYgacXLfiHVn3w8rmA2xh6X7Ir7qfzKtElPmnbzECbFz7Mug6XpRIJIFZSY3Ui2Rlyw4GV/PJvtPdr/LTuIGQpEJNR+zsvQAb4ddrD8Xg/PSbP3Os8uD3Pjv4YVSh4za723CO8CCfCHA7TwFqaBckg0Jf67Cw/LIVVSs26iWBqVPZYMShZuQrk66wE+SvpYxu0cs5VFraBa/xnVzuo4SiD6YyWXqr94pSCeuXyX1zAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790532716; c=relaxed/relaxed;
	bh=zC7Xehq809TaFuAfdSBJ2cn1CqGM+uzSKUoB2zetqjg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=N3Zw/aseR+nKs965A28ansG/iRZswYn6QfHIYZ0AggFGNg7IeFu6UH26kZ/lVyiOYrEU88evaXZLhuVPgQ5TpVVftd/mbWpSif4QGz/Dgv2cEzTiSKLyvk3FUp/8ypCfunOFA9+btjkLzk4ezX+ufLlWQzTgtvgTmga/AFU5ilqMGFCOyZ3+6ljvqV3UWzaiZrUQ0XppwgU5yFSRUd6kNlNswEtoFpJc9IeIGnJB4qpeTSzfLMLEAIdw1CKriS0zio5RmdrdmRFh5mgeYcCqSDTwZwP0xMhZjnjVJYfn1zBJCwaoRgDkRJ8B0ONxfnb0kfDF4ejrJ+zTrzpZRgWjIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCFR4fmwz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:11:55 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1095670A0;
	Sun, 27 Sep 2026 20:11:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F0AA9625294D; Sun, 27 Sep 2026 20:11:45 +0200 (CEST)
Message-ID: <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:03 +0200
Subject: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
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

From: Yury Murashka <yurypm@arista.com>

pcie_do_recovery() only clears the error status bits of an error-reporting
device if recovery succeeds, but not if it fails.  (E.g. because reset
failed, drivers are missing pci_error_handlers or those handlers failed.)

One undesirable consequence is that the AER driver may subsequently
identify a wrong device when searching for error-reporting devices in
is_error_source(), due to stale bits on an unaffected device.

Avoid by clearing error status bits on recovery failure.

Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
Signed-off-by: Yury Murashka <yurypm@arista.com>
[lukas: drop cmdline param, rewrite commit msg, tag for stable]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/pcie/err.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index d77403d8855b..cfcfc7e4f10d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	return status;
 
 failed:
+	if (host->native_aer || pcie_ports_native) {
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
 	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
-- 
2.53.0


