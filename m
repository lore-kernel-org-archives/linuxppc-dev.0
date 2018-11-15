Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ECC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:28:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E5620869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJd4WjRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E5620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wyGn6BWgzF3Nn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 10:28:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJd4WjRr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJd4WjRr"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wy0j52cDzF3gY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 10:16:21 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id g27so19655002oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0/zlQteT7Eb+WVjd5aUv8zmL6TUh4WrZMBcM1VmM60w=;
 b=RJd4WjRrMh+I3fogDnQnkEar5Mze93Z9Lnb32BCllXD4QjvTA0UEeAiidrUwivLnkn
 Zy/jNIr4E7xK4+d5YunPO0SLw5nz1ms8tF1F4vtVwUjUdFpX+mZwzbr69vM6g5Irx9fF
 oEcYj2+jBiQDx1nqXa+N0Ub37260OCLxo/2uV61XakP5nD4ffB4PHW0EaB4uhSNDvDOE
 Nd5qcppdMBDhjG9Fwr+Lhp9IWUadb5LCndSrYruFqZwq+K9cioIutFKELf1ycYZdMGdI
 O3uN65WmZ9rKbWXm41TjcLij/8yTtzOf1h++geWO6jvOru1cSUHB3rWEMogRsXIAl94e
 ck3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0/zlQteT7Eb+WVjd5aUv8zmL6TUh4WrZMBcM1VmM60w=;
 b=r3u9LtJ8DG47nhDlx6cjzzA5BsXCSn3SFrf8KpHiHozgUx1hg/RxQdu4hGlseLlBD2
 NyQ42FPcH67xaG9c+KEriNWV4pC6N6R8U6vvgooCtgSkR6Oh+dZE4OCtK0wAdEh65Uby
 NPNPvk4oi/txuaYM0rkkW2Cyq91xry2YNWh+nxkZO9Sz60OjyyKPE+NbpXCCEHyxCoyx
 6JWcz2qhxnJk8aIobcED13FfZqU01hRLwiIbxtxF8vjvK6qPMBnZqLHBVJHhvsVQHn5b
 A3qqU2Gb+hLjDydjkcPdiGQS5yvlqwpDuxbO1+ObIDJfTt9sk14yUM9qWFxVf25Ae4No
 QucQ==
X-Gm-Message-State: AGRZ1gKMsjXA2nD9VNnux3dFYWPaD7ZZUu6dpEQliX3WhpcwiURYAhH3
 PxerXik15fWGjX1YYuiDpyA=
X-Google-Smtp-Source: AJdET5cXWr6Qmr40kj0P21sABhxXuWQiugOA6lCkMgOojEvFft0MixSoyluh6J5y5WMoO5U1IIzehQ==
X-Received: by 2002:a9d:41ca:: with SMTP id v10mr5271965oti.101.1542323779488; 
 Thu, 15 Nov 2018 15:16:19 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 15 Nov 2018 15:16:19 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: helgaas@google.com
Subject: [PATCH 1/2] PCI/AER: Do not use APEI/HEST to disable AER services
 globally
Date: Thu, 15 Nov 2018 17:16:02 -0600
Message-Id: <20181115231605.24352-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
X-Mailman-Approved-At: Fri, 16 Nov 2018 10:26:13 +1100
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
 linux-pci@vger.kernel.org, Shyam_Iyer@Dell.com,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 keith.busch@intel.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 Oliver O'Halloran <oohall@gmail.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, Len Brown <lenb@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI). HEST is tightly coupled to ownership
of AER, however the correct way to determine AER ownership is the _OSC
method.

_OSC is negotiated per root bus. It's possible to have one HEST
descriptor for all root busses where AER is owned by firmware, and
still have root busses that are not firmware-first. In that case we
would incorrectly disable AER services globally.

Instead of using HEST in making the determination, always request AER
control via _OSC, and only disable AER when firmware denies control.

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
index a90a9194ac4a..ac014151b7a6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -316,29 +316,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
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
@@ -1453,7 +1430,7 @@ static struct pcie_port_service_driver aerdriver = {
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
2.17.1

