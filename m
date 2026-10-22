Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D4606A31F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=JoFP7xbL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9XRp21M1z2yql;
	Fri, 23 Oct 2026 03:59:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792688342;
	cv=none; b=JrdBASx7TUuFHGBcv2V2VSu1ohegwpdwk4TQnwfmWpRQmsInR5Vv3x2vPU7A+qZJ10+TZWfWI2JdG+6jO6Ai6j5FFk0TL7DikO3U4YLo+y3Og7kFasdvECNiiVdSiAQ813rbPpiAPUqPyo+Hf8pZJELj08F4Ez5ihvj7ZngQDOkqfE2BjC2Yi842UL8c4L6hvQu7EohrGnK2oSc9xatovERGe2G45FuIe4i3GaJdpo51zcRENO0Ix3ekEsUKjxClhzS5iTDAN9/reNK3nwjiCLRhTfEK+hk745aOOogfbCCu/J1Yet5eI8q9PjuZ5JKgf91WMXaHxlqblJegsuSwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792688342; c=relaxed/relaxed;
	bh=W7YeOGCoo/KQR6RPp5t3iOKduMWVKWg0EO1FIafOrtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IErEorP3mmsYZWNIwvJRyjC8M7sL9J0CCHi/ys6QrIlf4YM8z0oQU2Kmv5VTv1ThEyWDI6PCyeI+nxRa1/1eXks1WLudLV5XUeKt0dedn3g2jE3+/XqNpmv98V6yPYvdSI62zxI3YQs86pEsYnXLVAKz1ef8gHxr1qJ9g6VsJBcAmp8ICye2W3zBNHK3cGz07aWIF0vaIz0mwO9pDdNeKwGCwj4+uSU0Zslvo6RmPe+SnSDIIhjf/gxemjma1/md08IwSXQU+Wm76MHVmraUVfo6KtxBI9cemTdQ+2ebKdFNtK9IKRxOIDL9msiDzvqISIo4feSrkG4A9Tmh6ba65w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=JoFP7xbL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=JoFP7xbL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9XRn1jMtz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:59:01 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-188406bb948so1191333c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688339; x=1793293139; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7YeOGCoo/KQR6RPp5t3iOKduMWVKWg0EO1FIafOrtU=;
        b=JoFP7xbL97OpVWZuZ36GIl4WwA+x4Ad8vhnmSjYId8Xx3kuH/y1IakoomdvQzXsoRO
         kjQPW2LML78mekvtBxUaYFgDwy8BIFbwFmEI51vPsuG3yT2w4YRkGXTn2Uyp1PiN+b72
         +P64nz0IEadTjNRULoHhL0PQWiQ0llRb62ukBGUiKCvFXa8Vobtd/GC+jAe/lcO6JAaa
         3tgXGpv6p3k9TfB/SyL2tVrWwmOBEbBUrPYUwWBNYPYkbFHXS8bGS/4YDJWy7s12FmoL
         m0cdlaYzxdOmDWRsPb3ZKHpMm514LHtbxm19Y5/pJbleObK4tuF4GSJYQf0mWMU91lnR
         Mj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688339; x=1793293139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7YeOGCoo/KQR6RPp5t3iOKduMWVKWg0EO1FIafOrtU=;
        b=I7Y2fAljPPp4d3Bia1DRW/KowRNQ1ZRFjByKgrQsslxtOPUDXJF0bXSRMw+mROCQLK
         PfwenvSv+DV+QLajlviIzheBBDBjTcnvwoBpbXeXHQt46j2TXr9aB0qOgLL3EMUTgSZP
         qwcxlzrGNNVj3c5sQtSsDWWrd3YRcQPwqbPqLydEMEqD9rPaPeVueHWZx+vqTtRcL1ad
         Lsyr5oExoDEg/qkknM13ZNW9nomu3qKMKd1LiO14mYYkzVgUfC1BSmK6X354PFlgCQ9a
         J3/9WH378h5XIW7kJK+qcews63G97hxq7qC1pQOL0ru7m8dY1cy5HNp++M0j/7FPUjMM
         9hog==
