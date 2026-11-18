Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A5606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:57:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTz802YkQz2yGT;
	Wed, 18 Nov 2026 21:57:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794999440;
	cv=none; b=jDlp9jj70rIPJ9TE80DgmvDS36JOBQ1GeAjzZIpSkZu/Bpx55Sv02/XCT0dTaVxapp0TNyptNPn8mmrjXN3bC1t6bJqs5iRyx37+8JjPUuzW5Wp2zqVQ7PcTExs4T+t84G5PAzt0YNgu9UEPpMwj82N3l9DTxYZsUbkXiGbE13WY0dwpBktyHx+KKVvHYG/vZhBcq0I6R5/T+WYHYUqgdgNIY0AXFoNEmZHECqP2i7NtnWOJLPgGBp3Rs/Er/4nAcmCuSLUzno+Xpd/IGBaEaB8LiX+muZ+6h4STnpJsFRi6P2QqMSri5QnIiFfEp3XrhfpazL8LgwhVixB53RS2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794999440; c=relaxed/relaxed;
	bh=4FnyvVJpJuPd07n97XxriYL9x6n85FTrcjI+tsMhtOE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=aMUuD/U2N58w46hG7eiyqi6NDEkhs61ABAtk0KWskAQQSKP3x95SxZ0SsDNH/mbY8OFwUpyXA5KymC6ZgMMFQYNlqHrRyb/ekm5GFOaS/zbJgn+0VQsbwbvVFsy7aAxrntvgalH5zpyzF3l2Um4kpWoDpA34cXvGBBUwC5SXabdZTLi00VXvtb6txi7PLKDReZfsy4dLtiYcP29Fip5BSFpfKNQfCRg5xKO8w/XAZjECUCffZ8yY7mE8gI2VVPeba3svk7eh5qJCZlpV1n36jWs3ZrlguVpkOr4EleFZMSn7lrA5KmCNl1qv6t9R5ziUbUxaF7fEbq9e7WONoGJk8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTz7z1Jppz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:57:19 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 98DC435D1;
	Wed, 18 Nov 2026 11:57:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 853776000333; Wed, 18 Nov 2026 11:57:15 +0100 (CET)
Message-ID: <40e4bd7f25b37af1bdc48a13be140bdd8e7d81ab.1794997749.git.lukas@wunner.de>
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 18 Nov 2026 11:40:07 +0100
Subject: [PATCH v2 7/7] PCI/AER: Enable baseline capability error reporting
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

PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:  Baseline
capability and Advanced Error Reporting Extended Capability (AER).

So far the kernel only supports the AER paradigm.  Enable the baseline
capability paradigm to complete the kernel's support for error reporting.

Baseline capability (solely) relies on the error enable/status bits in the
Device Control and Device Status registers, which exist on every PCIe
device.  One difference between baseline capability and AER is that the
severity of Uncorrectable Errors cannot be controlled.  Another difference
is that Advisory Non-Fatal Errors are not reported at all (PCIe r7.1 sec
6.2.5).

But the main difference to AER is that no detailed error information is
available:  It is only known that an error occurred and which severity it
had, but not its type or the Prefix / Header of the TLP that caused it.
An exception are Unsupported Request Errors which are signaled with a
dedicated bit in the Device Status register.  Report these as if the
Unsupported Request Error Status bit in the Uncorrectable Error Status
register was set, for consistency with the AER paradigm.

Error recovery works the same for baseline capability as it already does
for AER:  Drivers are informed about errors through the pci_error_handlers
callbacks.  Recovery from Fatal Errors (and from Non-Fatal Errors, if
chosen by drivers) is attempted through a Secondary Bus Reset.

Similarly to commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
AER is native"), which universally enabled error reporting on AER-capable
devices, the present commit is invasive because it universally enables
error reporting on AER-incapable devices.  Previously those errors were
neither reported nor recovered.  It may be necessary to amend more drivers
with pci_error_handlers callbacks to recover from newly reported errors.

Baseline capability is only enabled if firmware grants AER control to the
operating system.  Otherwise firmware owns the error enable/status bits in
the Device Control and Device Status registers (PCI Firmware r3.3 table
4-6 bit 3).

Baseline capability support is initially only implemented for native error
handling, not Firmware First error handling:  ghes_handle_aer() would have
to be amended to pass the Device Control and Device Status registers to
aer_recover_queue(), and to only pass an AER capability structure if it is
present in the CPER record.  It's not clear whether any firmware actually
generates such CPER records and whether implementing support for it is
worthwhile, so postpone that for now.

