Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B6606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:35:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jb4wx72XCz2y2h;
	Fri, 27 Nov 2026 05:35:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795718129;
	cv=none; b=XX/hf8EgPdEX/3ucNAMk2UyYch+HUvsgaqGQ5+iQiObTWeUHAuez2Rr1iYW/Qy8iZB/yvleaAQnG+Klp808/YsTIsSHJFAWMOR3nbk8T24t57Fx5IAupWEQAfGeBFgBcZQ2u3OP3oY7wIDSAq5sJZbekn90pqC1O+tn6D+pgIh1jqg8ehcPpEUFnLpbdCkHTFk3RL/ECpk/x3WTsf3++NqzuAarD9KG2FGGg/hObC3wLzIfAiT2oewW2LcYkwm2GvfL4rHmbYONnK0sIwUMgYnEgkBQ8IbLCGzf7FhN2TOQMdcTIAZNroIC5R6li7Gn35/fOLNtl4iPbnBDpYME+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795718129; c=relaxed/relaxed;
	bh=T8gL3R5Of4fh7/JSzNbmIkuPBYVFqpMyrpx8pK3ARFw=;
	h=Message-Id:From:Date:Subject:To:Cc; b=DYvm11btvOuD0LwhX6l4+26vdJRXF67gtnA5EF02Xvo2yZ02VRhIW0WsukIMKvv8jSFIvF/7vaVl4GMsehaN8jBThAUNX+5IqK/G9e20PCr6F03DQnui5yauBMBKnupwRfq0Mn9VoeNwQq8gOVrBT/OMrp7P6wSgPY4nO+ZfbrIsJjFvS1M5gKly/HlYib8GV7apR1CeL79yfldjSM9uvVF4pjThqSZmCKrsonverQKU03YVIn0yqCbb/3CorsL1PmPeIVVurDPz6qlZGRcOpvHAwalnqRRnlvMRJ4u1pHSemEp7cg6a9U9pI04UshKHYoqsG3m/F4Jsrn8u2mJbjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb4ww43Kqz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 05:35:26 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 1DEE4DAA;
	Thu, 26 Nov 2026 19:35:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D77516028ECD; Thu, 26 Nov 2026 19:35:20 +0100 (CET)
Message-Id: <1ddc35c51b5317988bbf235c467a9534218c6ea4.1795717157.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 26 Nov 2026 19:35:00 +0100
Subject: [PATCH] PCI/AER: Check error status registers if Error Source ID is
 zero
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Yazen Ghannam <yazen.ghannam@amd.com>
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

Since commit 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID
register"), the AER driver checks whether the Error Source ID register
contains either the ID of the Root Port (or RCEC) itself, or of a device
subordinate to the Root Port (or associated with the RCEC).

If this check succeeds, the Error Source ID register is assumed to contain
a valid value and is not double-checked by reading error status registers.

However per PCIe r7.1 sec 2.2.9.1, devices may send Completions with a
zero Completer ID "prior to the initial device Configuration Write
Request".  Similarly, CXL r4.0 sec 8.1.5.1 states that a Component may
generate a CREDIT_RTN IP2PM message with a zero bus number after reset,
which can fail ACS Source Validation and trigger an ACS Violation Error.

On ARM platforms, there is often a Root Port at address 0000:00:00.0,
which makes it impossible to discern whether a zero Error Source ID refers
to the Root Port or to an uninitialized device downstream.

For this reason, always double-check error status registers if the Error
Source ID is zero.

Fixes: 6d69eeae8966 ("PCI/AER: Check validity of Error Source ID register")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
base-commit: 6d69eeae8966bc3bea0facbd550f45ef9de41cc4
 
This fixes a commit queued on pci/aer.  It can either be folded into
that commit or applied on top of pci/aer, whichever is preferred.
 
 drivers/pci/pcie/aer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 1973b6e..24b014b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1158,6 +1158,10 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 
 static bool source_id_valid(struct pci_dev *root, u16 id)
 {
+	/* ID is zero prior to initial device config (PCIe r7.1 sec 2.2.9.1) */
+	if (id == 0)
+		return true;
+
 	/* The Root Port or RCEC can itself be a valid Error Source */
 	if (pci_dev_id(root) == id)
 		return true;
@@ -1186,7 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	u16 reg16;
 
 	/* Some Root Ports report an invalid Error Source ID */
-	if (e_info->id_valid &&
+	if (e_info->id && e_info->id_valid &&
 	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
 		/* Device ID match? */
 		if (e_info->id == pci_dev_id(dev))
-- 
2.53.0


