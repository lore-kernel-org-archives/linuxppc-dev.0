Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0561606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTypQ32jGz2yMn;
	Wed, 18 Nov 2026 21:42:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794998526;
	cv=none; b=OevH+cTlDAuIHUferlgOS62aH26/Gr9N0F/66cO21lSoHC9rYMeBJhnhBqO2klp8bgAOA4c9PplNI/a8cbk3IHcwSl9YwMtIRrt+iw2uyHAY1b4qTxRSA+lbnIjC3GKH8u7CfeoseIG042t1uI+4EfGr9CzAngwsaMVzj1NNtqPIt/Lb+FgX+XbQnLd8WbYMYuZI/s8PfFs0E6qEDbPjTRVszCKWDBTx4Q0s5WvN18US0rqnowCCF03F4MkBovGZsf/v16sMs4NLsDfPy9LiQeuAb9OWwu7mMfK+BIkYD8+mlXzExmjshf3Q4laUiuP2tRKSHH0/d4q/5fpm7BRSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794998526; c=relaxed/relaxed;
	bh=7ULs6kFe6nCSS6/2neQFMZlz5nGwnDgQN00Y1eoPHhQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=CUPsRkIkXzFoaztHgOWvwA+KSCulVwiC83Hrj+imokmvE3t4uYAadEES2c48oSx6f2chcrLaYSQFa2i0u17VAsbCnO3YUnVm+c/ON2UlUBj8zpf55tTsoAZ66GQXheQbBpAUIQQ6igq9vdWfTVUgzrn0WQyXguBSI1t0xO6/I1lZ6l4amEACwR9RyYbex73N/cuMjWMxQdyRYd9Z5O7IbZkUECuJWWMUFy0HsZN+DWseEgEY3ZdjXuavBQTR724l8HVDry81MGfh8lxNO/agGdIsbvGoFrGMkCsW8fMSRv5sIFqvNinQSShsO4OQmdXVV7svhhGxrK7ZVgtG185KRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTypP4xc0z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:42:05 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 745661C64;
	Wed, 18 Nov 2026 11:42:00 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3A5C06000333; Wed, 18 Nov 2026 11:42:00 +0100 (CET)
Message-ID: <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:01 +0100
Subject: [PATCH v2 1/7] PCI/DPC: Avoid access to non-existent AER capability
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

In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
DPC event handling") amended the DPC driver to access the AER capability
without checking for its presence.

This did not cause actual problems because in March 2018, commit
4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
the BIOS") had seemingly inadvertently prevented instantiation of a DPC
port service on AER-incapable ports.

However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control") made it
possible to override this:  The DPC driver may access a non-existent AER
capability if "pcie_ports=dpc-native" is passed on the command line.

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
Changes v1 -> v2:
  * On AER-capable devices, infer severity from AER Extended Capability
    instead of Device Status register because the latter also logs masked
    errors (Sathya).
  * Fix storytelling in commit message because 4e5fad429bd1 changed
    behavior, not 708b20003624 (Sathya).
 
 drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..d02cbbbe3143 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -238,19 +238,35 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 {
 	int pos = dev->aer_cap;
 	u32 status, mask, sev;
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
-		info->severity = AER_FATAL;
-	else
-		info->severity = AER_NONFATAL;
+	/*
+	 * Infer severity from AER Extended Capability if present, else from
+	 * Device Status register.  The latter cannot be used on AER-capable
+	 * ports because it also logs masked errors (PCIe r7.1 sec 7.5.3.5).
+	 */
+	if (pos) {
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
+		status &= ~mask;
+		if (!status)
+			return 0;
+
+		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
+		status &= sev;
+		if (status)
+			info->severity = AER_FATAL;
+		else
+			info->severity = AER_NONFATAL;
+	} else {
+		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+		if (devsta & PCI_EXP_DEVSTA_FED)
+			info->severity = AER_FATAL;
+		else if (devsta & PCI_EXP_DEVSTA_NFED)
+			info->severity = AER_NONFATAL;
+		else
+			return 0;
+	}
 
 	info->level = KERN_ERR;
 
@@ -275,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
@@ -353,6 +369,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
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