Devices without AER-capable Root Ports or DPC-capable Downstream Ports in
their ancestry may cause System Errors if the corresponding bits in the
Root Control register have been set by platform firmware or the user.
Previously this could only occur with AER-capable devices.  The present
commit extends it to AER-incapable devices.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
  * Convert AER severity to Device Status bit with new severity2devsta[]
    array, instead of renumbering AER severity (sashiko).
  * On entry of aer_get_device_error_info(), clear info->mask and
    info->first_error (Sathya, sashiko).
  * Emit "(no details available)" message for AER-incapable devices
    as well as for devices whose AER registers are deliberately not
    read on Fatal Errors (Sathya).
  * Amend commit message to inform that System Errors may be raised
    by AER-incapable devices if they have no AER- or DPC-capable
    port in their ancestry (Sathya).
 
 .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 ++++++----
 Documentation/PCI/pcieaer-howto.rst           |  9 ++--
 drivers/pci/pcie/aer.c                        | 47 ++++++++++++-------
 drivers/pci/pcie/dpc.c                        |  2 +-
 4 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
index 5ed284523956..9e772e1ed9b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
@@ -1,9 +1,9 @@
 PCIe Device AER statistics
 --------------------------
 
-These attributes show up under all the devices that are AER capable. These
+These attributes show up under all PCIe devices (AER capable or not). These
 statistical counters indicate the errors "as seen/reported by the device".
-Note that this may mean that if an endpoint is causing problems, the AER
+Note that this may mean that if an endpoint is causing problems, the error
 counters may increment at its link partner (e.g. root port) because the
 errors may be "seen" / reported by the link partner and not the
 problematic endpoint itself (which may report all counters as 0 as it never
@@ -17,7 +17,10 @@ Description:	List of correctable errors seen and reported by this
 		PCI device using ERR_COR. Note that since multiple errors may
 		be reported using a single ERR_COR message, thus
 		TOTAL_ERR_COR at the end of the file may not match the actual
-		total of all the errors in the file. Sample output::
+		total of all the errors in the file.
+		For PCIe devices without AER Extended Capability, only the
+		total counter is meaningful while all other counters remain 0.
+		Sample output::
 
 		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
 		    Receiver Error 2
@@ -38,7 +41,10 @@ Description:	List of uncorrectable fatal errors seen and reported by this
 		PCI device using ERR_FATAL. Note that since multiple errors may
 		be reported using a single ERR_FATAL message, thus
 		TOTAL_ERR_FATAL at the end of the file may not match the actual
-		total of all the errors in the file. Sample output::
+		total of all the errors in the file.
+		For PCIe devices without AER Extended Capability, only the
+		total counter is meaningful while all other counters remain 0.
+		Sample output::
 
 		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
 		    Undefined 0
@@ -68,7 +74,11 @@ Description:	List of uncorrectable nonfatal errors seen and reported by this
 		PCI device using ERR_NONFATAL. Note that since multiple errors
 		may be reported using a single ERR_FATAL message, thus
 		TOTAL_ERR_NONFATAL at the end of the file may not match the
-		actual total of all the errors in the file. Sample output::
+		actual total of all the errors in the file.
+		For PCIe devices without AER Extended Capability, only the
+		total counter and the Unsupported Request counter is meaningful
+		while all other counters remain 0.
+		Sample output::
 
 		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
 		    Undefined 0
@@ -121,7 +131,7 @@ Description:	Total number of ERR_NONFATAL messages reported to rootport.
 PCIe AER ratelimits
 -------------------
 
-These attributes show up under all the devices that are AER capable.
+These attributes show up under all PCIe devices (AER capable or not).
 They represent configurable ratelimits of logs per error type.
 
 See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
@@ -130,7 +140,7 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER correctable error log ratelimiting.
+Description:	Writing 0 disables Correctable Error log ratelimiting.
 		Writing a positive value sets the ratelimit interval in ms.
 		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
 
@@ -147,7 +157,7 @@ What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
 Date:		May 2025
 KernelVersion:	6.16.0
 Contact:	linux-pci@vger.kernel.org
-Description:	Writing 0 disables AER non-fatal uncorrectable error log
+Description:	Writing 0 disables Non-Fatal Uncorrectable Error log
 		ratelimiting. Writing a positive value sets the ratelimit
 		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
 		(5000 ms).
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 90fdfddd3ae5..e969e563b61d 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -34,9 +34,8 @@ set of error reporting requirements. Advanced Error Reporting
 capability is implemented with a PCIe Advanced Error Reporting
 extended capability structure providing more robust error reporting.
 
-The PCIe AER driver provides the infrastructure to support PCIe Advanced
-Error Reporting capability. The PCIe AER driver provides three basic
-functions:
+The PCIe AER driver provides the infrastructure to support both paradigms.
+It provides three basic functions:
 
   - Gathers the comprehensive error information if errors occurred.
   - Reports error to the users.
@@ -69,7 +68,7 @@ Specification for details regarding _OSC usage.
 AER error output
 ----------------
 
-When a PCIe AER error is captured, an error message will be output to
+When a PCIe error is captured, an error message will be output to
 console. If it's a correctable error, it is output as a warning message.
 Otherwise, it is printed as an error. So users could choose different
 log level to filter out correctable error messages.
@@ -113,7 +112,7 @@ See Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
 AER Statistics / Counters
 -------------------------
 
-When PCIe AER errors are captured, the counters / statistics are also exposed
+When PCIe errors are captured, the counters / statistics are also exposed
 in the form of sysfs attributes which are documented at
 Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9bb8e2127849..3c28afca5d03 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -403,21 +403,22 @@ void pci_aer_init(struct pci_dev *dev)
 {
 	int n;
 
-	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	if (!dev->aer_cap)
+	if (!pci_is_pcie(dev))
 		return;
 
 	dev->aer_info = kzalloc_obj(*dev->aer_info);
-	if (!dev->aer_info) {
-		dev->aer_cap = 0;
+	if (!dev->aer_info)
 		return;
-	}
 
 	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
 			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
 
+	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!dev->aer_cap)
+		goto enable;
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -438,6 +439,9 @@ void pci_aer_init(struct pci_dev *dev)
 					       PCI_ERR_COR_ADV_NFAT, 0);
 
 	pci_aer_clear_status(dev);
