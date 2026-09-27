Return-Path: <linuxppc-dev+bounces-28334-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED227C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:05:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htC6V4cfdz2yMn;
	Mon, 28 Sep 2026 04:05:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790532354;
	cv=none; b=DzAc+7+dWkOjPvEpUnwLvQKqV94lvTIEIkS1WOAERMz5vRiB1R+Rv1ZmhN9wdhronp/Sm8x3qb9M/2OP4no4an4ctpwYuYBwXKLh1925G1PghjXr+sHYg1LanBo1Sj/4j1vvVXaM4e2LLJnjkv4vdkp4xB5RT1Og/xINNC9wWyTmQ9LDQeaj1kLrh3QxnArwUa3/uzhnLWA+LRhAyMq0eI9nXsqIkAAn2owH6zj7XauiahkVFhmafonEX3j6I0AjBnncujAYxkFceZ9pGiA1/OtbhA9VyIaxpSwHCNHGdistlSUN/QGrRMphCMmxlbv6SMa9V119Lqoi3B13xS0OVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790532354; c=relaxed/relaxed;
	bh=KCcEhqXeUVxSlC9Hujql3hvKNzICczjMuXtM8vnDkwI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=VfAo9OwwDwxOGUVmQmZjer+P51bvYXaw55Ea7P6NmmeDcps0ci8WldDezdbmMHJG2eUsiGvMWKlseXVA+2Fz2PdEIw/4ygewtgPpgLUERDbGEcoGQEGTjbjenkIXbfjoBGzrQhsmWK5xhPQRlVetPsMSQKsrnNO6/V1AXE2RwQHVztn2gYT7UV5mGLJZSmKS7Y2kLiFyLzhq3egmMboKmFHAOaYtUrrTrQUhP91NRYgczBfEJb/rnfzaO7jORkgmT23p5KUyuPPTaB/ds4RqyHvWCwc+4h8qZuE8UBxhMVhI58PJc6ydjJEAOLtRrAQrVobqtmZ+bGVY9kZrt6jrrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:4f8:fff3:b8::104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 217 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 04:05:52 AEST
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htC6S5Lmfz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:05:52 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 3417D1D05;
	Sun, 27 Sep 2026 20:05:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DD4DA6078B58; Sun, 27 Sep 2026 20:05:48 +0200 (CEST)
Message-ID: <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:01 +0200
Subject: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER capability
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

Downstream Port Containment does not mandate presence of an Advanced Error
Reporting capability, so a Downstream Port may support DPC, but not AER
(PCIe r7.1 sec 6.2.11.2).

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
parsing for AER ownership") fixed it by inserting a call to
pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
of an AER capability.

However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override the check:  The DPC driver may access a non-existent
AER capability if "pcie_ports=dpc-native" is passed on the command line.

Fix it by making the DPC driver cope with AER-unsupporting Downstream
Ports.

There are two places where the AER capability is accessed:

- dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
  Non-Fatal Error triggered DPC.  Access the Device Status Register
  instead, in accordance with PCIe r7.1 sec 6.2.5.

- dpc_is_surprise_removal() uses it to detect whether a Surprise Down
  Error triggered DPC.  Return false on AER-unsupporting devices.  The
  function works around an AMD-specific quirk and it seems reasonable to
  assume that all affected products are AER-supporting.  In any case the
  detection is not possible without AER capability.

Insert a temporary check for an AER capability after the call to
aer_get_device_error_info() because the function currently returns false
for AER-unsupporting devices.  The check will become obsolete and will be
removed with the imminent baseline capability error reporting.

Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.5+
---
 drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..793a799053f1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 					  struct aer_err_info *info)
 {
-	int pos = dev->aer_cap;
-	u32 status, mask, sev;
+	u16 devsta;
 
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
-	status &= ~mask;
-	if (!status)
-		return 0;
-
-	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
-	status &= sev;
-	if (status)
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+	if (devsta & PCI_EXP_DEVSTA_FED)
 		info->severity = AER_FATAL;
-	else
+	else if (devsta & PCI_EXP_DEVSTA_NFED)
 		info->severity = AER_NONFATAL;
+	else
+		return 0;
 
 	info->level = KERN_ERR;
 
@@ -275,7 +269,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +347,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 	if (!pdev->is_hotplug_bridge)
 		return false;
 
+	if (!pdev->aer_cap)
+		return false;
+
 	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
 				 &status))
 		return false;
-- 
2.53.0