X-Forwarded-Encrypted: i=1; AKwUvBwggoa/kutkvODqaFtE06P+M5gMmHKS4BuEhCgW1aByQTGKyRFIsNb5pfGVx3+VFlvTlTpawEeq5XhzhKA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIIMR6OBhyxMbnVHnVDrv6tfzkFuPwDGQKxKRD5F1L5u7PQowkv
	jCSjiM160uMPot/Ta9hvZe5ksUhyuhA2TVb2dQuc3UB7c2D7Dw741iigFR/BlY5X4Q==
X-Gm-Gg: AYBFou2iKfxGKQ2655O/HLArxZTTM7JioCq55O4Y6jFmAAaeMpEfqrT9mOLFG4fCzK0
	gRlZa+tcBggnHMykirFYoKfKrmTlZetmIo25Wx7lFFhcVrJyQWVEGjqtuA1ooTog/WkC12tOSS0
	E6NNwgEMwnhPYMzHYfYYL38C2qfTrZqVwAyU3BhRy27eY2ryrp8CeeDgM4GOpK7cwWRwBT0Z/zf
	nCe0GLE35zpBiga0CCI0BXc7peICApyhlStb2iW1Rwuo/bx5buOcJc3kwFUM6z0BZYBYxwPOSYO
	rbJHOqefZQMzvHeV2BYntU4nLilVcBHqUChug657ZjLSoaPjFfII06MkCsd7xvzzo6zWVjw8f5q
	PixU5Xmocfq9bA9cl4EOk5BiJ3HPnnx+8SR6c0mX0LpWJm06gMNaH1PndvMUjlM69iSDWmfwLWb
	/AuJhn5Xw0XAGLoc8bDvGJ4IQAcnnVRnriFY8FvcC7HVn4nNX/sNh2VGWQkoanzPz8a5GQ5UabM
	TaBr3i3t711xnZMzq4A3wE/QZKVvglkPa0QGP6b0TYaB8dKXkSyVCisZAqCQl59uHoKF+VtLuSe
	RMozq3yItLqMJobfbTAf69EgQyDmppc+1dA=
X-Received: by 2002:a05:7022:618:b0:14c:1f57:3e86 with SMTP id a92af1059eb24-190a7e0c437mr10112891c88.47.1792688338953;
        Thu, 22 Oct 2026 09:58:58 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:58 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/2] PCI: Add pci=nodpc kernel boot option
Date: Thu, 22 Oct 2026 16:58:42 +0000
Message-ID: <20261022165842.1463451-3-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261022165842.1463451-1-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add pci=nodpc to let Linux opt out of Downstream Port Containment (DPC)
and Error Disconnect Recover (EDR) support on systems where userspace
manages PCIe errors.

Skip DPC initialization, state operations, hotplug recovery checks, and
port service registration when disabled. Expose pci_dpc_available() so
ACPI negotiation and PCIe port service discovery honor the same policy.
Do not advertise EDR support or request DPC control through _OSC, and
prevent native-port overrides from reintroducing DPC ownership.

Skip EDR notifier installation before the DPC-enabling _DSM call. Merely
skipping the native DPC driver would allow EDR to enable hardware DPC
while the handler lacks the capability information needed to recover.

The option disables Linux participation in DPC and EDR; it does not turn
off firmware-owned DPC hardware. AER reporting and recovery remain
independent and can be controlled with their own boot options.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
Changes in v3:
- Add pci_dpc_available() and use it for ACPI DPC/EDR negotiation.
- Skip EDR notifier registration and its DPC-enabling _DSM call.
- Gate DPC service discovery and prevent forced native DPC ownership.
- Clarify the firmware boundary and rebase onto PCI next.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-3-yurypm@arista.com/
Review: https://lore.kernel.org/linux-pci/20260709190730.E19A11F000E9@smtp.kernel.org/

 .../admin-guide/kernel-parameters.txt         |  4 ++++
 drivers/acpi/pci_root.c                       |  9 +++++--
 drivers/pci/pci.c                             |  2 ++
 drivers/pci/pci.h                             |  2 ++
 drivers/pci/pcie/dpc.c                        | 24 ++++++++++++++++---
 drivers/pci/pcie/edr.c                        |  5 +++-
 drivers/pci/pcie/portdrv.c                    |  3 ++-
 include/linux/pci.h                           |  6 +++++
 8 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6047efd3c..f98486d4d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5115,6 +5115,10 @@ Kernel parameters
 				through ports 0xC000-0xCFFF).
 				See http://wiki.osdev.org/PCI for more info
 				on the configuration access mechanisms.
