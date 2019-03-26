Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A302FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:28:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C53020823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1vxrjEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C53020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TJ5610T7zDqMt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 04:28:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1vxrjEi"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44THzh4kwNzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 04:23:57 +1100 (AEDT)
Received: by mail-oi1-x243.google.com with SMTP id v84so10586603oif.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GrNTWMSdwdmcCzwUphihcH8fY2Na1YarPGgraT4osj0=;
 b=N1vxrjEiksjfKwhhbLGIKcnVB7hA/pL2dejCO4eRxTkhqc+6aZPNVtsWZ8VkDE+f8Z
 8h+qQg42haGOMWQ7B6RPUp39RspKwE1Fhow1TUTobcwQpPLqTb5gGjrxcCk/f3RMEWsd
 HN5tSi2AMHy5WuuP3zceCIYOn4EvdTRZKfA3a1tEOjmDAOfV/3eaVjdMXOrJJigHiVHp
 83bVxq0jADf3EGDbptLvgzkNQH0f8QcETOSitL9rsSD7PtGbjFiOKpkB+jIZK+L3YDce
 sV66gKVcKlPdiIsC3UYI0UiPGr4GcNE52G6Si+MCmPQT6rjvqFvXwRJ96gKHZN65M2BA
 1/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GrNTWMSdwdmcCzwUphihcH8fY2Na1YarPGgraT4osj0=;
 b=P66mp1j5dlUIg9eLSOU3S8XuIhrzv2NCX6RjW9uW0hO8YBiyyl82KLZSc9N9jFVCxb
 alUEE9eoCYxVsO7TECycBPBROoVxOJD1d1ySd/NdoNHFuMCJHiW2cBvC8tyZz01aSXEk
 4KlDjvozWR92F81P3aOshTn8hVeP/sCm2Nem1Ptfhk9jE2Kap1Q9kkW9BFdajjjFg+/H
 j3hmWWEBl8mPa8csHpIVgzeg40cQh6/G1YFHuJPJ6RdKCF4MK841eVpHC3qLXtbqSaA/
 5W/vyocYb/IbgHYK9YrLSlmlt1xkjXJfWIU62tzzNBQNAa/xnHn+YdrqeAGEp97lH3hs
 pgtA==
X-Gm-Message-State: APjAAAUpH+J5AvOtC9Yn5LflW0uWRwB2P0m71r65J4p413bPwrV3hA01
 /OW6ZlhmgjsX9t+UflCXdOI=
X-Google-Smtp-Source: APXvYqy1JxySdfPsTJRq7F+l/hXsj2wyaKmNfwvpuYQeZO36NckQmkeLRixW0McUEdg75shDev3B0w==
X-Received: by 2002:aca:a84a:: with SMTP id r71mr16744805oie.56.1553621034688; 
 Tue, 26 Mar 2019 10:23:54 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id z12sm3047459otp.2.2019.03.26.10.23.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Mar 2019 10:23:54 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: bhelgaas@google.com
Subject: [PATCH v2 1/2] PCI/AER: Do not use APEI/HEST to disable AER services
 globally
Date: Tue, 26 Mar 2019 12:23:41 -0500
Message-Id: <20190326172343.28946-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190326172343.28946-1-mr.nuke.me@gmail.com>
References: <20190326172343.28946-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alex_gagniuc@dellteam.com, Sam Bobroff <sbobroff@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shyam_Iyer@Dell.com, okaya@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, keith.busch@intel.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de, leo.duran@amd.com,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, scott.faasse@hpe.com,
 Oliver O'Halloran <oohall@gmail.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As part of the ACPI Platform Error Interfaces (APEI), the HEST table
describes the meaning of errors sources. Although HEST is related to
ownership of AER, the gatekeeper for AER ownership is the _OSC method.

HEST can identify error sources as firmware-first with granularity
ranging from device-level to global. It's not uncommon for HEST to
say "all AER errors sent via of APEI are firmware-first" by setting
the firmware-first and global bits. It's still allowable to do this
and grant the OS AER control over part of the PCIe topology.

Because there is quite some flexibility in how HEST and _OSC can
interact, it is wrong to assume that global firmware-first implies
_OSC will never grant AER control. If we don't ask for control, we are
not going to get it, and we may have entire parts of the PCIe tree
that do not report errors. Thus, ask for AER ownership, regardless of
HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/pci_root.c  |  9 ++-------
 drivers/pci/pcie/aer.c   | 25 +------------------------
 include/linux/pci-acpi.h |  6 ------
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..32b2053bb0fa 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -491,13 +491,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f8fc2114ad39..d029979e61f6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -313,29 +313,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	return dev->__aer_firmware_first;
 }
 
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (pcie_ports_native)
-		return false;
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
 #endif
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
@@ -1450,7 +1427,7 @@ static struct pcie_port_service_driver aerdriver = {
  */
 int __init pcie_aer_init(void)
 {
-	if (!pci_aer_available() || aer_acpi_firmware_first())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..2e9c0b973eba 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -116,10 +116,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
-#ifdef CONFIG_ACPI_APEI
-extern bool aer_acpi_firmware_first(void);
-#else
-static inline bool aer_acpi_firmware_first(void) { return false; }
-#endif
-
 #endif	/* _PCI_ACPI_H_ */
-- 
2.19.2

