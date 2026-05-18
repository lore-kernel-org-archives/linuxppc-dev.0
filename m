Return-Path: <linuxppc-dev+bounces-21116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB93CD4F50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 13:36:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJzN220hqz2xpn;
	Mon, 18 May 2026 23:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::129" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779110636;
	cv=pass; b=ZEkL7nGSQmL/KHfnlRW1J+OPXV0McCGuH/80i4wyEGo8p7dr7bjt5vuipJt/8wxVriuBWq5gc8zz31p00EmLC8LfLFKL+CfvVzefbolKjTpkRrJkxs2GRxqFCSjbNMKB6Z2GXjGRbelgB6EgiPHhTLcKeaCWJ6a5Rsl0JxGve9dfheEbsw8ulTDYLwiTojg2TfWZqU6s6uCiAoDLA/4ut1yPEk5fZjZtQxmGIGdn78gcV32DjXSIvtVVpiMayKZPEdQcew1IcIPqLq3b/iURZ3RdRvnuX1XcQ92dRynqBCfvIVOqJrLkD2oi4IbZSiPsYeoMoWXgex1WU+2pVbl1/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779110636; c=relaxed/relaxed;
	bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nMPvwtWyRDzAV7ZlYZNDr+fGGmZh3TC9IgE4bwZVjTuhhYkCLJtD9P0owz1skGonlo1Ej0QZoN1nWywZwfwYm/GHma4wEWPpp/DgSXYVK5lQ9xDggPNoAi5tRt0q+bM2tmrXd47mPLH+1O3lZItyTMjkOe4YIXVJPjpRX/TIiEIipFBocQp01b4oerfiXWIFAGh62gylai/7qeA6d3cPIE8xEoug8T2ofAOZxJE5AUWHxWWWQbTaQP8+rzytVfgFmU+tBSWoMMrsA3MxzdzVceJ9FFsQ1UT+P9AuKpwP3GbwJMaKGW9yIug5eTVSVOLN2ONSzrWjQOuP0dO7XamjOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=KPTDlK3W; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=KPTDlK3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJz623gT8z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 23:23:53 +1000 (AEST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5aa0862dda1so3151424e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 06:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779110629; cv=none;
        d=google.com; s=arc-20240605;
        b=IW18f1dUPu1+cpx9VUhiKq5WhohrkQxpycMh5W6Xr6hFo9jYo/q7sjrKMvhvv7fFmZ
         64LOHWvnwOZ9s+l3FXFcYVKtG1IrQlf/bSPmEiyGW0RCaW2RnHgjzX119BButdEssnqd
         oeFw/8O6b+3itNHIhQeF6Cozf6ChSLNArwS9Sx8lraAldje8ybtvBWFKUza7pPBrC/Iv
         9eBx1lwiCb6ULCuh6GmKhi9iyvdRAp440TpzHdIbSjuOTjC66CgmkByPtRDXGzlSxMRM
         UpEZqX4TLnk/UWRWbix6FbXyf5LrGh910HggifrzsWGH1rwfYM48x2SD6h1yKCpiNLxL
         FGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        fh=1kpuUahpmykm26QLCanRNMduj4/vTw0Kzq8C/Y/DmlE=;
        b=b5F4HA0vcv82Kzdg88bxBmpmx9i2iM8s47JCyDocoilqgyJiexAap5ruVkJv2NnI/C
         YQoH6JLc09AvPrYJwqC/CjsP1kkp4ZDT4/D7qLTPWbzGGGXc9CKeGJpOoITmPYq3MpdX
         5WNFtDEdOLJdPC692irbiEYsWSXxzZB2l+Wheiv8H/mdzhUR84UwdUxMmaSxfJ//dzlA
         5vUXcUfDFhG2fvqf4U7dDVyY16bPlO7aDCupQ30TZUlUkeYC5GvBjoTfky1Oq+5ugzL8
         XXE1ikZUz2KZOvVfC8yucjQRDvj+51CkpZkAgj6+D1g7c1x2CSw8DWGpQtRhENChi+yT
         Bkug==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779110629; x=1779715429; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        b=KPTDlK3WILn72PWSS3WprbsL3DMzAWziaVtXkQuQcIwk5De4rnylQVCuM/xEGmoyng
         CZjUTa8HBgHGK3w3EhYkOq2FC0GSxsJFDqa8IpQ6JQ1sIiXrcJs5CNQq2BFmLHnjWL2K
         /JEPsL52xw8yZ006c7af6QMJ3mC5glwGpN5MJviPSdYG6sjGp98F5wa0FANif8iAotIo
         Z45uUL0+08zKz532wyOBV9SQLXw5fJ6KtE77SHy6b66MyJetx4OQ7e3+HnI+TIAnPzsE
         yM+zK64XQ76n/DUZZBIrQndIm4elc6QAXKwRBDI5qBJWOjiVRrj1vu2WR8PT9zJHlLTB
         o/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110629; x=1779715429;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqfmEHThWndcoL8uij8sV8NK0VPjWDK3IFq607zTzh4=;
        b=Zdi7pj2R4pq2GNCE2LaJsf8Oj7qC/PYxYoZ86gVs6pkYQyf+VXdCnAU6WGJcpsafsZ
         XNtGYOz7rqPB0Y1wrYnXmdQpgjOApaP5duX7Du3bwoXmnqwVOMxnKRgAT5wnS6ZSmYsW
         9eGIBJ+Dk3W4qek7GpDlW8l26oYYnn2B3SpRqxQQI6mEUOR2Ew4hzzUzdsxvnx1x9mst
         wrk4/fiFkXHi1nc1gfY3dWWBZiYuegdSFgnAbdTbKxg01l1ktHYEXbsZBoOkUUWiYWNI
         OuU9Q9t79HGd0+WSmOzo/HymS8nGfi0qLhGh0f3E/4EPMtK8dvAkIpYyGt9r3APV5gV0
         zszA==
X-Forwarded-Encrypted: i=1; AFNElJ9EMIpPzrMBFQJQ5UsiVzy6PyCm0UqGqHsDTqXwoGtD3Oo3OIuxPBwsimce0jMgzILmRInTTrbEy6Wq3ik=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCLrNM3OTrKJCwPS9qjfv2jGqAQ5IMJmLpwTrI1ZJ8WaZS7NdE
	ENu94Mf64VwiU4cSwMqV6pcUa7xtoYs8ilynMzfqhL/EukgBPR8MTtKr/85jIJhRXjhfF7G4xMt
	lQOy23UnxqZklXxuTA8qX66QPbQoV/dJlnof6JmF2
X-Gm-Gg: Acq92OHDyEkP8w5wwkaywjPPzEqIXWIRwkPks1bW4vvmE0gZzh9bx2S5lE+Z7jy82Kp
	/JDg2ckf4WGbNuetBBkMlFS4GmB3li1RvI8TsJt4WWAbqJpNwBToMI4jYbUv+vYQcbnhVamT5Vj
	VWSw/mWTq2PdUSyJwnhTwEjrCO04BdvSaCboljK10kH+8fyOdCpijTCTdMDbVdox9nb5gtrT9W8
	MZFcPD3933WAEd8hh3Nl3oAdsqFeInZ/RGz+oi/fdgJ8dOCo4TBqy9LhcjlU0edYIJbm3SDapRA
	UdmvXCywy2IPsCYKwes=
X-Received: by 2002:a05:6512:3d04:b0:5a2:b8cf:39ce with SMTP id
 2adb3069b0e04-5aa0e7428damr4225351e87.10.1779110628885; Mon, 18 May 2026
 06:23:48 -0700 (PDT)
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
MIME-Version: 1.0
From: Yury Murashka <yurypm@arista.com>
Date: Mon, 18 May 2026 14:23:36 +0100
X-Gm-Features: AVHnY4JOrJy53gmu77kAh1twBosgSM7U8IAMkHT73ISMbEifpQmD_iNo2Y-2TdY
Message-ID: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
Subject: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: bhelgaas@google.com, mahesh@linux.ibm.com
Cc: oohall@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Yury Murashka <yurypm@arista.com>
Content-Type: text/plain; charset="UTF-8"

pci_aer_clear_nonfatal_status() is not called when AER recovery fails.
If a new AER error is subsequently reported, the AER driver calls
find_source_device() to find the source of the error. It rescans the
whole bus and picks the first device reporting an AER error. Because the
previous error was never cleared, the error is attributed to the wrong
device and AER recovery is started for the wrong device.

Add a kernel boot parameter pci=aer_clear_on_recovery_failure to clear
AER error status even when recovery fails, preventing stale errors from
causing incorrect device identification on subsequent AER events.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/err.c                          | 13 +++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb..5a9e266f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5301,6 +5301,11 @@ Kernel parameters
                nomio           [S390] Do not use MIO instructions.
                norid           [S390] ignore the RID field and force use of
                                one PCI domain per PCI function
+               aer_clear_on_recovery_failure
+                               [PCIE] If the PCIEAER kernel config parameter is
+                               enabled, this kernel boot option can be used to
+                               enable AER errors cleanup even if error recovery
+                               failed.
                notph           [PCIE] If the PCIE_TPH kernel config parameter
                                is enabled, this kernel boot option can be used
                                to disable PCIe TLP Processing Hints support
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651..701459c62 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6769,6 +6769,8 @@ static int __init pci_setup(char *str)
                                disable_acs_redir_param = str + 18;
                        } else if (!strncmp(str, "config_acs=", 11)) {
                                config_acs_param = str + 11;
+                       } else if (!strncmp(str,
"aer_clear_on_recovery_failure", 29)) {
+                               pci_enable_aer_clear_on_recovery_failure();
                        } else {
                                pr_err("PCI: Unknown option `%s'\n", str);
                        }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e5..093a7c896 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1292,6 +1292,7 @@ int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
+void pci_enable_aer_clear_on_recovery_failure(void);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
@@ -1301,6 +1302,7 @@ static inline int pci_aer_clear_status(struct
pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) {
return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
 static inline void pci_restore_aer_state(struct pci_dev *dev) { }
+static inline void pci_enable_aer_clear_on_recovery_failure(void) { }
 #endif

 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc11..29d655a34 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -21,6 +21,13 @@
 #include "portdrv.h"
 #include "../pci.h"

+static int enable_aer_clear_on_recovery_failure;
+
+void pci_enable_aer_clear_on_recovery_failure(void)
+{
+       enable_aer_clear_on_recovery_failure = 1;
+}
+
 static pci_ers_result_t merge_result(enum pci_ers_result orig,
                                  enum pci_ers_result new)
 {
@@ -289,6 +296,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
        return status;

 failed:
+       if (enable_aer_clear_on_recovery_failure &&
+           (host->native_aer || pcie_ports_native)) {
+               pcie_clear_device_status(dev);
+               pci_aer_clear_nonfatal_status(dev);
+       }
+
        pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);

        pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
--
2.51.0