+		nodpc		[PCIE] Disable Linux DPC and EDR support. Linux
+				neither requests DPC control from firmware nor
+				enables DPC through EDR. Firmware-owned DPC
+				settings are not changed. Requires CONFIG_PCIE_DPC.
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a1a9c0601..6bca8206c 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -438,7 +438,7 @@ static u32 calculate_support(void)
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
-	if (IS_ENABLED(CONFIG_PCIE_EDR))
+	if (IS_ENABLED(CONFIG_PCIE_EDR) && pci_dpc_available())
 		support |= OSC_PCI_EDR_SUPPORT;
 
 	return support;
@@ -517,7 +517,7 @@ static u32 calculate_control(void)
 	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
 	 * and EDR.
 	 */
-	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+	if (pci_dpc_available() && IS_ENABLED(CONFIG_PCIE_EDR))
 		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
 
 	return control;
@@ -1064,6 +1064,11 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	else if (pcie_ports_dpc_native)
 		override = OSC_PCI_EXPRESS_DPC_CONTROL & ~ctrl;
 
+	if (!pci_dpc_available()) {
+		ctrl &= ~OSC_PCI_EXPRESS_DPC_CONTROL;
+		override &= ~OSC_PCI_EXPRESS_DPC_CONTROL;
+	}
+
 	if (override) {
 		decode_osc_control(root, pcie_ports_native ?
 				   "OS forcing control (\"pcie_ports=native\") of" :
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ca8d3fbb..c2a6aacc5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6838,6 +6838,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
+			} else if (!strcmp(str, "nodpc")) {
+				pci_no_dpc();
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
 			} else if (!strcmp(str, "noaer_recovery")) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ccc6a678c..ae8fc06e5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -934,6 +934,7 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
+void pci_no_dpc(void);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
@@ -942,6 +943,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
+static inline void pci_no_dpc(void) { }
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d..fbafc3ca0 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,12 +43,24 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static bool pcie_dpc_disable;
+
+void pci_no_dpc(void)
+{
+	pcie_dpc_disable = true;
+}
+
+bool pci_dpc_available(void)
+{
+	return !pcie_dpc_disable;
+}
+
 void pci_save_dpc_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (!pci_dpc_available() || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -64,7 +76,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (!pci_dpc_available() || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -104,7 +116,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
 
-	if (!pdev->dpc_cap)
+	if (!pci_dpc_available() || !pdev->dpc_cap)
 		return false;
 
 	/*
@@ -404,6 +416,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 {
 	u16 cap;
 
+	if (!pci_dpc_available())
+		return;
+
 	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	if (!pdev->dpc_cap)
 		return;
@@ -532,5 +547,8 @@ static struct pcie_port_service_driver dpcdriver = {
 
 int __init pcie_dpc_init(void)
 {
+	if (!pci_dpc_available())
+		return 0;
+
 	return pcie_port_service_register(&dpcdriver);
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index e86298dbb..8567dd1d5 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -223,6 +223,9 @@ void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	acpi_status status;
 
+	if (!pci_dpc_available())
+		return;
+
 	if (!adev) {
 		pci_dbg(pdev, "No valid ACPI node, skipping EDR init\n");
 		return;
@@ -246,7 +249,7 @@ void pci_acpi_remove_edr_notifier(struct pci_dev *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
-	if (!adev)
+	if (!pci_dpc_available() || !adev)
 		return;
 
 	acpi_remove_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 32fc623dd..aa1c57e33 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -262,7 +262,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * With dpc-native, allow Linux to use DPC even if it doesn't have
 	 * permission to use AER.
 	 */
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
+	if (pci_dpc_available() &&
+	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
 	    (pcie_ports_dpc_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_DPC;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3e9c6c9c..dd667223b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1984,6 +1984,12 @@ bool pci_aer_available(void);
 static inline bool pci_aer_available(void) { return false; }
 #endif
 
+#ifdef CONFIG_PCIE_DPC
+bool pci_dpc_available(void);
+#else
+static inline bool pci_dpc_available(void) { return false; }
+#endif
+
 bool pci_ats_disabled(void);
 
 #define PCIE_PTM_CONTEXT_UPDATE_AUTO 0
-- 
2.51.0


