Return-Path: <linuxppc-dev+bounces-18921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1783910ED64F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 10:06:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhxBn51tXz2yjp;
	Fri, 27 Mar 2026 21:06:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774606017;
	cv=none; b=k6+qQMBjyd4S/i/JYghbDsClKgqEEEgGsJOUXWdkO14qQw3UgnYlgH5/SIhIzdDLPHiRYyYholflzMzh7BcGvEcIx+HOx7YM6beyTS4hgaz5dJUPsjD4AznYtpJ15AcDLaBCg9VpC+YcioK6zC2YrgwsKVp0oHcx8uXrlW/etmsAbZjk1wjfcx0tpSEDPNS1a7YL3BEThvjJDgPQ3DWb6wGARmm8CPM7LUYRLKeuXvdH2BAQ1bWpdSWQmFreP4pM1fUpkIcqmU5X0vWgwI5hORHIHt3bGDpa2SUHadAWNXkFhRL0YQsPG2ydyL1ViwrOxUTfnoCl4RG2hG8uNMsi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774606017; c=relaxed/relaxed;
	bh=AmXjMga8xYMmoEJQoej3DEiSR5iIJ7Y35Lu6qiFw1sQ=;
	h=Message-Id:From:Date:Subject:To:Cc; b=CLmNo/rjUiT+ATe29reGuMGorKMgs7Yxkbp5Jmm5maYqfh2blzd7VLjFRdIc3W7bvzVthzQuTaVi0XItVCAuhK8zI6d/l2sXZm8gvPigOcpt6TyOKpI/ehpWBiMoOQm2LHVZiZMi44hhMyPV/S6Bt94GsCCmzUqTPmM+QjIR5yPYhcvrDb2GDtsU7kua7T7h9ahIjfb3uXlsv7gCRhlcAQ5eV28tkiknKH9+RJjbWc7OpL6xQw3pKdV3HfdNetKrnhjJdTiU54TWas7ssnKyO+8SxgaYCHBCnlBsDIQdE2YR0yhi8K5xuntI52bkRyGuxuvD5KqGA2ujxE+yo4B5WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.95.204; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 606 seconds by postgrey-1.37 at boromir; Fri, 27 Mar 2026 21:06:56 AEDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhxBm41pqz2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 21:06:56 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6C77538B4;
	Fri, 27 Mar 2026 10:56:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 65B2D6024CB9; Fri, 27 Mar 2026 10:56:42 +0100 (CET)
Message-Id: <734338c2e8b669db5a5a3b45d34131b55ffebfca.1774605029.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 27 Mar 2026 10:56:43 +0100
Subject: [PATCH] PCI/AER: Stop ruling out unbound devices as error source
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Stefan Roese <sr@denx.de>
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

When searching for the error source, the AER driver rules out devices
whose enable_cnt is zero.  This was introduced in 2009 by commit
28eb27cf0839 ("PCI AER: support invalid error source IDs") without
providing a rationale.

Drivers typically call pci_enable_device() on probe, hence the enable_cnt
check essentially filters out unbound devices.  At the time of the commit,
drivers had to opt in to AER by calling pci_enable_pcie_error_reporting()
and so any AER-enabled device could be assumed to be bound to a driver.
The check thus made sense because it allowed skipping config space
accesses to devices which were known not to be the error source.

But since 2022, AER is universally enabled on all devices when they are
enumerated, cf. commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
AER is native").

Errors may very well be reported by unbound devices, e.g. due to link
instability.  By ruling them out as error source, errors reported by them
are neither logged nor cleared.  When they do get bound and another error
occurs, the earlier error is reported together with the new error, which
may confuse users.  Stop doing so.

Fixes: f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.0+
---
 drivers/pci/pcie/aer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4299c55..384d026 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1039,8 +1039,6 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	 *      3) There are multiple errors and prior ID comparing fails;
 	 * We check AER status registers to find possible reporter.
 	 */
-	if (atomic_read(&dev->enable_cnt) == 0)
-		return false;
 
 	/* Check if AER is enabled */
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &reg16);
-- 
2.51.0


