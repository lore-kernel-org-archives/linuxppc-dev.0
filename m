Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288FB606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:59:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLlkw4gGTz2xNC;
	Sat, 07 Nov 2026 03:59:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793984344;
	cv=none; b=oKEKrLKjKHr21SLx8YGwtV4zwUu/JyaRujrAX4y7RuEyJ9Pjm78iAxn04zav/qSQwgzsFH0xrX1XejergOHgBfuVaoT3qfvkufrDZhonckFsMxF5LXMumsodeqCMD+/crndoEsbPWfTqjwdPmb3UNrBz0wIzo/PPmRfUovmnFK5YkCKtS2vUdm9xXmd75+0BRjEqehDpVGDN8fjNRra/OP2Kj5gSS2Wkq4EZy2N2PFLbm3UXPHy77mgwN7GXQntHFdwVLeSJg/5X3z7AwYTlGzlCNg1NH2XZhrOG/ZE74+ikOEIIgn57ryS8xn+6fEJCCP7gQiF4Gj7KtUj2pXs9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793984344; c=relaxed/relaxed;
	bh=jwZtwfHrevTvlShMfmV8TYSXo57pKgQIF+OFPwaencc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ElB8F2qYnCO6VcUseMzvTywSQ3spUlt1KxysVOV/RRW1AosOEXlpJZjwPCUGn8fE2mq6ejPCCpyXWJ8Xx+bDgvPwOhZOeqPXFdN6N5dknf+oP+epZfrqY9ajpRpLkh5hWD58EsBVKh04OUsiB1/BYYyF6wS5S7+thRLUxFtJQ+0rjpz8fvBoUlboQnmjGHcUy3JCRPrnA0icWPS3ia0nUSevixk++Plhq9aaPJlNv8JXX9drWvBMxatAiRl2bmiM24TRzt9fNxn/4aiH226ByC+jwHuXvkle8J/7ZZKV9vaRxPiJ2nDtHhI4vB7wcVzv350lnHO2YeYSzU1aPpsWIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLlkv6wbjz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 03:59:03 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id B1A70147C;
	Fri, 06 Nov 2026 17:58:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9D50C602EB8B; Fri,  6 Nov 2026 17:58:56 +0100 (CET)
Message-ID: <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
In-Reply-To: <cover.1793982724.git.lukas@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 6 Nov 2026 17:38:02 +0100
Subject: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID register
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
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

Certain Intel and AMD Root Ports are known to populate the Error Source ID
register with an invalid value.  The AER driver seeks to recognize such
buggy silicon by assuming invalidity if the bus number is zero.  It then
searches for the error-signaling device in the hierarchy below the Root
Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
invalid error source IDs").

Alex has provided dmesg output which shows an invalid Error Source ID with
a non-zero bus number.  The AER driver's heuristic fails to recognize its
invalidity:

  pcieport 0000:00:07.1: AER: Correctable Error message received from 0000:01:00.0 (no details found)

The Root Port at 0000:00:07.1 has secondary bus 04, so an error source on
bus 01 is obviously invalid.  The range of secondary buses is cached and
checking against it is cheap.

Do that instead of relying on a heuristic.  Emit a message when an invalid
Error Source ID is detected to alert silicon validation engineers.

If the Error Source ID is the Root Port itself, assume that it is valid.
This changes behavior if the Error Message originated from a device which
happens to have the same slot and function number as the Root Port and
whose bus number was zeroed in the Error Source ID register.  On affected
Intel and AMD systems, the invalid Error Source ID always has a zero slot
and function number and there is no Root Port at 0000:00:00.0, so it is
expected that this change does not lead to false-negatives in practice.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222095
Tested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes versus v1:
 Reorder a < b && b < c comparisons (Ilpo, Bjorn)
 Amend kernel-doc of find_source_device() (Sathya)
 s/subordinate/secondary/ in commit message (Bjorn)
 Document behavioral change in commit message (sashiko)
 
 drivers/pci/pci.h       |  7 ++++++-
 drivers/pci/pcie/aer.c  | 35 ++++++++++++++++++++++++++---------
 drivers/pci/pcie/rcec.c | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..aa392bb6a482 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -871,6 +871,9 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
  * @id: Value from register PCI_ERR_ROOT_ERR_SRC
  * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
  * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