+enable:
+	if (pcie_aer_is_native(dev))
+		pcie_clear_device_status(dev);
 
 	if (pci_aer_available())
 		pci_enable_pcie_error_reporting(dev);
@@ -988,14 +992,12 @@ void aer_print_error(struct aer_err_info *info, int i)
 	if (!info->ratelimit_print[i])
 		goto anfe;
 
-	if (!info->status) {
-		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
-			bus_type, aer_error_severity_string[info->severity]);
-		return;
-	}
+	aer_printk(level, dev, "%s Bus Error: severity=%s%s\n",
+		   bus_type, aer_error_severity_string[info->severity],
+		   info->status ? "" : " (no details available)");
 
-	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
-		   bus_type, aer_error_severity_string[info->severity]);
+	if (!info->status)
+		return;
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
@@ -1204,8 +1206,11 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	if (!(reg16 & PCI_EXP_AER_FLAGS))
 		return false;
 
-	if (!aer)
-		return false;
+	if (!aer) {
+		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
+		return reg16 & severity2devsta[e_info->severity] &&
+		       !PCI_POSSIBLE_ERROR(reg16);
+	}
 
 	/* Check if error is recorded */
 	if (e_info->severity == AER_CORRECTABLE) {
@@ -1521,6 +1526,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 {
 	struct pci_dev *dev;
 	int type, aer;
+	u16 devsta;
 
 	if (i >= AER_MAX_MULTI_ERR_DEVICES)
 		return 0;
@@ -1531,13 +1537,22 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 
 	/* Must reset in this function */
 	info->status = 0;
+	info->mask = 0;
 	info->anfe_status = 0;
+	info->first_error = 0;
 	info->tlp_header_valid = 0;
 	info->is_cxl = pcie_is_cxl(dev);
 
 	/* The device might not support AER */
-	if (!aer)
-		return 0;
+	if (!aer) {
+		if (info->severity != AER_CORRECTABLE) {
+			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+			if (devsta & PCI_EXP_DEVSTA_URD &&
+			    !PCI_POSSIBLE_ERROR(devsta))
+				info->status = PCI_ERR_UNC_UNSUP;
+		}
+		return 1;
+	}
 
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a0880e3cd68c..bf5295fe1f4f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -291,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
+		    aer_get_device_error_info(&info, 0)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
-- 
2.53.0


