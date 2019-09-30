Return-Path: <SRS0=cA15=XZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D165C4360C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 02:15:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A4B2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 02:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSdLpYVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A4B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46hQwF5vcCzDqNQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Sep 2019 12:15:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uSdLpYVJ"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46hQnP02JgzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2019 12:09:12 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id f19so3282523plr.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2019 19:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GpdB7/NTd3wtvGApi+SbwzoSWGyyJYFNhOXdPw30ujU=;
 b=uSdLpYVJI6agqhIuFFc4HJVODoORgxFLSHEYcs3h5PWTlzvNM38KyCuA3zuniy92Gm
 0S1yVfu+E3c3jS9CSgQboR+fQEObkxkoQDodLfnczAQVKswxCqEdc84kLOjJb7Y+4gTT
 hUx2CFIW1GT7FuQZ4bEO+FwWOjlmRvMvy30OEfxtP83zMi5J92mIsTcaT8Yg0iAxDc18
 vn7icu7d2alBoSA6xCNEHb+AIOP84KwDeZvnwDByYGITxVyVgUdSN4sOr3NW+9NdjrvI
 ZoCOp6vVtARf+jf7Df3HZFQ6hfSAgnhCimUws6ZDXA6SkVY/MIaNe0N2kstXVNdxClhv
 ORSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GpdB7/NTd3wtvGApi+SbwzoSWGyyJYFNhOXdPw30ujU=;
 b=Ktr3oIok0oRdO9dbh8HlcyqP4fVZALbVEs+lh8s4OqMUSHTCm0T0qMdkbm0LVgQHoG
 PfeCADQn4UxCCcetqTIkMLcUY9rlLWkJn90ygAxdU1phP5TsLasTIhwbJkWH4BP49F2+
 32J2rt0oWG4fWGv4/OTmRvotItoEZFZxZVT5RNGeRFpXsrkNFrERLmzY/kyWYAR/jMLm
 /+3JZZOJVur8hbJQWKaQzmP/ZqsXzqsSqrqGCeBkJU4DwBPYxOT72c7LCXiM6Y4KjgHI
 elenGFpLYyFP16pNnKiRhByemfhCwyVemCpcBTGPCoJ4otqibFLLMfoLAsrsDHj+KOBy
 6fVQ==
X-Gm-Message-State: APjAAAWgHv/yqPz80ewlY8D2H0dpdlZYqoiTOdvkbNXb4VZIgH45IC3L
 d4863ZrI2r6L+oYVR73ekLnfkeVy
X-Google-Smtp-Source: APXvYqzkHaoeDmSN7IhITXbXlspuHGKFl8/ESO8gCTP8d/M8lRKpa0zl41o5kYYshR3e5JSieRd/sA==
X-Received: by 2002:a17:902:bcc4:: with SMTP id
 o4mr16891124pls.142.1569809350280; 
 Sun, 29 Sep 2019 19:09:10 -0700 (PDT)
Received: from wafer.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id x72sm11450733pfc.89.2019.09.29.19.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2019 19:09:09 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/pci: Remove pcibios_setup_bus_devices()
Date: Mon, 30 Sep 2019 12:08:48 +1000
Message-Id: <20190930020848.25767-4-oohall@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930020848.25767-1-oohall@gmail.com>
References: <20190930020848.25767-1-oohall@gmail.com>
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
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org,
 Oliver O'Halloran <oohall@gmail.com>, shawn@anastas.io
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With the previous patch applied pcibios_setup_device() will always be run
when pcibios_bus_add_device() is called. There are several code paths where
pcibios_setup_bus_device() is still called (the PowerPC specific PCI
hotplug support is one) so with just the previous patch applied the setup
can be run multiple times on a device, once before the device is added
to the bus and once after.

There's no need to run the setup in the early case any more so just
remove it entirely.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/pci.h    |  1 -
 arch/powerpc/kernel/pci-common.c  | 25 -------------------------
 arch/powerpc/kernel/pci-hotplug.c |  1 -
 arch/powerpc/kernel/pci_of_scan.c |  1 -
 4 files changed, 28 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 327567b..63ed7e3 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -113,7 +113,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 pgprot_t prot);
 
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
-extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
 extern void pcibios_setup_phb_io_space(struct pci_controller *hose);
 extern void pcibios_scan_phb(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b89925ed..f8a59d7 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1000,24 +1000,6 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
-void pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus devices %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/* Cardbus can call us to add new devices to a bus, so ignore
-		 * those who are already fully discovered
-		 */
-		if (pci_dev_is_added(dev))
-			continue;
-
-		pcibios_setup_device(dev);
-	}
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
@@ -1036,13 +1018,6 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-void pci_fixup_cardbus(struct pci_bus *bus)
-{
-	/* Now fixup devices on that bus */
-	pcibios_setup_bus_devices(bus);
-}
-
-
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index fc62c4b..d6a67f8 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -134,7 +134,6 @@ void pci_hp_add_devices(struct pci_bus *bus)
 		 */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		/*
 		 * Scan bridges that are already configured. We don't touch
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index f91d7e9..c3024f1 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -414,7 +414,6 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 	 */
 	if (!rescan_existing)
 		pcibios_setup_bus_self(bus);
-	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
 	for_each_pci_bridge(dev, bus)
-- 
2.9.5