+ * @id_valid: Whether @id is a valid value.  Some Root Ports report an invalid
+ *	Error Source ID, necessitating a search for the error-signaling device
+ *	in the hierarchy below the Root Port.
  * @multi_error_valid: If multiple errors are reported
  * @first_error: First reported error
  * @__pad2: Padding for alignment
@@ -893,7 +896,8 @@ struct aer_err_info {
 
 	unsigned int severity:2;
 	unsigned int root_ratelimit_print:1;
-	unsigned int __pad1:4;
+	unsigned int __pad1:3;
+	unsigned int id_valid:1;
 	unsigned int multi_error_valid:1;
 
 	unsigned int first_error:5;
@@ -955,6 +959,7 @@ void pcie_link_rcec(struct pci_dev *rcec);
 void pcie_walk_rcec(struct pci_dev *rcec,
 		    int (*cb)(struct pci_dev *, void *),
 		    void *userdata);
+bool pci_rcec_associated(struct pci_dev *rcec, u16 id);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) { }
 static inline void pci_rcec_exit(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d492c7ce01e1..6f2460231422 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -951,12 +951,13 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 {
 	u16 source = info->id;
 
-	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
+	pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s%s\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 info->multi_error_valid ? "s received, first one" : " received",
 		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
 		 PCI_SLOT(source), PCI_FUNC(source),
+		 info->id_valid ? "" : " (invalid source)",
 		 found ? "" : " (no details found)");
 }
 
@@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 	return 0;
 }
 
+static bool source_id_valid(struct pci_dev *root, u16 id)
+{
+	/* The Root Port or RCEC can itself be a valid Error Source */
+	if (pci_dev_id(root) == id)
+		return true;
+
+	/* For RCECs, @id shall be in range of its associated buses/devices */
+	if (pci_pcie_type(root) == PCI_EXP_TYPE_RC_EC)
+		return pci_rcec_associated(root, id);
+
+	/* For Root Ports, @id shall be in range of its subordinate buses */
+	if (!root->subordinate)
+		return false;
+
+	return root->subordinate->busn_res.start <= PCI_BUS_NUM(id) &&
+	       PCI_BUS_NUM(id) <= root->subordinate->busn_res.end;
+}
+
 /**
  * is_error_source - check whether the device is source of reported error
  * @dev: pointer to pci_dev to be checked
@@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	u32 status, mask;
 	u16 reg16;
 
-	/*
-	 * When bus ID is equal to 0, it might be a bad ID
-	 * reported by Root Port.
-	 */
-	if ((PCI_BUS_NUM(e_info->id) != 0) &&
+	/* Some Root Ports report an invalid Error Source ID */
+	if (e_info->id_valid &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
 		if (e_info->id == pci_dev_id(dev))
@@ -1174,8 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 
 	/*
 	 * When either
-	 *      1) bus ID is equal to 0. Some ports might lose the bus
-	 *              ID of error source id;
+	 *      1) Error Source ID register is invalid;
 	 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
@@ -1231,7 +1246,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
  * Return: true if found.
  *
  * Invoked by DPC when error is detected at the Root Port.
- * Caller of this function must set id, severity, and multi_error_valid of
+ * Callers must set id, id_valid, severity, and multi_error_valid fields of
  * struct aer_err_info pointed by @e_info properly.  This function must fill
  * e_info->error_dev_num and e_info->dev[], based on the given information.
  */
@@ -1566,6 +1581,8 @@ static void aer_isr_one_error_type(struct pci_dev *root,
 {
 	bool found;
 
+	info->id_valid = source_id_valid(root, info->id);
+
 	found = find_source_device(root, info);
 
 	/*
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index 2bf6d9d549ba..88070ef0019c 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -21,6 +21,20 @@ struct walk_rcec_data {
 	void *user_data;
 };
 
+bool pci_rcec_associated(struct pci_dev *rcec, u16 id)
+{
+	if (!rcec->rcec_ea)
+		return false;
+
+	if (rcec->bus->number == PCI_BUS_NUM(id)) {
+		unsigned long bitmap = rcec->rcec_ea->bitmap;
+		return test_bit(PCI_SLOT(id), &bitmap);
+	}
+
+	return rcec->rcec_ea->nextbusn <= PCI_BUS_NUM(id) &&
+	       PCI_BUS_NUM(id) <= rcec->rcec_ea->lastbusn;
+}
+
 static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
 {
 	unsigned long bitmap = rcec->rcec_ea->bitmap;
-- 
2.53.0


